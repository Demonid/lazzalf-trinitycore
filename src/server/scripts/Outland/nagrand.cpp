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
SDName: Nagrand
SD%Complete: 90
SDComment: Quest support: 9868, 9874, 9991, 10044, 10172, 10646, 10085. TextId's unknown for altruis_the_sufferer and greatmother_geyah (npc_text)
SDCategory: Nagrand
EndScriptData */

/* ContentData
npc_altruis_the_sufferer
npc_greatmother_geyah
npc_maghar_captive
npc_creditmarker_visit_with_ancestors
EndContentData */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

/*######
## npc_altruis_the_sufferer
######*/

#define GOSSIP_HATS1 "I see twisted steel and smell sundered earth."
#define GOSSIP_HATS2 "Well...?"
#define GOSSIP_HATS3 "[PH] Story about Illidan's Pupil"

#define GOSSIP_SATS1 "Legion?"
#define GOSSIP_SATS2 "And now?"
#define GOSSIP_SATS3 "How do you see them now?"
#define GOSSIP_SATS4 "Forge camps?"
#define GOSSIP_SATS5 "Ok."
#define GOSSIP_SATS6 "[PH] Story done"

class npc_altruis_the_sufferer : public CreatureScript
{
public:
    npc_altruis_the_sufferer() : CreatureScript("npc_altruis_the_sufferer") { }

    bool OnQuestAccept(Player* player, Creature* /*creature*/, Quest const* /*quest*/)
    {
        if (!player->GetQuestRewardStatus(9991))              //Survey the Land, q-id 9991
        {
            player->CLOSE_GOSSIP_MENU();
            player->ActivateTaxiPathTo(532);                  //TaxiPath 532
        }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+10:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SATS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                player->SEND_GOSSIP_MENU(9420, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+11:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SATS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
                player->SEND_GOSSIP_MENU(9421, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+12:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SATS3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                player->SEND_GOSSIP_MENU(9422, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+13:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SATS4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                player->SEND_GOSSIP_MENU(9423, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+14:
                player->SEND_GOSSIP_MENU(9424, creature->GetGUID());
                break;

            case GOSSIP_ACTION_INFO_DEF+20:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SATS5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 21);
                player->SEND_GOSSIP_MENU(9427, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+21:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(9991);
                break;

            case GOSSIP_ACTION_INFO_DEF+30:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SATS6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 31);
                player->SEND_GOSSIP_MENU(384, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+31:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(10646);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        //gossip before obtaining Survey the Land
        if (player->GetQuestStatus(9991) == QUEST_STATUS_NONE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HATS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+10);

        //gossip when Survey the Land is incomplete (technically, after the flight)
        if (player->GetQuestStatus(9991) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HATS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+20);

        //wowwiki.com/Varedis
        if (player->GetQuestStatus(10646) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HATS3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+30);

        player->SEND_GOSSIP_MENU(9419, creature->GetGUID());

        return true;
    }

};

/*######
## npc_greatmother_geyah
######*/

#define GOSSIP_HGG1 "Hello, Greatmother. Garrosh told me that you wanted to speak with me."
#define GOSSIP_HGG2 "Garrosh is beyond redemption, Greatmother. I fear that in helping the Mag'har, I have convinced Garrosh that he is unfit to lead."

#define GOSSIP_SGG1 "You raised all of the orcs here, Greatmother?"
#define GOSSIP_SGG2 "Do you believe that?"
#define GOSSIP_SGG3 "What can be done? I have tried many different things. I have done my best to help the people of Nagrand. Each time I have approached Garrosh, he has dismissed me."
#define GOSSIP_SGG4 "Left? How can you choose to leave?"
#define GOSSIP_SGG5 "What is this duty?"
#define GOSSIP_SGG6 "Is there anything I can do for you, Greatmother?"
#define GOSSIP_SGG7 "I have done all that I could, Greatmother. I thank you for your kind words."
#define GOSSIP_SGG8 "Greatmother, you are the mother of Durotan?"
#define GOSSIP_SGG9 "Greatmother, I never had the honor. Durotan died long before my time, but his heroics are known to all on my world. The orcs of Azeroth reside in a place known as Durotar, named after your son. And ... (You take a moment to breathe and think through what you are about to tell the Greatmother.)"
#define GOSSIP_SGG10 "It is my Warchief, Greatmother. The leader of my people. From my world. He ... He is the son of Durotan. He is your grandchild."
#define GOSSIP_SGG11 "I will return to Azeroth at once, Greatmother."

//all the textId's for the below is unknown, but i do believe the gossip item texts are proper.
class npc_greatmother_geyah : public CreatureScript
{
public:
    npc_greatmother_geyah() : CreatureScript("npc_greatmother_geyah") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 7:
                player->AreaExploredOrEventHappens(10044);
                player->CLOSE_GOSSIP_MENU();
                break;

            case GOSSIP_ACTION_INFO_DEF + 10:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 11:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG8, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 12:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG9, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 13:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG10, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 14:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SGG11, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 15:
                player->AreaExploredOrEventHappens(10172);
                player->CLOSE_GOSSIP_MENU();
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(10044) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HGG1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        }
        else if (player->GetQuestStatus(10172) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HGG2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        }
        else

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

};

/*#####
## npc_maghar_captive
#####*/

enum eMagharCaptive
{
    SAY_MAG_START               = -1000482,
    SAY_MAG_NO_ESCAPE           = -1000483,
    SAY_MAG_MORE                = -1000484,
    SAY_MAG_MORE_REPLY          = -1000485,
    SAY_MAG_LIGHTNING           = -1000486,
    SAY_MAG_SHOCK               = -1000487,
    SAY_MAG_COMPLETE            = -1000488,

    SPELL_CHAIN_LIGHTNING       = 16006,
    SPELL_EARTHBIND_TOTEM       = 15786,
    SPELL_FROST_SHOCK           = 12548,
    SPELL_HEALING_WAVE          = 12491,

    QUEST_TOTEM_KARDASH_H       = 9868,

    NPC_MURK_RAIDER             = 18203,
    NPC_MURK_BRUTE              = 18211,
    NPC_MURK_SCAVENGER          = 18207,
    NPC_MURK_PUTRIFIER          = 18202
};

static float m_afAmbushA[]= {-1568.805786f, 8533.873047f, 1.958f};
static float m_afAmbushB[]= {-1491.554321f, 8506.483398f, 1.248f};

class npc_maghar_captive : public CreatureScript
{
public:
    npc_maghar_captive() : CreatureScript("npc_maghar_captive") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_TOTEM_KARDASH_H)
        {
            if (npc_maghar_captiveAI* pEscortAI = dynamic_cast<npc_maghar_captiveAI*>(creature->AI()))
            {
                creature->SetStandState(UNIT_STAND_STATE_STAND);
                creature->setFaction(232);

                pEscortAI->Start(true, false, player->GetGUID(), quest);

                DoScriptText(SAY_MAG_START, creature);

                creature->SummonCreature(NPC_MURK_RAIDER, m_afAmbushA[0]+2.5f, m_afAmbushA[1]-2.5f, m_afAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_PUTRIFIER, m_afAmbushA[0]-2.5f, m_afAmbushA[1]+2.5f, m_afAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_MURK_BRUTE, m_afAmbushA[0], m_afAmbushA[1], m_afAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_maghar_captiveAI(creature);
    }

    struct npc_maghar_captiveAI : public npc_escortAI
    {
        npc_maghar_captiveAI(Creature* creature) : npc_escortAI(creature) { Reset(); }

        uint32 m_uiChainLightningTimer;
        uint32 m_uiHealTimer;
        uint32 m_uiFrostShockTimer;

        void Reset()
        {
            m_uiChainLightningTimer = 1000;
            m_uiHealTimer = 0;
            m_uiFrostShockTimer = 6000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoCast(me, SPELL_EARTHBIND_TOTEM, false);
        }

        void WaypointReached(uint32 uiPointId)
        {
            switch (uiPointId)
            {
                case 7:
                    DoScriptText(SAY_MAG_MORE, me);

                    if (Creature* temp = me->SummonCreature(NPC_MURK_PUTRIFIER, m_afAmbushB[0], m_afAmbushB[1], m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                        DoScriptText(SAY_MAG_MORE_REPLY, temp);

                    me->SummonCreature(NPC_MURK_PUTRIFIER, m_afAmbushB[0]-2.5f, m_afAmbushB[1]-2.5f, m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);

                    me->SummonCreature(NPC_MURK_SCAVENGER, m_afAmbushB[0]+2.5f, m_afAmbushB[1]+2.5f, m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_MURK_SCAVENGER, m_afAmbushB[0]+2.5f, m_afAmbushB[1]-2.5f, m_afAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                case 16:
                    DoScriptText(SAY_MAG_COMPLETE, me);

                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_TOTEM_KARDASH_H, me);

                    SetRun();
                    break;
            }
        }

        void JustSummoned(Creature* summoned)
        {
            if (summoned->GetEntry() == NPC_MURK_BRUTE)
                DoScriptText(SAY_MAG_NO_ESCAPE, summoned);

            if (summoned->isTotem())
                return;

            summoned->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            summoned->AI()->AttackStart(me);

        }

        void SpellHitTarget(Unit* /*target*/, const SpellInfo* pSpell)
        {
            if (pSpell->Id == SPELL_CHAIN_LIGHTNING)
            {
                if (rand()%10)
                    return;

                DoScriptText(SAY_MAG_LIGHTNING, me);
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);
            if (!me->getVictim())
                return;

            if (m_uiChainLightningTimer <= uiDiff)
            {
                DoCast(me->getVictim(), SPELL_CHAIN_LIGHTNING);
                m_uiChainLightningTimer = urand(7000, 14000);
            }
            else
                m_uiChainLightningTimer -= uiDiff;

            if (HealthBelowPct(30))
            {
                if (m_uiHealTimer <= uiDiff)
                {
                    DoCast(me, SPELL_HEALING_WAVE);
                    m_uiHealTimer = 5000;
                }
                else
                    m_uiHealTimer -= uiDiff;
            }

            if (m_uiFrostShockTimer <= uiDiff)
            {
                DoCast(me->getVictim(), SPELL_FROST_SHOCK);
                m_uiFrostShockTimer = urand(7500, 15000);
            }
            else
                m_uiFrostShockTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};

/*######
## npc_creditmarker_visist_with_ancestors
######*/

class npc_creditmarker_visit_with_ancestors : public CreatureScript
{
public:
    npc_creditmarker_visit_with_ancestors() : CreatureScript("npc_creditmarker_visit_with_ancestors") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_creditmarker_visit_with_ancestorsAI (creature);
    }

    struct npc_creditmarker_visit_with_ancestorsAI : public ScriptedAI
    {
        npc_creditmarker_visit_with_ancestorsAI(Creature* c) : ScriptedAI(c) {}

        void Reset() {}

        void EnterCombat(Unit* /*who*/) {}

        void MoveInLineOfSight(Unit* who)
        {
            if (!who)
                return;

            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (CAST_PLR(who)->GetQuestStatus(10085) == QUEST_STATUS_INCOMPLETE)
                {
                    uint32 creditMarkerId = me->GetEntry();
                    if ((creditMarkerId >= 18840) && (creditMarkerId <= 18843))
                    {
                        // 18840: Sunspring, 18841: Laughing, 18842: Garadar, 18843: Bleeding
                        if (!CAST_PLR(who)->GetReqKillOrCastCurrentCount(10085, creditMarkerId))
                            CAST_PLR(who)->KilledMonsterCredit(creditMarkerId, me->GetGUID());
                    }
                }
            }
        }
    };

};

/*######
## go_corkis_prison and npc_corki
######*/

enum CorkiData
{
  // first quest
  QUEST_HELP                                    = 9923,
  NPC_CORKI                                     = 18445,
  NPC_CORKI_CREDIT_1                            = 18369,
  GO_CORKIS_PRISON                              = 182349,
  CORKI_SAY_THANKS                              = -1800071,
  // 2nd quest
  QUEST_CORKIS_GONE_MISSING_AGAIN               = 9924,
  NPC_CORKI_2                                   = 20812,
  GO_CORKIS_PRISON_2                            = 182350,
  CORKI_SAY_PROMISE                             = -1800072,
  // 3rd quest
  QUEST_CHOWAR_THE_PILLAGER                     = 9955,
  NPC_CORKI_3                                   = 18369,
  NPC_CORKI_CREDIT_3                            = 18444,
  GO_CORKIS_PRISON_3                            = 182521,
  CORKI_SAY_LAST                                = -1800073
};

class go_corkis_prison : public GameObjectScript
{
public:
  go_corkis_prison() : GameObjectScript("go_corkis_prison") { }

  bool OnGossipHello(Player* player, GameObject* go)
  {
      if (go->GetEntry() == GO_CORKIS_PRISON)
      {
          if (Creature* corki = go->FindNearestCreature(NPC_CORKI, 25, true))
          {
              go->SetGoState(GO_STATE_READY);
              corki->GetMotionMaster()->MovePoint(1, go->GetPositionX()+5, go->GetPositionY(), go->GetPositionZ());
              if (player)
                  player->KilledMonsterCredit(NPC_CORKI_CREDIT_1, 0);
          }
      }
      if (go->GetEntry() == GO_CORKIS_PRISON_2)
      {
          if (Creature* corki = go->FindNearestCreature(NPC_CORKI_2, 25, true))
          {
              go->SetGoState(GO_STATE_READY);
              corki->GetMotionMaster()->MovePoint(1, go->GetPositionX()-5, go->GetPositionY(), go->GetPositionZ());
              if (player)
                  player->KilledMonsterCredit(NPC_CORKI_2, 0);
          }
      }
      if (go->GetEntry() == GO_CORKIS_PRISON_3)
      {
          if (Creature* corki = go->FindNearestCreature(NPC_CORKI_3, 25, true))
          {
              go->SetGoState(GO_STATE_READY);
              corki->GetMotionMaster()->MovePoint(1, go->GetPositionX()+4, go->GetPositionY(), go->GetPositionZ());
              if (player)
                  player->KilledMonsterCredit(NPC_CORKI_CREDIT_3, 0);
          }
      }
      return true;
  }
};

class npc_corki : public CreatureScript
{
public:
  npc_corki() : CreatureScript("npc_corki") { }

  CreatureAI* GetAI(Creature* creature) const
  {
      return new npc_corkiAI(creature);
  }

  struct npc_corkiAI : public ScriptedAI
  {
      npc_corkiAI(Creature* creature) : ScriptedAI(creature) {}

      uint32 Say_Timer;
      bool ReleasedFromCage;

      void Reset()
      {
          ReleasedFromCage = false;
      }

      void UpdateAI(uint32 const diff)
      {
          if (Say_Timer <= diff && ReleasedFromCage)
          {
              me->ForcedDespawn();
              ReleasedFromCage = false;
          }
          else
              Say_Timer -= diff;
      }

      void MovementInform(uint32 type, uint32 id)
      {
          if (type == POINT_MOTION_TYPE && id == 1)
          {
              Say_Timer = 5000;
              ReleasedFromCage = true;
              if (me->GetEntry() == NPC_CORKI)
                  DoScriptText(CORKI_SAY_THANKS, me);
              if (me->GetEntry() == NPC_CORKI_2)
                  DoScriptText(CORKI_SAY_PROMISE, me);
              if (me->GetEntry() == NPC_CORKI_3)
                  DoScriptText(CORKI_SAY_LAST, me);
          }
      };
  };
};

/*#####
## npc_kurenai_captive
#####*/

enum KurenaiCaptive
{
    SAY_KUR_START                   = 0,
    SAY_KUR_NO_ESCAPE               = 1,
    SAY_KUR_MORE                    = 2,
    SAY_KUR_MORE_TWO                = 3,
    SAY_KUR_LIGHTNING               = 4,
    SAY_KUR_SHOCK                   = 5,
    SAY_KUR_COMPLETE                = 6,

    SPELL_KUR_CHAIN_LIGHTNING       = 16006,
    SPELL_KUR_EARTHBIND_TOTEM       = 15786,
    SPELL_KUR_FROST_SHOCK           = 12548,
    SPELL_KUR_HEALING_WAVE          = 12491,

    QUEST_TOTEM_KARDASH_A           = 9879,

    NPC_KUR_MURK_RAIDER             = 18203,
    NPC_KUR_MURK_BRUTE              = 18211,
    NPC_KUR_MURK_SCAVENGER          = 18207,
    NPC_KUR_MURK_PUTRIFIER          = 18202,
};

static float kurenaiAmbushA[]= {-1568.805786f, 8533.873047f, 1.958f};
static float kurenaiAmbushB[]= {-1491.554321f, 8506.483398f, 1.248f};

class npc_kurenai_captive : public CreatureScript
{
public:
    npc_kurenai_captive() : CreatureScript("npc_kurenai_captive") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_TOTEM_KARDASH_A)
        {
            if (npc_kurenai_captiveAI* EscortAI = dynamic_cast<npc_kurenai_captiveAI*>(creature->AI()))
            {
                creature->SetStandState(UNIT_STAND_STATE_STAND);
                EscortAI->Start(true, false, player->GetGUID(), quest);
                DoScriptText(SAY_KUR_START, creature);

                creature->SummonCreature(NPC_KUR_MURK_RAIDER, kurenaiAmbushA[0]+2.5f, kurenaiAmbushA[1]-2.5f, kurenaiAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_KUR_MURK_BRUTE, kurenaiAmbushA[0]-2.5f, kurenaiAmbushA[1]+2.5f, kurenaiAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                creature->SummonCreature(NPC_KUR_MURK_SCAVENGER, kurenaiAmbushA[0], kurenaiAmbushA[1], kurenaiAmbushA[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_kurenai_captiveAI(creature);
    }

    struct npc_kurenai_captiveAI : public npc_escortAI
    {
        npc_kurenai_captiveAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 ChainLightningTimer;
        uint32 HealTimer;
        uint32 FrostShockTimer;

        void Reset()
        {
            ChainLightningTimer = 1000;
            HealTimer = 0;
            FrostShockTimer = 6000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoCast(me, SPELL_KUR_EARTHBIND_TOTEM, false);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            if (Player* player = GetPlayerForEscort())
            {
                if (player->GetQuestStatus(QUEST_TOTEM_KARDASH_A) != QUEST_STATUS_COMPLETE)
                    player->FailQuest(QUEST_TOTEM_KARDASH_A);
            }
        }

        void WaypointReached(uint32 PointId)
        {
            switch(PointId)
            {
                case 3:
                {
                    Talk(SAY_KUR_MORE);

                    if (Creature* temp = me->SummonCreature(NPC_KUR_MURK_PUTRIFIER, kurenaiAmbushB[0], kurenaiAmbushB[1], kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000))
                        Talk(SAY_KUR_MORE_TWO);

                    me->SummonCreature(NPC_KUR_MURK_PUTRIFIER, kurenaiAmbushB[0]-2.5f, kurenaiAmbushB[1]-2.5f, kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_KUR_MURK_SCAVENGER, kurenaiAmbushB[0]+2.5f, kurenaiAmbushB[1]+2.5f, kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(NPC_KUR_MURK_SCAVENGER, kurenaiAmbushB[0]+2.5f, kurenaiAmbushB[1]-2.5f, kurenaiAmbushB[2], 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                }
                case 7:
                {
                    Talk(SAY_KUR_COMPLETE);

                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_TOTEM_KARDASH_A, me);

                    SetRun();
                    break;
                }
            }
        }

        void JustSummoned(Creature* summoned)
        {
            if (summoned->GetEntry() == NPC_KUR_MURK_BRUTE)
                Talk(SAY_KUR_NO_ESCAPE);

            // This function is for when we summoned enemies to fight - so that does NOT mean we should make our totem count in this!
            if (summoned->isTotem())
                return;

            summoned->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            summoned->AI()->AttackStart(me);
        }

        void SpellHitTarget(Unit* /*target*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_KUR_CHAIN_LIGHTNING)
            {
                if (rand()%30)
                    return;

                Talk(SAY_KUR_LIGHTNING);
            }

            if (spell->Id == SPELL_KUR_FROST_SHOCK)
            {
                if (rand()%30)
                    return;

                Talk(SAY_KUR_SHOCK);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            if (ChainLightningTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_KUR_CHAIN_LIGHTNING);
                ChainLightningTimer = urand(7000,14000);
            } else ChainLightningTimer -= diff;

            if (HealthBelowPct(30))
            {
                if (HealTimer <= diff)
                {
                    DoCast(me, SPELL_KUR_HEALING_WAVE);
                    HealTimer = 5000;
                } else HealTimer -= diff;
            }

            if (FrostShockTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_KUR_FROST_SHOCK);
                FrostShockTimer = urand(7500,15000);
            } else FrostShockTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## go_warmaul_prison
######*/

enum FindingTheSurvivorsData
{
    QUEST_FINDING_THE_SURVIVORS                     = 9948,
    NPC_MAGHAR_PRISONER                             = 18428,

    SAY_FREE_0                                      = 0,
    SAY_FREE_1                                      = 1,
    SAY_FREE_2                                      = 2,
    SAY_FREE_3                                      = 3,
    SAY_FREE_4                                      = 4,
};

class go_warmaul_prison : public GameObjectScript
{
public:
    go_warmaul_prison() : GameObjectScript("go_warmaul_prison") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (player->GetQuestStatus(QUEST_FINDING_THE_SURVIVORS) != QUEST_STATUS_INCOMPLETE)
            return false;
        
        if (Creature* prisoner = go->FindNearestCreature(NPC_MAGHAR_PRISONER, 1.0f))
        {
            if (prisoner)
            {
                go->UseDoorOrButton();
                if (player)
                    player->KilledMonsterCredit(NPC_MAGHAR_PRISONER, 0);

                prisoner->AI()->Talk(RAND(SAY_FREE_0, SAY_FREE_1, SAY_FREE_2, SAY_FREE_3, SAY_FREE_4), player->GetGUID());
                prisoner->ForcedDespawn(6000);
            }
        }
        return true;
    }
};

void AddSC_nagrand()
{
    new npc_altruis_the_sufferer();
    new npc_greatmother_geyah();
    new npc_maghar_captive();
    new npc_creditmarker_visit_with_ancestors();
    new npc_corki();
    new go_corkis_prison();
    new npc_kurenai_captive();
    new go_warmaul_prison();
}
