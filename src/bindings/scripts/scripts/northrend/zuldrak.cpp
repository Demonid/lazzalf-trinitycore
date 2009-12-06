/*
 * Copyright (C) 2009 Trinity <http://www.trinitycore.org/>
 *
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

#include "precompiled.h"

/*####
## npc_drakuru_shackles
####*/

enum eDrakuruShackles
{
    SPELL_LEFT_CHAIN           = 59951,
    SPELL_RIGHT_CHAIN          = 59952,
    SPELL_UNLOCK_SHACKLE       = 55083,
    SPELL_FREE_RAGECLAW        = 55223,

    NPC_RAGECLAW               = 29686
};

struct TRINITY_DLL_DECL npc_drakuru_shacklesAI : public ScriptedAI
{
    npc_drakuru_shacklesAI(Creature* pCreature) : ScriptedAI(pCreature) {}

    Unit* Rageclaw;

    void Reset()
    {
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        float x, y, z;
        Rageclaw = NULL;
        m_creature->GetClosePoint(x, y, z, m_creature->GetObjectSize()/3,0.1);
        if (Unit* summon = m_creature->SummonCreature(NPC_RAGECLAW,x,y,z,0,TEMPSUMMON_DEAD_DESPAWN,1000))
            DoActionOnRageclaw(true,summon);
    }

    void DoActionOnRageclaw(bool bLocking, Unit* pWho)
    {
        if (!pWho)
            return;

        if (bLocking)
        {
            if (pWho)
            {
                Rageclaw = pWho;

                m_creature->SetInFront(Rageclaw);
                Rageclaw->SetInFront(m_creature);

                DoCast(Rageclaw, SPELL_LEFT_CHAIN, true);
                DoCast(Rageclaw, SPELL_RIGHT_CHAIN, true);
            }
        }
        else
        {
            DoCast(Rageclaw, SPELL_FREE_RAGECLAW, true);
            if (pWho->GetTypeId() == TYPEID_PLAYER)
                CAST_PLR(pWho)->CastSpell(Rageclaw, SPELL_UNLOCK_SHACKLE, true);
            m_creature->setDeathState(DEAD);
        }
    }

    void SpellHit(Unit* pCaster, const SpellEntry* pSpell)
    {
        if (pSpell->Id == SPELL_UNLOCK_SHACKLE)
        {
            if (Rageclaw)
                DoActionOnRageclaw(false, pCaster);
            else
                m_creature->setDeathState(JUST_DIED);
        }
    }
};

CreatureAI* GetAI_npc_drakuru_shackles(Creature* pCreature)
{
    return new npc_drakuru_shacklesAI (pCreature);
}

/*####
## npc_captured_rageclaw
####*/

enum eRageclaw
{
    SPELL_UNSHACKLED           = 55085,
    SPELL_KNEEL                = 39656
};

const char * SAY_RAGECLAW_1 =      "I poop on you, trollses!";
const char * SAY_RAGECLAW_2 =      "ARRRROOOOGGGGAAAA!";
const char * SAY_RAGECLAW_3 =      "No more mister nice wolvar!";

#define SAY_RAGECLAW RAND(SAY_RAGECLAW_1,SAY_RAGECLAW_2,SAY_RAGECLAW_3)

struct TRINITY_DLL_DECL npc_captured_rageclawAI : public ScriptedAI
{
    npc_captured_rageclawAI(Creature* pCreature) : ScriptedAI(pCreature) {}

    uint32 DespawnTimer;
    bool Despawn;

    void Reset()
    {
        Despawn = false;
        DespawnTimer = 0;
        m_creature->setFaction(35);
        DoCast(m_creature, SPELL_KNEEL, true); // Little Hack for kneel - Thanks Illy :P
    }

    void MoveInLineOfSight(Unit *who){}

    void SpellHit(Unit* pCaster, const SpellEntry* pSpell)
    {
        if (pSpell->Id == SPELL_FREE_RAGECLAW)
        {
            m_creature->RemoveAurasDueToSpell(SPELL_LEFT_CHAIN);

            m_creature->RemoveAurasDueToSpell(SPELL_RIGHT_CHAIN);

            m_creature->RemoveAurasDueToSpell(SPELL_KNEEL);

            m_creature->setFaction(m_creature->GetCreatureInfo()->faction_H);

            DoCast(m_creature, SPELL_UNSHACKLED, true);
            m_creature->MonsterSay(SAY_RAGECLAW, LANG_UNIVERSAL, NULL);
            m_creature->GetMotionMaster()->MoveRandom(10);

            DespawnTimer = 10000;
            Despawn = true;
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (m_creature->getVictim())
        {
            DoMeleeAttackIfReady();
            return;
        }

        if (!Despawn)
            return;

        if (DespawnTimer <= uiDiff)
            m_creature->DisappearAndDie();
        else DespawnTimer -= uiDiff;
   }
};

CreatureAI* GetAI_npc_captured_rageclaw(Creature* pCreature)
{
    return new npc_captured_rageclawAI (pCreature);
}

/*####
## npc_gymer
####*/

#define    GOSSIP_ITEM_G "I'm ready, Gymer. Let's go!"

enum eGymer
{
    QUEST_STORM_KING_VENGEANCE    = 12919,
    SPELL_GYMER                   = 55568
};

bool GossipHello_npc_gymer(Player* pPlayer, Creature* pCreature)
{
    if (pCreature->isQuestGiver())
        pPlayer->PrepareQuestMenu(pCreature->GetGUID());

    pPlayer->SEND_GOSSIP_MENU(pCreature->GetNpcTextId(), pCreature->GetGUID());

    if (pPlayer->GetQuestStatus(QUEST_STORM_KING_VENGEANCE) == QUEST_STATUS_INCOMPLETE)
    {
        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_G, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        pPlayer->SEND_GOSSIP_MENU(13640, pCreature->GetGUID());
    }

    return true;
}

bool GossipSelect_npc_gymer(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
{
    if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        pPlayer->CastSpell(pPlayer, SPELL_GYMER, true);
    }

    return true;
}

/*####
## npc_gurgthock
####*/

enum eGurgthock
{
    QUEST_AMPHITHEATER_ANGUISH_TUSKARRMAGEDDON   = 12935,

    NPC_ORINOKO_TUSKBREAKER = 30020,

    SAY_QUEST_ACCEPT_TUSKARRMAGEDON = -1571031
};

struct TRINITY_DLL_DECL npc_gurgthockAI : public ScriptedAI
{
    npc_gurgthockAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pOrinoko = NULL;
    }

    Creature* pOrinoko;

    uint32 uiTimer;
    uint32 uiPhase;
    uint32 uiRemoveFlagTimer;
    uint32 uiQuest;

    bool bEventInProgress;
    bool bRemoveFlag;

    void Reset()
    {
        m_creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
        uiTimer = 0;
        uiPhase = 0;
        uiRemoveFlagTimer = 5000;
        bEventInProgress = false;
        bRemoveFlag = false;
    }

    void RemoveSummons()
    {
        if (bEventInProgress)
            bEventInProgress = false;

        m_creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

        if (pOrinoko)
        {
            pOrinoko->RemoveFromWorld();
            pOrinoko = NULL;
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        ScriptedAI::UpdateAI(uiDiff);

        if (bRemoveFlag)
        {
            if (uiRemoveFlagTimer <= uiDiff)
            {
                m_creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                bRemoveFlag = false;
            } else uiRemoveFlagTimer -= uiDiff;
        }

        switch(uiQuest)
        {
            case 1:
                if (!bEventInProgress)
                {
                    bEventInProgress = true;
                    bRemoveFlag = true;
                    DoScriptText(SAY_QUEST_ACCEPT_TUSKARRMAGEDON, m_creature);
                    uiPhase = 1;
                    uiTimer = 4000;
                    uiQuest = 0;
                }
                break;
        }

        if (uiPhase)
        {
            if (uiTimer <= uiDiff)
            {
                switch(uiPhase)
                {
                    case 1:
                        pOrinoko = m_creature->SummonCreature(NPC_ORINOKO_TUSKBREAKER, 5757.765137, -2945.161133, 286.276672, 5.156380, TEMPSUMMON_CORPSE_DESPAWN, 1000);
                        uiPhase = 2;
                        uiTimer = 4000;
                        break;
                     case 2:
                        if (pOrinoko)
                            pOrinoko->GetMotionMaster()->MoveJump(5776.319824, -2981.005371, 273.100037, 10.0f, 20.0f);
                        uiPhase = 0;
                        break;
                }
            } else uiTimer -= uiDiff;
        }
    }

    void SummonedCreatureDespawn(Creature* pSummon)
    {
        if (bEventInProgress)
            bEventInProgress = false;

        m_creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
    }
};

bool QuestAccept_npc_gurgthock(Player* pPlayer, Creature* pCreature, Quest const *pQuest)
{
    switch (pQuest->GetQuestId())
    {
        case QUEST_AMPHITHEATER_ANGUISH_TUSKARRMAGEDDON:
            CAST_AI(npc_gurgthockAI, pCreature->AI())->uiQuest = 1;
            break;
    }
    return false;
}

CreatureAI* GetAI_npc_gurgthock(Creature* pCreature)
{
    return new npc_gurgthockAI(pCreature);
}

/*####
## npc_orinoko_tuskbreaker
####*/

enum eOrinokoTuskbreaker
{
    SPELL_BATTLE_SHOUT      = 32064,
    SPELL_FISHY_SCENT       = 55937,
    SPELL_IMPALE            = 55929,
    SPELL_SUMMON_WHISKER    = 55946,

    NPC_WHISKER             = 30113,
    NPC_HUNGRY_PENGUIN      = 30110,

    SAY_CALL_FOR_HELP       = -1571032
};

struct TRINITY_DLL_DECL npc_orinoko_tuskbreakerAI : public ScriptedAI
{
    npc_orinoko_tuskbreakerAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
        m_creature->SetReactState(REACT_PASSIVE);
        pAffected = NULL;
        pWhisker  = NULL;
    }

    bool bSummoned;
    bool bBattleShout;
    bool bFishyScent;

    uint32 uiBattleShoutTimer;
    uint32 uiFishyScentTimer;

    Unit* pAffected;
    Creature* pWhisker;

    void Reset()
    {
        bSummoned           = false;
        bBattleShout        = false;
        bFishyScent         = false;
        uiBattleShoutTimer  = 0;
        uiFishyScentTimer   = 20000;
    }

    void EnterEvadeMode()
    {
        if (pWhisker)
            pWhisker->RemoveFromWorld();

        if (Unit* pSummoner = CAST_SUM(m_creature)->GetSummoner())
        {
            CAST_AI(npc_gurgthockAI,CAST_CRE(pSummoner)->AI())->bEventInProgress = false;
            CAST_AI(npc_gurgthockAI,CAST_CRE(pSummoner)->AI())->RemoveSummons();
        }
    }

    void MovementInform(uint32 uiType, uint32 uiId)
    {
        if (uiType != POINT_MOTION_TYPE)
            return;

        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
        m_creature->SetReactState(REACT_AGGRESSIVE);
        m_creature->SetHomePosition(m_creature->GetPositionX(),m_creature->GetPositionY(),m_creature->GetPositionZ(), 0);
        uiBattleShoutTimer  = 7000;
    }

    void EnterCombat(Unit* pWho)
    {
        DoCast(pWho, SPELL_IMPALE);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if (!bBattleShout && uiBattleShoutTimer <= uiDiff)
        {
            DoCast(m_creature, SPELL_BATTLE_SHOUT);
            bBattleShout = true;
        } else uiBattleShoutTimer -= uiDiff;

        if (uiFishyScentTimer <= uiDiff)
        {
            if (pAffected = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(pAffected, SPELL_FISHY_SCENT);
            uiFishyScentTimer = 20000;
        } else uiFishyScentTimer -= uiDiff;

        if (!bSummoned && m_creature->GetHealth()*100 / m_creature->GetMaxHealth() <= 50)
        {
            DoScriptText(SAY_CALL_FOR_HELP ,m_creature);
            //DoCast(m_creature->getVictim(), SPELL_SUMMON_WHISKER); petai is not working correctly???
            pWhisker = m_creature->SummonCreature(NPC_WHISKER, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 0);
            bSummoned = true;
        }

        DoMeleeAttackIfReady();
    }

    void JustSummoned(Creature* pSummon)
    {
        switch(pSummon->GetEntry())
        {
            case NPC_WHISKER:
                pSummon->AI()->AttackStart(m_creature->getVictim());
                break;
            case NPC_HUNGRY_PENGUIN:
                if (pAffected && pAffected->isAlive())
                    pSummon->AI()->AttackStart(pAffected);
                break;
        }
    }

    void JustDied(Unit* pKiller)
    {
        if (pWhisker)
            pWhisker->RemoveFromWorld();

        if (pKiller->GetTypeId() == TYPEID_PLAYER)
            CAST_PLR(pKiller)->GroupEventHappens(QUEST_AMPHITHEATER_ANGUISH_TUSKARRMAGEDDON, CAST_PLR(pKiller));

        if (Unit* pSummoner = CAST_SUM(m_creature)->GetSummoner())
            CAST_AI(npc_gurgthockAI,CAST_CRE(pSummoner)->AI())->bEventInProgress = false;
    }
};

CreatureAI* GetAI_npc_orinoko_tuskbreaker(Creature* pCreature)
{
    return new npc_orinoko_tuskbreakerAI(pCreature);
}

void AddSC_zuldrak()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_drakuru_shackles";
    newscript->GetAI = &GetAI_npc_drakuru_shackles;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_captured_rageclaw";
    newscript->GetAI = &GetAI_npc_captured_rageclaw;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_gymer";
    newscript->pGossipHello = &GossipHello_npc_gymer;
    newscript->pGossipSelect = &GossipSelect_npc_gymer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_gurgthock";
    newscript->GetAI = &GetAI_npc_gurgthock;
    newscript->pQuestAccept = &QuestAccept_npc_gurgthock;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_orinoko_tuskbreaker";
    newscript->GetAI = &GetAI_npc_orinoko_tuskbreaker;
    newscript->RegisterSelf();
}
