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

#define SPELL_FOCUSED_EYEBEAM   63347
#define SPELL_EYEBEAM_VISUAL_1  63676
#define SPELL_EYEBEAM_VISUAL_2  63702
#define SPELL_EYEBEAM_IMMUNITY  64722

#define NPC_RUBBLE_STALKER      RAID_MODE(33809,33942)
#define SPELL_SUMMON_RUBBLE     63633
#define SPELL_FALLING_RUBBLE    63821

#define SPELL_STONE_GRIP_CANCEL 65594

#define SPELL_ARM_SWEEP         RAID_MODE(63766,63983)

#define SPELL_ARM_ENTER_VEHICLE 65343
#define SPELL_ARM_VISUAL        64753

#define SPELL_BERSERK           47008 // guess

#define NPC_LEFT_ARM            32933//RAID_MODE(32933,33910)
#define NPC_RIGHT_ARM           32934//RAID_MODE(32934,33911)
#define NPC_EYEBEAM_1           33632
#define NPC_EYEBEAM_2           33802
#define NPC_RUBBLE              33768

// Achievements
#define ACHIEVEMENT_LOOKS_COULD_KILL            RAID_MODE(2955, 2956) // TODO
#define ACHIEVEMENT_RUBBLE_AND_ROLL             RAID_MODE(2959, 2960)
#define ACHIEVEMENT_WITH_OPEN_ARMS              RAID_MODE(2951, 2952)

enum Events
{
    EVENT_NONE = 0,
    //EVENT_MELEE_CHECK,
    EVENT_SMASH,
    EVENT_SWEEP,
    EVENT_STONE_SHOUT,
    EVENT_SHOCKWAVE,
    EVENT_EYEBEAM,
    EVENT_STONE_GRIP,
    EVENT_RIGHT_ARM_DEAD,
    EVENT_RESPAWN_LEFT_ARM,
    EVENT_RESPAWN_RIGHT_ARM,
    EVENT_ENRAGE,
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
    SAY_BERSERK                                 = -1603238,
};

enum
{
    ACHIEV_DISARMED_START_EVENT                   = 21687,
};

enum KologarnChests
{
    CACHE_OF_LIVING_STONE_10                    = 195046,
    CACHE_OF_LIVING_STONE_25                    = 195047
};

const Position RubbleLeft   = {1781.814f, -45.07f, 448.808f, 2.260f};
const Position RubbleRight  = {1781.814f, -3.716f, 448.808f, 4.211f};

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
            ASSERT(vehicle);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
            SetCombatMovement(false);
            emerged = false;
        }

        Vehicle *vehicle;
        bool left, right;
        bool emerged;
        bool eyeBeamHit;
        uint32 RubbleCount;
        
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

        void EnterCombat(Unit * who)
        {
            DoScriptText(SAY_AGGRO, me);
            _EnterCombat();

            for (int32 n = 0; n < 2; ++n)
                if (vehicle->GetPassenger(n))
                    vehicle->GetPassenger(n)->ToCreature()->AI()->DoZoneInCombat();
            
            //events.ScheduleEvent(EVENT_MELEE_CHECK, 10000);
            events.ScheduleEvent(EVENT_SMASH, 5000);
            events.ScheduleEvent(EVENT_STONE_GRIP, 25000);
            events.ScheduleEvent(EVENT_ENRAGE, 600000);
            events.ScheduleEvent(EVENT_EYEBEAM, 10000);
            events.ScheduleEvent(EVENT_SHOCKWAVE, 12000);
            
            RubbleCount = 0;            
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

        void JustDied(Unit * /*victim*/)
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
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
        }

        void AttackStart(Unit *who)
        {
            me->Attack(who, true);
        }

        void PassengerBoarded(Unit *who, int8 /*seatId*/, bool apply)
        {
            if (who->GetEntry() == NPC_LEFT_ARM)
            {
                left = apply;
                if (apply)
                {
                    who->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
                }
                else
                {
                    if (instance && right)
                        instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    events.ScheduleEvent(EVENT_RESPAWN_LEFT_ARM, 40000);
                    DoScriptText(SAY_LEFT_ARM_GONE, me);
                }
            }

            else if (who->GetEntry() == NPC_RIGHT_ARM)
            {
                right = apply;
                if (apply)
                {
                    who->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
                }
                else
                {
                    if (instance && left)
                        instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    events.ScheduleEvent(EVENT_RESPAWN_RIGHT_ARM, 40000);
                    DoScriptText(SAY_RIGHT_ARM_GONE, me);
                }
            }

            if (!apply)
            {
                me->DealDamage(me, int32(me->GetMaxHealth() * 15 / 100)); // decreases Kologarn's health by 15%
                //who->CastSpell(me, SPELL_ARM_DEAD_DAMAGE, true);
                
                if (Creature* rubbleStalker = me->FindNearestCreature(NPC_RUBBLE_STALKER, 20.0f))
                {
                    if (rubbleStalker)
                    {
                        rubbleStalker->CastSpell(rubbleStalker, SPELL_FALLING_RUBBLE, true);
                        //rubbleStalker->CastSpell(rubbleStalker, SPELL_SUMMON_RUBBLE, true);
                    }
                }
                
                ++RubbleCount;

                if (!right && !left)
                    events.ScheduleEvent(EVENT_STONE_SHOUT, 5000);

                //if (instance)
                //    instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
            }

            if (apply)
                events.CancelEvent(EVENT_STONE_SHOUT);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!me->getVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            if (events.GetTimer() > 15000 && !me->IsWithinMeleeRange(me->getVictim()))
                DoCastAOE(SPELL_PETRIFY_BREATH, true);

            switch (events.GetEvent())
            {
                //case EVENT_MELEE_CHECK:
                    //if (!me->IsWithinMeleeRange(me->getVictim()))
                    //    DoCast(SPELL_PETRIFY_BREATH);
                    //events.RepeatEvent(1000);
                 //   break;
                case EVENT_SWEEP:
                    DoCast(SPELL_ARM_SWEEP);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SMASH:
                    if (left && right)
                    {
                        if (me->IsWithinMeleeRange(me->getVictim()))
                            DoCastVictim(SPELL_TWO_ARM_SMASH);
                    }
                    else if (left || right)
                    {
                        if (me->IsWithinMeleeRange(me->getVictim()))
                            DoCastVictim(SPELL_ONE_ARM_SMASH);
                    }
                    events.RepeatEvent(15000);
                    break;
                case EVENT_STONE_SHOUT:
                    DoCast(SPELL_STONE_SHOUT);
                    events.RepeatEvent(2000);
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
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_FARTHEST, 0, 50, true))
                    {
                        if (Creature* EyeBeam = me->SummonCreature(NPC_EYEBEAM_1,pTarget->GetPositionX(),pTarget->GetPositionY()+3,pTarget->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN,10000))
                        {
                            EyeBeam->CastSpell(me, SPELL_EYEBEAM_VISUAL_1, true);
                            EyeBeam->AI()->AttackStart(pTarget);
                        }
                        if (Creature* EyeBeam = me->SummonCreature(NPC_EYEBEAM_2,pTarget->GetPositionX(),pTarget->GetPositionY()-3,pTarget->GetPositionZ(),0,TEMPSUMMON_TIMED_DESPAWN,10000))
                        {
                            EyeBeam->CastSpell(me, SPELL_EYEBEAM_VISUAL_2, true);
                            EyeBeam->AI()->AttackStart(pTarget);
                        }
                    }
                    events.RescheduleEvent(EVENT_EYEBEAM, 20000);
                    break;
                case EVENT_ENRAGE:
                    DoCast(SPELL_BERSERK);
                    DoScriptText(SAY_BERSERK, me);
                    break;
                case EVENT_RESPAWN_LEFT_ARM:
                {
                    if (Unit* LeftArm = me->SummonCreature(NPC_LEFT_ARM, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        LeftArm->EnterVehicle(vehicle, 0);
                        DoCast(me, SPELL_ARM_VISUAL, true);
                        if (instance)
                            instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    }
                    events.CancelEvent(EVENT_RESPAWN_LEFT_ARM);                   
                    break;
                }
                case EVENT_RESPAWN_RIGHT_ARM:
                {
                    if (Unit* RightArm = me->SummonCreature(NPC_RIGHT_ARM, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        RightArm->EnterVehicle(vehicle, 1);
                        DoCast(me, SPELL_ARM_VISUAL, true);
                        if (instance)
                            instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_DISARMED_START_EVENT);
                    }             
                    events.CancelEvent(EVENT_RESPAWN_RIGHT_ARM);             
                    break;
                }
                case EVENT_STONE_GRIP:
                {
                    if (right)
                    {
                        std::list<Unit*> targetList;
                        std::list<Unit*>::const_iterator itr;
                        for (int i = 0; i < RAID_MODE(1, 3); i++)
                            if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                                targetList.push_back(pTarget);                    
                        //SelectTargetList(targetList, RAID_MODE(1, 3), SELECT_TARGET_RANDOM, 0.0f, true);
                        for (itr = targetList.begin(); itr != targetList.end(); ++itr)
                        {
                            DoCast((*itr), SPELL_STONE_GRIP, true);
                            /* 10 man: */
                            // Cast 62056 -> HandleAuraLinked (64224) -> Apply 64224 -> Absorb damage
                            //            -> Apply Stun with basepoints 64290
                            // Cast 64290 -> Trigger spell (64708) Squeezed Lifeless
                            //            -> Periodic damage 
                            // Cast 63962 -> Visual
                        }
                        DoScriptText(SAY_GRAB_PLAYER, me);
                    }
                    events.RepeatEvent(25000);
                }
                break;
            }

            DoMeleeAttackIfReady();
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

            uint32 spellId = GetEffectValue();
            for (uint8 i = 0; i < 5; ++i)
                caster->CastSpell(caster, spellId, true);
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

class spell_ulduar_stone_grip_absorb : public SpellScriptLoader
{
public:
    spell_ulduar_stone_grip_absorb() : SpellScriptLoader("spell_ulduar_stone_grip_absorb") { }

    class spell_ulduar_stone_grip_absorb_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ulduar_stone_grip_absorb_AuraScript);

        //! This will be called when Right Arm (vehicle) has sustained a specific amount of damage depending on instance mode
        //! What we do here is remove all harmful aura's related and teleport to safe spot.
        void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
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
            GetOwner()->ToUnit()->RemoveAurasDueToSpell(SpellMgr::CalculateSpellEffectAmount(GetSpellProto(), EFFECT_2));
            // Spellsystem doesn't recognize EFFECT_0 as actionable effect on dispel for some reason, manually do it here
            GetOwner()->ToUnit()->ExitVehicle();
            GetOwner()->ToUnit()->NearTeleportTo(1756.25f + irand(-3, 3), -8.3f + irand(-3, 3), 448.8f, 3.62f);
        }

        void Register()
        {
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
    new spell_ulduar_cancel_stone_grip();
    new spell_ulduar_stone_grip_absorb();
    new spell_ulduar_stone_grip();
}
