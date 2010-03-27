/* Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008 - 2010 TrinityCore <http://www.trinitycore.org>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "ScriptedPch.h"
#include "nexus.h"

enum Spells
{
    //Spells
    SPELL_FROZEN_PRISON                           = 47854,
    SPELL_TAIL_SWEEP                              = 50155,
    SPELL_CRYSTAL_CHAINS                          = 50997,
    SPELL_ENRAGE                                  = 8599,
    SPELL_CRYSTALFIRE_BREATH                      = 48096,
    H_SPELL_CRYSTALFIRE_BREATH                    = 57091,
    SPELL_CRYSTALIZE                              = 48179,
    SPELL_INTENSE_COLD                            = 48094,
    SPELL_INTENSE_COLD_TRIGGERED                  = 48095
};
enum Yells
{
    //Yell
    SAY_AGGRO                                     = -1576040,
    SAY_SLAY                                      = -1576041,
    SAY_ENRAGE                                    = -1576042,
    SAY_DEATH                                     = -1576043,
    SAY_CRYSTAL_NOVA                              = -1576044
};
enum Achievements
{
    ACHIEV_INTENSE_COLD                           = 2036
};
enum Misc
{
    DATA_CONTAINMENT_SPHERES                      = 3
};

struct boss_keristraszaAI : public ScriptedAI
{
    boss_keristraszaAI(Creature *c) : ScriptedAI(c)
    {
        pInstance = c->GetInstanceData();
    }

    ScriptedInstance* pInstance;

    uint32 uiCrystalfireBreathTimer;
    uint32 uiCrystalChainsCrystalizeTimer;
    uint32 uiTailSweepTimer;
    bool bEnrage;

    uint64 auiContainmentSphereGUIDs[DATA_CONTAINMENT_SPHERES];

    uint32 uiCheckIntenseColdTimer;
    bool bMoreThanTwoIntenseCold; // needed for achievement: Intense Cold(2036)

    void Reset()
    {
        uiCrystalfireBreathTimer = 14*IN_MILISECONDS;
        uiCrystalChainsCrystalizeTimer = DUNGEON_MODE(30*IN_MILISECONDS,11*IN_MILISECONDS);
        uiTailSweepTimer = 5*IN_MILISECONDS;
        bEnrage = false;

        uiCheckIntenseColdTimer = 2*IN_MILISECONDS;
        bMoreThanTwoIntenseCold = false;

        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);

        RemovePrison(CheckContainmentSpheres());

        if (pInstance)
            pInstance->SetData(DATA_KERISTRASZA_EVENT, NOT_STARTED);
    }

    void EnterCombat(Unit* who)
    {
        DoScriptText(SAY_AGGRO, m_creature);
        DoCastAOE(SPELL_INTENSE_COLD);

        if (pInstance)
            pInstance->SetData(DATA_KERISTRASZA_EVENT, IN_PROGRESS);
    }

    void JustDied(Unit* killer)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if (pInstance)
        {
            if (IsHeroic() && !bMoreThanTwoIntenseCold)
                pInstance->DoCompleteAchievement(ACHIEV_INTENSE_COLD);
            pInstance->SetData(DATA_KERISTRASZA_EVENT, DONE);
        }
    }

    void KilledUnit(Unit *victim)
    {
        DoScriptText(SAY_SLAY, m_creature);
    }

    bool CheckContainmentSpheres(bool remove_prison = false)
    {
        if(!pInstance)
            return false;

        auiContainmentSphereGUIDs[0] = pInstance->GetData64(ANOMALUS_CONTAINMET_SPHERE);
        auiContainmentSphereGUIDs[1] = pInstance->GetData64(ORMOROKS_CONTAINMET_SPHERE);
        auiContainmentSphereGUIDs[2] = pInstance->GetData64(TELESTRAS_CONTAINMET_SPHERE);

        GameObject *ContainmentSpheres[DATA_CONTAINMENT_SPHERES];

        for (uint8 i = 0; i < DATA_CONTAINMENT_SPHERES; ++i)
        {
            ContainmentSpheres[i] = pInstance->instance->GetGameObject(auiContainmentSphereGUIDs[i]);
            if (!ContainmentSpheres[i])
                return false;
            if (ContainmentSpheres[i]->GetGoState() != GO_STATE_ACTIVE)
                return false;
        }
        if (remove_prison)
            RemovePrison(true);
        return true;
    }

    void RemovePrison(bool remove)
    {
        if (remove)
        {
            m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
            m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (m_creature->HasAura(SPELL_FROZEN_PRISON))
                m_creature->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);
        }
        else
        {
            m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
            m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            DoCast(m_creature, SPELL_FROZEN_PRISON, false);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (uiCheckIntenseColdTimer < diff && !bMoreThanTwoIntenseCold)
        {
            std::list<HostileReference*> ThreatList = m_creature->getThreatManager().getThreatList();
            for (std::list<HostileReference*>::const_iterator itr = ThreatList.begin(); itr != ThreatList.end(); itr++)
            {
                Unit *pTarget = Unit::GetUnit(*m_creature, (*itr)->getUnitGuid());
                if (!pTarget || pTarget->GetTypeId() != TYPEID_PLAYER)
                    continue;

                Aura *AuraIntenseCold = pTarget->GetAura(SPELL_INTENSE_COLD_TRIGGERED);
                if (AuraIntenseCold && AuraIntenseCold->GetStackAmount() > 2)
                {
                    bMoreThanTwoIntenseCold = true;
                    break;
                }
            }
            uiCheckIntenseColdTimer = 2*IN_MILISECONDS;
        } else uiCheckIntenseColdTimer -= diff;

        if (!bEnrage && (m_creature->GetHealth() < HealthBelowPct(25)))
        {
            DoScriptText(SAY_ENRAGE, m_creature);
            DoCast(m_creature, SPELL_ENRAGE);
            bEnrage = true;
        }

        if (uiCrystalfireBreathTimer <= diff)
        {
            DoCast(m_creature->getVictim(), DUNGEON_MODE(SPELL_CRYSTALFIRE_BREATH, H_SPELL_CRYSTALFIRE_BREATH));
            uiCrystalfireBreathTimer = 14*IN_MILISECONDS;
        } else uiCrystalfireBreathTimer -= diff;

        if (uiTailSweepTimer <= diff)
        {
            DoCast(m_creature, SPELL_TAIL_SWEEP);
            uiTailSweepTimer = 5*IN_MILISECONDS;
        } else uiTailSweepTimer -= diff;

        if (uiCrystalChainsCrystalizeTimer <= diff)
        {
            DoScriptText(SAY_CRYSTAL_NOVA, m_creature);
            if (IsHeroic())
                DoCast(m_creature, SPELL_CRYSTALIZE);
            else if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                DoCast(pTarget, SPELL_CRYSTAL_CHAINS);
            uiCrystalChainsCrystalizeTimer = DUNGEON_MODE(30*IN_MILISECONDS,11*IN_MILISECONDS);
        } else uiCrystalChainsCrystalizeTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_keristrasza(Creature* pCreature)
{
    return new boss_keristraszaAI (pCreature);
}

bool GOHello_containment_sphere(Player *pPlayer, GameObject *pGO)
{
    ScriptedInstance *pInstance = pGO->GetInstanceData();

    Creature *pKeristrasza = Unit::GetCreature(*pGO, pInstance ? pInstance->GetData64(DATA_KERISTRASZA) : 0);
    if (pKeristrasza && pKeristrasza->isAlive())
    {
        // maybe these are hacks :(
        pGO->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_UNK1);
        pGO->SetGoState(GO_STATE_ACTIVE);

        CAST_AI(boss_keristraszaAI, pKeristrasza->AI())->CheckContainmentSpheres(true);
    }
    return true;
}

void AddSC_boss_keristrasza()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_keristrasza";
    newscript->GetAI = &GetAI_boss_keristrasza;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "containment_sphere";
    newscript->pGOHello = &GOHello_containment_sphere;
    newscript->RegisterSelf();
}
