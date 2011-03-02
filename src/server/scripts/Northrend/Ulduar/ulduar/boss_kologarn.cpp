/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
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
SDName: Kologarn
SDAuthor: PrinceCreed
SD%Complete: 100%
SD%Comments: Kologarn's vehicleid is wrong.
EndScriptData */

#include "ScriptPCH.h"
#include "ulduar.h"
#include "Vehicle.h"

#define SPELL_ARM_DEAD_DAMAGE   RAID_MODE(63629,63979)
#define SPELL_TWO_ARM_SMASH     RAID_MODE(63356,64003)
#define SPELL_ONE_ARM_SMASH     RAID_MODE(63573,64006)
#define SPELL_STONE_SHOUT       RAID_MODE(63716,64005)
#define SPELL_PETRIFY_BREATH    RAID_MODE(62030,63980)
#define SPELL_SHOCKWAVE         63783
#define SPELL_SHOCKWAVE_VISUAL  63788

#define SPELL_STONE_GRIP        RAID_MODE(62166,63981)
#define SPELL_STONE_GRIP_STUN   62056

#define SPELL_FOCUSED_EYEBEAM   63347
#define SPELL_EYEBEAM_VISUAL_1  63676
#define SPELL_EYEBEAM_VISUAL_2  63702
#define SPELL_EYEBEAM_IMMUNITY  64722

#define SPELL_SUMMON_RUBBLE     63633
#define SPELL_FALLING_RUBBLE    63821

#define SPELL_STONE_GRIP_CANCEL 65594

#define SPELL_ARM_SWEEP         RAID_MODE(63766,63983)

#define SPELL_ARM_ENTER_VEHICLE 65343
#define SPELL_ARM_RESPAWN       64753

// Passive
#define SPELL_KOLOGARN_REDUCE_PARRY 64651
#define SPELL_KOLOGARN_PACIFY       63726
#define SPELL_KOLOGARN_UNK_0        65219   // Not found in DBC

#define SPELL_BERSERK           47008 // guess

#define NPC_RUBBLE_STALKER      33809
#define NPC_ARM_SWEEP_STALKER   33661

enum Events
{
    EVENT_NONE,
    EVENT_SMASH,
    EVENT_GRIP,
    EVENT_SWEEP,
    EVENT_SHOCKWAVE,
    EVENT_EYEBEAM,
    EVENT_STONESHOT,
    EVENT_RIGHT,
    EVENT_LEFT,
    EVENT_ENRAGE
};

enum Actions
{
    ACTION_RESPAWN_RIGHT,
    ACTION_RESPAWN_LEFT,
    ACTION_GRIP
};

enum Yells
{
    SAY_AGGRO                                   = -1603230,
    SAY_SLAY_1                                  = -1603231,
    SAY_SLAY_2                                  = -1603232,
    SAY_LEFT_ARM_GONE                           = -1603233,
    SAY_RIGHT_ARM_GONE                          = -1603234,
    SAY_SHOCKWAVE                               = -1603235,
    SAY_GRAB_PLAYER                             = -1603236,
    SAY_DEATH                                   = -1603237,
    SAY_BERSERK                                 = -1603238
};

#define EMOTE_LEFT                              "The Left Arm has regrown!"
#define EMOTE_RIGHT                             "The Right Arm has regrown!"
#define EMOTE_STONE                             "Kologarn casts Stone Grip!"

// Achievements
#define ACHIEVEMENT_LOOKS_COULD_KILL            RAID_MODE(2955, 2956) // TODO
#define ACHIEVEMENT_RUBBLE_AND_ROLL             RAID_MODE(2959, 2960)
#define ACHIEVEMENT_WITH_OPEN_ARMS              RAID_MODE(2951, 2952)
#define ACHIEV_DISARMED_START_EVENT             21687

#define N_GRIPPED                               RAID_MODE(1, 2)

const Position RubbleLeft   = {1781.814f, -45.07f, 448.808f, 2.260f};
const Position RubbleRight  = {1781.814f, -3.716f, 448.808f, 4.211f};

enum KologarnChests
{
    CACHE_OF_LIVING_STONE_10                    = 195046,
    CACHE_OF_LIVING_STONE_25                    = 195047
};

class boss_kologarn : public CreatureScript
{
public:
    boss_kologarn() : CreatureScript("boss_kologarn") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_kologarnAI (pCreature);
    }

    struct boss_kologarnAI : public BossAI
    {
        boss_kologarnAI(Creature *pCreature) : BossAI(pCreature, BOSS_KOLOGARN), vehicle(pCreature->GetVehicleKit()),
            left(false), right(false)
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            SetCombatMovement(false);
            emerged = false;
            eyeBeamHit = false;

            DoCast(SPELL_KOLOGARN_REDUCE_PARRY);
        }

        Vehicle *vehicle;

        bool left, right;
        bool emerged;
        uint32 RubbleCount;
        bool eyeBeamHit;

        void MoveInLineOfSight(Unit* who)
        {
            // Birth animation
            if (!emerged && me->IsWithinDistInMap(who, 40.0f) && who->GetTypeId() == TYPEID_PLAYER && !who->ToPlayer()->isGameMaster())
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                emerged = true;
            }
        }

        void AttackStart(Unit *who)
        {
            me->Attack(who, true);
        }

        void JustDied(Unit* /*victim*/)
        {                
            DoScriptText(SAY_DEATH, me);
            _JustDied();

            if (instance)
            {
                // Rubble and Roll
                if (RubbleCount > 4)
                    instance->DoCompleteAchievement(ACHIEVEMENT_RUBBLE_AND_ROLL);
                // With Open Arms
                if (RubbleCount == 0)
                    instance->DoCompleteAchievement(ACHIEVEMENT_WITH_OPEN_ARMS);

                // If Looks Could Kill
                /*if (!eyeBeamHit)
                    instance->DoCompleteAchievement(ACHIEVEMENT_LOOKS_COULD_KILL);*/
            }

            // Hack to disable corpse fall
            me->GetMotionMaster()->MoveTargetedHome();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->setFaction(35);
            // Chest spawn
            me->SummonGameObject(RAID_MODE(CACHE_OF_LIVING_STONE_10, CACHE_OF_LIVING_STONE_25),1836.52f,-36.11f,448.81f,0.56f,0,0,1,1,604800);
        }

        void KilledUnit(Unit* /*who*/)
        {
            if (!(rand()%5))
                DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply)
        {
            if (who->GetTypeId() == TYPEID_UNIT)
            {
                if (who->GetEntry() == NPC_LEFT_ARM)
                    left = apply;
                else if (who->GetEntry() == NPC_RIGHT_ARM)
                    right = apply;
                who->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
            _EnterCombat();
        
            RubbleCount = 0;
            
            for (int32 n = 0; n < 2; ++n)
            {
                if (vehicle->GetPassenger(n))
                    vehicle->GetPassenger(n)->ToCreature()->AI()->DoZoneInCombat();
            }
            events.ScheduleEvent(EVENT_SMASH, 5000);
            events.ScheduleEvent(EVENT_SWEEP, 10000);
            events.ScheduleEvent(EVENT_EYEBEAM, 10000);
            events.ScheduleEvent(EVENT_SHOCKWAVE, 12000);
            events.ScheduleEvent(EVENT_GRIP, 40000);
            events.ScheduleEvent(EVENT_ENRAGE, 600000);
            eyeBeamHit = false;
        }

        void Reset()
        {
            _Reset();
            
            if (instance)
                instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
        
            if (Unit* LeftArm = me->SummonCreature(NPC_LEFT_ARM, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                LeftArm->EnterVehicle(vehicle, 0);
            if (Unit* RightArm = me->SummonCreature(NPC_RIGHT_ARM, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                RightArm->EnterVehicle(vehicle, 1);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;
            
            if (events.GetTimer() > 15000 && !me->IsWithinMeleeRange(me->getVictim()))
                DoCastAOE(SPELL_PETRIFY_BREATH, true);
        
            if (!left && !right)
                DoCast(me, SPELL_STONE_SHOUT, true);

            switch(events.GetEvent())
            {
                case EVENT_NONE: 
                    break;
                case EVENT_ENRAGE:
                    DoCast(SPELL_BERSERK);
                    DoScriptText(SAY_BERSERK, me);
                    break;
                case EVENT_SMASH:
                    if (left && right)
                    {
                        if (me->IsWithinMeleeRange(me->getVictim()))
                            DoCastVictim(SPELL_TWO_ARM_SMASH, true);
                    }
                    else if (left || right)
                    {
                        if (me->IsWithinMeleeRange(me->getVictim()))
                            DoCastVictim(SPELL_ONE_ARM_SMASH, true);
                    }
                    events.RescheduleEvent(EVENT_SMASH, 15000);
                    break;
                case EVENT_SWEEP:
                    if (left)
                        DoCast(me->FindNearestCreature(NPC_ARM_SWEEP_STALKER, 500.0f, true), SPELL_ARM_SWEEP, true);
                    events.RescheduleEvent(EVENT_SWEEP, 15000);
                    break;
                case EVENT_GRIP:
                    if (right)
                    {
                        DoCast(SPELL_STONE_GRIP);
                        DoScriptText(SAY_GRAB_PLAYER, me);
                        DoScriptText(SAY_GRAB_PLAYER, me);
                    }
                    events.RescheduleEvent(EVENT_GRIP, 30000);
                    break;
                case EVENT_SHOCKWAVE:
                    if (left)
                    {
                        DoScriptText(SAY_SHOCKWAVE, me);
                        DoCastAOE(SPELL_SHOCKWAVE, true);
                        DoCastAOE(SPELL_SHOCKWAVE_VISUAL, true);
                    }
                    events.RescheduleEvent(EVENT_SHOCKWAVE, urand(15000, 25000));
                    break;
                case EVENT_EYEBEAM:
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_FARTHEST, 0, -10.0f, true))
                    {
                        if (Creature* EyeBeam = me->SummonCreature(NPC_FOCUSED_EYEBEAM,pTarget->GetPositionX(),pTarget->GetPositionY()+3,pTarget->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN,10000))
                        {
                            EyeBeam->CastSpell(me, SPELL_EYEBEAM_VISUAL_1, true);
                            EyeBeam->AI()->AttackStart(pTarget);
                        }
                        if (Creature* EyeBeam = me->SummonCreature(NPC_FOCUSED_EYEBEAM_RIGHT,pTarget->GetPositionX(),pTarget->GetPositionY()-3,pTarget->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN,10000))
                        {
                            EyeBeam->CastSpell(me, SPELL_EYEBEAM_VISUAL_2, true);
                            EyeBeam->AI()->AttackStart(pTarget);
                        }
                    }
                    events.RescheduleEvent(EVENT_EYEBEAM, 20000);
                    break;
                case EVENT_LEFT:
                    if (Unit* LeftArm = me->SummonCreature(NPC_LEFT_ARM, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        LeftArm->EnterVehicle(vehicle, 0);
                        DoCast(me, SPELL_ARM_RESPAWN, true);
                        me->MonsterTextEmote(EMOTE_LEFT, 0, true);
                        if (instance)
                            instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    }
                    events.CancelEvent(EVENT_LEFT);
                    break;                
                case EVENT_RIGHT:
                    if (Unit* RightArm = me->SummonCreature(NPC_RIGHT_ARM, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        RightArm->EnterVehicle(vehicle, 1);
                        DoCast(me, SPELL_ARM_RESPAWN, true);
                        me->MonsterTextEmote(EMOTE_RIGHT, 0, true);
                        if (instance)
                            instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    }
                    events.CancelEvent(EVENT_RIGHT);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void DoAction(const int32 action)
        {
            switch (action)
            {
                case ACTION_RESPAWN_LEFT:
                    DoScriptText(SAY_LEFT_ARM_GONE, me);
                    me->DealDamage(me, int32(me->GetMaxHealth() * 15 / 100)); // decreases Kologarn's health by 15%
                    ++RubbleCount;
                    if (instance && right)
                        instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    events.ScheduleEvent(EVENT_LEFT, 30000);
                    break;
                case ACTION_RESPAWN_RIGHT:
                    DoScriptText(SAY_RIGHT_ARM_GONE, me);
                    me->DealDamage(me, int32(me->GetMaxHealth() * 15 / 100));
                    ++RubbleCount;
                    if (instance && left)
                        instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    events.ScheduleEvent(EVENT_RIGHT, 30000);
                    break;
            }
        }    
    };

};


class npc_focused_eyebeam : public CreatureScript
{
public:
    npc_focused_eyebeam() : CreatureScript("npc_focused_eyebeam") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_focused_eyebeamAI (pCreature);
    }

    struct npc_focused_eyebeamAI : public ScriptedAI
    {
        npc_focused_eyebeamAI(Creature *c) : ScriptedAI(c)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
            DoCast(me, SPELL_EYEBEAM_IMMUNITY);
            DoCast(me, SPELL_FOCUSED_EYEBEAM);
            me->SetDisplayId(11686);
            checkTimer = 1500;
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint32 checkTimer;

        void SpellHitTarget(Unit* pTarget, const SpellEntry *spell)
        {
            if (spell->Id == SPELL_FOCUSED_EYEBEAM)
            {
                if (pTarget->GetTypeId() == TYPEID_PLAYER)
                    if (Creature* pKologarn = me->GetCreature(*me, pInstance->GetData64(DATA_KOLOGARN)))
                        CAST_AI(boss_kologarn::boss_kologarnAI,pKologarn->AI())->eyeBeamHit = true;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (checkTimer <= diff)
            {
                if (me->getVictim() && me->getVictim()->isAlive())
                    me->GetMotionMaster()->MovePoint(0,me->getVictim()->GetPositionX(),me->getVictim()->GetPositionY(),me->getVictim()->GetPositionZ());
            
                checkTimer = 500;
            }
            else checkTimer -= diff;
        }
    };

};


class npc_left_arm : public CreatureScript
{
public:
    npc_left_arm() : CreatureScript("npc_left_arm") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_left_armAI (pCreature);
    }

    struct npc_left_armAI : public ScriptedAI
    {
        npc_left_armAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
            me->SetReactState(REACT_PASSIVE);
        }

        InstanceScript* pInstance;

        void JustDied(Unit* /*victim*/)
        {
            for (uint8 i = 0; i < 5; ++i)
                me->SummonCreature(NPC_RUBBLE, RubbleLeft, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
            
            if (pInstance)
                if (Creature* pKologarn = me->GetCreature(*me, pInstance->GetData64(DATA_KOLOGARN)))
                    pKologarn->AI()->DoAction(ACTION_RESPAWN_LEFT);
                    
            // Hack to disable corpse fall
            me->GetMotionMaster()->MoveTargetedHome();
        }
    
        void JustSummoned(Creature *summon)
        {
            summon->AI()->DoZoneInCombat();
        }
    };

};


class npc_right_arm : public CreatureScript
{
public:
    npc_right_arm() : CreatureScript("npc_right_arm") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_right_armAI (pCreature);
    }

    struct npc_right_armAI : public ScriptedAI
    {
        npc_right_armAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 64708, true);
            me->SetReactState(REACT_PASSIVE);
        }

        InstanceScript* pInstance;

        void JustDied(Unit* /*victim*/)
        {
            for (uint8 i = 0; i < 5; ++i)
                me->SummonCreature(NPC_RUBBLE, RubbleRight, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 3000);
            
            if (pInstance)
                if (Creature* pKologarn = me->GetCreature(*me, pInstance->GetData64(DATA_KOLOGARN)))
                    pKologarn->AI()->DoAction(ACTION_RESPAWN_RIGHT);
                    
            // Hack to disable corpse fall
            me->GetMotionMaster()->MoveTargetedHome();
        }
    
        void JustSummoned(Creature *summon)
        {
            summon->AI()->DoZoneInCombat();
        }
    };
};

class spell_ulduar_rubble_summon : public SpellScriptLoader
{
    public:
        spell_ulduar_rubble_summon() : SpellScriptLoader("spell_ulduar_rubble_summon") { }

        class spell_ulduar_rubble_summonSpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ulduar_rubble_summonSpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (!caster)
                    return;

                uint64 originalCaster = caster->GetInstanceScript() ? caster->GetInstanceScript()->GetData64(DATA_KOLOGARN) : 0;
                uint32 spellId = GetEffectValue();
                for (uint8 i = 0; i < 5; ++i)
                    caster->CastSpell(caster, spellId, true, NULL, NULL, originalCaster);
            }

            void Register()
            {
                OnEffect += SpellEffectFn(spell_ulduar_rubble_summonSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ulduar_rubble_summonSpellScript();
        }
};

// predicate function to select non main tank target
class StoneGripTargetSelector : public std::unary_function<Unit *, bool>
{
    public:
        StoneGripTargetSelector(Creature* me, const Unit* victim) : _me(me), _victim(victim) {}

        bool operator() (Unit* pTarget)
        {
            if (pTarget == _victim && _me->getThreatManager().getThreatList().size() > 1)
                return true;

            if (pTarget->GetTypeId() != TYPEID_PLAYER)
                return true;

            return false;
        }

        Creature* _me;
        Unit const* _victim;
};

class spell_ulduar_stone_grip_cast_target : public SpellScriptLoader
{
    public:
        spell_ulduar_stone_grip_cast_target() : SpellScriptLoader("spell_ulduar_stone_grip_cast_target") { }

        class spell_ulduar_stone_grip_cast_target_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ulduar_stone_grip_cast_target_SpellScript);

            bool Load()
            {
                if (GetCaster()->GetTypeId() != TYPEID_UNIT)
                    return false;
                return true;
            }

            void FilterTargetsInitial(std::list<Unit*>& unitList)
            {
                // Remove "main tank" and non-player targets
                unitList.remove_if(StoneGripTargetSelector(GetCaster()->ToCreature(), GetCaster()->getVictim()));
                // Maximum affected targets per difficulty mode
                uint32 maxTargets = 1;
                if (GetSpellInfo()->Id == 63981)
                    maxTargets = 3;

                // Return a random amount of targets based on maxTargets
                while (maxTargets < unitList.size())
                {
                    std::list<Unit*>::iterator itr = unitList.begin();
                    advance(itr, urand(0, unitList.size()-1));
                    unitList.erase(itr);
                }

                // For subsequent effects
                m_unitList = unitList;
            }

            void FillTargetsSubsequential(std::list<Unit*>& unitList)
            {
                unitList = m_unitList;
            }

            void HandleForceCast(SpellEffIndex i)
            {
                Player * plr = GetHitPlayer();
                if (!plr)
                    return;

                plr->CastSpell(GetTargetUnit(), GetSpellInfo()->EffectTriggerSpell[i], true);     // Don't send m_originalCasterGUID param here or underlying
                PreventHitEffect(i);                                                                   // AureEffect::HandleAuraControlVehicle will fail on caster == target
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_ulduar_stone_grip_cast_target_SpellScript::FilterTargetsInitial, EFFECT_0, TARGET_UNIT_AREA_ENEMY_SRC);
                OnEffect += SpellEffectFn(spell_ulduar_stone_grip_cast_target_SpellScript::HandleForceCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_ulduar_stone_grip_cast_target_SpellScript::FillTargetsSubsequential, EFFECT_1, TARGET_UNIT_AREA_ENEMY_SRC);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_ulduar_stone_grip_cast_target_SpellScript::FillTargetsSubsequential, EFFECT_2, TARGET_UNIT_AREA_ENEMY_SRC);
            }

            // Shared between effects
            std::list<Unit*> m_unitList;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ulduar_stone_grip_cast_target_SpellScript();
        }
};

class spell_ulduar_cancel_stone_grip : public SpellScriptLoader
{
    public:
        spell_ulduar_cancel_stone_grip() : SpellScriptLoader("spell_ulduar_cancel_stone_grip") { }

        class spell_ulduar_cancel_stone_gripSpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ulduar_cancel_stone_gripSpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* target = this->GetHitPlayer();
                if (!target)
                    return;

                if (!target->GetVehicle())
                    return;

                switch (target->GetMap()->GetDifficulty())
                {
                    case RAID_DIFFICULTY_10MAN_NORMAL:
                        target->RemoveAura(SpellMgr::CalculateSpellEffectAmount(GetSpellInfo(), EFFECT_0));
                        break;
                    case RAID_DIFFICULTY_25MAN_NORMAL:
                        target->RemoveAura(SpellMgr::CalculateSpellEffectAmount(GetSpellInfo(), EFFECT_1));
                        break;
                }
            }

            void Register()
            {
                OnEffect += SpellEffectFn(spell_ulduar_cancel_stone_gripSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ulduar_cancel_stone_gripSpellScript();
        }
};

class spell_ulduar_squeezed_lifeless : public SpellScriptLoader
{
public:
    spell_ulduar_squeezed_lifeless() : SpellScriptLoader("spell_ulduar_squeezed_lifeless") { }

    class spell_ulduar_squeezed_lifeless_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_ulduar_squeezed_lifeless_SpellScript);

        void HandleInstaKill(SpellEffIndex /*effIndex*/)
        {
            if (!GetHitPlayer()->GetVehicle())
                return;

            Position pos;
            pos.m_positionX = 1756.25f + irand(-3, 3);
            pos.m_positionY = -8.3f + irand(-3, 3);
            pos.m_positionZ = 448.8f;
            pos.m_orientation = M_PI;
            GetHitPlayer()->DestroyForNearbyPlayers();
            GetHitPlayer()->ExitVehicle(&pos);
            GetHitPlayer()->UpdateObjectVisibility(false);
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_ulduar_squeezed_lifeless_SpellScript::HandleInstaKill, EFFECT_1, SPELL_EFFECT_INSTAKILL);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_ulduar_squeezed_lifeless_SpellScript();
    }
};

class spell_ulduar_stone_grip_absorb : public SpellScriptLoader
{
    public:
        spell_ulduar_stone_grip_absorb() : SpellScriptLoader("spell_ulduar_stone_grip_absorb") { }

        class spell_ulduar_stone_grip_absorb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ulduar_stone_grip_absorb_AuraScript);

            //! This will be called when Right Arm (vehicle) has sustained a specific amount of damage depending on instance mode
            //! What we do here is remove all harmful aura's related and teleport to safe spot.
            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes mode)
            {
                if (!(mode & AURA_EFFECT_HANDLE_REAL))
                    return;

                if (GetTargetApplication()->GetRemoveMode() !=  AURA_REMOVE_BY_ENEMY_SPELL)
                    return;

                if (!GetOwner()->ToCreature())
                    return;

                uint32 rubbleStalkerEntry = (GetOwner()->GetMap()->GetDifficulty() == DUNGEON_DIFFICULTY_NORMAL ? 33809 : 33942);
                Creature* rubbleStalker = GetOwner()->FindNearestCreature(rubbleStalkerEntry, 200.0f, true);
                if (rubbleStalker)
                    rubbleStalker->CastSpell(rubbleStalker, SPELL_STONE_GRIP_CANCEL, true);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_ulduar_stone_grip_absorb_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ulduar_stone_grip_absorb_AuraScript();
        }
};

class spell_ulduar_stone_grip : public SpellScriptLoader
{
    public:
        spell_ulduar_stone_grip() : SpellScriptLoader("spell_ulduar_stone_grip") { }

        class spell_ulduar_stone_grip_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ulduar_stone_grip_AuraScript);

            void OnRemoveStun(AuraEffect const* aurEff, AuraEffectHandleModes mode)
            {
                if (!(mode & AURA_EFFECT_HANDLE_REAL))
                    return;

                if (Player* pOwner = GetOwner()->ToPlayer())
                    pOwner->RemoveAurasDueToSpell(aurEff->GetAmount());
            }

            void OnRemoveVehicle(AuraEffect const* aurEff, AuraEffectHandleModes mode)
            {
                if (!(mode & AURA_EFFECT_HANDLE_REAL))
                    return;

                if (GetOwner()->GetTypeId() != TYPEID_UNIT)
                    return;

                Player* pCaster = GetCaster() ? GetCaster()->ToPlayer() : NULL;
                if (!pCaster || !pCaster->IsOnVehicle(GetOwner()->ToUnit()))
                    return;

                pCaster->RemoveAurasDueToSpell(GetId());
                pCaster->ExitVehicle();
                pCaster->GetMotionMaster()->MoveJump(1756.25f + irand(-3, 3), -8.3f + irand(-3, 3), 448.8f, 5.0f, 5.0f);
                PreventDefaultAction();
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_ulduar_stone_grip_AuraScript::OnRemoveVehicle, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_ulduar_stone_grip_AuraScript::OnRemoveStun, EFFECT_2, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ulduar_stone_grip_AuraScript();
        }
};

void AddSC_boss_kologarn()
{
    new boss_kologarn();
    new npc_focused_eyebeam();
    new npc_left_arm();
    new npc_right_arm();
    new spell_ulduar_rubble_summon();
    new spell_ulduar_squeezed_lifeless();
    new spell_ulduar_cancel_stone_grip();
    new spell_ulduar_stone_grip_cast_target();
    new spell_ulduar_stone_grip_absorb();
    new spell_ulduar_stone_grip();
}
