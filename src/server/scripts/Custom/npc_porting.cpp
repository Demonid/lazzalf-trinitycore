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
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39417,39419,0}, // 1 Warrior PvE Fury/Arms 2H AXE + GUN
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39245,39419,0}, // 2 Warrior PvE Fury/Arms 2H MACE + GUN
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39417,39296,0}, // 3 Warrior PvE Fury/Arms 2H AXE + BOW
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39245,39296,0}, // 4 Warrior PvE Fury/Arms 2H MACE + BOW
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39417,37191,0}, // 5 Warrior PvE Fury/Arms 2H AXE + CROSSBOW
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39245,37191,0}, // 6 Warrior PvE Fury/Arms 2H MACE + CROSSBOW
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39417,40716,0}, // 7 Warrior PvE Fury/Arms 2H AXE + THROWN
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39245,40716,0}, // 8 Warrior PvE Fury/Arms 2H MACE + THROWN
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39417,40706,0}, // 9 Paladin PvE Retribution 2H AXE
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39245,40706,0}, // 10 Paladin PvE Retribution 2H MACE
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39417,40715,0}, // 11 Death Knight PvE Blood/Unholy 2H AXE
    {39262,39280,39345,39139,39195,40678,39249,39401,39239,39403,39257,39277,40684,39404,39245,40715,0}, // 12 Death Knight PvE Blood/Unholy 2H MACE
    {39267,39197,39395,39234,39398,39298,39258,39141,39467,39292,39225,39246,47216,37784,40475,39344,41168,0}, // 13 Warrior PvE Protection 1H SWORD
    {39267,39197,39395,39234,39398,39298,39258,39141,39467,39292,39225,39246,47216,37784,40475,39344,40707,0}, // 14 Paladin PvE Protection 1H SWORD
    {39267,39197,39395,39234,39398,39298,39258,39141,39467,39292,39225,39246,47216,37784,39344,39344,40714,0}, // 15 Death Knight PvE Frost 1H SWORDS
    {47215,40685,39232,39415,39407,39244,39261,39188,39293,39198,39306,39235,39260,39369,39423,39233,40705,0}, // 16 Paladin PvE Holy 1H MACE
    {47215,40685,39232,39415,39407,39244,39261,39188,39293,39198,39306,39235,39260,39369,39200,39233,40705,0}, // 17 Paladin PvE Holy 1H SWORD
    {39405,39472,39274,39272,39391,39307,39243,39251,39217,39189,39389,39244,39229,37660,39423,39233,40708,0}, // 18 Shaman PvE Elemental 1H MACE
    {39405,39472,39274,39272,39391,39307,39243,39251,39217,39189,39389,39244,39229,37660,39271,39233,40708,0}, // 19 Shaman PvE Elemental DAGGER
    {40682,40685,39407,39250,39425,39274,39251,39189,39217,39307,39391,39243,39405,39232,40709,39423,39233,0}, // 20 Shaman PvE Restoration 1H MACE
    {40682,40685,39407,39250,39425,39274,39251,39189,39217,39307,39391,39243,39405,39232,40709,39271,39233,0}, // 21 Shaman PvE Restoration DAGGERS
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39416,39468,40710,0}, // 22 Shaman PvE Enanchement FIST WEAPONS
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39226,39226,40710,0}, // 23 Shaman PvE Enanchement 1H MACES
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39420,39420,40710,0}, // 24 Shaman PvE Enanchement DAGGERS
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,40497,39419,0}, // 25 Hunter PvE Survival/Marksman 2H POLEARM + GUN
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39393,39419,0}, // 26 Hunter PvE Survival/Marksman 2H SWORD + GUN
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,37883,39419,0}, // 27 Hunter PvE Survival/Marksman 2H STAFF + GUN
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,40491,40491,39419,0}, // 28 Hunter PvE Survival/Marksman 1H SWORDS + GUN
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39226,39226,39419,0}, // 29 Hunter PvE Survival/Marksman 1H MACES + GUN
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39416,39468,39419,0}, // 30 Hunter PvE Survival/Marksman FIST WEAPONS + GUN
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39420,39420,39419,0}, // 31 Hunter PvE Survival/Marksman DAGGERS + GUN
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,40497,39296,0}, // 32 Hunter PvE Survival/Marksman 2H POLEARM + BOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39393,39296,0}, // 33 Hunter PvE Survival/Marksman 2H SWORD + BOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,37883,39296,0}, // 34 Hunter PvE Survival/Marksman 2H STAFF + BOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,40491,40491,39296,0}, // 35 Hunter PvE Survival/Marksman 1H SWORDS + BOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39226,39226,39296,0}, // 36 Hunter PvE Survival/Marksman 1H MACES + BOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39416,39468,39296,0}, // 37 Hunter PvE Survival/Marksman FIST WEAPONS + BOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39420,39420,39296,0}, // 38 Hunter PvE Survival/Marksman DAGGERS + BOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,40497,37191,0}, // 39 Hunter PvE Survival/Marksman 2H POLEARM + CROSSBOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39393,37191,0}, // 40 Hunter PvE Survival/Marksman 2H SWORD + CROSSBOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,37883,37191,0}, // 41 Hunter PvE Survival/Marksman 2H STAFF + CROSSBOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,40491,40491,37191,0}, // 42 Hunter PvE Survival/Marksman 1H SWORDS + CROSSBOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39226,39226,37191,0}, // 43 Hunter PvE Survival/Marksman 1H MACES + CROSSBOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39416,39468,37191,0}, // 44 Hunter PvE Survival/Marksman FIST WEAPONS + CROSSBOW
    {39277,37642,39404,39421,39278,39294,39248,39194,39379,39397,39236,39257,40684,37669,39420,39420,37191,0}, // 45 Hunter PvE Survival/Marksman DAGGERS + CROSSBOW
    {39231,39415,39388,40685,39191,39215,39257,39283,39259,39230,39240,39308,39407,40488,40699,40711,0}, // 46 Druid PvE Restoration 1H MACE
    {39231,39415,39388,40685,39191,39215,39257,39283,39259,39230,39240,39308,39407,39271,40699,40711,0}, // 47 Druid PvE Restoration DAGGER
    {39231,39415,39388,40685,39191,39215,39257,39283,39259,39230,39240,39308,39407,40489,40711,0}, // 48 Druid PvE Restoration 2H STAFF
    {39283,39244,39241,39259,39215,39257,39308,39191,39230,39240,39229,40682,39282,39424,40698,40712,0}, // 49 Druid PvE Balance DAGGER
    {39283,39244,39241,39259,39215,39257,39308,39191,39230,39240,39229,40682,39282,40489,40712,0}, // 50 Druid PvE Balance 2H STAFF
    {39283,39244,39241,39259,39215,39257,39308,39191,39230,39240,39229,40682,39282,39424,39423,40698,40712,0}, // 51 Druid PvE Balance 1H MACE
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39422,40713,0}, // 52 Druid PvE Feral/Dps 2H STAFF
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,40497,40713,0}, // 53 Druid PvE Feral/Dps 2H POLEARM
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39420,39420,39419,0}, // 54 Rogue PvE Assassination DAGGERS + GUN
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39416,39468,39419,0}, // 55 Rogue PvE Combat FIST WEAPONS + GUN
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39226,39226,39419,0}, // 56 Rogue PvE Combat 1H MACES + GUN
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,40491,40491,39419,0}, // 57 Rogue PvE Combat 1H SWORDS + GUN
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39420,39420,39296,0}, // 58 Rogue PvE Assassination DAGGERS + BOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39416,39468,39296,0}, // 59 Rogue PvE Combat FIST WEAPONS + BOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39226,39226,39296,0}, // 60 Rogue PvE Combat 1H MACES + BOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,40491,40491,39296,0}, // 61 Rogue PvE Combat 1H SWORDS + BOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39420,39420,37191,0}, // 62 Rogue PvE Assassination DAGGERS + CROSSBOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39416,39468,37191,0}, // 63 Rogue PvE Combat FIST WEAPONS + CROSSBOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39226,39226,37191,0}, // 64 Rogue PvE Combat 1H MACES + CROSSBOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,40491,40491,37191,0}, // 65 Rogue PvE Combat 1H SWORDS + CROSSBOW
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39420,39420,40716,0}, // 66 Rogue PvE Assassination DAGGERS + THROWN
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39416,39468,40716,0}, // 67 Rogue PvE FIST WEAPONS + THROWN
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,39226,39226,40716,0}, // 68 Rogue PvE Combat FIST 1H MACES + THROWN
    {39277,39247,39257,40684,39421,39404,39386,39237,39399,39196,39299,39224,39279,40491,40491,40716,0}, // 69 Rogue PvE Combat FIST 1H SWORDS + THROWN
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,39424,40698,39426,0}, // 70 Mage PvE Fire/Frost/Arcane DAGGER
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,40489,39426,0}, // 71 Mage PvE Fire/Frost/Arcane 2H STAFF
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,39200,40698,39426,0}, // 72 Mage PvE Fire/Frost/Arcane 1H SWORD
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,39424,40698,39426,0}, // 73 Warlock PvE Affliction/Demonology/Destruction DAGGER
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,40489,39426,0}, // 74 Warlock PvE Affliction/Demonology/Destruction 2H STAFF
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,39200,40698,39426,0}, // 75 Warlock PvE Affliction/Demonology/Destruction 1H SWORD
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,39424,40698,39426,0}, // 76 Priest Shadow DAGGER
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,40489,39426,0}, // 77 Priest Shadow 2H STAFF
    {39409,39241,39396,39282,39284,39309,39252,39231,39389,39229,40682,39273,39192,39216,39423,40698,39426,0}, // 78 Priest Shadow 1H MACE
    {39295,39425,39242,39232,39310,39408,39390,39407,39250,39388,40685,39254,39285,39190,40488,40699,40711,0}, // 79 Priest Holy/Discipline 1H MACE
    {39295,39425,39242,39232,39310,39408,39390,39407,39250,39388,40685,39254,39285,39190,39271,40699,40711,0}, // 80 Priest Holy/Discipline DAGGER
    {39295,39425,39242,39232,39310,39408,39390,39407,39250,39388,40685,39254,39285,39190,39394,40699,40711,0}, // 81 Priest Holy/Discipline 2H STAFF
    {0}
};

#define MSG_GOSSIP_PORTING_1     "Attiva Porting Fase 1"
#define MSG_GOSSIP_CLOSE         "Chiudi"
#define MSG_GOSSIP_PORTING_2     "Attiva Porting Fase 2"
#define MSG_GOSSIP_PORTING_3     "Portami a Dalaran"

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
            else if (fields[0].GetUInt32() == 2)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, MSG_GOSSIP_PORTING_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
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
            case GOSSIP_ACTION_INFO_DEF+2:
                {
                    pPlayer->AddItem(ITEM_BAG, 4);
                    QueryResult result = ExtraDatabase.PQuery("SELECT level, gold, repu_1, repu_2, repu_3, level_repu_1, level_repu_2, level_repu_3, skill_1, skill_2, skill_3, skill_4, skill_5, skill_6, skill_7, skill_8, level_skill_1, level_skill_2, level_skill_3, level_skill_4 , level_skill_5, level_skill_6, level_skill_7, level_skill_8 FROM `porting` WHERE `guid` = %u", pPlayer->GetGUIDLow());               
                    if (result)
                    {
                        Field *fields = result->Fetch();
                        // Livello
                        pPlayer->GiveLevel(fields[0].GetUInt8());
                        // Monete
                        pPlayer->ModifyMoney(fields[1].GetUInt32() * 1000);
                        // Reputazioni
                        for (int i = 2; i < 5; i++)
                        {
                            if (fields[i].GetUInt32())
                            {
                                FactionEntry const *factionEntry = sFactionStore.LookupEntry(fields[i].GetUInt32());

                                if (!factionEntry)
                                    continue;

                                if (factionEntry->reputationListID < 0)
                                    continue;

                                pPlayer->GetReputationMgr().SetOneFactionReputation(factionEntry, fields[i+3].GetUInt32());
                            }
                        }
                        // Skills
                        for (int i = 8; i < 16; i++)
                        {
                            if (fields[i].GetUInt32())
                            {
                                SkillLineEntry const *skillInfo = sSkillLineStore.LookupEntry(fields[i].GetUInt32());
                                if (!skillInfo)
                                    continue;

                                for (int j = 0; SkillSpells[j].skill != 0; j++)
                                {
                                    if (SkillSpells[j].skill == fields[i].GetUInt32())
                                    {
                                        if (SkillSpells[j].spell)
                                        {
                                            SpellEntry const* spellInfo = sSpellStore.LookupEntry(SkillSpells[j].spell);
                                            if (spellInfo && SpellMgr::IsSpellValid(spellInfo, pPlayer))
                                                if (!pPlayer->HasSpell(SkillSpells[j].spell))
                                                    pPlayer->learnSpell(SkillSpells[j].spell, false);
                                        }

                                        if (!pPlayer->GetSkillValue(SkillSpells[j].skill))
                                            break; 

                                        uint32 maxskill = 0;

                                        if (SkillSpells[j].maxskill == 450 || SkillSpells[j].maxskill == 300)
                                        {
                                            maxskill = (uint32(fields[i+8].GetUInt32() / 75) + (fields[i+8].GetUInt32()%75 ? 1 : 0)) * 75 >= SkillSpells[j].maxskill ? SkillSpells[j].maxskill : (uint32(fields[i+8].GetUInt32() / 75) + (fields[i+8].GetUInt32()%75 ? 1 : 0)) * 75;
                                            if (SkillSpells[j].skill == 762) // Riding
                                            {
                                                if (maxskill > 75)
                                                    if (!pPlayer->HasSpell(33391))
                                                        pPlayer->learnSpell(33391, false);
                                                if (maxskill > 150)
                                                    if (!pPlayer->HasSpell(34090))
                                                        pPlayer->learnSpell(34090, false);
                                                if (maxskill > 225)
                                                    if (!pPlayer->HasSpell(34091))
                                                        pPlayer->learnSpell(34091, false);
                                            }
                                        }
                                        else if (SkillSpells[j].maxskill == 400)
                                            maxskill = pPlayer->getLevel() * 5;

                                        uint32 max =  maxskill ? maxskill : pPlayer->GetPureMaxSkillValue(SkillSpells[j].skill);

                                        if (fields[i+8].GetUInt32() <= 0 || fields[i+8].GetUInt32() > max || max <= 0)
                                            break;

                                        pPlayer->SetSkill(SkillSpells[j].skill, pPlayer->GetSkillStep(SkillSpells[j].skill), fields[i+8].GetUInt32(), max);
                                        
                                        if (SkillSpells[j].skill == 333) // Enchanting
                                            pPlayer->AddItem(ITEM_TITANIUM_ROD, 1);

                                        if (SkillSpells[j].skill == 762 && fields[i+8].GetUInt32() == 300) // Riding
                                            pPlayer->AddItem(ITEM_TOME_COLD_WEATHER_FLY, 1);
                                    }
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
            case GOSSIP_ACTION_INFO_DEF+3:
                {
                    QueryResult result = ExtraDatabase.PQuery("SELECT id_equip_1, id_equip_2, id_equip_3, id_items FROM `porting` WHERE `guid` = %u", pPlayer->GetGUIDLow());               
                    if (result)
                    {
                        // Equip standard
                        Field *fields = result->Fetch();
                        for (int j = 0; j < 3; j++)
                            if (EquipVct[fields[j].GetUInt32()].item[0])
                                for (int i = 1; EquipVct[fields[j].GetUInt32()].item[i] != 0; i++)
                                {
                                    pPlayer->AddItem(EquipVct[fields[j].GetUInt32()].item[i], 1);
                                }

                        // Singoli item
                        std::stringstream ItemStringStream;
                        std::string ItemString;
                        ItemStringStream.str(std::string(fields[3].GetCString()));
                        while (std::getline(ItemStringStream, ItemString, ','))
		                {
			                std::stringstream ss2(ItemString);
			                int item_num = 0;
			                ss2 >> item_num; 
			                if (item_num > 0)
			                { 
				                pPlayer->AddItem(item_num, 1);
			                }
		                }                                
                    }
    
                    result = ExtraDatabase.PQuery("SELECT `active`, `ticket_txt` FROM `porting` WHERE `guid` = %u", pPlayer->GetGUIDLow());
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
                                std::string ticketText(fields[1].GetCString());
                                ticket->message = ticketText;
                                sTicketMgr->AddOrUpdateGMTicket(*ticket, true);
                                std::string msg = "Porting completato in parte! Ticket editato in automatico per completare il porting con un GM!";
                                pCreature->MonsterWhisper(msg.c_str(), pPlayer->GetGUID());
                            }
                            else
                            {                            
                                std::string msg = "Porting completato in parte! Edita eventualmente il ticket (per non perdere priorità) o apri ticket per completare il porting con un GM! Motivo del parziale completamento:";
                                pCreature->MonsterWhisper(msg.c_str(), pPlayer->GetGUID());
                                pCreature->MonsterWhisper(fields[1].GetCString(), pPlayer->GetGUID());
                            }
                        }
                        ExtraDatabase.PExecute("UPDATE `porting` SET `fase` = 2 WHERE `guid` = %u", pPlayer->GetGUIDLow());                
                    }
                    pPlayer->CLOSE_GOSSIP_MENU();
                }
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                {
                    ExtraDatabase.PExecute("UPDATE `porting` SET `fase` = 3, `active` = 0 WHERE `guid` = %u", pPlayer->GetGUIDLow());                
                    pPlayer->CLOSE_GOSSIP_MENU();
                    pPlayer->TeleportTo(571, 5804.15f, 624.77f, 647.8f, 1.64f);
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