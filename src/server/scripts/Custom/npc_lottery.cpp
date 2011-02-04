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

float mol_win[3] = {0.5f, 0.2f, 0.1f};

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
            SayTimer = 600*IN_MILLISECONDS;
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
                    uint32 maxTickets = 0;
                    if (result)
                    {
                        maxTickets = result->Fetch()->GetUInt32();
                        if (!maxTickets)
                            return;
                    }

                    result = ExtraDatabase.Query("SELECT name, guid, id FROM `lotto_tickets` ORDER BY RAND() LIMIT 3;");
                    uint32 position = 0;

                    if (!result)
                        return;

                    do
                    {
                        ++position;

                        Field *fields = result->Fetch();

                        const char* name = fields[0].GetCString();
                        uint32 guid = fields[1].GetUInt32();
                        uint32 ticket = fields[2].GetUInt32();
                        // uint32 reward = TICKET_COST / (1 << position) * maxTickets;
                        uint32 reward = TICKET_COST * mol_win[position-1] * maxTickets;

                        ExtraDatabase.PExecute("INSERT INTO `lotto_extractions` (winner,guid,position,reward) VALUES ('%s',%u,%u,%u);",name,guid,position,reward);

                        // Send reward by mail
                        Player *pPlayer = sObjectMgr->GetPlayerByLowGUID(guid);
                        SQLTransaction trans = CharacterDatabase.BeginTransaction();
                        MailDraft("Premio Lotteria", "Complimenti! Hai vinto alla Lotteria!")
                            .AddMoney(reward)
                            .SendMailTo(trans, MailReceiver(pPlayer, GUID_LOPART(guid)), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM));
                        CharacterDatabase.CommitTransaction(trans);

                        // Event Message
                        char msg[500];
                        switch (position)
                        {
                            case 1:
                                sprintf(msg, "Il vincitore della Lotteria e' %s che guadagna la bellezza di %i gold con il biglietto %i!", name, reward/10000, ticket);
                                break;
                            case 2:
                                sprintf(msg, "Il secondo premio va a %s che vince %i gold con il biglietto %i!", name, reward/10000, ticket);
                                break;
                            case 3:
                                sprintf(msg, "Mentre il terzo se lo aggiudica %s che vince %i gold con il biglietto %i!", name, reward/10000, ticket);
                                break;
                        }
                        sWorld->SendWorldText(LANG_EVENTMESSAGE, msg);
                    }
                    while (result->NextRow());

                    // Delete tickets after extraction
                    ExtraDatabase.PExecute("DELETE FROM lotto_tickets;");
                }
            }
            else
            {
                if (!me->IsVisible())
                    me->SetVisible(true);
                    
                if (SayTimer <= diff)
                {
                    me->MonsterYell("Biglietti della Lotteria! Bastano 50 ori per diventare milionari!", 0, NULL);
                    QueryResult result = ExtraDatabase.Query("SELECT MAX(id) FROM lotto_tickets");
                    if (result)
                    {
                        uint32 maxTickets = result->Fetch()->GetUInt32();
                        char msg[500];
                        sprintf(msg, "Il Primo premio ammonta a %u ori!", uint32(TICKET_COST / 10000 * mol_win[0] * maxTickets));
                        if (uint32(TICKET_COST / 10000 * mol_win[0] * maxTickets) > 3000)
                            me->MonsterYell(msg, 0, NULL);
                    }
                    SayTimer = 600 * IN_MILLISECONDS;
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

