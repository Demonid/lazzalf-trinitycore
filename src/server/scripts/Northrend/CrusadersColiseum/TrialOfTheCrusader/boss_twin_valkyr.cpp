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
//    - Hardcoded bullets spawner

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
    EQUIP_MAIN_1         = 9423,
    EQUIP_MAIN_2         = 37377,
};

enum Summons
{
    NPC_BULLET_CONTROLLER        = 34743,

    NPC_BULLET_DARK              = 34628,
    NPC_BULLET_LIGHT             = 34630,
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

    SPELL_LIGHT_TWIN_SPIKE      = 66075,
    SPELL_LIGHT_SURGE           = 65766,
    SPELL_LIGHT_SHIELD          = 65858,
    SPELL_LIGHT_TWIN_PACT       = 65876,
    SPELL_LIGHT_VORTEX          = 66046,
    SPELL_LIGHT_TOUCH           = 67297,
    SPELL_LIGHT_ESSENCE         = 65686,
    SPELL_EMPOWERED_LIGHT       = 65748,
    SPELL_TWIN_EMPATHY_LIGHT    = 66133,
    SPELL_UNLEASHED_LIGHT       = 65795,

    SPELL_DARK_TWIN_SPIKE       = 66069,
    SPELL_DARK_SURGE            = 65768,
    SPELL_DARK_SHIELD           = 65874,
    SPELL_DARK_TWIN_PACT        = 65875,
    SPELL_DARK_VORTEX           = 66058,
    SPELL_DARK_TOUCH            = 67282,
    SPELL_DARK_ESSENCE          = 65684,
    SPELL_EMPOWERED_DARK        = 65724,
    SPELL_TWIN_EMPATHY_DARK     = 66132,
    SPELL_UNLEASHED_DARK        = 65808,    
    
    SPELL_CONTROLLER_PERIODIC    = 66149,
    SPELL_POWER_TWINS           = 65879,
    SPELL_BERSERK               = 64238,
    SPELL_POWERING_UP           = 67590,
    SPELL_SURGE_OF_SPEED        = 65828,
};

#define SPELL_DARK_ESSENCE_HELPER RAID_MODE<uint32>(65684, 67176, 67177, 67178)
#define SPELL_LIGHT_ESSENCE_HELPER RAID_MODE<uint32>(65686, 67222, 67223, 67224)

#define SPELL_POWERING_UP_HELPER RAID_MODE<uint32>(67590, 67602, 67603, 67604)

#define SPELL_EMPOWERED_DARK_HELPER RAID_MODE<uint32>(65724,67213,67214,67215)
#define SPELL_EMPOWERED_LIGHT_HELPER RAID_MODE<uint32>(65748, 67216, 67217, 67218)

#define SPELL_UNLEASHED_DARK_HELPER RAID_MODE<uint32>(65808, 67172, 67173, 67174)
#define SPELL_UNLEASHED_LIGHT_HELPER RAID_MODE<uint32>(65795, 67238, 67239, 67240)

#define ACHIEVEMENT_SALT_AND_PEPPER RAID_MODE(3799, 3815, 3799, 3815)
#define SALT_AND_PEPPER_MAX_TIMER 3 * MINUTE * IN_MILLISECONDS

enum Actions
{
    ACTION_VORTEX,
    ACTION_PACT
};

/*######
## boss_twin_base
######*/

class OrbsDespawner : public BasicEvent
{
    public:
        explicit OrbsDespawner(Creature* creature) : _creature(creature)
        {
        }

        bool Execute(uint64 /*currTime*/, uint32 /*diff*/)
        {
            Trinity::CreatureWorker<OrbsDespawner> worker(_creature, *this);
            _creature->VisitNearbyGridObject(5000.0f, worker);
            return true;
        }

        void operator()(Creature* creature) const
        {
            switch (creature->GetEntry())
            {
                case NPC_BULLET_DARK:
                case NPC_BULLET_LIGHT:
                    creature->DespawnOrUnsummon();
                    return;
                default:
                    return;
            }
        }

    private:
        Creature* _creature;
};

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

    AuraStateType  m_uiAuraState;

    uint8  m_uiStage;
    bool   m_bIsBerserk;
    uint8  m_uiWaveCount;
    uint32 m_uiWeapon;
    uint32 m_uiColorballsTimer;
    uint32 m_uiSpecialAbilityTimer;
    uint32 m_uiSpikeTimer;
    uint32 m_uiTouchTimer;
    uint32 m_uiBerserkTimer;

    int32 m_uiVortexSay;
    int32 m_uiVortexEmote;
    uint32 m_uiSisterNpcId;
    uint32 m_uiColorballNpcId;
    uint32 m_uiMyEmphatySpellId;
    uint32 m_uiMyEssenceSpellId;
    uint32 m_uiOtherEssenceSpellId;
    uint32 m_uiEmpoweredWeaknessSpellId;
    uint32 m_uiSurgeSpellId;
    uint32 m_uiVortexSpellId;
    uint32 m_uiShieldSpellId;
    uint32 m_uiTwinPactSpellId;
    uint32 m_uiSpikeSpellId;
    uint32 m_uiTouchSpellId;

    void Reset() {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        me->SetReactState(REACT_PASSIVE);
        me->ModifyAuraState(m_uiAuraState, true);
        /* Uncomment this once that they are flying above the ground
        me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
        me->SetFlying(true); */
        m_bIsBerserk = false;

        m_uiWaveCount = 1;
        m_uiColorballsTimer = 15*IN_MILLISECONDS;
        m_uiSpecialAbilityTimer = MINUTE*IN_MILLISECONDS;
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
        Summons.DespawnAll();
        me->DespawnOrUnsummon();
    }

    void MovementInform(uint32 uiType, uint32 uiId)
    {
        if (uiType != POINT_MOTION_TYPE) return;

        switch (uiId)
        {
            case 1:
                m_pInstance->DoUseDoorOrButton(m_pInstance->GetData64(GO_MAIN_GATE_DOOR));
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetInCombatWithZone();
                break;
        }
    }

    void KilledUnit(Unit* who)
    {
        if (who->GetTypeId() == TYPEID_PLAYER)
        {
            DoScriptText(urand(0, 1) ? SAY_KILL1 : SAY_KILL2, me);
            if (m_pInstance)
                m_pInstance->SetData(DATA_TRIBUTE_TO_IMMORTALITY_ELEGIBLE, CRITERIA_NOT_MEETED);
        }
    }

    void JustSummoned(Creature* summoned)
    {
        switch (summoned->GetEntry())
        {
            case NPC_BULLET_DARK:
            case NPC_BULLET_LIGHT:
                summoned->SetCorpseDelay(0);
                break;
        }
        Summons.Summon(summoned);
    }

    void SummonedCreatureDespawn(Creature* summoned)
    {
        switch (summoned->GetEntry())
        {
            case NPC_LIGHT_ESSENCE:
                m_pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_LIGHT_ESSENCE_HELPER);
                m_pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POWERING_UP_HELPER);
                break;
            case NPC_DARK_ESSENCE:
                m_pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_DARK_ESSENCE_HELPER);
                m_pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POWERING_UP_HELPER);
                break;
            //case NPC_BULLET_CONTROLLER:
            //    me->m_Events.AddEvent(new OrbsDespawner(me), me->m_Events.CalculateTime(100));
            //    break;
        }
        Summons.Despawn(summoned);
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
                    // me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                    // pSister->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);

                    m_pInstance->SetData(TYPE_VALKIRIES, DONE);
                    Summons.DespawnAll();
                }
                else 
                {
                    // me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
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

    void EnterCombat(Unit* who)
    {
        me->SetInCombatWithZone();
        if (m_pInstance)
        {
            if (Creature* pSister = GetSister())
            {
                me->AddAura(m_uiMyEmphatySpellId, pSister);
                pSister->SetInCombatWithZone();
            }
            m_pInstance->SetData(TYPE_VALKIRIES, IN_PROGRESS);
            m_pInstance->SetData(DATA_HEALTH_TWIN_SHARED, me->GetMaxHealth());
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
                break;
        }
    }

    void EnableDualWield(bool mode = true)
    {
        SetEquipmentSlots(false, m_uiWeapon, mode ? m_uiWeapon : EQUIP_UNEQUIP, EQUIP_UNEQUIP);
        me->SetCanDualWield(mode);
        me->UpdateDamagePhysical(mode ? OFF_ATTACK : BASE_ATTACK);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_pInstance || !UpdateVictim())
            return;

        if (m_pInstance->GetData(DATA_HEALTH_TWIN_SHARED) != 0)
            me->SetHealth(m_pInstance->GetData(DATA_HEALTH_TWIN_SHARED));
        else
            me->SetHealth(1);

        switch (m_uiStage)
        {
            case 0:
                break;
            case 1: // Vortex
                if (m_uiSpecialAbilityTimer <= uiDiff)
                {
                    if (Creature* pSister = GetSister())
                        pSister->AI()->DoAction(ACTION_VORTEX);
                    DoScriptText(m_uiVortexEmote, me);
                    DoScriptText(m_uiVortexSay, me);
                    DoCastAOE(m_uiVortexSpellId);
                    m_uiStage = 0;
                    m_uiSpecialAbilityTimer = MINUTE*IN_MILLISECONDS;
                }
                else
                    m_uiSpecialAbilityTimer -= uiDiff;
                break;
            case 2: // Shield+Pact
                if (m_uiSpecialAbilityTimer <= uiDiff)
                {
                    DoScriptText(EMOTE_SHIELD, me);
                    DoScriptText(SAY_SHIELD, me);
                    if (Creature* pSister = GetSister())
                    {
                        pSister->AI()->DoAction(ACTION_PACT);
                        pSister->CastSpell(pSister, SPELL_POWER_TWINS, false);
                    }
                    DoCast(me, m_uiShieldSpellId);
                    DoCast(me, m_uiTwinPactSpellId);
                    m_uiStage = 0;
                    m_uiSpecialAbilityTimer = MINUTE*IN_MILLISECONDS;
                }
                else
                    m_uiSpecialAbilityTimer -= uiDiff;
                break;
            default:
                break;
        }

        if (me->HasUnitState(UNIT_STAT_CASTING))
            return;

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
            m_pInstance = (InstanceScript*)creature->GetInstanceScript();
        }
        
        InstanceScript* m_pInstance;

        uint32 saltAndPepperTimer;

        void Reset() {
            boss_twin_baseAI::Reset();
            SetEquipmentSlots(false, EQUIP_MAIN_1, EQUIP_UNEQUIP, EQUIP_NO_CHANGE);
            m_uiStage = 0;
            m_uiWeapon = EQUIP_MAIN_1;
            m_uiAuraState = AURA_STATE_UNKNOWN22;
            m_uiVortexEmote = EMOTE_LIGHT_VORTEX;
            m_uiVortexSay = SAY_LIGHT_VORTEX;
            m_uiSisterNpcId = NPC_DARKBANE;
            m_uiColorballNpcId = NPC_BULLET_LIGHT;
            m_uiMyEmphatySpellId = SPELL_TWIN_EMPATHY_DARK;
            m_uiMyEssenceSpellId = SPELL_LIGHT_ESSENCE_HELPER;
            m_uiOtherEssenceSpellId = SPELL_DARK_ESSENCE_HELPER;
            m_uiEmpoweredWeaknessSpellId = SPELL_EMPOWERED_DARK_HELPER;
            m_uiSurgeSpellId = RAID_MODE(SURGE_OF_LIGHT_10N, SURGE_OF_LIGHT_25N, SURGE_OF_LIGHT_10H, SURGE_OF_LIGHT_25H);
            m_uiVortexSpellId = RAID_MODE(LIGHT_VORTEX_10N, LIGHT_VORTEX_25N, LIGHT_VORTEX_10H, LIGHT_VORTEX_25H);
            m_uiShieldSpellId = RAID_MODE(LIGHT_SHIELD_10N, LIGHT_SHIELD_25N, LIGHT_SHIELD_10H, LIGHT_SHIELD_25H);
            m_uiTwinPactSpellId = RAID_MODE(LIGHT_TWINS_PACT_10N, LIGHT_TWINS_PACT_25N, LIGHT_TWINS_PACT_10H, LIGHT_TWINS_PACT_25H);
            m_uiTouchSpellId = RAID_MODE(TOUCH_OF_LIGHT_10, TOUCH_OF_LIGHT_25, TOUCH_OF_LIGHT_10, TOUCH_OF_LIGHT_25);
            m_uiSpikeSpellId = RAID_MODE(LIGHT_TWIN_SPIKE_10N, LIGHT_TWIN_SPIKE_25N, LIGHT_TWIN_SPIKE_10H, LIGHT_TWIN_SPIKE_25H);

            saltAndPepperTimer = 0;

            /*
            if (m_pInstance)
            {
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT,  EVENT_START_TWINS_FIGHT);
            }
            */
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

        void EnterCombat(Unit* who)
        {
            saltAndPepperTimer = 0;

            /*
            if (m_pInstance)
            {
                m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT,  EVENT_START_TWINS_FIGHT);
            }
            */

            me->SummonCreature(NPC_BULLET_CONTROLLER, ToCCommonLoc[1].GetPositionX(), ToCCommonLoc[1].GetPositionY(), ToCCommonLoc[1].GetPositionZ(), 0.0f, TEMPSUMMON_MANUAL_DESPAWN);
            boss_twin_baseAI::EnterCombat(who);
        }
        
        void EnterEvadeMode()
        {
            m_pInstance->DoUseDoorOrButton(m_pInstance->GetData64(GO_MAIN_GATE_DOOR));
            boss_twin_baseAI::EnterEvadeMode();
        }

        void JustReachedHome()
        {
            if (m_pInstance)
                m_pInstance->DoUseDoorOrButton(m_pInstance->GetData64(GO_MAIN_GATE_DOOR));

            boss_twin_baseAI::JustReachedHome();
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

        void Reset() {
            boss_twin_baseAI::Reset();
            SetEquipmentSlots(false, EQUIP_MAIN_2, EQUIP_UNEQUIP, EQUIP_NO_CHANGE);
            m_uiStage = 1;
            m_uiWeapon = EQUIP_MAIN_2;
            m_uiAuraState = AURA_STATE_UNKNOWN19;
            m_uiVortexEmote = EMOTE_DARK_VORTEX;
            m_uiVortexSay = SAY_DARK_VORTEX;
            m_uiSisterNpcId = NPC_LIGHTBANE;
            m_uiColorballNpcId = NPC_BULLET_DARK;
            m_uiMyEmphatySpellId = SPELL_TWIN_EMPATHY_LIGHT;
            m_uiMyEssenceSpellId = SPELL_DARK_ESSENCE_HELPER;
            m_uiOtherEssenceSpellId = SPELL_LIGHT_ESSENCE_HELPER;        
            m_uiEmpoweredWeaknessSpellId = SPELL_EMPOWERED_LIGHT_HELPER;
            m_uiSurgeSpellId = RAID_MODE(SURGE_OF_DARKNESS_10N, SURGE_OF_DARKNESS_25N, SURGE_OF_DARKNESS_10H, SURGE_OF_DARKNESS_25H);
            m_uiVortexSpellId = RAID_MODE(DARK_VORTEX_10N, DARK_VORTEX_25N, DARK_VORTEX_10H, DARK_VORTEX_25H);
            m_uiShieldSpellId = RAID_MODE(DARK_SHIELD_10N, DARK_SHIELD_25N, DARK_SHIELD_10H, DARK_SHIELD_25H);
            m_uiTwinPactSpellId = RAID_MODE(DARK_TWINS_PACT_10N, DARK_TWINS_PACT_25N, DARK_TWINS_PACT_10H, DARK_TWINS_PACT_25H);
            m_uiTouchSpellId = RAID_MODE(TOUCH_OF_DARKNESS_10, TOUCH_OF_DARKNESS_25, TOUCH_OF_DARKNESS_10, TOUCH_OF_DARKNESS_25);
            m_uiSpikeSpellId = RAID_MODE(DARK_TWIN_SPIKE_10N, DARK_TWIN_SPIKE_25N, DARK_TWIN_SPIKE_10H, DARK_TWIN_SPIKE_25H);
        }

        void JustDied(Unit* killer)
        {
            if (m_pInstance)
            {
                Map::PlayerList const &players = m_pInstance->instance->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    Player* player = itr->getSource();
                    if (!player)
                        continue;
                    player->KilledMonsterCredit(34497, 0);
                }
            }
            boss_twin_baseAI::JustDied(killer);
        }   
    };    
};

#define ESSENCE_REMOVE 0
#define ESSENCE_APPLY 1

class mob_essence_of_twin : public CreatureScript
{
    public:
        mob_essence_of_twin() : CreatureScript("mob_essence_of_twin") { }

        struct mob_essence_of_twinAI : public ScriptedAI
        {
            mob_essence_of_twinAI(Creature* creature) : ScriptedAI(creature) { }

            uint32 GetData(uint32 data)
            {
                uint32 spellReturned = 0;
                switch (me->GetEntry())
                {
                    case NPC_LIGHT_ESSENCE:
                        spellReturned = data == ESSENCE_REMOVE? SPELL_DARK_ESSENCE_HELPER : SPELL_LIGHT_ESSENCE_HELPER;
                        break;
                    case NPC_DARK_ESSENCE:
                        spellReturned = data == ESSENCE_REMOVE? SPELL_LIGHT_ESSENCE_HELPER : SPELL_DARK_ESSENCE_HELPER;
                        break;
                    default:
                        break;
                }

                return spellReturned;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_essence_of_twinAI(creature);
        };

        bool OnGossipHello(Player* player, Creature* creature)
        {
            player->RemoveAurasDueToSpell(creature->GetAI()->GetData(ESSENCE_REMOVE));
            player->CastSpell(player, creature->GetAI()->GetData(ESSENCE_APPLY), true);
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
        // me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
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

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_uiRangeCheckTimer < uiDiff)
            {
                if (Unit* target = me->SelectNearestTarget(2.0f))
                    if (target->GetTypeId() == TYPEID_PLAYER && target->isAlive())
                    {
                        DoCastAOE(SPELL_UNLEASHED_DARK);
                        me->GetMotionMaster()->MoveIdle();
                        me->DespawnOrUnsummon(500);
                    }
                m_uiRangeCheckTimer = IN_MILLISECONDS;
            }
            else m_uiRangeCheckTimer -= uiDiff;
        }

        void SpellHitTarget(Unit* who, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_UNLEASHED_DARK_HELPER)
            {
                if (who->HasAura(SPELL_DARK_ESSENCE_HELPER))
                    who->CastSpell(who, SPELL_POWERING_UP, true);
            }
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

        void SpellHitTarget(Unit* who, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_UNLEASHED_LIGHT_HELPER)
            {
                if (who->HasAura(SPELL_LIGHT_ESSENCE_HELPER))
                    who->CastSpell(who, SPELL_POWERING_UP, true);
            }
        }
    };

};

class mob_bullet_controller : public CreatureScript
{
public:
    mob_bullet_controller() : CreatureScript("mob_bullet_controller") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_bullet_controllerAI(creature);
    }

    struct mob_bullet_controllerAI : public Scripted_NoMovementAI
    {
        mob_bullet_controllerAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            Reset();
        }

        void Reset()
        {
            DoCastAOE(SPELL_CONTROLLER_PERIODIC);
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            UpdateVictim();
        }
    };
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
                            if(target->GetDummyAuraEffect(SPELLFAMILY_GENERIC, 2206, EFFECT_1))
                                target->CastSpell(target, SPELL_EMPOWERED_DARK, true);

                            if(target->GetDummyAuraEffect(SPELLFAMILY_GENERIC, 2845, EFFECT_1))
                                target->CastSpell(target, SPELL_EMPOWERED_LIGHT, true);

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

            uint32 spellId;

            bool Validate(SpellEntry const*  /*spellEntry*/)
            {
                spellId = sSpellMgr->GetSpellIdForDifficulty(SPELL_SURGE_OF_SPEED, GetCaster());
                if (!sSpellMgr->GetSpellInfo(spellId))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetTargetUnit())
                    if (urand(0, 99) < 15)
                        target->CastSpell(target, spellId, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_powering_up_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_powering_up_SpellScript();
        }
};

class spell_valkyr_essences : public SpellScriptLoader
{
    public:
        spell_valkyr_essences() : SpellScriptLoader("spell_valkyr_essences") { }

        class spell_valkyr_essences_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_valkyr_essences_AuraScript);

            uint32 spellId;

            bool Load()
            {
                spellId = sSpellMgr->GetSpellIdForDifficulty(SPELL_SURGE_OF_SPEED, GetCaster());
                if (!sSpellMgr->GetSpellInfo(spellId))
                    return false;
                return true;
            }

            void Absorb(AuraEffect*  /*aurEff*/, DamageInfo & /*dmgInfo*/, uint32 & /*absorbAmount*/)
            {
                if (urand(0, 99) < 5)
                    GetTarget()->CastSpell(GetTarget(), spellId, true);
            }

            void Register()
            {
                OnEffectAbsorb += AuraEffectAbsorbFn(spell_valkyr_essences_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_valkyr_essences_AuraScript();
        }
};

class spell_power_of_the_twins : public SpellScriptLoader
{
    public:
        spell_power_of_the_twins() : SpellScriptLoader("spell_power_of_the_twins") { }

        class spell_power_of_the_twins_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_power_of_the_twins_AuraScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                {
                    if (Creature* Valk = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(GetCaster()->GetEntry())))
                        CAST_AI(boss_twin_baseAI, Valk->AI())->EnableDualWield(true);
                }
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                {
                    if (Creature* Valk = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(GetCaster()->GetEntry())))
                        CAST_AI(boss_twin_baseAI, Valk->AI())->EnableDualWield(false);
                }
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_power_of_the_twins_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_power_of_the_twins_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);

            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_power_of_the_twins_AuraScript();
        }
};

void AddSC_boss_twin_valkyr()
{
    new boss_fjola();
    new boss_eydis();
    new mob_unleashed_light();
    new mob_unleashed_dark();
    new mob_essence_of_twin();
    new mob_bullet_controller();
    new spell_powering_up();
    new spell_valkyr_essences();
    new spell_power_of_the_twins();
}
