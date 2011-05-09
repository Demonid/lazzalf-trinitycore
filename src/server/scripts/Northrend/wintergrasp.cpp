#include "ScriptPCH.h"
#include "../OutdoorPvP/OutdoorPvPWG.h"
#include "OutdoorPvPMgr.h"
#include "World.h"

/*******************************************************
 * npc_demolisher_engineerer
 *******************************************************/

class npc_demolisher_engineerer : public CreatureScript
{
    public:
    npc_demolisher_engineerer() : CreatureScript("npc_demolisher_engineerer") { }

    struct npc_demolisher_engineererAI : public PassiveAI
    {
        npc_demolisher_engineererAI(Creature* pCreature) : PassiveAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->AddUnitState(UNIT_STAT_ROOT);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_demolisher_engineererAI (pCreature);
    }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        OutdoorPvPWG *pvpWG = (OutdoorPvPWG*) sOutdoorPvPMgr->GetOutdoorPvPToZoneId(NORTHREND_WINTERGRASP);

        if (!pvpWG)
            return false;

        if (pCreature->isQuestGiver())
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());

        if (pPlayer->isGameMaster() || pCreature->GetZoneScript() && pCreature->GetZoneScript()->GetData(pCreature->GetDBTableGUIDLow()))
        {
            if (pPlayer->HasAura(SPELL_CORPORAL))
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, pvpWG->GetLocaleString(WG_STRING_ENG_GOSSIP_1, sWorld->GetDefaultDbcLocale()), GOSSIP_SENDER_MAIN,   GOSSIP_ACTION_INFO_DEF);
            else if (pPlayer->HasAura(SPELL_LIEUTENANT))
            {
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, pvpWG->GetLocaleString(WG_STRING_ENG_GOSSIP_1, sWorld->GetDefaultDbcLocale()), GOSSIP_SENDER_MAIN,   GOSSIP_ACTION_INFO_DEF);
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, pvpWG->GetLocaleString(WG_STRING_ENG_GOSSIP_2, sWorld->GetDefaultDbcLocale()), GOSSIP_SENDER_MAIN,   GOSSIP_ACTION_INFO_DEF+1);
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, pvpWG->GetLocaleString(WG_STRING_ENG_GOSSIP_3, sWorld->GetDefaultDbcLocale()), GOSSIP_SENDER_MAIN,   GOSSIP_ACTION_INFO_DEF+2);
            }
        }
        else
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, pvpWG->GetLocaleString(WG_STRING_ENG_GOSSIP_4, sWorld->GetDefaultDbcLocale()), GOSSIP_SENDER_MAIN,   GOSSIP_ACTION_INFO_DEF+9);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        pPlayer->CLOSE_GOSSIP_MENU();

        if (pPlayer->isGameMaster() || pCreature->GetZoneScript() && pCreature->GetZoneScript()->GetData(pCreature->GetDBTableGUIDLow()))
        {
            switch(uiAction - GOSSIP_ACTION_INFO_DEF)
            {
                case 0: pPlayer->CastSpell(pPlayer, SPELL_BUILD_CATAPULT, false, NULL, NULL, pCreature->GetGUID()); break;
                case 1: pPlayer->CastSpell(pPlayer, SPELL_BUILD_DEMOLISHER, false, NULL, NULL, pCreature->GetGUID()); break;
                case 2: pPlayer->CastSpell(pPlayer, pPlayer->GetTeamId() ? SPELL_BUILD_SIEGE_ENGINE_H : SPELL_BUILD_SIEGE_ENGINE_A, false, NULL, NULL, pCreature->GetGUID()); break;
            }
        }

        return true;
    }
};

/*******************************************************
 * npc_wg_misc
 *******************************************************/

enum NPC_WG_MISC_SPELLS
{
    SPELL_STRIKE                = 11976,    // WG_CREATURE_GUARD + WG_CREATURE_CHAMPION
    SPELL_SLEEPING_SLEEP        = 42648,    // WG_CREATURE_CHAMPION
    SPELL_ARCANE_MISSILES       = 31743,    // WG_CREATURE_ENHANCEMENT_A
    SPELL_SLOW                  = 31741,    // WG_CREATURE_ENHANCEMENT_A
    SPELL_HEALING_WAVE          = 11986,    // WG_CREATURE_ENHANCEMENT_H
    SPELL_LIGHTNING_BOLT        = 9532,     // WG_CREATURE_ENHANCEMENT_H
    SPELL_QUICK_FLAME_WARD      = 4979,     // WG_CREATURE_ENHANCEMENT_H
    SPELL_MORTAL_STRIKE         = 15708,    // WG_CREATURE_QUESTGIVER_1 + WG_CREATURE_QUESTGIVER_2 + WG_CREATURE_QUESTGIVER_3 + WG_CREATURE_QUESTGIVER_4
    SPELL_HEAL                  = 34945,    // WG_CREATURE_QUESTGIVER_5_A
    SPELL_HOLY_NOVA             = 34944,    // WG_CREATURE_QUESTGIVER_5_A
    SPELL_POWER_WORD_SHIELD     = 17139,    // WG_CREATURE_QUESTGIVER_5_A
    SPELL_CLEAVE                = 15284     // WG_CREATURE_QUESTGIVER_5_H + WG_CREATURE_QUESTGIVER_6
};

enum NPC_WG_MISC_EVENTS
{
    EVENT_STRIKE = 1,
    EVENT_ARCANE_MISSILES,
    EVENT_SLOW,
    EVENT_HEALING_WAVE,
    EVENT_LIGHTNING_BOLT,
    EVENT_QUICK_FLAME_WARD,
    EVENT_MORTAL_STRIKE,
    EVENT_HEAL,
    EVENT_HOLY_NOVA,
    EVENT_CLEAVE
 };

class npc_wg_misc : public CreatureScript
{
    public:
    npc_wg_misc() : CreatureScript("npc_wg_misc") { }

    struct npc_wg_miscAI : public ScriptedAI
    {
        npc_wg_miscAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        EventMap events;
        OutdoorPvPWG *pvpWG;

        void Reset()
        {
            events.Reset();
            pvpWG = (OutdoorPvPWG*) sOutdoorPvPMgr->GetOutdoorPvPToZoneId(NORTHREND_WINTERGRASP);

            switch(me->GetEntry())
            {
                case WG_CREATURE_ENHANCEMENT_A:
                case WG_CREATURE_ENHANCEMENT_H:
                case WG_CREATURE_QUESTGIVER_5_A:
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                    return;
            }

            switch(me->GetEntry())
            {
                case WG_CREATURE_CHAMPION_A:
                case WG_CREATURE_CHAMPION_H:
                    if (pvpWG && !pvpWG->isWarTime())
                        DoCast(me, SPELL_SLEEPING_SLEEP);
                    break;
            }
        }

        void EnterCombat(Unit *who)
        {
            events.ScheduleEvent(EVENT_STRIKE, 5000);
            events.ScheduleEvent(EVENT_ARCANE_MISSILES, 500);
            events.ScheduleEvent(EVENT_SLOW, 100);
            events.ScheduleEvent(EVENT_HEALING_WAVE, 5000);
            events.ScheduleEvent(EVENT_LIGHTNING_BOLT, 500);
            events.ScheduleEvent(EVENT_QUICK_FLAME_WARD, 100);
            events.ScheduleEvent(EVENT_MORTAL_STRIKE, 5000);
            events.ScheduleEvent(EVENT_HEAL, 5000);
            events.ScheduleEvent(EVENT_HOLY_NOVA, 4000);
            events.ScheduleEvent(EVENT_CLEAVE, 5000);

            switch(me->GetEntry())
            {
                case WG_CREATURE_QUESTGIVER_5_A:
                    DoCast(me, SPELL_POWER_WORD_SHIELD);
                    break;
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            events.Update(uiDiff);

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            while(uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_STRIKE:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_GUARD_A:
                            case WG_CREATURE_GUARD_H:
                            case WG_CREATURE_CHAMPION_A:
                            case WG_CREATURE_CHAMPION_H:
                                DoCast(me->getVictim(), SPELL_STRIKE);
                                events.ScheduleEvent(EVENT_STRIKE, 5000);
                                return;
                        }
                    case EVENT_ARCANE_MISSILES:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_ENHANCEMENT_A:
                                DoCast(me->getVictim(), SPELL_ARCANE_MISSILES);
                                events.ScheduleEvent(EVENT_ARCANE_MISSILES, 5000);
                                return;
                        }
                    case EVENT_SLOW:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_ENHANCEMENT_A:
                                DoCast(me->getVictim(), SPELL_SLOW);
                                events.ScheduleEvent(EVENT_SLOW, 15000);
                                return;
                        }
                    case EVENT_HEALING_WAVE:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_ENHANCEMENT_H:
                                if (HealthBelowPct(50))
                                    DoCast(me, SPELL_HEALING_WAVE);
                                events.ScheduleEvent(EVENT_HEALING_WAVE, 3000);
                                return;
                        }
                    case EVENT_LIGHTNING_BOLT:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_ENHANCEMENT_H:
                                DoCast(me->getVictim(), SPELL_LIGHTNING_BOLT);
                                events.ScheduleEvent(EVENT_LIGHTNING_BOLT, 5000);
                                return;
                        }
                    case EVENT_QUICK_FLAME_WARD:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_ENHANCEMENT_H:
                                DoCast(me, SPELL_QUICK_FLAME_WARD);
                                events.ScheduleEvent(EVENT_QUICK_FLAME_WARD, 10000);
                                return;
                        }
                    case EVENT_MORTAL_STRIKE:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_QUESTGIVER_1_A:
                            case WG_CREATURE_QUESTGIVER_1_H:
                            case WG_CREATURE_QUESTGIVER_2_A:
                            case WG_CREATURE_QUESTGIVER_2_H:
                            case WG_CREATURE_QUESTGIVER_3_A:
                            case WG_CREATURE_QUESTGIVER_3_H:
                            case WG_CREATURE_QUESTGIVER_4_A:
                            case WG_CREATURE_QUESTGIVER_4_H:
                                DoCast(me->getVictim(), SPELL_MORTAL_STRIKE);
                                events.ScheduleEvent(EVENT_MORTAL_STRIKE, 10000);
                                return;
                        }
                    case EVENT_HEAL:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_QUESTGIVER_5_A:
                                if (HealthBelowPct(50))
                                    DoCast(me, SPELL_HEAL);
                                events.ScheduleEvent(EVENT_HEAL, 5000);
                                return;
                        }
                    case EVENT_HOLY_NOVA:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_QUESTGIVER_5_A:
                                DoCast(me, SPELL_HOLY_NOVA);
                                events.ScheduleEvent(EVENT_HOLY_NOVA, 8000);
                                return;
                        }
                    case EVENT_CLEAVE:
                        switch(me->GetEntry())
                        {
                            case WG_CREATURE_QUESTGIVER_5_H:
                            case WG_CREATURE_QUESTGIVER_6_A:
                            case WG_CREATURE_QUESTGIVER_6_H:
                                DoCast(me->getVictim(), SPELL_CLEAVE);
                                events.ScheduleEvent(EVENT_CLEAVE, 10000);
                                return;
                        }
                }
            }

            switch(me->GetEntry())
            {
                case WG_CREATURE_ENHANCEMENT_A:
                case WG_CREATURE_ENHANCEMENT_H:
                case WG_CREATURE_QUESTGIVER_5_A:
                    return;
                default:
                    DoMeleeAttackIfReady();
                    return;
            }
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_wg_miscAI (pCreature);
    }
};

/*******************************************************
 * npc_winterguard
 *******************************************************/

class npc_winterguard : public CreatureScript
{
    public:
    npc_winterguard() : CreatureScript("npc_winterguard") { }

    struct npc_winterguardAI : public Scripted_NoMovementAI
    {
        npc_winterguardAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature)
        {
            pCreature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            pCreature->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_NORMAL, true);
            pCreature->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_MAGIC, true);
            
            pvpWG = (OutdoorPvPWG*)sOutdoorPvPMgr->GetOutdoorPvPToZoneId(NORTHREND_WINTERGRASP);
        }

        OutdoorPvPWG *pvpWG;

        void Reset(){}

        void Aggro(Unit* /*pWho*/){}

        void AttackStart(Unit* /*pWho*/){}

        void MoveInLineOfSight(Unit *pWho)
        {
            if (!pWho || !pWho->IsInWorld() || pWho->GetZoneId() != NORTHREND_WINTERGRASP)
                return;

            if (!pvpWG || (pvpWG->isWarTime() == true))
                return;

            if (!me->IsWithinDist(pWho, 40.0f, false))
                return;

            Player *pPlayer = pWho->GetCharmerOrOwnerPlayerOrPlayerItself();

            if (!pPlayer || pPlayer->isGameMaster() || pPlayer->IsBeingTeleported())
                return;

            if ((pPlayer->GetTeam() == ALLIANCE && pvpWG->getDefenderTeamId() != TEAM_ALLIANCE)
                || (pPlayer->GetTeam() == TEAM_HORDE && pvpWG->getDefenderTeamId() != TEAM_HORDE))
                    pPlayer->TeleportTo(571, 5047.93f, 2848.57f, 393, 0);  // Out the Fortress

            return;
        }

        void UpdateAI(const uint32 /*diff*/){}
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_winterguardAI(pCreature);
    }
};


enum eWintergraspBattleMage
{
    SPELL_PORTAL_VISUAL        = 60223,
    GO_WINTERGRASP_PORTAL    = 193772
};

class npc_wg_ally_battle_mage : public CreatureScript
{
public:
    npc_wg_ally_battle_mage() : CreatureScript("npc_wg_ally_battle_mage") { }

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_wg_ally_battle_mageAI(creature);
    }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
            return false;

        if (OutdoorPvPWG *pvpWG = (OutdoorPvPWG*)sOutdoorPvPMgr->GetOutdoorPvPToZoneId(4197))
        {
            if (pvpWG->isWarTime())
            {
                if (pvpWG->getDefenderTeamId() == TEAM_HORDE)
                    pPlayer->SEND_GOSSIP_MENU(14777, pCreature->GetGUID());
                else
                    pPlayer->SEND_GOSSIP_MENU(14781, pCreature->GetGUID());
            }
            else
            {
                if (pvpWG->getDefenderTeamId() == TEAM_HORDE)
                    pPlayer->SEND_GOSSIP_MENU(14775, pCreature->GetGUID());
                else
                    pPlayer->SEND_GOSSIP_MENU(14782, pCreature->GetGUID());
            }
        }
        return true;
    }

    struct npc_wg_ally_battle_mageAI : public ScriptedAI
    {
        npc_wg_ally_battle_mageAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            uiPortalTimer = 0;
            uiPortalPhase = 0;
            Check = true;
        }

        uint32 uiPortalTimer;
        uint8 uiPortalPhase;
        GameObject* WintergraspPortal;
        bool Player;
        bool Check;
        bool Check2;

        void UpdateAI(const uint32 diff)
        {
            // If WG is disabled, don't do anything.
            if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
                return;

            if (OutdoorPvPWG *pvpWG = (OutdoorPvPWG*)sOutdoorPvPMgr->GetOutdoorPvPToZoneId(4197))
            {
                // Get playerlist if there is.
                if (pvpWG->isWarTime() && Check == true)
                {
                    Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (!PlayerList.isEmpty())
                        {
                            if (i->getSource()->GetDistance2d(me) <= 75)
                            {
                                Player = true;
                                Check = false;
                            }
                            else
                            {
                                Player = false;
                                Check = false;
                                Check2 = true;
                            }
                        }
                        else
                        {
                            Player = false;
                            Check = false;
                            Check2 = true;
                        }
                    }
                }

                if (pvpWG->m_changeDefender != true) // If wg is switching (.wg switch)
                {
                    if (pvpWG->isWarTime())
                    {
                        if (Player == true) //(false) If there isn't any player, then, don't cast the portal spell. Just summon gameobject.
                        {
                            if (uiPortalTimer <= diff)
                            {
                                switch (uiPortalPhase)
                                {
                                case 0:
                                    me->SetOrientation(4.037271f);
                                    me->SendMovementFlagUpdate();
                                    ++uiPortalPhase;
                                    uiPortalTimer = 100;
                                    break;
                                case 1:
                                    me->AI()->DoCast(SPELL_PORTAL_VISUAL);
                                    ++uiPortalPhase;
                                    uiPortalTimer = 900;
                                    break;
                                case 2:
                                    WintergraspPortal = me->SummonGameObject(GO_WINTERGRASP_PORTAL, 5686.974609f, 773.303711f, 647.753235f, 5.572729f, 0, 0, 0.324484f, -0.945891f, 0);
                                    me->SetOrientation(5.515240f);
                                    me->SendMovementFlagUpdate();
                                    me->MonsterYell("Reinforcements are needed on the Wintergrasp battlefield! I have opened a portal for quick travel to the battle at The Silver Enclave.", LANG_UNIVERSAL, 0);
                                    ++uiPortalPhase;
                                    uiPortalTimer = 1000;
                                    break;
                                }
                            }else uiPortalTimer -= diff;
                        }
                        else
                        {
                            if (Check2 == true) // If the portal isn't exist
                            {
                                WintergraspPortal = me->SummonGameObject(GO_WINTERGRASP_PORTAL, 5686.974609f, 773.303711f, 647.753235f, 5.572729f, 0, 0, 0.324484f, -0.945891f, 0);
                                Check2 = false;
                            }
                        }
                    }
                    else
                    {
                        if (pvpWG->getDefenderTeamId() == TEAM_ALLIANCE)
                        {
                            if (pvpWG->m_timer <= 3600000) // An hour before battle begin, the portal will disappear.
                            {
                                uiPortalTimer = 0;
                                uiPortalPhase = 0;
                                Check = true;
                                Check2 = false;
                                if (GameObject* WintergraspPortal = me->FindNearestGameObject(GO_WINTERGRASP_PORTAL, 5.0f)) // If the portal is exist
                                    WintergraspPortal->RemoveFromWorld();
                            }
                        }
                        else
                        {
                            uiPortalTimer = 0;
                            uiPortalPhase = 0;
                            Check = true;
                            Check2 = false;
                            if (GameObject* WintergraspPortal = me->FindNearestGameObject(GO_WINTERGRASP_PORTAL, 5.0f)) // If the portal is exist
                                WintergraspPortal->RemoveFromWorld();
                        }
                    }
                }
            }
        }
    };
};

class npc_wg_horde_battle_mage : public CreatureScript
{
public:
    npc_wg_horde_battle_mage() : CreatureScript("npc_wg_horde_battle_mage") { }

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_wg_horde_battle_mageAI(creature);
    }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
            return false;

        if (OutdoorPvPWG *pvpWG = (OutdoorPvPWG*)sOutdoorPvPMgr->GetOutdoorPvPToZoneId(4197))
        {
            if (pvpWG->isWarTime())
            {
                if (pvpWG->getDefenderTeamId() == TEAM_HORDE)
                    pPlayer->SEND_GOSSIP_MENU(14777, pCreature->GetGUID());
                else
                    pPlayer->SEND_GOSSIP_MENU(14781, pCreature->GetGUID());
            }
            else
            {
                if (pvpWG->getDefenderTeamId() == TEAM_HORDE)
                    pPlayer->SEND_GOSSIP_MENU(14775, pCreature->GetGUID());
                else
                    pPlayer->SEND_GOSSIP_MENU(14782, pCreature->GetGUID());
            }
        }
        return true;
    }

    struct npc_wg_horde_battle_mageAI : public ScriptedAI
    {
        npc_wg_horde_battle_mageAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            uiPortalTimer = 0;
            uiPortalPhase = 0;
            Check = true;
        }

        uint32 uiPortalTimer;
        uint8 uiPortalPhase;
        GameObject* WintergraspPortal;
        bool Player;
        bool Check;
        bool Check2;

        void UpdateAI(const uint32 diff)
        {
            // If WG is disabled, don't do anything.
            if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
                return;

            if (OutdoorPvPWG *pvpWG = (OutdoorPvPWG*)sOutdoorPvPMgr->GetOutdoorPvPToZoneId(4197))
            {
                // Get playerlist if there is.
                if (pvpWG->isWarTime() && Check == true)
                {
                    Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (!PlayerList.isEmpty())
                        {
                            if (i->getSource()->GetDistance2d(me) <= 75)
                            {
                                Player = true;
                                Check = false;
                            }
                            else
                            {
                                Player = false;
                                Check = false;
                                Check2 = true;
                            }
                        }
                        else
                        {
                            Player = false;
                            Check = false;
                            Check2 = true;
                        }
                    }
                }

                if (pvpWG->m_changeDefender != true) // If wg is switching (.wg switch)
                {
                    if (pvpWG->isWarTime())
                    {
                        if (Player == true) //(false) If there isn't any player, then, don't cast the portal spell. Just summon gameobject.
                        {
                            if (uiPortalTimer <= diff)
                            {
                                switch (uiPortalPhase)
                                {
                                case 0:
                                    me->SetOrientation(4.356160f);
                                    me->SendMovementFlagUpdate();
                                    ++uiPortalPhase;
                                    uiPortalTimer = 100;
                                    break;
                                case 1:
                                    me->AI()->DoCast(SPELL_PORTAL_VISUAL);
                                    ++uiPortalPhase;
                                    uiPortalTimer = 900;
                                    break;
                                case 2:
                                    WintergraspPortal = me->SummonGameObject(GO_WINTERGRASP_PORTAL, 5924.042969f, 570.354492f, 661.087280f, 5.930885f, 0, 0, 0.324484f, -0.945891f, 0);
                                    me->SetOrientation(6.003930f);
                                    me->SendMovementFlagUpdate();
                                    ++uiPortalPhase;
                                    uiPortalTimer = 1000;
                                    break;
                                }
                            }else uiPortalTimer -= diff;
                        }
                        else
                        {
                            if (Check2 == true) // If the portal isn't exist
                            {
                                WintergraspPortal = me->SummonGameObject(GO_WINTERGRASP_PORTAL, 5686.974609f, 773.303711f, 647.753235f, 5.572729f, 0, 0, 0.324484f, -0.945891f, 0);
                                Check2 = false;
                            }
                        }
                    }
                    else
                    {
                        if (pvpWG->getDefenderTeamId() == TEAM_HORDE)
                        {
                            if (pvpWG->m_timer <= 3600000) // An hour before battle begin, the portal will disappear.
                            {
                                uiPortalTimer = 0;
                                uiPortalPhase = 0;
                                Check = true;
                                Check2 = false;
                                if (GameObject* WintergraspPortal = me->FindNearestGameObject(GO_WINTERGRASP_PORTAL, 5.0f)) // If the portal is exist
                                    WintergraspPortal->RemoveFromWorld();
                            }
                        }
                        else
                        {
                            uiPortalTimer = 0;
                            uiPortalPhase = 0;
                            Check = true;
                            Check2 = false;
                            if (GameObject* WintergraspPortal = me->FindNearestGameObject(GO_WINTERGRASP_PORTAL, 5.0f)) // If the portal is exist
                                WintergraspPortal->RemoveFromWorld();
                        }
                    }
                }
            }
        }
    };
};

class go_wg_veh_teleporter : public GameObjectScript
{
public:
    go_wg_veh_teleporter() : GameObjectScript("go_wg_veh_teleporter") { }

    bool OnGossipHello(Player *pPlayer, GameObject * pGO)
    {
        if (GameObject* trigger = pGO->FindNearestGameObject(190375, 500)) // Wintergrasp Fortress Gate
            if (Vehicle * veh = pPlayer->GetVehicle())
            {
                Position triggerPos;
                trigger->GetPosition(&triggerPos);
                triggerPos.m_positionX -= 30;
                veh->Relocate(triggerPos);
            }
        
        return true;
    }
};

/* Wintergrasp Battle-Mage */
/*
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry` in (32169, 32170);
DELETE FROM `npc_text` WHERE ID In (14775, 14777, 14781, 14782);
UPDATE `creature` SET `position_x`=5925.341309, `position_y`=573.709961, `position_z`=661.087280 WHERE `id`=32170;
UPDATE `creature_template` SET `ScriptName`='npc_wg_ally_battle_mage' WHERE `entry`=32169;
UPDATE `creature_template` SET `ScriptName`='npc_wg_horde_battle_mage' WHERE `entry`=32170;
UPDATE `trinity_string` SET `content_default`='Before the Battle of  Wintergrasp left 10 minutes!' WHERE `entry`=781;
DELETE FROM `spell_target_position` WHERE id IN (58633, 58632, 59096);
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES 
(58632, 571, 5095.104980, 2170.985840, 365.603210, 2.367906),
(58633, 571, 5025.775879, 3673.123779, 362.671295, 4.197887),
(59096, 571, 5324.776367, 2841.025391, 406.280334, 3.143867);
*/
void AddSC_wintergrasp()
{
    new npc_demolisher_engineerer();
    new npc_wg_misc();
    new npc_winterguard();
    new npc_wg_ally_battle_mage();
    new npc_wg_horde_battle_mage();
    new go_wg_veh_teleporter();
}
