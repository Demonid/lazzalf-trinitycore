/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

#include "ScriptedPch.h"
#include "ScriptedEscortAI.h"
#include "Vehicle.h"
#include "trial_of_the_champion.h"

enum eSpells
{
    //Vehicle
	
    SPELL_SHIELD_BREAKER            = 68504,
    SPELL_SHIELD                    = 62544,
	
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
    SPELL_POISON_BOTTLE             = 67701
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

struct Point
{
    float x,y,z;
};

const Point MovementPoint[] =
{
  {746.84,623.15,411.41},
  {747.96,620.29,411.09},
  {750.23,618.35,411.09}
};

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
    ScriptedInstance* pInstance = me->GetInstanceData();

    if (!pInstance)
        return false;

    Creature* pGrandChampion1 = Unit::GetCreature(*me, pInstance->GetData64(DATA_GRAND_CHAMPION_1));
    Creature* pGrandChampion2 = Unit::GetCreature(*me, pInstance->GetData64(DATA_GRAND_CHAMPION_2));
    Creature* pGrandChampion3 = Unit::GetCreature(*me, pInstance->GetData64(DATA_GRAND_CHAMPION_3));

    if (pGrandChampion1 && pGrandChampion2 && pGrandChampion3)
    {
        if (!pGrandChampion1->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) &&
            !pGrandChampion2->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) &&
            !pGrandChampion3->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
            return true;
    }

    return false;
}

/*
* Generic AI for vehicles used by npcs in ToC, it needs more improvements.  *
* Script Complete: 25%.                                                     *
*/

struct generic_vehicleAI_toc5AI : public npc_escortAI
{
    generic_vehicleAI_toc5AI(Creature* pCreature) : npc_escortAI(pCreature)
    {
		hasBeenInCombat = false;
        SetDespawnAtEnd(false);
        uiWaypointPath = 0;
		uiCheckTimer=5000;
        pInstance = pCreature->GetInstanceData();
    }



    ScriptedInstance* pInstance;
	
	bool hasBeenInCombat;

    uint32 uiShieldBreakerTimer;
    uint32 uiBuffTimer;
	uint32 uiCheckTimer;
    uint32 uiWaypointPath;

    void Reset()
    {
        uiShieldBreakerTimer = 8000;
        uiBuffTimer = urand(30000,60000);
		


    }

    void SetData(uint32 uiType, uint32 uiData)
    {
        switch(uiType)
        {
            case 1:
                AddWaypoint(0,746.45,647.03,411.57);
                AddWaypoint(1,771.434, 642.606, 411.9);
                AddWaypoint(2,779.807, 617.535, 411.716);
                AddWaypoint(3,771.098, 594.635, 411.625);
				AddWaypoint(4,746.887, 583.425, 411.668);
				AddWaypoint(5,715.176, 583.782, 412.394);
				AddWaypoint(6,720.719, 591.141, 411.737);
                uiWaypointPath = 1;
                break;
            case 2:
                AddWaypoint(0,746.45,647.03,411.57);
                AddWaypoint(1,771.434, 642.606, 411.9);
                AddWaypoint(2,779.807, 617.535, 411.716);
                AddWaypoint(3,771.098, 594.635, 411.625);
				AddWaypoint(4,746.887, 583.425, 411.668);
				AddWaypoint(5,746.16, 571.678, 412.389);
				AddWaypoint(6,746.887, 583.425, 411.668);
                uiWaypointPath = 2;
                break;
            case 3:
                AddWaypoint(0,746.45,647.03,411.57);
                AddWaypoint(1,771.434, 642.606, 411.9);
                AddWaypoint(2,779.807, 617.535, 411.716);
                AddWaypoint(3,771.098, 594.635, 411.625);
				AddWaypoint(4,777.759, 584.577, 412.393);
				AddWaypoint(5,772.48, 592.99, 411.68);
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
                if (pInstance && uiWaypointPath == 3 || uiWaypointPath == 2)
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
		
		if (uiCheckTimer <= uiDiff)
        {
			if(!CheckPlayersAlive())
				if(pInstance)
				{
					//DoScriptText(SAY_START2, me);
					pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
					GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
					if(GO)
						pInstance->HandleGameObject(GO->GetGUID(),true);
			 
					me->RemoveFromWorld();
				}
				
		uiCheckTimer=5000;
		}else uiCheckTimer -= uiDiff;
		
        if (!UpdateVictim())
            return;

        if (uiBuffTimer <= uiDiff)
        {
            if (!me->HasAura(SPELL_SHIELD))
                DoCastSpellShield();

            uiBuffTimer = urand(30000,45000);
        }else uiBuffTimer -= uiDiff;

        //dosen't work at all
        if (uiShieldBreakerTimer <= uiDiff)
        {
            Vehicle *pVehicle = me->GetVehicleKit();
            if (!pVehicle)
				return;


            if (Unit* pPassenger = pVehicle->GetPassenger(SEAT_ID_0))
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                if (me->GetMap()->IsDungeon() && !players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* pPlayer = itr->getSource();
                        if (pPlayer && !pPlayer->isGameMaster() && me->IsInRange(pPlayer,10.0f,30.0f,false))
                        {
                            pPassenger->CastSpell(pPlayer,SPELL_SHIELD_BREAKER,true);
                            break;
                        }
                    }
                }
            }
            uiShieldBreakerTimer = 7000;
        }else uiShieldBreakerTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_generic_vehicleAI_toc5(Creature* pCreature)
{
    return new generic_vehicleAI_toc5AI(pCreature);
}

// Marshal Jacob Alerius && Mokra the Skullcrusher || Warrior
struct boss_warrior_toc5AI : public ScriptedAI
{
    boss_warrior_toc5AI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();

        bDone = false;
        bHome = false;

		hasBeenInCombat = false;

        uiPhase = 0;
        uiPhaseTimer = 0;

        me->SetReactState(REACT_PASSIVE);
        // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
        me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
    }

    ScriptedInstance* pInstance;

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
			 pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
			 	 
			if(pInstance)
			{
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
			if(GO)
				pInstance->HandleGameObject(GO->GetGUID(),true);
			 
			// pInstance->SetData(BOSS_GRAND_CHAMPIONS, NOT_STARTED);
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
		hasBeenInCombat = true;
		
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!bDone && GrandChampionsOutVehicle(me))
        {
            bDone = true;

			
 		DoScriptText(SAY_START2, me);	

            if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                me->SetHomePosition(739.678,662.541,412.393,4.49);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                me->SetHomePosition(746.71,661.02,411.69,4.6);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                me->SetHomePosition(754.34,660.70,412.39,4.79);

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

    void JustDied(Unit* pKiller)
    {
	 	hasBeenInCombat = false;	
		DoScriptText(SAY_START, me);	
        if (pInstance)
            pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);
    }
	
	void ResetEncounter()
	{
		Creature* spawn_1;
		
		if(me)
		{
			Map *instance=me->GetMap();
			if(instance && pInstance)
			{
				//apri il cancello
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
				pInstance->HandleGameObject(GO->GetGUID(),true);
				
				/*sostanzialmente vede qual � il boss e respawna gli altri due solo se sono morti o despawnati, tenendo conto che 
				 *quelli gi� vivi respawnano da soli*/
				if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
				{
					Respawn(DATA_GRAND_CHAMPION_2,2);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_2,2);
					spawn_1 = me->SummonCreature(me->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
				}				
				
				//if(spawn_1) //perch� non si pu� mai essere troppo sicuri :S (appunto)
				//{
				//	spawn_1->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
				//	spawn_1->SetReactState(REACT_AGGRESSIVE);
				//}
				 //a questo punto il boss, vivo o morto che sia, viene despawnato
				me->RemoveFromWorld();
							
			}
		}			
	}

	void Respawn(uint32 id, int posizione)
	{
		Map *instance=me->GetMap();
		Creature* npc = instance->GetCreature(pInstance->GetData64(id)); //vediamo se c'� l'npc da respawnare
		Creature* spawn_2;

		if(!npc)
			return;

		if((npc && !(npc->isAlive()))) //ovvero se il boss c'� ma � morto oppure se il boss � gi� despawnato
		{
			switch(posizione)
			{
				case 1:
					spawn_2 = me->SummonCreature(npc->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 2:
					spawn_2 = me->SummonCreature(npc->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 3:
					spawn_2 = me->SummonCreature(npc->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
					break;
			}

			//if(spawn_2) //perch� non si pu� mai essere troppo sicuri :S (appunto)
			//{
			//	spawn_2->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
			//	spawn_2->SetReactState(REACT_AGGRESSIVE);
			//}

			if(npc) //solo se � ancora spawnato (quello vecchio) lo despawna
				npc->RemoveFromWorld();
		}
	}
};

CreatureAI* GetAI_boss_warrior_toc5(Creature* pCreature)
{
    return new boss_warrior_toc5AI(pCreature);
}

// Ambrose Boltspark && Eressea Dawnsinger || Mage
struct boss_mage_toc5AI : public ScriptedAI
{
    boss_mage_toc5AI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();

        bDone = false;
        bHome = false;

		hasBeenInCombat = false;

        uiPhase = 0;
        uiPhaseTimer = 0;

        me->SetReactState(REACT_PASSIVE);
        // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
        me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
    }

    ScriptedInstance* pInstance;

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
			
			//ResetEncounter();
			if(pInstance)
				 pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);

			 	 
			if(pInstance)
			{
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
			if(GO)
				pInstance->HandleGameObject(GO->GetGUID(),true);
			 
			}
			// pInstance->SetData(BOSS_GRAND_CHAMPIONS, NOT_STARTED);
			 me->RemoveFromWorld();
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
		hasBeenInCombat = true;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!bDone && GrandChampionsOutVehicle(me))
        {
            bDone = true;

            if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                me->SetHomePosition(739.678,662.541,412.393,4.49);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                me->SetHomePosition(746.71,661.02,411.69,4.6);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                me->SetHomePosition(754.34,660.70,412.39,4.79);

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
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(pTarget, DUNGEON_MODE(SPELL_POLYMORPH,SPELL_POLYMORPH_H));
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

    void JustDied(Unit* pKiller)
    {
	 	hasBeenInCombat = false;	
		DoScriptText(SAY_START, me);	
        if (pInstance)
            pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);
    }
		void ResetEncounter()
	{
		Creature* spawn_1;
		
		if(me)
		{
			Map *instance=me->GetMap();
			if(instance && pInstance)
			{
				//apri il cancello
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
				pInstance->HandleGameObject(GO->GetGUID(),true);
				
				/*sostanzialmente vede qual � il boss e respawna gli altri due solo se sono morti o despawnati, tenendo conto che 
				 *quelli gi� vivi respawnano da soli*/
				if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
				{
					Respawn(DATA_GRAND_CHAMPION_2,2);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_2,2);
					spawn_1 = me->SummonCreature(me->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
				}				
				
				//if(spawn_1) //perch� non si pu� mai essere troppo sicuri :S
				//{
				//	spawn_1->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
				//	spawn_1->SetReactState(REACT_AGGRESSIVE);
				//}
				 //a questo punto il boss, vivo o morto che sia, viene despawnato
				me->RemoveFromWorld();
							
			}
		}			
	}

	void Respawn(uint32 id, int posizione)
	{
		Map *instance=me->GetMap();
		Creature* npc = instance->GetCreature(pInstance->GetData64(id)); //vediamo se c'� l'npc da respawnare
		Creature* spawn_2;

		if(!npc)
			return;

		if((npc && !(npc->isAlive()))) //ovvero se il boss c'� ma � morto oppure se il boss � gi� despawnato
		{
			switch(posizione)
			{
				case 1:
					spawn_2 = me->SummonCreature(npc->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 2:
					spawn_2 = me->SummonCreature(npc->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 3:
					spawn_2 = me->SummonCreature(npc->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
					break;
			}

			//if(spawn_2) //perch� non si pu� mai essere troppo sicuri :S
			//{
			//	spawn_2->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
			//	spawn_2->SetReactState(REACT_AGGRESSIVE);
			//}

			if(npc) //solo se � ancora spawnato (quello vecchio) lo despawna
				npc->RemoveFromWorld();
		}
	}
};

CreatureAI* GetAI_boss_mage_toc5(Creature* pCreature)
{
    return new boss_mage_toc5AI(pCreature);
}

// Colosos && Runok Wildmane || Shaman
struct boss_shaman_toc5AI : public ScriptedAI
{
    boss_shaman_toc5AI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();

        bDone = false;
        bHome = false;

		hasBeenInCombat = false;

        uiPhase = 0;
        uiPhaseTimer = 0;

        me->SetReactState(REACT_PASSIVE);
        // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
        me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
    }

    ScriptedInstance* pInstance;

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
			pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
		 	 
		 if(pInstance)
		 {
			GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
		 if(GO)
			pInstance->HandleGameObject(GO->GetGUID(),true);
		  
		 }
		// pInstance->SetData(BOSS_GRAND_CHAMPIONS, NOT_STARTED);
		 //pInstance->SetData(DATA_MOVEMENT_DONE,DONE);
		 me->RemoveFromWorld();
			//ResetEncounter();
		}
	}
    void EnterCombat(Unit* pWho)
    {
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
                me->SetHomePosition(739.678,662.541,412.393,4.49);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                me->SetHomePosition(746.71,661.02,411.69,4.6);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                me->SetHomePosition(754.34,660.70,412.39,4.79);

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
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(pTarget,DUNGEON_MODE(SPELL_CHAIN_LIGHTNING,SPELL_CHAIN_LIGHTNING_H));

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

    void JustDied(Unit* pKiller)
    {
	 	hasBeenInCombat = false;	
		DoScriptText(SAY_START, me);	
			
        if (pInstance)
            pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);

		//what a nonsense! -.-
		if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                    pInstance->HandleGameObject(pGO->GetGUID(),true);
		

    }
	
	void ResetEncounter()
	{
		Creature* spawn_1;
		
		if(me)
		{
			Map *instance=me->GetMap();
			if(instance && pInstance)
			{
				//apri il cancello
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
				pInstance->HandleGameObject(GO->GetGUID(),true);
				
				/*sostanzialmente vede qual � il boss e respawna gli altri due solo se sono morti o despawnati, tenendo conto che 
				 *quelli gi� vivi respawnano da soli*/
				if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
				{
					Respawn(DATA_GRAND_CHAMPION_2,2);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_2,2);
					spawn_1 = me->SummonCreature(me->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
				}				
				
				//if(spawn_1) //perch� non si pu� mai essere troppo sicuri :S
				//{
				//	spawn_1->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
				//	spawn_1->SetReactState(REACT_AGGRESSIVE);
				//}
				 //a questo punto il boss, vivo o morto che sia, viene despawnato
				me->RemoveFromWorld();
							
			}
		}			
	}

	void Respawn(uint32 id, int posizione)
	{
		Map *instance=me->GetMap();
		Creature* npc = instance->GetCreature(pInstance->GetData64(id)); //vediamo se c'� l'npc da respawnare
		Creature* spawn_2;

		if(!npc)
			return;

		if((npc && !(npc->isAlive()))) //ovvero se il boss c'� ma � morto oppure se il boss � gi� despawnato
		{
			switch(posizione)
			{
				case 1:
					spawn_2 = me->SummonCreature(npc->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 2:
					spawn_2 = me->SummonCreature(npc->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 3:
					spawn_2 = me->SummonCreature(npc->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
					break;
			}

			//if(spawn_2) //perch� non si pu� mai essere troppo sicuri :S
			//{
			//	spawn_2->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
			//	spawn_2->SetReactState(REACT_AGGRESSIVE);
			//}

			if(npc) //solo se � ancora spawnato (quello vecchio) lo despawna
				npc->RemoveFromWorld();
		}
	}
};

CreatureAI* GetAI_boss_shaman_toc5(Creature* pCreature)
{
    return new boss_shaman_toc5AI(pCreature);
}

// Jaelyne Evensong && Zul'tore || Hunter
struct boss_hunter_toc5AI : public ScriptedAI
{
    boss_hunter_toc5AI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();

        bDone = false;
        bHome = false;
		
		hasBeenInCombat = false;

        uiPhase = 0;
        uiPhaseTimer = 0;

        me->SetReactState(REACT_PASSIVE);
        // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
        me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
    }

    ScriptedInstance* pInstance;

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
				pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
			 if(pInstance)
			 {
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
			 if(GO)
				pInstance->HandleGameObject(GO->GetGUID(),true);
			
			// pInstance->SetData(BOSS_GRAND_CHAMPIONS, NOT_STARTED);
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
		hasBeenInCombat = true;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!bDone && GrandChampionsOutVehicle(me))
        {
            bDone = true;

            if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                me->SetHomePosition(739.678,662.541,412.393,4.49);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                me->SetHomePosition(746.71,661.02,411.69,4.6);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                me->SetHomePosition(754.34,660.70,412.39,4.79);

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
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(pTarget,SPELL_LIGHTNING_ARROWS);
				
            uiLightningArrowsTimer = 15000;

        } else uiLightningArrowsTimer -= uiDiff;

        if (uiShootTimer <= uiDiff)
        {
            if (Unit* pTarget = SelectTarget(SELECT_TARGET_FARTHEST,0,30.0f))
            {
                uiTargetGUID = pTarget->GetGUID();
                DoCast(pTarget, DUNGEON_MODE(SPELL_SHOOT,SPELL_SHOOT_H));
            }
            uiShootTimer = 19000;
            uiMultiShotTimer = 8000;
            bShoot = true;
        } else uiShootTimer -= uiDiff;

        if (bShoot && uiMultiShotTimer <= uiDiff)
        {
            me->InterruptNonMeleeSpells(true);
            Unit* pTarget = Unit::GetUnit(*me, uiTargetGUID);

            if (pTarget && me->IsInRange(pTarget,5.0f,30.0f,false))
            {
                DoCast(pTarget,SPELL_MULTI_SHOT);
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
                            DoCast(pTarget,SPELL_MULTI_SHOT);
                            break;
                        }
                    }
                }
            }
            bShoot = false;
        } else uiMultiShotTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* pKiller)
    {
	 	hasBeenInCombat = false;	
		DoScriptText(SAY_START, me);	
        if (pInstance)
            pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);

		//what a nonsense! -.-
		if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                    pInstance->HandleGameObject(pGO->GetGUID(),true);
    }
		
	void ResetEncounter()
	{
		Creature* spawn_1;
		
		if(me)
		{
			Map *instance=me->GetMap();
			if(instance && pInstance)
			{
				//apri il cancello
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
				pInstance->HandleGameObject(GO->GetGUID(),true);
				
				/*sostanzialmente vede qual � il boss e respawna gli altri due solo se sono morti o despawnati, tenendo conto che 
				 *quelli gi� vivi respawnano da soli*/
				if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
				{
					Respawn(DATA_GRAND_CHAMPION_2,2);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_2,2);
					spawn_1 = me->SummonCreature(me->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
				}				
				
				//if(spawn_1) //perch� non si pu� mai essere troppo sicuri :S
				//{
				//	spawn_1->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
				//	spawn_1->SetReactState(REACT_AGGRESSIVE);
				//}
				 //a questo punto il boss, vivo o morto che sia, viene despawnato
				me->RemoveFromWorld();
							
			}
		}			
	}

	void Respawn(uint32 id, int posizione)
	{
		Map *instance=me->GetMap();
		Creature* npc = instance->GetCreature(pInstance->GetData64(id)); //vediamo se c'� l'npc da respawnare
		Creature* spawn_2;

		if(!npc)
			return;

		if((npc && !(npc->isAlive()))) //ovvero se il boss c'� ma � morto oppure se il boss � gi� despawnato
		{
			switch(posizione)
			{
				case 1:
					spawn_2 = me->SummonCreature(npc->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 2:
					spawn_2 = me->SummonCreature(npc->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 3:
					spawn_2 = me->SummonCreature(npc->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
					break;
			}

			//if(spawn_2) //perch� non si pu� mai essere troppo sicuri :S
			//{
			//	spawn_2->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
			//	spawn_2->SetReactState(REACT_AGGRESSIVE);
			//}

			if(npc) //solo se � ancora spawnato (quello vecchio) lo despawna
				npc->RemoveFromWorld();
		}
	}
	
};

CreatureAI* GetAI_boss_hunter_toc5(Creature* pCreature)
{
    return new boss_hunter_toc5AI(pCreature);
}

// Lana Stouthammer Evensong && Deathstalker Visceri || Rouge
struct boss_rouge_toc5AI : public ScriptedAI
{
    boss_rouge_toc5AI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();

        bDone = false;
        bHome = false;

        uiPhase = 0;
        uiPhaseTimer = 0;

		hasBeenInCombat = false;

        me->SetReactState(REACT_PASSIVE);
        // THIS IS A HACK, SHOULD BE REMOVED WHEN THE EVENT IS FULL SCRIPTED
        me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
    }

    ScriptedInstance* pInstance;

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
				pInstance->SetData(BOSS_GRAND_CHAMPIONS, FAIL);
				 
			if(pInstance)
			{
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
			if(GO)
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
		hasBeenInCombat = true;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!bDone && GrandChampionsOutVehicle(me))
        {
            bDone = true;

            if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
                me->SetHomePosition(739.678,662.541,412.393,4.49);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
                me->SetHomePosition(746.71,661.02,411.69,4.6);
            else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
                me->SetHomePosition(754.34,660.70,412.39,4.79);

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
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
            DoCast(pTarget,SPELL_POISON_BOTTLE);
            uiPosionBottleTimer = 19000;
        } else uiPosionBottleTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* pKiller)
    {
		hasBeenInCombat = false;
		DoScriptText(SAY_START, me);	
        if (pInstance)
            pInstance->SetData(BOSS_GRAND_CHAMPIONS, DONE);

		//where's the sense in that?
		if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                    pInstance->HandleGameObject(pGO->GetGUID(),true);
    }
	void ResetEncounter()
	{
		Creature* spawn_1;
		
		if(me)
		{
			Map *instance=me->GetMap();
			if(instance && pInstance)
			{
				//apri il cancello
				GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
				pInstance->HandleGameObject(GO->GetGUID(),true);
				
				/*sostanzialmente vede qual � il boss e respawna gli altri due solo se sono morti o despawnati, tenendo conto che 
				 *quelli gi� vivi respawnano da soli*/
				if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_1))
				{
					Respawn(DATA_GRAND_CHAMPION_2,2);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_2))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_3,3);
					spawn_1 = me->SummonCreature(me->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
				}
				else if (pInstance && me->GetGUID() == pInstance->GetData64(DATA_GRAND_CHAMPION_3))
				{
					Respawn(DATA_GRAND_CHAMPION_1,1);
					Respawn(DATA_GRAND_CHAMPION_2,2);
					spawn_1 = me->SummonCreature(me->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
				}				
				
				//if(spawn_1) //perch� non si pu� mai essere troppo sicuri :S
				//{
				//	spawn_1->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
				//	spawn_1->SetReactState(REACT_AGGRESSIVE);
				//}
				 //a questo punto il boss, vivo o morto che sia, viene despawnato
				me->RemoveFromWorld();
							
			}
		}			
	}

	void Respawn(uint32 id, int posizione)
	{
		Map *instance=me->GetMap();
		Creature* npc = instance->GetCreature(pInstance->GetData64(id)); //vediamo se c'� l'npc da respawnare
		Creature* spawn_2;

		if(!npc)
			return;

		if((npc && !(npc->isAlive()))) //ovvero se il boss c'� ma � morto oppure se il boss � gi� despawnato
		{
			switch(posizione)
			{
				case 1:
					spawn_2 = me->SummonCreature(npc->GetEntry(),739.678,662.541,412.393,4.49,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 2:
					spawn_2 = me->SummonCreature(npc->GetEntry(),746.71,661.02,411.69,4.6,TEMPSUMMON_MANUAL_DESPAWN);
					break;
				case 3:
					spawn_2 = me->SummonCreature(npc->GetEntry(),754.34,660.70,412.39,4.79,TEMPSUMMON_MANUAL_DESPAWN);
					break;
			}

			//if(spawn_2) //perch� non si pu� mai essere troppo sicuri :S
			//{
			//	spawn_2->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
			//	spawn_2->SetReactState(REACT_AGGRESSIVE);
			//}

			if(npc) //solo se � ancora spawnato (quello vecchio) lo despawna
				npc->RemoveFromWorld();
		}
	}
};

CreatureAI* GetAI_boss_rouge_toc5(Creature* pCreature)
{
    return new boss_rouge_toc5AI(pCreature);
}

void AddSC_boss_grand_champions()
{
    Script* NewScript;

    NewScript = new Script;
    NewScript->Name = "generic_vehicleAI_toc5";
    NewScript->GetAI = &GetAI_generic_vehicleAI_toc5;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "boss_warrior_toc5";
    NewScript->GetAI = &GetAI_boss_warrior_toc5;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "boss_mage_toc5";
    NewScript->GetAI = &GetAI_boss_mage_toc5;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "boss_shaman_toc5";
    NewScript->GetAI = &GetAI_boss_shaman_toc5;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "boss_hunter_toc5";
    NewScript->GetAI = &GetAI_boss_hunter_toc5;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "boss_rouge_toc5";
    NewScript->GetAI = &GetAI_boss_rouge_toc5;
    NewScript->RegisterSelf();
}
