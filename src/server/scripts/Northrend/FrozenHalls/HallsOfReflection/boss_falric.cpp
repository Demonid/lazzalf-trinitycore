/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
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
 SDName: boss_falric
 SD%Complete: 0%
 SDComment: new script for tc implementation.
 SDCategory: Halls of Reflection
 EndScriptData */

#include "ScriptPCH.h"
#include "ScriptedCreature.h"
#include "halls_of_reflection.h"

enum Texts
{
    SAY_FALRIC_AGGRO                        = -1668050,
    SAY_FALRIC_DEATH                        = -1668053,
    SAY_FALRIC_SLAY01                       = -1668051,
    SAY_FALRIC_SLAY02                       = -1668052,
    SAY_FALRIC_SP01                         = -1668054,
    SAY_FALRIC_SP02                         = -1668055,
};

enum Spells
{
    SPELL_IMPENDING_DESPAIR                 = 72426,
    SPELL_DEFILING_HORROR_N                 = 72435,
    SPELL_DEFILING_HORROR_H                 = 72452,
    SPELL_QUIVERING_STRIKE_N                = 72422,
    SPELL_QUIVERING_STRIKE_H                = 72453,

    SPELL_HOPELESSNESS_20                      = 72395,
	SPELL_HOPELESSNESS_40                      = 72396,
	SPELL_HOPELESSNESS_60                      = 72397,
    H_SPELL_HOPELESSNESS_25                    = 72390,
	H_SPELL_HOPELESSNESS_50                    = 72391,
	H_SPELL_HOPELESSNESS_75                    = 72393,

    SPELL_BERSERK                           = 47008
};

class boss_falric : public CreatureScript
{
public:
    boss_falric() : CreatureScript("boss_falric") { }

    struct boss_falricAI : public ScriptedAI
    {
        boss_falricAI(Creature *pCreature) : ScriptedAI(pCreature)
       {
            m_pInstance = (InstanceScript*)pCreature->GetInstanceScript();
            Reset();
       }

       InstanceScript* m_pInstance;
       bool m_bIsCall;
       //FUNCTIONS
       uint32 m_uiBerserkTimer;
       uint32 m_uiGrowlTimer;
       uint32 m_uiHorrorTimer;
       uint32 m_uiStrikeTimer;
       uint32 m_uiSummonTimer;
       uint32 m_uiLocNo;
       uint64 m_uiSummonGUID[16];
       uint32 m_uiCheckSummon;

       uint8 uiHopelessnessCount;

       uint8 SummonCount;
       uint64 pSummon;
       bool hasBeenInCombat;

       void Reset()
       {
		   if (!me->isAlive())
			   me->Respawn();

           hasBeenInCombat = true;
           m_uiBerserkTimer = 180000;
           SummonCount = 0;
           m_bIsCall = false;
           m_uiGrowlTimer = 20000;
           m_uiHorrorTimer = urand(14000,20000);
           m_uiStrikeTimer = 2000;
           m_uiSummonTimer = 11000;
           uiHopelessnessCount = 0;
           me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
		   
		   if ( m_pInstance->GetData(TYPE_PHASE) == 2 )
			   me->SetVisible(true);
		   else me->SetVisible(false);
        }

        void EnterCombat(Unit* pVictim)
        {
            hasBeenInCombat = true;
            DoScriptText(SAY_FALRIC_AGGRO, me);
        }

        void KilledUnit(Unit* pVictim)
        {
            switch(urand(0,1))
            {
                case 0: DoScriptText(SAY_FALRIC_SLAY01, me); break;
                case 1: DoScriptText(SAY_FALRIC_SLAY02, me); break;
            }
        }

		void JustDied(Unit* pKiller)
		{
			if (m_pInstance) 
				m_pInstance->SetData(TYPE_FALRIC, DONE);
			DoScriptText(SAY_FALRIC_DEATH, me);
		}

        void AttackStart(Unit* who) 
        { 
            if (!m_pInstance) 
                return;

            if (m_pInstance->GetData(TYPE_FALRIC) != IN_PROGRESS)
                 return; 

            ScriptedAI::AttackStart(who);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!m_pInstance) 
                return;

            if (m_pInstance->GetData(TYPE_FALRIC) != IN_PROGRESS)
                 return;

			if (!UpdateVictim())
                return;

            if (m_uiStrikeTimer < uiDiff)
            {
                DoCast(me->getVictim(), DUNGEON_MODE(SPELL_QUIVERING_STRIKE_N, SPELL_QUIVERING_STRIKE_H));
                m_uiStrikeTimer = (urand(7000, 14000));
            }
            else m_uiStrikeTimer -= uiDiff;

            if (m_uiHorrorTimer < uiDiff)
            {
                DoScriptText(SAY_FALRIC_SP01, me);
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 120, true))
                   DoCast(pTarget, SPELL_IMPENDING_DESPAIR);
                m_uiHorrorTimer = (urand(15000, 25000));
            }
            else m_uiHorrorTimer -= uiDiff;

            if (m_uiGrowlTimer < uiDiff)
            {
                DoScriptText(SAY_FALRIC_SP02, me);
                DoCast(me->getVictim(), DUNGEON_MODE(SPELL_DEFILING_HORROR_N, SPELL_DEFILING_HORROR_H));
                m_uiGrowlTimer = urand(25000, 30000);
            }
            else m_uiGrowlTimer -= uiDiff;

            if (m_uiBerserkTimer < uiDiff)
            {
                DoCast(me, SPELL_BERSERK);
                m_uiBerserkTimer = 180000;
            } else  m_uiBerserkTimer -= uiDiff;

			if ( HealthBelowPct(66) )
				if ( uiHopelessnessCount == 0 )
				{
					uiHopelessnessCount++;
					DoCast( DUNGEON_MODE(SPELL_HOPELESSNESS_20, H_SPELL_HOPELESSNESS_25) );
				}

			/* 
			
			if ( HealthBelowPct(33) )
				if ( uiHopelessnessCount == 1 )
				{
					uiHopelessnessCount++;
					me->RemoveAura ( DUNGEON_MODE(SPELL_HOPELESSNESS_20, H_SPELL_HOPELESSNESS_25) );
					DoCast( DUNGEON_MODE(SPELL_HOPELESSNESS_40, H_SPELL_HOPELESSNESS_50) );
				}

			if ( HealthBelowPct(10) )
				if ( uiHopelessnessCount == 2 )
				{
					uiHopelessnessCount++;
					me->RemoveAura ( DUNGEON_MODE(SPELL_HOPELESSNESS_40, H_SPELL_HOPELESSNESS_50) );
					DoCast( DUNGEON_MODE(SPELL_HOPELESSNESS_60, H_SPELL_HOPELESSNESS_75) );
				}

			*/

            DoMeleeAttackIfReady();  

            return;
        }

		void DoAction(int32 const param)
		{
			switch (param)
			{
			case 0:
				m_pInstance->SetData(TYPE_FALRIC, IN_PROGRESS);
				me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
				me->SetInCombatWithZone();
				break;
			}
		}

    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_falricAI(pCreature);
    }

};

void AddSC_boss_falric()
{
    new boss_falric();
}
