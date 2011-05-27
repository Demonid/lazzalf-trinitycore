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
SDName: Dragonblight
SD%Complete: 100
SDComment:
SDCategory: Dragonblight
EndScriptData */

/* ContentData
npc_alexstrasza_wr_gate
EndContentData */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

enum eEnums
{
    QUEST_RETURN_TO_AG_A    = 12499,
    QUEST_RETURN_TO_AG_H    = 12500,
    MOVIE_ID_GATES          = 14
};

#define GOSSIP_ITEM_WHAT_HAPPENED   "Alexstrasza, can you show me what happened here?"

class npc_alexstrasza_wr_gate : public CreatureScript
{
public:
    npc_alexstrasza_wr_gate() : CreatureScript("npc_alexstrasza_wr_gate") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (pCreature->isQuestGiver())
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());

        if (pPlayer->GetQuestRewardStatus(QUEST_RETURN_TO_AG_A) || pPlayer->GetQuestRewardStatus(QUEST_RETURN_TO_AG_H))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_WHAT_HAPPENED, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            pPlayer->CLOSE_GOSSIP_MENU();
            pPlayer->SendMovieStart(MOVIE_ID_GATES);
        }

        return true;
    }
};

/* Emblazoned Battle Horn */

#define NPC_GROMTHAR 27002

const Position gromthar_position = {2720.921f, 427.441f, 67.002f, 5.996f};

class item_emblazoned_battle_horn : public ItemScript
{
public:
    item_emblazoned_battle_horn() : ItemScript("item_emblazoned_battle_horn") { }

    bool OnUse(Player* pPlayer, Item* pItem, SpellCastTargets const& /*targets*/)
    {
        if (!pPlayer)
            return true;

        if (Creature* pCreature = pPlayer->FindNearestCreature(NPC_GROMTHAR, 100, true))
            if (pCreature->isAlive())
                return false;
 
        pPlayer->SummonCreature(NPC_GROMTHAR, gromthar_position, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 180000);
        return true;
    }
};

/* Torturer LeCraft */

#define SPELL_EXECUTOR_BRANDING_IRON 48603
#define NPC_TORTURER_CREDIT 27394

class npc_torturer_lecraft : public CreatureScript
{
public:
    npc_torturer_lecraft() : CreatureScript("npc_torturer_lecraft") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_torturer_lecraftAI(pCreature);
    }

    struct npc_torturer_lecraftAI : public ScriptedAI
    {
        npc_torturer_lecraftAI(Creature *c) : ScriptedAI(c)
        {
            brandedTimes = 0;
        }

        uint8 brandedTimes;

        void Reset()
        {
            brandedTimes = 0;
        }

        void EnterCombat(Unit* /*who*/)
        {
            brandedTimes = 0;
            me->MonsterSay("Come to play?", LANG_UNIVERSAL, 0);
        }

        void SpellHit(Unit* caster, const SpellEntry *spell)
        {
            if (Player* player = caster->ToPlayer())
            {
                if (spell->Id == SPELL_EXECUTOR_BRANDING_IRON)
                {
                    brandedTimes++;

                    switch (brandedTimes)
                    {
                        case 1:
                            me->MonsterWhisper("Ow! I'll tell you NOTHING, filthy $R!", player->GetGUID());
                            break;
                        case 2:
                            me->MonsterWhisper("Wait... WAIT! What is it that you want to know? I know you're the $C named $N.", player->GetGUID());
                            break;
                        case 3:
                            me->MonsterWhisper("OW...NO! We know that you've been stealing our armor and weapons and horses!", player->GetGUID());
                            break;
                        case 4:
                            me->MonsterWhisper("We know... that you don't... know why we're immune... to your so-called blight. Grand Admiral Westwind somehow gave the high abbot that prayer. I beg you... no more... please?", player->GetGUID());
                            break;
                        case 5:
                            me->MonsterWhisper("AHHHHHHHHH! Please... we know... that you... have a spy... disguised as... one of us! There... that's all that I know. Please... mercy... STOP!", player->GetGUID());
                            player->KilledMonsterCredit(NPC_TORTURER_CREDIT, 0);
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        void UpdateAI(const uint32 /*diff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

};

#define NEXUS_DRAKE_HATCHLING 26127

class npc_dummy_raelorasz : public CreatureScript
{
public:
    npc_dummy_raelorasz() : CreatureScript("npc_dummy_raelorasz") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_dummy_raeloraszAI(pCreature);
    }

    struct npc_dummy_raeloraszAI : public ScriptedAI
    {
        npc_dummy_raeloraszAI(Creature *c) : ScriptedAI(c)
        {
            uiFindTimer = 5000;
        }

        uint32 uiFindTimer;

        void UpdateAI(const uint32 uiDiff)
        {
            if (uiFindTimer <= uiDiff)
            {
                std::list<Creature*> list;
                me->GetCreatureListWithEntryInGrid(list, NEXUS_DRAKE_HATCHLING, 30.0f);
                if (!list.empty())
                    for (std::list<Creature*>::iterator itr = list.begin(); itr != list.end(); ++itr)
                    {
                        if (Unit* owner = (*itr)->GetOwner())
                            if (owner->ToPlayer())
                            {
                                owner->ToPlayer()->CompleteQuest(11940);
                                (*itr)->DespawnOrUnsummon();
                            }
                    }
                uiFindTimer = 5000;
            }
            else
                uiFindTimer -= uiDiff;
        }
    };

};

void AddSC_dragonblight()
{
    new npc_alexstrasza_wr_gate;
    new item_emblazoned_battle_horn();
    new npc_torturer_lecraft();
    new npc_dummy_raelorasz();
}
