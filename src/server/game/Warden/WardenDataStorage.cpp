/*
 * Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Log.h"
#include "Opcodes.h"
#include "ByteBuffer.h"
#include <openssl/md5.h>
#include "World.h"
#include "Player.h"
#include "Util.h"
#include "WardenDataStorage.h"
#include "WardenWin.h"

WardenCheckMgr::WardenCheckMgr()
{
    InternalDataID = 1;
}

WardenCheckMgr::~WardenCheckMgr()
{
    //std::map<uint32, WardenCheck*>::iterator itr1 = CheckStore.begin();
    //for (; itr1 != CheckStore.end(); ++itr1)
    //    delete itr1->second;
    for (uint32 i = 0; i < CheckStore.size(); ++i)
        delete CheckStore[i];

    std::map<uint32, WardenCheckResult*>::iterator itr2 = CheckResultStore.begin();
    for (; itr2 != CheckResultStore.end(); ++itr2)
        delete itr2->second;
}

void WardenCheckMgr::LoadWardenChecks()
{
    LoadWardenCheckResult();
}

void WardenCheckMgr::LoadWardenCheckResult()
{
    // Check if Warden is enabled by config before loading anything
    if (!sWorld->getBoolConfig(CONFIG_BOOL_WARDEN_ENABLED))
    {
        sLog->outString(">> Warden disabled, loading checks skipped.");
        sLog->outString();
        return;
    }

    // For reload case
    for (uint32 i = 0; i < CheckStore.size(); ++i)
        delete CheckStore[i];
    CheckStore.clear();

    for (CheckResultContainer::iterator itr = CheckResultStore.begin(); itr != CheckResultStore.end(); ++itr)
        delete itr->second;
    CheckResultStore.clear();

    QueryResult result = WorldDatabase.Query("SELECT COUNT(*) FROM warden_data_result");

    if (!result)
    {
        sLog->outString(">> Loaded 0 Warden checks. DB table `warden_checks` is empty!");
        sLog->outString();
        return;
    }

    Field* fields = result->Fetch();

    CheckStore.resize(fields[0].GetUInt32() + 1);

    result = WorldDatabase.Query("SELECT `check`, `data`, `result`, `address`, `length`, `str` FROM warden_data_result");

    uint32 count = 0;

    if (!result)
    {
        sLog->outString();
        sLog->outString(">> Loaded %u warden data and results", count);
        return;
    }

    do
    {
        ++count;

        Field *fields = result->Fetch();

        uint8 type = fields[0].GetUInt8();

        uint32 id = GenerateInternalDataID();
        WardenCheck *wd = new WardenCheck();
        wd->Type = type;

        if (type == PAGE_CHECK_A || type == PAGE_CHECK_B || type == DRIVER_CHECK)
        {
            std::string data = fields[1].GetString();
            wd->i.SetHexStr(data.c_str());
            int len = data.size() / 2;
            if (wd->i.GetNumBytes() < len)
            {
                uint8 temp[24];
                memset(temp, 0, len);
                memcpy(temp, wd->i.AsByteArray(), wd->i.GetNumBytes());
                std::reverse(temp, temp + len);
                wd->i.SetBinary((uint8*)temp, len);
            }
        }

        if (type == MEM_CHECK || type == MODULE_CHECK)
            MemCheckIds.push_back(id);

        if (type == MEM_CHECK || type == PAGE_CHECK_A || type == PAGE_CHECK_B || type == PROC_CHECK)
        {
            wd->Address = fields[3].GetUInt32();
            wd->Length = fields[4].GetUInt8();
        }

        // PROC_CHECK support missing
        if (type == MEM_CHECK || type == MPQ_CHECK || type == LUA_STR_CHECK || type == DRIVER_CHECK || type == MODULE_CHECK)
            wd->str = fields[5].GetString();

        CheckStore[id] = wd;

        if (type == MPQ_CHECK || type == MEM_CHECK)
        {
            std::string result = fields[2].GetString();
            WardenCheckResult *wr = new WardenCheckResult();
            wr->res.SetHexStr(result.c_str());
            int len = result.size() / 2;
            if (wr->res.GetNumBytes() < len)
            {
                uint8 *temp = new uint8[len];
                memset(temp, 0, len);
                memcpy(temp, wr->res.AsByteArray(), wr->res.GetNumBytes());
                std::reverse(temp, temp + len);
                wr->res.SetBinary((uint8*)temp, len);
                delete [] temp;
            }
            CheckResultStore[id] = wr;
        }
    } while (result->NextRow());

    sLog->outString();
    sLog->outString(">> Loaded %u warden data and results", count);
}

WardenCheck *WardenCheckMgr::GetWardenDataById(uint32 Id)
{
    if (Id < CheckStore.size())
        return CheckStore[Id];

    return NULL;
}

WardenCheckResult *WardenCheckMgr::GetWardenResultById(uint32 Id)
{
    CheckResultContainer::const_iterator itr = CheckResultStore.find(Id);
    if (itr != CheckResultStore.end())
        return itr->second;
    return NULL;
}
