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
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

/* Script Data Start
SDName: Boss mal_ganis
SDAuthor: Tartalo
SD%Complete: 80
SDComment: TODO: Intro & outro
SDCategory:
Script Data End */

/*** SQL START ***
update creature_template set scriptname = 'boss_mal_ganis' where entry = '';
*** SQL END ***/
#include "ScriptedPch.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CARRION_SWARM                         = 52720, //A cresting wave of chaotic magic splashes over enemies in front of the caster, dealing 3230 to 3570 Shadow damage and 380 to 420 Shadow damage every 3 sec. for 15 sec.
    H_SPELL_CARRION_SWARM                       = 58852,
    SPELL_MIND_BLAST                            = 52722, //Inflicts 4163 to 4837 Shadow damage to an enemy.
    H_SPELL_MIND_BLAST                          = 58850,
    SPELL_SLEEP                                 = 52721, //Puts an enemy to sleep for up to 10 sec. Any damage caused will awaken the target.
    H_SPELL_SLEEP                               = 58849,
    SPELL_VAMPIRIC_TOUCH                        = 52723 //Heals the caster for half the damage dealt by a melee attack.
};

enum Yells
{
    SAY_INTRO_1                                 = -1595009,
    SAY_INTRO_2                                 = -1595010,
    SAY_AGGRO                                   = -1595011,
    SAY_KILL_1                                  = -1595012,
    SAY_KILL_2                                  = -1595013,
    SAY_KILL_3                                  = -1595014,
    SAY_SLAY_1                                  = -1595015,
    SAY_SLAY_2                                  = -1595016,
    SAY_SLAY_3                                  = -1595017,
    SAY_SLAY_4                                  = -1595018,
    SAY_SLEEP_1                                 = -1595019,
    SAY_SLEEP_2                                 = -1595020,
    SAY_30HEALTH                                = -1595021,
    SAY_15HEALTH                                = -1595022,
    SAY_ESCAPE_SPEECH_1                         = -1595023,
    SAY_ESCAPE_SPEECH_2                         = -1595024,
    SAY_OUTRO                                   = -1595025,
};

enum CombatPhases
{
    COMBAT,
    OUTRO
};

struct boss_mal_ganisAI : public ScriptedAI
{
    boss_mal_ganisAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    uint32 uiCarrionSwarmTimer;
    uint32 uiMindBlastTimer;
    uint32 uiVampiricTouchTimer;
    uint32 uiSleepTimer;

    uint8 uiOutroStep;
    uint32 uiOutroTimer;

    bool bYelled;
    bool bYelled2;

    CombatPhases Phase;

    ScriptedInstance* pInstance;

    void Reset()
    {
         bYelled = false;
         bYelled2 = false;
         Phase = COMBAT;
         uiCarrionSwarmTimer = 6000;
         uiMindBlastTimer = 11000;
         uiVampiricTouchTimer = urand(10000,15000);
         uiSleepTimer = urand(15000,20000);
         uiOutroTimer = 1000;

         if (pInstance)
             pInstance->SetData(DATA_MAL_GANIS_EVENT, NOT_STARTED);
    }

    void EnterCombat(Unit* who)
    {
        DoScriptText(SAY_AGGRO, m_creature);
        if (pInstance)
            pInstance->SetData(DATA_MAL_GANIS_EVENT, IN_PROGRESS);
    }

    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (damage >= m_creature->GetHealth() && done_by != m_creature)
            damage = m_creature->GetHealth()-1;
    }

    void UpdateAI(const uint32 diff)
    {
        switch(Phase)
        {
            case COMBAT:
                //Return since we have no target
                if (!UpdateVictim())
                    return;

                if (!bYelled && HealthBelowPct(30))
                {
                    DoScriptText(SAY_30HEALTH, m_creature);
                    bYelled = true;
                }

                if (!bYelled2 && HealthBelowPct(15))
                {
                    DoScriptText(SAY_15HEALTH, m_creature);
                    bYelled2 = true;
                }

                if (HealthBelowPct(1))
                {
                    //Handle Escape Event: Don't forget to add Player::RewardPlayerAndGroupAtEvent
                    m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    uiOutroStep = 1;
                    Phase = OUTRO;
                    return;
                }

                if (Creature* pArthas = m_creature->GetCreature(*m_creature, pInstance ? pInstance->GetData64(DATA_ARTHAS) : 0))
                    if (pArthas->isDead())
                    {
                        EnterEvadeMode();
                        m_creature->DisappearAndDie();
                        if (pInstance)
                            pInstance->SetData(DATA_MAL_GANIS_EVENT, FAIL);
                    }

                if (uiCarrionSwarmTimer < diff)
                {
                    DoCastVictim(SPELL_CARRION_SWARM);
                    uiCarrionSwarmTimer = 7000;
                } else uiCarrionSwarmTimer -= diff;

                if (uiMindBlastTimer < diff)
                {
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(pTarget, SPELL_MIND_BLAST);
                    uiMindBlastTimer = 6000;
                } else uiMindBlastTimer -= diff;

                if (uiVampiricTouchTimer < diff)
                {
                    DoCast(m_creature, SPELL_VAMPIRIC_TOUCH);
                    uiVampiricTouchTimer = 32000;
                } else uiVampiricTouchTimer -= diff;

                if (uiSleepTimer < diff)
                {
                    DoScriptText(RAND(SAY_SLEEP_1,SAY_SLEEP_2), m_creature);
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(pTarget, SPELL_SLEEP);
                    uiSleepTimer = urand(15000,20000);
                } else uiSleepTimer -= diff;

                DoMeleeAttackIfReady();
                break;
            case OUTRO:
                if (uiOutroTimer < diff)
                {
                    switch(uiOutroStep)
                    {
                        case 1:
                            DoScriptText(SAY_ESCAPE_SPEECH_1, m_creature);
                            me->GetMotionMaster()->MoveTargetedHome();
                            ++uiOutroStep;
                            uiOutroTimer = 8000;
                            break;
                        case 2:
                            m_creature->SetUInt64Value(UNIT_FIELD_TARGET, pInstance ? pInstance->GetData64(DATA_ARTHAS) : 0);
                            m_creature->HandleEmoteCommand(29);
                            DoScriptText(SAY_ESCAPE_SPEECH_2, m_creature);
                            ++uiOutroStep;
                            uiOutroTimer = 9000;
                            break;
                        case 3:
                            DoScriptText(SAY_OUTRO, m_creature);
                            ++uiOutroStep;
                            uiOutroTimer = 16000;
                            break;
                        case 4:
                            m_creature->HandleEmoteCommand(33);
                            ++uiOutroStep;
                            uiOutroTimer = 500;
                            break;
                        case 5:
                            m_creature->SetVisibility(VISIBILITY_OFF);
                            m_creature->Kill(m_creature);
                            break;

                    }
                } else uiOutroTimer -= diff;
                break;
        }
    }

    void JustDied(Unit* killer)
    {
        if (pInstance)
        {
            pInstance->SetData(DATA_MAL_GANIS_EVENT, DONE);

            // give achievement credit to players. criteria use spell 58630 which doesn't exist.
            if (pInstance)
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 58630);
        }
    }

    void KilledUnit(Unit *victim)
    {
        if (victim == m_creature)
            return;

        DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3,SAY_SLAY_4), m_creature);
    }
};

CreatureAI* GetAI_boss_mal_ganis(Creature* pCreature)
{
    return new boss_mal_ganisAI (pCreature);
}

void AddSC_boss_mal_ganis()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_mal_ganis";
    newscript->GetAI = &GetAI_boss_mal_ganis;
    newscript->RegisterSelf();
}
