/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: trial_of_the_crusader
SD%Complete: ??%
SDComment: based on /dev/rsa
SDCategory: Crusader Coliseum
EndScriptData */

// Known bugs:
//    - They should be floating but they aren't respecting the floor =(
//    - Lacks the powering up effect that leads to Empowering
//    - There's a workaround for the shared life effect

#include "ScriptPCH.h"
#include "trial_of_the_crusader.h"

enum Yells
{
    SAY_AGGRO           = -1649040,
    SAY_DEATH           = -1649041,
    SAY_BERSERK         = -1649042,
    EMOTE_SHIELD        = -1649043,
    SAY_SHIELD          = -1649044,
    SAY_KILL1           = -1649045,
    SAY_KILL2           = -1649046,
    EMOTE_LIGHT_VORTEX  = -1649047,
    SAY_LIGHT_VORTEX    = -1649048,
    EMOTE_DARK_VORTEX   = -1649049,
    SAY_DARK_VORTEX     = -1649050,
};

enum Equipment
{
    EQUIP_MAIN_1         = 49303,
    EQUIP_OFFHAND_1      = 47146,
    EQUIP_RANGED_1       = 47267,
    EQUIP_MAIN_2         = 45990,
    EQUIP_OFFHAND_2      = 47470,
    EQUIP_RANGED_2       = 47267,
    EQUIP_DONE           = EQUIP_NO_CHANGE,
};

enum Summons
{
    NPC_DARK_ESSENCE     = 34567,
    NPC_LIGHT_ESSENCE    = 34568,

    NPC_UNLEASHED_DARK   = 34628,
    NPC_UNLEASHED_LIGHT  = 34630,
};

enum BossSpells
{
    // LIGHT
    LIGHT_TWIN_SPIKE_10N        = 66075,
    LIGHT_TWIN_SPIKE_10H        = 67313,
    LIGHT_TWIN_SPIKE_25N        = 67312,
    LIGHT_TWIN_SPIKE_25H        = 67314,

    SURGE_OF_LIGHT_10N          = 65766,
    SURGE_OF_LIGHT_10H          = 67271,
    SURGE_OF_LIGHT_25N          = 67270,
    SURGE_OF_LIGHT_25H          = 67272,

    LIGHT_SHIELD_10N            = 65858,
    LIGHT_SHIELD_10H            = 67260,
    LIGHT_SHIELD_25N            = 67259,
    LIGHT_SHIELD_25H            = 67261,

    LIGHT_TWINS_PACT_10N        = 65876,
    LIGHT_TWINS_PACT_10H        = 67307,
    LIGHT_TWINS_PACT_25N        = 67306,
    LIGHT_TWINS_PACT_25H        = 67308,

    LIGHT_VORTEX_10N            = 66046,
    LIGHT_VORTEX_10H            = 67207,
    LIGHT_VORTEX_25N            = 67206,
    LIGHT_VORTEX_25H            = 67208,

    TOUCH_OF_LIGHT_10           = 67297, //only heroic
    TOUCH_OF_LIGHT_25           = 67298,

    DARK_TWIN_SPIKE_10N         = 66069,
    DARK_TWIN_SPIKE_10H         = 67310,
    DARK_TWIN_SPIKE_25N         = 67309,
    DARK_TWIN_SPIKE_25H         = 67311,

    SURGE_OF_DARKNESS_10N       = 65768,
    SURGE_OF_DARKNESS_10H       = 67263,
    SURGE_OF_DARKNESS_25N       = 67262,
    SURGE_OF_DARKNESS_25H       = 67264,

    // DARK
    DARK_SHIELD_10N             = 65874,
    DARK_SHIELD_10H             = 67257,
    DARK_SHIELD_25N             = 67256,
    DARK_SHIELD_25H             = 67258,

    DARK_TWINS_PACT_10N         = 65875,
    DARK_TWINS_PACT_10H         = 67304,
    DARK_TWINS_PACT_25N         = 67303,
    DARK_TWINS_PACT_25H         = 67305,

    DARK_VORTEX_10N             = 66058,
    DARK_VORTEX_10H             = 67183,
    DARK_VORTEX_25N             = 67182,
    DARK_VORTEX_25H             = 67184,

    TOUCH_OF_DARKNESS_10        = 67282, //only heroic
    TOUCH_OF_DARKNESS_25        = 67283,

    POWER_OF_TWINS_10N          = 65879,
    POWER_OF_TWINS_10H          = 67245,
    POWER_OF_TWINS_25N          = 67244,
    POWER_OF_TWINS_25H          = 67246,

    SPELL_TWIN_POWER            = 65916,
    SPELL_BERSERK               = 64238,
    SPELL_NONE                  = 0,

    SPELL_EMPOWERED_DARK        = 67215,
    SPELL_EMPOWERED_LIGHT       = 67218,

    SPELL_UNLEASHED_DARK        = 65808,
    SPELL_UNLEASHED_LIGHT       = 65795,

    SPELL_POWERING_UP_1         = 67590,
    SPELL_POWERING_UP_2         = 67602,
    SPELL_POWERING_UP_3         = 67603,
    SPELL_POWERING_UP_4         = 67604,
};

enum Actions
{
    ACTION_VORTEX,
    ACTION_PACT
};

#define SPELL_LIGHT_ESSENCE        65686 //RAID_MODE(65686,67222,67223,67224)
#define SPELL_DARK_ESSENCE         65684 //RAID_MODE(65684,67176,67177,67178)
#define SPELL_LIGHT_ESSENCE_25     67222
#define SPELL_DARK_ESSENCE_25      67176
#define SPELL_LIGHT_ESSENCE_10H    67223
#define SPELL_DARK_ESSENCE_10H     67177
#define SPELL_LIGHT_ESSENCE_25H    67224
#define SPELL_DARK_ESSENCE_25H     67178

#define ACHIEVEMENT_SALT_AND_PEPPER RAID_MODE(3799, 3815, 3799, 3815)
#define SALT_AND_PEPPER_MAX_TIMER 3 * MINUTE * IN_MILLISECONDS

/*######
## boss_twin_base
######*/

struct boss_twin_baseAI : public ScriptedAI
{
    boss_twin_baseAI(Creature* creature) : ScriptedAI(creature), Summons(me)
    {
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
        me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
        m_pInstance = (InstanceScript*)creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;
    SummonList Summons;

    uint8  m_uiStage;
    bool   m_bIsBerserk;
    // bool   m_Immune;
    uint8  m_uiWaveCount;
    uint32 m_uiColorballsTimer;
    uint32 m_uiSpecialAbilityTimer;
    uint32 m_uiSpikeTimer;
    uint32 m_uiTouchTimer;
    uint32 m_uiBerserkTimer;
    uint32 m_uiImmuneTimer;

    int32 m_uiVortexSay;
    int32 m_uiVortexEmote;
    uint32 m_uiSisterNpcId;
    uint32 m_uiColorballNpcId;
    uint32 m_uiEssenceNpcId;
    uint32 m_uiMyEssenceSpellId;
    uint32 m_uiOtherEssenceSpellId;
    uint32 m_uiEmpoweredWeaknessSpellId;
    uint32 m_uiSurgeSpellId;
    uint32 m_uiVortexSpellId;
    uint32 m_uiShieldSpellId;
    uint32 m_uiTwinPactSpellId;
    uint32 m_uiSpikeSpellId;
    uint32 m_uiTouchSpellId;

    Position HomeLocation;
    Position EssenceLocation[2];

    void Reset() 
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        me->SetReactState(REACT_PASSIVE);
        /* Uncomment this once that they are flying above the ground
        me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
        me->SetFlying(true); */
        m_bIsBerserk = false;
        // m_Immune = false;
        m_uiImmuneTimer = 0;

        m_uiWaveCount = 1;
        m_uiColorballsTimer = 15*IN_MILLISECONDS;
        m_uiSpecialAbilityTimer = urand(45,50)*IN_MILLISECONDS;
        m_uiSpikeTimer = 20*IN_MILLISECONDS;
        m_uiTouchTimer = urand(10, 15)*IN_MILLISECONDS;
        m_uiBerserkTimer = IsHeroic() ? 6*MINUTE*IN_MILLISECONDS : 10*MINUTE*IN_MILLISECONDS;

        Summons.DespawnAll();
    }

    void JustReachedHome()
    {
        if (m_pInstance)
        {
            m_pInstance->SetData(TYPE_VALKIRIES, FAIL);
            m_pInstance->SetData(DATA_HEALTH_TWIN_SHARED, me->GetMaxHealth());
        }
        me->DespawnOrUnsummon();
    }

    void MovementInform(uint32 uiType, uint32 uiId)
    {
        if (uiType != POINT_MOTION_TYPE) return;

        switch (uiId)
        {
            case 0:
                me->GetMotionMaster()->MovePoint(1, HomeLocation.GetPositionX(), HomeLocation.GetPositionY(), HomeLocation.GetPositionZ());
                me->SetHomePosition(HomeLocation);
                break;
            case 1:
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetInCombatWithZone();
                break;
        }
    }

    void KilledUnit(Unit* pWho)
    {
        if (pWho->GetTypeId() == TYPEID_PLAYER)
        {
            DoScriptText(urand(0, 1) ? SAY_KILL1 : SAY_KILL2, me);
            if (m_pInstance)
                m_pInstance->SetData(DATA_TRIBUTE_TO_IMMORTALITY_ELEGIBLE, CRITERIA_NOT_MEETED);
        }
    }

    void JustSummoned(Creature* pSummoned)
    {
        switch (pSummoned->GetEntry())
        {
            case NPC_UNLEASHED_DARK:
            case NPC_UNLEASHED_LIGHT:
                pSummoned->SetCorpseDelay(0);
                break;
        }
        Summons.Summon(pSummoned);
    }

    void SummonedCreatureDespawn(Creature* pSummoned)
    {
        switch (pSummoned->GetEntry())
        {
            case NPC_LIGHT_ESSENCE:
            case NPC_DARK_ESSENCE:
                Map* pMap = me->GetMap();
                Map::PlayerList const &lPlayers = pMap->GetPlayers();
                for (Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
                {
                    Unit* pPlayer = itr->getSource();
                    if (!pPlayer) 
                        continue;
                    if (pPlayer->isAlive())
                    {
                        if (pSummoned->GetEntry() == NPC_LIGHT_ESSENCE)
                        {
                            pPlayer->RemoveAurasDueToSpell(65686);
                            pPlayer->RemoveAurasDueToSpell(67222);
                            pPlayer->RemoveAurasDueToSpell(67223);
                            pPlayer->RemoveAurasDueToSpell(67224);
                        }
                        if (pSummoned->GetEntry() == NPC_DARK_ESSENCE)
                        {
                            pPlayer->RemoveAurasDueToSpell(65684);
                            pPlayer->RemoveAurasDueToSpell(67176);
                            pPlayer->RemoveAurasDueToSpell(67177);
                            pPlayer->RemoveAurasDueToSpell(67178);
                        }
                    }
                }
                break;
        }
        Summons.Despawn(pSummoned);
    }

    void DamageTaken(Unit* pDoneBy, uint32 &uiDamage)
    {
        if (!me || !me->isAlive())
            return;

        if (pDoneBy->GetGUID() == me->GetGUID())
            return;

        if (pDoneBy->GetTypeId() == TYPEID_PLAYER)
        {
            if (pDoneBy->HasAura(m_uiOtherEssenceSpellId))
                uiDamage += uiDamage/2;
            if (pDoneBy->HasAura(m_uiEmpoweredWeaknessSpellId))
                uiDamage += uiDamage;
            else
                if (pDoneBy->HasAura(m_uiMyEssenceSpellId))
                    uiDamage /= 2;
        }

        if (m_pInstance)
            m_pInstance->SetData(DATA_HEALTH_TWIN_SHARED, me->GetHealth() >= uiDamage ? me->GetHealth() - uiDamage : 0);
    }

    void SpellHit(Unit* caster, const SpellInfo* spell)
    {
        if (caster->ToCreature() == me)
            if (spell->Effects[0].Effect == 136) //Effect Heal
                if (m_pInstance)
                    m_pInstance->SetData(DATA_HEALTH_TWIN_SHARED, me->GetHealth() + me->CountPctFromMaxHealth(spell->Effects[EFFECT_0].CalcValue()));
    }

    void SummonColorballs(uint8 quantity)
    {
        float x0 = ToCCommonLoc[1].GetPositionX(), y0 = ToCCommonLoc[1].GetPositionY(), r = 47.0f;
        float y = y0;
        for (uint8 i = 0; i < quantity; i++)
        {
            float x = float(urand(uint32(x0 - r), uint32(x0 + r)));
            if (urand(0, 1))
                y = y0 + sqrt(pow(r, 2) - pow((x-x0), 2));
            else
                y = y0 - sqrt(pow(r, 2) - pow((x-x0), 2));
            me->SummonCreature(m_uiColorballNpcId, x, y, me->GetPositionZ(), TEMPSUMMON_CORPSE_DESPAWN);
        }
    }

    void JustDied(Unit* /*killer*/)
    {
        DoScriptText(SAY_DEATH, me);
        if (m_pInstance)
        {
            m_pInstance->SetData(DATA_HEALTH_TWIN_SHARED, 0);
            if (Creature* pSister = GetSister())
            {
                if (!pSister->isAlive())
                {
                    m_pInstance->SetData(TYPE_VALKIRIES, DONE);
                    Summons.DespawnAll();
                }
                else 
                {
                    m_pInstance->SetData(TYPE_VALKIRIES, SPECIAL);
                    me->Kill(pSister);
                }                    
            }
        }
        Summons.DespawnAll();
    }

    // Called when sister pointer needed
    Creature* GetSister()
    {
        return Unit::GetCreature((*me), m_pInstance->GetData64(m_uiSisterNpcId));
    }

    void EnterCombat(Unit* /*pWho*/)
    {
        me->SetInCombatWithZone();
        if (m_pInstance)
        {
            m_pInstance->SetData(TYPE_VALKIRIES, IN_PROGRESS);
            m_pInstance->SetData(DATA_HEALTH_TWIN_SHARED, me->GetMaxHealth());
        }
        if (me->isAlive())
        {
            me->SummonCreature(m_uiEssenceNpcId, EssenceLocation[0].GetPositionX(), EssenceLocation[0].GetPositionY(), EssenceLocation[0].GetPositionZ());
            me->SummonCreature(m_uiEssenceNpcId, EssenceLocation[1].GetPositionX(), EssenceLocation[1].GetPositionY(), EssenceLocation[1].GetPositionZ());
        }
        DoScriptText(SAY_AGGRO, me);
        DoCast(me, m_uiSurgeSpellId);
    }

    void DoAction(const int32 action)
    {
        switch (action)
        {
            case ACTION_VORTEX:
                m_uiStage = me->GetEntry() == NPC_LIGHTBANE ? 2 : 1;
                break;
            case ACTION_PACT:
                m_uiStage = me->GetEntry() == NPC_LIGHTBANE ? 1 : 2;
                DoCast(me, SPELL_TWIN_POWER);
                break;
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_pInstance || !UpdateVictim())
            return;

        /*
        if (m_uiImmuneTimer)
        {
            if (m_uiImmuneTimer <= uiDiff)
            {
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
                me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_INTERRUPT, false);
                m_uiImmuneTimer = 0;
            }
            else
                m_uiImmuneTimer -= uiDiff;
        }*/

        if (m_pInstance->GetData(DATA_HEALTH_TWIN_SHARED) != 0)
            me->SetHealth(m_pInstance->GetData(DATA_HEALTH_TWIN_SHARED));
        else
            me->SetHealth(1);

        if (me->HasUnitState(UNIT_STAT_CASTING))
            return;

        switch (m_uiStage)
        {
            case 0:
                break;
            case 1: // Vortex
                if (m_uiSpecialAbilityTimer <= uiDiff)
                {
                    //m_uiImmuneTimer = 5000;
                    //me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                    //me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_INTERRUPT, true);
                    if (Creature* pSister = GetSister())
                        pSister->AI()->DoAction(ACTION_VORTEX);
                    DoScriptText(m_uiVortexEmote, me);
                    DoScriptText(m_uiVortexSay, me);                    
                    DoCastAOE(m_uiVortexSpellId);
                    m_uiStage = 0;
                    m_uiSpecialAbilityTimer = urand(45,50)*IN_MILLISECONDS;
                }
                else
                    m_uiSpecialAbilityTimer -= uiDiff;
                break;
            case 2: // Shield+Pact
                if (m_uiSpecialAbilityTimer <= uiDiff)
                {
                    // m_Immune = true;
                    if (Creature* pSister = GetSister())
                        pSister->AI()->DoAction(ACTION_PACT);
                    DoScriptText(EMOTE_SHIELD, me);
                    DoScriptText(SAY_SHIELD, me);
                    DoCast(me, m_uiShieldSpellId);
                    DoCast(me, m_uiTwinPactSpellId);
                    m_uiStage = 0;
                    m_uiSpecialAbilityTimer = urand(45,50)*IN_MILLISECONDS;
                }
                else
                    m_uiSpecialAbilityTimer -= uiDiff;
                break;
            default:
                break;
        }

        if (m_uiSpikeTimer <= uiDiff)
        {
            DoCastVictim(m_uiSpikeSpellId);
            m_uiSpikeTimer = 20*IN_MILLISECONDS;
        }
        else
            m_uiSpikeTimer -= uiDiff;

        if (IsHeroic() && m_uiTouchTimer <= uiDiff)
        {
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 200, true, m_uiOtherEssenceSpellId))
                me->CastCustomSpell(m_uiTouchSpellId, SPELLVALUE_MAX_TARGETS, 1, target, false);
            m_uiTouchTimer = urand(10, 15)*IN_MILLISECONDS;
        }
        else
            m_uiTouchTimer -= uiDiff;

        if (m_uiColorballsTimer <= uiDiff)
        {
            if (m_uiWaveCount >= 2)
            {
                SummonColorballs(12);
                m_uiWaveCount = 0;
            }
            else
            {
                SummonColorballs(2);
                m_uiWaveCount++;
            }
            m_uiColorballsTimer = 15*IN_MILLISECONDS;
        }
        else
            m_uiColorballsTimer -= uiDiff;

        if (!m_bIsBerserk && m_uiBerserkTimer <= uiDiff)
        {
            DoCast(me, SPELL_BERSERK);
            DoScriptText(SAY_BERSERK, me);
            m_bIsBerserk = true;
        }
        else
            m_uiBerserkTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

/*######
## boss_fjola
######*/

class boss_fjola : public CreatureScript
{
public:
    boss_fjola() : CreatureScript("boss_fjola") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_fjolaAI(creature);
    }

    struct boss_fjolaAI : public boss_twin_baseAI
    {
        boss_fjolaAI(Creature* creature) : boss_twin_baseAI(creature) 
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);     
        }

        uint32 saltAndPepperTimer;

        void Reset() 
        {
            boss_twin_baseAI::Reset();
            SetEquipmentSlots(false, EQUIP_MAIN_1, EQUIP_OFFHAND_1, EQUIP_RANGED_1);
            m_uiStage = 0;
            m_uiVortexEmote = EMOTE_LIGHT_VORTEX;
            m_uiVortexSay = SAY_LIGHT_VORTEX;
            m_uiSisterNpcId = NPC_DARKBANE;
            m_uiColorballNpcId = NPC_UNLEASHED_LIGHT;
            m_uiEssenceNpcId = NPC_LIGHT_ESSENCE;
            m_uiMyEssenceSpellId = RAID_MODE(SPELL_LIGHT_ESSENCE,SPELL_LIGHT_ESSENCE_25,SPELL_LIGHT_ESSENCE_10H,SPELL_LIGHT_ESSENCE_25H);
            m_uiOtherEssenceSpellId = RAID_MODE(SPELL_DARK_ESSENCE,SPELL_DARK_ESSENCE_25,SPELL_DARK_ESSENCE_10H,SPELL_DARK_ESSENCE_25H);
            m_uiEmpoweredWeaknessSpellId = SPELL_EMPOWERED_DARK;
            m_uiSurgeSpellId = RAID_MODE(SURGE_OF_LIGHT_10N, SURGE_OF_LIGHT_25N, SURGE_OF_LIGHT_10H, SURGE_OF_LIGHT_25H);
            m_uiVortexSpellId = RAID_MODE(LIGHT_VORTEX_10N, LIGHT_VORTEX_25N, LIGHT_VORTEX_10H, LIGHT_VORTEX_25H);
            m_uiShieldSpellId = RAID_MODE(LIGHT_SHIELD_10N, LIGHT_SHIELD_25N, LIGHT_SHIELD_10H, LIGHT_SHIELD_25H);
            m_uiTwinPactSpellId = RAID_MODE(LIGHT_TWINS_PACT_10N, LIGHT_TWINS_PACT_25N, LIGHT_TWINS_PACT_10H, LIGHT_TWINS_PACT_25H);
            m_uiTouchSpellId = RAID_MODE(TOUCH_OF_LIGHT_10, TOUCH_OF_LIGHT_25, TOUCH_OF_LIGHT_10, TOUCH_OF_LIGHT_25);
            m_uiSpikeSpellId = RAID_MODE(LIGHT_TWIN_SPIKE_10N, LIGHT_TWIN_SPIKE_25N, LIGHT_TWIN_SPIKE_10H, LIGHT_TWIN_SPIKE_25H);

            HomeLocation = ToCCommonLoc[8];
            EssenceLocation[0] = TwinValkyrsLoc[2];
            EssenceLocation[1] = TwinValkyrsLoc[3];

            saltAndPepperTimer = 0;

            /*if (m_pInstance)
            {
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT,  EVENT_START_TWINS_FIGHT);
            }*/
        }

        void EnterCombat(Unit* pWho)
        {
            saltAndPepperTimer = 0;
            boss_twin_baseAI::EnterCombat(pWho);
            /*if (m_pInstance)
            {
                m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT,  EVENT_START_TWINS_FIGHT);
            }*/
        }

        void JustDied(Unit* killer)
        {
            if (saltAndPepperTimer <= SALT_AND_PEPPER_MAX_TIMER)
                m_pInstance->DoCompleteAchievement(ACHIEVEMENT_SALT_AND_PEPPER);

            Map::PlayerList const &players = m_pInstance->instance->GetPlayers();
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                Player* player = itr->getSource();
                if (!player)
                    continue;
                player->KilledMonsterCredit(34496, 0);
            }
            
            boss_twin_baseAI::JustDied(killer);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            saltAndPepperTimer += uiDiff;
            boss_twin_baseAI::UpdateAI(uiDiff);
        }
    };

};

/*######
## boss_eydis
######*/

class boss_eydis : public CreatureScript
{
public:
    boss_eydis() : CreatureScript("boss_eydis") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_eydisAI(creature);
    }

    struct boss_eydisAI : public boss_twin_baseAI
    {
        boss_eydisAI(Creature* creature) : boss_twin_baseAI(creature) {}

        void Reset() 
        {
            boss_twin_baseAI::Reset();
            SetEquipmentSlots(false, EQUIP_MAIN_2, EQUIP_OFFHAND_2, EQUIP_RANGED_2);
            m_uiStage = 1;
            m_uiVortexEmote = EMOTE_DARK_VORTEX;
            m_uiVortexSay = SAY_DARK_VORTEX;
            m_uiSisterNpcId = NPC_LIGHTBANE;
            m_uiColorballNpcId = NPC_UNLEASHED_DARK;
            m_uiEssenceNpcId = NPC_DARK_ESSENCE;
            m_uiMyEssenceSpellId = RAID_MODE(SPELL_DARK_ESSENCE, SPELL_DARK_ESSENCE_25, SPELL_DARK_ESSENCE_10H, SPELL_DARK_ESSENCE_25H);
            m_uiOtherEssenceSpellId = RAID_MODE(SPELL_LIGHT_ESSENCE, SPELL_LIGHT_ESSENCE_25, SPELL_LIGHT_ESSENCE_10H, SPELL_LIGHT_ESSENCE_25H);
            m_uiEmpoweredWeaknessSpellId = SPELL_EMPOWERED_LIGHT;
            m_uiSurgeSpellId = RAID_MODE(SURGE_OF_DARKNESS_10N, SURGE_OF_DARKNESS_25N, SURGE_OF_DARKNESS_10H, SURGE_OF_DARKNESS_25H);
            m_uiVortexSpellId = RAID_MODE(DARK_VORTEX_10N, DARK_VORTEX_25N, DARK_VORTEX_10H, DARK_VORTEX_25H);
            m_uiShieldSpellId = RAID_MODE(DARK_SHIELD_10N, DARK_SHIELD_25N, DARK_SHIELD_10H, DARK_SHIELD_25H);
            m_uiTwinPactSpellId = RAID_MODE(DARK_TWINS_PACT_10N, DARK_TWINS_PACT_25N, DARK_TWINS_PACT_10H, DARK_TWINS_PACT_25H);
            m_uiTouchSpellId = RAID_MODE(TOUCH_OF_DARKNESS_10, TOUCH_OF_DARKNESS_25, TOUCH_OF_DARKNESS_10, TOUCH_OF_DARKNESS_25);
            m_uiSpikeSpellId = RAID_MODE(DARK_TWIN_SPIKE_10N, DARK_TWIN_SPIKE_25N, DARK_TWIN_SPIKE_10H, DARK_TWIN_SPIKE_25H);

            HomeLocation = ToCCommonLoc[9];
            EssenceLocation[0] = TwinValkyrsLoc[0];
            EssenceLocation[1] = TwinValkyrsLoc[1];
        }

        void JustDied(Unit* killer)
        {
            Map::PlayerList const &players = m_pInstance->instance->GetPlayers();
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                Player* player = itr->getSource();
                if (!player)
                    continue;
                player->KilledMonsterCredit(34497, 0);
            }

            boss_twin_baseAI::JustDied(killer);
        }
    };

};

class mob_essence_of_twin : public CreatureScript
{
public:
    mob_essence_of_twin() : CreatureScript("mob_essence_of_twin") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        switch (creature->GetEntry())
        {
            case NPC_LIGHT_ESSENCE:
                player->RemoveAurasDueToSpell(65684);
                player->RemoveAurasDueToSpell(67176);
                player->RemoveAurasDueToSpell(67177);
                player->RemoveAurasDueToSpell(67178);
                player->CastSpell(player, SPELL_LIGHT_ESSENCE, true);
                break;
            case NPC_DARK_ESSENCE:                
                player->RemoveAurasDueToSpell(65686);
                player->RemoveAurasDueToSpell(67222);
                player->RemoveAurasDueToSpell(67223);
                player->RemoveAurasDueToSpell(67224);
                player->CastSpell(player, SPELL_DARK_ESSENCE, true);
                break;
            default:
                break;
        }
        player->CLOSE_GOSSIP_MENU();
        return true;
    }
};

struct mob_unleashed_ballAI : public ScriptedAI
{
    mob_unleashed_ballAI(Creature* creature) : ScriptedAI(creature)
    {
        m_pInstance = (InstanceScript*)creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;
    uint32 m_uiRangeCheckTimer;

    void MoveToNextPoint()
    {
        float x0 = ToCCommonLoc[1].GetPositionX(), y0 = ToCCommonLoc[1].GetPositionY(), r = 47.0f;
        float y = y0;
        float x = float(urand(uint32(x0 - r), uint32(x0 + r)));
        if (urand(0, 1))
            y = y0 + sqrt(pow(r, 2) - pow((x-x0), 2));
        else
            y = y0 - sqrt(pow(r, 2) - pow((x-x0), 2));
        me->GetMotionMaster()->MovePoint(0, x, y, me->GetPositionZ());
    }

    void Reset()
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        me->SetReactState(REACT_PASSIVE);
        me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
        me->SetFlying(true);
        SetCombatMovement(false);
        MoveToNextPoint();
        m_uiRangeCheckTimer = IN_MILLISECONDS;
    }

    void MovementInform(uint32 uiType, uint32 uiId)
    {
        if (uiType != POINT_MOTION_TYPE) return;

        switch (uiId)
        {
            case 0:
                if (urand(0, 3) == 0)
                    MoveToNextPoint();
                else
                    me->DisappearAndDie();
                break;
        }
    }
};

class mob_unleashed_dark : public CreatureScript
{
public:
    mob_unleashed_dark() : CreatureScript("mob_unleashed_dark") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_unleashed_darkAI(creature);
    }

    struct mob_unleashed_darkAI : public mob_unleashed_ballAI
    {
        mob_unleashed_darkAI(Creature* creature) : mob_unleashed_ballAI(creature) {}

        void SpellHitTarget(Unit* pWho, const SpellEntry* spell)
        {
            if (spell->Id == SPELL_UNLEASHED_DARK && pWho->HasAura(SPELL_DARK_ESSENCE))
            {   
                pWho->CastSpell(pWho, RAID_MODE(SPELL_POWERING_UP_1, SPELL_POWERING_UP_2, SPELL_POWERING_UP_3, SPELL_POWERING_UP_4), true);
                int n = 5 + rand() % 8;
                if(Aura * aura = pWho->GetAura(RAID_MODE(SPELL_POWERING_UP_1, SPELL_POWERING_UP_2, SPELL_POWERING_UP_3, SPELL_POWERING_UP_4)))
                {
                    if (aura->GetStackAmount()+n > 100)
                        aura->SetStackAmount(100);
                    else
                        aura->SetStackAmount(aura->GetStackAmount()+n);
                }
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_uiRangeCheckTimer < uiDiff)
            {
                if (Unit* target = me->SelectNearestTarget(2.0f))
                    if (target->GetTypeId() == TYPEID_PLAYER && target->isAlive())
                    {
                        DoCastAOE(SPELL_UNLEASHED_DARK);
                        me->GetMotionMaster()->MoveIdle();
                        me->DespawnOrUnsummon(1000);
                    }
                m_uiRangeCheckTimer = IN_MILLISECONDS;
            }
            else m_uiRangeCheckTimer -= uiDiff;
        }
    };

};

class mob_unleashed_light : public CreatureScript
{
public:
    mob_unleashed_light() : CreatureScript("mob_unleashed_light") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_unleashed_lightAI(creature);
    }

    struct mob_unleashed_lightAI : public mob_unleashed_ballAI
    {
        mob_unleashed_lightAI(Creature* creature) : mob_unleashed_ballAI(creature) {}

        void SpellHitTarget(Unit* pWho, const SpellEntry* spell)
        {
            if (spell->Id == SPELL_UNLEASHED_LIGHT && pWho->HasAura(SPELL_LIGHT_ESSENCE))
            { 
                pWho->CastSpell(pWho, RAID_MODE(SPELL_POWERING_UP_1, SPELL_POWERING_UP_2, SPELL_POWERING_UP_3, SPELL_POWERING_UP_4), true);
                int n = 5 + rand() % 8;
                if(Aura * aura = pWho->GetAura(RAID_MODE(SPELL_POWERING_UP_1, SPELL_POWERING_UP_2, SPELL_POWERING_UP_3, SPELL_POWERING_UP_4)))
                {
                    if(aura->GetStackAmount()+n > 100)
                        aura->SetStackAmount(100);
                    else
                    aura->SetStackAmount(aura->GetStackAmount()+n);
                }
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_uiRangeCheckTimer < uiDiff)
            {
                if (Unit* target = me->SelectNearestTarget(2.0f))
                    if (target->GetTypeId() == TYPEID_PLAYER && target->isAlive())
                    {
                        DoCastAOE(SPELL_UNLEASHED_LIGHT);
                        me->GetMotionMaster()->MoveIdle();
                        me->DespawnOrUnsummon(500);
                    }
                m_uiRangeCheckTimer = IN_MILLISECONDS;
            }
            else m_uiRangeCheckTimer -= uiDiff;
        }
    };

};

enum ePoweringUp
{
    SPELL_SURGE_OF_SPEED_1      = 65828,
    SPELL_SURGE_OF_SPEED_2      = 67241,
    SPELL_SURGE_OF_SPEED_3      = 67242,
    SPELL_SURGE_OF_SPEED_4      = 67243,
    SPELL_EMPOWERED_DARKNESS_1  = 65724,
    SPELL_EMPOWERED_DARKNESS_2  = 67213,
    SPELL_EMPOWERED_DARKNESS_3  = 67214,
    SPELL_EMPOWERED_DARKNESS_4  = 67215,
    SPELL_EMPOWERED_LIGHT_1     = 65748,
    SPELL_EMPOWERED_LIGHT_2     = 67216,
    SPELL_EMPOWERED_LIGHT_3     = 67217,
    SPELL_EMPOWERED_LIGHT_4     = 67218,
};

class spell_powering_up : public SpellScriptLoader
{
    public:
        spell_powering_up() : SpellScriptLoader("spell_powering_up") { }

    class spell_powering_up_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_powering_up_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
            {
                if (Aura* pAura = target->GetAura(GetId()))
                {
                    if (pAura->GetStackAmount() == 100)
                    {
                        if (target->HasAura(SPELL_DARK_ESSENCE))
                        {
                            switch(GetId())
                            {
                                case SPELL_POWERING_UP_1:
                                    target->CastSpell(target, SPELL_EMPOWERED_DARKNESS_1, true) ;
                                    break;
                                case SPELL_POWERING_UP_2:
                                    target->CastSpell(target, SPELL_EMPOWERED_DARKNESS_2, true) ;
                                    break;
                                case SPELL_POWERING_UP_3:
                                    target->CastSpell(target, SPELL_EMPOWERED_DARKNESS_3, true) ;
                                    break;
                                case SPELL_POWERING_UP_4:
                                    target->CastSpell(target, SPELL_EMPOWERED_DARKNESS_4, true) ;
                                    break;
                            }
                        }
                        if (target->HasAura(SPELL_LIGHT_ESSENCE))
                        {
                            switch(GetId())
                            {
                                case SPELL_POWERING_UP_1:
                                    target->CastSpell(target, SPELL_EMPOWERED_LIGHT_1, true) ;
                                    break;
                                case SPELL_POWERING_UP_2:
                                    target->CastSpell(target, SPELL_EMPOWERED_LIGHT_2, true) ;
                                    break;
                                case SPELL_POWERING_UP_3:
                                    target->CastSpell(target, SPELL_EMPOWERED_LIGHT_3, true) ;
                                    break;
                                case SPELL_POWERING_UP_4:
                                    target->CastSpell(target, SPELL_EMPOWERED_LIGHT_4, true) ;
                                    break;
                            }
                        }
                        target->RemoveAurasDueToSpell(GetId());
                    }
                }
            }
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_powering_up_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_powering_up_AuraScript();
    }

    class spell_powering_up_SpellScript : public SpellScript
    {
    public:
        PrepareSpellScript(spell_powering_up_SpellScript)
        bool Validate(SpellEntry const * /*spellEntry*/)
        {
            return true;
        }

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetTargetUnit())
                if (rand()%100 < 30)
                {
                    switch(GetSpellInfo()->Id)
                    {
                        case SPELL_POWERING_UP_1:
                            target->CastSpell(target, SPELL_SURGE_OF_SPEED_1, true) ;
                            break;
                        case SPELL_POWERING_UP_2:
                            target->CastSpell(target, SPELL_SURGE_OF_SPEED_2, true) ;
                            break;
                        case SPELL_POWERING_UP_3:
                            target->CastSpell(target, SPELL_SURGE_OF_SPEED_3, true) ;
                            break;
                        case SPELL_POWERING_UP_4:
                            target->CastSpell(target, SPELL_SURGE_OF_SPEED_4, true) ;
                            break;
                }
            }
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_powering_up_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_powering_up_SpellScript();
    }
};
void AddSC_boss_twin_valkyr()
{
    new boss_fjola();
    new boss_eydis();
    new mob_unleashed_light();
    new mob_unleashed_dark();
    new mob_essence_of_twin();
    new spell_powering_up();
}
