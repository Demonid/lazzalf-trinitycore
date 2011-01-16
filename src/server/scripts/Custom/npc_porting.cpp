#include "ScriptPCH.h"
#include "TicketMgr.h"
#include "ObjectMgr.h"

struct SkillSpell
{
    uint32 skill, spell, maxskill;
};

static SkillSpell SkillSpells[] =
{
    {393, 8613, 450}, // Skinning
    {165, 2108, 450}, // Leatherworking
    {164, 2018, 450}, // Blacksmithing
    {197, 3908, 450}, // Tailoring
    {333, 7411, 450}, // Enchanting
    {186, 2575, 450}, // Mining
    {202, 4036, 450}, // Engineering
    {171, 2259, 450}, // Alchemy
    {182, 2366, 450}, // Herbalism
    {755, 25229, 450}, // Jewelcrafting
    {773, 45357, 450}, // Inscription
    {129, 3273, 450}, // First Aid
    {185, 2550, 450}, // Cooking
    {356, 7620, 450}, // Fishing
    {95, 204, 400}, // Defense
    {136, 227, 400}, // Staves
    {173, 1180, 400}, // Daggers
    {44, 196, 400}, // Axes
    {43, 201, 400}, // Swords
    {54, 198, 400}, // Maces
    {162, 203, 400}, // Unarmed
    {160, 199, 400}, // Two-Handed Maces
    {55, 202, 400}, // Two-Handed Swords
    {172, 197, 400}, // Two-Handed Axes
    {228, 5009, 400}, // Wands
    {473, 15590, 400}, // Fist Weapons
    {45, 264, 400}, // Bows
    {229, 200, 400}, // Polearms
    {46, 266, 400}, // Guns
    {176, 2567, 400}, // Thrown
    {226, 5011, 400}, // Crossbows
    {633, 1809, 400}, // Lockpicking
    {762, 33388, 300}, // Riding
    {0, 0}
};

struct Elem
{
    uint32 item[20];
};

static Elem EquipVct[] = 
{
    {0},
    {1,2,3,0}, // 1 Warrior PvE Fury
    {4,8,2,4,0}, // 2 Warrior PvE Arms
    {0}
};

#define MSG_GOSSIP_PORTING_1     "Attiva Porting Fase 1"
#define MSG_GOSSIP_CLOSE         "Chiudi"
#define MSG_GOSSIP_PORTING_2     "Attiva Porting Fase 2"

#define ITEM_BAG 21843
#define ITEM_TITANIUM_ROD 44452
#define ITEM_TOME_COLD_WEATHER_FLY 49177

class npc_porting : public CreatureScript
{
    public:
        npc_porting() : CreatureScript("npc_porting") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        QueryResult result = ExtraDatabase.PQuery("SELECT `fase` FROM `porting` WHERE `guid` = %u AND `active` <> 0", pPlayer->GetGUIDLow());

        if (result)
        {
            Field *fields = result->Fetch();
            if (fields[0].GetUInt32() == 0)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, MSG_GOSSIP_PORTING_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            else if (fields[0].GetUInt32() == 1)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, MSG_GOSSIP_PORTING_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
       }

        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, MSG_GOSSIP_CLOSE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);


        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();

        if (uiSender != GOSSIP_SENDER_MAIN)
            return true;

        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1: // Close
                pPlayer->CLOSE_GOSSIP_MENU();
                break;
            case GOSSIP_ACTION_INFO_DEF+2: // Bags
                {
                    pPlayer->AddItem(ITEM_BAG, 4);
                    QueryResult result = ExtraDatabase.PQuery("SELECT livel, gold, repu_1, repu_2, repu_3, level_repu_1, level_repu_2, level_repu_3, skill_1, skill_2, skill_3, skill_4, skill_5, skill_6, skill_7, skill_8, level_skill_1, level_skill_2, level_skill_3, level_skill_4 , level_skill_5, level_skill_6, level_skill_7, level_skill_8 FROM `porting` WHERE `guid` = %u", pPlayer->GetGUIDLow());               
                    if (result)
                    {
                        Field *fields = result->Fetch();
                        // Livello
                        pPlayer->GiveLevel(fields[0].GetUInt8());
                        // Monete
                        pPlayer->ModifyMoney(fields[1].GetUInt32() * 1000);
                        // Reputazioni
                        for (int i = 2; i < 5; i++)
                            if (fields[i].GetUInt32())
                            {
                                FactionEntry const *factionEntry = sFactionStore.LookupEntry(fields[i].GetUInt32());

                                if (!factionEntry)
                                    continue;

                                if (factionEntry->reputationListID < 0)
                                    continue;

                                pPlayer->GetReputationMgr().SetOneFactionReputation(factionEntry, fields[i+3].GetUInt32());
                            }
                        // Skills
                        for (int i = 8; i < 16; i++)
                            if (fields[i].GetUInt32())
                            {
                                SkillLineEntry const *skillInfo = sSkillLineStore.LookupEntry(i);
                                if (!skillInfo)
                                    continue;

                                for (int j = 0; SkillSpells[j].skill != 0; j++)
                                {
                                    if (SkillSpells[j].skill == fields[i].GetUInt32())
                                    {
                                        if (SkillSpells[j].spell)
                                            pPlayer->CastSpell(pPlayer, SkillSpells[j].spell, true);

                                        if (!pPlayer->GetSkillValue(SkillSpells[j].skill))
                                            continue; 

                                        uint32 maxskill = 0;

                                        if (SkillSpells[j].maxskill == 450 || SkillSpells[j].maxskill == 300)
                                            maxskill = (uint32(fields[i+8].GetUInt32() / 75) + (fields[i+8].GetUInt32()%75 ? 1 : 0)) * 75 >= SkillSpells[j].maxskill ? SkillSpells[j].maxskill : (uint32(fields[i+8].GetUInt32() / 75) + (fields[i+8].GetUInt32()%75 ? 1 : 0)) * 75;
                                        else if (SkillSpells[j].maxskill == 400)
                                            maxskill = pPlayer->getLevel() * 5;

                                        uint32 max =  maxskill ? maxskill : pPlayer->GetPureMaxSkillValue(SkillSpells[j].skill);

                                        if (fields[i+8].GetUInt32() <= 0 || fields[i+8].GetUInt32() > max || max <= 0)
                                            continue;

                                        pPlayer->SetSkill(SkillSpells[j].skill, pPlayer->GetSkillStep(SkillSpells[j].skill), fields[i+8].GetUInt32(), max);
                                        
                                        if (SkillSpells[j].skill == 333) // Enchanting
                                            pPlayer->AddItem(ITEM_TITANIUM_ROD, 1);

                                        if (SkillSpells[j].skill == 762 && fields[i+8].GetUInt32() == 300) // Riding
                                            pPlayer->AddItem(ITEM_TOME_COLD_WEATHER_FLY, 1);
                                    }
                                }
                            }
                        std::string msg = "Equipaggia le 4 bags e poi continua il porting";
                        pCreature->MonsterWhisper(msg.c_str(), pPlayer->GetGUID());
                        ExtraDatabase.PExecute("UPDATE `porting` SET `fase` = 1 WHERE `guid` = %u", pPlayer->GetGUIDLow());
                    }
                    pPlayer->CLOSE_GOSSIP_MENU();
                }
                break;
            case GOSSIP_ACTION_INFO_DEF+3: // Bags
                {
                    QueryResult result = ExtraDatabase.PQuery("SELECT id_equip_1, id_equip_2, id_equip_3 FROM `porting` WHERE `guid` = %u", pPlayer->GetGUIDLow());               
                    if (result)
                    {
                        Field *fields = result->Fetch();
                        for (int j = 0; j < 3; j++)
                            if (EquipVct[fields[j].GetUInt32()].item[0])
                                for (int i = 1; EquipVct[fields[j].GetUInt32()].item[i] != 0; i++)
                                {
                                    pPlayer->AddItem(EquipVct[fields[j].GetUInt32()].item[i], 1);
                                }

                    }

                    result = ExtraDatabase.PQuery("SELECT `active` FROM `porting` WHERE `guid` = %u", pPlayer->GetGUIDLow());
                    if (result)
                    {
                        Field *fields = result->Fetch();
                        if (fields[0].GetUInt32() == 1)
                        {
                            GM_Ticket *ticket = sTicketMgr->GetGMTicketByPlayer(pPlayer->GetGUID());
                            if (ticket && ticket->closed == 0 && !ticket->completed)
                            {
                                sTicketMgr->RemoveGMTicket(ticket, pPlayer->GetGUID());

                                // send abandon ticket
                                WorldPacket deleteTicket(SMSG_GMTICKET_DELETETICKET, 4);
                                deleteTicket << uint32(GMTICKET_RESPONSE_TICKET_DELETED);
                                pPlayer->GetSession()->SendPacket(&deleteTicket);

                                sTicketMgr->UpdateLastChange();
                            }

                            std::string msg = "Porting concluso! Il Ticket è stato chiuso!";
                            pCreature->MonsterWhisper(msg.c_str(), pPlayer->GetGUID());
                        }
                        else if (fields[0].GetUInt32() == 2)
                        {
                            GM_Ticket *ticket = sTicketMgr->GetGMTicketByPlayer(pPlayer->GetGUID());
                            if (ticket && ticket->closed == 0 && !ticket->completed)
                            {
                                std::string ticketText = "Test";
                                ticket->message = ticketText;
                                sTicketMgr->AddOrUpdateGMTicket(*ticket, true);
                                std::string msg = "Porting completato in parte! Ticket editato in automatico per completare il porting con un GM!";
                                pCreature->MonsterWhisper(msg.c_str(), pPlayer->GetGUID());
                            }
                            else
                            {                            
                                std::string msg = "Porting completato in parte! Edita eventualmente il ticket (per non perdere priorità) o apri ticket per completare il porting con un GM!";
                                pCreature->MonsterWhisper(msg.c_str(), pPlayer->GetGUID());
                            }
                        }
                        ExtraDatabase.PExecute("UPDATE `porting` SET `fase` = 2, `active` = 0 WHERE `guid` = %u", pPlayer->GetGUIDLow());                
                    }
                    pPlayer->CLOSE_GOSSIP_MENU();
                }
                break;
        }
        return true;
    }
};

void AddSC_npc_porting()
{
    new npc_porting();
}