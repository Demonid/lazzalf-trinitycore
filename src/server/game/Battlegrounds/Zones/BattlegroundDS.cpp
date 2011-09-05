/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#include "Battleground.h"
#include "BattlegroundDS.h"
#include "Language.h"
#include "Player.h"
#include "Object.h"
#include "ObjectMgr.h"
#include "WorldPacket.h"

BattlegroundDS::BattlegroundDS()
{
    m_BgObjects.resize(BG_DS_OBJECT_MAX);

    m_StartDelayTimes[BG_STARTING_EVENT_FIRST]  = BG_START_DELAY_1M;
    m_StartDelayTimes[BG_STARTING_EVENT_SECOND] = BG_START_DELAY_30S;
    m_StartDelayTimes[BG_STARTING_EVENT_THIRD]  = BG_START_DELAY_15S;
    m_StartDelayTimes[BG_STARTING_EVENT_FOURTH] = BG_START_DELAY_NONE;
    //we must set messageIds
    m_StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_ARENA_ONE_MINUTE;
    m_StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_ARENA_THIRTY_SECONDS;
    m_StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_ARENA_FIFTEEN_SECONDS;
    m_StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_ARENA_HAS_BEGUN;

    m_knockback = BG_DS_KNOCKBACK_TIMER;
    m_knockbackCheck = 2;
    waterfallKnockback = BG_DS_WATERFALL_KNOCKBACK_TIMER;
}

BattlegroundDS::~BattlegroundDS()
{

}

void BattlegroundDS::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() == STATUS_IN_PROGRESS)
    {
        if (m_knockbackCheck)
         {
            if (m_knockback < diff)
            {
                for(BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end();itr++)
                {
                    Player * plr = ObjectAccessor::FindPlayer(itr->first);
                    if (plr->GetDistance2d(1214, 765) <= 50 && plr->GetPositionZ() > 10)
                    {
                        plr->TeleportTo(GetMapId(), 1232.65f, 764.913f, 20.0729f, plr->GetOrientation());
                        plr->RemoveAurasDueToSpell(48018); // warlock teleport
                        KnockBackPlayer(plr, 6.40f, 50.00f, 7.00f);
                    }
                    if (plr->GetDistance2d(1369, 817) <= 50 && plr->GetPositionZ() > 10)
                    {
                        plr->TeleportTo(GetMapId(), 1350.95f, 817.2f, 20.0729f, plr->GetOrientation());
                        plr->RemoveAurasDueToSpell(48018); // warlock teleport
                        KnockBackPlayer(plr, 3.18f, 50.00f, 7.00f);
                    }
                }
                if (--m_knockbackCheck) // check again for lamers
                    m_knockback = BG_DS_KNOCKBACK_TIMER/2;
             }
             else
                m_knockback -= diff;
        }

        if (isWaterFallActive())
        {
            if (waterfallKnockback < diff)
            {
                CheckWaterfallForKnockback();
            } else
                waterfallKnockback -= diff;
        }

        if (getWaterFallTimer() < diff)
        {
            if (GetBgMap(false))
                if (isWaterFallActive())
                {
                    setWaterFallTimer(urand(BG_DS_WATERFALL_TIMER_MIN, BG_DS_WATERFALL_TIMER_MAX));
                    DoorOpen(BG_DS_OBJECT_WATER_1);
                    DoorOpen(BG_DS_OBJECT_WATER_2);
                    setWaterFallActive(false);
                }
                else
                {
                    setWaterFallTimer(BG_DS_WATERFALL_DURATION);
                    DoorOpen(BG_DS_OBJECT_WATER_1);
                    DoorOpen(BG_DS_OBJECT_WATER_2);
                    setWaterFallActive(true);

                   waterfallKnockback = BG_DS_WATERFALL_KNOCKBACK_TIMER;
                }
        }
        else
            setWaterFallTimer(getWaterFallTimer() - diff);
     }
}

void BattlegroundDS::StartingEventCloseDoors()
{
    for (uint32 i = BG_DS_OBJECT_DOOR_1; i <= BG_DS_OBJECT_DOOR_2; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);
}

void BattlegroundDS::StartingEventOpenDoors()
{
    SpawnWater();

    for (uint32 i = BG_DS_OBJECT_DOOR_1; i <= BG_DS_OBJECT_DOOR_2; ++i)
        DoorOpen(i);

    for (uint32 i = BG_DS_OBJECT_BUFF_1; i <= BG_DS_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, 60);

    setWaterFallTimer(BG_DS_KNOCKBACK_TIMER);
    setWaterFallActive(true);

    m_knockback = BG_DS_KNOCKBACK_TIMER;
    m_knockbackCheck = 2;
}

void BattlegroundDS::AddPlayer(Player *plr)
{
    Battleground::AddPlayer(plr);
    //create score and add it to map, default values are set in constructor
    BattlegroundDSScore* sc = new BattlegroundDSScore;

    m_PlayerScores[plr->GetGUID()] = sc;

    UpdateArenaWorldState();
}

void BattlegroundDS::RemovePlayer(Player* /*plr*/, uint64 /*guid*/, uint32 /*team*/)
{
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;

    UpdateArenaWorldState();
    CheckArenaWinConditions();
}

void BattlegroundDS::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (!killer)
    {
        sLog->outError("BattlegroundDS: Killer player not found");
        return;
    }

    Battleground::HandleKillPlayer(player, killer);

    UpdateArenaWorldState();
    CheckArenaWinConditions();
}

void BattlegroundDS::HandleAreaTrigger(Player *Source, uint32 Trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (Trigger)
    {
        case 5347:
        case 5348:
            break;
        default:
            sLog->outError("WARNING: Unhandled AreaTrigger in Battleground: %u", Trigger);
            Source->GetSession()->SendAreaTriggerMessage("Warning: Unhandled AreaTrigger in Battleground: %u", Trigger);
            break;
    }
}

bool BattlegroundDS::HandlePlayerUnderMap(Player* player)
{
    player->TeleportTo(GetMapId(), 1299.046f, 784.825f, 9.338f, 2.422f, false);
    return true;
}

void BattlegroundDS::FillInitialWorldStates(WorldPacket &data)
{
    UpdateArenaWorldState();
    data << uint32(3610) << uint32(1);                                              // 9 show    
}

void BattlegroundDS::Reset()
{
    //call parent's class reset
    Battleground::Reset();

    m_knockback = BG_DS_KNOCKBACK_TIMER;
    m_knockbackCheck = 2;
    waterfallKnockback = BG_DS_WATERFALL_KNOCKBACK_TIMER;
}

bool BattlegroundDS::SpawnWater()
{
    // water
    if (!AddObject(BG_DS_OBJECT_WATER_1, BG_DS_OBJECT_TYPE_WATER_1, 1291.56f, 790.837f, 7.1f, 3.14238f, 0, 0, 0.694215f, -0.719768f, RESPAWN_IMMEDIATELY)
        || !AddObject(BG_DS_OBJECT_WATER_2, BG_DS_OBJECT_TYPE_WATER_2, 1291.56f, 790.837f, 7.1f, 3.14238f, 0, 0, 0.694215f, -0.719768f, RESPAWN_IMMEDIATELY))
    {
        sLog->outErrorDb("BatteGroundDS: Failed to spawn some object!");
        return false;
    }

    return true;
 }

bool BattlegroundDS::SetupBattleground()
{
    // gates
    if (!AddObject(BG_DS_OBJECT_DOOR_1, BG_DS_OBJECT_TYPE_DOOR_1, 1350.95f, 817.2f, 20.8096f, 3.15f, 0, 0, 0.99627f, 0.0862864f, RESPAWN_IMMEDIATELY)
        || !AddObject(BG_DS_OBJECT_DOOR_2, BG_DS_OBJECT_TYPE_DOOR_2, 1232.65f, 764.913f, 20.0729f, 6.3f, 0, 0, 0.0310211f, -0.999519f, RESPAWN_IMMEDIATELY)
    // water
    /*
        || !AddObject(BG_DS_OBJECT_WATER_1, BG_DS_OBJECT_TYPE_WATER_1, 1291.56f, 790.837f, 7.1f, 3.14238f, 0, 0, 0.694215f, -0.719768f, 120)
        || !AddObject(BG_DS_OBJECT_WATER_2, BG_DS_OBJECT_TYPE_WATER_2, 1291.56f, 790.837f, 7.1f, 3.14238f, 0, 0, 0.694215f, -0.719768f, 120)
    */
    // buffs
        || !AddObject(BG_DS_OBJECT_BUFF_1, BG_DS_OBJECT_TYPE_BUFF_1, 1291.7f, 813.424f, 7.11472f, 4.64562f, 0, 0, 0.730314f, -0.683111f, RESPAWN_IMMEDIATELY)
        || !AddObject(BG_DS_OBJECT_BUFF_2, BG_DS_OBJECT_TYPE_BUFF_2, 1291.7f, 768.911f, 7.11472f, 1.55194f, 0, 0, 0.700409f, 0.713742f, RESPAWN_IMMEDIATELY))
    {
        sLog->outErrorDb("BatteGroundDS: Failed to spawn some object!");
        return false;
    }

    return true;
}

void BattlegroundDS::CheckWaterfallForKnockback()
{
    for(BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end();itr++)
    {
        Player * plr = ObjectAccessor::FindPlayer(itr->first);
        if (plr->GetDistance2d(1291.56f, 790.837f) <= 8)
        {
            float o = (plr->GetPositionY() - 1291.56f) / (plr->GetPositionX() - 790.837f);
            KnockBackPlayer(plr, atan(o), 10.00f, 2.50f);
        }
    }
}

void BattlegroundDS::KnockBackPlayer(Unit *pPlayer, float angle, float horizontalSpeed, float verticalSpeed)
{
    if (pPlayer->GetTypeId() == TYPEID_PLAYER)
    {
        WorldPacket data(SMSG_MOVE_KNOCK_BACK, 8+4+4+4+4+2);
        data.append(pPlayer->GetPackGUID());
        data << uint32(0);
        data << float(cos(angle));
        data << float(sin(angle));
        data << float(horizontalSpeed);
        data << float(-verticalSpeed);
        ((Player*)pPlayer)->GetSession()->SendPacket(&data);
    }
    else
        sLog->outError("The target of KnockBackPlayer must be a player !");
}
