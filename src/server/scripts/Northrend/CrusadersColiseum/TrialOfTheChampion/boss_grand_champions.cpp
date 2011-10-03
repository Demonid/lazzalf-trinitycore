/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: boss_grand_champions
SD%Complete: 50 %
SDComment: Is missing the ai to make the npcs look for a new mount and use it.
SDCategory: Trial Of the Champion
EndScriptData */

/*TODO: Nel primo incontro l'apertura del cancello � legata al fatto
che 3 dei 5 boss hanno nella funzione JustKilled il codice che permette
alla porta di aprirsi. Questo approccio non � propriamente corretto
perch� il cancello non deve aprirsi finch� TUTTI e 3 i boss non sono
morti e non durante l'incontro (come pu� succedere ora)*/

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"
#include "Vehicle.h"
#include "trial_of_the_champion.h"

enum eSpells
{
    //Vehicle
	
    SPELL_SHIELD_BREAKER            = 68504,
    SPELL_SHIELD                    = 62544,
	SPELL_THRUST					= 68505,
	SPELL_SHIELD_1					= 66482,
	SPELL_CHARGE					= 63010,
	
    // Marshal Jacob Alerius && Mokra the Skullcrusher || Warrior
    SPELL_MORTAL_STRIKE             = 68783,
    SPELL_MORTAL_STRIKE_H           = 68784,
    SPELL_BLADESTORM                = 63784,
    SPELL_INTERCEPT                 = 67540,
    SPELL_ROLLING_THROW             = 47115, //not implemented in the AI yet...

    // Ambrose Boltspark && Eressea Dawnsinger || Mage
    SPELL_FIREBALL                  = 66042,
    SPELL_FIREBALL_H                = 68310,
    SPELL_BLAST_WAVE                = 66044,
    SPELL_BLAST_WAVE_H              = 68312,
    SPELL_HASTE                     = 66045,
    SPELL_POLYMORPH                 = 66043,
    SPELL_POLYMORPH_H               = 68311,

    // Colosos && Runok Wildmane || Shaman
    SPELL_CHAIN_LIGHTNING           = 67529,
    SPELL_CHAIN_LIGHTNING_H         = 68319,
    SPELL_EARTH_SHIELD              = 67530,
    SPELL_HEALING_WAVE              = 67528,
    SPELL_HEALING_WAVE_H            = 68318,
    SPELL_HEX_OF_MENDING            = 67534,

    // Jaelyne Evensong && Zul'tore || Hunter
    SPELL_DISENGAGE                 = 68340, //not implemented in the AI yet...
    SPELL_LIGHTNING_ARROWS          = 66083,
    SPELL_MULTI_SHOT                = 49047,
    SPELL_SHOOT                     = 65868,
    SPELL_SHOOT_H                   = 67988,

    // Lana Stouthammer Evensong && Deathstalker Visceri || Rouge
    SPELL_EVISCERATE                = 67709,
    SPELL_EVISCERATE_H              = 68317,
    SPELL_FAN_OF_KNIVES             = 67706,
    SPELL_POISON_BOTTLE             = 67701,

    KILL_CREDIT                     = 68572,
};
enum eEnums
{
    SAY_START                       = -1999939,
    SAY_START2                      = -1999937
};
	
enum eSeat
{
    SEAT_ID_0                       = 0
};

/*
struct Point
{
    float x,y,z;
};

const Point MovementPoint[] =
{
  {746.84f,623.15f,411.41f},
  {747.96f,620.29f,411.09f},
  {750.23f,618.35f,411.09f}
};
*/
void AggroAllPlayers(Creature* pTemp)
{
    Map::PlayerList const &PlList = pTemp->GetMap()->GetPlayers();

    if(PlList.isEmpty())
            return;

    for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
    {
        if(Player* pPlayer = i->getSource())
        {
            if(pPlayer->isGameMaster())
                continue;

            if(pPlayer->isAlive())
            {
                pTemp->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
                pTemp->SetReactState(REACT_AGGRESSIVE);
                pTemp->SetInCombatWith(pPlayer);
                pPlayer->SetInCombatWith(pTemp);
                pTemp->AddThreat(pPlayer, 0.0f);
            }
        }
    }
}

bool GrandChampionsOutVehicle(Creature* me)
{
    InstanceScript* pInstance = me->GetInstanceScript();

    if (!pInstance)
        return false;

    Creature* pGrandChampion1 = Unit::GetCreature(*me, pInstance->GetData64(DATA_GRAND_CHAMPION_1));
    Creature* pGrandChampion2 = Unit::GetCreature(*me, pInstance->GetData64(DATA_GRAND_CHAMPION_2));
    Creature* pGrandChampion3 = Unit::GetCreature(*me, pInstance->GetData64(DATA_GRAND_CHAMPION_3));

    if (pGrandChampion1 && pGrandChampion2 && pGrandChampion3)
    {
        if (!pGrandChampion1->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) &&
            !pGrandChampion2->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT)  &&
            !pGrandChampion3->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) )
        {
            pInstance->SetData(DATA_REMOVE_MOUNT, 0);            
            return true;
        }
    }

    return false;
}

/*
* Generic AI for vehicles used by npcs in ToC, it needs more improvements.  *
* Script Complete: 25%.                                                     *
*/
class generic_vehicleAI_toc5 : public CreatureScript
{
    public:
        generic_vehicleAI_toc5(): CreatureScript("generic_vehicleAI_toc5") {}

    struct generic_vehicleAI_toc5AI : public npc_escortAI
    {
        generic_vehicleAI_toc5AI(Creature* creature) : npc_escortAI(creature)
        {
		    hasBeenInCombat = false;
            SetDespawnAtEnd(false);
            uiWaypointPath = 0;
		    uiCheckTimer=5000;
            pInstance = creature->GetInstanceScript();
        }



        InstanceScript* pInstance;
    	
	    bool hasBeenInCombat;

        uint32 uiShieldBreakerTimer;
        uint32 uiChargeTimer;
    	
	    uint32 uiTimerSpell1;
	    uint32 uiTimerSpell2;
	    uint32 uiTimerSpell3;
        
	    uint32 uiBuffTimer;
	    uint32 uiCheckTimer;
        uint32 uiWaypointPath;

        void Reset()
        {
            uiShieldBreakerTimer = 8000;
            uiChargeTimer = 5000;
            uiBuffTimer = urand(30000,60000);
		    uiTimerSpell1= urand(4000,10000);
		    uiTimerSpell2= urand(4000,10000);
		    uiTimerSpell3= urand(1000,2000);
        }

        void SetData(uint32 uiType, uint32 uiData)
        {
            switch(uiType)
            {
                case 1:
                    AddWaypoint(0, 746.45f, 647.03f, 411.57f);
                    AddWaypoint(1, 771.434f, 642.606f, 411.9f);
                    AddWaypoint(2, 779.807f, 617.535f, 411.716f);
                    AddWaypoint(3, 771.098f, 594.635f, 411.625f);
				    AddWaypoint(4, 746.887f, 583.425f, 411.668f);
				    AddWaypoint(5, 715.176f, 583.782f, 412.394f);
				    AddWaypoint(6, 720.719f, 591.141f, 411.737f);
                    uiWaypointPath = 1;
                    break;
                case 2:
                    AddWaypoint(0, 746.45f, 647.03f, 411.57f);
                    AddWaypoint(1, 771.434f, 642.606f, 411.9f);
                    AddWaypoint(2, 779.807f, 617.535f, 411.716f);
                    AddWaypoint(3, 771.098f, 594.635f, 411.625f);
				    AddWaypoint(4, 746.887f, 583.425f, 411.668f);
				    AddWaypoint(5, 746.16f, 571.678f, 412.389f);
				    AddWaypoint(6, 746.887f, 583.425f, 411.668f);
                    uiWaypointPath = 2;
                    break;
                case 3:
                    AddWaypoint(0, 746.45f, 647.03f, 411.57f);
                    AddWaypoint(1, 771.434f, 642.606f, 411.9f);
                    AddWaypoint(2, 779.807f, 617.535f, 411.716f);
                    AddWaypoint(3, 771.098f, 594.635f, 411.625f);
				    AddWaypoint(4, 777.759f, 584.577f, 412.393f);
				    AddWaypoint(5, 772.48f, 592.99f, 411.68f);
                    uiWaypointPath = 3;
                    break;
            }

            if (uiType <= 3)
                Start(false,true,0,NULL);
        }

        void WaypointReached(uint32 i)
        {
            switch(i)
            {
                case 2:
                    if ((pInstance && uiWaypointPath == 3) || uiWaypointPath == 2)
                        pInstance->SetData(DATA_MOVEMENT_DONE, pInstance->GetData(DATA_MOVEMENT_DONE)+1);
                    break;
                case 3:
                    if (pInstance)
                        pInstance->SetData(DATA_MOVEMENT_DONE, pInstance->GetData(DATA_MOVEMENT_DONE)+1);
                    break;
            }
        }

        void EnterCombat(Unit* pWho)
        {
		    hasBeenInCombat = true;
            DoCastSpellShield();
        }
	    bool CheckPlayersAlive()
	    {
		    Map* pMap = me->GetMap();
		    if (pMap && pMap->IsDungeon())
            {
    			
			    Map::PlayerList const &players = pMap->GetPlayers();
			    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
			    {
					    if(itr->getSource() && itr->getSource()->isAlive() && !itr->getSource()->isGameMaster())
					    return true;				
			    }
		    }
		    return false;
	    }

        void DoCastSpellShield()
        {
            for (uint8 i = 0; i < 3; ++i)
                DoCast(me,SPELL_SHIELD,true);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;

            if (uiBuffTimer <= uiDiff)
            {
                if (!me->HasAura(SPELL_SHIELD))
                    DoCastSpellShield();

                uiBuffTimer = urand(30000,45000);
            }else uiBuffTimer -= uiDiff;

            if (uiChargeTimer <= uiDiff)
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                if (me->GetMap()->IsDungeon() && !players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* pPlayer = itr->getSource();
                        if (pPlayer && !pPlayer->isGameMaster() && me->IsInRange(pPlayer,8.0f,25.0f,false) && pPlayer->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
                        {
                            Creature* pVehicle = pPlayer->GetVehicleBase()->ToCreature();
                            if (pVehicle)
                            {
                                DoResetThreat();
                                me->AddThreat(pVehicle,1.0f);
                                DoCast(pVehicle, SPELL_CHARGE);
                            }
                            break;
                        }
                    }
                }
                uiChargeTimer = 5000;
            }else uiChargeTimer -= uiDiff;

            //dosen't work at all
            if (uiShieldBreakerTimer <= uiDiff)
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                if (me->GetMap()->IsDungeon() && !players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* pPlayer = itr->getSource();
                        if (pPlayer && !pPlayer->isGameMaster() && me->IsInRange(pPlayer,10.0f,30.0f,false) && pPlayer->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
                        {
                            Creature* pVehicle = pPlayer->GetVehicleBase()->ToCreature();
                            if (pVehicle)
                            {
                                DoResetThreat();
                                me->AddThreat(pVehicle,1.0f);
                                DoCast(pVehicle,SPELL_SHIELD_BREAKER);
                            }
                            break;
                        }
                    }
                }
                uiShieldBreakerTimer = 7000;
            }else uiShieldBreakerTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new generic_vehicleAI_toc5AI(creature);
    };
};

// Marshal Jacob Alerius && Mokra the Skullcrusher || Warrior
class boss_warrior_toc5 : public CreatureScript
{
    public:
        boss_warrior_toc5(): CreatureScript("boss_warrior_toc5") {}

    struct boss_warrior_toc5AI : public BossAI
    {
        boss_warrior_toc5AI(Creature* creature) : BossAI(creature,BOSS_GRAND_CHAMPIONS)
        {
            pInstance = creature->GetInstanceScript();

            bDone = false;
            bHome = false;

		    hasBeenInCombat = false;

            uiPhase = 0;
            uiPhaseTimer = 0;

            me->SetReactState(REACT_PASSIVE);
            // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
        }

        InstanceScript* pInstance;

        uint8 uiPhase;
        uint32 uiPhaseTimer;
        
        uint32 uiBladeStormTimer;
        uint32 uiInterceptTimer;
        uint32 uiMortalStrikeTimer;
        uint32 uiAttackTimer;

        bool bDone;
        bool bHome;

	    bool hasBeenInCombat;	

        void Reset()
        {
            uiBladeStormTimer = urand(15000,20000);
            uiInterceptTimer  = 7000;
            uiMortalStrikeTimer = urand(8000,12000);

		    Map* pMap = me->GetMap();
		    if (hasBeenInCombat && pMap && pMap->IsDungeon())
            {
			    Map::PlayerList const &players = pMap->GetPlayers();
			    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
			    {
				    if(itr->getSource() && itr->getSource()->isAlive() && !itr->getSource()->isGameMaster())
				        return; //se almeno un player � vivo, esce						
			    }
    			
			    if(pInstance)
			    {
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
                    pInstance->SetData(DATA_WARRIOR_KILLED, FAIL);

			        if(GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                        pInstance->HandleGameObject(GO->GetGUID(),true);
    			
			    }
			    me->RemoveFromWorld();
                //ResetEncounter();
		    }
	    }

        void JustReachedHome()
        {
            ScriptedAI::JustReachedHome();

            if (!bHome)
                return;

            uiPhaseTimer = 15000;
            uiPhase = 1;

            bHome = false;
        }

	    void EnterCombat(Unit* pWho)
        {
		    _EnterCombat();
		    hasBeenInCombat = true;
    		
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!bDone && GrandChampionsOutVehicle(me))
            {
                bDone = true;

    			
 		    DoScriptText(SAY_START2, me);	

                if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                    me->SetHomePosition(739.678f,662.541f,412.393f,4.49f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                    me->SetHomePosition(746.71f,661.02f,411.69f,4.6f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                    me->SetHomePosition(754.34f,660.70f,412.39f,4.79f);

                EnterEvadeMode();
                bHome = true;
            }

            if (uiPhaseTimer <= uiDiff)
            {
                if (uiPhase == 1)
                {
                    AggroAllPlayers(me);
                    uiPhase = 0;
                }
            }else uiPhaseTimer -= uiDiff;

            if (!UpdateVictim() || me->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
                return;

            if (uiInterceptTimer <= uiDiff)
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                if (me->GetMap()->IsDungeon() && !players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* pPlayer = itr->getSource();
                        if (pPlayer && !pPlayer->isGameMaster() && me->IsInRange(pPlayer,8.0f,25.0f,false))
                        {
                            DoResetThreat();
                            me->AddThreat(pPlayer,5.0f);
                            DoCast(pPlayer,SPELL_INTERCEPT);
                            break;
                        }
                    }
                }
                uiInterceptTimer = 25000;
            } else uiInterceptTimer -= uiDiff;

            if (uiBladeStormTimer <= uiDiff)
            {
                DoCastVictim(SPELL_BLADESTORM);
                uiBladeStormTimer = urand(25000,35000);
            } else uiBladeStormTimer -= uiDiff;

            if (uiMortalStrikeTimer <= uiDiff)
            {
                DoCastVictim(DUNGEON_MODE(SPELL_MORTAL_STRIKE, SPELL_MORTAL_STRIKE_H));
                uiMortalStrikeTimer = urand(22000,26000);
            } else uiMortalStrikeTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer)
        {
	 	    hasBeenInCombat = false;	
		    DoScriptText(SAY_START, me);	
            if (pInstance)
            {
                pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);
                pInstance->SetData(DATA_WARRIOR_KILLED, DONE);
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, KILL_CREDIT);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_warrior_toc5AI(creature);
    };
};

// Ambrose Boltspark && Eressea Dawnsinger || Mage
class boss_mage_toc5 : public CreatureScript
{
    public:
        boss_mage_toc5(): CreatureScript("boss_mage_toc5") {}

    struct boss_mage_toc5AI : public BossAI
    {
        boss_mage_toc5AI(Creature* creature) : BossAI(creature,BOSS_GRAND_CHAMPIONS)
        {
            pInstance = creature->GetInstanceScript();

            bDone = false;
            bHome = false;

		    hasBeenInCombat = false;

            uiPhase = 0;
            uiPhaseTimer = 0;

            me->SetReactState(REACT_PASSIVE);
            // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
        }

        InstanceScript* pInstance;

        uint8 uiPhase;
        uint32 uiPhaseTimer;

        uint32 uiFireBallTimer;
        uint32 uiBlastWaveTimer;
        uint32 uiHasteTimer;
        uint32 uiPolymorphTimer;

        bool bDone;
        bool bHome;

	    bool hasBeenInCombat;

        void Reset()
        {
            uiFireBallTimer = 5000;
            uiPolymorphTimer  = 8000;
            uiBlastWaveTimer = 12000;
            uiHasteTimer = 22000;
		    Map* pMap = me->GetMap();
		    if (hasBeenInCombat && pMap && pMap->IsDungeon())
            {
			    Map::PlayerList const &players = pMap->GetPlayers();
			    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
			    {
				    if(itr->getSource() && itr->getSource()->isAlive() && !itr->getSource()->isGameMaster())
				        return; //se almeno un player � vivo, esce						
			    }    			
			    
			    if(pInstance)
			    {
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
                    pInstance->SetData(DATA_MAGE_KILLED, FAIL);

			        if(GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                        pInstance->HandleGameObject(GO->GetGUID(),true);
    			
			    }
			    me->RemoveFromWorld();
                //ResetEncounter();
		    }
	    }
        void JustReachedHome()
        {
            ScriptedAI::JustReachedHome();

            if (!bHome)
                return;

            uiPhaseTimer = 15000;
            uiPhase = 1;

            bHome = false;
        }

	    void EnterCombat(Unit* pWho)
        {
		    _EnterCombat();
		    hasBeenInCombat = true;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!bDone && GrandChampionsOutVehicle(me))
            {
                bDone = true;

                if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                    me->SetHomePosition(739.678f,662.541f,412.393f,4.49f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                    me->SetHomePosition(746.71f,661.02f,411.69f,4.6f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                    me->SetHomePosition(754.34f,660.70f,412.39f,4.79f);

                if (pInstance)
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, IN_PROGRESS);

                EnterEvadeMode();
                bHome = true;
            }

            if (uiPhaseTimer <= uiDiff)
            {
                if (uiPhase == 1)
                {
                    AggroAllPlayers(me);
                    uiPhase = 0;
                }
            }else uiPhaseTimer -= uiDiff;

            if (!UpdateVictim() || me->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
                return;

            if (uiFireBallTimer <= uiDiff)
            {
                DoCastVictim(DUNGEON_MODE(SPELL_FIREBALL,SPELL_FIREBALL_H));
                uiFireBallTimer = 17000;
            } else uiFireBallTimer -= uiDiff;

            if (uiPolymorphTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(target, DUNGEON_MODE(SPELL_POLYMORPH,SPELL_POLYMORPH_H));
                uiPolymorphTimer = 22000;
            } else uiPolymorphTimer -= uiDiff;

            if (uiBlastWaveTimer <= uiDiff)
            {
                DoCastAOE(DUNGEON_MODE(SPELL_BLAST_WAVE,SPELL_BLAST_WAVE_H),false);
                uiBlastWaveTimer = 30000;
            } else uiBlastWaveTimer -= uiDiff;

            if (uiHasteTimer <= uiDiff)
            {
                me->InterruptNonMeleeSpells(true);

                DoCast(me,SPELL_HASTE);
                uiHasteTimer = 40000;
            } else uiHasteTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer)
        {
	 	    hasBeenInCombat = false;	
		    DoScriptText(SAY_START, me);	
            if (pInstance)
            {
                pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);
                pInstance->SetData(DATA_MAGE_KILLED, DONE);
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, KILL_CREDIT);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_mage_toc5AI(creature);
    };
};

// Colosos && Runok Wildmane || Shaman
class boss_shaman_toc5 : public CreatureScript
{
    public:
        boss_shaman_toc5(): CreatureScript("boss_shaman_toc5") {}

    struct boss_shaman_toc5AI : public BossAI
    {
        boss_shaman_toc5AI(Creature* creature) : BossAI(creature,BOSS_GRAND_CHAMPIONS)
        {
            pInstance = creature->GetInstanceScript();

            bDone = false;
            bHome = false;

		    hasBeenInCombat = false;

            uiPhase = 0;
            uiPhaseTimer = 0;

            me->SetReactState(REACT_PASSIVE);
            // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
        }

        InstanceScript* pInstance;

        uint8 uiPhase;
        uint32 uiPhaseTimer;

        uint32 uiChainLightningTimer;
        uint32 uiEartShieldTimer;
        uint32 uiHealingWaveTimer;
        uint32 uiHexMendingTimer;

        bool bDone;
        bool bHome;

	    bool hasBeenInCombat;

        void Reset()
        {
            uiChainLightningTimer = 16000;
            uiHealingWaveTimer = 12000;
            uiEartShieldTimer = urand(30000,35000);
            uiHexMendingTimer = urand(20000,25000);
		    Map* pMap = me->GetMap();
		    if (hasBeenInCombat && pMap && pMap->IsDungeon())
            {
			    Map::PlayerList const &players = pMap->GetPlayers();
			    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
			    {
				    if(itr->getSource() && itr->getSource()->isAlive() && !itr->getSource()->isGameMaster())
				        return; //se almeno un player � vivo, esce						
			    }

		        if(pInstance)
			    {
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
                    pInstance->SetData(DATA_SHAMAN_KILLED, FAIL);

			        if(GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                        pInstance->HandleGameObject(GO->GetGUID(),true);
    			
			    }
			    me->RemoveFromWorld();
			    //ResetEncounter();
		    }
	    }
        void EnterCombat(Unit* pWho)
        {
		    _EnterCombat();
            hasBeenInCombat = true;
		    DoCast(me,SPELL_EARTH_SHIELD);
            DoCast(pWho,SPELL_HEX_OF_MENDING);
        };

        void JustReachedHome()
        {
            ScriptedAI::JustReachedHome();

            if (!bHome)
                return;

            uiPhaseTimer = 15000;
            uiPhase = 1;

            bHome = false;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!bDone && GrandChampionsOutVehicle(me))
            {
                bDone = true;

                if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                    me->SetHomePosition(739.678f,662.541f,412.393f,4.49f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                    me->SetHomePosition(746.71f,661.02f,411.69f,4.6f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))

                if (pInstance)
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, IN_PROGRESS);

                EnterEvadeMode();
                bHome = true;
            }

            if (uiPhaseTimer <= uiDiff)
            {
                if (uiPhase == 1)
                {
                    AggroAllPlayers(me);
                    uiPhase = 0;
                }
            }else uiPhaseTimer -= uiDiff;

            if (!UpdateVictim() || me->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
                return;

            if (uiChainLightningTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(target,DUNGEON_MODE(SPELL_CHAIN_LIGHTNING,SPELL_CHAIN_LIGHTNING_H));

                uiChainLightningTimer = 23000;
            } else uiChainLightningTimer -= uiDiff;

            if (uiHealingWaveTimer <= uiDiff)
            {
                bool bChance = urand(0,1);

                if (!bChance)
                {
                    if (Unit* pFriend = DoSelectLowestHpFriendly(40))
                        DoCast(pFriend,DUNGEON_MODE(SPELL_HEALING_WAVE,SPELL_HEALING_WAVE_H));
                } else
                    DoCast(me,DUNGEON_MODE(SPELL_HEALING_WAVE,SPELL_HEALING_WAVE_H));

                uiHealingWaveTimer = 19000;
            } else uiHealingWaveTimer -= uiDiff;

            if (uiEartShieldTimer <= uiDiff)
            {
                DoCast(me,SPELL_EARTH_SHIELD);

                uiEartShieldTimer = urand(40000,45000);
            } else uiEartShieldTimer -= uiDiff;

            if (uiHexMendingTimer <= uiDiff)
            {
                DoCastVictim(SPELL_HEX_OF_MENDING,true);

                uiHexMendingTimer = urand(30000,35000);
            } else uiHexMendingTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer)
        {
	 	    hasBeenInCombat = false;	
		    DoScriptText(SAY_START, me);	
    			
            if (pInstance)
            {
                pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);
                pInstance->SetData(DATA_SHAMAN_KILLED, DONE);
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, KILL_CREDIT);

                //what a nonsense! -.-
		        if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                    pInstance->HandleGameObject(pGO->GetGUID(),true); 
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_shaman_toc5AI(creature);
    };
};

// Jaelyne Evensong && Zul'tore || Hunter
class boss_hunter_toc5 : public CreatureScript
{
    public:
        boss_hunter_toc5(): CreatureScript("boss_hunter_toc5") {}

    struct boss_hunter_toc5AI : public BossAI
    {
        boss_hunter_toc5AI(Creature* creature) : BossAI(creature,BOSS_GRAND_CHAMPIONS)
        {
            pInstance = creature->GetInstanceScript();

            bDone = false;
            bHome = false;
    		
		    hasBeenInCombat = false;

            uiPhase = 0;
            uiPhaseTimer = 0;

            me->SetReactState(REACT_PASSIVE);
            // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
        }

        InstanceScript* pInstance;

        uint8 uiPhase;
        uint32 uiPhaseTimer;

        uint32 uiShootTimer;
        uint32 uiDisengageCooldown;
        uint32 uiMultiShotTimer;
        uint32 uiLightningArrowsTimer;

        uint64 uiTargetGUID;

        bool bShoot;
        bool bDone;
        bool bHome;

	    bool hasBeenInCombat;

        void Reset()
        {
            uiShootTimer = 12000;
            uiMultiShotTimer = 0;
            uiLightningArrowsTimer = 7000;
            uiDisengageCooldown = 10000;

            uiTargetGUID = 0;

            bShoot = false;
		    Map* pMap = me->GetMap();
		    if (hasBeenInCombat && pMap && pMap->IsDungeon())
            {
			    Map::PlayerList const &players = pMap->GetPlayers();
			    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
			    {
				    if(itr->getSource() && itr->getSource()->isAlive() && !itr->getSource()->isGameMaster())
				        return; //se almeno un player � vivo, esce						
			    }
    			
			    if(pInstance)
			    {
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
                    pInstance->SetData(DATA_HUNTER_KILLED, FAIL);

			        if(GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                        pInstance->HandleGameObject(GO->GetGUID(),true);
    			
			    }
			    me->RemoveFromWorld();
			    //ResetEncounter();
		    }
	    }

        void JustReachedHome()
        {
            ScriptedAI::JustReachedHome();

            if (!bHome)
                return;

            uiPhaseTimer = 15000;
            uiPhase = 1;

            bHome = false;
        }

	    void EnterCombat(Unit* pWho)
        {
		    _EnterCombat();
		    hasBeenInCombat = true;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!bDone && GrandChampionsOutVehicle(me))
            {
                bDone = true;

                if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                    me->SetHomePosition(739.678f,662.541f,412.393f,4.49f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                    me->SetHomePosition(746.71f,661.02f,411.69f,4.6f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                    me->SetHomePosition(754.34f,660.70f,412.39f,4.79f);

                if (pInstance)
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, IN_PROGRESS);

                EnterEvadeMode();
                bHome = true;
            }
    				
            if (uiPhaseTimer <= uiDiff)
            {
                if (uiPhase == 1)
                {
                    AggroAllPlayers(me);
                    uiPhase = 0;
                }
            }else uiPhaseTimer -= uiDiff;

            if (!UpdateVictim() || me->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
                return;

            if (uiDisengageCooldown <= uiDiff)
            {
                if (me->IsWithinDistInMap(me->getVictim(), 5) && uiDisengageCooldown == 0)
                {
                    DoCast(me, SPELL_DISENGAGE);
                    uiDisengageCooldown = 35000;
                }
                uiDisengageCooldown = 20000;
            }else uiDisengageCooldown -= uiDiff;
    		
            if (uiLightningArrowsTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(target,SPELL_LIGHTNING_ARROWS);
    				
                uiLightningArrowsTimer = 15000;

            } else uiLightningArrowsTimer -= uiDiff;

            if (uiShootTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST,0,30.0f))
                {
                    uiTargetGUID = target->GetGUID();
                    DoCast(target, DUNGEON_MODE(SPELL_SHOOT,SPELL_SHOOT_H));
                }
                uiShootTimer = 19000;
                uiMultiShotTimer = 8000;
                bShoot = true;
            } else uiShootTimer -= uiDiff;

            if (bShoot && uiMultiShotTimer <= uiDiff)
            {
                me->InterruptNonMeleeSpells(true);
                Unit* target = Unit::GetUnit(*me, uiTargetGUID);

                if (target && me->IsInRange(target,5.0f,30.0f,false))
                {
                    DoCast(target,SPELL_MULTI_SHOT);
                } else
                {
                    Map::PlayerList const& players = me->GetMap()->GetPlayers();
                    if (me->GetMap()->IsDungeon() && !players.isEmpty())
                    {
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                        {
                            Player* pPlayer = itr->getSource();
                            if (pPlayer && !pPlayer->isGameMaster() && me->IsInRange(pPlayer,5.0f,30.0f,false))
                            {
                                DoCast(target,SPELL_MULTI_SHOT);
                                break;
                            }
                        }
                    }
                }
                bShoot = false;
            } else uiMultiShotTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer)
        {
	 	    hasBeenInCombat = false;	
		    DoScriptText(SAY_START, me);	
            if (pInstance)
            {
                pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);
                pInstance->SetData(DATA_HUNTER_KILLED, DONE);
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, KILL_CREDIT);

                //what a nonsense! -.-
		        if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                    pInstance->HandleGameObject(pGO->GetGUID(),true);
            }

        }    	
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_hunter_toc5AI(creature);
    };
};

// Lana Stouthammer Evensong && Deathstalker Visceri || Rouge
class boss_rouge_toc5 : public CreatureScript
{
    public:
        boss_rouge_toc5(): CreatureScript("boss_rouge_toc5") {}

    struct boss_rouge_toc5AI : public BossAI
    {
        boss_rouge_toc5AI(Creature* creature) : BossAI(creature,BOSS_GRAND_CHAMPIONS)
        {
            pInstance = creature->GetInstanceScript();

            bDone = false;
            bHome = false;

            uiPhase = 0;
            uiPhaseTimer = 0;

		    hasBeenInCombat = false;

            me->SetReactState(REACT_PASSIVE);
            // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
        }

        InstanceScript* pInstance;

        uint8 uiPhase;
        uint32 uiPhaseTimer;
        uint32 uiEviscerateTimer;
        uint32 uiFanKivesTimer;
        uint32 uiPosionBottleTimer;

        bool bDone;
        bool bHome;

	    bool hasBeenInCombat;

        void Reset()
        {
            uiEviscerateTimer = 8000;
            uiFanKivesTimer   = 14000;
            uiPosionBottleTimer = 19000;
		    Map* pMap = me->GetMap();

		    if (hasBeenInCombat && pMap && pMap->IsDungeon())
		    {
			    Map::PlayerList const &players = pMap->GetPlayers();
			    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
			    {
				    if(itr->getSource() && itr->getSource()->isAlive() && !itr->getSource()->isGameMaster())
					    return; //se almeno un player � vivo, esce						
			    }		   
    				 
			    if(pInstance)
			    {
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
                    pInstance->SetData(DATA_ROGUE_KILLED, FAIL);

			        if(GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                        pInstance->HandleGameObject(GO->GetGUID(),true);
    			
			    }
			    me->RemoveFromWorld();
			    //ResetEncounter();
		    }
    		
	    }

        void JustReachedHome()
        {
            ScriptedAI::JustReachedHome();

            if (!bHome)
                return;

            uiPhaseTimer = 15000;
            uiPhase = 1;

            bHome = false;
        }

	    void EnterCombat(Unit* pWho)
        {
		    _EnterCombat();
		    hasBeenInCombat = true;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!bDone && GrandChampionsOutVehicle(me))
            {
                bDone = true;

                if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                    me->SetHomePosition(739.678f,662.541f,412.393f,4.49f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                    me->SetHomePosition(746.71f,661.02f,411.69f,4.6f);
                else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                    me->SetHomePosition(754.34f,660.70f,412.39f,4.79f);

                if (pInstance)
                    pInstance->SetData(BOSS_GRAND_CHAMPIONS, IN_PROGRESS);

                EnterEvadeMode();
                bHome = true;
            }

            if (uiPhaseTimer <= uiDiff)
            {
                if (uiPhase == 1)
                {
                    AggroAllPlayers(me);
                    uiPhase = 0;
                }
            } else uiPhaseTimer -= uiDiff;

            if (!UpdateVictim() || me->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
                return;

            if (uiEviscerateTimer <= uiDiff)
            {
                DoCast(me->getVictim(),DUNGEON_MODE(SPELL_EVISCERATE,SPELL_EVISCERATE_H));
                uiEviscerateTimer = 22000;
            } else uiEviscerateTimer -= uiDiff;

            if (uiFanKivesTimer <= uiDiff)
            {
                DoCastAOE(SPELL_FAN_OF_KNIVES,false);
                uiFanKivesTimer = 20000;
            } else uiFanKivesTimer -= uiDiff;

            if (uiPosionBottleTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM,0))
                DoCast(target,SPELL_POISON_BOTTLE);
                uiPosionBottleTimer = 19000;
            } else uiPosionBottleTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer)
        {
		    hasBeenInCombat = false;
		    DoScriptText(SAY_START, me);	
            if (pInstance)
            {
                pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);
                pInstance->SetData(DATA_ROGUE_KILLED, DONE);
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, KILL_CREDIT);

                //what a nonsense! -.-
		        if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                    pInstance->HandleGameObject(pGO->GetGUID(),true);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_rouge_toc5AI(creature);
    };
};

#define TOC5_MAP 650

class achievement_criteria_warrior_toc5 : public AchievementCriteriaScript
{
    public:
        achievement_criteria_warrior_toc5() : AchievementCriteriaScript("achievement_criteria_warrior_toc5") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            InstanceScript* pInstance = source->GetInstanceScript();

            if (!pInstance || source->GetMapId() != TOC5_MAP)
                return false;

            if (pInstance->GetData(DATA_WARRIOR_KILLED) == DONE)
                return true;

            return false;
        }
};

class achievement_criteria_mage_toc5 : public AchievementCriteriaScript
{
    public:
        achievement_criteria_mage_toc5() : AchievementCriteriaScript("achievement_criteria_mage_toc5") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            InstanceScript* pInstance = source->GetInstanceScript();

            if (!pInstance || source->GetMapId() != TOC5_MAP)
                return false;

            if (pInstance->GetData(DATA_MAGE_KILLED) == DONE)
                return true;

            return false;
        }
};

class achievement_criteria_shaman_toc5 : public AchievementCriteriaScript
{
    public:
        achievement_criteria_shaman_toc5() : AchievementCriteriaScript("achievement_criteria_shaman_toc5") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            InstanceScript* pInstance = source->GetInstanceScript();

            if (!pInstance || source->GetMapId() != TOC5_MAP)
                return false;

            if (pInstance->GetData(DATA_SHAMAN_KILLED) == DONE)
                return true;

            return false;
        }
};

class achievement_criteria_hunter_toc5 : public AchievementCriteriaScript
{
    public:
        achievement_criteria_hunter_toc5() : AchievementCriteriaScript("achievement_criteria_hunter_toc5") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            InstanceScript* pInstance = source->GetInstanceScript();

            if (!pInstance || source->GetMapId() != TOC5_MAP)
                return false;

            if (pInstance->GetData(DATA_HUNTER_KILLED) == DONE)
                return true;

            return false;
        }
};

class achievement_criteria_rogue_toc5 : public AchievementCriteriaScript
{
    public:
        achievement_criteria_rogue_toc5() : AchievementCriteriaScript("achievement_criteria_rogue_toc5") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            InstanceScript* pInstance = source->GetInstanceScript();

            if (!pInstance || source->GetMapId() != TOC5_MAP)
                return false;

            if (pInstance->GetData(DATA_ROGUE_KILLED) == DONE)
                return true;

            return false;
        }
};

void AddSC_boss_grand_champions()
{
    new generic_vehicleAI_toc5();
    new boss_warrior_toc5();
    new boss_mage_toc5();
    new boss_shaman_toc5();
    new boss_hunter_toc5();
    new boss_rouge_toc5();
    new achievement_criteria_warrior_toc5();
    new achievement_criteria_mage_toc5();
    new achievement_criteria_shaman_toc5();
    new achievement_criteria_hunter_toc5();
    new achievement_criteria_rogue_toc5();
}
