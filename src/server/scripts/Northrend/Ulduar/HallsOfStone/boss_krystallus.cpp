/* Script Data Start
SDName: Boss krystallus
SDAuthor: LordVanMartin
SD%Complete:
SDComment:
SDCategory:
Script Data End */

/*** SQL START ***
update creature_template set scriptname = 'boss_krystallus' where entry = '';
*** SQL END ***/
#include "ScriptPCH.h"
#include "halls_of_stone.h"

enum Spells
{
    SPELL_BOULDER_TOSS                             = 50843,
    H_SPELL_BOULDER_TOSS                           = 59742,
    SPELL_GROUND_SPIKE                             = 59750,
    SPELL_GROUND_SLAM                              = 50827,
    SPELL_SHATTER                                  = 50810,
    H_SPELL_SHATTER                                = 61546,
    SPELL_SHATTER_EFFECT                           = 50811,
    H_SPELL_SHATTER_EFFECT                         = 61547,
    SPELL_STONED                                   = 50812,
    SPELL_STOMP                                    = 48131,
    H_SPELL_STOMP                                  = 59744
};

enum Yells
{
    SAY_AGGRO                                   = -1599007,
    SAY_KILL                                    = -1599008,
    SAY_DEATH                                   = -1599009,
    SAY_SHATTER                                 = -1599010
};

struct boss_krystallusAI : public ScriptedAI
{
    boss_krystallusAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    uint32 uiBoulderTossTimer;
    uint32 uiGroundSpikeTimer;
    uint32 uiGroundSlamTimer;
    uint32 uiShatterTimer;
    uint32 uiStompTimer;

    bool bIsSlam;

    ScriptedInstance* pInstance;

    void Reset()
    {
        bIsSlam = false;

        uiBoulderTossTimer = 3000 + rand()%6000;
        uiGroundSpikeTimer = 9000 + rand()%5000;
        uiGroundSlamTimer = 15000 + rand()%3000;
        uiStompTimer = 20000 + rand()%9000;
        uiShatterTimer = 0;

        if (pInstance)
            pInstance->SetData(DATA_KRYSTALLUS_EVENT, NOT_STARTED);
    }
    void EnterCombat(Unit* /*who*/)
    {
        DoScriptText(SAY_AGGRO, me);

        if (pInstance)
            pInstance->SetData(DATA_KRYSTALLUS_EVENT, IN_PROGRESS);
    }

    void UpdateAI(const uint32 diff)
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        if (uiBoulderTossTimer <= diff)
        {
            if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                DoCast(pTarget, SPELL_BOULDER_TOSS);
            uiBoulderTossTimer = 9000 + rand()%6000;
        } else uiBoulderTossTimer -= diff;

        if (uiGroundSpikeTimer <= diff)
        {
            if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                DoCast(pTarget, SPELL_GROUND_SPIKE);
            uiGroundSpikeTimer = 12000 + rand()%5000;
        } else uiGroundSpikeTimer -= diff;

        if (uiStompTimer <= diff)
        {
            DoCast(me, SPELL_STOMP);
            uiStompTimer = 20000 + rand()%9000;
        } else uiStompTimer -= diff;

        if (uiGroundSlamTimer <= diff)
        {
            DoCast(me, SPELL_GROUND_SLAM);
            bIsSlam = true;
            uiShatterTimer = 10000;
            uiGroundSlamTimer = 15000 + rand()%3000;
        } else uiGroundSlamTimer -= diff;

        if (bIsSlam)
        {
            if (uiShatterTimer <= diff)
            {
                DoCast(me, DUNGEON_MODE(SPELL_SHATTER, H_SPELL_SHATTER));
            } else uiShatterTimer -= diff;
        }

        DoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*killer*/)
    {
        DoScriptText(SAY_DEATH, me);

        if (pInstance)
            pInstance->SetData(DATA_KRYSTALLUS_EVENT, DONE);
    }

    void KilledUnit(Unit * victim)
    {
        if (victim == me)
            return;
        DoScriptText(SAY_KILL, me);
    }

    void SpellHitTarget(Unit* pTarget, const SpellEntry* pSpell)
    {
        //this part should be in the core
        if (pSpell->Id == SPELL_SHATTER || pSpell->Id == H_SPELL_SHATTER)
        {
            //this spell must have custom handling in the core, dealing damage based on distance
            pTarget->CastSpell(pTarget, DUNGEON_MODE(SPELL_SHATTER_EFFECT, H_SPELL_SHATTER_EFFECT), true);

            if (pTarget->HasAura(SPELL_STONED))
                pTarget->RemoveAurasDueToSpell(SPELL_STONED);

            //clear this, if we are still performing
            if (bIsSlam)
            {
                bIsSlam = false;

                //and correct movement, if not already
                if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != TARGETED_MOTION_TYPE)
                {
                    if (me->getVictim())
                        me->GetMotionMaster()->MoveChase(me->getVictim());
                }
            }
        }
    }
};

CreatureAI* GetAI_boss_krystallus(Creature* pCreature)
{
    return new boss_krystallusAI (pCreature);
}

void AddSC_boss_krystallus()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_krystallus";
    newscript->GetAI = &GetAI_boss_krystallus;
    newscript->RegisterSelf();
}
