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

#ifndef _WARDEN_DATA_STORAGE_H
#define _WARDEN_DATA_STORAGE_H

#include <map>
#include "BigNumber.h"

struct WardenCheck
{
    uint8 Type;
    BigNumber i;
    uint32 Address;                                         // PROC_CHECK, MEM_CHECK, PAGE_CHECK
    uint8 Length;                                           // PROC_CHECK, MEM_CHECK, PAGE_CHECK
    std::string str;                                        // LUA, MPQ, DRIVER
};

struct WardenCheckResult
{
    BigNumber res;                                          // MEM_CHECK
};

class WardenCheckMgr
{
        friend class ACE_Singleton<WardenCheckMgr, ACE_Null_Mutex>;

    public:        
        WardenCheckMgr();
        ~WardenCheckMgr();
        uint32 InternalDataID;
        std::vector<uint32> MemCheckIds;

    private:
        // We have a linear key without any gaps, so we use vector for fast access
        typedef std::vector<WardenCheck*> CheckContainer;
        typedef std::map<uint32, WardenCheckResult*> CheckResultContainer;

        CheckContainer CheckStore;
        CheckResultContainer CheckResultStore;

    public:
        inline uint32 GenerateInternalDataID() { return InternalDataID++; }
        WardenCheck *GetWardenDataById(uint32 Id);
        WardenCheckResult *GetWardenResultById(uint32 Id);
        void LoadWardenChecks();

    protected:
        void LoadWardenCheckResult();
};

#define sWardenCheckMgr ACE_Singleton<WardenCheckMgr, ACE_Null_Mutex>::instance()

#endif
