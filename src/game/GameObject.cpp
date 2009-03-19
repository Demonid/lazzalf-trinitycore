/*
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008-2009 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "Common.h"
#include "QuestDef.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "PoolHandler.h"
#include "SpellMgr.h"
#include "Spell.h"
#include "UpdateMask.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "World.h"
#include "Database/DatabaseEnv.h"
#include "LootMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "InstanceData.h"
#include "BattleGround.h"
#include "Util.h"
#include "OutdoorPvPMgr.h"
#include "BattleGroundAV.h"

GameObject::GameObject() : WorldObject()
{
    m_objectType |= TYPEMASK_GAMEOBJECT;
    m_objectTypeId = TYPEID_GAMEOBJECT;
                                                            // 2.3.2 - 0x58
    m_updateFlag = (UPDATEFLAG_LOWGUID | UPDATEFLAG_HIGHGUID | UPDATEFLAG_HAS_POSITION);

    m_valuesCount = GAMEOBJECT_END;
    m_respawnTime = 0;
    m_respawnDelayTime = 25;
    m_lootState = GO_NOT_READY;
    m_spawnedByDefault = true;
    m_usetimes = 0;
    m_spellId = 0;
    m_charges = 5;
    m_cooldownTime = 0;
    m_goInfo = NULL;

    m_DBTableGuid = 0;
}

GameObject::~GameObject()
{
    if(m_uint32Values)                                      // field array can be not exist if GameOBject not loaded
    {
        // Possible crash at access to deleted GO in Unit::m_gameobj
        uint64 owner_guid = GetOwnerGUID();
        if(owner_guid)
        {
            Unit* owner = ObjectAccessor::GetUnit(*this,owner_guid);
            if(owner)
                owner->RemoveGameObject(this,false);
            else if(!IS_PLAYER_GUID(owner_guid))
                sLog.outError("Delete GameObject (GUID: %u Entry: %u ) that have references in not found creature %u GO list. Crash possible later.",GetGUIDLow(),GetGOInfo()->id,GUID_LOPART(owner_guid));
        }
    }
}

void GameObject::AddToWorld()
{
    ///- Register the gameobject for guid lookup
    if(!IsInWorld()) ObjectAccessor::Instance().AddObject(this);
    WorldObject::AddToWorld();
}

void GameObject::RemoveFromWorld()
{
    ///- Remove the gameobject from the accessor
    if(IsInWorld()) ObjectAccessor::Instance().RemoveObject(this);
    WorldObject::RemoveFromWorld();
}

bool GameObject::Create(uint32 guidlow, uint32 name_id, Map *map, uint32 phaseMask, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 animprogress, uint32 go_state, uint32 ArtKit)
{
    Relocate(x,y,z,ang);
    SetMapId(map->GetId());
    SetInstanceId(map->GetInstanceId());
    SetPhaseMask(phaseMask,false);

    if(!IsPositionValid())
    {
        sLog.outError("ERROR: Gameobject (GUID: %u Entry: %u ) not created. Suggested coordinates isn't valid (X: %f Y: %f)",guidlow,name_id,x,y);
        return false;
    }

    GameObjectInfo const* goinfo = objmgr.GetGameObjectInfo(name_id);
    if (!goinfo)
    {
        sLog.outErrorDb("Gameobject (GUID: %u Entry: %u) not created: it have not exist entry in `gameobject_template`. Map: %u  (X: %f Y: %f Z: %f) ang: %f rotation0: %f rotation1: %f rotation2: %f rotation3: %f",guidlow, name_id, map->GetId(), x, y, z, ang, rotation0, rotation1, rotation2, rotation3);
        return false;
    }

    Object::_Create(guidlow, goinfo->id, HIGHGUID_GAMEOBJECT);

    m_goInfo = goinfo;

    if (goinfo->type >= MAX_GAMEOBJECT_TYPE)
    {
        sLog.outErrorDb("Gameobject (GUID: %u Entry: %u) not created: it have not exist GO type '%u' in `gameobject_template`. It's will crash client if created.",guidlow,name_id,goinfo->type);
        return false;
    }

    SetFloatValue(GAMEOBJECT_POS_X, x);
    SetFloatValue(GAMEOBJECT_POS_Y, y);
    SetFloatValue(GAMEOBJECT_POS_Z, z);

    SetFloatValue(GAMEOBJECT_PARENTROTATION+0, rotation0);
    SetFloatValue(GAMEOBJECT_PARENTROTATION+1, rotation1);

    UpdateRotationFields(rotation2,rotation3);              // GAMEOBJECT_FACING, GAMEOBJECT_ROTATION, GAMEOBJECT_PARENTROTATION+2/3

    SetFloatValue(OBJECT_FIELD_SCALE_X, goinfo->size);

    SetUInt32Value(GAMEOBJECT_FACTION, goinfo->faction);
    SetUInt32Value(GAMEOBJECT_FLAGS, goinfo->flags);

    SetEntry(goinfo->id);

    SetUInt32Value(GAMEOBJECT_DISPLAYID, goinfo->displayId);

    SetGoState(go_state);
    SetGoType(GameobjectTypes(goinfo->type));

    SetGoAnimProgress(animprogress);

    SetByteValue(GAMEOBJECT_BYTES_1, 2, ArtKit);

    // Spell charges for GAMEOBJECT_TYPE_SPELLCASTER (22)
    if (goinfo->type == GAMEOBJECT_TYPE_SPELLCASTER)
        m_charges = goinfo->spellcaster.charges;

    //Notify the map's instance data.
    //Only works if you create the object in it, not if it is moves to that map.
    //Normally non-players do not teleport to other maps.
    if(map->IsDungeon() && ((InstanceMap*)map)->GetInstanceData())
    {
        ((InstanceMap*)map)->GetInstanceData()->OnObjectCreate(this);
    }

    return true;
}

void GameObject::Update(uint32 /*p_time*/)
{
    if (IS_MO_TRANSPORT(GetGUID()))
    {
        //((Transport*)this)->Update(p_time);
        return;
    }

    switch (m_lootState)
    {
        case GO_NOT_READY:
        {
            switch(GetGoType())
            {
                case GAMEOBJECT_TYPE_TRAP:
                {
                    // Arming Time for GAMEOBJECT_TYPE_TRAP (6)
                    Unit* owner = GetOwner();
                    if (owner && ((Player*)owner)->isInCombat())
                        m_cooldownTime = time(NULL) + GetGOInfo()->trap.startDelay;
                    m_lootState = GO_READY;
                    break;
                }
                case GAMEOBJECT_TYPE_FISHINGNODE:
                {
                    // fishing code (bobber ready)
                    if( time(NULL) > m_respawnTime - FISHING_BOBBER_READY_TIME )
                    {
                        // splash bobber (bobber ready now)
                        Unit* caster = GetOwner();
                        if(caster && caster->GetTypeId()==TYPEID_PLAYER)
                        {
                            SetGoState(0);
                            SetUInt32Value(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);

                            UpdateData udata;
                            WorldPacket packet;
                            BuildValuesUpdateBlockForPlayer(&udata,((Player*)caster));
                            udata.BuildPacket(&packet);
                            ((Player*)caster)->GetSession()->SendPacket(&packet);

                            WorldPacket data(SMSG_GAMEOBJECT_CUSTOM_ANIM,8+4);
                            data << GetGUID();
                            data << (uint32)(0);
                            ((Player*)caster)->SendMessageToSet(&data,true);
                        }

                        m_lootState = GO_READY;                 // can be successfully open with some chance
                    }
                    return;
                }
                default:
                    m_lootState = GO_READY;                         // for other GOis same switched without delay to GO_READY
                    break;
            }
            // NO BREAK for switch (m_lootState)
        }
        case GO_READY:
        {
            if (m_respawnTime > 0)                          // timer on
            {
                if (m_respawnTime <= time(NULL))            // timer expired
                {
                    m_respawnTime = 0;
                    m_SkillupList.clear();
                    m_usetimes = 0;

                    switch (GetGoType())
                    {
                        case GAMEOBJECT_TYPE_FISHINGNODE:   //  can't fish now
                        {
                            Unit* caster = GetOwner();
                            if(caster && caster->GetTypeId()==TYPEID_PLAYER)
                            {
                                if(caster->m_currentSpells[CURRENT_CHANNELED_SPELL])
                                {
                                    caster->m_currentSpells[CURRENT_CHANNELED_SPELL]->SendChannelUpdate(0);
                                    caster->m_currentSpells[CURRENT_CHANNELED_SPELL]->finish(false);
                                }

                                WorldPacket data(SMSG_FISH_NOT_HOOKED,0);
                                ((Player*)caster)->GetSession()->SendPacket(&data);
                            }
                            // can be delete
                            m_lootState = GO_JUST_DEACTIVATED;
                            return;
                        }
                        case GAMEOBJECT_TYPE_DOOR:
                        case GAMEOBJECT_TYPE_BUTTON:
                            //we need to open doors if they are closed (add there another condition if this code breaks some usage, but it need to be here for battlegrounds)
                            if( !GetGoState() )
                                SwitchDoorOrButton(false);
                            //flags in AB are type_button and we need to add them here so no break!
                        default:
                            if(!m_spawnedByDefault)         // despawn timer
                            {
                                                            // can be despawned or destroyed
                                SetLootState(GO_JUST_DEACTIVATED);
                                return;
                            }
                                                            // respawn timer
                            uint16 poolid = poolhandler.IsPartOfAPool(GetGUIDLow(), TYPEID_GAMEOBJECT);
                            if (poolid)
                                poolhandler.UpdatePool(poolid, GetGUIDLow(), TYPEID_GAMEOBJECT);
                            else
                                GetMap()->Add(this);
                            break;
                    }
                }
            }

            // traps can have time and can not have
            GameObjectInfo const* goInfo = GetGOInfo();
            if(goInfo->type == GAMEOBJECT_TYPE_TRAP)
            {
                // traps
                Unit* owner = GetOwner();
                Unit* ok = NULL;                            // pointer to appropriate target if found any

                if(m_cooldownTime >= time(NULL))
                    return;

                bool IsBattleGroundTrap = false;
                //FIXME: this is activation radius (in different casting radius that must be selected from spell data)
                //TODO: move activated state code (cast itself) to GO_ACTIVATED, in this place only check activating and set state
                float radius = goInfo->trap.radius;
                if(!radius)
                {
                    if(goInfo->trap.cooldown != 3)            // cast in other case (at some triggering/linked go/etc explicit call)
                        return;
                    else
                    {
                        if(m_respawnTime > 0)
                            break;

                        radius = goInfo->trap.cooldown;       // battlegrounds gameobjects has data2 == 0 && data5 == 3
                        IsBattleGroundTrap = true;
                    }
                }

                bool NeedDespawn = (goInfo->trap.charges != 0);

                CellPair p(Trinity::ComputeCellPair(GetPositionX(),GetPositionY()));
                Cell cell(p);
                cell.data.Part.reserved = ALL_DISTRICT;

                // Note: this hack with search required until GO casting not implemented
                // search unfriendly creature
                if(owner && NeedDespawn)                    // hunter trap
                {
                    Trinity::AnyUnfriendlyNoTotemUnitInObjectRangeCheck u_check(this, owner, radius);
                    Trinity::UnitSearcher<Trinity::AnyUnfriendlyNoTotemUnitInObjectRangeCheck> checker(this, ok, u_check);

                    CellLock<GridReadGuard> cell_lock(cell, p);

                    TypeContainerVisitor<Trinity::UnitSearcher<Trinity::AnyUnfriendlyNoTotemUnitInObjectRangeCheck>, GridTypeMapContainer > grid_object_checker(checker);
                    cell_lock->Visit(cell_lock, grid_object_checker, *GetMap());

                    // or unfriendly player/pet
                    if(!ok)
                    {
                        TypeContainerVisitor<Trinity::UnitSearcher<Trinity::AnyUnfriendlyNoTotemUnitInObjectRangeCheck>, WorldTypeMapContainer > world_object_checker(checker);
                        cell_lock->Visit(cell_lock, world_object_checker, *GetMap());
                    }
                }
                else                                        // environmental trap
                {
                    // environmental damage spells already have around enemies targeting but this not help in case not existed GO casting support

                    // affect only players
                    Player* p_ok = NULL;
                    MaNGOS::AnyPlayerInObjectRangeCheck p_check(this, radius);
                    MaNGOS::PlayerSearcher<MaNGOS::AnyPlayerInObjectRangeCheck>  checker(this,p_ok, p_check);

                    CellLock<GridReadGuard> cell_lock(cell, p);

                    TypeContainerVisitor<Trinity::PlayerSearcher<Trinity::AnyPlayerInObjectRangeCheck>, WorldTypeMapContainer > world_object_checker(checker);
                    cell_lock->Visit(cell_lock, world_object_checker, *GetMap());
                    ok = p_ok;
                }

                if (ok)
                {
                    //Unit *caster =  owner ? owner : ok;

                    CastSpell(ok, goInfo->trap.spellId);
                    //caster->CastSpell(ok, goInfo->trap.spellId, true, 0, 0, GetGUID());
                    m_cooldownTime = time(NULL) + 4;        // 4 seconds

                    if(NeedDespawn)
                        SetLootState(GO_JUST_DEACTIVATED);  // can be despawned or destroyed

                    if(IsBattleGroundTrap && ok->GetTypeId() == TYPEID_PLAYER)
                    {
                        //BattleGround gameobjects case
                        if(((Player*)ok)->InBattleGround())
                            if(BattleGround *bg = ((Player*)ok)->GetBattleGround())
                                bg->HandleTriggerBuff(GetGUID());
                    }
                }
            }

            if (m_charges && m_usetimes >= m_charges)
                SetLootState(GO_JUST_DEACTIVATED);          // can be despawned or destroyed

            break;
        }
        case GO_ACTIVATED:
        {
            switch(GetGoType())
            {
                case GAMEOBJECT_TYPE_DOOR:
                case GAMEOBJECT_TYPE_BUTTON:
                    if(GetAutoCloseTime() && (m_cooldownTime < time(NULL)))
                    {
                        SwitchDoorOrButton(false);
                        SetLootState(GO_JUST_DEACTIVATED);
                    }
                    break;
            }
            break;
        }
        case GO_JUST_DEACTIVATED:
        {
            //if Gameobject should cast spell, then this, but some GOs (type = 10) should be destroyed
            if (GetGoType() == GAMEOBJECT_TYPE_GOOBER)
            {
                uint32 spellId = GetGOInfo()->goober.spellId;

                if(spellId)
                {
                    std::set<uint32>::iterator it = m_unique_users.begin();
                    std::set<uint32>::iterator end = m_unique_users.end();
                    for (; it != end; it++)
                    {
                        Unit* owner = Unit::GetUnit(*this, uint64(*it));
                        if (owner) owner->CastSpell(owner, spellId, false, 0, 0, GetGUID());
                    }

                    m_unique_users.clear();
                    m_usetimes = 0;
                }
                //any return here in case battleground traps
            }

            if(GetOwnerGUID())
            {
                m_respawnTime = 0;
                Delete();
                return;
            }

            //burning flags in some battlegrounds, if you find better condition, just add it
            if (GetGoAnimProgress() > 0)
            {
                SendObjectDeSpawnAnim(GetGUID());
                //reset flags
                SetUInt32Value(GAMEOBJECT_FLAGS, GetGOInfo()->flags);
            }

            loot.clear();
            SetLootState(GO_READY);

            if(!m_respawnDelayTime)
                return;

            if(!m_spawnedByDefault)
            {
                m_respawnTime = 0;
                return;
            }

            m_respawnTime = time(NULL) + m_respawnDelayTime;

            // if option not set then object will be saved at grid unload
            if(sWorld.getConfig(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY))
                SaveRespawnTime();

            ObjectAccessor::UpdateObjectVisibility(this);

            break;
        }
    }
}

void GameObject::Refresh()
{
    // not refresh despawned not casted GO (despawned casted GO destroyed in all cases anyway)
    if(m_respawnTime > 0 && m_spawnedByDefault)
        return;

    if(isSpawned())
        GetMap()->Add(this);
}

void GameObject::AddUniqueUse(Player* player)
{
    AddUse();
    m_unique_users.insert(player->GetGUIDLow());
}

void GameObject::Delete()
{
    SendObjectDeSpawnAnim(GetGUID());

    SetGoState(1);
    SetUInt32Value(GAMEOBJECT_FLAGS, GetGOInfo()->flags);

    uint16 poolid = poolhandler.IsPartOfAPool(GetGUIDLow(), TYPEID_GAMEOBJECT);
    if (poolid)
        poolhandler.UpdatePool(poolid, GetGUIDLow(), TYPEID_GAMEOBJECT);
    else
        AddObjectToRemoveList();
}

void GameObject::getFishLoot(Loot *fishloot, Player* loot_owner)
{
    fishloot->clear();

    uint32 zone, subzone;
    GetZoneAndAreaId(zone,subzone);

    // if subzone loot exist use it
    if(LootTemplates_Fishing.HaveLootFor(subzone))
        fishloot->FillLoot(subzone, LootTemplates_Fishing, loot_owner,true);
    // else use zone loot
    else
        fishloot->FillLoot(zone, LootTemplates_Fishing, loot_owner,true);
}

void GameObject::SaveToDB()
{
    // this should only be used when the gameobject has already been loaded
    // preferably after adding to map, because mapid may not be valid otherwise
    GameObjectData const *data = objmgr.GetGOData(m_DBTableGuid);
    if(!data)
    {
        sLog.outError("GameObject::SaveToDB failed, cannot get gameobject data!");
        return;
    }

    SaveToDB(GetMapId(), data->spawnMask, data->phaseMask);
}

void GameObject::SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask)
{
    const GameObjectInfo *goI = GetGOInfo();

    if (!goI)
        return;

    if (!m_DBTableGuid)
        m_DBTableGuid = GetGUIDLow();
    // update in loaded data (changing data only in this place)
    GameObjectData& data = objmgr.NewGOData(m_DBTableGuid);

    // data->guid = guid don't must be update at save
    data.id = GetEntry();
    data.mapid = mapid;
    data.phaseMask = phaseMask;
    data.posX = GetFloatValue(GAMEOBJECT_POS_X);
    data.posY = GetFloatValue(GAMEOBJECT_POS_Y);
    data.posZ = GetFloatValue(GAMEOBJECT_POS_Z);
    data.orientation = GetFloatValue(GAMEOBJECT_FACING);
    data.rotation0 = GetFloatValue(GAMEOBJECT_PARENTROTATION+0);
    data.rotation1 = GetFloatValue(GAMEOBJECT_PARENTROTATION+1);
    data.rotation2 = GetFloatValue(GAMEOBJECT_PARENTROTATION+2);
    data.rotation3 = GetFloatValue(GAMEOBJECT_PARENTROTATION+3);
    data.spawntimesecs = m_spawnedByDefault ? m_respawnDelayTime : -(int32)m_respawnDelayTime;
    data.animprogress = GetGoAnimProgress();
    data.go_state = GetGoState();
    data.spawnMask = spawnMask;
    data.ArtKit = GetGoArtKit();

    // updated in DB
    std::ostringstream ss;
    ss << "INSERT INTO gameobject VALUES ( "
        << m_DBTableGuid << ", "
        << GetEntry() << ", "
        << mapid << ", "
        << uint32(spawnMask) << ","                         // cast to prevent save as symbol
        << uint16(GetPhaseMask()) << ","                    // prevent out of range error
        << GetFloatValue(GAMEOBJECT_POS_X) << ", "
        << GetFloatValue(GAMEOBJECT_POS_Y) << ", "
        << GetFloatValue(GAMEOBJECT_POS_Z) << ", "
        << GetFloatValue(GAMEOBJECT_FACING) << ", "
        << GetFloatValue(GAMEOBJECT_PARENTROTATION) << ", "
        << GetFloatValue(GAMEOBJECT_PARENTROTATION+1) << ", "
        << GetFloatValue(GAMEOBJECT_PARENTROTATION+2) << ", "
        << GetFloatValue(GAMEOBJECT_PARENTROTATION+3) << ", "
        << m_respawnDelayTime << ", "
        << (uint32)GetGoAnimProgress() << ", "
        << (uint32)GetGoState() << ")";

    WorldDatabase.BeginTransaction();
    WorldDatabase.PExecuteLog("DELETE FROM gameobject WHERE guid = '%u'", m_DBTableGuid);
    WorldDatabase.PExecuteLog( ss.str( ).c_str( ) );
    WorldDatabase.CommitTransaction();
}

bool GameObject::LoadFromDB(uint32 guid, Map *map)
{
    GameObjectData const* data = objmgr.GetGOData(guid);

    if( !data )
    {
        sLog.outErrorDb("ERROR: Gameobject (GUID: %u) not found in table `gameobject`, can't load. ",guid);
        return false;
    }

    uint32 entry = data->id;
    //uint32 map_id = data->mapid;                          // already used before call
    uint32 phaseMask = data->phaseMask;
    float x = data->posX;
    float y = data->posY;
    float z = data->posZ;
    float ang = data->orientation;

    float rotation0 = data->rotation0;
    float rotation1 = data->rotation1;
    float rotation2 = data->rotation2;
    float rotation3 = data->rotation3;

    uint32 animprogress = data->animprogress;
    uint32 go_state = data->go_state;
    uint32 ArtKit = data->ArtKit;

    m_DBTableGuid = guid;
    if (map->GetInstanceId() != 0) guid = objmgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT);

    if (!Create(guid,entry, map, phaseMask, x, y, z, ang, rotation0, rotation1, rotation2, rotation3, animprogress, go_state, ArtKit) )
        return false;

    switch(GetGOInfo()->type)
    {
        case GAMEOBJECT_TYPE_DOOR:
        case GAMEOBJECT_TYPE_BUTTON:
            /* this code (in comment) isn't correct because in battlegrounds we need despawnable doors and buttons, pls remove
            SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NODESPAWN);
            m_spawnedByDefault = true;
            m_respawnDelayTime = 0;
            m_respawnTime = 0;
            break;*/
        default:
            if(data->spawntimesecs >= 0)
            {
                m_spawnedByDefault = true;
                m_respawnDelayTime = data->spawntimesecs;
                m_respawnTime = objmgr.GetGORespawnTime(m_DBTableGuid, map->GetInstanceId());

                                                            // ready to respawn
                if(m_respawnTime && m_respawnTime <= time(NULL))
                {
                    m_respawnTime = 0;
                    objmgr.SaveGORespawnTime(m_DBTableGuid,GetInstanceId(),0);
                }
            }
            else
            {
                m_spawnedByDefault = false;
                m_respawnDelayTime = -data->spawntimesecs;
                m_respawnTime = 0;
            }
            break;
    }

    return true;
}

void GameObject::DeleteFromDB()
{
    objmgr.SaveGORespawnTime(m_DBTableGuid,GetInstanceId(),0);
    objmgr.DeleteGOData(m_DBTableGuid);
    WorldDatabase.PExecuteLog("DELETE FROM gameobject WHERE guid = '%u'", m_DBTableGuid);
    WorldDatabase.PExecuteLog("DELETE FROM game_event_gameobject WHERE guid = '%u'", m_DBTableGuid);
}

GameObject* GameObject::GetGameObject(WorldObject& object, uint64 guid)
{
    return ObjectAccessor::GetGameObject(object,guid);
}

GameObjectInfo const *GameObject::GetGOInfo() const
{
    return m_goInfo;
}

uint32 GameObject::GetLootId(GameObjectInfo const* ginfo)
{
    if (!ginfo)
        return 0;

    switch(ginfo->type)
    {
        case GAMEOBJECT_TYPE_CHEST:
            return ginfo->chest.lootId;
        case GAMEOBJECT_TYPE_FISHINGHOLE:
            return ginfo->fishinghole.lootId;
        case GAMEOBJECT_TYPE_FISHINGNODE:
            return ginfo->fishnode.lootId;
        default:
            return 0;
    }
}

/*********************************************************/
/***                    QUEST SYSTEM                   ***/
/*********************************************************/
bool GameObject::hasQuest(uint32 quest_id) const
{
    QuestRelations const& qr = objmgr.mGOQuestRelations;
    for(QuestRelations::const_iterator itr = qr.lower_bound(GetEntry()); itr != qr.upper_bound(GetEntry()); ++itr)
    {
        if(itr->second==quest_id)
            return true;
    }
    return false;
}

bool GameObject::hasInvolvedQuest(uint32 quest_id) const
{
    QuestRelations const& qr = objmgr.mGOQuestInvolvedRelations;
    for(QuestRelations::const_iterator itr = qr.lower_bound(GetEntry()); itr != qr.upper_bound(GetEntry()); ++itr)
    {
        if(itr->second==quest_id)
            return true;
    }
    return false;
}

bool GameObject::IsTransport() const
{
    // If something is marked as a transport, don't transmit an out of range packet for it.
    GameObjectInfo const * gInfo = GetGOInfo();
    if(!gInfo) return false;
    return gInfo->type == GAMEOBJECT_TYPE_TRANSPORT || gInfo->type == GAMEOBJECT_TYPE_MO_TRANSPORT;
}

Unit* GameObject::GetOwner() const
{
    return ObjectAccessor::GetUnit(*this, GetOwnerGUID());
}

void GameObject::SaveRespawnTime()
{
    if(m_respawnTime > time(NULL) && m_spawnedByDefault)
        objmgr.SaveGORespawnTime(m_DBTableGuid,GetInstanceId(),m_respawnTime);
}

bool GameObject::isVisibleForInState(Player const* u, bool inVisibleList) const
{
    // Not in world
    if(!IsInWorld() || !u->IsInWorld())
        return false;

    // Transport always visible at this step implementation
    if(IsTransport() && IsInMap(u))
        return true;

    // quick check visibility false cases for non-GM-mode
    if(!u->isGameMaster())
    {
        // despawned and then not visible for non-GM in GM-mode
        if(!isSpawned())
            return false;

        // special invisibility cases
        if(GetGOInfo()->type == GAMEOBJECT_TYPE_TRAP && GetGOInfo()->trap.stealthed)
        {
            Unit *owner = GetOwner();
            if(owner && u->IsHostileTo(owner) && !canDetectTrap(u, GetDistance(u)))
                return false;
        }
    }

    // check distance
    return IsWithinDistInMap(u->m_seer,World::GetMaxVisibleDistanceForObject() +
        (inVisibleList ? World::GetVisibleObjectGreyDistance() : 0.0f), false);
}

bool GameObject::canDetectTrap(Player const* u, float distance) const
{
    if(u->hasUnitState(UNIT_STAT_STUNNED))
        return false;
    if(distance < GetGOInfo()->size) //collision
        return true;
    if(!u->HasInArc(M_PI, this)) //behind
        return false;
    if(u->HasAuraType(SPELL_AURA_DETECT_STEALTH))
        return true;

    //Visible distance is modified by -Level Diff (every level diff = 0.25f in visible distance)
    float visibleDistance = (int32(u->getLevel()) - int32(GetOwner()->getLevel()))* 0.25f;
    //GetModifier for trap (miscvalue 1)
    //35y for aura 2836
    //WARNING: these values are guessed, may be not blizzlike
    visibleDistance += u->GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_DETECT, 1)* 0.5f;

    return distance < visibleDistance;
}

void GameObject::Respawn()
{
    if(m_spawnedByDefault && m_respawnTime > 0)
    {
        m_respawnTime = time(NULL);
        objmgr.SaveGORespawnTime(m_DBTableGuid,GetInstanceId(),0);
    }
}

bool GameObject::ActivateToQuest( Player *pTarget)const
{
    if(!objmgr.IsGameObjectForQuests(GetEntry()))
        return false;

    switch(GetGoType())
    {
        // scan GO chest with loot including quest items
        case GAMEOBJECT_TYPE_CHEST:
        {
            if(LootTemplates_Gameobject.HaveQuestLootForPlayer(GetLootId(), pTarget))
            {
                //TODO: fix this hack
                //look for battlegroundAV for some objects which are only activated after mine gots captured by own team
                if(GetEntry() == BG_AV_OBJECTID_MINE_N || GetEntry() == BG_AV_OBJECTID_MINE_S)
                    if(BattleGround *bg = pTarget->GetBattleGround())
                        if(bg->GetTypeID() == BATTLEGROUND_AV && !(((BattleGroundAV*)bg)->PlayerCanDoMineQuest(GetEntry(),pTarget->GetTeam())))
                            return false;
                return true;
            }
            break;
        }
        case GAMEOBJECT_TYPE_GOOBER:
        {
            if(pTarget->GetQuestStatus(GetGOInfo()->goober.questId) == QUEST_STATUS_INCOMPLETE)
                return true;
            break;
        }
        default:
            break;
    }

    return false;
}

void GameObject::TriggeringLinkedGameObject( uint32 trapEntry, Unit* target)
{
    GameObjectInfo const* trapInfo = sGOStorage.LookupEntry<GameObjectInfo>(trapEntry);
    if(!trapInfo || trapInfo->type!=GAMEOBJECT_TYPE_TRAP)
        return;

    SpellEntry const* trapSpell = sSpellStore.LookupEntry(trapInfo->trap.spellId);
    if(!trapSpell)                                          // checked at load already
        return;

    float range;
    SpellRangeEntry const * srentry = sSpellRangeStore.LookupEntry(trapSpell->rangeIndex);
    //get owner to check hostility of GameObject
    if (GetSpellMaxRangeForHostile(srentry) == GetSpellMaxRangeForHostile(srentry))
        range = GetSpellMaxRangeForHostile(srentry);
    else
    {
        Unit * owner=GetOwner();
        if (owner)
            range = owner->GetSpellMaxRangeForTarget(target, srentry);
        else
            //if no owner assume that object is hostile to target
            range = GetSpellMaxRangeForHostile(srentry);
    }

    // search nearest linked GO
    GameObject* trapGO = NULL;
    {
        // using original GO distance
        CellPair p(Trinity::ComputeCellPair(GetPositionX(), GetPositionY()));
        Cell cell(p);
        cell.data.Part.reserved = ALL_DISTRICT;

        MaNGOS::NearestGameObjectEntryInObjectRangeCheck go_check(*target,trapEntry,range);
        MaNGOS::GameObjectLastSearcher<MaNGOS::NearestGameObjectEntryInObjectRangeCheck> checker(this, trapGO,go_check);

        TypeContainerVisitor<Trinity::GameObjectLastSearcher<Trinity::NearestGameObjectEntryInObjectRangeCheck>, GridTypeMapContainer > object_checker(checker);
        CellLock<GridReadGuard> cell_lock(cell, p);
        cell_lock->Visit(cell_lock, object_checker, *GetMap());
    }

    // found correct GO
    // FIXME: when GO casting will be implemented trap must cast spell to target
    if(trapGO)
        target->CastSpell(target,trapSpell,true, 0, 0, GetGUID());
}

GameObject* GameObject::LookupFishingHoleAround(float range)
{
    GameObject* ok = NULL;

    CellPair p(Trinity::ComputeCellPair(GetPositionX(),GetPositionY()));
    Cell cell(p);
    cell.data.Part.reserved = ALL_DISTRICT;
    MaNGOS::NearestGameObjectFishingHole u_check(*this, range);
    MaNGOS::GameObjectSearcher<MaNGOS::NearestGameObjectFishingHole> checker(this, ok, u_check);

    CellLock<GridReadGuard> cell_lock(cell, p);

    TypeContainerVisitor<Trinity::GameObjectSearcher<Trinity::NearestGameObjectFishingHole>, GridTypeMapContainer > grid_object_checker(checker);
    cell_lock->Visit(cell_lock, grid_object_checker, *GetMap());

    return ok;
}

void GameObject::UseDoorOrButton(uint32 time_to_restore)
{
    if(m_lootState != GO_READY)
        return;

    if(!time_to_restore)
        time_to_restore = GetAutoCloseTime();

    SwitchDoorOrButton(true);
    SetLootState(GO_ACTIVATED);

    m_cooldownTime = time(NULL) + time_to_restore;

}

void GameObject::SetGoArtKit(uint8 kit)
{
    SetByteValue(GAMEOBJECT_BYTES_1, 2, kit);
    GameObjectData *data = const_cast<GameObjectData*>(objmgr.GetGOData(m_DBTableGuid));
    if(data)
        data->ArtKit = kit;
}

void GameObject::SwitchDoorOrButton(bool activate)
{
    if(activate)
        SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
    else
        RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);

    if(GetGoState())                                        //if closed -> open
        SetGoState(0);
    else                                                    //if open -> close
        SetGoState(1);
}

void GameObject::Use(Unit* user)
{
    // by default spell caster is user
    Unit* spellCaster = user;
    uint32 spellId = 0;
    bool triggered = false;

    switch(GetGoType())
    {
        case GAMEOBJECT_TYPE_DOOR:                          //0
        case GAMEOBJECT_TYPE_BUTTON:                        //1
            //doors/buttons never really despawn, only reset to default state/flags
            UseDoorOrButton();

            // activate script
            sWorld.ScriptsStart(sGameObjectScripts, GetDBTableGUIDLow(), spellCaster, this);
            return;

        case GAMEOBJECT_TYPE_QUESTGIVER:                    //2
        {
            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            player->PrepareQuestMenu( GetGUID() );
            player->SendPreparedQuest( GetGUID() );
            return;
        }
        //Sitting: Wooden bench, chairs enzz
        case GAMEOBJECT_TYPE_CHAIR:                         //7
        {
            GameObjectInfo const* info = GetGOInfo();
            if(!info)
                return;

            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            // a chair may have n slots. we have to calculate their positions and teleport the player to the nearest one

            // check if the db is sane
            if(info->chair.slots > 0)
            {
                float lowestDist = DEFAULT_VISIBILITY_DISTANCE;

                float x_lowest = GetPositionX();
                float y_lowest = GetPositionY();

                // the object orientation + 1/2 pi
                // every slot will be on that straight line
                float orthogonalOrientation = GetOrientation()+M_PI*0.5f;
                // find nearest slot
                for(uint32 i=0; i<info->chair.slots; i++)
                {
                    // the distance between this slot and the center of the go - imagine a 1D space
                    float relativeDistance = (info->size*i)-(info->size*(info->chair.slots-1)/2.0f);

                    float x_i = GetPositionX() + relativeDistance * cos(orthogonalOrientation);
                    float y_i = GetPositionY() + relativeDistance * sin(orthogonalOrientation);

                    // calculate the distance between the player and this slot
                    float thisDistance = player->GetDistance2d(x_i, y_i);

                    /* debug code. It will spawn a npc on each slot to visualize them.
                    Creature* helper = player->SummonCreature(14496, x_i, y_i, GetPositionZ(), GetOrientation(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 10000);
                    std::ostringstream output;
                    output << i << ": thisDist: " << thisDistance;
                    helper->MonsterSay(output.str().c_str(), LANG_UNIVERSAL, 0);
                    */

                    if(thisDistance <= lowestDist)
                    {
                        lowestDist = thisDistance;
                        x_lowest = x_i;
                        y_lowest = y_i;
                    }
                }
                player->TeleportTo(GetMapId(), x_lowest, y_lowest, GetPositionZ(), GetOrientation(),TELE_TO_NOT_LEAVE_TRANSPORT | TELE_TO_NOT_LEAVE_COMBAT | TELE_TO_NOT_UNSUMMON_PET);
            }
            else
            {
                // fallback, will always work
                player->TeleportTo(GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation(),TELE_TO_NOT_LEAVE_TRANSPORT | TELE_TO_NOT_LEAVE_COMBAT | TELE_TO_NOT_UNSUMMON_PET);
            }
            player->SetStandState(UNIT_STAND_STATE_SIT_LOW_CHAIR+info->chair.height);
            return;
        }
        //big gun, its a spell/aura
        case GAMEOBJECT_TYPE_GOOBER:                        //10
        {
            GameObjectInfo const* info = GetGOInfo();

            if(user->GetTypeId()==TYPEID_PLAYER)
            {
                Player* player = (Player*)user;

                // show page
                if(info->goober.pageId)
                {
                    WorldPacket data(SMSG_GAMEOBJECT_PAGETEXT, 8);
                    data << GetGUID();
                    player->GetSession()->SendPacket(&data);
                }

                // possible quest objective for active quests
                player->CastedCreatureOrGO(info->id, GetGUID(), 0);
            }

            // cast this spell later if provided
            spellId = info->goober.spellId;

            break;
        }
        case GAMEOBJECT_TYPE_CAMERA:                        //13
        {
            GameObjectInfo const* info = GetGOInfo();
            if(!info)
                return;

            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            if(info->camera.cinematicId)
            {
                WorldPacket data(SMSG_TRIGGER_CINEMATIC, 4);
                data << info->camera.cinematicId;
                player->GetSession()->SendPacket(&data);
            }
            return;
        }
        //fishing bobber
        case GAMEOBJECT_TYPE_FISHINGNODE:                   //17
        {
            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            if(player->GetGUID() != GetOwnerGUID())
                return;

            switch(getLootState())
            {
                case GO_READY:                              // ready for loot
                {
                    // 1) skill must be >= base_zone_skill
                    // 2) if skill == base_zone_skill => 5% chance
                    // 3) chance is linear dependence from (base_zone_skill-skill)

                    uint32 zone, subzone;
                    GetZoneAndAreaId(zone,subzone);

                    int32 zone_skill = objmgr.GetFishingBaseSkillLevel( subzone );
                    if(!zone_skill)
                        zone_skill = objmgr.GetFishingBaseSkillLevel( zone );

                    //provide error, no fishable zone or area should be 0
                    if(!zone_skill)
                        sLog.outErrorDb("Fishable areaId %u are not properly defined in `skill_fishing_base_level`.",subzone);

                    int32 skill = player->GetSkillValue(SKILL_FISHING);
                    int32 chance = skill - zone_skill + 5;
                    int32 roll = irand(1,100);

                    DEBUG_LOG("Fishing check (skill: %i zone min skill: %i chance %i roll: %i",skill,zone_skill,chance,roll);

                    if(skill >= zone_skill && chance >= roll)
                    {
                        // prevent removing GO at spell cancel
                        player->RemoveGameObject(this,false);
                        SetOwnerGUID(player->GetGUID());

                        //fish catched
                        player->UpdateFishingSkill();

                        GameObject* ok = LookupFishingHoleAround(DEFAULT_VISIBILITY_DISTANCE);
                        if (ok)
                        {
                            player->SendLoot(ok->GetGUID(),LOOT_FISHINGHOLE);
                            SetLootState(GO_JUST_DEACTIVATED);
                        }
                        else
                            player->SendLoot(GetGUID(),LOOT_FISHING);
                    }
                    else
                    {
                        // fish escaped, can be deleted now
                        SetLootState(GO_JUST_DEACTIVATED);

                        WorldPacket data(SMSG_FISH_ESCAPED, 0);
                        player->GetSession()->SendPacket(&data);
                    }
                    break;
                }
                case GO_JUST_DEACTIVATED:                   // nothing to do, will be deleted at next update
                    break;
                default:
                {
                    SetLootState(GO_JUST_DEACTIVATED);

                    WorldPacket data(SMSG_FISH_NOT_HOOKED, 0);
                    player->GetSession()->SendPacket(&data);
                    break;
                }
            }

            if(player->m_currentSpells[CURRENT_CHANNELED_SPELL])
            {
                player->m_currentSpells[CURRENT_CHANNELED_SPELL]->SendChannelUpdate(0);
                player->m_currentSpells[CURRENT_CHANNELED_SPELL]->finish();
            }
            return;
        }

        case GAMEOBJECT_TYPE_SUMMONING_RITUAL:              //18
        {
            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            Unit* caster = GetOwner();

            GameObjectInfo const* info = GetGOInfo();

            if( !caster || caster->GetTypeId()!=TYPEID_PLAYER )
                return;

            // accept only use by player from same group for caster except caster itself
            if(((Player*)caster)==player || !((Player*)caster)->IsInSameRaidWith(player))
                return;

            AddUniqueUse(player);

            // full amount unique participants including original summoner
            if(GetUniqueUseCount() < info->summoningRitual.reqParticipants)
                return;

            // in case summoning ritual caster is GO creator
            spellCaster = caster;

            if(!caster->m_currentSpells[CURRENT_CHANNELED_SPELL])
                return;

            spellId = info->summoningRitual.spellId;
            if(spellId==62330)                              // GO store not existed spell, replace by expected
            {
                // spell have reagent and mana cost but it not expected use its
                // it triggered spell in fact casted at currently channeled GO
                spellId = 61993;
                triggered = true;
            }

            // finish spell
            caster->m_currentSpells[CURRENT_CHANNELED_SPELL]->SendChannelUpdate(0);
            caster->m_currentSpells[CURRENT_CHANNELED_SPELL]->finish();

            // can be deleted now
            SetLootState(GO_JUST_DEACTIVATED);

            // go to end function to spell casting
            break;
        }
        case GAMEOBJECT_TYPE_SPELLCASTER:                   //22
        {
            SetUInt32Value(GAMEOBJECT_FLAGS,2);

            GameObjectInfo const* info = GetGOInfo();
            if(!info)
                return;

            if(info->spellcaster.partyOnly)
            {
                Unit* caster = GetOwner();
                if( !caster || caster->GetTypeId()!=TYPEID_PLAYER )
                    return;

                if(user->GetTypeId()!=TYPEID_PLAYER || !((Player*)user)->IsInSameRaidWith((Player*)caster))
                    return;
            }

            spellId = info->spellcaster.spellId;

            AddUse();
            break;
        }
        case GAMEOBJECT_TYPE_MEETINGSTONE:                  //23
        {
            GameObjectInfo const* info = GetGOInfo();

            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            Player* targetPlayer = ObjectAccessor::FindPlayer(player->GetSelection());

            // accept only use by player from same group for caster except caster itself
            if(!targetPlayer || targetPlayer == player || !targetPlayer->IsInSameGroupWith(player))
                return;

            //required lvl checks!
            uint8 level = player->getLevel();
            if (level < info->meetingstone.minLevel || level > info->meetingstone.maxLevel)
                return;
            level = targetPlayer->getLevel();
            if (level < info->meetingstone.minLevel || level > info->meetingstone.maxLevel)
                return;

            if(info->id==194097)
                spellId = 61994;                            // Ritual of Summoning
            else
                spellId = 59782;                            // Summoning Stone Effect

            break;
        }

        case GAMEOBJECT_TYPE_FLAGSTAND:                     // 24
        {
            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            if( player->CanUseBattleGroundObject() )
            {
                // in battleground check
                BattleGround *bg = player->GetBattleGround();
                if(!bg)
                    return;
                // BG flag click
                // AB:
                // 15001
                // 15002
                // 15003
                // 15004
                // 15005
                bg->EventPlayerClickedOnFlag(player, this);
                return;                                     //we don;t need to delete flag ... it is despawned!
            }
            break;
        }
        case GAMEOBJECT_TYPE_FLAGDROP:                      // 26
        {
            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            if( player->CanUseBattleGroundObject() )
            {
                // in battleground check
                BattleGround *bg = player->GetBattleGround();
                if(!bg)
                    return;
                // BG flag dropped
                // WS:
                // 179785 - Silverwing Flag
                // 179786 - Warsong Flag
                // EotS:
                // 184142 - Netherstorm Flag
                GameObjectInfo const* info = GetGOInfo();
                if(info)
                {
                    switch(info->id)
                    {
                        case 179785:                        // Silverwing Flag
                            // check if it's correct bg
                            if(bg->GetTypeID() == BATTLEGROUND_WS)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                        case 179786:                        // Warsong Flag
                            if(bg->GetTypeID() == BATTLEGROUND_WS)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                        case 184142:                        // Netherstorm Flag
                            if(bg->GetTypeID() == BATTLEGROUND_EY)
                                bg->EventPlayerClickedOnFlag(player, this);
                            break;
                    }
                }
                //this cause to call return, all flags must be deleted here!!
                spellId = 0;
                Delete();
            }
            break;
        }
        case GAMEOBJECT_TYPE_BARBER_CHAIR:                  //32
        {
            GameObjectInfo const* info = GetGOInfo();
            if(!info)
                return;

            if(user->GetTypeId()!=TYPEID_PLAYER)
                return;

            Player* player = (Player*)user;

            // fallback, will always work
            player->TeleportTo(GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation(),TELE_TO_NOT_LEAVE_TRANSPORT | TELE_TO_NOT_LEAVE_COMBAT | TELE_TO_NOT_UNSUMMON_PET);

            WorldPacket data(SMSG_ENABLE_BARBER_SHOP, 0);
            player->GetSession()->SendPacket(&data);

            player->SetStandState(UNIT_STAND_STATE_SIT_LOW_CHAIR+info->barberChair.chairheight);
            return;
        }
        default:
            sLog.outDebug("Unknown Object Type %u", GetGoType());
            break;
    }

    if(!spellId)
        return;

    SpellEntry const *spellInfo = sSpellStore.LookupEntry( spellId );
    if(!spellInfo)
    {
        if(user->GetTypeId()!=TYPEID_PLAYER || !sOutdoorPvPMgr.HandleCustomSpell((Player*)user,spellId,this))
            sLog.outError("WORLD: unknown spell id %u at use action for gameobject (Entry: %u GoType: %u )", spellId,GetEntry(),GetGoType());
        else
            sLog.outDebug("WORLD: %u non-dbc spell was handled by OutdoorPvP", spellId);
        return;
    }

    Spell *spell = new Spell(spellCaster, spellInfo, triggered);

    // spell target is user of GO
    SpellCastTargets targets;
    targets.setUnitTarget( user );

    spell->prepare(&targets);
}

void GameObject::CastSpell(Unit* target, uint32 spellId)
{
    SpellEntry const *spellInfo = sSpellStore.LookupEntry(spellId);
    if(!spellInfo)
        return;

    bool self = false;
    for(int i = 0; i < 3; ++i)
    {
        if(spellInfo->EffectImplicitTargetA[i] == TARGET_UNIT_CASTER)
        {
            self = true;
            break;
        }
    }

    if(self)
    {
        target->CastSpell(target, spellInfo, true);
        return;
    }

    //summon world trigger
    Creature *trigger = SummonTrigger(GetPositionX(), GetPositionY(), GetPositionZ(), 0, 1);
    if(!trigger) return;

    trigger->SetVisibility(VISIBILITY_OFF); //should this be true?
    if(Unit *owner = GetOwner())
    {
        trigger->setFaction(owner->getFaction());
        trigger->CastSpell(target, spellInfo, true, 0, 0, owner->GetGUID());
    }
    else
    {
        trigger->setFaction(14);
        trigger->CastSpell(target, spellInfo, true, 0, 0, target->GetGUID());
    }
    //trigger->setDeathState(JUST_DIED);
    //trigger->RemoveCorpse();
}

// overwrite WorldObject function for proper name localization
const char* GameObject::GetNameForLocaleIdx(int32 loc_idx) const
{
    if (loc_idx >= 0)
    {
        GameObjectLocale const *cl = objmgr.GetGameObjectLocale(GetEntry());
        if (cl)
        {
            if (cl->Name.size() > loc_idx && !cl->Name[loc_idx].empty())
                return cl->Name[loc_idx].c_str();
        }
    }

    return GetName();
}

void GameObject::UpdateRotationFields(float rotation2 /*=0.0f*/, float rotation3 /*=0.0f*/)
{
    SetFloatValue(GAMEOBJECT_FACING, GetOrientation());

    int64 rotation = 0;

    double f_rot1 = sin(GetOrientation() / 2.0f);
    int64 i_rot1 = int64(f_rot1 / atan(pow(2.0f, -20.0f)));
    rotation |= (i_rot1 << 43 >> 43) & 0x00000000001FFFFF;

    SetUInt64Value(GAMEOBJECT_ROTATION, rotation);

    if(rotation2==0.0f && rotation3==0.0f)
    {
        rotation2 = sin(GetOrientation()/2);
        rotation3 = cos(GetOrientation()/2);
    }

    SetFloatValue(GAMEOBJECT_PARENTROTATION+2, rotation2);
    SetFloatValue(GAMEOBJECT_PARENTROTATION+3, rotation3);
}
