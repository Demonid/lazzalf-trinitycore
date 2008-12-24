/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Boss_Maiden_of_Virtue
SD%Complete: 100
SDComment:
SDCategory: Karazhan
EndScriptData */

#include "precompiled.h"

#define SAY_AGGRO               -1532018
#define SAY_SLAY1               -1532019
#define SAY_SLAY2               -1532020
#define SAY_SLAY3               -1532021
#define SAY_REPENTANCE1         -1532022
#define SAY_REPENTANCE2         -1532023
#define SAY_DEATH               -1532024

#define SPELL_REPENTANCE        29511
#define SPELL_HOLYFIRE          29522
#define SPELL_HOLYWRATH         32445
#define SPELL_HOLYGROUND        29512
#define SPELL_BERSERK           26662

struct TRINITY_DLL_DECL boss_maiden_of_virtueAI : public ScriptedAI
{
    boss_maiden_of_virtueAI(Creature *c) : ScriptedAI(c) {Reset();}

    uint32 Repentance_Timer;
    uint32 Holyfire_Timer;
    uint32 Holywrath_Timer;
    uint32 Holyground_Timer;
    uint32 Enrage_Timer;

    bool Enraged;

    void Reset()
    {
        Repentance_Timer    = 30000+(rand()%15000);
        Holyfire_Timer      = 8000+(rand()%17000);
        Holywrath_Timer     = 20000+(rand()%10000);
        Holyground_Timer    = 3000;
        Enrage_Timer        = 600000;

        Enraged = false;

        m_creature->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
        m_creature->ApplySpellImmune(1, IMMUNITY_EFFECT,SPELL_EFFECT_ATTACK_ME, true);
    }

    void KilledUnit(Unit* Victim)
    {
        if(rand()%2) 
			return;

        switch(rand()%3)
        {
        case 0: DoScriptText(SAY_SLAY1, m_creature);break;
        case 1: DoScriptText(SAY_SLAY2, m_creature);break;
        case 2: DoScriptText(SAY_SLAY3, m_creature);break;
        }
    }

    void JustDied(Unit* Killer)
    {
        DoScriptText(SAY_DEATH, m_creature);
    }

    void Aggro(Unit *who)
    {
         DoScriptText(SAY_AGGRO, m_creature);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!m_creature->SelectHostilTarget() || !m_creature->getVictim() )
            return;

        if (Enrage_Timer < diff && !Enraged)
        {
            DoCast(m_creature, SPELL_BERSERK,true);
            Enraged = true;
        }else Enrage_Timer -=diff;

        if (Holyground_Timer < diff)
        {
            DoCast(m_creature, SPELL_HOLYGROUND, true);     //Triggered so it doesn't interrupt her at all
            Holyground_Timer = 3000;
        }else Holyground_Timer -= diff;

        if (Repentance_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_REPENTANCE);

            switch(rand()%2)
            {
            case 0: DoScriptText(SAY_REPENTANCE1, m_creature);break;
            case 1: DoScriptText(SAY_REPENTANCE2, m_creature);break;
            }
            Repentance_Timer = 30000 + rand()%15000;        //A little randomness on that spell
        }else Repentance_Timer -= diff;

        if (Holyfire_Timer < diff)
        {
			if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))		
                DoCast(target,SPELL_HOLYFIRE);

                Holyfire_Timer = 8000 + rand()%17000; //Anywhere from 8 to 25 seconds, good luck having several of those in a row!         
        }else Holyfire_Timer -= diff;

        if (Holywrath_Timer < diff)
        {
			if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
				DoCast(target,SPELL_HOLYWRATH);
            
			Holywrath_Timer = 20000+(rand()%10000);     //20-30 secs sounds nice
            
        }else Holywrath_Timer -= diff;

        DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_boss_maiden_of_virtue(Creature *_Creature)
{
    return new boss_maiden_of_virtueAI (_Creature);
}

void AddSC_boss_maiden_of_virtue()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="boss_maiden_of_virtue";
    newscript->GetAI = &GetAI_boss_maiden_of_virtue;
    newscript->RegisterSelf();
}
