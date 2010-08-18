/* ScriptData
SDName: boss_anubarak_trial
SD%Complete: 70%
SDComment: by /dev/rsa
SDCategory:
EndScriptData */

// Anubarak - underground phase partially not worked, timers need correct
// Burrower - underground phase not implemented, buff not worked.
// Leecheng Swarm spell not worked - awaiting core support
// Anubarak spike aura worked only after 9750

#include "ScriptPCH.h"
#include "trial_of_crusader.h"

enum Summons
{
    NPC_FROST_SPHERE     = 34606,
    NPC_BURROWER         = 34607,
    NPC_SCARAB           = 34605,
    NPC_SPIKE            = 34660,
};

enum BossSpells
{
SPELL_COLD              = 66013,
SPELL_MARK              = 67574,
SPELL_LEECHING_SWARM    = 66118,
SPELL_LEECHING_HEAL     = 66125,
SPELL_LEECHING_DAMAGE   = 66240,
SPELL_IMPALE            = 65920,
SPELL_SPIKE_CALL        = 66169,
SPELL_POUND             = 66012,
SPELL_SHOUT             = 67730,
SPELL_SUBMERGE_0        = 53421,
SPELL_SUBMERGE_1        = 67322,
SPELL_SUMMON_BEATLES    = 66339,
SPELL_DETERMINATION     = 66092,
SPELL_ACID_MANDIBLE     = 67861,
SPELL_SPIDER_FRENZY     = 66129,
SPELL_EXPOSE_WEAKNESS   = 67847,
SUMMON_SCARAB           = NPC_SCARAB,
SUMMON_BORROWER         = NPC_BURROWER,
SUMMON_FROSTSPHERE      = NPC_FROST_SPHERE,
SPELL_BERSERK           = 26662,
SPELL_PERMAFROST        = 66193,
};

class boss_anubarak_trial : public CreatureScript
{
    public:
        boss_anubarak_trial(): CreatureScript("boss_anubarak_trial") {}

    struct boss_anubarak_trialAI : public ScriptedAI
    {
        boss_anubarak_trialAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            bsw = new BossSpellWorker(this);
            Reset();
        }

        InstanceScript* m_pInstance;
        uint8 stage;
        bool intro;
        BossSpellWorker* bsw;
        Unit* pTarget;

        void Reset() {
            if(!m_pInstance) return;
            stage = 0;
            intro = true;
           me->SetRespawnDelay(DAY);
            pTarget = NULL;
           me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
           me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }


        void KilledUnit(Unit* pVictim)
        {
            DoScriptText(-1713563,me);
        }

        void MoveInLineOfSight(Unit* pWho) 
        {
            if (!intro) return;
            DoScriptText(-1713554,me);
            intro = false;
           me->SetInCombatWithZone();
        }

        void JustReachedHome()
        {
            if (m_pInstance)
                m_pInstance->SetData(TYPE_ANUBARAK, FAIL);
    //           me->ForcedDespawn();
        }

        void JustDied(Unit* pKiller)
        {
            if (!m_pInstance) return;
                DoScriptText(-1713564,me);
                m_pInstance->SetData(TYPE_ANUBARAK, DONE);
        }

        void Aggro(Unit* pWho)
        {
            if (!intro) DoScriptText(-1713555,me);
           me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
           me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
           me->SetInCombatWithZone();
            m_pInstance->SetData(TYPE_ANUBARAK, IN_PROGRESS);
        }

        void UpdateAI(const uint32 uiDiff)
        {
		    if (!UpdateVictim())
                return;

            switch(stage)
            {
                case 0: {
                    bsw->timedCast(SPELL_POUND, uiDiff);
                    bsw->timedCast(SPELL_COLD, uiDiff);
                    if (bsw->timedQuery(SUMMON_BORROWER, uiDiff)) {
                            bsw->doCast(SUMMON_BORROWER);
                            DoScriptText(-1713556,me);
                            };
                    if (bsw->timedQuery(SPELL_SUBMERGE_0, uiDiff)) stage = 1;

                        break;}
                case 1: {
                        bsw->doCast(SPELL_SUBMERGE_0);
                       me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        stage = 2;
                        DoScriptText(-1713557,me);
                        break;}
                case 2: {
                        if (bsw->timedQuery(SPELL_SPIKE_CALL, uiDiff)) {
                             pTarget =bsw->SelectUnit();
    //                         bsw->doCast(SPELL_SPIKE_CALL);
    //                         This summon not supported in database. Temporary override.
                             Unit* spike = bsw->doSummon(NPC_SPIKE,TEMPSUMMON_TIMED_DESPAWN,60000);
                             if (spike) { spike->AddThreat(pTarget, 1000.0f);
                                          DoScriptText(-1713558,me,pTarget);
                                          bsw->doCast(SPELL_MARK,pTarget);
                                          spike->GetMotionMaster()->MoveChase(pTarget);
                                         }
                             };
                        if (bsw->timedQuery(SPELL_SUMMON_BEATLES, uiDiff)) {
                                bsw->doCast(SPELL_SUMMON_BEATLES);
                                bsw->doCast(SUMMON_SCARAB);
                                DoScriptText(-1713560,me);
                             };
                        if (bsw->timedQuery(SPELL_SUBMERGE_0, uiDiff)) stage = 3;
                        break;}
                case 3: {
                        stage = 0;
                        DoScriptText(-1713559,me);
                       me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        bsw->doRemove(SPELL_SUBMERGE_0,me);
                        break;}
                case 4: {
                                bsw->doCast(SPELL_LEECHING_SWARM);
                                DoScriptText(-1713561,me);
                        stage = 5;
                        break;}
                case 5: {
                            bsw->timedCast(SPELL_POUND, uiDiff);
                            bsw->timedCast(SPELL_COLD, uiDiff);
                            break;}

            }
            bsw->timedCast(SUMMON_FROSTSPHERE, uiDiff);

            bsw->timedCast(SPELL_BERSERK, uiDiff);

            if (me->GetHealthPercent() < 30.0f && stage == 0) stage = 4;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_anubarak_trialAI(pCreature);
    };
};

class mob_swarm_scarab : public CreatureScript
{
    public:
        mob_swarm_scarab(): CreatureScript("mob_swarm_scarab") {}

    struct mob_swarm_scarabAI : public ScriptedAI
    {
        mob_swarm_scarabAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = (InstanceScript*)pCreature->GetInstanceScript();
            bsw = new BossSpellWorker(this);
            Reset();
        }

        InstanceScript* m_pInstance;
        BossSpellWorker* bsw;

        void Reset()
        {
           me->SetInCombatWithZone();
           me->SetRespawnDelay(DAY);
        }

        void KilledUnit(Unit* pVictim)
        {
            if (pVictim->GetTypeId() != TYPEID_PLAYER) return;
        }

        void JustDied(Unit* Killer)
        {
        }

        void Aggro(Unit *who)
        {
            if (!m_pInstance) return;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_pInstance && m_pInstance->GetData(TYPE_ANUBARAK) != IN_PROGRESS) 
               me->ForcedDespawn();

            if (!UpdateVictim())
                return;

            bsw->timedCast(SPELL_DETERMINATION, uiDiff);

            bsw->timedCast(SPELL_ACID_MANDIBLE, uiDiff);

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_swarm_scarabAI(pCreature);
    };
};

class mob_nerubian_borrower : public CreatureScript
{
    public:
        mob_nerubian_borrower(): CreatureScript("mob_nerubian_borrower") {}

    struct mob_nerubian_borrowerAI : public ScriptedAI
    {
        mob_nerubian_borrowerAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = (InstanceScript*)pCreature->GetInstanceScript();
            bsw = new BossSpellWorker(this);
            Reset();
        }

        InstanceScript* m_pInstance;
        bool submerged;
        BossSpellWorker* bsw;
        Unit* currentTarget;

        void Reset()
        {
           me->SetInCombatWithZone();
           me->SetRespawnDelay(DAY);
            submerged = false;
            currentTarget = NULL;
        }

        void KilledUnit(Unit* pVictim)
        {
            if (pVictim->GetTypeId() != TYPEID_PLAYER) return;
        }

        void JustDied(Unit* Killer)
        {
        }

        void Aggro(Unit *who)
        {
            if (!m_pInstance) return;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_pInstance && m_pInstance->GetData(TYPE_ANUBARAK) != IN_PROGRESS) 
               me->ForcedDespawn();

            if (!UpdateVictim())
                return;

            bsw->timedCast(SPELL_EXPOSE_WEAKNESS, uiDiff);

            if (bsw->timedQuery(SPELL_SPIDER_FRENZY, uiDiff))
                if(Creature* pTemp = GetClosestCreatureWithEntry(me, NPC_BURROWER, 50.0f))
                {
                currentTarget = pTemp;
                bsw->doCast(SPELL_SPIDER_FRENZY);
                };

            if (me->GetHealthPercent() < 20.0f && bsw->timedQuery(SPELL_SUBMERGE_1, uiDiff) && !submerged)
               {
                bsw->doCast(SPELL_SUBMERGE_1);
                submerged = true;
                DoScriptText(-1713557,me);
                };

            if (me->GetHealthPercent() > 50.0f && submerged)
                {
                 bsw->doRemove(SPELL_SUBMERGE_1,me);
                 submerged = false;
                 DoScriptText(-1713559,me);
                 };

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_nerubian_borrowerAI(pCreature);
    };
};

class mob_frost_sphere : public CreatureScript
{
    public:
        mob_frost_sphere(): CreatureScript("mob_frost_sphere") {}

    struct mob_frost_sphereAI : public ScriptedAI
    {
        mob_frost_sphereAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            bsw = new BossSpellWorker(this);
            Reset();
        }

        InstanceScript* m_pInstance;
        BossSpellWorker* bsw;

        void Reset()
        {
            me->SetRespawnDelay(DAY);
            me->SetSpeed(MOVE_RUN, 0.1f);
            me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
            me->GetMotionMaster()->MoveRandom();
        }

        void EnterCombat(Unit* attacker)
        {
            bsw->doCast(SPELL_PERMAFROST);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!m_pInstance || m_pInstance->GetData(TYPE_ANUBARAK) != IN_PROGRESS) 
              me->ForcedDespawn();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_frost_sphereAI(pCreature);
    };
};

class mob_anubarak_spike : public CreatureScript
{
    public:
        mob_anubarak_spike(): CreatureScript("mob_anubarak_spike") {}

    struct mob_anubarak_spikeAI : public ScriptedAI
    {
        mob_anubarak_spikeAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            bsw = new BossSpellWorker(this);
            Reset();
        }

        InstanceScript* m_pInstance;
        BossSpellWorker* bsw;
        Unit* defaultTarget;

        void Reset()
        {
           me->SetRespawnDelay(DAY);
           me->SetSpeed(MOVE_RUN, 0.5f);
           me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
           me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            defaultTarget = NULL;
        }

        void Aggro(Unit *who)
        {
            if (!m_pInstance) return;
            bsw->doCast(SPELL_IMPALE);
            defaultTarget = who;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_pInstance && m_pInstance->GetData(TYPE_ANUBARAK) != IN_PROGRESS) 
               me->ForcedDespawn();
            if (defaultTarget)
                if (!defaultTarget->isAlive() || !bsw->hasAura(SPELL_MARK,defaultTarget))
                    me->ForcedDespawn();

    /*        if (bsw->timedQuery(SPELL_IMPALE,uiDiff)) {
            if (me->IsWithinDist(me->getVictim(), 4.0f)
                && !bsw->hasAura(SPELL_PERMAFROST,me->getVictim()))
               {
                  bsw->doCast(SPELL_IMPALE);
               }  else bsw->doRemove(SPELL_IMPALE);
            }*/
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_anubarak_spikeAI(pCreature);
    };
};

void AddSC_boss_anub_arak_crusader()
{
    new boss_anubarak_trial();
    new mob_swarm_scarab();
    new mob_nerubian_borrower();
    new mob_anubarak_spike();
    new mob_frost_sphere();
}