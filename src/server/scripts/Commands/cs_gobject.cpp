/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
Name: gobject_commandscript
%Complete: 100
Comment: All gobject related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "GameEventMgr.h"
#include "ObjectMgr.h"
#include "PoolMgr.h"
#include "MapManager.h"
#include "Chat.h"

class gobject_commandscript : public CommandScript
{
public:
    gobject_commandscript() : CommandScript("gobject_commandscript") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand gobjectAddCommandTable[] =
        {
            { "temp",           SEC_GAMEMASTER,     false, &HandleGameObjectAddTempCommand,   "", NULL },
            { "",               SEC_GAMEMASTER,     false, &HandleGameObjectAddCommand,       "", NULL },
            { NULL,             0,                  false, NULL,                              "", NULL }
        };
        static ChatCommand gobjectSetCommandTable[] =
        {
            { "phase",          SEC_GAMEMASTER,     false, &HandleGameObjectSetPhaseCommand,  "", NULL },
            { "state",          SEC_GAMEMASTER,     false, &HandleGameObjectSetStateCommand,  "", NULL },
            { NULL,             0,                  false, NULL,                              "", NULL }
        };
        static ChatCommand gobjectCommandTable[] =
        {
            { "activate",       SEC_GAMEMASTER,     false, &HandleGameObjectActivateCommand,  "", NULL },
            { "delete",         SEC_GAMEMASTER,     false, &HandleGameObjectDeleteCommand,    "", NULL },
            { "info",           SEC_GAMEMASTER,     false, &HandleGameObjectInfoCommand,      "", NULL },
            { "move",           SEC_GAMEMASTER,     false, &HandleGameObjectMoveCommand,      "", NULL },
            { "near",           SEC_GAMEMASTER,     false, &HandleGameObjectNearCommand,      "", NULL },
            { "target",         SEC_GAMEMASTER,     false, &HandleGameObjectTargetCommand,    "", NULL },
            { "turn",           SEC_GAMEMASTER,     false, &HandleGameObjectTurnCommand,      "", NULL },
            { "add",            SEC_GAMEMASTER,     false, NULL,            "", gobjectAddCommandTable },
            { "guildadd",       SEC_GAMEMASTER,     false, &HandleGameObjectAddGuildCommand,  "", NULL },
            { "set",            SEC_GAMEMASTER,     false, NULL,            "", gobjectSetCommandTable },
            { NULL,             0,                  false, NULL,                              "", NULL }
        };
        static ChatCommand commandTable[] =
        {
            { "gobject",        SEC_GAMEMASTER,     false, NULL,                "", gobjectCommandTable },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        return commandTable;
    }

    //spawn go
    static bool HandleGameObjectAddGuildCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        // number or [name] Shift-click form |color|Hgameobject_entry:go_id|h[name]|h|r
        char* cId = handler->extractKeyFromLink((char*)args, "Hgameobject_entry");
        if (!cId)
            return false;

        char* c_guildhouse = strtok(NULL, " ");
        if (!c_guildhouse)
            return false;

        char* c_guildhouseadd = strtok(NULL, " ");
        if (!c_guildhouseadd)
            return false;

        uint32 id = atol(cId);
        uint32 guildhouseid = atol(c_guildhouse);
        uint32 guildhouseaddid = atol(c_guildhouseadd);

        if (!id || !guildhouseid || !guildhouseaddid)
            return false;

        char* spawntimeSecs = strtok(NULL, " ");

        const GameObjectTemplate *gInfo = sObjectMgr->GetGameObjectTemplate(id);

        if (!gInfo)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (gInfo->displayId && !sGameObjectDisplayInfoStore.LookupEntry(gInfo->displayId))
        {
            // report to DB errors log as in loading case
            sLog->outErrorDb("Gameobject (Entry %u GoType: %u) have invalid displayId (%u), not spawned.", id, gInfo->type, gInfo->displayId);
            handler->PSendSysMessage(LANG_GAMEOBJECT_HAVE_INVALID_DATA, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player *chr = handler->GetSession()->GetPlayer();
        float x = float(chr->GetPositionX());
        float y = float(chr->GetPositionY());
        float z = float(chr->GetPositionZ());
        float o = float(chr->GetOrientation());
        Map *map = chr->GetMap();

        GameObject* pGameObj = new GameObject;
        uint32 db_lowGUID = sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT);

        if (!pGameObj->Create(db_lowGUID, gInfo->entry, map, chr->GetPhaseMaskForSpawn(), x, y, z, o, 0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY))
        {
            delete pGameObj;
            return false;
        }

        if (spawntimeSecs)
        {
            uint32 value = atoi((char*)spawntimeSecs);
            pGameObj->SetRespawnTime(value);
            //sLog->outDebug(LOG_FILTER_TSCR, "*** spawntimeSecs: %d", value);
        }

        // fill the gameobject data and save to the db
        pGameObj->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), chr->GetPhaseMaskForSpawn());

        // this will generate a new guid if the object is in an instance
        if (!pGameObj->LoadFromDB(db_lowGUID, map))
        {
            delete pGameObj;
            return false;
        }

        map->AddToMap(pGameObj);

        WorldDatabase.PQuery("INSERT INTO guildhouses_add (guid, type, id, add_type, comment) VALUES (%u, 1, %u, %u, '%s')", 
                              pGameObj->GetDBTableGUIDLow(), guildhouseid, guildhouseaddid, pGameObj->GetName());   

        // TODO: is it really necessary to add both the real and DB table guid here ?
        sObjectMgr->AddGameobjectToGrid(db_lowGUID, sObjectMgr->GetGOData(db_lowGUID));

        handler->PSendSysMessage(LANG_GAMEOBJECT_ADD, id, gInfo->name.c_str(), db_lowGUID, x, y, z);
        return true;
    }

    static bool HandleGameObjectActivateCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* id = handler->extractKeyFromLink((char*)args, "Hgameobject");
        if (!id)
            return false;

        uint32 guidLow = atoi(id);
        if (!guidLow)
            return false;

        GameObject* object = NULL;

        // by DB guid
        if (GameObjectData const* goData = sObjectMgr->GetGOData(guidLow))
            object = handler->GetObjectGlobalyWithGuidOrNearWithDbGuid(guidLow, goData->id);

        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, guidLow);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Activate
        object->SetLootState(GO_READY);
        object->UseDoorOrButton(10000);

        handler->PSendSysMessage("Object activated!");

        return true;
    }

    //spawn go
    static bool HandleGameObjectAddCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        // number or [name] Shift-click form |color|Hgameobject_entry:go_id|h[name]|h|r
        char* id = handler->extractKeyFromLink((char*)args, "Hgameobject_entry");
        if (!id)
            return false;

        uint32 objectId = atol(id);
        if (!objectId)
            return false;

        char* spawntimeSecs = strtok(NULL, " ");

        const GameObjectTemplate* objectInfo = sObjectMgr->GetGameObjectTemplate(objectId);

        if (!objectInfo)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, objectId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (objectInfo->displayId && !sGameObjectDisplayInfoStore.LookupEntry(objectInfo->displayId))
        {
            // report to DB errors log as in loading case
            sLog->outErrorDb("Gameobject (Entry %u GoType: %u) have invalid displayId (%u), not spawned.", objectId, objectInfo->type, objectInfo->displayId);
            handler->PSendSysMessage(LANG_GAMEOBJECT_HAVE_INVALID_DATA, objectId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();
        float x = float(player->GetPositionX());
        float y = float(player->GetPositionY());
        float z = float(player->GetPositionZ());
        float o = float(player->GetOrientation());
        Map* map = player->GetMap();

        GameObject* object = new GameObject;
        uint32 guidLow = sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT);

        if (!object->Create(guidLow, objectInfo->entry, map, player->GetPhaseMaskForSpawn(), x, y, z, o, 0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY))
        {
            delete object;
            return false;
        }

        if (spawntimeSecs)
        {
            uint32 value = atoi((char*)spawntimeSecs);
            object->SetRespawnTime(value);
        }

        // fill the gameobject data and save to the db
        object->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());

        // this will generate a new guid if the object is in an instance
        if (!object->LoadFromDB(guidLow, map))
        {
            delete object;
            return false;
        }

        map->AddToMap(object);

        // TODO: is it really necessary to add both the real and DB table guid here ?
        sObjectMgr->AddGameobjectToGrid(guidLow, sObjectMgr->GetGOData(guidLow));

        handler->PSendSysMessage(LANG_GAMEOBJECT_ADD, objectId, objectInfo->name.c_str(), guidLow, x, y, z);
        return true;
    }

    // add go, temp only
    static bool HandleGameObjectAddTempCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* id = strtok((char*)args, " ");
        if (!id)
            return false;

        Player* player = handler->GetSession()->GetPlayer();

        char* spawntime = strtok(NULL, " ");
        uint32 spawntm = 300;

        if (spawntime)
            spawntm = atoi((char*)spawntime);

        float x = player->GetPositionX();
        float y = player->GetPositionY();
        float z = player->GetPositionZ();
        float ang = player->GetOrientation();

        float rot2 = sin(ang/2);
        float rot3 = cos(ang/2);

        uint32 objectId = atoi(id);

        player->SummonGameObject(objectId, x, y, z, ang, 0, 0, rot2, rot3, spawntm);

        return true;
    }

    static bool HandleGameObjectTargetCommand(ChatHandler* handler, char const* args)
    {
        Player* player = handler->GetSession()->GetPlayer();
        QueryResult result;
        GameEventMgr::ActiveEvents const& activeEventsList = sGameEventMgr->GetActiveEventList();

        if (*args)
        {
            // number or [name] Shift-click form |color|Hgameobject_entry:go_id|h[name]|h|r
            char* id = handler->extractKeyFromLink((char*)args, "Hgameobject_entry");
            if (!id)
                return false;

            uint32 objectId = atol(id);

            if (objectId)
                result = WorldDatabase.PQuery("SELECT guid, id, position_x, position_y, position_z, orientation, map, phaseMask, (POW(position_x - '%f', 2) + POW(position_y - '%f', 2) + POW(position_z - '%f', 2)) AS order_ FROM gameobject WHERE map = '%i' AND id = '%u' ORDER BY order_ ASC LIMIT 1",
                player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), objectId);
            else
            {
                std::string name = id;
                WorldDatabase.EscapeString(name);
                result = WorldDatabase.PQuery(
                    "SELECT guid, id, position_x, position_y, position_z, orientation, map, phaseMask, (POW(position_x - %f, 2) + POW(position_y - %f, 2) + POW(position_z - %f, 2)) AS order_ "
                    "FROM gameobject, gameobject_template WHERE gameobject_template.entry = gameobject.id AND map = %i AND name "_LIKE_" "_CONCAT3_("'%%'", "'%s'", "'%%'")" ORDER BY order_ ASC LIMIT 1",
                    player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), name.c_str());
            }
        }
        else
        {
            std::ostringstream eventFilter;
            eventFilter << " AND (eventEntry IS NULL ";
            bool initString = true;

            for (GameEventMgr::ActiveEvents::const_iterator itr = activeEventsList.begin(); itr != activeEventsList.end(); ++itr)
            {
                if (initString)
                {
                    eventFilter  <<  "OR eventEntry IN (" << *itr;
                    initString = false;
                }
                else
                    eventFilter << ',' << *itr;
            }

            if (!initString)
                eventFilter << "))";
            else
                eventFilter << ')';

            result = WorldDatabase.PQuery("SELECT gameobject.guid, id, position_x, position_y, position_z, orientation, map, phaseMask, "
                "(POW(position_x - %f, 2) + POW(position_y - %f, 2) + POW(position_z - %f, 2)) AS order_ FROM gameobject "
                "LEFT OUTER JOIN game_event_gameobject on gameobject.guid = game_event_gameobject.guid WHERE map = '%i' %s ORDER BY order_ ASC LIMIT 10",
                handler->GetSession()->GetPlayer()->GetPositionX(), handler->GetSession()->GetPlayer()->GetPositionY(), handler->GetSession()->GetPlayer()->GetPositionZ(),
                handler->GetSession()->GetPlayer()->GetMapId(), eventFilter.str().c_str());
        }

        if (!result)
        {
            handler->SendSysMessage(LANG_COMMAND_TARGETOBJNOTFOUND);
            return true;
        }

        bool found = false;
        float x, y, z, o;
        uint32 guidLow, id;
        uint16 mapId, phase;
        uint32 poolId;

        do
        {
            Field* fields = result->Fetch();
            guidLow = fields[0].GetUInt32();
            id =      fields[1].GetUInt32();
            x =       fields[2].GetFloat();
            y =       fields[3].GetFloat();
            z =       fields[4].GetFloat();
            o =       fields[5].GetFloat();
            mapId =   fields[6].GetUInt16();
            phase =   fields[7].GetUInt16();
            poolId =  sPoolMgr->IsPartOfAPool<GameObject>(guidLow);
            if (!poolId || sPoolMgr->IsSpawnedObject<GameObject>(guidLow))
                found = true;
        } while (result->NextRow() && !found);

        if (!found)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, id);
            return false;
        }

        GameObjectTemplate const* objectInfo = sObjectMgr->GetGameObjectTemplate(id);

        if (!objectInfo)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, id);
            return false;
        }

        GameObject* target = handler->GetSession()->GetPlayer()->GetMap()->GetGameObject(MAKE_NEW_GUID(guidLow, id, HIGHGUID_GAMEOBJECT));

        handler->PSendSysMessage(LANG_GAMEOBJECT_DETAIL, guidLow, objectInfo->name.c_str(), guidLow, id, x, y, z, mapId, o, phase);

        if (target)
        {
            int32 curRespawnDelay = int32(target->GetRespawnTimeEx() - time(NULL));
            if (curRespawnDelay < 0)
                curRespawnDelay = 0;

            std::string curRespawnDelayStr = secsToTimeString(curRespawnDelay, true);
            std::string defRespawnDelayStr = secsToTimeString(target->GetRespawnDelay(), true);

            handler->PSendSysMessage(LANG_COMMAND_RAWPAWNTIMES, defRespawnDelayStr.c_str(), curRespawnDelayStr.c_str());
        }
        return true;
    }

    //delete object by selection or guid
    static bool HandleGameObjectDeleteCommand(ChatHandler* handler, char const* args)
    {
        // number or [name] Shift-click form |color|Hgameobject:go_guid|h[name]|h|r
        char* id = handler->extractKeyFromLink((char*)args, "Hgameobject");
        if (!id)
            return false;

        uint32 guidLow = atoi(id);
        if (!guidLow)
            return false;

        GameObject* object = NULL;

        // by DB guid
        if (GameObjectData const* gameObjectData = sObjectMgr->GetGOData(guidLow))
            object = handler->GetObjectGlobalyWithGuidOrNearWithDbGuid(guidLow, gameObjectData->id);

        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, guidLow);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint64 ownerGuid = object->GetOwnerGUID();
        if (ownerGuid)
        {
            Unit* owner = ObjectAccessor::GetUnit(*handler->GetSession()->GetPlayer(), ownerGuid);
            if (!owner || !IS_PLAYER_GUID(ownerGuid))
            {
                handler->PSendSysMessage(LANG_COMMAND_DELOBJREFERCREATURE, GUID_LOPART(ownerGuid), object->GetGUIDLow());
                handler->SetSentErrorMessage(true);
                return false;
            }

            owner->RemoveGameObject(object, false);
        }

        object->SetRespawnTime(0);                                 // not save respawn time
        object->Delete();
        object->DeleteFromDB();

        // GuidHouse
        WorldDatabase.PQuery("DELETE FROM guildhouses_add WHERE guid = %u AND type = 1", object->GetDBTableGUIDLow());   

        handler->PSendSysMessage(LANG_COMMAND_DELOBJMESSAGE, object->GetGUIDLow());

        return true;
    }

    //turn selected object
    static bool HandleGameObjectTurnCommand(ChatHandler* handler, char const* args)
    {
        // number or [name] Shift-click form |color|Hgameobject:go_id|h[name]|h|r
        char* id = handler->extractKeyFromLink((char*)args, "Hgameobject");
        if (!id)
            return false;

        uint32 guidLow = atoi(id);
        if (!guidLow)
            return false;

        GameObject* object = NULL;

        // by DB guid
        if (GameObjectData const* gameObjectData = sObjectMgr->GetGOData(guidLow))
            object = handler->GetObjectGlobalyWithGuidOrNearWithDbGuid(guidLow, gameObjectData->id);

        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, guidLow);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* orientation = strtok(NULL, " ");
        float o;

        if (orientation)
            o = (float)atof(orientation);
        else
        {
            Player* player = handler->GetSession()->GetPlayer();
            o = player->GetOrientation();
        }

        object->Relocate(object->GetPositionX(), object->GetPositionY(), object->GetPositionZ(), o);
        object->UpdateRotationFields();
        object->DestroyForNearbyPlayers();
        object->UpdateObjectVisibility();

        object->SaveToDB();
        object->Refresh();

        handler->PSendSysMessage(LANG_COMMAND_TURNOBJMESSAGE, object->GetGUIDLow(), object->GetGOInfo()->name.c_str(), object->GetGUIDLow(), o);

        return true;
    }

    //move selected object
    static bool HandleGameObjectMoveCommand(ChatHandler* handler, char const* args)
    {
        // number or [name] Shift-click form |color|Hgameobject:go_guid|h[name]|h|r
        char* id = handler->extractKeyFromLink((char*)args, "Hgameobject");
        if (!id)
            return false;

        uint32 guidLow = atoi(id);
        if (!guidLow)
            return false;

        GameObject* object = NULL;

        // by DB guid
        if (GameObjectData const* gameObjectData = sObjectMgr->GetGOData(guidLow))
            object = handler->GetObjectGlobalyWithGuidOrNearWithDbGuid(guidLow, gameObjectData->id);

        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, guidLow);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* toX = strtok(NULL, " ");
        char* toY = strtok(NULL, " ");
        char* toZ = strtok(NULL, " ");

        if (!toX)
        {
            Player* player = handler->GetSession()->GetPlayer();
            object->Relocate(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), object->GetOrientation());
            object->DestroyForNearbyPlayers();
            object->UpdateObjectVisibility();
        }
        else
        {
            if (!toY || !toZ)
                return false;

            float x = (float)atof(toX);
            float y = (float)atof(toY);
            float z = (float)atof(toZ);

            if (!MapManager::IsValidMapCoord(object->GetMapId(), x, y, z))
            {
                handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, object->GetMapId());
                handler->SetSentErrorMessage(true);
                return false;
            }

            object->Relocate(x, y, z, object->GetOrientation());
            object->DestroyForNearbyPlayers();
            object->UpdateObjectVisibility();
        }

        object->SaveToDB();
        object->Refresh();

        handler->PSendSysMessage(LANG_COMMAND_MOVEOBJMESSAGE, object->GetGUIDLow(), object->GetGOInfo()->name.c_str(), object->GetGUIDLow());

        return true;
    }

    //set phasemask for selected object
    static bool HandleGameObjectSetPhaseCommand(ChatHandler* handler, char const* args)
    {
        // number or [name] Shift-click form |color|Hgameobject:go_id|h[name]|h|r
        char* id = handler->extractKeyFromLink((char*)args, "Hgameobject");
        if (!id)
            return false;

        uint32 guidLow = atoi(id);
        if (!guidLow)
            return false;

        GameObject* object = NULL;

        // by DB guid
        if (GameObjectData const* gameObjectData = sObjectMgr->GetGOData(guidLow))
            object = handler->GetObjectGlobalyWithGuidOrNearWithDbGuid(guidLow, gameObjectData->id);

        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, guidLow);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* phase = strtok (NULL, " ");
        uint32 phaseMask = phase ? atoi(phase) : 0;
        if (phaseMask == 0)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        object->SetPhaseMask(phaseMask, true);
        object->SaveToDB();
        return true;
    }

    static bool HandleGameObjectNearCommand(ChatHandler* handler, char const* args)
    {
        float distance = (!*args) ? 10.0f : (float)(atof(args));
        uint32 count = 0;

        Player* player = handler->GetSession()->GetPlayer();
        QueryResult result = WorldDatabase.PQuery("SELECT guid, id, position_x, position_y, position_z, map, "
            "(POW(position_x - '%f', 2) + POW(position_y - '%f', 2) + POW(position_z - '%f', 2)) AS order_ "
            "FROM gameobject WHERE map='%u' AND (POW(position_x - '%f', 2) + POW(position_y - '%f', 2) + POW(position_z - '%f', 2)) <= '%f' ORDER BY order_",
            player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(),
            player->GetMapId(), player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), distance * distance);

        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                uint32 guid = fields[0].GetUInt32();
                uint32 entry = fields[1].GetUInt32();
                float x = fields[2].GetFloat();
                float y = fields[3].GetFloat();
                float z = fields[4].GetFloat();
                uint16 mapId = fields[5].GetUInt16();

                GameObjectTemplate const* gameObjectInfo = sObjectMgr->GetGameObjectTemplate(entry);

                if (!gameObjectInfo)
                    continue;

                handler->PSendSysMessage(LANG_GO_LIST_CHAT, guid, entry, guid, gameObjectInfo->name.c_str(), x, y, z, mapId);

                ++count;
            } while (result->NextRow());
        }

        handler->PSendSysMessage(LANG_COMMAND_NEAROBJMESSAGE, distance, count);
        return true;
    }

    //show info of gameobject
    static bool HandleGameObjectInfoCommand(ChatHandler* handler, char const* args)
    {
        uint32 entry = 0;
        uint32 type = 0;
        uint32 displayId = 0;
        std::string name;
        uint32 lootId = 0;

        if (!*args)
        {
            if (WorldObject* object = handler->getSelectedObject())
                entry = object->GetEntry();
            else
                entry = atoi((char*)args);
        }

        GameObjectTemplate const* gameObjectInfo = sObjectMgr->GetGameObjectTemplate(entry);

        if (!gameObjectInfo)
            return false;

        type = gameObjectInfo->type;
        displayId = gameObjectInfo->displayId;
        name = gameObjectInfo->name;
        if (type == GAMEOBJECT_TYPE_CHEST)
            lootId = gameObjectInfo->chest.lootId;
        else if (type == GAMEOBJECT_TYPE_FISHINGHOLE)
            lootId = gameObjectInfo->fishinghole.lootId;

        handler->PSendSysMessage(LANG_GOINFO_ENTRY, entry);
        handler->PSendSysMessage(LANG_GOINFO_TYPE, type);
        handler->PSendSysMessage(LANG_GOINFO_LOOTID, lootId);
        handler->PSendSysMessage(LANG_GOINFO_DISPLAYID, displayId);
        handler->PSendSysMessage(LANG_GOINFO_NAME, name.c_str());

        return true;
    }

    static bool HandleGameObjectSetStateCommand(ChatHandler* handler, char const* args)
    {
        // number or [name] Shift-click form |color|Hgameobject:go_id|h[name]|h|r
        char* id = handler->extractKeyFromLink((char*)args, "Hgameobject");
        if (!id)
            return false;

        uint32 guidLow = atoi(id);
        if (!guidLow)
            return false;

        GameObject* object = NULL;

        if (GameObjectData const* gameObjectData = sObjectMgr->GetGOData(guidLow))
            object = handler->GetObjectGlobalyWithGuidOrNearWithDbGuid(guidLow, gameObjectData->id);

        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, guidLow);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* type = strtok(NULL, " ");
        if (!type)
            return false;

        int32 objectType = atoi(type);
        if (objectType < 0)
        {
            if (objectType == -1)
                object->SendObjectDeSpawnAnim(object->GetGUID());
            else if (objectType == -2)
                return false;
            return true;
        }

        char* state = strtok(NULL, " ");
        if (!state)
            return false;

        int32 objectState = atoi(state);

        if (objectType < 4)
            object->SetByteValue(GAMEOBJECT_BYTES_1, objectType, objectState);
        else if (objectType == 4)
        {
            WorldPacket data(SMSG_GAMEOBJECT_CUSTOM_ANIM, 8+4);
            data << object->GetGUID();
            data << (uint32)(objectState);
            object->SendMessageToSet(&data, true);
        }
        handler->PSendSysMessage("Set gobject type %d state %d", objectType, objectState);
        return true;
    }
};

void AddSC_gobject_commandscript()
{
    new gobject_commandscript();
}
