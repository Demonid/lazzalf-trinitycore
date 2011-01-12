#include "ScriptPCH.h"

struct SkillSpell
{
    uint32 skill, spell;
};

static SkillSpell SkillSpells[] =
{
    {393, 8613}, // Skinning
    {165, 2108}, // Leatherworking
    {164, 2018}, // Blacksmithing
    {197, 3908}, // Tailoring
    {333, 7411}, // Enchanting
    {186, 2575}, // Mining
    {202, 4036}, // Engineering
    {171, 2259}, // Alchemy
    {182, 2366}, // Herbalism
    {755, 25229}, // Jewelcrafting
    {773, 45357}, // Inscription
    {129, 3273}, // First Aid
    {185, 2550}, // Cooking
    {356, 7620}, // Fishing
    {95, 204}, // Defense
    {0, 0}
};

struct Elem
{
    uint32 item[20];
};

static Elem EquipVct[] = 
{
    {0},
    {1,2,3,0}, // Warrior Fury
    {4,8,2,4,0}, // Warrior Arms
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
        QueryResult result = ExtraDatabase.PQuery("SELECT `fase` FROM `porting` WHERE `guid` = %u AND `active` = 1", pPlayer->GetGUIDLow());

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

                                        uint32 max = uint32(fields[i+8].GetUInt32() / 75) * 75 ? uint32(fields[i+8].GetUInt32() / 75) * 75 : pPlayer->GetPureMaxSkillValue(SkillSpells[j].skill);

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
                        ExtraDatabase.PQuery("UPDATE `porting` SET `fase` = 1 WHERE `guid` = %u", pPlayer->GetGUIDLow());
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
                    std::string msg = "Porting concluso!";
                    pCreature->MonsterWhisper(msg.c_str(), pPlayer->GetGUID());
                    ExtraDatabase.PQuery("UPDATE `porting` SET `fase` = 2, `active` = 0 WHERE `guid` = %u", pPlayer->GetGUIDLow());                
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