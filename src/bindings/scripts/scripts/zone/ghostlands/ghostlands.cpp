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
SDName: Ghostlands
SD%Complete: 100
SDComment: Quest support: 9692, 9212. Obtain Budd's Guise of Zul'aman. Vendor Rathis Tomber
SDCategory: Ghostlands
EndScriptData */

/* ContentData
npc_blood_knight_dawnstar
npc_budd_nedreck
npc_rathis_tomber
npc_ranger_lilatha
EndContentData */

#include "precompiled.h"
#include "../../npc/npc_escortAI.h"

/*######
## npc_blood_knight_dawnstar
######*/

bool GossipHello_npc_blood_knight_dawnstar(Player *player, Creature *_Creature)
{
    if (player->GetQuestStatus(9692) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(24226,1,true))
        player->ADD_GOSSIP_ITEM( 0, "Take Blood Knight Insignia", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_blood_knight_dawnstar(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    if (action == GOSSIP_ACTION_INFO_DEF+1)
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem( NULL_BAG, NULL_SLOT, dest, 24226, 1, false);
        if( msg == EQUIP_ERR_OK )
        {
            player->StoreNewItem( dest, 24226, 1, true);
            player->PlayerTalkClass->ClearMenus();
        }
    }
    return true;
}

/*######
## npc_budd_nedreck
######*/

bool GossipHello_npc_budd_nedreck(Player *player, Creature *_Creature)
{
    if( _Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if( player->GetQuestStatus(11166) == QUEST_STATUS_INCOMPLETE)
        player->ADD_GOSSIP_ITEM(0,"You gave the crew disguises?",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(),_Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_budd_nedreck(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action==GOSSIP_ACTION_INFO_DEF )
    {
        player->CLOSE_GOSSIP_MENU();
        _Creature->CastSpell(player, 42540, false);
    }
    return true;
}

/*######
## npc_rathis_tomber
######*/

bool GossipHello_npc_rathis_tomber(Player *player, Creature *_Creature)
{
    if( _Creature->isQuestGiver() )
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if( _Creature->isVendor() && player->GetQuestRewardStatus(9152) )
    {
        player->ADD_GOSSIP_ITEM(1, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
        player->SEND_GOSSIP_MENU(8432,_Creature->GetGUID());
    }else
    player->SEND_GOSSIP_MENU(8431,_Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_rathis_tomber(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_ACTION_TRADE )
        player->SEND_VENDORLIST( _Creature->GetGUID() );
    return true;
}

/*#####
## go_gilded_brazier (Paladin First Trail quest (9678))
#####*/

bool GOHello_gilded_brazier(Player *player, GameObject* _GO)
{
    if (player->GetQuestStatus(9678) == QUEST_STATUS_INCOMPLETE)
    {
        Creature *Stillblade = player->SummonCreature(17716, 8106.11, -7542.06, 151.775, 3.02598, TEMPSUMMON_DEAD_DESPAWN, 60000);
        if (Stillblade)
            ((CreatureAI*)Stillblade->AI())->AttackStart(player);
    }
    return true;
};

/*######
## npc_ranger_lilatha
######*/
 
#define SAY_START                                                       "Let's go."
#define SAY_PROGRESS1                                           "$N, let's use the antechamber to the right."
#define SAY_PROGRESS2                                           "I can see the light at the end of the tunnel!"
#define SAY_PROGRESS3                                           "There's Farstrider Enclave now, $C. Not far to go... Look out! Troll ambush!!"
#define SAY_END1                                                        "Thank you for saving my life and bringing me back to safety, $N"
#define SAY_END2                                                        "Captain Helios, I've been rescued from the Amani Catacombs. Reporting for duty, sir!"
#define CAPTAIN_ANSWER                                          "Liatha, get someone to look at those injuries. Thank you for bringing her back safely."
 
#define QUEST_ESCAPE_FROM_THE_CATACOMBS         9212
#define GO_CAGE                                                         181152
#define NPC_CAPTAIN_HELIOS                                      16220

struct TRINITY_DLL_DECL npc_ranger_lilathaAI : public npc_escortAI
{
	npc_ranger_lilathaAI(Creature *c) : npc_escortAI(c) {Reset();}

	std::list<GameObject*> CageList;
 
	void WaypointReached(uint32 i)
	{
		Unit* player = Unit::GetUnit((*m_creature), PlayerGUID);

		if (!player)
            return;

        switch(i)
		{
		case 0:			
			{
			m_creature->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
			setCage(true);
			DoSay(SAY_START, LANG_UNIVERSAL, player);
			break;
			}
		case 5:
			DoSay(SAY_PROGRESS1, LANG_UNIVERSAL, player); break;
		case 11:			
			DoSay(SAY_PROGRESS2, LANG_UNIVERSAL, player); 
			m_creature->SetOrientation(4.762841);
			break;			
		case 18:
			{
			DoSay(SAY_PROGRESS3, LANG_UNIVERSAL, player);
			Creature* Summ1 = m_creature->SummonCreature(16342, 7627.083984, -7532.538086, 152.128616, 1.082733, TEMPSUMMON_DEAD_DESPAWN, 0);
			Creature* Summ2 = m_creature->SummonCreature(16343, 7620.432129, -7532.550293, 152.454865, 0.827478, TEMPSUMMON_DEAD_DESPAWN, 0);
			Summ1->Attack(m_creature, true);
			Summ2->Attack(player, true);
			m_creature->AI()->AttackStart(Summ1);
			break;			
			}
		case 19:
			m_creature->SetSpeed(MOVE_RUN, 1.5f); break;
		case 25:
			m_creature->SetSpeed(MOVE_WALK, 1.0f); break;
		case 30:
			if (player && player->GetTypeId() == TYPEID_PLAYER)
				((Player*)player)->GroupEventHappens(QUEST_ESCAPE_FROM_THE_CATACOMBS,m_creature);                
			break;
		case 32:			
			m_creature->SetOrientation(2.978281);
			DoSay(SAY_END1, LANG_UNIVERSAL, player);
			break;                                
		case 33:
			m_creature->SetOrientation(5.858011);
			DoSay(SAY_END2, LANG_UNIVERSAL, player);
			captainAnswer();
			break;                        
		}
	}
 
    void Aggro(Unit* who) {}
 
	void Reset()
	{
		if (!IsBeingEscorted)
			m_creature->setFaction(1602);
		setCage(false);
	}
 
	void JustDied(Unit* killer)
	{
		if (PlayerGUID)
		{
			Unit* player = Unit::GetUnit((*m_creature), PlayerGUID);
			if (player)
				((Player*)player)->FailQuest(QUEST_ESCAPE_FROM_THE_CATACOMBS);
		}
	}
 
	void UpdateAI(const uint32 diff)
    {
        npc_escortAI::UpdateAI(diff);
    }
 
	void setCage(bool open)
	{
		CellPair pair(Trinity::ComputeCellPair(m_creature->GetPositionX(), m_creature->GetPositionY()));
		Cell cell(pair);
		cell.data.Part.reserved = ALL_DISTRICT;
		cell.SetNoCreate();
 
		Trinity::AllGameObjectsWithEntryInGrid go_check(GO_CAGE);
		Trinity::GameObjectListSearcher<Trinity::AllGameObjectsWithEntryInGrid> go_search(CageList, go_check);
		TypeContainerVisitor
			<Trinity::GameObjectListSearcher<Trinity::AllGameObjectsWithEntryInGrid>, GridTypeMapContainer> go_visit(go_search);
		CellLock<GridReadGuard> cell_lock(cell, pair);
		cell_lock->Visit(cell_lock, go_visit, *(m_creature->GetMap()));
 
		if (!CageList.empty())
		{
			for(std::list<GameObject*>::iterator itr = CageList.begin(); itr != CageList.end(); ++itr)
			{
				if( open )
					(*itr)->SetGoState(0);
				else
					(*itr)->SetGoState(1);
			}
		} else error_log("SD2 ERROR: CageList is empty!");
	}
 
	void captainAnswer()
	{
		CellPair pair(Trinity::ComputeCellPair(m_creature->GetPositionX(), m_creature->GetPositionY()));
		Cell cell(pair);
		cell.data.Part.reserved = ALL_DISTRICT;
		cell.SetNoCreate();
 
		std::list<Creature*> NPCList;

		Trinity::AllCreaturesOfEntryInRange check(m_creature, NPC_CAPTAIN_HELIOS, 100);
		Trinity::CreatureListSearcher<Trinity::AllCreaturesOfEntryInRange> searcher(NPCList, check);
		TypeContainerVisitor<Trinity::CreatureListSearcher<Trinity::AllCreaturesOfEntryInRange>, GridTypeMapContainer> visitor(searcher);
 
		CellLock<GridReadGuard> cell_lock(cell, pair);
		cell_lock->Visit(cell_lock, visitor, *(m_creature->GetMap()));
 
		if (!NPCList.empty())
		{
			for(std::list<Creature*>::iterator itr = NPCList.begin(); itr != NPCList.end(); ++itr)
			{
				(*itr)->Say(CAPTAIN_ANSWER, LANG_UNIVERSAL, PlayerGUID);
			}
		}else error_log("SD2 ERROR: Captain Helios not found!");
	}
};
 
bool QuestAccept_npc_ranger_lilatha(Player* player, Creature* creature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_ESCAPE_FROM_THE_CATACOMBS)
    {
        creature->setFaction(1603);
        ((npc_escortAI*)(creature->AI()))->Start(true, true, false, player->GetGUID());
    }
    return true;
}
 
CreatureAI* GetAI_npc_ranger_lilathaAI(Creature *_Creature)
{
    npc_ranger_lilathaAI* ranger_lilathaAI = new npc_ranger_lilathaAI(_Creature);
 
	ranger_lilathaAI->AddWaypoint(0, 7545.07, -7359.87, 162.354, 4000); // Say0
	ranger_lilathaAI->AddWaypoint(1, 7550.048340, -7362.237793, 162.235657);
	ranger_lilathaAI->AddWaypoint(2, 7566.976074, -7364.315430, 161.738770);
	ranger_lilathaAI->AddWaypoint(3, 7578.830566, -7361.677734, 161.738770);
	ranger_lilathaAI->AddWaypoint(4, 7590.969238, -7359.053711, 162.257660);
	ranger_lilathaAI->AddWaypoint(5, 7598.354004, -7362.815430, 162.256683, 4000); // Say1
	ranger_lilathaAI->AddWaypoint(6, 7605.861328, -7380.424316, 161.937073);
	ranger_lilathaAI->AddWaypoint(7, 7605.295410, -7387.382813, 157.253998);
	ranger_lilathaAI->AddWaypoint(8, 7606.131836, -7393.893555, 156.941925);
	ranger_lilathaAI->AddWaypoint(9, 7615.207520, -7400.187012, 157.142639);
	ranger_lilathaAI->AddWaypoint(10, 7618.956543, -7402.652832, 158.202042);
	ranger_lilathaAI->AddWaypoint(11, 7636.850586, -7401.756836, 162.144791);
	ranger_lilathaAI->AddWaypoint(12, 7637.058105, -7404.944824, 162.206970, 4000);// Say2
	ranger_lilathaAI->AddWaypoint(13, 7636.910645, -7412.585449, 162.366425);
	ranger_lilathaAI->AddWaypoint(14, 7637.607910, -7425.591797, 162.630661);
	ranger_lilathaAI->AddWaypoint(15, 7637.816895, -7459.057129, 163.302704);
	ranger_lilathaAI->AddWaypoint(16, 7638.859863, -7470.902344, 162.517059);
	ranger_lilathaAI->AddWaypoint(17, 7641.395996, -7488.217285, 157.381287);
	ranger_lilathaAI->AddWaypoint(18, 7634.455566, -7505.451660, 154.682159);
	ranger_lilathaAI->AddWaypoint(19, 7631.906738, -7516.948730, 153.597382); // say3
	ranger_lilathaAI->AddWaypoint(20, 7622.231445, -7537.037598, 151.587112);
	ranger_lilathaAI->AddWaypoint(21, 7610.921875, -7550.670410, 149.639374);
	ranger_lilathaAI->AddWaypoint(22, 7598.229004, -7562.551758, 145.953888);
	ranger_lilathaAI->AddWaypoint(23, 7588.509277, -7577.755371, 148.294479);
	ranger_lilathaAI->AddWaypoint(24, 7567.339355, -7608.456055, 146.006485);
	ranger_lilathaAI->AddWaypoint(25, 7562.547852, -7617.417969, 148.097504);
	ranger_lilathaAI->AddWaypoint(26, 7561.508789, -7645.064453, 151.245163);
	ranger_lilathaAI->AddWaypoint(27, 7563.337402, -7654.652344, 151.227158);
	ranger_lilathaAI->AddWaypoint(28, 7565.533691, -7658.296387, 151.248886);
	ranger_lilathaAI->AddWaypoint(29, 7571.155762, -7659.118652, 151.244568);
	ranger_lilathaAI->AddWaypoint(30, 7579.119629, -7662.213867, 151.651505);
	ranger_lilathaAI->AddWaypoint(31, 7603.768066, -7667.000488, 153.997726);
	ranger_lilathaAI->AddWaypoint(32, 7603.768066, -7667.000488, 153.997726, 4000);  // Say4 & Set orientation
	ranger_lilathaAI->AddWaypoint(33, 7603.768066, -7667.000488, 153.997726, 8000);  // Say5 & Set orientation
	ranger_lilathaAI->AddWaypoint(34, 7603.768066, -7667.000488, 153.997726); 
 
	return (CreatureAI*)ranger_lilathaAI;
}
 
void AddSC_ghostlands()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_blood_knight_dawnstar";
    newscript->pGossipHello = &GossipHello_npc_blood_knight_dawnstar;
    newscript->pGossipSelect = &GossipSelect_npc_blood_knight_dawnstar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_budd_nedreck";
    newscript->pGossipHello = &GossipHello_npc_budd_nedreck;
    newscript->pGossipSelect = &GossipSelect_npc_budd_nedreck;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_rathis_tomber";
    newscript->pGossipHello = &GossipHello_npc_rathis_tomber;
    newscript->pGossipSelect = &GossipSelect_npc_rathis_tomber;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "go_gilded_brazier";
    newscript->pGOHello = &GOHello_gilded_brazier;
    newscript->RegisterSelf();

	newscript = new Script;
	newscript->Name = "npc_ranger_lilatha";
	newscript->GetAI = &GetAI_npc_ranger_lilathaAI;
	newscript->pQuestAccept = &QuestAccept_npc_ranger_lilatha;
	newscript->RegisterSelf();
}
