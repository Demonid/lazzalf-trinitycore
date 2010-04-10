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
SDName: Boss salramm
SDAuthor: Tartalo
SD%Complete: 80
SDComment: TODO: Intro
SDCategory:
Script Data End */

/*** SQL START ***
update creature_template set scriptname = 'boss_salramm' where entry = '';
*** SQL END ***/
#include "ScriptedPch.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CURSE_OF_TWISTED_FLESH                = 58845,
    SPELL_EXPLODE_GHOUL                         = 52480,
    H_SPELL_EXPLODE_GHOUL                       = 58825,
    SPELL_SHADOW_BOLT                           = 57725,
    H_SPELL_SHADOW_BOLT                         = 58828,
    SPELL_STEAL_FLESH                           = 52708,
    SPELL_SUMMON_GHOULS                         = 52451
};

enum Yells
{
    SAY_AGGRO                                   = -1595032,
    SAY_SPAWN                                   = -1595033,
    SAY_SLAY_1                                  = -1595034,
    SAY_SLAY_2                                  = -1595035,
    SAY_SLAY_3                                  = -1595036,
    SAY_DEATH                                   = -1595037,
    SAY_EXPLODE_GHOUL_1                         = -1595038,
    SAY_EXPLODE_GHOUL_2                         = -1595039,
    SAY_STEAL_FLESH_1                           = -1595040,
    SAY_STEAL_FLESH_2                           = -1595041,
    SAY_STEAL_FLESH_3                           = -1595042,
    SAY_SUMMON_GHOULS_1                         = -1595043,
    SAY_SUMMON_GHOULS_2                         = -1595044
};

struct boss_salrammAI : public ScriptedAI
{
    boss_salrammAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
        if (pInstance)
            DoScriptText(SAY_SPAWN,m_creature);
    }

    uint32 uiCurseFleshTimer;
    uint32 uiExplodeGhoulTimer;
    uint32 uiShadowBoltTimer;
    uint32 uiStealFleshTimer;
    uint32 uiSummonGhoulsTimer;

    ScriptedInstance* pInstance;

    void Reset()
    {
         uiCurseFleshTimer = 30000;  //30s DBM
         uiExplodeGhoulTimer = urand(25000,28000); //approx 6 sec after summon ghouls
         uiShadowBoltTimer = urand(8000,12000); // approx 10s
         uiStealFleshTimer = 12345;
         uiSummonGhoulsTimer = urand(19000,24000); //on a video approx 24s after aggro

         if (pInstance)
             pInstance->SetData(DATA_SALRAMM_EVENT, NOT_STARTED);
    }

    void EnterCombat(Unit* who)
    {
        DoScriptText(SAY_AGGRO, m_creature);

        if (pInstance)
             pInstance->SetData(DATA_SALRAMM_EVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        //Curse of twisted flesh timer
        if (uiCurseFleshTimer <= diff)
        {
            DoCast(m_creature->getVictim(), SPELL_CURSE_OF_TWISTED_FLESH);
            uiCurseFleshTimer = 37000;
        } else uiCurseFleshTimer -= diff;

        //Shadow bolt timer
        if (uiShadowBoltTimer <= diff)
        {
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                DoCast(pTarget, SPELL_SHADOW_BOLT);
            uiShadowBoltTimer = urand(8000,12000);
        } else uiShadowBoltTimer -= diff;

        //Steal Flesh timer
        if (uiStealFleshTimer <= diff)
        {
            DoScriptText(RAND(SAY_STEAL_FLESH_1,SAY_STEAL_FLESH_2,SAY_STEAL_FLESH_3), m_creature);
            if (Unit* random_pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                DoCast(random_pTarget, SPELL_STEAL_FLESH);
            uiStealFleshTimer = 10000;
        } else uiStealFleshTimer -= diff;

        //Summon ghouls timer
        if (uiSummonGhoulsTimer <= diff)
        {
            DoScriptText(RAND(SAY_SUMMON_GHOULS_1,SAY_SUMMON_GHOULS_2), m_creature);
            if (Unit* random_pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                DoCast(random_pTarget, SPELL_SUMMON_GHOULS);
            uiSummonGhoulsTimer = 10000;
        } else uiSummonGhoulsTimer -= diff;

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* killer)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if (pInstance)
            pInstance->SetData(DATA_SALRAMM_EVENT, DONE);
    }

    void KilledUnit(Unit *victim)
    {
        if (victim == m_creature)
            return;

        DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), m_creature);
    }
};

CreatureAI* GetAI_boss_salramm(Creature* pCreature)
{
    return new boss_salrammAI (pCreature);
}

void AddSC_boss_salramm()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_salramm";
    newscript->GetAI = &GetAI_boss_salramm;
    newscript->RegisterSelf();
}
