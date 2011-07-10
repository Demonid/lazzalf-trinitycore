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
SDName: boss_anubarak_trial
SD%Complete: ??%
SDComment: based on /dev/rsa
SDCategory:
EndScriptData */

// Known bugs:
// Anubarak - underground phase partially not worked
//          - tele after impale hit a permafrost doesn't work (the entire tele spell should be better)
// Burrow   - visual is vanishing
// Burrower - Spider Frenzy not working as it should (frenzy not stacking)
// Scarab   - Kill credit isn't crediting?
// FrostSph - often they are casting Permafrost a little above the ground

#include "ScriptPCH.h"
#include "trial_of_the_crusader.h"

enum Yells
{
    SAY_INTRO               = -1649055,
    SAY_AGGRO               = -1649056,
    SAY_KILL1               = -1649057,
    SAY_KILL2               = -1649058,
    SAY_DEATH               = -1649059,
    EMOTE_SPIKE             = -1649060,
    SAY_BURROWER            = -1649061,
    EMOTE_LEECHING_SWARM    = -1649062,
    SAY_LEECHING_SWARM      = -1649063,
};

enum Summons
{
    NPC_FROST_SPHERE     = 34606,
    NPC_BURROW           = 34862,
    NPC_BURROWER         = 34607,
    NPC_SCARAB           = 34605,
    NPC_SPIKE            = 34660,
};

enum BossSpells
{
    SPELL_FREEZE_SLASH      = 66012,
    SPELL_PENETRATING_COLD  = 66013,
    SPELL_LEECHING_SWARM    = 66118,
    SPELL_LEECHING_HEAL     = 66125,
    SPELL_LEECHING_DAMAGE   = 66240,
    SPELL_MARK              = 67574,
    SPELL_SPIKE_CALL        = 66169,
    SPELL_SUBMERGE_ANUBARAK = 65981,
    SPELL_CLEAR_ALL_DEBUFFS = 34098,
    SPELL_EMERGE_ANUBARAK   = 65982,
    SPELL_SUMMON_BEATLES    = 66339,
    SPELL_SUMMON_BURROWER   = 66332,

    // Burrow
    SPELL_CHURNING_GROUND   = 66969,

    // Scarab
    SPELL_DETERMINATION     = 66092,
    SPELL_ACID_MANDIBLE     = 65774, //Passive - Triggered

    // Burrower
    SPELL_SPIDER_FRENZY     = 66128,
    SPELL_EXPOSE_WEAKNESS   = 67720, //Passive - Triggered
    SPELL_SHADOW_STRIKE     = 66134,
    SPELL_SUBMERGE_EFFECT   = 53421,
    SPELL_EMERGE_EFFECT     = 66947,

    SUMMON_SCARAB           = NPC_SCARAB,
    SUMMON_FROSTSPHERE      = NPC_FROST_SPHERE,
    SPELL_BERSERK           = 26662,

    //Frost Sphere
    SPELL_FROST_SPHERE      = 67539,
    SPELL_PERMAFROST        = 66193,
    SPELL_PERMAFROST_VISUAL = 65882,

    //Spike
    SPELL_SUMMON_SPIKE      = 66169,
    SPELL_SPIKE_SPEED1      = 65920,
    SPELL_SPIKE_TRAIL       = 65921,
    SPELL_SPIKE_SPEED2      = 65922,
    SPELL_SPIKE_SPEED3      = 65923,
    SPELL_SPIKE_FAIL        = 66181,
    SPELL_SPIKE_TELE        = 66170,
};

#define SPELL_PERMAFROST_HELPER RAID_MODE<uint32>(66193,67856,67855,67857)

enum SummonActions
{
    ACTION_SHADOW_STRIKE,
    ACTION_SCARAB_SUBMERGE,
};

const Position SphereSpawn[6] =
{
    { 786.6439f, 108.2498f, 155.6701f, 0 },
    { 806.8429f, 150.5902f, 155.6701f, 0 },
    { 759.1386f, 163.9654f, 155.6701f, 0 },
    { 744.3701f, 119.5211f, 155.6701f, 0 },
    { 710.0211f, 120.8152f, 155.6701f, 0 },
    { 706.6383f, 161.5266f, 155.6701f, 0 },
};

class boss_anubarak_trial : public CreatureScript
{
public:
    boss_anubarak_trial() : CreatureScript("boss_anubarak_trial") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_anubarak_trialAI(creature);
    };

    struct boss_anubarak_trialAI : public ScriptedAI
    {
        boss_anubarak_trialAI(Creature* creature) : ScriptedAI(creature), Summons(me)
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            //me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            m_pInstance = creature->GetInstanceScript();
        }

        SummonList Summons;
        std::list<uint64> m_vBurrowGUID;
        uint64 m_aSphereGUID[6];

        uint32 m_uiFreezeSlashTimer;
        uint32 m_uiPenetratingColdTimer;
        uint32 m_uiSummonNerubianTimer;
        uint32 m_uiNerubianShadowStrikeTimer;
        uint32 m_uiSubmergeTimer;
        uint32 m_uiPursuingSpikeTimer;
        uint32 m_uiSummonScarabTimer;
        uint32 m_uiSummonFrostSphereTimer;
        uint32 m_uiBerserkTimer;

        InstanceScript* m_pInstance;
        uint8  m_uiStage;
        bool   m_bIntro;
        bool   m_bReachedPhase3;
        uint8  m_uiScarabSummoned;
        bool   find_debuff;

        void Reset()
        {
            m_uiFreezeSlashTimer = 15*IN_MILLISECONDS;
            m_uiPenetratingColdTimer = 20*IN_MILLISECONDS;
            m_uiNerubianShadowStrikeTimer = 30*IN_MILLISECONDS;
            m_uiSummonNerubianTimer = 10*IN_MILLISECONDS;
            m_uiSubmergeTimer = 80*IN_MILLISECONDS;

            m_uiPursuingSpikeTimer = 2*IN_MILLISECONDS;
            m_uiSummonScarabTimer = 2*IN_MILLISECONDS;

            m_uiSummonFrostSphereTimer = 20*IN_MILLISECONDS;

            m_uiBerserkTimer = 10*MINUTE*IN_MILLISECONDS;
            m_uiStage = 0;
            m_uiScarabSummoned = 0;
            m_bIntro = true;
            m_bReachedPhase3 = false;
            find_debuff = true;
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            Summons.DespawnAll();
            m_vBurrowGUID.clear();
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

        void MoveInLineOfSight(Unit* /*who*/)
        {
            if (!m_bIntro)
            {
                DoScriptText(SAY_INTRO, me);
                m_bIntro = false;
            }
        }

        void JustReachedHome()
        {
            if (m_pInstance)
                m_pInstance->SetData(TYPE_ANUBARAK, FAIL);
            //Summon Scarab Swarms neutral at random places
            for (int i=0; i < 10; i++)
                if (Creature* pTemp = me->SummonCreature(NPC_SCARAB, AnubarakLoc[1].GetPositionX()+urand(0, 50)-25, AnubarakLoc[1].GetPositionY()+urand(0, 50)-25, AnubarakLoc[1].GetPositionZ()))
                    pTemp->setFaction(31);
        }

        void JustDied(Unit* /*killer*/)
        {
            Summons.DespawnAll();
            DoScriptText(SAY_DEATH, me);
            if (m_pInstance)
            {
                m_pInstance->SetData(TYPE_ANUBARAK, SPECIAL);
                m_pInstance->SetData(TYPE_ANUBARAK, DONE);
            }
        }

        void JustSummoned(Creature* summoned)
        {
            switch (summoned->GetEntry())
            {
                case NPC_BURROW:
                    m_vBurrowGUID.push_back(summoned->GetGUID());
                    summoned->SetReactState(REACT_PASSIVE);
                    summoned->CastSpell(summoned, SPELL_CHURNING_GROUND, false);
                    break;
					/*
                case NPC_SPIKE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    {
                        if (m_pInstance)
                            sLog->outBoss("Anub Id: %u, Setting Spike Target, target GUID: %u", m_pInstance->instance->GetInstanceId(), target->GetGUID());
                        m_uiTargetGUID = target->GetGUID();
                        summoned->CombatStart(target);
                        DoScriptText(EMOTE_SPIKE, me, target);
                    }
                    break;
					*/
            }
            Summons.Summon(summoned);
        }

        void SummonedCreatureDespawn(Creature* summoned)
        {
            switch (summoned->GetEntry())
            {
                case NPC_SPIKE:
                    m_uiPursuingSpikeTimer = 2*IN_MILLISECONDS;
                    break;
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetInCombatWithZone();
            if (m_pInstance)
                m_pInstance->SetData(TYPE_ANUBARAK, IN_PROGRESS);
            //Despawn Scarab Swarms neutral
            Summons.DoAction(NPC_SCARAB, ACTION_SCARAB_SUBMERGE);
            //Spawn Burrow
            for (int i = 0; i < 4; i++)
                me->SummonCreature(NPC_BURROW, AnubarakLoc[i+2]);
            //Spawn Frost Spheres
            for (int i = 0; i < 6; i++)
                if (Unit* summoned = me->SummonCreature(NPC_FROST_SPHERE, SphereSpawn[i]))
                    m_aSphereGUID[i] = summoned->GetGUID();
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            switch (m_uiStage)
            {
                case 0:
                    if (m_uiFreezeSlashTimer <= uiDiff)
                    {
                        DoCastVictim(SPELL_FREEZE_SLASH);
                        m_uiFreezeSlashTimer = 15*IN_MILLISECONDS;
                    } else m_uiFreezeSlashTimer -= uiDiff;

                    if (m_uiPenetratingColdTimer <= uiDiff)
                    {
                        me->CastCustomSpell(SPELL_PENETRATING_COLD, SPELLVALUE_MAX_TARGETS, RAID_MODE(2, 5, 2, 5));
                        m_uiPenetratingColdTimer = 20*IN_MILLISECONDS;
                    } else m_uiPenetratingColdTimer -= uiDiff;

                    if (m_uiSummonNerubianTimer <= uiDiff && (IsHeroic() || !m_bReachedPhase3))
                    {
                        me->CastCustomSpell(SPELL_SUMMON_BURROWER, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 2, 2, 4));
                        m_uiSummonNerubianTimer = 90*IN_MILLISECONDS;
                    } else m_uiSummonNerubianTimer -= uiDiff;

                    if (IsHeroic() && m_uiNerubianShadowStrikeTimer <= uiDiff)
                    {
                        Summons.DoAction(NPC_BURROWER, ACTION_SHADOW_STRIKE);
                        m_uiNerubianShadowStrikeTimer = 30*IN_MILLISECONDS;
                    } else m_uiNerubianShadowStrikeTimer -= uiDiff;

                    if (m_uiSubmergeTimer <= uiDiff && !m_bReachedPhase3 && !me->HasAura(SPELL_BERSERK))
                    {
                        m_uiStage = 1;
                        m_uiSubmergeTimer = 60*IN_MILLISECONDS;
                    } else m_uiSubmergeTimer -= uiDiff;
                    break;
                case 1:
                    DoCast(me, SPELL_SUBMERGE_ANUBARAK);
                    DoCast(me, SPELL_CLEAR_ALL_DEBUFFS);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    DoScriptText(SAY_BURROWER, me);
                    m_uiScarabSummoned = 0;
                    m_uiSummonScarabTimer = 4*IN_MILLISECONDS;
                    m_uiStage = 2;
                    break;
                case 2:
                    if (m_uiPursuingSpikeTimer <= uiDiff)
                    {                        
                        DoCast(SPELL_SPIKE_CALL);
                        // Just to make sure it won't happen again in this phase
                        m_uiPursuingSpikeTimer = 90*IN_MILLISECONDS;
                    } else m_uiPursuingSpikeTimer -= uiDiff;

                    if (m_uiSummonScarabTimer <= uiDiff)
                    {
                        /* WORKAROUND
                         * - The correct implementation is more likely the comment below but it needs spell knowledge
                         */
                        std::list<uint64>::iterator i = m_vBurrowGUID.begin();
                        uint32 at = urand(0, m_vBurrowGUID.size()-1);
                        for (uint32 k = 0; k < at; k++)
                            ++i;
                        if (Creature *pBurrow = Unit::GetCreature(*me, *i))
                            pBurrow->CastSpell(pBurrow, 66340, false);
                        m_uiScarabSummoned++;
                        m_uiSummonScarabTimer = 4*IN_MILLISECONDS;
                        if (m_uiScarabSummoned == 4) m_uiSummonScarabTimer = RAID_MODE(4, 20)*IN_MILLISECONDS;

                        /*It seems that this spell have something more that needs to be taken into account
                        //Need more sniff info
                        DoCast(SPELL_SUMMON_BEATLES);
                        // Just to make sure it won't happen again in this phase
                        m_uiSummonScarabTimer = 90*IN_MILLISECONDS;*/
                    } else m_uiSummonScarabTimer -= uiDiff;

                    if (m_uiSummonNerubianTimer <= uiDiff && (IsHeroic() || !m_bReachedPhase3))
                    {
                        me->CastCustomSpell(SPELL_SUMMON_BURROWER, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 2, 2, 4));
                        m_uiSummonNerubianTimer = 90*IN_MILLISECONDS;
                    } else m_uiSummonNerubianTimer -= uiDiff;

                    if (m_uiSubmergeTimer <= uiDiff)
                    {
                        m_uiStage = 3;
                        m_uiSubmergeTimer = 80*IN_MILLISECONDS;
                    } else m_uiSubmergeTimer -= uiDiff;
                    break;
                case 3:
                    m_uiStage = 0;
                    DoCast(SPELL_SPIKE_TELE);
                    Summons.DespawnEntry(NPC_SPIKE);
                    me->RemoveAurasDueToSpell(SPELL_SUBMERGE_ANUBARAK);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    DoCast(me, SPELL_EMERGE_ANUBARAK);
                    me->GetMotionMaster()->MoveChase(me->getVictim());
                    m_uiSummonNerubianTimer = 10*IN_MILLISECONDS;
                    m_uiNerubianShadowStrikeTimer = 30*IN_MILLISECONDS;
                    m_uiSummonScarabTimer = 2*IN_MILLISECONDS;
                    break;
            }

            if (!IsHeroic())
            {
                if (m_uiSummonFrostSphereTimer <= uiDiff)
                {
                    uint8 startAt = urand(0, 5);
                    uint8 i = startAt;
                    do
                    {
                        if (Unit *pSphere = Unit::GetCreature(*me, m_aSphereGUID[i]))
                        {
                            if (!pSphere->HasAura(SPELL_FROST_SPHERE))
                            {
                                if (Creature* pSummon = me->SummonCreature(NPC_FROST_SPHERE, SphereSpawn[i]))
                                    m_aSphereGUID[i] = pSummon->GetGUID();
                                break;
                            }
                        }
                        else if (Creature* pSummon = me->SummonCreature(NPC_FROST_SPHERE, SphereSpawn[i]))
                            m_aSphereGUID[i] = pSummon->GetGUID(); 
                        i = (i+1)%6;
                    } while (i != startAt);
                    m_uiSummonFrostSphereTimer = urand(20, 30)*IN_MILLISECONDS;
                } else m_uiSummonFrostSphereTimer -= uiDiff;
            }

            if (!find_debuff)
            {
                Map::PlayerList const &players = m_pInstance->instance->GetPlayers();                
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    Player* player = itr->getSource();
                    if (!player)
                        continue;
                    if (player->HasAura(66118) || 
                        player->HasAura(67630) ||
                        player->HasAura(68646) ||
                        player->HasAura(68647))
                    {
                        find_debuff = true;
                        break;
                    }
                }
                if (!find_debuff)
                {
                    DoCastAOE(SPELL_LEECHING_SWARM);
                    DoScriptText(EMOTE_LEECHING_SWARM, me);
                    DoScriptText(SAY_LEECHING_SWARM, me);
                }
            }

            if (HealthBelowPct(30) && m_uiStage == 0 && !m_bReachedPhase3)
            {
                m_bReachedPhase3 = true;
                find_debuff = false;
                DoCastAOE(SPELL_LEECHING_SWARM);
                DoScriptText(EMOTE_LEECHING_SWARM, me);
                DoScriptText(SAY_LEECHING_SWARM, me);
            }

            if (m_uiBerserkTimer <= uiDiff && !me->HasAura(SPELL_BERSERK))
            {
                DoCast(me, SPELL_BERSERK);
            } else m_uiBerserkTimer -= uiDiff;

            if (m_uiStage != 2)
                DoMeleeAttackIfReady();
        }
    };

};

class mob_anubarak_spike : public CreatureScript
{
public:
    mob_anubarak_spike() : CreatureScript("mob_anubarak_spike") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_anubarak_spikeAI(creature);
    };

    struct mob_anubarak_spikeAI : public ScriptedAI
    {
        mob_anubarak_spikeAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = (InstanceScript*)creature->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            //if (m_pInstance)
            //    sLog->outBoss("Anub Spike Id: %u,  Created", m_pInstance->instance->GetInstanceId());

            // For an unknown reason this npc isn't recognize the Aura of Permafrost with this flags =/
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE);
            
            m_uiIncreaseSpeedTimer = 0;
            m_uiTargetGUID = 0;    
        }

        InstanceScript* m_pInstance;
        uint32 m_uiIncreaseSpeedTimer;
        uint8  m_uiSpeed;
        uint64 m_uiTargetGUID;

        void Reset()
        {
            //if (m_pInstance)
            //    sLog->outBoss("Anub Spike Id: %u,  Reset", m_pInstance->instance->GetInstanceId());

            if (Unit* target = CheckPlayersInRange(1, 0.0f, 120.f))
                if (target && target->isAlive())
                {
                    m_uiTargetGUID = target->GetGUID();
                    //if (m_pInstance)
                    //    sLog->outBoss("Anub Spike Id: %u,  Enter combat, target GUID: %u", m_pInstance->instance->GetInstanceId(), m_uiTargetGUID);
                    DoScriptText(EMOTE_SPIKE, me, target);
                    me->CombatStart(target);
                    DoCast(target, SPELL_MARK);
                    me->SetSpeed(MOVE_RUN, 0.5f);
                    m_uiSpeed = 0;
                    m_uiIncreaseSpeedTimer = 1*IN_MILLISECONDS;
                    me->TauntApply(target);
                }
        }

        /*
        void EnterCombat(Unit* who)
        {
            if (m_pInstance)
                sLog->outBoss("Anub Spike Id: %u,  Enter combat, target GUID: %u", m_pInstance->instance->GetInstanceId(), m_uiTargetGUID);            
        }
        */

        void DamageTaken(Unit* /*who*/, uint32& uiDamage)
        {
            uiDamage = 0;
        }

        Unit* CheckPlayersInRange(uint32 uiPlayersMin, float uiRangeMin, float uiRangeMax)
        {
            Map * pMap = me->GetMap();
            if (pMap)
            {                
                uint32 uplayerfound = 0;
                std::list<Player*> PlayerList;
                Map::PlayerList const &Players = pMap->GetPlayers();
                for (Map::PlayerList::const_iterator itr = Players.begin(); itr != Players.end(); ++itr)
                {
                    if (Player * pPlayer = itr->getSource())
                    {
                        float uiDistance = pPlayer->GetDistance(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                        if (uiDistance < uiRangeMin || uiRangeMax < uiDistance)
                            continue;

                        uplayerfound++;
                        
                        if (!pPlayer->isAlive() || pPlayer->isGameMaster())
                            continue;

                        PlayerList.push_back(pPlayer);
                    }
                }

                if (PlayerList.empty())
                    return NULL;

                size_t size = PlayerList.size();
                if (uplayerfound < uiPlayersMin)
                    return NULL;

                std::list<Player*>::const_iterator itr = PlayerList.begin();
                std::advance(itr, urand(0, size - 1));
                return *itr;
            }
            else
                return NULL;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            //if (m_pInstance)
            //    sLog->outBoss("Anub Spike Id: %u,  UpdateAI, target GUID: %u", m_pInstance->instance->GetInstanceId(), m_uiTargetGUID);

            if (!me->GetAura(66193) && !me->GetAura(67855) && 
                !me->GetAura(67856) && !me->GetAura(67857))
                me->RemoveAurasWithMechanic(1 << MECHANIC_SNARE);

            Unit* target = Unit::GetPlayer(*me, m_uiTargetGUID);

            if (me->getVictim() && !me->getVictim()->ToPlayer())
            {
                me->Kill(me->getVictim());
                if (target)
                    me->TauntApply(target);
            }

            if (!target || !target->isAlive() || !target->HasAura(SPELL_MARK))
            {
                if (Unit* target = me->FindNearestCreature(NPC_FROST_SPHERE, 15.0f))
                    target->RemoveFromWorld();
                if (Creature* pAnubarak = Unit::GetCreature((*me), m_pInstance->GetData64(NPC_ANUBARAK)))
                    pAnubarak->CastSpell(pAnubarak, SPELL_SPIKE_TELE, false);
                me->DisappearAndDie();
                return;
            }

            if (m_uiIncreaseSpeedTimer)
            {
                if (m_uiIncreaseSpeedTimer <= uiDiff)
                {
                    switch (m_uiSpeed)
                    {
                        case 0:
                            DoCast(me, SPELL_SPIKE_SPEED1);
                            DoCast(me, SPELL_SPIKE_TRAIL);
                            m_uiSpeed = 1;
                            m_uiIncreaseSpeedTimer = 7*IN_MILLISECONDS;
                            break;
                        case 1:
                            DoCast(me, SPELL_SPIKE_SPEED2);
                            m_uiSpeed = 2;
                            m_uiIncreaseSpeedTimer = 7*IN_MILLISECONDS;
                            break;
                        case 2:
                            DoCast(me, SPELL_SPIKE_SPEED3);
                            m_uiIncreaseSpeedTimer = 0;
                            break;
                        default:
                            break;
                    }
                } else m_uiIncreaseSpeedTimer -= uiDiff;
            }
        }
    };

};

class mob_swarm_scarab : public CreatureScript
{
public:
    mob_swarm_scarab() : CreatureScript("mob_swarm_scarab") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_swarm_scarabAI(creature);
    };

    struct mob_swarm_scarabAI : public ScriptedAI
    {
        mob_swarm_scarabAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = (InstanceScript*)creature->GetInstanceScript();
            if (IsHeroic())
            {
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT,SPELL_EFFECT_ATTACK_ME, true);
            }
        }

        InstanceScript* m_pInstance;

        uint32 m_uiDeterminationTimer;

        void Reset()
        {
            me->SetCorpseDelay(0);
            m_uiDeterminationTimer = urand(5*IN_MILLISECONDS, 60*IN_MILLISECONDS);
            DoCast(me, SPELL_ACID_MANDIBLE);
            me->SetInCombatWithZone();
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                me->AddThreat(target, 20000.0f);
            if (!me->isInCombat())
                me->DisappearAndDie();
        }

        void DoAction(const int32 actionId)
        {
            switch (actionId)
            {
                case ACTION_SCARAB_SUBMERGE:
                    DoCast(SPELL_SUBMERGE_EFFECT);
                    me->DespawnOrUnsummon(1000);
                    break;
            }
        }

        void JustDied(Unit* killer)
        {
            // DoCast(killer, RAID_MODE(SPELL_TRAITOR_KING_10, SPELL_TRAITOR_KING_25));

            if(m_pInstance->GetData(DATA_TRAITOR_KING) == ACHI_IS_NOT_STARTED)
               m_pInstance->SetData(DATA_TRAITOR_KING, ACHI_START);
           
            m_pInstance->SetData(DATA_TRAITOR_KING, ACHI_INCREASE);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            /* Bosskillers don't recognize */
            if (m_uiDeterminationTimer <= uiDiff)
            {
                DoCast(me, SPELL_DETERMINATION);
                m_uiDeterminationTimer = urand(10*IN_MILLISECONDS, 60*IN_MILLISECONDS);
            } else m_uiDeterminationTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};

class mob_nerubian_burrower : public CreatureScript
{
public:
    mob_nerubian_burrower() : CreatureScript("mob_nerubian_burrower") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_nerubian_burrowerAI(creature);
    };

    struct mob_nerubian_burrowerAI : public ScriptedAI
    {
        mob_nerubian_burrowerAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = (InstanceScript*)creature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;

        uint32 m_uiSpiderFrenzyTimer;
        uint32 m_uiSubmergeTimer;
        uint32 m_uiExposeWeaknessTimer;

        void Reset()
        {
            me->SetCorpseDelay(0);
            m_uiSpiderFrenzyTimer = urand(10*IN_MILLISECONDS, 20*IN_MILLISECONDS);
            m_uiSubmergeTimer = 30*IN_MILLISECONDS;
            m_uiExposeWeaknessTimer = 1* IN_MILLISECONDS;
            //DoCast(me, SPELL_EXPOSE_WEAKNESS);
            DoCast(me, SPELL_SPIDER_FRENZY);
            me->SetInCombatWithZone();
            if (!me->isInCombat())
                me->DisappearAndDie();
        }

        void DoAction(const int32 actionId)
        {
            switch (actionId)
            {
                case ACTION_SHADOW_STRIKE:
                    if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) && 
                        !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) &&
                        !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE) &&
                        !me->HasAura(SPELL_SUBMERGE_EFFECT))
                        if (Unit *target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            DoCast(target, SPELL_SHADOW_STRIKE);
                    break;
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if ((m_uiSubmergeTimer <= uiDiff) && HealthBelowPct(80))
            {
                if (me->HasAura(SPELL_SUBMERGE_EFFECT))
                {
                    me->RemoveAurasDueToSpell(SPELL_SUBMERGE_EFFECT);
                    DoCast(me, SPELL_EMERGE_EFFECT);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->CombatStart(me->SelectNearestTarget());
                }
                else
                {
                    if (!me->HasAura(SPELL_PERMAFROST_HELPER))
                    {
                        DoCast(me, SPELL_SUBMERGE_EFFECT);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                        me->CombatStop();
                    }
                }
                m_uiSubmergeTimer = 20*IN_MILLISECONDS;
            } else m_uiSubmergeTimer -= uiDiff;

            if (!me->HasAura(SPELL_SUBMERGE_EFFECT) && me->getVictim())
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);                
                if (m_uiExposeWeaknessTimer <= uiDiff)
                {
                    if (me->IsWithinMeleeRange(me->getVictim()))
                        DoCastVictim(SPELL_EXPOSE_WEAKNESS, true);
                    m_uiExposeWeaknessTimer = 2*IN_MILLISECONDS;
                }
                else 
                    m_uiExposeWeaknessTimer -= uiDiff;
            }

            if (!me->HasAura(SPELL_SUBMERGE_EFFECT))
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_OOC_NOT_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                DoMeleeAttackIfReady();
            }
        }
    };

};

class mob_frost_sphere : public CreatureScript
{
public:
    mob_frost_sphere() : CreatureScript("mob_frost_sphere") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_frost_sphereAI(creature);
    };

    struct mob_frost_sphereAI : public ScriptedAI
    {
        mob_frost_sphereAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = (InstanceScript*)creature->GetInstanceScript();
        }

        bool   m_bFall;
        uint32 m_uiPermafrostTimer;
        InstanceScript* m_pInstance;

        void Reset()
        {
            m_bFall = false;
            m_uiPermafrostTimer = 0;
            me->SetReactState(REACT_PASSIVE);
            me->SetFlying(true);
            me->SetDisplayId(25144);
            me->SetSpeed(MOVE_RUN, 0.5, false);
            me->GetMotionMaster()->MoveRandom(20.0f);
            DoCast(SPELL_FROST_SPHERE);
        }

        void DamageTaken(Unit* /*who*/, uint32& uiDamage)
        {
            if (me->GetHealth() < uiDamage)
            {
                uiDamage = 0;

                if (!m_bFall)
                {
                    m_bFall = true;
                    me->SetFlying(false);
                    me->GetMotionMaster()->MoveIdle();
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    //At hit the ground
                    me->GetMotionMaster()->MoveFall(142.2f, 0);
                    //me->FallGround(); //need correct vmap use (i believe it isn't working properly right now)
                }
            }
        }

        void MovementInform(uint32 uiType, uint32 uiId)
        {
            if (uiType != POINT_MOTION_TYPE) return;

            switch (uiId)
            {
                case 0:
                    m_uiPermafrostTimer = IN_MILLISECONDS;
                    break;
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_uiPermafrostTimer)
            {
                if (m_uiPermafrostTimer <= uiDiff)
                {
                    m_uiPermafrostTimer = 0;
                    me->RemoveAurasDueToSpell(SPELL_FROST_SPHERE);
                    me->SetDisplayId(11686);
                    me->SetFloatValue(OBJECT_FIELD_SCALE_X, 2.0f);
                    DoCast(SPELL_PERMAFROST_VISUAL);
                    DoCast(SPELL_PERMAFROST);
                } else m_uiPermafrostTimer -= uiDiff;
            }
        }
    };

};

void AddSC_boss_anubarak_trial()
{
    new boss_anubarak_trial();
    new mob_swarm_scarab();
    new mob_nerubian_burrower();
    new mob_anubarak_spike();
    new mob_frost_sphere();
}
