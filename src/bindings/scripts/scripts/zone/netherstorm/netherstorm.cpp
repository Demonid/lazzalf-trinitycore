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
SDName: Netherstorm
SD%Complete: 75
SDComment: Quest support: 10438, 10652 (special flight paths), 10299,10321,10322,10323,10329,10330,10338,10365(Shutting Down Manaforge), 10198
SDCategory: Netherstorm
EndScriptData */

/* ContentData
npc_manaforge_control_console
go_manaforge_control_console
npc_commander_dawnforge
npc_protectorate_nether_drake
npc_veronia
EndContentData */

#include "precompiled.h"

/*######
## npc_manaforge_control_console
######*/

#define EMOTE_START     "Warning! Emergency shutdown process initiated by $N. Shutdown will complete in two minutes."
#define EMOTE_60        "Emergency shutdown will complete in one minute."
#define EMOTE_30        "Emergency shutdown will complete in thirty seconds."
#define EMOTE_10        "Emergency shutdown will complete in ten seconds."
#define EMOTE_COMPLETE  "Emergency shutdown complete."
#define EMOTE_ABORT     "Emergency shutdown aborted."

#define ENTRY_BNAAR_C_CONSOLE   20209
#define ENTRY_CORUU_C_CONSOLE   20417
#define ENTRY_DURO_C_CONSOLE    20418
#define ENTRY_ARA_C_CONSOLE     20440

#define ENTRY_SUNFURY_TECH      20218
#define ENTRY_SUNFURY_PROT      20436

#define ENTRY_ARA_TECH          20438
#define ENTRY_ARA_ENGI          20439
#define ENTRY_ARA_GORKLONN      20460

#define SPELL_DISABLE_VISUAL    35031
#define SPELL_INTERRUPT_1       35016                       //ACID mobs should cast this
#define SPELL_INTERRUPT_2       35176                       //ACID mobs should cast this (Manaforge Ara-version)

struct TRINITY_DLL_DECL npc_manaforge_control_consoleAI : public ScriptedAI
{
    npc_manaforge_control_consoleAI(Creature *c) : ScriptedAI(c) {Reset();}

    uint32 Event_Timer;
    uint32 Wave_Timer;
    uint32 Phase;
    bool Wave;
    uint64 someplayer;
    uint64 goConsole;
    Creature* add;

    void Reset()
    {
        Event_Timer = 3000;
        Wave_Timer = 0;
        Phase = 1;
        Wave = false;
        someplayer = 0;
        goConsole = 0;
        Creature* add = NULL;
    }

    void Aggro(Unit *who) { return; }

    /*void SpellHit(Unit *caster, const SpellEntry *spell)
    {
        //we have no way of telling the creature was hit by spell -> got aura applied after 10-12 seconds
        //then no way for the mobs to actually stop the shutdown as intended.
        if( spell->Id == SPELL_INTERRUPT_1 )
            DoSay("Silence! I kill you!",LANG_UNIVERSAL, NULL);
    }*/

    void JustDied(Unit* killer)
    {
        DoTextEmote(EMOTE_ABORT, NULL);

        if( someplayer )
        {
            Unit* p = Unit::GetUnit((*m_creature),someplayer);
            if( p && p->GetTypeId() == TYPEID_PLAYER )
            {
                switch( m_creature->GetEntry() )
                {
                    case ENTRY_BNAAR_C_CONSOLE:
                        ((Player*)p)->FailQuest(10299);
                        ((Player*)p)->FailQuest(10329);
                        break;
                    case ENTRY_CORUU_C_CONSOLE:
                        ((Player*)p)->FailQuest(10321);
                        ((Player*)p)->FailQuest(10330);
                        break;
                    case ENTRY_DURO_C_CONSOLE:
                        ((Player*)p)->FailQuest(10322);
                        ((Player*)p)->FailQuest(10338);
                        break;
                    case ENTRY_ARA_C_CONSOLE:
                        ((Player*)p)->FailQuest(10323);
                        ((Player*)p)->FailQuest(10365);
                        break;
                }
            }
        }

        if( goConsole )
        {
            if( GameObject* go = GameObject::GetGameObject((*m_creature),goConsole) )
                go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
        }
    }

    void DoWaveSpawnForCreature(Creature *creature)
    {
        switch( creature->GetEntry() )
        {
            case ENTRY_BNAAR_C_CONSOLE:
                if( rand()%2 )
                {
                    add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2933.68,4162.55,164.00,1.60,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,2927.36,4212.97,164.00);
                }
                else
                {
                    add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2927.36,4212.97,164.00,4.94,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,2933.68,4162.55,164.00);
                }
                Wave_Timer = 30000;
                break;
            case ENTRY_CORUU_C_CONSOLE:
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2445.21,2765.26,134.49,3.93,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2424.21,2740.15,133.81);
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2429.86,2731.85,134.53,1.31,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2435.37,2766.04,133.81);
                Wave_Timer = 20000;
                break;
            case ENTRY_DURO_C_CONSOLE:
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2986.80,2205.36,165.37,3.74,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2985.15,2197.32,164.79);
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2952.91,2191.20,165.32,0.22,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2060.01,2185.27,164.67);
                Wave_Timer = 15000;
                break;
            case ENTRY_ARA_C_CONSOLE:
                if( rand()%2 )
                {
                    add = m_creature->SummonCreature(ENTRY_ARA_TECH,4035.11,4038.97,194.27,2.57,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,4003.42,4040.19,193.49);
                    add = m_creature->SummonCreature(ENTRY_ARA_TECH,4033.66,4036.79,194.28,2.57,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,4003.42,4040.19,193.49);
                    add = m_creature->SummonCreature(ENTRY_ARA_TECH,4037.13,4037.30,194.23,2.57,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,4003.42,4040.19,193.49);
                }
                else
                {
                    add = m_creature->SummonCreature(ENTRY_ARA_TECH,3099.59,4049.30,194.22,0.05,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,4028.01,4035.17,193.59);
                    add = m_creature->SummonCreature(ENTRY_ARA_TECH,3999.72,4046.75,194.22,0.05,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,4028.01,4035.17,193.59);
                    add = m_creature->SummonCreature(ENTRY_ARA_TECH,3996.81,4048.26,194.22,0.05,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                    if( add ) add->GetMotionMaster()->MovePoint(0,4028.01,4035.17,193.59);
                }
                Wave_Timer = 15000;
                break;
        }
    }
    void DoFinalSpawnForCreature(Creature *creature)
    {
        switch( creature->GetEntry() )
        {
            case ENTRY_BNAAR_C_CONSOLE:
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2946.52,4201.42,163.47,3.54,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2927.49,4192.81,163.00);
                break;
            case ENTRY_CORUU_C_CONSOLE:
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2453.88,2737.85,133.27,2.59,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2433.96,2751.53,133.85);
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2441.62,2735.32,134.49,1.97,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2433.96,2751.53,133.85);
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2450.73,2754.50,134.49,3.29,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2433.96,2751.53,133.85);
                break;
            case ENTRY_DURO_C_CONSOLE:
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2956.18,2202.85,165.32,5.45,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2972.27,2193.22,164.48);
                add = m_creature->SummonCreature(ENTRY_SUNFURY_TECH,2975.30,2211.50,165.32,4.55,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2972.27,2193.22,164.48);
                add = m_creature->SummonCreature(ENTRY_SUNFURY_PROT,2965.02,2217.45,164.16,4.96,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,2972.27,2193.22,164.48);
                break;
            case ENTRY_ARA_C_CONSOLE:
                add = m_creature->SummonCreature(ENTRY_ARA_ENGI,3994.51,4020.46,192.18,0.91,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,4008.35,4035.04,192.70);
                add = m_creature->SummonCreature(ENTRY_ARA_GORKLONN,4021.56,4059.35,193.59,4.44,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                if( add ) add->GetMotionMaster()->MovePoint(0,4016.62,4039.89,193.46);
                break;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if( Event_Timer < diff )
        {
            switch(Phase)
            {
                case 1:
                    if( someplayer )
                    {
                        Unit* u = Unit::GetUnit((*m_creature),someplayer);
                        if( u && u->GetTypeId() == TYPEID_PLAYER ) DoTextEmote(EMOTE_START, u);
                    }
                    Event_Timer = 60000;
                    Wave = true;
                    ++Phase;
                    break;
                case 2:
                    DoTextEmote(EMOTE_60, NULL);
                    Event_Timer = 30000;
                    ++Phase;
                    break;
                case 3:
                    DoTextEmote(EMOTE_30, NULL);
                    Event_Timer = 20000;
                    DoFinalSpawnForCreature(m_creature);
                    ++Phase;
                    break;
                case 4:
                    DoTextEmote(EMOTE_10, NULL);
                    Event_Timer = 10000;
                    Wave = false;
                    ++Phase;
                    break;
                case 5:
                    DoTextEmote(EMOTE_COMPLETE, NULL);
                    if( someplayer )
                    {
                        Unit* u = Unit::GetUnit((*m_creature),someplayer);
                        if( u && u->GetTypeId() == TYPEID_PLAYER )
                            ((Player*)u)->KilledMonster(m_creature->GetEntry(),m_creature->GetGUID());
                        DoCast(m_creature,SPELL_DISABLE_VISUAL);
                    }
                    if( goConsole )
                    {
                        if( GameObject* go = GameObject::GetGameObject((*m_creature),goConsole) )
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                    }
                    ++Phase;
                    break;
            }
        } else Event_Timer -= diff;

        if( Wave )
        {
            if( Wave_Timer < diff )
            {
                DoWaveSpawnForCreature(m_creature);
            } else Wave_Timer -= diff;
        }
    }
};
CreatureAI* GetAI_npc_manaforge_control_console(Creature *_Creature)
{
    return new npc_manaforge_control_consoleAI (_Creature);
}

/*######
## go_manaforge_control_console
######*/

//TODO: clean up this workaround when Trinity adds support to do it properly (with gossip selections instead of instant summon)
bool GOHello_go_manaforge_control_console(Player *player, GameObject* _GO)
{
    if (_GO->GetGoType() == GAMEOBJECT_TYPE_QUESTGIVER)
    {
        player->PrepareQuestMenu(_GO->GetGUID());
        player->SendPreparedQuest(_GO->GetGUID());
    }

    Creature* manaforge;
    manaforge = NULL;

    switch( _GO->GetAreaId() )
    {
        case 3726:                                          //b'naar
            if( (player->GetQuestStatus(10299) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10329) == QUEST_STATUS_INCOMPLETE) &&
                player->HasItemCount(29366,1))
                manaforge = player->SummonCreature(ENTRY_BNAAR_C_CONSOLE,2918.95,4189.98,161.88,0.34,TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN,125000);
            break;
        case 3730:                                          //coruu
            if( (player->GetQuestStatus(10321) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10330) == QUEST_STATUS_INCOMPLETE) &&
                player->HasItemCount(29396,1))
                manaforge = player->SummonCreature(ENTRY_CORUU_C_CONSOLE,2426.77,2750.38,133.24,2.14,TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN,125000);
            break;
        case 3734:                                          //duro
            if( (player->GetQuestStatus(10322) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10338) == QUEST_STATUS_INCOMPLETE) &&
                player->HasItemCount(29397,1))
                manaforge = player->SummonCreature(ENTRY_DURO_C_CONSOLE,2976.48,2183.29,163.20,1.85,TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN,125000);
            break;
        case 3722:                                          //ara
            if( (player->GetQuestStatus(10323) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10365) == QUEST_STATUS_INCOMPLETE) &&
                player->HasItemCount(29411,1))
                manaforge = player->SummonCreature(ENTRY_ARA_C_CONSOLE,4013.71,4028.76,192.10,1.25,TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN,125000);
            break;
    }

    if( manaforge )
    {
        ((npc_manaforge_control_consoleAI*)manaforge->AI())->someplayer = player->GetGUID();
        ((npc_manaforge_control_consoleAI*)manaforge->AI())->goConsole = _GO->GetGUID();
        _GO->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
    }
    return true;
}

/*######
## npc_commander_dawnforge
######*/
	 	 
// The Speech of Dawnforge, Ardonis & Pathaleon
#define SAY_COMMANDER_DAWNFORGE_1           -1000128
#define SAY_ARCANIST_ARDONIS_1              -1000129
#define SAY_COMMANDER_DAWNFORGE_2           -1000130
#define SAY_PATHALEON_CULATOR_IMAGE_1       -1000131
#define SAY_COMMANDER_DAWNFORGE_3           -1000132
#define SAY_PATHALEON_CULATOR_IMAGE_2       -1000133
#define SAY_PATHALEON_CULATOR_IMAGE_2_1     -1000134
#define SAY_PATHALEON_CULATOR_IMAGE_2_2     -1000135
#define SAY_COMMANDER_DAWNFORGE_4           -1000136
#define SAY_ARCANIST_ARDONIS_2              -1000136
#define SAY_COMMANDER_DAWNFORGE_5           -1000137

#define QUEST_INFO_GATHERING                10198
#define SPELL_SUNFURY_DISGUISE              34603
	 	 
// Entries of Arcanist Ardonis, Commander Dawnforge, Pathaleon the Curators Image
int CreatureEntry[3][1] =
{
	{19830},                                                // Ardonis
	{19831},                                                // Dawnforge
	{21504}                                                 // Pathaleon
};

struct TRINITY_DLL_DECL npc_commander_dawnforgeAI : public ScriptedAI
{
	npc_commander_dawnforgeAI(Creature *c) : ScriptedAI(c) { Reset (); }


	uint64 playerGUID;
	uint64 ardonisGUID;
	uint64 pathaleonGUID;


	uint32 Phase;
	uint32 PhaseSubphase;
	uint32 Phase_Timer;
	bool isEvent;
	 	 
	float angle_dawnforge;
	float angle_ardonis;
	 	 
	void Reset()
	{
		playerGUID = 0;
		ardonisGUID = 0;
		pathaleonGUID = 0;

		Phase = 1;
		PhaseSubphase = 0;
		Phase_Timer = 4000;
		isEvent = false;
	}
	 	 
	void Aggro(Unit *who) { }

	//Select any creature in a grid
	Creature* SelectCreatureInGrid(uint32 entry, float range)
	{
		Creature* pCreature = NULL;

		CellPair pair(Trinity::ComputeCellPair(m_creature->GetPositionX(), m_creature->GetPositionY()));
		Cell cell(pair);
		cell.data.Part.reserved = ALL_DISTRICT;
		cell.SetNoCreate();
	 	 
		Trinity::NearestCreatureEntryWithLiveStateInObjectRangeCheck creature_check(*m_creature, entry, true, range);
		Trinity::CreatureLastSearcher<Trinity::NearestCreatureEntryWithLiveStateInObjectRangeCheck> searcher(pCreature, creature_check);
	 	 
		TypeContainerVisitor<Trinity::CreatureLastSearcher<Trinity::NearestCreatureEntryWithLiveStateInObjectRangeCheck>, GridTypeMapContainer> creature_searcher(searcher);
	 	 
		CellLock<GridReadGuard> cell_lock(cell, pair);
		cell_lock->Visit(cell_lock, creature_searcher,*(m_creature->GetMap()));

		return pCreature;
	}
	 	 
	void JustSummoned(Creature *summoned)
	{
		pathaleonGUID = summoned->GetGUID();
	}
	 	 
	// Emote Ardonis and Pathaleon
	void Turn_to_Pathaleons_Image()
	{
		Unit *ardonis = Unit::GetUnit(*m_creature,ardonisGUID);
		Unit *pathaleon = Unit::GetUnit(*m_creature,pathaleonGUID);
		Player *player = (Player*)Unit::GetUnit(*m_creature,playerGUID);
 	 
		if (!ardonis || !pathaleon || !player)
			return;
	 	 
		//Calculate the angle to Pathaleon
		angle_dawnforge = m_creature->GetAngle(pathaleon->GetPositionX(), pathaleon->GetPositionY());
		angle_ardonis = ardonis->GetAngle(pathaleon->GetPositionX(), pathaleon->GetPositionY());

		//Turn Dawnforge and update
		m_creature->SetOrientation(angle_dawnforge);
		m_creature->SendUpdateToPlayer(player);
		//Turn Ardonis and update
		ardonis->SetOrientation(angle_ardonis);
		ardonis->SendUpdateToPlayer(player);

		//Set them to kneel
		m_creature->SetStandState(PLAYER_STATE_KNEEL);
		ardonis->SetStandState(PLAYER_STATE_KNEEL);
	}
	 	 
	//Set them back to each other
	void Turn_to_eachother()
	{
		if (Unit *ardonis = Unit::GetUnit(*m_creature,ardonisGUID))
		{
			Player *player = (Player*)Unit::GetUnit(*m_creature,playerGUID);

			if (!player)
				return;
	 	 
			angle_dawnforge = m_creature->GetAngle(ardonis->GetPositionX(), ardonis->GetPositionY());
			angle_ardonis = ardonis->GetAngle(m_creature->GetPositionX(), m_creature->GetPositionY());
	 	 
			//Turn Dawnforge and update
			m_creature->SetOrientation(angle_dawnforge);
			m_creature->SendUpdateToPlayer(player);
			//Turn Ardonis and update
			ardonis->SetOrientation(angle_ardonis);
			ardonis->SendUpdateToPlayer(player);

			//Set state
			m_creature->SetStandState(PLAYER_STATE_NONE);
			ardonis->SetStandState(PLAYER_STATE_NONE);
		}
	}
	 	 
	bool CanStartEvent(Player *player)
	{
		if (!isEvent)
		{
			Creature *ardonis = SelectCreatureInGrid(CreatureEntry[0][0], 10.0f);
			if (!ardonis)
				return false;

			ardonisGUID = ardonis->GetGUID();
			playerGUID = player->GetGUID();
	 	 
			isEvent = true;

			Turn_to_eachother();
			return true;
		}
	 	 
		debug_log("SD2: npc_commander_dawnforge event already in progress, need to wait.");
		return false;
	}

	void UpdateAI(const uint32 diff)
	{
		//Is event even running?
		if (!isEvent)
			return;

		//Phase timing
		if (Phase_Timer >= diff)
		{
			Phase_Timer -= diff;
			return;
		}
	 	 
		Unit *ardonis = Unit::GetUnit(*m_creature,ardonisGUID);
		Unit *pathaleon = Unit::GetUnit(*m_creature,pathaleonGUID);
		Player *player = (Player*)Unit::GetUnit(*m_creature,playerGUID);
	 	 
		if (!ardonis || !player)
		{
			Reset();
			return;
		}
	 	 
		if (Phase > 4 && !pathaleon)
		{
			Reset();
			return;
		}
 	 
		//Phase 1 Dawnforge say
		switch (Phase)
		{
		case 1:
			DoScriptText(SAY_COMMANDER_DAWNFORGE_1, m_creature);
			++Phase;
			Phase_Timer = 16000;
			break;
			//Phase 2 Ardonis say
		case 2:
			DoScriptText(SAY_ARCANIST_ARDONIS_1, ardonis);
			++Phase;
			Phase_Timer = 16000;
			break;
			//Phase 3 Dawnforge say
		case 3:
			DoScriptText(SAY_COMMANDER_DAWNFORGE_2, m_creature);
			++Phase;
			Phase_Timer = 16000;
			break;
			//Phase 4 Pathaleon spawns up to phase 9
		case 4:
			//spawn pathaleon's image
			m_creature->SummonCreature(CreatureEntry[2][0], 2325.851563, 2799.534668, 133.084229, 6.038996, TEMPSUMMON_TIMED_DESPAWN, 90000);
			++Phase;
			Phase_Timer = 500;
			break;
			//Phase 5 Pathaleon say
		case 5:
			DoScriptText(SAY_PATHALEON_CULATOR_IMAGE_1, pathaleon);
			++Phase;
			Phase_Timer = 6000;
			break;
			//Phase 6
		case 6:
			switch(PhaseSubphase)
			{
				//Subphase 1: Turn Dawnforge and Ardonis
			case 0:
				Turn_to_Pathaleons_Image();
				++PhaseSubphase;
				Phase_Timer = 8000;
				break;
				//Subphase 2 Dawnforge say
			case 1:
				DoScriptText(SAY_COMMANDER_DAWNFORGE_3, m_creature);
				PhaseSubphase = 0;
				++Phase;
				Phase_Timer = 8000;
				break;
			}
			break;
			//Phase 7 Pathaleons say 3 Sentence, every sentence need a subphase
		case 7:
			switch(PhaseSubphase)
			{
				//Subphase 1
			case 0:
				DoScriptText(SAY_PATHALEON_CULATOR_IMAGE_2, pathaleon);
				++PhaseSubphase;
				Phase_Timer = 12000;
				break;
				//Subphase 2
			case 1:
				DoScriptText(SAY_PATHALEON_CULATOR_IMAGE_2_1, pathaleon);
				++PhaseSubphase;
				Phase_Timer = 16000;
				break;
				//Subphase 3
			case 2:
				DoScriptText(SAY_PATHALEON_CULATOR_IMAGE_2_2, pathaleon);
				PhaseSubphase = 0;
				++Phase;
				Phase_Timer = 10000;
				break;
			}
			break;
			//Phase 8 Dawnforge & Ardonis say
		case 8:
			DoScriptText(SAY_COMMANDER_DAWNFORGE_4, m_creature);
			DoScriptText(SAY_ARCANIST_ARDONIS_2, ardonis);
			++Phase;
			Phase_Timer = 4000;
			break;
			//Phase 9 Pathaleons Despawn, Reset Dawnforge & Ardonis angle
		case 9:
			Turn_to_eachother();
			//hide pathaleon, unit will despawn shortly
			pathaleon->SetVisibility(VISIBILITY_OFF);
			PhaseSubphase = 0;
			++Phase;
			Phase_Timer = 3000;
			break;
			//Phase 10 Dawnforge say
		case 10:
			DoScriptText(SAY_COMMANDER_DAWNFORGE_5, m_creature);
			player->AreaExploredOrEventHappens(QUEST_INFO_GATHERING);
			Reset();
			break;
		}
	 }
};
	 	 
CreatureAI* GetAI_npc_commander_dawnforge(Creature* _Creature)
{
	return new npc_commander_dawnforgeAI(_Creature);
}
	 	 
Creature* SearchDawnforge(Player *source, uint32 entry, float range)
{
	Creature* pCreature = NULL;

	CellPair pair(Trinity::ComputeCellPair(source->GetPositionX(), source->GetPositionY()));
	Cell cell(pair);
	cell.data.Part.reserved = ALL_DISTRICT;
	cell.SetNoCreate();
	 	 
	Trinity::NearestCreatureEntryWithLiveStateInObjectRangeCheck creature_check(*source, entry, true, range);
	Trinity::CreatureLastSearcher<Trinity::NearestCreatureEntryWithLiveStateInObjectRangeCheck> searcher(pCreature, creature_check);

	TypeContainerVisitor<Trinity::CreatureLastSearcher<Trinity::NearestCreatureEntryWithLiveStateInObjectRangeCheck>, GridTypeMapContainer> creature_searcher(searcher);
	 	 
	CellLock<GridReadGuard> cell_lock(cell, pair);
	cell_lock->Visit(cell_lock, creature_searcher,*(source->GetMap()));
	 	 
	return pCreature;
}
	 	 
bool AreaTrigger_at_commander_dawnforge(Player *player, AreaTriggerEntry *at)
{
	//if player lost aura or not have at all, we should not try start event.
	if (!player->HasAura(SPELL_SUNFURY_DISGUISE,0))
		return false;
	 	 
	if (player->isAlive() && player->GetQuestStatus(QUEST_INFO_GATHERING) == QUEST_STATUS_INCOMPLETE)
	{
		Creature* Dawnforge = SearchDawnforge(player, CreatureEntry[1][0], 30.0f);

		if (!Dawnforge)
			return false;
	 	 
		if (((npc_commander_dawnforgeAI*)Dawnforge->AI())->CanStartEvent(player))
			return true;
	}
	return false;
}

/*######
## npc_protectorate_nether_drake
######*/

bool GossipHello_npc_protectorate_nether_drake(Player *player, Creature *_Creature)
{
    //On Nethery Wings
    if (player->GetQuestStatus(10438) == QUEST_STATUS_INCOMPLETE && player->HasItemCount(29778,1) )
        player->ADD_GOSSIP_ITEM(0, "Fly me to Ultris", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_protectorate_nether_drake(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        player->CLOSE_GOSSIP_MENU();

        std::vector<uint32> nodes;

        nodes.resize(2);
        nodes[0] = 152;                                     //from drake
        nodes[1] = 153;                                     //end at drake
        player->ActivateTaxiPathTo(nodes);                  //TaxiPath 627 (possibly 627+628(152->153->154->155) )
    }
    return true;
}

/*######
## npc_veronia
######*/

bool GossipHello_npc_veronia(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    //Behind Enemy Lines
    if (player->GetQuestStatus(10652) && !player->GetQuestRewardStatus(10652))
        player->ADD_GOSSIP_ITEM(0, "Fly me to Manaforge Coruu please", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_veronia(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,34905,true);               //TaxiPath 606
    }
    return true;
}

/*######
## mob_phase_hunter
######*/

#define SUMMONED_MOB            19595
#define EMOTE_WEAK              "is very weak"

// Spells
#define SPELL_PHASE_SLIP        36574
#define SPELL_MANA_BURN         13321
#define SPELL_MATERIALIZE       34804
#define SPELL_DE_MATERIALIZE    34804

struct TRINITY_DLL_DECL mob_phase_hunterAI : public ScriptedAI
{

    mob_phase_hunterAI(Creature *c) : ScriptedAI(c) {Reset();}
    
    bool Weak;
	bool Materialize;

    int WeakPercent;
    uint32 PlayerGUID;
    uint32 Health;
    uint32 Level;
    uint32 PhaseSlipVulnerabilityTimer;
    uint32 ManaBurnTimer;

    void Reset()
    {
        Weak = false;
		Materialize = false;

        WeakPercent = 25 + (rand()%16); // 25-40
        PlayerGUID = 0;
        ManaBurnTimer = 5000 + (rand()%3 * 1000); // 5-8 sec cd
    }

    void Aggro(Unit *who)
    {
        PlayerGUID = who->GetGUID();
    }

	void SpellHit(Unit *caster, const SpellEntry *spell)
	{
		DoCast(m_creature, SPELL_DE_MATERIALIZE);
	}

    void UpdateAI(const uint32 diff)
    {

		if(!Materialize)
		{
			DoCast(m_creature, SPELL_MATERIALIZE);
			Materialize = true;
		}

        Player* target = NULL;
        target = ((Player*)Unit::GetUnit((*m_creature), PlayerGUID));
        
        if(!target)
            return;

        if(m_creature->HasAuraType(SPELL_AURA_MOD_DECREASE_SPEED) || m_creature->hasUnitState(UNIT_STAT_ROOT)) // if the mob is rooted/slowed by spells eg.: Entangling Roots, Frost Nova, Hamstring, Crippling Poison, etc. => remove it
            DoCast(m_creature, SPELL_PHASE_SLIP);
        if(ManaBurnTimer < diff) // cast Mana Burn
        {
            if(target->GetCreateMana() > 0)
            {
                DoCast(target, SPELL_MANA_BURN);
                ManaBurnTimer = 8000 + (rand()%10 * 1000); // 8-18 sec cd
            }
        }else ManaBurnTimer -= diff;

        if(!Weak && m_creature->GetHealth() < (m_creature->GetMaxHealth() / 100 * WeakPercent) && target->GetQuestStatus(10190) == QUEST_STATUS_INCOMPLETE) // start: support for quest 10190
        {
            DoTextEmote(EMOTE_WEAK, 0);
            Weak = true;
        }
        if(Weak && m_creature->HasAura(34219, 0))
        {
            Health = m_creature->GetHealth(); // get the normal mob's data
            Level = m_creature->getLevel();

            m_creature->AttackStop(); // delete the normal mob
            m_creature->DealDamage(m_creature, m_creature->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            m_creature->RemoveCorpse();
            
            Creature* DrainedPhaseHunter = NULL;
            
            if(!DrainedPhaseHunter)
                DrainedPhaseHunter = m_creature->SummonCreature(SUMMONED_MOB, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), m_creature->GetOrientation(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000); // summon the mob
            
            if(DrainedPhaseHunter)
            {
                DrainedPhaseHunter->SetLevel(Level); // set the summoned mob's data
                DrainedPhaseHunter->SetHealth(Health);
                DrainedPhaseHunter->AI()->AttackStart(target);
            }
        } // end: support for quest 10190

		DoMeleeAttackIfReady();
    }

};

CreatureAI* GetAI_mob_phase_hunter(Creature *_Creature)
{
    return new mob_phase_hunterAI (_Creature);
}

/*######
##
######*/

void AddSC_netherstorm()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="go_manaforge_control_console";
    newscript->pGOHello = &GOHello_go_manaforge_control_console;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_manaforge_control_console";
    newscript->GetAI = GetAI_npc_manaforge_control_console;
    newscript->RegisterSelf();

	newscript = new Script;
	newscript->Name = "npc_commander_dawnforge";
	newscript->GetAI = GetAI_npc_commander_dawnforge;
	newscript->RegisterSelf();
	 	 
	newscript = new Script;
	newscript->Name = "at_commander_dawnforge";
	newscript->pAreaTrigger = &AreaTrigger_at_commander_dawnforge;
	newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_protectorate_nether_drake";
    newscript->pGossipHello =   &GossipHello_npc_protectorate_nether_drake;
    newscript->pGossipSelect =  &GossipSelect_npc_protectorate_nether_drake;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_veronia";
    newscript->pGossipHello =   &GossipHello_npc_veronia;
    newscript->pGossipSelect =  &GossipSelect_npc_veronia;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_phase_hunter";
    newscript->GetAI = GetAI_mob_phase_hunter;
    newscript->RegisterSelf();
}
