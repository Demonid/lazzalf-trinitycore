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

//#include <map>

enum GuildAdd_Type
{
    NPC_BASIC        = 0x00000001,
    NPC_GUARD        = 0x00000002,
    NPC_BUFFMAN      = 0x00000004,
    NPC_TELE         = 0x00000008,
};
#define NPC_MAX 4

enum GH_Item_type
{
    CREATURE        = 0,
    OBJECT          = 1,
};

class GuildHouse
{
    public: 
        GuildHouse(uint32 guild_id = 0, uint32 guild_add = 0);
        GuildHouse(uint32 guildID, uint32 id, float x, float y, float z, uint32 map, uint32 add);
        
        uint32        GuildId;      
        uint32        Id;    
        uint32        GuildHouse_Add;
        float         m_X, m_Y, m_Z, m_orient;
        uint32        m_map; 

        void ChangeId(uint32 newid);
        void AddGuildHouse_Add(uint32 NewAdd);
};

typedef std::vector<uint32> Item_Vector;
class GH_Item
{    
   public:
      Item_Vector AddCre;
      Item_Vector AddGO;
      bool spawned;
      GH_Item()
      {
          AddCre.clear();
          AddGO.clear();
          spawned = true;
      }
};

typedef UNORDERED_MAP<uint32, GuildHouse> GuildHouseMap;
typedef UNORDERED_MAP<uint32, GH_Item> GH_Add;
typedef UNORDERED_MAP<uint64, uint32> GuildGuardID;

void LoadGuildHouse();
void LoadGuildHouseAdd();
bool CheckGuildID(uint32 guild_id);
bool CheckGuildHouse(uint32 guild_id);
bool GetGuildHouseLocation(uint32 guild_id, float &x, float &y, float &z, float &o, uint32 &map);
bool GetGuildHouseMap(uint32 guild_id, uint32 &map);
uint32 GetGuildHouse_Add(uint32 guild_id);
bool Add_GuildhouseAdd(uint32 guild_id, uint32 add);
bool haveGuildHouse(uint32 guild_id);
bool ChangeGuildHouse(uint32 guild_id, uint32 newid);
bool RemoveGuildHouseAdd(uint32 id);
bool AddGuildHouseAdd(uint32 id, uint32 add, uint32 guild);
void UpdateGuardMap(uint64 guid, uint32 guild);
uint32 GetGuildByGuardID(uint64 guid);

#endif