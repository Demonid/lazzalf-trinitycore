/*
 * Copyright (C) 2009 Trinity <http://www.trinitycore.org/>
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

/* ScriptData
SDName: boss_prince_taldaram
SDAuthor: Tartalo & tlexii
SD%Complete: 0
SDComment:
SDCategory: Ahn'kahet
EndScriptData */

#include "precompiled.h"
#include "def_ahnkahet.h"

#define SPELL_BLOODTHIRST                   55968 //Trigger Spell + add aura
#define SPELL_CONJURE_FLAME_SPHERE          55931

#define SPELL_FLAME_SPHERE_SUMMON_1         55895// 1x 30106
#define H_SPELL_FLAME_SPHERE_SUMMON_1       59511// 1x 31686
#define H_SPELL_FLAME_SPHERE_SUMMON_2       59512// 1x 31687
#define SPELL_FLAME_SPHERE_SPAWN_EFFECT     55891
#define SPELL_FLAME_SPHERE_VISUAL           55928
#define SPELL_FLAME_SPHERE_PERIODIC         55926
#define H_SPELL_FLAME_SPHERE_PERIODIC       59508
#define SPELL_FLAME_SPHERE_DEATH_EFFECT     55947
#define SPELL_BEAM_VISUAL                   60342

#define SPELL_EMBRACE_OF_THE_VAMPYR         55959
#define H_SPELL_EMBRACE_OF_THE_VAMPYR       59513

#define SPELL_VANISH                        55964

#define CREATURE_FLAME_SPHERE               30106
#define H_CREATURE_FLAME_SPHERE_1           31686
#define H_CREATURE_FLAME_SPHERE_2           31687

#define DATA_EMBRACE_DMG                    20000
#define H_DATA_EMBRACE_DMG                  40000

#define DATA_GROUND_POSITION_Z               11.4
#define DATA_SPHERE_DISTANCE                100.0

//not in db
//Yell
#define SAY_AGGRO                                -1619021
#define SAY_SLAY_1                               -1619022
#define SAY_SLAY_2                               -1619023
#define SAY_DEATH                                -1619024
#define SAY_FEED_1                               -1619025
#define SAY_FEED_2                               -1619026
#define SAY_VANISH_1                             -1619027
#define SAY_VANISH_2                             -1619028

enum CombatPhase 
{
    NORMAL,
    CASTING_FLAME_SPHERES,
    JUST_VANISHED,
    VANISHED,
    FEEDING
};

struct TRINITY_DLL_DECL boss_taldaramAI : public ScriptedAI
{
    boss_taldaramAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
    }
    
    uint32 uiBloodthirstTimer;
    uint32 uiVanishTimer;
    uint32 uiWaitTimer;
    uint32 uiEmbraceTimer;
    uint32 uiEmbraceTakenDamage;
    uint32 uiFlamesphereTimer;
    uint32 uiPhaseTimer;

    uint64 uiSphereGuids[2];

    Unit *pEmbraceTarget;
    
    CombatPhase Phase;
    
    ScriptedInstance* pInstance;
    
    void Reset()
    {
        uiBloodthirstTimer = 10000;
        uiVanishTimer = (25 + rand()%10)*1000;
        uiEmbraceTimer = 20000;
        uiFlamesphereTimer = 5000;
        uiEmbraceTakenDamage = 0;
        Phase = NORMAL;
        uiPhaseTimer = 0;
        pEmbraceTarget = NULL;
        if (pInstance)
            pInstance->SetData(DATA_PRINCE_TALDARAM_EVENT, NOT_STARTED);
    }
    
    void EnterCombat(Unit* who)
    {
        if (pInstance)
            pInstance->SetData(DATA_PRINCE_TALDARAM_EVENT, IN_PROGRESS);
            DoScriptText(SAY_AGGRO, m_creature);
    }
      
    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;
        if (uiPhaseTimer < diff)
        {
            switch (Phase)
            {
                case CASTING_FLAME_SPHERES:
                    //DoCast(m_creature, SPELL_FLAME_SPHERE_SUMMON_1);
                    DoSpawnCreature(CREATURE_FLAME_SPHERE, 0, 0, 5, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 10000);
                    if (HeroicMode)
                    {
                        //DoCast(m_creature, H_SPELL_FLAME_SPHERE_SUMMON_1);
                        DoSpawnCreature(H_CREATURE_FLAME_SPHERE_1, 0, 0, 5, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 10000);
                        //DoCast(m_creature, H_SPELL_FLAME_SPHERE_SUMMON_2);
                        DoSpawnCreature(H_CREATURE_FLAME_SPHERE_2, 0, 0, 5, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 10000);
                    }
                    Phase = NORMAL;
                    uiPhaseTimer = 0;
                break;
                case JUST_VANISHED:
                    DoModifyThreatPercent(pEmbraceTarget, 100);
                    DoTeleportTo(pEmbraceTarget->GetPositionX(),pEmbraceTarget->GetPositionY(),pEmbraceTarget->GetPositionZ());
                    Phase = VANISHED;
                    uiPhaseTimer = 1400;
                break;
                case VANISHED:
                    DoCast(pEmbraceTarget,HeroicMode ? H_SPELL_EMBRACE_OF_THE_VAMPYR : SPELL_EMBRACE_OF_THE_VAMPYR );
                    Phase = FEEDING;
                    uiPhaseTimer = 20000;
                break;
                case FEEDING:
                    Phase = NORMAL;
                    uiPhaseTimer = 0;
                    pEmbraceTarget = NULL;
                break;
                case NORMAL:
                    if (uiBloodthirstTimer < diff)
                    {
                        DoCast(m_creature->getVictim(),SPELL_BLOODTHIRST);
                        uiBloodthirstTimer = 10000;
                    } else uiBloodthirstTimer -= diff;
                    
                    if (uiFlamesphereTimer < diff)
                    {
                        DoCast(m_creature, SPELL_CONJURE_FLAME_SPHERE);
                        Phase = CASTING_FLAME_SPHERES;
                        uiPhaseTimer = 3000 + diff;
                        uiFlamesphereTimer = 15000;
                    } else uiFlamesphereTimer -= diff;
                                       
                    if (uiVanishTimer < diff )
                    {
                        //Count alive players
                        Unit *target = NULL;
                        std::list<HostilReference *> t_list = m_creature->getThreatManager().getThreatList();
                        std::vector<Unit *> target_list;
                        for(std::list<HostilReference *>::iterator itr = t_list.begin(); itr!= t_list.end(); ++itr)
                        {
                            target = Unit::GetUnit(*m_creature, (*itr)->getUnitGuid());
                            // exclude pets & totems
                            if (target && target->GetTypeId() == TYPEID_PLAYER && target->isAlive())
                                target_list.push_back(target);
                            target = NULL;
                        }
                        //He only vanishes if there are 3 or more alive players
                        if (target_list.size() > 2)
                        {
                            DoScriptText(RAND(SAY_VANISH_1,SAY_VANISH_2), m_creature);
                            DoCast(m_creature,SPELL_VANISH);
                            Phase = JUST_VANISHED;
                            uiPhaseTimer = 1000;
                            pEmbraceTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                            while (pEmbraceTarget && pEmbraceTarget->GetTypeId() != TYPEID_PLAYER)
                                pEmbraceTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
                        }
                        uiVanishTimer = (25 + rand()%10)*1000;
                    } else uiVanishTimer -= diff;
                    
                    DoMeleeAttackIfReady();
                break;
            }
        } else uiPhaseTimer -= diff;
    }
    
    void DamageTaken(Unit* done_by, uint32 &damage)
    {
        if (Phase == FEEDING && pEmbraceTarget && pEmbraceTarget->isAlive())
        {
          uiEmbraceTakenDamage += damage;
          if (uiEmbraceTakenDamage > (HeroicMode ? H_DATA_EMBRACE_DMG : DATA_EMBRACE_DMG))
          {
              Phase = NORMAL;
              uiPhaseTimer = 0;
              pEmbraceTarget = NULL;
              m_creature->CastStop();
          }
        }
    }
    
    void JustDied(Unit* killer)
    {
        DoScriptText(SAY_DEATH, m_creature);
        
        if (pInstance)
            pInstance->SetData(DATA_PRINCE_TALDARAM_EVENT, DONE);
    }

    void KilledUnit(Unit *victim)
    {
        if (victim == m_creature)
            return;
        if (Phase == FEEDING && pEmbraceTarget && victim == pEmbraceTarget)
        {
            Phase = NORMAL;
            uiPhaseTimer = 0;
            pEmbraceTarget = NULL;
        }
        DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), m_creature);
    }
        
    bool CheckSpheres()
    {
        if(!pInstance)
	        return false;
        uiSphereGuids[0] = pInstance->GetData64(DATA_SPHERE1);
        uiSphereGuids[1] = pInstance->GetData64(DATA_SPHERE2);
        
        GameObject *pSpheres[2];
        for (uint8 i=0; i < 2; ++i)
        {
	        pSpheres[i] = pInstance->instance->GetGameObject(uiSphereGuids[i]);
	        if (!pSpheres[i])
	            return false;
	        if (pSpheres[i]->GetGoState() != GO_STATE_ACTIVE)
	            return false;
        }
        RemovePrison();
        return true;
    }
    
    void RemovePrison()
    {
        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        m_creature->RemoveAurasDueToSpell(SPELL_BEAM_VISUAL);
        m_creature->SetHomePosition(m_creature->GetPositionX(), m_creature->GetPositionY(), DATA_GROUND_POSITION_Z, m_creature->GetOrientation());
        uint64 prison_GUID = pInstance->GetData64(DATA_PRINCE_TALDARAM_PLATFORM);
        pInstance->HandleGameObject(prison_GUID,true);
    }
};

struct TRINITY_DLL_DECL mob_taldaram_flamesphereAI : public ScriptedAI
{
    mob_taldaram_flamesphereAI(Creature *c) : ScriptedAI(c) 
    {
        pInstance = c->GetInstanceData();
    }
    
    uint32 uiDespawnTimer;
    ScriptedInstance* pInstance;
    
    void Reset()
    {
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        m_creature->AddUnitMovementFlag(MOVEMENTFLAG_FLYING + MOVEMENTFLAG_HOVER);
        m_creature->setFaction(16);
        DoCast(m_creature, SPELL_FLAME_SPHERE_VISUAL);
        DoCast(m_creature, SPELL_FLAME_SPHERE_SPAWN_EFFECT);
        DoCast(m_creature, HeroicMode ? H_SPELL_FLAME_SPHERE_PERIODIC : SPELL_FLAME_SPHERE_PERIODIC);
        uiDespawnTimer = 10000;
        Unit *pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0);
        if (pTarget)
        {
            float angle,x,y;
            angle = m_creature->GetAngle(pTarget);
            x = m_creature->GetPositionX() + DATA_SPHERE_DISTANCE * cos(angle);
            y = m_creature->GetPositionY() + DATA_SPHERE_DISTANCE * sin(angle);
            m_creature->GetMotionMaster()->MovePoint(0, x, y, m_creature->GetPositionZ());
        }
    }
    
    void EnterCombat(Unit *who) {}
    void MoveInLineOfSight(Unit *who) {}
    
    void JustDied(Unit* slayer)
    {
        DoCast(m_creature, SPELL_FLAME_SPHERE_DEATH_EFFECT);
    }
     
    void UpdateAI(const uint32 diff)
    {
        if (uiDespawnTimer < diff)
        {
            m_creature->DealDamage(m_creature, m_creature->GetMaxHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            m_creature->RemoveCorpse();
        }
        else uiDespawnTimer -= diff;
    }
};

CreatureAI* GetAI_boss_taldaram(Creature* pCreature)
{
    return new boss_taldaramAI (pCreature);
}

CreatureAI* GetAI_mob_taldaram_flamesphere(Creature* pCreature)
{
    return new mob_taldaram_flamesphereAI (pCreature);
}

bool GOHello_prince_taldaram_sphere(Player *pPlayer, GameObject *pGO)
{
    ScriptedInstance *pInstance = pGO->GetInstanceData();

    Creature *pPrinceTaldaram = Unit::GetCreature(*pGO, pInstance ? pInstance->GetData64(DATA_PRINCE_TALDARAM) : 0);
    if (pPrinceTaldaram && pPrinceTaldaram->isAlive())
    {
        // maybe these are hacks :(
        pGO->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_UNK1);
        pGO->SetGoState(GO_STATE_ACTIVE);
        
        switch(pGO->GetEntry())
        {
            case 193093: pInstance->SetData(DATA_SPHERE1_EVENT,IN_PROGRESS); break;
            case 193094: pInstance->SetData(DATA_SPHERE2_EVENT,IN_PROGRESS); break;
        }
        
        CAST_AI(boss_taldaramAI, pPrinceTaldaram->AI())->CheckSpheres();
    }
    return true;
}

void AddSC_boss_taldaram()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="boss_taldaram";
    newscript->GetAI = &GetAI_boss_taldaram;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name="mob_taldaram_flamesphere";
    newscript->GetAI = &GetAI_mob_taldaram_flamesphere;
    newscript->RegisterSelf();
    
    newscript = new Script;
    newscript->Name = "prince_taldaram_sphere";
    newscript->pGOHello = &GOHello_prince_taldaram_sphere;
    newscript->RegisterSelf();
}
