/*
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

#include "OutdoorPvPSI.h"
#include "WorldPacket.h"
#include "Player.h"
#include "GameObject.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "Language.h"
#include "World.h"

OutdoorPvPSI::OutdoorPvPSI()
{
    m_TypeId = OUTDOOR_PVP_SI;
    m_Gathered_A = 0;
    m_Gathered_H = 0;
    m_LastController = 0;
}

void OutdoorPvPSI::FillInitialWorldStates(WorldPacket &data)
{
    data << SI_GATHERED_A << m_Gathered_A;
    data << SI_GATHERED_H << m_Gathered_H;
    data << SI_SILITHYST_MAX << SI_MAX_RESOURCES;
}

void OutdoorPvPSI::SendRemoveWorldStates(Player *plr)
{
    plr->SendUpdateWorldState(SI_GATHERED_A,0);
    plr->SendUpdateWorldState(SI_GATHERED_H,0);
    plr->SendUpdateWorldState(SI_SILITHYST_MAX,0);
}

void OutdoorPvPSI::UpdateWorldState()
{
    SendUpdateWorldState(SI_GATHERED_A,m_Gathered_A);
    SendUpdateWorldState(SI_GATHERED_H,m_Gathered_H);
    SendUpdateWorldState(SI_SILITHYST_MAX,SI_MAX_RESOURCES);
}

bool OutdoorPvPSI::SetupOutdoorPvP()
{
    for(int i = 0; i < OutdoorPvPSIBuffZonesNum; ++i)
        sOutdoorPvPMgr.AddZone(OutdoorPvPSIBuffZones[i],this);
    return true;
}

bool OutdoorPvPSI::Update(uint32 diff)
{
    return false;
}

void OutdoorPvPSI::HandlePlayerEnterZone(Player * plr, uint32 zone)
{
    if(plr->GetTeam() == m_LastController)
        plr->CastSpell(plr,SI_CENARION_FAVOR,true);
    OutdoorPvP::HandlePlayerEnterZone(plr,zone);
}

void OutdoorPvPSI::HandlePlayerLeaveZone(Player * plr, uint32 zone)
{
    // remove buffs
    plr->RemoveAurasDueToSpell(SI_CENARION_FAVOR);
    OutdoorPvP::HandlePlayerLeaveZone(plr, zone);
}

void OutdoorPvPSI::BuffTeam(uint32 team)
{
    if(team == ALLIANCE)
    {
        for(std::set<uint64>::iterator itr = m_PlayerGuids[0].begin(); itr != m_PlayerGuids[0].end(); ++itr)
        {
            if(Player * plr = objmgr.GetPlayer(*itr))
                if(plr->IsInWorld()) plr->CastSpell(plr,SI_CENARION_FAVOR,true);
        }
        for(std::set<uint64>::iterator itr = m_PlayerGuids[1].begin(); itr != m_PlayerGuids[1].end(); ++itr)
        {
            if(Player * plr = objmgr.GetPlayer(*itr))
                if(plr->IsInWorld()) plr->RemoveAurasDueToSpell(SI_CENARION_FAVOR);
        }
    }
    else if(team == HORDE)
    {
        for(std::set<uint64>::iterator itr = m_PlayerGuids[1].begin(); itr != m_PlayerGuids[1].end(); ++itr)
        {
            if(Player * plr = objmgr.GetPlayer(*itr))
                if(plr->IsInWorld()) plr->CastSpell(plr,SI_CENARION_FAVOR,true);
        }
        for(std::set<uint64>::iterator itr = m_PlayerGuids[0].begin(); itr != m_PlayerGuids[0].end(); ++itr)
        {
            if(Player * plr = objmgr.GetPlayer(*itr))
                if(plr->IsInWorld()) plr->RemoveAurasDueToSpell(SI_CENARION_FAVOR);
        }
    }
    else
    {
        for(std::set<uint64>::iterator itr = m_PlayerGuids[0].begin(); itr != m_PlayerGuids[0].end(); ++itr)
        {
            if(Player * plr = objmgr.GetPlayer(*itr))
                if(plr->IsInWorld()) plr->RemoveAurasDueToSpell(SI_CENARION_FAVOR);
        }
        for(std::set<uint64>::iterator itr = m_PlayerGuids[1].begin(); itr != m_PlayerGuids[1].end(); ++itr)
        {
            if(Player * plr = objmgr.GetPlayer(*itr))
                if(plr->IsInWorld()) plr->RemoveAurasDueToSpell(SI_CENARION_FAVOR);
        }
    }
}

bool OutdoorPvPSI::HandleAreaTrigger(Player *plr, uint32 trigger)
{
    switch(trigger)
    {
    case SI_AREATRIGGER_A:
        if(plr->GetTeam() == ALLIANCE && plr->HasAura(SI_SILITHYST_FLAG,0))
        {
            // remove aura
            plr->RemoveAurasDueToSpell(SI_SILITHYST_FLAG);
            ++ m_Gathered_A;
            if(m_Gathered_A >= SI_MAX_RESOURCES)
            {
                BuffTeam(ALLIANCE);
                sWorld.SendZoneText(OutdoorPvPSIBuffZones[0],objmgr.GetTrinityStringForDBCLocale(LANG_OPVP_SI_CAPTURE_A));
                m_LastController = ALLIANCE;
                m_Gathered_A = 0;
                m_Gathered_H = 0;
            }
            UpdateWorldState();
            // reward player
            plr->CastSpell(plr,SI_TRACES_OF_SILITHYST,true);
            // add 19 honor
            plr->RewardHonor(NULL,1,19);
            // add 20 cenarion circle repu
            plr->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(609),20);
            // complete quest
            plr->KilledMonster(SI_TURNIN_QUEST_CM_A,0);
        }
        return true;
    case SI_AREATRIGGER_H:
        if(plr->GetTeam() == HORDE && plr->HasAura(SI_SILITHYST_FLAG,0))
        {
            // remove aura
            plr->RemoveAurasDueToSpell(SI_SILITHYST_FLAG);
            ++ m_Gathered_H;
            if(m_Gathered_H >= SI_MAX_RESOURCES)
            {
                BuffTeam(HORDE);
                sWorld.SendZoneText(OutdoorPvPSIBuffZones[0],objmgr.GetTrinityStringForDBCLocale(LANG_OPVP_SI_CAPTURE_H));
                m_LastController = HORDE;
                m_Gathered_A = 0;
                m_Gathered_H = 0;
            }
            UpdateWorldState();
            // reward player
            plr->CastSpell(plr,SI_TRACES_OF_SILITHYST,true);
            // add 19 honor
            plr->RewardHonor(NULL,1,19);
            // add 20 cenarion circle repu
            plr->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(609),20);
            // complete quest
            plr->KilledMonster(SI_TURNIN_QUEST_CM_H,0);
        }
        return true;
    }
    return false;
}

bool OutdoorPvPSI::HandleDropFlag(Player *plr, uint32 spellId)
{
    if(spellId == SI_SILITHYST_FLAG)
    {
        // if it was dropped away from the player's turn-in point, then create a silithyst mound, if it was dropped near the areatrigger, then it was dispelled by the outdoorpvp, so do nothing
        switch(plr->GetTeam())
        {
        case ALLIANCE:
            {
                AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(SI_AREATRIGGER_A);
                if(atEntry)
                {
                    // 5.0f is safe-distance
                    if(plr->GetDistance(atEntry->x,atEntry->y,atEntry->z) > 5.0f + atEntry->radius)
                    {
                        // he dropped it further, summon mound
                        GameObject * go = new GameObject;
                        Map * map = MapManager::Instance().GetMap(plr->GetMapId(), plr);
                        if(!map)
                            return true;
                        if(!go->Create(objmgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT),SI_SILITHYST_MOUND, map, plr->GetPhaseMask(), plr->GetPositionX(),plr->GetPositionY(),plr->GetPositionZ(),plr->GetOrientation(),0,0,0,0,100,1))
                        {
                            delete go;
                        }
                        else
                        {
                            go->SetRespawnTime(0);
                            map->Add(go);
                        }
                    }
                }
            }
            break;
        case HORDE:
            {
                AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(SI_AREATRIGGER_H);
                if(atEntry)
                {
                    // 5.0f is safe-distance
                    if(plr->GetDistance(atEntry->x,atEntry->y,atEntry->z) > 5.0f + atEntry->radius)
                    {
                        // he dropped it further, summon mound
                        GameObject * go = new GameObject;
                        Map * map = MapManager::Instance().GetMap(plr->GetMapId(), plr);
                        if(!map)
                            return true;
                        if(!go->Create(objmgr.GenerateLowGuid(HIGHGUID_GAMEOBJECT),SI_SILITHYST_MOUND, map, plr->GetPhaseMask() ,plr->GetPositionX(),plr->GetPositionY(),plr->GetPositionZ(),plr->GetOrientation(),0,0,0,0,100,1))
                        {
                            delete go;
                        }
                        else
                        {
                            go->SetRespawnTime(0);
                            map->Add(go);
                        }
                    }
                }
            }
            break;
        }
        return true;
    }
    return false;
}

bool OutdoorPvPSI::HandleCustomSpell(Player *plr, uint32 spellId, GameObject *go)
{
    if(!go || spellId != SI_SILITHYST_FLAG_GO_SPELL)
        return false;
    plr->CastSpell(plr,SI_SILITHYST_FLAG,true);
    if(go->GetGOInfo()->id == SI_SILITHYST_MOUND)
    {
        // despawn go
        go->SetRespawnTime(0);
        go->Delete();
    }
    return true;
}

