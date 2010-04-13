/* Copyright (C) 2010 EmeraldEmu <wow.4vendeta.com>
 * Emerald Emu is based on Trinity Core and MaNGOS. 
 * EEMU is personaly developed for Vendeta High Rate.
 */

#include "ScriptedPch.h"
#include "def.h"
enum
{
	H_Stomp		= 67649,
	Stomp		= 66330,
	H_Impale	= 67477,
	Impale		= 67478,
	Whirl		= 63666,
	FireBomb	= 66313,
	HeadCrack	= 66407,
	Batter		= 66408,
	RisingAnger	= 36300
};
struct  boss_gormokAI : public ScriptedAI
{
	boss_gormokAI(Creature* pCreature) : ScriptedAI(pCreature) 
	{
	pInstance = pCreature->GetInstanceData();
	}
	ScriptedInstance* pInstance;
	
    uint32 Phase;
    uint32 Stomp_Timer;
    uint32 Impale_Timer;
    uint32 Whirl_Timer;
    uint32 PhaseTimer;
    uint32 EndPhaseTwo;
    uint32 Summon_Timer;
    uint32 Summon_Count;
    
    void Reset()
	{
	if (pInstance)
            pInstance->SetData(DATA_BOSS_GORMOK, NOT_STARTED);
	    m_creature->GetMotionMaster()->MovePoint(0, 563.539551, 213.565628, 395.098206);
	
	Phase = 0;
	PhaseTimer = 60000; // 2 minute
	Stomp_Timer = 10000; //30secs for spell 1
	Impale_Timer = 5000; // 5 seconds 
	Summon_Timer = 20000; // 25 seconds
	Whirl_Timer = 5000;
	Summon_Count = 0;
	}
    
    void EnterCombat(Unit *who)
    {
        DoZoneInCombat();
        m_creature->MonsterSay("ROAR!", LANG_UNIVERSAL, 0);
        if (pInstance)
            pInstance->SetData(DATA_BOSS_GORMOK, IN_PROGRESS);
    }
    
    void UpdateAI(const uint32 diff )
	{
	if (!UpdateVictim())
	return;
	
		if(Stomp_Timer < diff)
		{
			m_creature->MonsterSay("I STOMP ON YOUR FACE!", LANG_UNIVERSAL, 0);
			DoCast(m_creature->getVictim(),Stomp);
			Stomp_Timer = 30000;
		}else Stomp_Timer -= diff;
 
		if(Impale_Timer < diff)
		{	
			DoCast(m_creature->getVictim(),Impale);
			Impale_Timer = 10000;
			m_creature->MonsterSay("IMPALE!", LANG_UNIVERSAL, 0);
		}else Impale_Timer -= diff;

		if(Summon_Timer < diff && Summon_Count <= 4)
		{
			if (Unit *pTarget1 = SelectUnit(SELECT_TARGET_RANDOM,0))
			{
			if (Creature *pLarva1 = pTarget1->SummonCreature(34800,pTarget1->GetPositionX() ,pTarget1->GetPositionY()+1, pTarget1->GetPositionZ()+1, 0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000))
			{
			DoCast(m_creature,RisingAnger);	
			pLarva1->AI()->AttackStart(pTarget1); 
			pLarva1->MonsterSay("Boss Enjoy the buff :D", LANG_UNIVERSAL, 0);
			Summon_Count = (Summon_Count + 1);
			}
			}
			Summon_Timer = 60000;
			m_creature->MonsterSay("Enjoy my little friends", LANG_UNIVERSAL, 0);
		}else Summon_Timer -= diff;
 
 
	DoMeleeAttackIfReady();
	}
 
    void JustDied(Unit* Killer)
    {
        if (pInstance)
            pInstance->SetData(DATA_BOSS_GORMOK, DONE);
    }
};

CreatureAI* GetAI_boss_gormok(Creature* pCreature)
{
    return new boss_gormokAI(pCreature);
}
 
 
 
void AddSC_boss_gormok()
{
    Script* newscript;
 
    newscript = new Script;
    newscript->Name = "boss_gormok";
    newscript->GetAI = &GetAI_boss_gormok;
    newscript->RegisterSelf();
}