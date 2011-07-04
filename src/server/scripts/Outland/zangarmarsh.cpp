/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Zangarmarsh
SD%Complete: 100
SDComment: Quest support: 9752, 9785, 9803, 10009. Mark Of ... buffs.
SDCategory: Zangarmarsh
EndScriptData */

/* ContentData
npcs_ashyen_and_keleth
npc_cooshcoosh
npc_elder_kuruti
npc_mortog_steamhead
npc_kayra_longmane
npc_timothy_daniels
EndContentData */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

/*######
## npcs_ashyen_and_keleth
######*/

#define GOSSIP_ITEM_BLESS_ASH     "Grant me your mark, wise ancient."
#define GOSSIP_ITEM_BLESS_KEL     "Grant me your mark, mighty ancient."
//signed for 17900 but used by 17900, 17901
#define GOSSIP_REWARD_BLESS       -1000359
//#define TEXT_BLESSINGS        "<You need higher standing with Cenarion Expedition to recive a blessing.>"

class npcs_ashyen_and_keleth : public CreatureScript
{
public:
    npcs_ashyen_and_keleth() : CreatureScript("npcs_ashyen_and_keleth") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetReputationRank(942) > REP_NEUTRAL)
        {
            if (creature->GetEntry() == 17900)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BLESS_ASH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            if (creature->GetEntry() == 17901)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BLESS_KEL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        }
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            creature->setPowerType(POWER_MANA);
            creature->SetMaxPower(POWER_MANA, 200);             //set a "fake" mana value, we can't depend on database doing it in this case
            creature->SetPower(POWER_MANA, 200);

            if (creature->GetEntry() == 17900)                //check which Creature we are dealing with
            {
                switch (player->GetReputationRank(942))
                {                                               //mark of lore
                    case REP_FRIENDLY:
                        creature->CastSpell(player, 31808, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    case REP_HONORED:
                        creature->CastSpell(player, 31810, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    case REP_REVERED:
                        creature->CastSpell(player, 31811, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    case REP_EXALTED:
                        creature->CastSpell(player, 31815, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    default:
                        break;
                }
            }

            if (creature->GetEntry() == 17901)
            {
                switch (player->GetReputationRank(942))         //mark of war
                {
                    case REP_FRIENDLY:
                        creature->CastSpell(player, 31807, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    case REP_HONORED:
                        creature->CastSpell(player, 31812, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    case REP_REVERED:
                        creature->CastSpell(player, 31813, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    case REP_EXALTED:
                        creature->CastSpell(player, 31814, true);
                        DoScriptText(GOSSIP_REWARD_BLESS, creature);
                        break;
                    default:
                        break;
                }
            }
            player->CLOSE_GOSSIP_MENU();
            player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
        }
        return true;
    }
};

/*######
## npc_cooshcoosh
######*/

#define GOSSIP_COOSH            "You owe Sim'salabim money. Hand them over or die!"

enum eCooshhooosh
{
    SPELL_LIGHTNING_BOLT    = 9532,
    QUEST_CRACK_SKULLS      = 10009,
    FACTION_HOSTILE_CO      = 45
};

class npc_cooshcoosh : public CreatureScript
{
public:
    npc_cooshcoosh() : CreatureScript("npc_cooshcoosh") { }

    struct npc_cooshcooshAI : public ScriptedAI
    {
        npc_cooshcooshAI(Creature* c) : ScriptedAI(c)
        {
            m_uiNormFaction = c->getFaction();
        }

        uint32 m_uiNormFaction;
        uint32 LightningBolt_Timer;

        void Reset()
        {
            LightningBolt_Timer = 2000;
            if (me->getFaction() != m_uiNormFaction)
                me->setFaction(m_uiNormFaction);
        }

        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (LightningBolt_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_LIGHTNING_BOLT);
                LightningBolt_Timer = 5000;
            } else LightningBolt_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_cooshcooshAI (creature);
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_CRACK_SKULLS) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_COOSH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        player->SEND_GOSSIP_MENU(9441, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->setFaction(FACTION_HOSTILE_CO);
            creature->AI()->AttackStart(player);
        }
        return true;
    }
};

/*######
## npc_elder_kuruti
######*/

#define GOSSIP_ITEM_KUR1 "Greetings, elder. It is time for your people to end their hostility towards the draenei and their allies."
#define GOSSIP_ITEM_KUR2 "I did not mean to deceive you, elder. The draenei of Telredor thought to approach you in a way that would seem familiar to you."
#define GOSSIP_ITEM_KUR3 "I will tell them. Farewell, elder."

class npc_elder_kuruti : public CreatureScript
{
public:
    npc_elder_kuruti() : CreatureScript("npc_elder_kuruti") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(9803) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KUR1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        player->SEND_GOSSIP_MENU(9226, creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KUR2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(9227, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KUR3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(9229, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
            {
                if (!player->HasItemCount(24573, 1))
                {
                    ItemPosCountVec dest;
                    uint32 itemId = 24573;
                    InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, 1, false);
                    if (msg == EQUIP_ERR_OK)
                    {
                        player->StoreNewItem(dest, itemId, true);
                    }
                    else
                        player->SendEquipError(msg, NULL, NULL, itemId);
                }
                player->SEND_GOSSIP_MENU(9231, creature->GetGUID());
                break;
            }
        }
        return true;
    }
};

/*######
## npc_mortog_steamhead
######*/
class npc_mortog_steamhead : public CreatureScript
{
public:
    npc_mortog_steamhead() : CreatureScript("npc_mortog_steamhead") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isVendor() && player->GetReputationRank(942) == REP_EXALTED)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());
        return true;
    }
};

/*######
## npc_kayra_longmane
######*/

enum eKayra
{
    SAY_START           = -1000343,
    SAY_AMBUSH1         = -1000344,
    SAY_PROGRESS        = -1000345,
    SAY_AMBUSH2         = -1000346,
    SAY_NEAR_END        = -1000347,
    SAY_END             = -1000348, //this is signed for 10646

    QUEST_ESCAPE_FROM   = 9752,
    NPC_SLAVEBINDER     = 18042
};

class npc_kayra_longmane : public CreatureScript
{
public:
    npc_kayra_longmane() : CreatureScript("npc_kayra_longmane") { }

    struct npc_kayra_longmaneAI : public npc_escortAI
    {
        npc_kayra_longmaneAI(Creature* c) : npc_escortAI(c) {}

        void Reset() { }

        void WaypointReached(uint32 i)
        {
            Player* player = GetPlayerForEscort();

            if (!player)
                return;

            switch(i)
            {
                case 4:
                    DoScriptText(SAY_AMBUSH1, me, player);
                    DoSpawnCreature(NPC_SLAVEBINDER, -10.0f, -5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_SLAVEBINDER, -8.0f, 5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 5:
                    DoScriptText(SAY_PROGRESS, me, player);
                    SetRun();
                    break;
                case 16:
                    DoScriptText(SAY_AMBUSH2, me, player);
                    DoSpawnCreature(NPC_SLAVEBINDER, -10.0f, -5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_SLAVEBINDER, -8.0f, 5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 17:
                    SetRun(false);
                    DoScriptText(SAY_NEAR_END, me, player);
                    break;
                case 25:
                    DoScriptText(SAY_END, me, player);
                    player->GroupEventHappens(QUEST_ESCAPE_FROM, me);
                    break;
            }
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* pQuest)
    {
        if (pQuest->GetQuestId() == QUEST_ESCAPE_FROM)
        {
            DoScriptText(SAY_START, creature, player);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_kayra_longmane::npc_kayra_longmaneAI, creature->AI()))
                pEscortAI->Start(false, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_kayra_longmaneAI(creature);
    }
};

/*######
## npc_timothy_daniels
######*/

#define GOSSIP_TIMOTHY_DANIELS_ITEM1    "Specialist, eh? Just what kind of specialist are you, anyway?"
#define GOSSIP_TEXT_BROWSE_POISONS      "Let me browse your reagents and poison supplies."

enum eTimothy
{
    GOSSIP_TEXTID_TIMOTHY_DANIELS1      = 9239
};

class npc_timothy_daniels : public CreatureScript
{
public:
    npc_timothy_daniels() : CreatureScript("npc_timothy_daniels") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->isVendor())
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_POISONS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_TIMOTHY_DANIELS_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch(uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_TIMOTHY_DANIELS1, creature->GetGUID());
                break;
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
        }

        return true;
    }
};

enum AhuneSummons
{
    NPC_FROZEN_CORE = 25865,
    NPC_AHUNITE_HAILSTONE = 25755,
    NPC_AHUNITE_COLDWAVE = 25756,
    NPC_AHUNITE_FROSTWIND = 25757,
};

enum AhunePhases
{
    AHUNE_PHASE_1 = 1,
    AHUNE_PHASE_2,
    AHUNE_PHASE_3,
};

enum AhuneSpells
{
    SPELL_SUMMON_ICE_SPEAR_BUNNY = 46359,  // Summona il Bunny
    SPELL_SUMMON_ICE_SPEAR_GOBJECT = 46369, // Effetto grafico della spina, è un gobject con due posizioni (spina chiusa e spina aperta)
    SPELL_SUMMON_ICE_SPEAR_KNOWBACK_DELAYER = 46878, // Attiva la spina alla fine dell'effetto
    SPELL_ICE_SPEAR_VISUAL = 75498, // Effetto grafico attorno alla spina
    SPELL_ICE_SPEAR_KNOWBAK = 46360, // Knowback della spina + trigger danno
    SPELL_ICE_SPEAR = 46588, // Danno triggerato della spina
    SPELL_ICE_SPEAR_TARGET_PICKER = 46372, // ???
    SPELL_ICE_SPEAR_COTROL_AURA = 46371, // ???

    SPELL_RESURFACES = 46402,
    SPELL_SELF_STUN = 46416, // Stun quando sparisce

    SPELL_BEAM_ATTACK_1 = 46336,
    SPELL_BEAM_ATTACK_2 = 46363, // Raggio Rosso

    SPELL_FROZENCORE_GETS_HIT = 46810,

    SPELL_AHUNE_SHIELD = 45954,
    SPELL_COLD_SLAP = 46145,
};

// TODO: da prendere nell'ista
const Position SummonsPositions[3] =
{
    {0.0f, 0.0f, 0.0f, 0.0f},  // Boss
    {0.0f, 0.0f, 0.0f, 0.0f},
    {0.0f, 0.0f, 0.0f, 0.0f},
};

#define GO_ICE_CHEST 187892

class boss_ahune : public CreatureScript
{
public:
    boss_ahune() : CreatureScript("boss_ahune") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_ahuneAI (creature);
    }

    struct boss_ahuneAI : public ScriptedAI
    {
        boss_ahuneAI(Creature* c) : ScriptedAI(c)
        {
            me->SummonCreature(NPC_FROZEN_CORE, SummonsPositions[0], TEMPSUMMON_CORPSE_DESPAWN);
            // Deve castarsi ahune's shield
        }

        uint8 phase;
        uint32 coldSlapTimer;
        uint32 iceSpearTimer;
        uint32 summonAddsTimer;
        uint32 addsPhaseTimer;
        uint32 corePhaseTimer;

        void Reset()
        {
            //me->DisappearAndDie(); // se si wippa deve sparire
        }

        void JustDied(Unit* /*killer*/)
        {
            // Summon/attivazione della cassa
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->SummonCreature(NPC_AHUNITE_HAILSTONE, SummonsPositions[0], TEMPSUMMON_CORPSE_DESPAWN);
            summonAddsTimer = 10 * IN_MILLISECONDS;
            iceSpearTimer = 7 * IN_MILLISECONDS;
            coldSlapTimer = 13 * IN_MILLISECONDS;
            addsPhaseTimer = MINUTE * IN_MILLISECONDS;
            phase = AHUNE_PHASE_1;
        }

        void UpdateAI(uint32 const diff)
        {
            // Check if we have a current target
            if (!UpdateVictim())
                return;

            // Ice Spear viene castato in tutte le fasi
            if (iceSpearTimer <= diff)
            {
                // Casta ice spear
                iceSpearTimer = 7 * IN_MILLISECONDS;
            }
            else
                iceSpearTimer -= diff;

            if (phase == AHUNE_PHASE_1 || phase == AHUNE_PHASE_3)
            {
                if (summonAddsTimer <= diff)
                {
                    for (uint8 i = 0; i < 2; ++i)
                        me->SummonCreature(NPC_AHUNITE_COLDWAVE, SummonsPositions[urand(0,2)], TEMPSUMMON_CORPSE_DESPAWN);

                    if (phase == AHUNE_PHASE_3)
                        me->SummonCreature(NPC_AHUNITE_FROSTWIND, SummonsPositions[urand(0,2)], TEMPSUMMON_CORPSE_DESPAWN);

                    summonAddsTimer = 5 * IN_MILLISECONDS;
                }
                else
                    summonAddsTimer -= diff;

                if (coldSlapTimer <= diff)
                {
                    // casta cold slap
                    coldSlapTimer = 7 * IN_MILLISECONDS;
                }
                else
                    coldSlapTimer -= diff;

                if (addsPhaseTimer <= diff)
                {
                    phase = AHUNE_PHASE_2;                    
                    corePhaseTimer = 30 * IN_MILLISECONDS;
                }
                else
                    addsPhaseTimer -= diff;
            }
            else if (phase == AHUNE_PHASE_2)
            {
                if (corePhaseTimer <= diff)
                {
                    phase = AHUNE_PHASE_3; 
                    addsPhaseTimer = MINUTE * IN_MILLISECONDS;
                }
                else
                    corePhaseTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_ahune_spine : public CreatureScript
{
public:
    npc_ahune_spine() : CreatureScript("npc_ahune_spine") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ahune_spineAI (creature);
    }

    struct npc_ahune_spineAI : public ScriptedAI
    {
        npc_ahune_spineAI(Creature* c) : ScriptedAI(c)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        uint32 activateSpineTime;
        uint32 despawnTimer;

        GameObject* goSpike;

        void Reset()
        {
            me->CastSpell(me, SPELL_ICE_SPEAR_VISUAL, false);
            goSpike = me->SummonGameObject(188077, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, 0, 0, 0, 5000);
            activateSpineTime = 2 * IN_MILLISECONDS;
            despawnTimer = 5 * IN_MILLISECONDS;
        }

        void UpdateAI(uint32 const diff)
        {
            if (activateSpineTime <= diff)
            {
                if (goSpike)
                    goSpike->setActive(true);
                me->CastSpell(me, SPELL_ICE_SPEAR_KNOWBAK, false);                
            }
            else
                activateSpineTime -= diff;

            if (despawnTimer <= diff)
            {
                //if (goSpike)
                //    goSpike->RemoveFromWorld();
                me->DespawnOrUnsummon();
            }
            else
                despawnTimer -= diff;
        }
    };
};

/*######
## AddSC
######*/

void AddSC_zangarmarsh()
{
    new npcs_ashyen_and_keleth();
    new npc_cooshcoosh();
    new npc_elder_kuruti();
    new npc_mortog_steamhead();
    new npc_kayra_longmane();
    new npc_timothy_daniels();
    new boss_ahune();
}
