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
SDName: Argent Challenge Encounter.
SD%Complete: 50 %
SDComment: AI for Argent Soldiers are not implemented. AI from bosses need more improvements.
SDCategory: Trial of the Champion
EndScriptData */

#include "ScriptPCH.h"
#include "trial_of_the_champion.h"
#include "ScriptedEscortAI.h"

enum eSpells
{
    //Eadric
    SPELL_EADRIC_ACHIEVEMENT    = 68197,
    SPELL_HAMMER_JUSTICE        = 66863,
    SPELL_HAMMER_RIGHTEOUS      = 66867,
    SPELL_RADIANCE              = 66935,
    SPELL_VENGEANCE             = 66865,
    EADRIC_KILL_CREDIT          = 68575,

    //Paletress
    SPELL_SMITE                 = 66536,
    SPELL_SMITE_H               = 67674,
    SPELL_HOLY_FIRE             = 66538,
    SPELL_HOLY_FIRE_H           = 67676,
    SPELL_RENEW                 = 66537,
    SPELL_RENEW_H               = 67675,
    SPELL_HOLY_NOVA             = 66546,
    SPELL_SHIELD                = 66515,
    SPELL_CONFESS               = 66680,
    PALESTRESS_KILL_CREDIT      = 68574,
	
	//Npc_argent_soldier
	SPELL_STRIKE                = 67237,
	SPELL_CLEAVE                = 15284,
	SPELL_PUMMEL                = 67235,
	SPELL_PAIN                  = 34942,
	SPELL_MIND                  = 67229,
	SPELL_SSMITE                = 67289,
	SPELL_LIGHT_H               = 67290,
	SPELL_LIGHT                 = 67247,
	SPELL_FLURRY                = 67233,
	SPELL_FINAL                 = 67255,
	SPELL_DIVINE                = 67251,

    //Memory
    SPELL_OLD_WOUNDS            = 66620,
    SPELL_OLD_WOUNDS_H          = 67679,
    SPELL_SHADOWS_PAST          = 66619,
    SPELL_SHADOWS_PAST_H        = 67678,
    SPELL_WAKING_NIGHTMARE      = 66552,
    SPELL_WAKING_NIGHTMARE_H    = 67677
};
enum Misc
{
    ACHIEV_CONF                 = 3802
};

enum eEnums
{
	SAY_START_10                            = -1999956,
	SAY_START_9                             = -1999955,
	SAY_START_8                             = -1999941,	
	SAY_START_7                             = -1999954,
	SAY_START_6                             = -1999951
};

class OrientationCheck : public std::unary_function<Unit*, bool>
{
    public:
        explicit OrientationCheck(Unit* _caster) : caster(_caster) { }
        bool operator() (Unit* unit)
        {
            return !unit->isInFront(caster, 40.0f, 2.5f);
        }
    
    private:
        Unit* caster;
};

class spell_eadric_radiance : public SpellScriptLoader
{
    public:
        spell_eadric_radiance() : SpellScriptLoader("spell_eadric_radiance") { }
        class spell_eadric_radiance_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_eadric_radiance_SpellScript);
            void FilterTargets(std::list<Unit*>& unitList)
            {
                unitList.remove_if(OrientationCheck(GetCaster()));
            }
            
            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_eadric_radiance_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_AREA_ENEMY_SRC);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_eadric_radiance_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_AREA_ENEMY_SRC);
            }
        };
        
        SpellScript *GetSpellScript() const
        {
            return new spell_eadric_radiance_SpellScript();
        }
};

class boss_eadric : public CreatureScript
{
    public:
        boss_eadric(): CreatureScript("boss_eadric") {}

    struct boss_eadricAI : public BossAI
    {
        boss_eadricAI(Creature* pCreature) : BossAI(pCreature,BOSS_ARGENT_CHALLENGE_E)
        {
            pInstance = pCreature->GetInstanceScript();
            pCreature->SetReactState(REACT_PASSIVE);
            pCreature->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
		    pCreature->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE);
		    hasBeenInCombat=false;
        }

        InstanceScript* pInstance;

        uint32 uiVenganceTimer;
        uint32 uiRadianceTimer;
        uint32 uiHammerJusticeTimer;
        uint32 uiResetTimer;

        bool bDone;
	    bool hasBeenInCombat;

        void Reset()
        {
            uiVenganceTimer = 10000;
            uiRadianceTimer = 16000;
            uiHammerJusticeTimer = 25000;
            uiResetTimer = 5000;

            bDone = false;
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
    				
				    GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
				    if(GO)
					    pInstance->HandleGameObject(GO->GetGUID(),true);
				    Creature* announcer=pMap->GetCreature(pInstance->GetData64(DATA_ANNOUNCER));
				    pInstance->SetData(DATA_ARGENT_SOLDIER_DEFEATED,0);
				    announcer->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
			    }
			    me->RemoveFromWorld();

			    //ResetEncounter();
		    }
        }

        void DamageTaken(Unit *done_by, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {		
                damage = 0;
                EnterEvadeMode();
			    me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
			    me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE);
			    DoScriptText(SAY_START_8, me);
                me->setFaction(35);
                bDone = true;
                if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE)))
                        pInstance->HandleGameObject(pGO->GetGUID(),true);	
                if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                        pInstance->HandleGameObject(pGO->GetGUID(),true);		
					    if (pInstance)
                pInstance->SetData(BOSS_ARGENT_CHALLENGE_E, DONE);
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, EADRIC_KILL_CREDIT);
		    }
        }

        void MovementInform(uint32 MovementType, uint32 Data)
        {
            if (MovementType != POINT_MOTION_TYPE)
                return;
        }

	    void EnterCombat(Unit* pWho)
	    {
		    _EnterCombat();
		    me->SetHomePosition(746.843f, 665.000f, 412.339f, 4.670f);
		    DoScriptText(SAY_START_9, me);
		    hasBeenInCombat = true;
	    }
    	
        void UpdateAI(const uint32 uiDiff)
        {
            if (bDone && uiResetTimer <= uiDiff)
            {
                me->GetMotionMaster()->MovePoint(0,746.843f, 695.68f, 412.339f);
                bDone = false;
			    if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE)))
                        pInstance->HandleGameObject(pGO->GetGUID(),false);
            } else uiResetTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (uiHammerJusticeTimer <= uiDiff)
            {
                me->InterruptNonMeleeSpells(true);

                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 250, true))
                {
                    if (pTarget && pTarget->isAlive())
                    {
                        DoCast(pTarget, SPELL_HAMMER_JUSTICE);
                        DoCast(pTarget, SPELL_HAMMER_RIGHTEOUS);
                    }
                }
                uiHammerJusticeTimer = 25000;
            } else uiHammerJusticeTimer -= uiDiff;

            if (uiVenganceTimer <= uiDiff)
            {
                DoCast(me,SPELL_VENGEANCE);

                uiVenganceTimer = 10000;
            } else uiVenganceTimer -= uiDiff;

            if (uiRadianceTimer <= uiDiff)
            {
                DoCastAOE(SPELL_RADIANCE);

                uiRadianceTimer = 16000;
            } else uiRadianceTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_eadricAI(pCreature);
    };
};

class boss_paletress : public CreatureScript
{
    public:
        boss_paletress(): CreatureScript("boss_paletress") {}

    struct boss_paletressAI : public BossAI
    {
        boss_paletressAI(Creature* pCreature) : BossAI(pCreature,BOSS_ARGENT_CHALLENGE_P)
        {
            pInstance = pCreature->GetInstanceScript();

		    hasBeenInCombat = false;
            MemoryGUID = 0;
            pCreature->SetReactState(REACT_PASSIVE);
            pCreature->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
		    pCreature->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE);
            pCreature->RestoreFaction();
        }

        InstanceScript* pInstance;

        Creature* pMemory;
        uint64 MemoryGUID;

        bool bHealth;
        bool bDone;
	    bool hasBeenInCombat;

        uint32 uiHolyFireTimer;
        uint32 uiHolySmiteTimer;
        uint32 uiRenewTimer;
        uint32 uiResetTimer;

        void Reset()
        {
            me->RemoveAllAuras();

            uiHolyFireTimer     = urand(9000,12000);
            uiHolySmiteTimer    = urand(5000,7000);
            uiRenewTimer        = urand(2000,5000);

            uiResetTimer        = 7000;

            bHealth = false;
            bDone = false;
    		
            if (Creature *pMemory = Unit::GetCreature(*me, MemoryGUID))
                if (pMemory->isAlive())
                    pMemory->RemoveFromWorld();

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
				    GameObject* GO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1));
			        if(GO)
				        pInstance->HandleGameObject(GO->GetGUID(),true);
				    Creature* announcer = pMap->GetCreature(pInstance->GetData64(DATA_ANNOUNCER));
				    pInstance->SetData(DATA_ARGENT_SOLDIER_DEFEATED,0);
				    announcer->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
			    }

			    me->RemoveFromWorld();
			    //ResetEncounter();
		    }

        }
	    void EnterCombat(Unit* pWho)
        {
		    _EnterCombat();
		    me->SetHomePosition(746.843f, 665.000f, 412.339f, 4.670f);
		    hasBeenInCombat = true;
		    DoScriptText(SAY_START_10, me);		
        }

        void SetData(uint32 uiId, uint32 uiValue)
        {
            if (uiId == 1)
                me->RemoveAura(SPELL_SHIELD);
        }

        void DamageTaken(Unit *done_by, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                EnterEvadeMode();
			    me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
			    me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE);
			    DoScriptText(SAY_START_7, me);
                me->setFaction(35);
                bDone = true;
                if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE)))
                        pInstance->HandleGameObject(pGO->GetGUID(),true);	
                if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE1)))
                        pInstance->HandleGameObject(pGO->GetGUID(),true);		
                pInstance->SetData(BOSS_ARGENT_CHALLENGE_P, DONE);
                if (IsHeroic())
                    pInstance->DoCompleteAchievement(ACHIEV_CONF);
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, PALESTRESS_KILL_CREDIT);
		    }
        }

        void MovementInform(uint32 MovementType, uint32 Data)
        {
            if (MovementType != POINT_MOTION_TYPE)
                return;	

        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (bDone && uiResetTimer <= uiDiff)
            {
                me->GetMotionMaster()->MovePoint(0, 746.843f, 695.68f, 412.339f);
                bDone = false;
			    if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE)))
                        pInstance->HandleGameObject(pGO->GetGUID(),false);	
            } else uiResetTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (uiHolyFireTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 250, true))
                {
                    if (pTarget && pTarget->isAlive())
                        DoCast(pTarget,DUNGEON_MODE(SPELL_HOLY_FIRE,SPELL_HOLY_FIRE_H));
                }
                 if (me->HasAura(SPELL_SHIELD))
                    uiHolyFireTimer = 13000;
                else
                    uiHolyFireTimer = urand(9000,12000);
            } else uiHolyFireTimer -= uiDiff;

            if (uiHolySmiteTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 250, true))
                {
                    if (pTarget && pTarget->isAlive())
                        DoCast(pTarget,DUNGEON_MODE(SPELL_SMITE,SPELL_SMITE_H));
                }
                if (me->HasAura(SPELL_SHIELD))
                    uiHolySmiteTimer = 9000;
                else
                    uiHolySmiteTimer = urand(5000,7000);
            } else uiHolySmiteTimer -= uiDiff;

            if (me->HasAura(SPELL_SHIELD))
            {
                if (uiRenewTimer <= uiDiff)
                {
                    me->InterruptNonMeleeSpells(true);
                    uint8 uiTarget = urand(0,1);
                    switch(uiTarget)
                    {
                        case 0:
                            DoCast(me,DUNGEON_MODE(SPELL_RENEW,SPELL_RENEW_H));
                            break;
                        case 1:
                            if (Creature *pMemory = Unit::GetCreature(*me, MemoryGUID))
                                if (pMemory->isAlive())
                                    DoCast(pMemory, DUNGEON_MODE(SPELL_RENEW,SPELL_RENEW_H));
                            break;
                    }
                    uiRenewTimer = urand(15000,17000);
                } else uiRenewTimer -= uiDiff;
            }

            if (!bHealth && me->GetHealth()*100 / me->GetMaxHealth() <= 35)
            {
		        DoScriptText(SAY_START_6, me);
                me->InterruptNonMeleeSpells(true);
                DoCastAOE(SPELL_HOLY_NOVA,false);
                DoCast(me, SPELL_SHIELD);
                DoCastAOE(SPELL_CONFESS,false);

                bHealth = true;
			    switch(urand(0, 24))
                {
                    case 0: me->SummonCreature(MEMORY_ALGALON, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 1: me->SummonCreature(MEMORY_CHROMAGGUS, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 2: me->SummonCreature(MEMORY_CYANIGOSA, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 3: me->SummonCreature(MEMORY_DELRISSA, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 4: me->SummonCreature(MEMORY_ECK, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 5: me->SummonCreature(MEMORY_ENTROPIUS, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 6: me->SummonCreature(MEMORY_GRUUL, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 7: me->SummonCreature(MEMORY_HAKKAR, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 8: me->SummonCreature(MEMORY_HEIGAN, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 9: me->SummonCreature(MEMORY_HEROD, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 10: me->SummonCreature(MEMORY_HOGGER, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 11: me->SummonCreature(MEMORY_IGNIS, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 12: me->SummonCreature(MEMORY_ILLIDAN, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 13: me->SummonCreature(MEMORY_INGVAR, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 14: me->SummonCreature(MEMORY_KALITHRESH, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 15: me->SummonCreature(MEMORY_LUCIFRON, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 16: me->SummonCreature(MEMORY_MALCHEZAAR, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 17: me->SummonCreature(MEMORY_MUTANUS, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 18: me->SummonCreature(MEMORY_ONYXIA, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 19: me->SummonCreature(MEMORY_THUNDERAAN, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 20: me->SummonCreature(MEMORY_VANCLEEF, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 21: me->SummonCreature(MEMORY_VASHJ, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 22: me->SummonCreature(MEMORY_VEKNILASH, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 23: me->SummonCreature(MEMORY_VEZAX, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                    case 24: me->SummonCreature(MEMORY_ARCHIMONDE, 0.0f, 0.0f, 0.0f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break; 
	            }
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* pSummon)
        {
            MemoryGUID = pSummon->GetGUID();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_paletressAI(pCreature);
    };
};

class npc_memory : public CreatureScript
{
    public:
        npc_memory(): CreatureScript("npc_memory") {}

    struct npc_memoryAI : public ScriptedAI
    {
        npc_memoryAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        uint32 uiOldWoundsTimer;
        uint32 uiShadowPastTimer;
        uint32 uiWakingNightmare;

        void Reset()
        {
            uiOldWoundsTimer = 12000;
            uiShadowPastTimer = 5000;
            uiWakingNightmare = 7000;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (uiOldWoundsTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                {
                    if (pTarget && pTarget->isAlive())
                        DoCast(pTarget, DUNGEON_MODE(SPELL_OLD_WOUNDS,SPELL_OLD_WOUNDS_H));
                }
                uiOldWoundsTimer = 23000;
            }else uiOldWoundsTimer -= uiDiff;

            if (uiWakingNightmare <= uiDiff)
            {
                DoCast(me, DUNGEON_MODE(SPELL_WAKING_NIGHTMARE,SPELL_WAKING_NIGHTMARE_H));
                uiWakingNightmare = 15000;
            }else uiWakingNightmare -= uiDiff;

            if (uiShadowPastTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,1))
                {
                    if (pTarget && pTarget->isAlive())
                        DoCast(pTarget,DUNGEON_MODE(SPELL_SHADOWS_PAST,SPELL_SHADOWS_PAST_H));
                }
                uiShadowPastTimer = 20000;
            }else uiShadowPastTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* pKiller)
        {
            if (me->isSummon())
            {
                if (Unit* pSummoner = CAST_SUM(me)->GetSummoner())
                {
                    if (pSummoner && pSummoner->isAlive())
                        CAST_CRE(pSummoner)->AI()->SetData(1,0);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_memoryAI(pCreature);
    };
};

// THIS AI NEEDS MORE IMPROVEMENTS
class npc_argent_soldier : public CreatureScript
{
    public:
        npc_argent_soldier(): CreatureScript("npc_argent_soldier") {}

    struct npc_argent_soldierAI : public npc_escortAI
    {
        npc_argent_soldierAI(Creature* pCreature) : npc_escortAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE);
		    if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE)))
                pInstance->HandleGameObject(pGO->GetGUID(),true);    					
            SetDespawnAtEnd(false);
            uiWaypoint = 0;
            bStarted = false;
        }

        InstanceScript* pInstance;

        uint8 uiWaypoint;
    	
	    uint32 uiStrikeTimer;
	    uint32 uiCleaveTimer;
        uint32 uiPummelTimer;
	    uint32 uiPainTimer;
        uint32 uiMindTimer;
	    uint32 uiSsmiteTimer;
    	
        uint32 uiLightTimer;
	    uint32 uiFlurryTimer;
        uint32 uiFinalTimer;
        uint32 uiDivineTimer;

        bool bStarted;

        void Reset()
        {
      	    uiStrikeTimer = 5000;	
      	    uiCleaveTimer = 6000;
            uiPummelTimer = 10000;
      	    uiPainTimer = 60000;
            uiMindTimer = 70000;
      	    uiSsmiteTimer = 6000;
    	
            uiLightTimer = 3000;
   	        uiFlurryTimer = 6000;
            uiFinalTimer = 30000;
            uiDivineTimer = 70000;
            
            if (bStarted)
            {
                me->SetReactState(REACT_AGGRESSIVE);					
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
            }
        }
    	
        void WaypointReached(uint32 uiPoint)
        {
            if (uiPoint == 0)
            {
                switch(uiWaypoint)
                {
                    case 1:
                        me->SetOrientation(4.60f);
			            me->SetReactState(REACT_AGGRESSIVE);					
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        bStarted = true;
                        break;
                }
		    }	
		    if (uiPoint == 1)
            {
                switch(uiWaypoint)
                {
                    case 0:
                        me->SetOrientation(5.81f);
			            me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        bStarted = true;
                        break;
                    case 2:
                        me->SetOrientation(3.39f);
			            me->SetReactState(REACT_AGGRESSIVE);					
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        bStarted = true;
                        if (GameObject* pGO = GameObject::GetGameObject(*me, pInstance->GetData64(DATA_MAIN_GATE)))
                            pInstance->HandleGameObject(pGO->GetGUID(),false);					
                        break;
    			
                }
                me->SendMovementFlagUpdate();
            
            }  
        }

        void SetData(uint32 uiType, uint32 uiData)
        {
            switch(me->GetEntry())
            {
                case NPC_ARGENT_LIGHWIELDER:
                    switch(uiType)
                    {
                        case 0:
					        AddWaypoint(0, 737.14f,655.42f,412.88f);
                            AddWaypoint(1, 712.14f,628.42f,411.88f);
                            break;
                        case 1:
                            AddWaypoint(0, 742.44f, 650.29f, 411.79f);
                            break;
                        case 2:
					        AddWaypoint(0, 756.14f, 655.42f, 411.88f);
                            AddWaypoint(1, 775.912f, 639.033f, 411.907f);
                            break;
                    }
                    break;
                case NPC_ARGENT_MONK:
                    switch(uiType)
                    {
                        case 0:
					        AddWaypoint(0, 737.14f, 655.42f, 412.88f);
                            AddWaypoint(1, 713.12f, 632.97f, 411.90f);
                            break;
                        case 1:
                            AddWaypoint(0, 746.73f, 650.24f, 411.56f);
                            break;
                        case 2:
					        AddWaypoint(0, 756.14f, 655.42f, 411.88f);
                            AddWaypoint(1, 784.817f, 629.883f, 411.908f);
                            break;
                    }
                    break;
                case NPC_PRIESTESS:
                    switch(uiType)
                    {
                        case 0:
					        AddWaypoint(0, 737.14f, 655.42f, 412.88f);
                            AddWaypoint(1, 715.06f, 637.07f, 411.91f);
                            break;
                        case 1:
                            AddWaypoint(0, 750.72f, 650.20f, 411.77f);
                            break;
                        case 2:
					        AddWaypoint(0, 756.14f, 655.42f, 411.88f);
                            AddWaypoint(1, 779.942f, 634.061f, 411.905f);
                            break;
                    }
                    break;
            }

            Start(false,true,0);
            uiWaypoint = uiType;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;
    			
            if (uiCleaveTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_STRIKE);				
                uiCleaveTimer = 20000;
            } else uiCleaveTimer -= uiDiff;	
    		
            if (uiStrikeTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_CLEAVE);				
                uiStrikeTimer = 25000;
            } else uiStrikeTimer -= uiDiff;	
    		
            if (uiPummelTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_PUMMEL);				
                uiPummelTimer = 35000;
            } else uiPummelTimer -= uiDiff;	
    		
            if (uiPainTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_PAIN);				
                uiPainTimer = 30000;
            } else uiPainTimer -= uiDiff;	
    		
            if (uiMindTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_MIND);				
                uiMindTimer = 90000;
            } else uiMindTimer -= uiDiff;
    		
            if (uiSsmiteTimer <= uiDiff)
            {
                if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(pTarget,SPELL_SSMITE);				
                uiSsmiteTimer = 25000;
            } else uiSsmiteTimer -= uiDiff;
    		
                    if (uiLightTimer <= uiDiff)
                    {
                        DoCast(me,DUNGEON_MODE(SPELL_LIGHT,SPELL_LIGHT_H));
                        uiLightTimer = urand (15000, 17000);
                    } else uiLightTimer -= uiDiff;
    				
                    if (uiFlurryTimer <= uiDiff)
                    {
                        DoCast(me,SPELL_FLURRY);
                        uiFlurryTimer = 22000;
                    } else uiFlurryTimer -= uiDiff;
    				
                    if (uiFinalTimer <= uiDiff)
                    {
                        DoCast(me,SPELL_FINAL);
                        uiFinalTimer = 70000;
                    } else uiFinalTimer -= uiDiff;
    				
                    if (uiDivineTimer <= uiDiff)
                    {
                        DoCast(me,SPELL_DIVINE);
                        uiDivineTimer = 85000;
                    } else uiDivineTimer -= uiDiff;
    			
            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* pKiller)
        {
            if (pInstance)
                pInstance->SetData(DATA_ARGENT_SOLDIER_DEFEATED,pInstance->GetData(DATA_ARGENT_SOLDIER_DEFEATED) + 1);
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_argent_soldierAI(pCreature);
    };
};

void AddSC_boss_argent_challenge()
{
    new boss_eadric();
    new spell_eadric_radiance();
    new boss_paletress();
    new npc_memory();
    new npc_argent_soldier();
}