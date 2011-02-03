/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDAuthor: PrinceCreed
SD%Complete: 100%
SDComment: //
SDCategory: Custom
EndScriptData */

#include "ScriptPCH.h"

/*######
## npc_lotto
######*/

#define GOSSIP_BUY_TICKET           "Compra un biglietto"
#define TICKET_COST                 500000
#define EVENT_LOTTO                 132
#define MAX_TICKET                  5

class npc_lotto : public CreatureScript
{
public:
    npc_lotto() : CreatureScript("npc_lotto") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pPlayer && !pPlayer->isGameMaster())
        {
            QueryResult result = ExtraDatabase.PQuery("SELECT COUNT(*) FROM lotto_tickets where guid=%u", pPlayer->GetGUIDLow());
            if (result)
            {
                Field *fields = result->Fetch();
                if (fields[0].GetInt32() >= MAX_TICKET)
                {
                    pPlayer->SEND_GOSSIP_MENU(1200006, pCreature->GetGUID());
                    return true;
                }
                pPlayer->PrepareGossipMenu(pCreature);
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_BUY_TICKET, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                pPlayer->SEND_GOSSIP_MENU(1200005, pCreature->GetGUID());
            }
        }
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        
        if (!pPlayer->HasEnoughMoney(TICKET_COST))
            return false;
        
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF:
                pPlayer->ModifyMoney(-TICKET_COST);
                QueryResult result = ExtraDatabase.Query("SELECT MAX(id) FROM lotto_tickets");
                uint32 id = result->Fetch()->GetUInt32();
                ExtraDatabase.PExecute("INSERT INTO lotto_tickets (id,name,guid) VALUES (%u,'%s',%u);", id+1, pPlayer->GetName(), pPlayer->GetGUIDLow());
                char msg[500];
                sprintf(msg, "Buona fortuna, $N. Il tuo biglietto e' il numero %i", id+1);
                pCreature->MonsterWhisper(msg, pPlayer->GetGUID());
                break;
        }
        pPlayer->PlayerTalkClass->CloseGossip();
        return true;
    }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_lottoAI (pCreature);
    }

    struct npc_lottoAI : public ScriptedAI
    {
        npc_lottoAI(Creature* pCreature) : ScriptedAI(pCreature) 
        {
            SayTimer = 1800*IN_MILLISECONDS;
        }
        
        uint32 SayTimer;

        void UpdateAI(const uint32 diff)
        {
            if (IsEventActive(EVENT_LOTTO))
            {
                if (me->IsVisible())
                {
                    me->SetVisible(false);
                    QueryResult result = ExtraDatabase.Query("SELECT MAX(id) FROM lotto_tickets");
                    uint32 maxTickets = result->Fetch()->GetUInt32();
                    if (maxTickets)
                    {
                        uint32 winner = urand(1, maxTickets);
                        uint32 reward = TICKET_COST / 2.0f * maxTickets;
                        result = ExtraDatabase.PQuery("SELECT guid FROM lotto_tickets WHERE id=%u;", winner);
                        uint32 winnerGuid = result->Fetch()->GetUInt32();
                        Player *pWinner = sObjectMgr->GetPlayerByLowGUID(winnerGuid);
                        SQLTransaction trans = CharacterDatabase.BeginTransaction();
                        MailDraft("Premio Lotteria", "Complimenti! Hai vinto!")
                            .AddMoney(reward)
                            .SendMailTo(trans, MailReceiver(pWinner, GUID_LOPART(winnerGuid)), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM));
                        CharacterDatabase.CommitTransaction(trans);
                        
                        if (pWinner) 
                        {
                            char msg[500];
                            sprintf(msg, "E' stato estratto il biglietto numero %i , e il vincitore e' %s ! Premio: %i ori! Prossima estrazione domani alla stessa ora!", winner, pWinner->GetName(), reward/10000);
                            sWorld->SendWorldText(LANG_EVENTMESSAGE, msg);
                        }
                        else 
                        {
                            char msg[500];
                            sprintf(msg, "E' stato estratto il biglietto numero %i per un ammontare di %i ori! Prossima estrazione domani!", winner, reward/10000);
                            sWorld->SendWorldText(LANG_EVENTMESSAGE, msg);
                        }

                        ExtraDatabase.PExecute("INSERT INTO lotto_extractions (winner,guid) SELECT name,guid FROM lotto_tickets WHERE id=%u;", winner);
                        ExtraDatabase.PExecute("DELETE FROM lotto_tickets;");
                    }
                }
            }
            else
            {
                if (!me->IsVisible())
                    me->SetVisible(true);
                    
                if (SayTimer <= diff)
                {
                    me->MonsterSay("Biglietti della Lotteria! Bastano 50 ori per diventare milionari!", 0, NULL);
                    SayTimer = 1800*IN_MILLISECONDS;
                }
                else SayTimer -= diff;
            }
        }
    };

};


void AddSC_npc_lottery()
{
    new npc_lotto;
}

