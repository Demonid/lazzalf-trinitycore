/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>.sourceforge.net/>
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
SDName: Boss_Doomlord_Kazzak
SD%Complete: 70
SDComment: Using incorrect spell for Mark of Kazzak
SDCategory: Hellfire Peninsula
EndScriptData */
#include "precompiled.h"
#define SAY_INTRO                       -1000375 //signed for 3465
#define SAY_AGGRO1                      -1000376 //signed for 3465
#define SAY_AGGRO2                      -1000377 //signed for 3465
#define SAY_SURPREME1                   -1000378 //signed for 3465
#define SAY_SURPREME2                   -1000379 //signed for 3465
#define SAY_KILL1                       -1000380 //signed for 3465
#define SAY_KILL2                       -1000381 //signed for 21027
#define SAY_KILL3                       -1000382 //signed for 21027
#define SAY_DEATH                       -1000383 //signed for 21027
#define EMOTE_FRENZY                    -1000384 //signed for 21027
#define SAY_RAND1                       -1000385 //signed for 21027
#define SAY_RAND2                       -1000386 //signed for 21027
#define SPELL_SHADOWVOLLEY              32963
#define SPELL_CLEAVE                    31779
#define SPELL_THUNDERCLAP               36706
#define SPELL_VOIDBOLT                  39329
#define SPELL_MARKOFKAZZAK              32960
#define SPELL_ENRAGE                    32964
#define SPELL_CAPTURESOUL               32966
#define SPELL_TWISTEDREFLECTION         21063
struct TRINITY_DLL_DECL boss_doomlordkazzakAI : public ScriptedAI
{
    boss_doomlordkazzakAI(Creature *c) : ScriptedAI(c) {}
    uint32 ShadowVolley_Timer;
    uint32 Cleave_Timer;
    uint32 ThunderClap_Timer;
    uint32 VoidBolt_Timer;
    uint32 MarkOfKazzak_Timer;
    uint32 Enrage_Timer;
    uint32 Twisted_Reflection_Timer;
    void Reset()
    {
        ShadowVolley_Timer = 6000 + rand()%4000;
        Cleave_Timer = 7000;
        ThunderClap_Timer = 14000 + rand()%4000;
        VoidBolt_Timer = 30000;
        MarkOfKazzak_Timer = 25000;
        Enrage_Timer = 60000;
        Twisted_Reflection_Timer = 33000;                   // Timer may be incorrect
    }
    void JustRespawned()
    {
        DoScriptText(SAY_INTRO, m_creature);
    }
    void EnterCombat(Unit *who)
    {
        DoScriptText(RAND(SAY_AGGRO1,SAY_AGGRO2), m_creature);
    }
    void KilledUnit(Unit* victim)
    {
        // When Kazzak kills a player (not pets/totems), he regens some health
         if (victim->GetTypeId() != TYPEID_PLAYER)
             return;
            DoCast(m_creature,SPELL_CAPTURESOUL);
            DoScriptText(RAND(SAY_KILL1,SAY_KILL2,SAY_KILL3), m_creature);
    }
    void JustDied(Unit *victim)
    {
        DoScriptText(SAY_DEATH, m_creature);
    }
    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;
        //ShadowVolley_Timer
        if (ShadowVolley_Timer < diff)
        {
            DoCast(m_creature->getVictim(), SPELL_SHADOWVOLLEY);
            ShadowVolley_Timer = 4000 + rand()%2000;
        }else ShadowVolley_Timer -= diff;
        //Cleave_Timer
        if (Cleave_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_CLEAVE);
            Cleave_Timer = 8000 + rand()%4000;
        }else Cleave_Timer -= diff;
        //ThunderClap_Timer
        if (ThunderClap_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_THUNDERCLAP);
            ThunderClap_Timer = 10000 + rand()%4000;
        }else ThunderClap_Timer -= diff;
        //VoidBolt_Timer
        if (VoidBolt_Timer < diff)
        {
            DoCast(m_creature->getVictim(),SPELL_VOIDBOLT);
            VoidBolt_Timer = 15000 + rand()%3000;
        }else VoidBolt_Timer -= diff;
        //MarkOfKazzak_Timer
        if (MarkOfKazzak_Timer < diff)
        {
            Unit* victim = SelectUnit(SELECT_TARGET_RANDOM, 0);
            if (victim->GetPower(POWER_MANA))
            {
                DoCast(victim, SPELL_MARKOFKAZZAK);
                MarkOfKazzak_Timer = 20000;
            }
        }else MarkOfKazzak_Timer -= diff;
        //Enrage_Timer
        if (Enrage_Timer < diff)
        {
            DoScriptText(EMOTE_FRENZY, m_creature);
            DoCast(m_creature,SPELL_ENRAGE);
            Enrage_Timer = 30000;
        }else Enrage_Timer -= diff;
        if (Twisted_Reflection_Timer < diff)
        {
            DoCast(SelectUnit(SELECT_TARGET_RANDOM, 0), SPELL_TWISTEDREFLECTION);
            Twisted_Reflection_Timer = 15000;
        }else Twisted_Reflection_Timer -= diff;
        DoMeleeAttackIfReady();
    }
};
CreatureAI* GetAI_boss_doomlordkazzak(Creature* pCreature)
{
    return new boss_doomlordkazzakAI (pCreature);
}
void AddSC_boss_doomlordkazzak()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_doomlord_kazzak";
    newscript->GetAI = &GetAI_boss_doomlordkazzak;
    newscript->RegisterSelf();
}

