/*
 * Copyright (C) 2008-2010 Trinity <http://www.trinitycore.org/>
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
 * @File : GuildHouse.h
 *
 * @Authors : Lazzalf
 *
 * @Date : 31/03/2010
 *
 * @Version : 0.1
 *
 **/

#ifndef SC_GUILDHOUSE_SYSTEM
#define SC_GUILDHOUSE_SYSTEM

#include "Common.h"
#include "ProgressBar.h"
#include "Map.h"
#include "World.h"
#include "Guild.h"
#include "ObjectMgr.h"
#include "Log.h"

#include <map>

enum GuildAdd_Type
{
    NPC_GUARD        = 0x00000001,
    NPC_BUFFMAN      = 0x00000002,
    NPC_TELE         = 0x00000004,
};
#define NPC_MAX 3

enum GH_Item_type
{
    CREATURE        = 0,
    OBJECT          = 1,
};

class GH_ItemTemp
{
    public:
        uint32              guid;
        GH_Item_type        type;
        uint32              GH_id;
        uint32              GH_AddType;
        bool                spawned;

        GH_ItemTemp(uint32 new_guid, GH_Item_type new_type, uint32 new_GH_id, uint32 new_GH_AddType);
};

class GuildHouse
{
    public: 
        GuildHouse(uint32 guild_id = 0, uint32 guild_add = 0);
        GuildHouse(uint32 guildID, uint32 id, uint32 x, uint32 y, uint32 z, uint16 map, uint32 add);
        
        uint32        GuildId;      
        uint32        Id;    
        uint32        GuildHouse_Add;
        float         m_X, m_Y, m_Z, m_orient;
        uint16        m_map; 

        void ChangeId(uint32 newid);
        void SetGuildHouse_Add(uint32 NewAdd);
        void ChangeGuildHouse_Add(uint32 NewAdd);
        void SetGuildHouse(uint32 guildID, uint32 id, uint32 x, uint32 y, uint32 z, uint16 map);
};

typedef UNORDERED_MAP<uint32, GuildHouse> GuildHouseMap;

typedef std::list<GH_ItemTemp> GH_Item;
typedef UNORDERED_MAP<uint32, GH_Item> GH_Add;
typedef UNORDERED_MAP<uint64, uint32> GuildGuardID;

uint32 GetGuildByGuardID(uint64 guid);
void LoadGuildHouse();
void LoadGuildHouseAdd();
//void LoadGuildGuardID();
bool CheckGuildGuardID(uint64 creature_guid, uint32 guild_id);
bool CheckGuildID(uint32 guild_id);
bool CheckGuildHouse(uint32 guild_id);
bool GetGuildHouseLocation(uint32 guild_id, float &x, float &y, float &z, float &o, uint16 &map);
bool ChangeGuildHouse(uint32 guild_id, uint32 newid);
bool RemoveGuildHouseAdd(uint32 id);
bool AddGuildHouseAdd(uint32 id, uint32 add, uint32 guild);
void UpdateGuardMap(uint32 guid, uint32 guild);

#endif