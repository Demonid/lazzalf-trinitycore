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
Name: Flame Leviathan
Author: PrinceCreed
%Complete: 90
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "ObjectMgr.h"
#include "SpellScript.h"
#include "Vehicle.h"
#include "ulduar.h"


#define ACHI_UNBROKEN             RAID_MODE(2905,2906)

enum Spells
{
    SPELL_PURSUED                               = 62374,
    SPELL_GATHERING_SPEED                       = 62375,
    SPELL_BATTERING_RAM                         = 62376,
    SPELL_FLAME_VENTS                           = 62396,
    SPELL_MISSILE_BARRAGE                       = 62400,
    SPELL_SYSTEMS_SHUTDOWN                      = 62475,
    SPELL_OVERLOAD_CIRCUIT                      = 62399,
    SPELL_START_THE_ENGINE                      = 62472,
    SPELL_SEARING_FLAME                         = 62402,
    SPELL_BLAZE                                 = 62292,
    SPELL_TAR_PASSIVE                           = 62288,
    SPELL_SMOKE_TRAIL                           = 63575,
    SPELL_ELECTROSHOCK                          = 62522,
    SPELL_NAPALM                                = 63666,
    SPELL_INVIS_AND_STEALTH_DETECT = 18950, // Passive
    //TOWER Additional SPELLS
    SPELL_THORIM_S_HAMMER                       = 62911, // Tower of Storms
    SPELL_MIMIRON_S_INFERNO                     = 62909, // Tower of Flames
    SPELL_HODIR_S_FURY                          = 62533, // Tower of Frost
    SPELL_FREYA_S_WARD                          = 62906, // Tower of Nature
    SPELL_FREYA_SUMMONS                         = 62947, // Tower of Nature
    //TOWER ap & health spells
    SPELL_BUFF_TOWER_OF_STORMS                  = 65076,
    SPELL_BUFF_TOWER_OF_FLAMES                  = 65075,
    SPELL_BUFF_TOWER_OF_FROST                   = 65077,
    SPELL_BUFF_TOWER_OF_LIFE                    = 64482,
    //Additional Spells
    SPELL_LASH                                  = 65062,
    SPELL_AUTO_REPAIR                           = 62705,
    LIGHTNING_SKYBEAM                           = 63773,
    GREEN_SKYBEAM                               = 63771,
    BLUE_SKYBEAM                                = 63769,
    RED_SKYBEAM                                 = 63772,
    SPELL_LIQUID_PYRITE                         = 62494,
    SPELL_GROUND_SLAM                           = 62625
};

enum Creatures
{
    NPC_ULDUAR_COLOSSUS                         = 33237,
    NPC_TURRET                                  = 33142,
    NPC_DEVICE                                  = 33143,
    NPC_SEAT                                    = 33114,
    NPC_MECHANOLIFT                             = 33214,
    NPC_LIQUID                                  = 33189,
    NPC_CONTAINER                               = 33218,
    NPC_THORIM_BEACON                           = 33365,
    NPC_MIMIRON_BEACON                          = 33370,
    NPC_HODIR_BEACON                            = 33212,
    NPC_FREYA_BEACON                            = 33367,
    NPC_THORIM_TARGET_BEACON                    = 33364,
    NPC_MIMIRON_TARGET_BEACON                   = 33369,
    NPC_HODIR_TARGET_BEACON                     = 33108,
    NPC_FREYA_TARGET_BEACON                     = 33366,
    NPC_LOREKEEPER                              = 33686,
    NPC_BRANZ_BRONZBEARD                        = 33579,
    NPC_DELORAH                                 = 33701,
    NPC_ULDUAR_GAUNTLET_GENERATOR               = 33571  // Trigger tied to towers
};

enum Towers
{
    GO_TOWER_OF_STORMS                          = 194377,
    GO_TOWER_OF_FLAMES                          = 194371,
    GO_TOWER_OF_FROST                           = 194370,
    GO_TOWER_OF_LIFE                            = 194375
};

enum Events
{
    EVENT_NONE,
    EVENT_PURSUE,
    EVENT_MISSILE,
    EVENT_VENT,
    EVENT_SPEED,
    EVENT_SUMMON,
    EVENT_SHUTDOWN,
    EVENT_REPAIR,
    EVENT_THORIM_S_HAMMER,      // Tower of Storms
    EVENT_MIMIRON_S_INFERNO,    // Tower of Flames
    EVENT_HODIR_S_FURY,         // Tower of Frost
    EVENT_FREYA_S_WARD,         // Tower of Life
};

enum Seats
{
    SEAT_PLAYER                                 = 0,
    SEAT_TURRET                                 = 1,
    SEAT_DEVICE                                 = 2,
    SEAT_CANNON                                 = 7,
};

enum Vehicles
{
    VEHICLE_SIEGE                               = 33060,
    VEHICLE_CHOPPER                             = 33062,
    VEHICLE_DEMOLISHER                          = 33109,
};

#define EMOTE_PURSUE                            "Flame Leviathan pursues $N."
#define EMOTE_OVERLOAD                          "Flame Leviathan's circuits overloaded."
#define EMOTE_REPAIR                            "Automatic repair sequence initiated."

enum Actions
{
    ACTION_NULL                                 = 0,
    ACTION_TOWER_OF_STORMS,
    ACTION_TOWER_OF_FLAMES,
    ACTION_TOWER_OF_FROST,
    ACTION_TOWER_OF_LIFE,
    ACTION_VEHICLE_RESPAWN,
    ACTION_COLOSSUS_COUNT
};

enum Yells
{
    SAY_AGGRO                                   = -1603060,
    SAY_SLAY                                    = -1603061,
    SAY_DEATH                                   = -1603062,
    SAY_TARGET_1                                = -1603063,
    SAY_TARGET_2                                = -1603064,
    SAY_TARGET_3                                = -1603065,
    SAY_HARDMODE                                = -1603066,
    SAY_TOWER_NONE                              = -1603067,
    SAY_TOWER_FROST                             = -1603068,
    SAY_TOWER_FLAME                             = -1603069,
    SAY_TOWER_NATURE                            = -1603070,
    SAY_TOWER_STORM                             = -1603071,
    SAY_PLAYER_RIDING                           = -1603072,
    SAY_OVERLOAD_1                              = -1603073,
    SAY_OVERLOAD_2                              = -1603074,
    SAY_OVERLOAD_3                              = -1603075,
};

enum eAchievementData
{
    ACHIEV_10_NUKED_FROM_ORBIT                  = 2915,
    ACHIEV_25_NUKED_FROM_ORBIT                  = 2917,
    ACHIEV_10_ORBITAL_BOMBARDMENT               = 2913,
    ACHIEV_25_ORBITAL_BOMBARDMENT               = 2918,
    ACHIEV_10_ORBITAL_DEVASTATION               = 2914,
    ACHIEV_25_ORBITAL_DEVASTATION               = 2916,
    ACHIEV_10_ORBIT_UARY                        = 3056,
    ACHIEV_25_ORBIT_UARY                        = 3057,
    ACHIEV_10_SHUTOUT                           = 2911,
    ACHIEV_25_SHUTOUT                           = 2912,
    ACHIEV_10_SIEGE_OF_ULDUAR                   = 2886,
    ACHIEV_25_SIEGE_OF_ULDUAR                   = 2887,
    ACHIEV_10_THREE_CAR_GARAGE                  = 2907, // no core support for using a vehicle
    ACHIEV_25_THREE_CAR_GARAGE                  = 2908, // no core support for using a vehicle
    ACHIEV_10_UNBROKEN                          = 2905,
    ACHIEV_25_UNBROKEN                          = 2906,
};

const Position PosColossus[2] =
{
    {368.77f, 12.78f,409.89f,3.14f},
    {368.77f,-46.85f,409.89f,3.14f}
};

const Position PosSiege[5] =
{
    {-814.59f,-64.54f,429.92f,5.969f},
    {-784.37f,-33.31f,429.92f,5.096f},
    {-808.99f,-52.10f,429.92f,5.668f},
    {-798.59f,-44.00f,429.92f,5.663f},
    {-812.83f,-77.71f,429.92f,0.046f},
};

const Position PosChopper[5] =
{
    {-717.83f,-106.56f,430.02f,0.122f},
    {-717.83f,-114.23f,430.44f,0.122f},
    {-717.83f,-109.70f,430.22f,0.122f},
    {-718.45f,-118.24f,430.26f,0.052f},
    {-718.45f,-123.58f,430.41f,0.085f},
};

const Position PosDemolisher[5] =
{
    {-724.12f,-176.64f,430.03f,2.543f},
    {-766.70f,-225.03f,430.50f,1.710f},
    {-729.54f,-186.26f,430.12f,1.902f},
    {-756.01f,-219.23f,430.50f,2.369f},
    {-798.01f,-227.24f,429.84f,1.446f},
};

const Position PosFreyasWard[4] =
{
    {374.971f, 66.375f,410.99f,0},
    {374.971f,-129.71f,410.51f,0},
    {160.301f,-129.71f,409.80f,0},
    {160.301f, 60.375f,409.80f,0}
};

class boss_flame_leviathan : public CreatureScript
{
public:
    boss_flame_leviathan() : CreatureScript("boss_flame_leviathan") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_flame_leviathanAI (creature);
    }

    struct boss_flame_leviathanAI : public BossAI
    {
        boss_flame_leviathanAI(Creature* creature) : BossAI(creature, BOSS_LEVIATHAN), vehicle(creature->GetVehicleKit())
        {
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_KNOCKOUT, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            DoCast(SPELL_INVIS_AND_STEALTH_DETECT);

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
            me->SetReactState(REACT_PASSIVE);
            
            bActiveTowers = false;
            
            // Summon Ulduar Colossus
            if (me->isAlive())
                for (uint32 i = 0; i < 2; ++i)
                    DoSummon(NPC_ULDUAR_COLOSSUS, PosColossus[i], 7000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
        }

        Vehicle* vehicle;
        int32 ShutdownCount;
        int32 ColossusCount;
        
        bool bActiveTowers;

        void Reset()
        {
            _Reset();           

            //if (me->GetVehicleKit())
            //    me->GetVehicleKit()->Reset();

            me->SetReactState(REACT_DEFENSIVE);
            InstallAdds(false);
            me->ResetLootMode();
            ColossusCount = 0;
            ShutdownCount = 0;
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            DoScriptText(SAY_AGGRO, me);
            me->SetReactState(REACT_AGGRESSIVE);
            events.ScheduleEvent(EVENT_PURSUE, 5000);
            events.ScheduleEvent(EVENT_MISSILE, 1500);
            events.ScheduleEvent(EVENT_VENT, 20000);
            events.ScheduleEvent(EVENT_SPEED, 15000);
            events.ScheduleEvent(EVENT_SUMMON, 1500);
            events.ScheduleEvent(EVENT_SHUTDOWN, 90000);            
            InstallAdds(true);
            ActiveTowers();
        }

        void SetHardMode(bool value)
        {
            bActiveTowers = value;
        }

        void ActiveTowers()
        {
            if (instance)
            {
                if (bActiveTowers)
                {
                    if (instance->GetData(DATA_TOWER_OF_STORMS) == 1)
                    {
                        me->AddAura(SPELL_BUFF_TOWER_OF_STORMS, me);
                        events.ScheduleEvent(EVENT_THORIM_S_HAMMER, 30000);
                    }

                    if (instance->GetData(DATA_TOWER_OF_FLAMES) == 1)
                    {
                        me->AddAura(SPELL_BUFF_TOWER_OF_FLAMES, me);
                        events.ScheduleEvent(EVENT_MIMIRON_S_INFERNO, 10000);
                    }

                    if (instance->GetData(DATA_TOWER_OF_FROST) == 1)
                    {
                        me->AddAura(SPELL_BUFF_TOWER_OF_FROST, me);
                        events.ScheduleEvent(EVENT_HODIR_S_FURY, 5000);
                    }

                    if (instance->GetData(DATA_TOWER_OF_LIFE) == 1)
                    {
                        me->AddAura(SPELL_BUFF_TOWER_OF_LIFE, me);
                        events.ScheduleEvent(EVENT_FREYA_S_WARD, 1000);
                    }
                
                    switch(instance->GetData(DATA_TOWER_DESTROYED))
                    {
                        case 0:
                            me->AddLootMode(LOOT_MODE_HARD_MODE_4);
                        case 1:
                            me->AddLootMode(LOOT_MODE_HARD_MODE_3);
                        case 2:
                            me->AddLootMode(LOOT_MODE_HARD_MODE_2);
                        case 3:
                            DoScriptText(SAY_HARDMODE, me);
                            me->AddLootMode(LOOT_MODE_HARD_MODE_1);
                            break;
                    }
                }
                else
                {
                    DoScriptText(SAY_TOWER_NONE, me);
                    me->SetLootMode(LOOT_MODE_DEFAULT);
                }
            }
        }

        void InstallAdds(bool apply = true)
        {
            if (apply)
            {
                for (uint8 i = RAID_MODE(2,0); i < 4; ++i)
                {
                    if (vehicle->GetPassenger(i))
                        if (Unit* target = vehicle->GetPassenger(i))
                        {
                            if (Creature* pTurret = (me->SummonCreature(NPC_TURRET, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN)))
                                pTurret->EnterVehicle(target, SEAT_TURRET);
                            if (Creature* pDevice = (me->SummonCreature(NPC_DEVICE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN)))
                                pDevice->EnterVehicle(target, SEAT_DEVICE);
                        }
                }
            }
            else
            {
                for (uint8 i = RAID_MODE(2,0); i < 4; ++i)
                {
                    if (vehicle->GetPassenger(i))
                        if (Vehicle* pSeat = vehicle->GetPassenger(i)->GetVehicleKit())
                        {
                            if (Unit* pTurret = (pSeat->GetPassenger(SEAT_TURRET)))
                            {
                                pTurret->CombatStop();
                                pTurret->RemoveFromWorld();
                            }

                            if (Unit* pDevice = (pSeat->GetPassenger(SEAT_DEVICE)))
                            {
                                pDevice->CombatStop();
                                pDevice->RemoveFromWorld();
                            }
                        }
                }
            }
        }

        void JustDied(Unit* /*victim*/)
        {
            _JustDied();
                // Set Field Flags 67108928 = 64 | 67108864 = UNIT_FLAG_UNK_6 | UNIT_FLAG_SKINNABLE
                // Set DynFlags 12
                // Set NPCFlags 0
            DoScriptText(SAY_DEATH, me);

            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            if (!players.isEmpty())
            {
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    Player* pPlayer = itr->getSource();
                    if (pPlayer)
                    {
                        me->GetMap()->ToInstanceMap()->PermBindAllPlayers(pPlayer);
                        pPlayer->KilledMonsterCredit(33113,0);
                    }
                }
            }

            if (bActiveTowers)
            {
                switch(instance->GetData(DATA_TOWER_DESTROYED))
                {
                    case 0:
                        instance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_ORBIT_UARY, ACHIEV_25_ORBIT_UARY));
                    case 1:
                        instance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_NUKED_FROM_ORBIT, ACHIEV_25_NUKED_FROM_ORBIT));
                    case 2:
                        instance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_ORBITAL_DEVASTATION, ACHIEV_25_ORBITAL_DEVASTATION));
                    case 3:
                        instance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_ORBITAL_BOMBARDMENT, ACHIEV_25_ORBITAL_BOMBARDMENT));
                    default:
                        break;
                }
            }
        }

        void SpellHit(Unit* /*caster*/, const SpellEntry* pSpell)
        {
            //if (pSpell->Id == SPELL_START_THE_ENGINE)
            //    vehicle->InstallAllAccessories();

            if (pSpell->Id == SPELL_ELECTROSHOCK)
                me->InterruptSpell(CURRENT_CHANNELED_SPELL);

            if (pSpell->Id == SPELL_OVERLOAD_CIRCUIT)
            {
                ShutdownCount++;
                
                if (ShutdownCount == RAID_MODE(2,4))
                {
                    ShutdownCount = 0;
                    events.ScheduleEvent(EVENT_SHUTDOWN, 0);
                    events.ScheduleEvent(EVENT_REPAIR, 0);
                    me->RemoveAurasDueToSpell(SPELL_OVERLOAD_CIRCUIT);
                    me->InterruptNonMeleeSpells(true);
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            
            if (me->HasUnitState(UNIT_STAT_CASTING) || me->HasAura(SPELL_SYSTEMS_SHUTDOWN))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_PURSUE:
                        DoScriptText(RAND(SAY_TARGET_1, SAY_TARGET_2, SAY_TARGET_3), me);
                        {
                            DoZoneInCombat();
                            Unit* target;
                            std::vector<Unit *> target_list;
                            std::list<HostileReference*> ThreatList = me->getThreatManager().getThreatList();
                            for (std::list<HostileReference*>::const_iterator itr = ThreatList.begin(); itr != ThreatList.end(); ++itr)
                            {
                                target = Unit::GetUnit(*me, (*itr)->getUnitGuid());
                                
                                if (!target || target->ToPlayer())
                                    continue;
                                    
                                if (target->GetEntry() == VEHICLE_SIEGE || target->GetEntry() == VEHICLE_DEMOLISHER)
                                    target_list.push_back(target);
                                    
                                target = NULL;
                            }
                            
                            if (!target_list.empty())
                                target = *(target_list.begin()+rand()%target_list.size());
                            else
                                target = me->getVictim();
                                
                            if (target && target->isAlive())
                            {
                                DoResetThreat();
                                me->AddThreat(target, 5000000.0f);
                                me->AddAura(SPELL_PURSUED, target);
                                if (Vehicle* pVehicle = target->GetVehicleKit())
                                {
                                    if (Unit* pDriver = pVehicle->GetPassenger(0))
                                        me->MonsterTextEmote(EMOTE_PURSUE, pDriver->GetGUID(), true);
                                }
                                else me->MonsterTextEmote(EMOTE_PURSUE, target->GetGUID(), true);
                            }
                        }
                        events.RescheduleEvent(EVENT_PURSUE, 35000);
                        break;
                    case EVENT_MISSILE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                            DoCast(target, SPELL_MISSILE_BARRAGE);
                        events.RescheduleEvent(EVENT_MISSILE, 3000);
                        break;
                    case EVENT_VENT:
                        DoCastAOE(SPELL_FLAME_VENTS);
                        events.RescheduleEvent(EVENT_VENT, urand(15000, 20000));
                        break;
                    case EVENT_SPEED:
                        DoCastAOE(SPELL_GATHERING_SPEED);
                        events.RescheduleEvent(EVENT_SPEED, 15000);
                        break;
                    case EVENT_SUMMON:
                        if (summons.size() < 15) // 4seat+1turret+10lift
                            if (Creature* pLift = DoSummonFlyer(NPC_MECHANOLIFT, me, 30.0f, 50.0f, 0))
                                pLift->GetMotionMaster()->MoveRandom(100);
                        events.RescheduleEvent(EVENT_SUMMON, 3000);
                        break;
                    case EVENT_SHUTDOWN:
                        DoScriptText(RAND(SAY_OVERLOAD_1, SAY_OVERLOAD_2, SAY_OVERLOAD_3), me);
                        InstallAdds(false);
                        me->MonsterTextEmote(EMOTE_OVERLOAD, 0, true);
                        me->AddAura(SPELL_SYSTEMS_SHUTDOWN, me);
                        me->RemoveAurasDueToSpell(SPELL_GATHERING_SPEED);
                        //me->AddUnitState(UNIT_STAT_STUNNED | UNIT_STAT_ROOT);
                        me->SetReactState(REACT_PASSIVE);
                        //me->StopMoving();
                        events.CancelEvent(EVENT_SHUTDOWN);
                        events.ScheduleEvent(EVENT_REPAIR, 20000);
                        return;
                    case EVENT_REPAIR:
                        me->MonsterTextEmote(EMOTE_REPAIR, 0, true);
                        InstallAdds(true);
                        //me->ClearUnitState(UNIT_STAT_STUNNED | UNIT_STAT_ROOT);
                        me->SetReactState(REACT_AGGRESSIVE);
                        events.CancelEvent(EVENT_REPAIR);
                        events.ScheduleEvent(EVENT_SHUTDOWN, 90000);
                        break;
                    case EVENT_THORIM_S_HAMMER:     // Tower of Storms
                        DoScriptText(SAY_TOWER_STORM, me);
                        DoSummon(NPC_THORIM_BEACON, me, float(urand(40,80)), 6000, TEMPSUMMON_TIMED_DESPAWN);
                        events.RescheduleEvent(EVENT_THORIM_S_HAMMER, urand(4000,10000));
                        break;
                    case EVENT_MIMIRON_S_INFERNO:   // Tower of Flames
                        DoScriptText(SAY_TOWER_FLAME, me);
                        me->SummonCreature(NPC_MIMIRON_BEACON, 280.42f, -19.18f, 409.81f);
                        events.CancelEvent(EVENT_MIMIRON_S_INFERNO);
                        break;
                    case EVENT_HODIR_S_FURY:        // Tower of Frost
                        DoScriptText(SAY_TOWER_FROST, me);
                        for (uint8 i = 0; i < 4; ++i)
                            DoSummon(NPC_HODIR_BEACON, me, 50, 0);
                        events.CancelEvent(EVENT_HODIR_S_FURY);
                        break;
                    case EVENT_FREYA_S_WARD:        // Tower of Life
                        DoScriptText(SAY_TOWER_NATURE, me);
                        for (uint32 i = 0; i < 4; ++i)
                            DoSummon(NPC_FREYA_BEACON, PosFreyasWard[i]);
                        events.CancelEvent(EVENT_FREYA_S_WARD);
                        break;
                }

                if (me->IsWithinMeleeRange(me->getVictim()))
                    DoSpellAttackIfReady(SPELL_BATTERING_RAM);
            }
        }

        void DoAction(const int32 action)
        {
            switch(action)
            {
                case ACTION_COLOSSUS_COUNT:
                {
                    ++ColossusCount;
                    if (ColossusCount >= 2)
                    {
                        // Event starts
                        if (instance)
                            instance->SetData(DATA_LEVIATHAN_DOOR, GO_STATE_ACTIVE_ALTERNATIVE);
                            
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->SetHomePosition(318.74f, -13.75f, 409.803f, 3.14f); // new Home Position
                        me->GetMotionMaster()->MoveCharge(354.8771f, -12.90240f, 409.803f);
                    }
                    break;
                }
                default:
                    break;
            }
        }
    };

};

//#define BOSS_DEBUG

class boss_flame_leviathan_seat : public CreatureScript
{
public:
    boss_flame_leviathan_seat() : CreatureScript("boss_flame_leviathan_seat") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_flame_leviathan_seatAI (creature);
    }

    struct boss_flame_leviathan_seatAI : public PassiveAI
    {
        boss_flame_leviathan_seatAI(Creature* creature) : PassiveAI(creature), vehicle(creature->GetVehicleKit())
        {
            assert(vehicle);
            me->SetDisplayId(11686);
    #ifdef BOSS_DEBUG
            me->SetReactState(REACT_AGGRESSIVE);
    #endif
        }

        Vehicle* vehicle;

    #ifdef BOSS_DEBUG
        void MoveInLineOfSight(Unit *who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER && CAST_PLR(who)->isGameMaster()
                && !who->GetVehicle() && vehicle->GetPassenger(SEAT_TURRET))
                who->EnterVehicle(vehicle, SEAT_PLAYER);
        }
    #endif

        void PassengerBoarded(Unit* who, int8 seatId, bool apply)
        {
            if (!me->GetVehicle())
                return;

            if (seatId == SEAT_PLAYER)
            {
                if (apply)
                {
                    DoScriptText(SAY_PLAYER_RIDING, me);
                    who->ApplySpellImmune(0, IMMUNITY_ID, SPELL_MISSILE_BARRAGE, true);
                }
                else
                    return;

                if (Creature* pTurret = vehicle->GetPassenger(SEAT_TURRET)->ToCreature())
                {
                    pTurret->setFaction(me->GetVehicleBase()->getFaction());
                    pTurret->SetUInt32Value(UNIT_FIELD_FLAGS, 0); // unselectable
                    pTurret->AI()->AttackStart(who);
                }
                
                if (Unit* pDevice = vehicle->GetPassenger(SEAT_DEVICE)->ToCreature())
                {
                    pDevice->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                    pDevice->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                }
            }
        }
    };

};

class boss_flame_leviathan_defense_cannon : public CreatureScript
{
public:
    boss_flame_leviathan_defense_cannon() : CreatureScript("boss_flame_leviathan_defense_cannon") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_flame_leviathan_defense_cannonAI (creature);
    }

    struct boss_flame_leviathan_defense_cannonAI : public ScriptedAI
    {
        boss_flame_leviathan_defense_cannonAI(Creature* creature) : ScriptedAI(creature) 
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            //NapalmTimer = 5000;
        }

        //uint32 NapalmTimer;

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            /*if (NapalmTimer <= diff)
            {
                if (Unit *target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    if (!me->IsWithinDist(target, 20))
                        DoCast(target, SPELL_NAPALM);
                NapalmTimer = urand(10000, 15000);
            }
            else NapalmTimer -= diff;*/
        }
    };
};

class boss_flame_leviathan_defense_turret : public CreatureScript
{
public:
    boss_flame_leviathan_defense_turret() : CreatureScript("boss_flame_leviathan_defense_turret") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_flame_leviathan_defense_turretAI (creature);
    }

    struct boss_flame_leviathan_defense_turretAI : public TurretAI
    {
        boss_flame_leviathan_defense_turretAI(Creature* c) : TurretAI(c) {}

        void DamageTaken(Unit* who, uint32 &damage)
        {
            if (!CanAIAttack(who))
                damage = 0;
        }

        bool CanAIAttack(const Unit *who) const
        {
            if (who->GetTypeId() != TYPEID_PLAYER || !who->GetVehicle() || who->GetVehicleBase()->GetEntry() != 33114)
                return false;
            return true;
        }
    };

};

class boss_flame_leviathan_overload_device : public CreatureScript
{
public:
    boss_flame_leviathan_overload_device() : CreatureScript("boss_flame_leviathan_overload_device") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_flame_leviathan_overload_deviceAI (creature);
    }

    struct boss_flame_leviathan_overload_deviceAI : public PassiveAI
    {
        boss_flame_leviathan_overload_deviceAI(Creature* creature) : PassiveAI(creature)
        {
            instance = creature->GetInstanceScript();
            me->SetDisplayId(28469);
        }

        InstanceScript* instance;

        void DoAction(const int32 param)
        {
            if (param == EVENT_SPELLCLICK)
            {
                if (me->GetVehicle())
                {
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    if (Unit* pPlayer = me->GetVehicle()->GetPassenger(SEAT_PLAYER))
                    {
                        me->GetVehicleBase()->CastSpell(pPlayer, SPELL_SMOKE_TRAIL, true);
                        pPlayer->ApplySpellImmune(0, IMMUNITY_ID, SPELL_MISSILE_BARRAGE, false);
                        pPlayer->ExitVehicle();
                        pPlayer->GetMotionMaster()->MoveJumpTo(30, 60, 30);
                    }
                }
            }
        }
    };

};

class boss_flame_leviathan_safety_container : public CreatureScript
{
public:
    boss_flame_leviathan_safety_container() : CreatureScript("boss_flame_leviathan_safety_container") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_flame_leviathan_safety_containerAI(creature);
    }

    struct boss_flame_leviathan_safety_containerAI : public PassiveAI
    {
        boss_flame_leviathan_safety_containerAI(Creature* creature) : PassiveAI(creature)
        {
        }

        void JustDied()
        {
            float x,y,z;
            me->GetPosition(x,y,z);
            z = me->GetMap()->GetHeight(x, y, z);
            me->GetMotionMaster()->MovePoint(0,x,y,z);
            me->GetMap()->CreatureRelocation(me, x,y,z,0);
        }

        void UpdateAI(const uint32 /*diff*/)
        {
        }
    };
};

class npc_mechanolift : public CreatureScript
{
public:
    npc_mechanolift() : CreatureScript("npc_mechanolift") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_mechanoliftAI(creature);
    }

    struct npc_mechanoliftAI : public PassiveAI
    {
        npc_mechanoliftAI(Creature* creature) : PassiveAI(creature), vehicle(creature->GetVehicleKit())
        {
            assert(vehicle);
        }

        Vehicle* vehicle;

        uint32 MoveTimer;

        void Reset ()
        {
            MoveTimer = 0;
            me->GetMotionMaster()->MoveRandom(50);
        }

        void JustDied(Unit* killer)
        {
            me->GetMotionMaster()->MoveTargetedHome();
            Creature* pLiquid = DoSummon(NPC_LIQUID, me, 0);
            if (pLiquid)
            {
                pLiquid->CastSpell(pLiquid, SPELL_LIQUID_PYRITE, true);
                pLiquid->GetMotionMaster()->MoveFall(killer->GetPositionZ());
            }
        }

        void MovementInform(uint32 /*type*/, uint32 id)
        {
            if (id == 1)
            {
                Creature* pContainer = me->FindNearestCreature(NPC_CONTAINER, 5, true);
                if (pContainer)
                    pContainer->EnterVehicle(me);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (MoveTimer <= diff)
            {
                if (me->GetVehicleKit()->HasEmptySeat(-1))
                {
                    Creature* pContainer = me->FindNearestCreature(NPC_CONTAINER, 50, true);
                    if (pContainer && !pContainer->GetVehicle())
                        me->GetMotionMaster()->MovePoint(1,pContainer->GetPositionX(),pContainer->GetPositionY(),pContainer->GetPositionZ());
                }
                MoveTimer = 30000; //check next 30 seconds
            }
            else
                MoveTimer-=diff;
        }
    };

};

// WHY IS THIS CALLED spell_???
class npc_pool_of_tar : public CreatureScript
{
    public:
        npc_pool_of_tar() : CreatureScript("npc_pool_of_tar") { }

        struct npc_pool_of_tarAI : public ScriptedAI
        {
            npc_pool_of_tarAI(Creature* creature) : ScriptedAI(creature)
            {
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_PASSIVE);
                me->AddAura(SPELL_TAR_PASSIVE, me);
            }

            void DamageTaken(Unit* /*who*/, uint32& damage)
            {
                damage = 0;
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
            {
                if (spell->SchoolMask & SPELL_SCHOOL_MASK_FIRE && !me->HasAura(SPELL_BLAZE))
                    me->CastSpell(me, SPELL_BLAZE, true);
            }

            void UpdateAI(uint32 const /*diff*/) {}
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pool_of_tarAI(creature);
        }
};


class npc_colossus : public CreatureScript
{
public:
    npc_colossus() : CreatureScript("npc_colossus") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new  npc_colossusAI(creature);
    }

    struct npc_colossusAI : public ScriptedAI
    {
        npc_colossusAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 GroundSlamTimer;
        
        void Reset()
        {
            GroundSlamTimer = 10000;
        }

        void JustDied(Unit* /*Who*/)
        {
            if (me->isSummon())
            {
                if (Creature* pLeviathan = me->GetCreature(*me, instance->GetData64(DATA_LEVIATHAN)))
                    pLeviathan->AI()->DoAction(ACTION_COLOSSUS_COUNT);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (GroundSlamTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_GROUND_SLAM);
                GroundSlamTimer = 10000;
            }
            else GroundSlamTimer -= diff;

            DoMeleeAttackIfReady() ;
        }
    };

};

class npc_thorims_hammer : public CreatureScript
{
public:
    npc_thorims_hammer() : CreatureScript("npc_thorims_hammer") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new  npc_thorims_hammerAI(creature);
    }

    struct npc_thorims_hammerAI : public Scripted_NoMovementAI
    {
        npc_thorims_hammerAI(Creature* creature) : Scripted_NoMovementAI (creature)
        {
            me->AddAura(LIGHTNING_SKYBEAM, me);
            me->SetReactState(REACT_PASSIVE);
            me->SetDisplayId(11686);
            hammerTimer = 3000;
            done = false;
        }
        
        uint32 hammerTimer;
        bool done;

        void UpdateAI(const uint32 diff)
        {
            if (hammerTimer <= diff && !done)
            {
                if (Creature* pTrigger = DoSummonFlyer(NPC_THORIM_TARGET_BEACON, me, 80, 0, 4000, TEMPSUMMON_TIMED_DESPAWN))
                    pTrigger->CastSpell(me, SPELL_THORIM_S_HAMMER, true);

                done = true;
            }
            else hammerTimer -= diff;
        }
    };

};

class npc_mimirons_inferno : public CreatureScript
{
public:
    npc_mimirons_inferno() : CreatureScript("npc_mimirons_inferno") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new  npc_mimirons_infernoAI(creature);
    }

    struct npc_mimirons_infernoAI : public ScriptedAI
    {
        npc_mimirons_infernoAI(Creature* creature) : ScriptedAI(creature)
        {
            me->AddAura(RED_SKYBEAM, me);
            me->SetReactState(REACT_PASSIVE);
            me->SetDisplayId(11686);
            me->GetMotionMaster()->MoveRandom(100);
            infernoTimer = 2000;
            pause = false;
            infernoCount = 0;
        }

        bool pause;
        uint8 infernoCount;
        uint32 pauseTimer;
        uint32 infernoTimer;

        void UpdateAI(const uint32 diff)
        {
            if (pauseTimer <= diff && pause)
            {
                pause = false;
                infernoTimer = 0;
                infernoCount = 0;
            }
            else pauseTimer -= diff;
        
            if (infernoTimer <= diff && !pause)
            {
                if (Creature* pTrigger = DoSummonFlyer(NPC_MIMIRON_TARGET_BEACON, me, 80, 0, 20000, TEMPSUMMON_TIMED_DESPAWN))
                    pTrigger->CastSpell(me, SPELL_MIMIRON_S_INFERNO, true);

                infernoTimer = 2000;
                
                infernoCount++;
                if (infernoCount == 3)
                {
                    pause = true;
                    pauseTimer = 6000;
                }
            }
            else infernoTimer -= diff;
        }
    };

};

class npc_hodirs_fury : public CreatureScript
{
public:
    npc_hodirs_fury() : CreatureScript("npc_hodirs_fury") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new  npc_hodirs_furyAI(creature);
    }

    struct npc_hodirs_furyAI : public ScriptedAI
    {
        npc_hodirs_furyAI(Creature* creature) : ScriptedAI (creature)
        {
            me->AddAura(BLUE_SKYBEAM, me);
            me->SetReactState(REACT_PASSIVE);
            me->SetDisplayId(11686);
            me->GetMotionMaster()->MoveRandom(100);
            chaseTimer = 1000;
            freezeTimer = 5000;
            pause = false;
        }
        
        uint32 pauseTimer;
        uint32 freezeTimer;
        uint32 chaseTimer;
        bool pause;

        void UpdateAI(const uint32 diff)
        {
            if (pause)
            {
                if (freezeTimer <= diff)
                {
                    me->GetMotionMaster()->Initialize();
                    pause = false;
                    chaseTimer = 20000;
                    freezeTimer = 5000;
                    pauseTimer = 4000;
                
                    if (Creature* pTrigger = DoSummonFlyer(NPC_HODIR_TARGET_BEACON, me, 80, 0, 1000, TEMPSUMMON_TIMED_DESPAWN))
                          pTrigger->CastSpell(me, SPELL_HODIR_S_FURY, true);
                }
                else freezeTimer -= diff;
                    
            }
            else
            {
                if (chaseTimer <= diff)
                {
                    if (Unit* target = me->SelectNearestTarget(20))
                    {
                        pause = true;
                        freezeTimer = 6000;
                        me->GetMotionMaster()->MoveFollow(target, 0, 0);
                    }
                    chaseTimer = 1000;
                }
                else chaseTimer -= diff;
                
                if (pauseTimer <= diff)
                {
                    me->GetMotionMaster()->MoveRandom(100);
                    pauseTimer = 60000;
                }
                else pauseTimer -= diff;
            }
        }
    };

};

class npc_freyas_ward : public CreatureScript
{
public:
    npc_freyas_ward() : CreatureScript("npc_freyas_ward") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new  npc_freyas_wardAI(creature);
    }

    struct npc_freyas_wardAI : public ScriptedAI
    {
        npc_freyas_wardAI(Creature* creature) : ScriptedAI(creature)
        {
            me->AddAura(GREEN_SKYBEAM, me);
            me->SetReactState(REACT_PASSIVE);
            me->SetDisplayId(11686);
            summonTimer = urand(15000, 20000);
        }

        uint32 summonTimer ;

        void UpdateAI(const uint32 diff)
        {
            if (summonTimer <= diff)
            {
                if (Creature* pTrigger = DoSummonFlyer(NPC_FREYA_TARGET_BEACON, me, 80, 0, 3000, TEMPSUMMON_TIMED_DESPAWN))
                    pTrigger->CastSpell(me, SPELL_FREYA_S_WARD, true);

                summonTimer = urand(25000, 35000);
            }
            else summonTimer -= diff ;
        }
    };

};

class npc_freya_ward_summon : public CreatureScript
{
public:
    npc_freya_ward_summon() : CreatureScript("npc_freya_ward_summon") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_freya_ward_summonAI (creature);
    }

    struct npc_freya_ward_summonAI : public ScriptedAI
    {
        npc_freya_ward_summonAI(Creature* creature) : ScriptedAI(creature)
        {
            for (int32 i = 0; i < RAID_MODE(3, 5); ++i)
                DoCast(me, SPELL_FREYA_SUMMONS, true);
            pInstance = creature->GetInstanceScript();
            me->GetMotionMaster()->MovePoint(0, 259.56f, -17.45f, 409.65f);
            lashTimer = 5000 ;
        }

        InstanceScript* pInstance;
        uint32 lashTimer ;

        void UpdateAI(const uint32 diff)
        {
            if (pInstance && pInstance->GetBossState(BOSS_LEVIATHAN) != IN_PROGRESS)
                me->DespawnOrUnsummon();
        
            if (!UpdateVictim())
                return;

            if (lashTimer <= diff)
            {
                DoCast(SPELL_LASH);
                lashTimer = 5000;
            }
            else lashTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

};

class mob_flameleviathan_loot : public CreatureScript
{
    public:
        mob_flameleviathan_loot(): CreatureScript("mob_flameleviathan_loot") {}

    struct mob_flameleviathan_lootAI : public ScriptedAI
    {
        mob_flameleviathan_lootAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = me->GetInstanceScript();
            bLeviathan = true;
            hardMode = false;
        }

        InstanceScript* pInstance;
        bool bLeviathan;
        bool hardMode;
        uint32 uiExplosion;

        void SetHardMode(bool value)
        {
            hardMode = value;
        }

        void EnterCombat(Unit *who)
        {
            uiExplosion = 5000;

            if (!pInstance)
            {
                bLeviathan = true;
                return;
            }

            if (hardMode)
            {
                switch(pInstance->GetData(DATA_TOWER_DESTROYED))
                {
                    case 0:
                        me->AddLootMode(LOOT_MODE_HARD_MODE_4);
                    case 1:
                        me->AddLootMode(LOOT_MODE_HARD_MODE_3);
                    case 2:
                        me->AddLootMode(LOOT_MODE_HARD_MODE_2);
                    case 3:                
                        me->AddLootMode(LOOT_MODE_HARD_MODE_1);
                        break;
                    default:                        
                        break;
                }
            }
            else
                me->SetLootMode(LOOT_MODE_DEFAULT);

            if (Unit* pLeviathan = Unit::GetUnit(*me, pInstance->GetData64(DATA_LEVIATHAN)))
            {
                if (pLeviathan->isAlive())
                {
                    bLeviathan = true;   
                    me->MonsterYell("Rilevato tentativo di Kill Illegale, attivazione sistema di distruzione personaggi", LANG_UNIVERSAL,0);
                    if (who)
                        sLog->outCheat("Boss-%s, Tentativo di kill del loot del Flame Leviathan senza aver fatto il boss", who->GetName());
                    return;
                }
            }
            bLeviathan = false;
        }

        void DamageTaken(Unit* killer, uint32 &damage)
        {
            if (bLeviathan)
                damage = 0;            
        }

        void JustDied(Unit* victim)
        {
            if (pInstance->GetData(DATA_ACHI_UNBROKEN) == ACHI_IS_IN_PROGRESS)
                pInstance->DoCompleteAchievement(ACHI_UNBROKEN);

            if (hardMode)
            {
                switch(pInstance->GetData(DATA_TOWER_DESTROYED))
                {
                    case 0:
                        pInstance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_ORBIT_UARY, ACHIEV_25_ORBIT_UARY));
                    case 1:
                        pInstance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_NUKED_FROM_ORBIT, ACHIEV_25_NUKED_FROM_ORBIT));
                    case 2:
                        pInstance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_ORBITAL_DEVASTATION, ACHIEV_25_ORBITAL_DEVASTATION));
                    case 3:
                        pInstance->DoCompleteAchievement(RAID_MODE(ACHIEV_10_ORBITAL_BOMBARDMENT, ACHIEV_25_ORBITAL_BOMBARDMENT));
                    default:
                        break;
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;           

            if (bLeviathan)
                if (uiExplosion < diff)
                {
                    DoCast(me, 64487, true); //Ascend to the Heavens
                    uiExplosion = 5000;
                } else uiExplosion -= diff;                    

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_flameleviathan_lootAI(creature);
    };
};

//npc lore keeper
#define GOSSIP_ITEM_3  "Attack the siege (NORMAL)"
#define GOSSIP_ITEM_1  "Activate secondary defensive systems (HM)"
#define GOSSIP_ITEM_2  "Confirmed"
class npc_lorekeeper : public CreatureScript
{
public:
    npc_lorekeeper() : CreatureScript("npc_lorekeeper") {}   

    bool OnGossipSelect(Player* pPlayer, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        InstanceScript* instance = creature->GetInstanceScript();
        switch(uiAction)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            if (pPlayer)
            {
                pPlayer->PrepareGossipMenu(creature);
                instance->instance->LoadGrid(364,-16); //make sure leviathan is loaded

                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_ITEM_2,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+2);
                pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(creature), creature->GetGUID());
            }
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            if (pPlayer)
                pPlayer->CLOSE_GOSSIP_MENU();

            if (Creature* pLeviathanLoot = instance->instance->GetCreature(instance->GetData64(NPC_LEVIATHAN_LOOT)))
                CAST_AI(mob_flameleviathan_loot::mob_flameleviathan_lootAI, (pLeviathanLoot->AI()))->SetHardMode(true);

            if (Creature* pLeviathan = instance->instance->GetCreature(instance->GetData64(BOSS_LEVIATHAN)))
            {    
                CAST_AI(boss_flame_leviathan::boss_flame_leviathanAI, (pLeviathan->AI()))->SetHardMode(true); //enable hard mode activating the 4 additional events spawning additional vehicles

                // creature->SetVisible(false);
                creature->AI()->DoAction(0); // spawn the vehicles
                if (Creature* Delorah = creature->FindNearestCreature(NPC_DELORAH, 1000, true))
                {
                    if (Creature* Branz = creature->FindNearestCreature(NPC_BRANZ_BRONZBEARD, 1000, true))
                    {
                        Delorah->GetMotionMaster()->MovePoint(0, Branz->GetPositionX()-4, Branz->GetPositionY(), Branz->GetPositionZ());
                        //TODO DoScriptText(xxxx, Delorah, Branz); when reached at branz
                    }
                }
            }
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            if (pPlayer)
                pPlayer->CLOSE_GOSSIP_MENU();

            if (Creature* pLeviathan = instance->instance->GetCreature(instance->GetData64(BOSS_LEVIATHAN)))
                CAST_AI(boss_flame_leviathan::boss_flame_leviathanAI, (pLeviathan->AI()))->SetHardMode(false);

            if (Creature* pLeviathanLoot = instance->instance->GetCreature(instance->GetData64(NPC_LEVIATHAN_LOOT)))
                CAST_AI(mob_flameleviathan_loot::mob_flameleviathan_lootAI, (pLeviathanLoot->AI()))->SetHardMode(false);

            creature->AI()->DoAction(0); // spawn the vehicles
            break;
        }
        return true;
    }

    bool OnGossipHello(Player* pPlayer, Creature* creature)
    {
        InstanceScript* instance = creature->GetInstanceScript();

        if (Creature* pLeviathan = instance->instance->GetCreature(instance->GetData64(BOSS_LEVIATHAN)))
            if(pLeviathan->isInCombat())
                return true;

        if (instance && instance->GetData(BOSS_LEVIATHAN) !=DONE && pPlayer)
        {
            pPlayer->PrepareGossipMenu(creature);
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_ITEM_3,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+3);
            if (pPlayer->isGameMaster())
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_ITEM_1,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);            
            pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(creature), creature->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lorekeeperAI (creature);
    }

    struct npc_lorekeeperAI : public ScriptedAI
    {
        npc_lorekeeperAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        SummonList summons;

        void JustSummoned(Creature *summon)
        {
            summons.Summon(summon);
        }

        void DoAction(const int32 uiAction)
        {
            // Start encounter
            if (uiAction == 0)
            {
                summons.DespawnAll();
                for (int32 i = 0; i < RAID_MODE(2, 5); ++i)
                    DoSummon(VEHICLE_SIEGE, PosSiege[i], 3000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
                for (int32 i = 0; i < RAID_MODE(2, 5); ++i)
                    DoSummon(VEHICLE_CHOPPER, PosChopper[i], 3000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
                for (int32 i = 0; i < RAID_MODE(2, 5); ++i)
                {
                    if (Creature* summon = DoSummon(VEHICLE_DEMOLISHER, PosDemolisher[i], 3000, TEMPSUMMON_CORPSE_TIMED_DESPAWN))                        
                        summon->SetPower(POWER_ENERGY,summon->GetMaxPower(POWER_ENERGY));
                }
                return;
            }
        }
    };
};

class go_ulduar_tower : public GameObjectScript
{
public:
    go_ulduar_tower() : GameObjectScript("go_ulduar_tower") { }

    void OnDestroyed(GameObject* pGO, Player* /*pPlayer*/,  uint32 /*value*/)
    {
        InstanceScript* instance = pGO->GetInstanceScript();
        if (!instance)
            return;
            
        switch(pGO->GetEntry())
        {
            case GO_TOWER_OF_STORMS:
                instance->SetData(DATA_TOWER_DESTROYED, TOWER_OF_STORM_DESTROYED);
                pGO->MonsterTextEmote("Tower of Storms destroyed!", 0, true);
                break;
            case GO_TOWER_OF_LIFE:
                instance->SetData(DATA_TOWER_DESTROYED, TOWER_OF_LIFE_DESTROYED);
                pGO->MonsterTextEmote("Tower of Life destroyed!", 0, true);
                break;            
            case GO_TOWER_OF_FLAMES:
                instance->SetData(DATA_TOWER_DESTROYED, TOWER_OF_FLAMES_DESTROYED);
                pGO->MonsterTextEmote("Tower of Flames destroyed!", 0, true);
                break;
            case GO_TOWER_OF_FROST:
                instance->SetData(DATA_TOWER_DESTROYED, TOWER_OF_FROST_DESTROYED);
                pGO->MonsterTextEmote("Tower of Frost destroyed!", 0, true);
                break;
        }

        Creature* trigger = pGO->FindNearestCreature(NPC_ULDUAR_GAUNTLET_GENERATOR, 15.0f, true);
        if (trigger)
            trigger->DisappearAndDie();
    }
};

class mob_steelforged_defender : public CreatureScript
{
    public:
        mob_steelforged_defender() : CreatureScript("mob_steelforged_defender") { }

    struct mob_steelforged_defenderAI : public ScriptedAI
    {
       mob_steelforged_defenderAI(Creature *c) : ScriptedAI(c)
       {
           pInstance = me->GetInstanceScript();
       }

       InstanceScript* pInstance;

       void JustDied(Unit* victim)
       {
           if(pInstance->GetData(DATA_DWARFAGEDDON) == ACHI_IS_NOT_STARTED)
               pInstance->SetData(DATA_DWARFAGEDDON, ACHI_START);
           
           pInstance->SetData(DATA_DWARFAGEDDON, ACHI_INCREASE);
       }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_steelforged_defenderAI (creature);
    };
};

class ulduar_repair_npc : public CreatureScript
{
    public:
        ulduar_repair_npc(): CreatureScript("ulduar_repair_npc") {}

    bool OnGossipHello(Player* player, Creature* _Creature)
    {
        if (!player)
            return true;

        player->ADD_GOSSIP_ITEM( 5, "Repair Chopper"         , GOSSIP_SENDER_MAIN, 1005);
        player->ADD_GOSSIP_ITEM( 5, "Repair Siege"           , GOSSIP_SENDER_MAIN, 1010);
        player->ADD_GOSSIP_ITEM( 5, "Repair Demolisher"      , GOSSIP_SENDER_MAIN, 1015);
         
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());

        return true;
    };

    void SendDefaultMenu_ulduar_repair_npc(Player* player, Creature* _Creature, uint32 action)
    {
        if (!player)
            return;

        // Not allow in combat
        if (!player->getAttackers().empty())
        {
            player->CLOSE_GOSSIP_MENU();
            _Creature->MonsterSay("Sei in combat!", LANG_UNIVERSAL, 0);
            return;
        }

        if (InstanceScript* data = player->GetInstanceScript())
            if (data->GetBossState(BOSS_LEVIATHAN) == IN_PROGRESS)
            {
                player->CLOSE_GOSSIP_MENU();
                _Creature->MonsterSay("Sei in combat con il leviathan!", LANG_UNIVERSAL, 0);
                return;            
            }
        
        switch(action)
        {
            case 1005: //Chopper
                if (Creature* vehicle = _Creature->FindNearestCreature(VEHICLE_CHOPPER, 20))
                {
                    if (vehicle->GetHealth() != vehicle->GetMaxHealth())
                    {
                        vehicle->SetHealth(vehicle->GetMaxHealth());
                        _Creature->MonsterSay("Chopper riparato!", LANG_UNIVERSAL, 0);
                        if (InstanceScript *data = player->GetInstanceScript())
                            data->SetData(DATA_ACHI_UNBROKEN, ACHI_FAILED);
                    }
                    else
                        _Creature->MonsterSay("Il chopper non ha bisogno di riparazioni!", LANG_UNIVERSAL, 0);
                }
                else
                    _Creature->MonsterSay("Non trovo un chopper nelle vicinanze", LANG_UNIVERSAL, 0);
                player->CLOSE_GOSSIP_MENU();
                break;
            case 1010: //Siege
                if (Creature* vehicle = _Creature->FindNearestCreature(VEHICLE_SIEGE, 20))
                {
                    if (vehicle->GetHealth() != vehicle->GetMaxHealth())
                    {
                        vehicle->SetHealth(vehicle->GetMaxHealth());
                        _Creature->MonsterSay("Siege riparato!", LANG_UNIVERSAL, 0);
                        if (InstanceScript *data = player->GetInstanceScript())
                            data->SetData(DATA_ACHI_UNBROKEN, ACHI_FAILED);
                    }
                    else
                        _Creature->MonsterSay("Il siege non ha bisogno di riparazioni!", LANG_UNIVERSAL, 0);
                }
                else
                    _Creature->MonsterSay("Non trovo un siege nelle vicinanze", LANG_UNIVERSAL, 0);
                player->CLOSE_GOSSIP_MENU();
                break; 
            case 1015: //Demolisher
                if (Creature* vehicle = _Creature->FindNearestCreature(VEHICLE_DEMOLISHER, 20))
                {
                    if ((vehicle->GetHealth() != vehicle->GetMaxHealth()) || (vehicle->GetPower(POWER_ENERGY) != vehicle->GetMaxPower(POWER_ENERGY)))
                    {
                        vehicle->SetHealth(vehicle->GetMaxHealth());
                        vehicle->SetPower(POWER_ENERGY,vehicle->GetMaxPower(POWER_ENERGY));
                        _Creature->MonsterSay("Demolisher riparato!", LANG_UNIVERSAL, 0);
                        if (InstanceScript *data = player->GetInstanceScript())
                            data->SetData(DATA_ACHI_UNBROKEN, ACHI_FAILED);
                    }
                    else
                        _Creature->MonsterSay("Il demolisher non ha bisogno di riparazioni!", LANG_UNIVERSAL, 0);
                }
                else
                    _Creature->MonsterSay("Non trovo un demolisher nelle vicinanze", LANG_UNIVERSAL, 0);
                player->CLOSE_GOSSIP_MENU();
                break; 
        }
    };

    bool OnGossipSelect(Player* pPlayer, Creature* _Creature, uint32 sender, uint32 action)
    {
        pPlayer->PlayerTalkClass->ClearMenus();

        // Main menu
        if (sender == GOSSIP_SENDER_MAIN)
            SendDefaultMenu_ulduar_repair_npc( pPlayer, _Creature, action );

        return true;
    };
};

// criteria_id = 10046 (10) / 10049 (25)
class achievement_three_car_garage_chopper : public AchievementCriteriaScript
{
    public:
        achievement_three_car_garage_chopper() : AchievementCriteriaScript("achievement_three_car_garage_chopper") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            if (Creature* vehicle = source->GetVehicleCreatureBase())
                if (vehicle->GetEntry() == VEHICLE_CHOPPER)
                    return true;

            return false;
        }
};

// criteria_id = 10047 (10) / 10050 (25)
class achievement_three_car_garage_siege : public AchievementCriteriaScript
{
    public:
        achievement_three_car_garage_siege() : AchievementCriteriaScript("achievement_three_car_garage_siege") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            if (Creature* vehicle = source->GetVehicleCreatureBase())
                if (vehicle->GetEntry() == VEHICLE_SIEGE)
                    return true;

            return false;
        }
};

// criteria_id = 10048 (10) / 10051 (25)
class achievement_three_car_garage_demolisher : public AchievementCriteriaScript
{
    public:
        achievement_three_car_garage_demolisher() : AchievementCriteriaScript("achievement_three_car_garage_demolisher") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            if (Creature* vehicle = source->GetVehicleCreatureBase())
                if (vehicle->GetEntry() == VEHICLE_DEMOLISHER)
                    return true;

            return false;
        }
};

class spell_load_into_catapult : public SpellScriptLoader
{
    enum Spells
    {
        SPELL_PASSENGER_LOADED = 62340,
    };

    public:
        spell_load_into_catapult() : SpellScriptLoader("spell_load_into_catapult") { }

        class spell_load_into_catapult_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_load_into_catapult_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* owner = GetOwner()->ToUnit();
                if (!owner)
                    return;

                owner->CastSpell(owner, SPELL_PASSENGER_LOADED, true);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* owner = GetOwner()->ToUnit();
                if (!owner)
                    return;

                owner->RemoveAurasDueToSpell(SPELL_PASSENGER_LOADED);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_load_into_catapult_AuraScript::OnApply, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_load_into_catapult_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_load_into_catapult_AuraScript();
        }
};

class spell_auto_repair : public SpellScriptLoader
{
    enum Spells
    {
        SPELL_AUTO_REPAIR = 62705,
    };

    public:
        spell_auto_repair() : SpellScriptLoader("spell_auto_repair") {}

        class spell_auto_repair_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_auto_repair_SpellScript);

            void CheckCooldownForTarget()
            {
                if (GetHitUnit()->HasAuraEffect(SPELL_AUTO_REPAIR, EFFECT_2))   // Check presence of dummy aura indicating cooldown
                {
                    PreventHitEffect(EFFECT_0);
                    PreventHitDefaultEffect(EFFECT_1);
                    PreventHitDefaultEffect(EFFECT_2);
                    //! Currently this doesn't work: if we call PreventHitAura(), the existing aura will be removed
                    //! because of recent aura refreshing changes. Since removing the existing aura negates the idea
                    //! of a cooldown marker, we just let the dummy aura refresh itself without executing the other spelleffects.
                    //! The spelleffects can be executed by letting the dummy aura expire naturally.
                    //! This is a temporary solution only.
                    //PreventHitAura();
                }
            }

            void HandleScript(SpellEffIndex /*eff*/)
            {
                Vehicle* vehicle = GetHitUnit()->GetVehicleKit();
                if (!vehicle)
                    return;

                Player* driver = vehicle->GetPassenger(0) ? vehicle->GetPassenger(0)->ToPlayer() : NULL;
                if (!driver)
                    return;

                driver->MonsterTextEmote(EMOTE_REPAIR, driver->GetGUID(), true);

                InstanceScript* instance = driver->GetInstanceScript();
                if (!instance)
                    return;

                // Actually should/could use basepoints (100) for this spell effect as percentage of health, but oh well.
                vehicle->GetBase()->SetFullHealth();
                
                instance->SetData(DATA_ACHI_UNBROKEN, ACHI_FAILED);            

                // For achievement
                //instance->SetData(DATA_UNBROKEN, 0);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_auto_repair_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
                BeforeHit += SpellHitFn(spell_auto_repair_SpellScript::CheckCooldownForTarget);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_auto_repair_SpellScript();
        }
};

void AddSC_boss_flame_leviathan()
{
    new boss_flame_leviathan();
    new boss_flame_leviathan_seat();
    new boss_flame_leviathan_defense_cannon();
    new boss_flame_leviathan_defense_turret();
    new boss_flame_leviathan_overload_device();
    new boss_flame_leviathan_safety_container();
    new npc_mechanolift();
    new npc_pool_of_tar();
    new npc_colossus();
    new npc_thorims_hammer();
    new npc_mimirons_inferno();
    new npc_hodirs_fury();
    new npc_freyas_ward();
    new npc_freya_ward_summon();
    new npc_lorekeeper();
    new go_ulduar_tower();

    new mob_flameleviathan_loot();
    new mob_steelforged_defender();
    new ulduar_repair_npc();
    new achievement_three_car_garage_chopper();
    new achievement_three_car_garage_siege();
    new achievement_three_car_garage_demolisher();

    new spell_load_into_catapult();
    new spell_auto_repair();
}
