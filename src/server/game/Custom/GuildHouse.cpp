/*
 * Copyright (C) 2009-2010 Trilogy <http://www.wowtrilogy.com/>
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

/**
 *
 * @File : GuildHouse.cpp
 *
 * @Authors : Lazzalf
 *
 * @Date : 31/03/2010
 *
 * @Version : 0.1
 *
 **/

#include "GuildHouse.h"
#include "ObjectMgr.h"
#include "ProgressBar.h"
#include "Guild.h"
#include "ObjectAccessor.h"
#include "MapManager.h"

GuildHouseObject GHobj;

GuildHouseObject::GuildHouseObject()
{
    GH_map.clear();
    GH_AddHouse.clear();
    mGuildGuardID.clear();
}

bool GuildHouseObject::CheckGuildID(uint32 guild_id)
{
    if (!guild_id)
        return false;

    Guild* guild = sObjectMgr.GetGuildById(guild_id);  
    
    if (!guild_id)
    {
        sLog.outError("The guild %u not found", guild_id);
        return false;
    }
    return true;
}

bool GuildHouseObject::CheckGuildHouse(uint32 guild_id)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;
    return true;
}

bool GuildHouseObject::ChangeGuildHouse(uint32 guild_id, uint32 newid)
{
    if (newid == 0) // Vendi
    {        
        GuildHouseMap::iterator itr = GH_map.find(guild_id);
        if (itr == GH_map.end())
            return true;
        QueryResult result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = 0 WHERE `guildId` = %u", guild_id);
        RemoveGuildHouseAdd(itr->second.Id);
        GH_map.erase(guild_id);
    }
    else // Compra
    {
        QueryResult result;
        GuildHouseMap::iterator itr = GH_map.find(guild_id);
        
        result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `map`, `minguildsize`, `price` FROM `guildhouses` WHERE `id` = %u", newid);
        if (!result)
            return false; // Id doesn't valid

        if (!(itr == GH_map.end()))
            ChangeGuildHouse(guild_id, 0); // remove old House        
        
        uint32 id = newid;
        Field *fields = result->Fetch();
        float x = fields[0].GetFloat();
        float y = fields[1].GetFloat();
        float z = fields[2].GetFloat();
        uint32 map = fields[3].GetUInt32();
        uint32 minguildsize = fields[4].GetUInt32();
        uint32 price = fields[5].GetUInt32();

        uint32 add = 1;

        result = CharacterDatabase.PQuery("SELECT `GuildHouse_Add` FROM `gh_guildadd` WHERE `guildId` = %u", guild_id);
        if (result)
        {
            Field *fields = result->Fetch();
            add = fields[0].GetUInt32();
        }
        else
        {
            CharacterDatabase.PQuery("INSERT INTO `gh_guildadd` (`guildId`,`GuildHouse_Add`) VALUES ( %u , 1 )", guild_id);
        }

        GuildHouse NewGH(guild_id, id, x, y, z, map, minguildsize, price, add);
        GH_map[guild_id] = NewGH;

        result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = %u WHERE `id` = %u", guild_id, newid);
        AddGuildHouseAdd(newid, add, guild_id);
    }
    return true;
}

bool GuildHouseObject::GetGuildHouseLocation(uint32 guild_id, float &x, float &y, float &z, float &o, uint32 &map)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;
    x = itr->second.m_X;
    y = itr->second.m_Y;
    z = itr->second.m_Z;
    o = itr->second.m_orient;
    map = itr->second.m_map;
    return true;
}

bool GuildHouseObject::GetGuildHouseMap(uint32 guild_id, uint32 &map)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;
    map = itr->second.m_map;
    return true;
}

uint32 GuildHouseObject::GetGuildHouse_Add(uint32 guild_id)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return 0;
    return itr->second.GuildHouse_Add;
};

bool GuildHouseObject::Add_GuildhouseAdd(uint32 guild_id, uint32 add)
{
    GuildHouseMap::iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;  
    uint32 NewAdd = (uint32(1) << (add-1));
    itr->second.AddGuildHouse_Add(NewAdd);
    return true;
};

bool GuildHouseObject::RemoveGuildHouseAdd(uint32 id)
{
    for (uint32 i = 1; i < NPC_MAX; i++)
    {
        uint32 find = ((id << 16) | i);
        GH_Add::iterator itr = GH_AddHouse.find(find);
        if (itr == GH_AddHouse.end()) 
            continue;
        if (!(itr->second.spawned))  // Non despawnare se � gi� despawnato
                continue;
        gh_Item_Vector::iterator itr2 =  itr->second.AddCre.begin();
        for (; itr2 != itr->second.AddCre.end(); itr2++)
        {
            if (CreatureData const* data = sObjectMgr.GetCreatureData(*itr2))
            {
                sObjectMgr.RemoveCreatureFromGrid(*itr2, data);
                if( Creature* pCreature = sObjectAccessor.GetObjectInWorld(MAKE_NEW_GUID(*itr2, data->id, HIGHGUID_UNIT), (Creature*)NULL))
                    pCreature->AddObjectToRemoveList();
            }
        }
        itr2 =  itr->second.AddGO.begin();
        for (; itr2 != itr->second.AddGO.end(); itr2++)
        {
            if (GameObjectData const* data = sObjectMgr.GetGOData(*itr2))
            { 
                sObjectMgr.RemoveGameobjectFromGrid(*itr2, data);
                if (GameObject* pGameobject = sObjectAccessor.GetObjectInWorld(MAKE_NEW_GUID(*itr2, data->id, HIGHGUID_GAMEOBJECT), (GameObject*)NULL) )
                     pGameobject->AddObjectToRemoveList();
            }
        }               
        itr->second.spawned = false;
    }
    return true;
}

bool GuildHouseObject::AddGuildHouseAdd(uint32 id, uint32 add, uint32 guild)
{
    for (uint8 i = 1; i < NPC_MAX; i++)
    {
        if (((uint32)1 << (i-1)) & add)
        {
            uint32 find = ((id << 16) | i);
            GH_Add::iterator itr = GH_AddHouse.find(find);
            if (itr == GH_AddHouse.end())
                continue;
            if (itr->second.spawned) //Non rispawnare se � gi� spawnato
                continue;
            gh_Item_Vector::iterator itr2 =  itr->second.AddGO.begin();
            for (; itr2 != itr->second.AddGO.end(); itr2++)
            {
                if (GameObjectData const* data = sObjectMgr.GetGOData(*itr2))
                {
                    sObjectMgr.AddGameobjectToGrid(*itr2, data);

                    Map* map = const_cast<Map*>(sMapMgr.CreateBaseMap(data->mapid));

                    if (!map->Instanceable() && map->IsLoaded(data->posX, data->posY))
                    {
                        GameObject* pGameobject = new GameObject;
                        //sLog.outDebug("Spawning gameobject %u", itr2->first);
                        if (!pGameobject->LoadFromDB(*itr2, map))
                            delete pGameobject;
                        else
                        {
                            if (pGameobject->isSpawnedByDefault())
                                map->Add(pGameobject);
                        }
                    }                       
                }
            }
            itr2 =  itr->second.AddCre.begin();
            for (; itr2 != itr->second.AddCre.end(); itr2++)
            {                
                if (CreatureData const* data = sObjectMgr.GetCreatureData(*itr2))
                {
                    sObjectMgr.AddCreatureToGrid(*itr2, data);

                    Map* map = const_cast<Map*>(sMapMgr.CreateBaseMap(data->mapid));
                    
                    if (!map->Instanceable() && map->IsLoaded(data->posX, data->posY))
                    {
                        Creature* pCreature = new Creature;
                        //sLog.outDebug("Spawning creature %u",itr2->first);
                        if (!pCreature->LoadFromDB(*itr2, map))
                            delete pCreature;
                        else
                        {
                            map->Add(pCreature);                        
                            if (((uint32)1 << (i-1)) == NPC_GUARD) //Guard
                                UpdateGuardMap(pCreature->GetGUID(), guild);
                        }
                    }                           
                }
                
            }
            itr->second.spawned = true;
        }
    }
    return true;
}        

void GuildHouseObject::LoadGuildHouse()
{
    GH_map.clear();
    QueryResult result = WorldDatabase.Query("SELECT `id`,`guildId`,`x`,`y`,`z`,`map`,`minguildsize`,`price` FROM guildhouses ORDER BY guildId ASC");

    if (!result)
    {
        barGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outErrorDb(">> Loaded 0 guild house.");
        return;
    }

    barGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 id = fields[0].GetUInt32();
        uint32 guildID = fields[1].GetUInt32();
        float x   = fields[2].GetFloat();
        float y   = fields[3].GetFloat();
        float z   = fields[4].GetFloat();
        uint32 map = fields[5].GetUInt32();
        uint32 min_member = fields[6].GetUInt32();
        uint32 cost = fields[7].GetUInt32();
        uint32 add = 1;

        if(guildID)
        {
            if (!CheckGuildID(guildID))
                continue;

            QueryResult result2 = CharacterDatabase.PQuery("SELECT `GuildHouse_Add` FROM `gh_guildadd` WHERE `guildId` = %u", guildID);
            if (result2)
            {
                Field *fields2 = result2->Fetch();
                add = fields2[0].GetUInt32();
            }

            GuildHouse NewGH(guildID, id, x, y, z, map, min_member, cost, add);
            GH_map[guildID] = NewGH;

            RemoveGuildHouseAdd(id);
            AddGuildHouseAdd(id, add, guildID);
        }
        else
            RemoveGuildHouseAdd(id);
    } while (result->NextRow());

    sLog.outString();
    sLog.outString( ">> Loaded %u GuildHouse", GH_map.size() );
}

void GuildHouseObject::LoadGuildHouseAdd()
{
    GH_AddHouse.clear();
    mGuildGuardID.clear();
    sLog.outString( "Loading Guild House System");
    sLog.outString("");

    QueryResult result = WorldDatabase.Query("SELECT `guid`,`type`,`id`,`add_type` FROM guildhouses_add ORDER BY Id ASC");

    if (!result)
    {
        barGoLink bar(1);

        bar.step();

        sLog.outString("");
        sLog.outErrorDb(">> Loaded 0 GuildHouse Add");
        return;
    }

    barGoLink bar(result->GetRowCount());

    do
    {
        Field *fields = result->Fetch();
        bar.step();

        uint32 guid         = fields[0].GetUInt32();
        uint16 type         = fields[1].GetUInt16();
        uint16 id           = fields[2].GetUInt16();
        uint16 add_type     = fields[3].GetUInt16();

        uint32 find = 0;
        find = ( (uint32)id << 16 ) | (uint32)add_type;
        if (type == CREATURE)
        {
            if (!sObjectMgr.GetCreatureData(guid))                
            {                
                sLog.outString( "Data per Creature Guid %u non esistente", guid );
                continue;
            }
            GH_AddHouse[find].AddCre.push_back(guid);
        }
        else if (type == OBJECT)
        {
            if (!sObjectMgr.GetGOData(guid))
            {                
                sLog.outString( "Data per GameObject Guid %u non esistente", guid );
                continue;
            }
            GH_AddHouse[find].AddGO.push_back(guid);
        }
    } while (result->NextRow());

    sLog.outString();
    sLog.outString( ">> Loaded %u GuildHouse Add", GH_AddHouse.size() );
}

uint32 GuildHouseObject::GetGuildByGuardID(uint64 guid)
{
    GuildGuardID::const_iterator itr = mGuildGuardID.find(guid);
    if (itr == mGuildGuardID.end()) 
        return 0;
    return itr->second;
}

void GuildHouseObject::UpdateGuardMap(uint64 guid, uint32 guild)
{
    GuildGuardID::iterator itr = mGuildGuardID.find(guid);
    if (itr == mGuildGuardID.end()) 
        mGuildGuardID[guid] = guild;
    else
        itr->second = guild;
}

GuildHouse::GuildHouse(uint32 guild_id, uint32 guild_add)
{
    GuildId = guild_id;    
    GuildHouse_Add = guild_add;
    Id = 0;
    m_X = 0;
    m_Y = 0;  
    m_Z = 0;
    m_orient = 0;
    m_map = 0;
    min_member = 0;
    price = 0;
}

GuildHouse::GuildHouse(uint32 newGuildId, uint32 newId, float x, float y, float z, uint32 map, uint32 member, uint32 cost, uint32 add)
{
    GuildId = newGuildId;
    Id = newId;
    m_X = x;
    m_Y = y;  
    m_Z = z;
    m_map = map;
    min_member = member;
    price = cost;
    m_orient = 0;
    GuildHouse_Add = add;
}

void GuildHouse::AddGuildHouse_Add(uint32 NewAdd)
{
    GuildHouse_Add |= NewAdd;
    QueryResult result = CharacterDatabase.PQuery("UPDATE `gh_guildadd` SET `GuildHouse_Add` = %u WHERE `guildId` = %u", GuildHouse_Add, GuildId);
    GHobj.AddGuildHouseAdd(Id, NewAdd, GuildId);
}

void LoadGuildHouseSystem()
{
    GHobj.LoadGuildHouseAdd();
    GHobj.LoadGuildHouse();
}

void GuildHouseObject::ControlGuildHouse()
{
    for (GuildHouseMap::iterator itr = GH_map.begin(); itr != GH_map.end(); itr++)
    {
        if (Guild* pGuild = sObjectMgr.GetGuildById((*itr).first))
            if (pGuild->GetMemberSize() < (*itr).second.min_member)
            {                    
                GHobj.ChangeGuildHouse((*itr).first, 0);
                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                pGuild->SetBankMoney(pGuild->GetGuildBankMoney()+((*itr).second.price * 75000), trans);
                CharacterDatabase.CommitTransaction(trans);
            }           
    }
}