/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Boss_Kurinnaxx
SD%Complete: 100
SDComment: VERIFY SCRIPT AND SQL
SDCategory: Ruins of Ahn'Qiraj
EndScriptData */

#include "precompiled.h"
#include "def_ruins_of_ahnqiraj.h"

enum Spells
{
    SPELL_MORTALWOUND            = 25646,
    SPELL_SANDTRAP               = 25656,
    SPELL_ENRAGE                 = 28798,
    SPELL_SUMMON_PLAYER          = 26446,
    SPELL_TRASH                  =  3391,
    SPELL_WIDE_SLASH             = 25814
};

struct TRINITY_DLL_DECL boss_kurinnaxxAI : public ScriptedAI
{
    boss_kurinnaxxAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }
    
    uint32 uiMortalWoundTimer;
    uint32 uiSandtrapTimer;
    bool bIsEnraged;
    
    ScriptedInstance* pInstance;

    void Reset()
    {
        bIsEnraged = false;
        uiMortalWoundTimer = urand(2000,7000);
        uiSandtrapTimer = 30000;
        
        if (pInstance)
            pInstance->SetData(DATA_KURINNAXX_EVENT, NOT_STARTED);
    }

    void EnterCombat(Unit *who)
    {   
        if (pInstance)
            pInstance->SetData(DATA_KURINNAXX_EVENT, IN_PROGRESS);
    }
    
    void JustDied(Unit *killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_KURINNAXX_EVENT, DONE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        //If we are <30% cast enrage
        if (!bIsEnraged && m_creature->GetHealth()*100 / m_creature->GetMaxHealth() <= 30 && !m_creature->IsNonMeleeSpellCasted(false))
        {
            bIsEnraged = true;
            DoCast(m_creature,SPELL_ENRAGE);
        }

        //uiMortalWoundTimer
        if (uiMortalWoundTimer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_MORTALWOUND);
            uiMortalWoundTimer = urand(2000,7000);;
        }else uiMortalWoundTimer -= diff;

        //uiSandtrapTimer
        if (uiSandtrapTimer < diff)
        {
            if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                DoCast(pTarget,SPELL_SANDTRAP);
            uiSandtrapTimer = 30000;
        }else uiSandtrapTimer -= diff;

        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_kurinnaxx(Creature* pCreature)
{
    return new boss_kurinnaxxAI (pCreature);
}

void AddSC_boss_kurinnaxx()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_kurinnaxx";
    newscript->GetAI = &GetAI_boss_kurinnaxx;
    newscript->RegisterSelf();
}

