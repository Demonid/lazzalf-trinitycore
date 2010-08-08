/* ScriptData
SDName: trial_of_the_crusader
SD%Complete: 80%
SDComment: by /dev/rsa
SDCategory: Crusader Coliseum
EndScriptData */

// Twin pact - heal part not worked now by undefined reason. Need override?
// timers need correct

#include "ScriptPCH.h"
#include "trial_of_crusader.h"

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
    SPELL_TWIN_SPIKE_L     = 66075,
    SPELL_LIGHT_SURGE      = 65766,
    SPELL_SHIELD_LIGHT     = 65858,
    SPELL_TWIN_PACT_L      = 65875,
    SPELL_LIGHT_VORTEX     = 66046,
    SPELL_LIGHT_TOUCH      = 67297,
    SPELL_TWIN_SPIKE_H     = 66069,
    SPELL_DARK_SURGE       = 65768,
    SPELL_SHIELD_DARK      = 65874,
    SPELL_TWIN_PACT_H      = 65876,
    SPELL_DARK_VORTEX      = 66058,
    SPELL_DARK_TOUCH       = 67282,
    SPELL_TWIN_POWER       = 65916,
    SPELL_LIGHT_ESSENCE    = 65686,
    SPELL_DARK_ESSENCE     = 65684,
    SPELL_BERSERK          = 64238,
    SPELL_REMOVE_TOUCH     = 68084,
    SPELL_NONE             = 0,
//
    SPELL_UNLEASHED_DARK   = 65808,
    SPELL_UNLEASHED_LIGHT  = 65795,
};

struct boss_fjolaAI : public ScriptedAI
{
    boss_fjolaAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
    m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
    bsw = new BossSpellWorker(this);
    Reset();
    }

    ScriptedInstance* m_pInstance;
    uint8 stage;
    BossSpellWorker* bsw;

    void Reset() {
        if(!m_pInstance) return;
        SetEquipmentSlots(false, EQUIP_MAIN_1, EQUIP_OFFHAND_1, EQUIP_RANGED_1);
        me->SetRespawnDelay(7*DAY);
        m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
        stage = 0;
    }

    void JustReachedHome()
    {
        if (!m_pInstance) return;
            m_pInstance->SetData(TYPE_VALKIRIES, FAIL);
            m_pInstance->SetData(DATA_HEALTH_FJOLA, me->GetMaxHealth());
            m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
            me->ForcedDespawn();
    }

    void JustDied(Unit* pKiller)
    {
        if (!m_pInstance) return;
            DoScriptText(-1713547,me);
            if (Creature* pSister = (Creature*)Unit::GetUnit((*me),m_pInstance->GetData64(NPC_DARKBANE)))
               if (!pSister->isAlive())
                         m_pInstance->SetData(TYPE_VALKIRIES, DONE);
                else m_pInstance->SetData(TYPE_VALKIRIES, SPECIAL);
        m_pInstance->SetData(DATA_HEALTH_FJOLA, 0);
    }

    void KilledUnit(Unit* pVictim)
    {
        if (!m_pInstance) return;
        DoScriptText(-1713544,me,pVictim);
    }

    void Aggro(Unit* pWho)
    {
        if (!m_pInstance) return;
        me->SetInCombatWithZone();
        m_pInstance->SetData(TYPE_VALKIRIES, IN_PROGRESS);
        if (me->isAlive()) me->SummonCreature(NPC_LIGHT_ESSENCE, SpawnLoc[24].x, SpawnLoc[24].y, SpawnLoc[24].z, 0, TEMPSUMMON_MANUAL_DESPAWN, 5000);
        if (me->isAlive()) me->SummonCreature(NPC_LIGHT_ESSENCE, SpawnLoc[25].x, SpawnLoc[25].y, SpawnLoc[25].z, 0, TEMPSUMMON_MANUAL_DESPAWN, 5000);
        DoScriptText(-1713541,me);
        m_pInstance->SetData(DATA_HEALTH_FJOLA, me->GetMaxHealth());
        bsw->doCast(SPELL_LIGHT_SURGE);
    }

    void DamageTaken(Unit* pDoneBy, uint32 &uiDamage)
    {
        if (!m_pInstance) return;
        if (!me || !me->isAlive())
            return;

        if(pDoneBy->GetGUID() == me->GetGUID()) return;

        if(pDoneBy->GetTypeId() == TYPEID_PLAYER)
        {
            if(pDoneBy->HasAura(SPELL_LIGHT_ESSENCE))
                uiDamage /= 2;
            else if(pDoneBy->HasAura(SPELL_DARK_ESSENCE))
                uiDamage += uiDamage/2;
        }

        m_pInstance->SetData(DATA_HEALTH_FJOLA, me->GetHealth() >= uiDamage ? me->GetHealth() - uiDamage : 0);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_pInstance) return;
        if (!UpdateVictim())
            return;

        if (me->GetHealth() > m_pInstance->GetData(DATA_HEALTH_EYDIS) &&
                                      m_pInstance->GetData(DATA_HEALTH_EYDIS) != 0)
                me->SetHealth(m_pInstance->GetData(DATA_HEALTH_EYDIS));

    switch (stage)
        {
         case 0:
                bsw->timedCast(SPELL_TWIN_SPIKE_L, uiDiff);

                if (bsw->timedQuery(SPELL_LIGHT_TOUCH, uiDiff))
                   {
                   if (Unit* pTarget = bsw->SelectRandomPlayer(SPELL_LIGHT_ESSENCE, false, 50.0f))
                             bsw->doCast(SPELL_LIGHT_TOUCH, pTarget);
                   bsw->doCast(NPC_UNLEASHED_LIGHT);
                   };
                if (m_pInstance->GetData(DATA_CASTING_FJOLA) == SPELL_NONE )
                   {
                   if (bsw->timedQuery(SPELL_LIGHT_VORTEX, uiDiff))
                      {
                            m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_LIGHT_VORTEX);
                            DoScriptText(-1713538,me);
                            stage = 1;
                            break;
                      };
                   if (bsw->timedQuery(SPELL_TWIN_PACT_L, uiDiff)
                       && me->GetHealthPercent() <= 50.0f)
                      {
                            me->InterruptNonMeleeSpells(true);
                            bsw->doCast(SPELL_SHIELD_LIGHT);
                            m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_TWIN_PACT_L);
                            DoScriptText(-1713539,me);
                            stage = 3;
                      };
                   };
                if (m_pInstance->GetData(DATA_CASTING_FJOLA) == SPELL_TWIN_PACT_H) 
                            if (!me->HasAura(SPELL_TWIN_POWER)) 
                                   bsw->doCast(SPELL_TWIN_POWER);
                break;
         case 1:
                    bsw->doCast(SPELL_LIGHT_VORTEX);
                    stage = 2;
                break;
         case 2:
                if (!me->HasAura(SPELL_LIGHT_VORTEX) 
                    && bsw->timedQuery(SPELL_SHIELD_LIGHT, uiDiff)) 
                    {
                         m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
                         stage = 0;
                    };
                break;
         case 3:
                    bsw->doCast(SPELL_TWIN_PACT_L);
                    stage = 4;
                 break;
         case 4:
                if (!me->HasAura(SPELL_SHIELD_LIGHT)
                    && bsw->timedQuery(SPELL_SHIELD_LIGHT, uiDiff))
                    {
                         m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
                         stage = 0;
                    };
         default:
                 break;
         }

        bsw->timedCast(SPELL_BERSERK, uiDiff);

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_fjola(Creature* pCreature)
{
    return new boss_fjolaAI(pCreature);
}

struct boss_eydisAI : public ScriptedAI
{
    boss_eydisAI(Creature* pCreature) : ScriptedAI(pCreature) 
    {
    m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
    bsw = new BossSpellWorker(this);
    Reset();
    }

    ScriptedInstance* m_pInstance;
    uint8 stage;
    BossSpellWorker* bsw;

    void Reset() 
    {
        if(!m_pInstance) return;
        SetEquipmentSlots(false, EQUIP_MAIN_2, EQUIP_OFFHAND_2, EQUIP_RANGED_2);
        me->SetRespawnDelay(7*DAY);
        m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
        stage = 0;
    }

    void JustReachedHome()
    {
        if (!m_pInstance) return;
            m_pInstance->SetData(TYPE_VALKIRIES, FAIL);
            m_pInstance->SetData(DATA_HEALTH_EYDIS, me->GetMaxHealth());
            m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
            me->ForcedDespawn();
    }

    void JustDied(Unit* pKiller)
    {
        if (!m_pInstance) return;
            DoScriptText(-1713547,me);
            if (Creature* pSister = (Creature*)Unit::GetUnit((*me),m_pInstance->GetData64(NPC_LIGHTBANE)))
               if (!pSister->isAlive())
                         m_pInstance->SetData(TYPE_VALKIRIES, DONE);
                else m_pInstance->SetData(TYPE_VALKIRIES, SPECIAL);
        m_pInstance->SetData(DATA_HEALTH_EYDIS, 0);
    }

    void KilledUnit(Unit* pVictim)
    {
        DoScriptText(-1713543,me,pVictim);
    }

    void Aggro(Unit* pWho)
    {
        if (!m_pInstance) return;
        me->SetInCombatWithZone();
        m_pInstance->SetData(TYPE_VALKIRIES, IN_PROGRESS);
        DoScriptText(-1713741,me);
        if (me->isAlive()) me->SummonCreature(NPC_DARK_ESSENCE, SpawnLoc[22].x, SpawnLoc[22].y, SpawnLoc[22].z, 0, TEMPSUMMON_MANUAL_DESPAWN, 5000);
        if (me->isAlive()) me->SummonCreature(NPC_DARK_ESSENCE, SpawnLoc[23].x, SpawnLoc[23].y, SpawnLoc[23].z, 0, TEMPSUMMON_MANUAL_DESPAWN, 5000);
        m_pInstance->SetData(DATA_HEALTH_EYDIS, me->GetMaxHealth());
        bsw->doCast(SPELL_DARK_SURGE);
    }

    void DamageTaken(Unit* pDoneBy, uint32 &uiDamage)
    {
        if (!m_pInstance) return;
        if (!me || !me->isAlive())
            return;

        if(pDoneBy->GetGUID() == me->GetGUID()) return;

        if(pDoneBy->GetTypeId() == TYPEID_PLAYER)
        {
            if(pDoneBy->HasAura(SPELL_DARK_ESSENCE))
                uiDamage /= 2;
            else if(pDoneBy->HasAura(SPELL_LIGHT_ESSENCE))
                uiDamage += uiDamage/2;
        }

        m_pInstance->SetData(DATA_HEALTH_EYDIS, me->GetHealth() >= uiDamage ? me->GetHealth() - uiDamage : 0);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;

        if (me->GetHealth() > m_pInstance->GetData(DATA_HEALTH_FJOLA) &&
                                      m_pInstance->GetData(DATA_HEALTH_FJOLA) != 0)
                me->SetHealth(m_pInstance->GetData(DATA_HEALTH_FJOLA));

    switch (stage)
        {
         case 0:
                bsw->timedCast(SPELL_TWIN_SPIKE_H, uiDiff);

                if (bsw->timedQuery(SPELL_DARK_TOUCH, uiDiff))
                   {
                   if (Unit* pTarget = bsw->SelectRandomPlayer(SPELL_DARK_ESSENCE, false, 50.0f))
                             bsw->doCast(SPELL_DARK_TOUCH, pTarget);
                   bsw->doCast(NPC_UNLEASHED_DARK);
                   };
                if (m_pInstance->GetData(DATA_CASTING_FJOLA) == SPELL_NONE )
                   {
                   if (bsw->timedQuery(SPELL_DARK_VORTEX, uiDiff))
                      {
                            m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_DARK_VORTEX);
                            DoScriptText(-1713540,me);
                            stage = 1;
                            break;
                      };
                   if (bsw->timedQuery(SPELL_TWIN_PACT_H, uiDiff)
                       && me->GetHealthPercent() <= 50.0f)
                      {
                            me->InterruptNonMeleeSpells(true);
                            bsw->doCast(SPELL_SHIELD_DARK);
                            m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_TWIN_PACT_H);
                            DoScriptText(-1713539,me);
                            stage = 3;
                            break;
                      };
                   };
                if (m_pInstance->GetData(DATA_CASTING_FJOLA) == SPELL_TWIN_PACT_L)
                            if (!me->HasAura(SPELL_TWIN_POWER)) 
                                   bsw->doCast(SPELL_TWIN_POWER);
                break;
         case 1:
                    bsw->doCast(SPELL_DARK_VORTEX);
                    stage = 2;
                break;
         case 2:
                if (!me->HasAura(SPELL_DARK_VORTEX)
                    && bsw->timedQuery(SPELL_SHIELD_DARK, uiDiff)) 
                    {
                        m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
                        stage = 0;
                    };
                break;
         case 3:
                    bsw->doCast(SPELL_TWIN_PACT_H);
                    stage = 4;
                 break;
         case 4:
                if (!me->HasAura(SPELL_SHIELD_DARK)
                    && bsw->timedQuery(SPELL_SHIELD_DARK, uiDiff)) 
                    {
                        m_pInstance->SetData(DATA_CASTING_FJOLA, SPELL_NONE);
                        stage = 0;
                    };
         default:
                 break;
         }

        bsw->timedCast(SPELL_BERSERK, uiDiff);

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_eydis(Creature* pCreature)
{
    return new boss_eydisAI(pCreature);
}

struct mob_light_essenceAI : public ScriptedAI
{
    mob_light_essenceAI(Creature* pCreature) : ScriptedAI(pCreature) {
    m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
    Reset();
    }
    ScriptedInstance* m_pInstance;

    void Reset() 
    {
    me->SetRespawnDelay(DAY);
    me->AddUnitMovementFlag(MOVEMENTFLAG_WALK_MODE);
    me->GetMotionMaster()->MoveRandom();
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_pInstance) me->ForcedDespawn();
        if (m_pInstance->GetData(TYPE_VALKIRIES) != IN_PROGRESS) {
                    Map* pMap = me->GetMap();
                    Map::PlayerList const &lPlayers = pMap->GetPlayers();
                    for(Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
                    {
                        Unit* pPlayer = itr->getSource();
                        if (!pPlayer) continue;
                        if (pPlayer->isAlive())
                             pPlayer->RemoveAurasDueToSpell(SPELL_LIGHT_ESSENCE);
                    }

            me->ForcedDespawn();
            }
        return;
    }
};

CreatureAI* GetAI_mob_light_essence(Creature* pCreature)
{
    return new mob_light_essenceAI(pCreature);
};

bool GossipHello_mob_light_essence(Player *player, Creature* pCreature)
{
    ScriptedInstance *pInstance = (ScriptedInstance *) pCreature->GetInstanceData();
    if(!pInstance) return true;
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
        player->RemoveAurasDueToSpell(SPELL_DARK_ESSENCE);
//        player->CastSpell(player,SPELL_REMOVE_TOUCH,false); // Not worked now
        player->CastSpell(player,SPELL_LIGHT_ESSENCE,false);
            player->RemoveAurasDueToSpell(SPELL_LIGHT_TOUCH); // Override for REMOVE_TOUCH
        player->CLOSE_GOSSIP_MENU();
    return true;
};

struct mob_dark_essenceAI : public ScriptedAI
{
    mob_dark_essenceAI(Creature* pCreature) : ScriptedAI(pCreature) {
    m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
    Reset();
    }
    ScriptedInstance* m_pInstance;

    void Reset() 
    {
    me->SetRespawnDelay(DAY);
    me->AddUnitMovementFlag(MOVEMENTFLAG_WALK_MODE);
    me->GetMotionMaster()->MoveRandom();
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_pInstance) me->ForcedDespawn();
        if (m_pInstance->GetData(TYPE_VALKIRIES) != IN_PROGRESS) {
                    Map* pMap = me->GetMap();
                    Map::PlayerList const &lPlayers = pMap->GetPlayers();
                    for(Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
                    {
                        Unit* pPlayer = itr->getSource();
                        if (!pPlayer) continue;
                        if (pPlayer->isAlive())
                             pPlayer->RemoveAurasDueToSpell(SPELL_DARK_ESSENCE);
                    }
            me->ForcedDespawn();
            }
        return;
    }
};

CreatureAI* GetAI_mob_dark_essence(Creature* pCreature)
{
    return new mob_dark_essenceAI(pCreature);
};

bool GossipHello_mob_dark_essence(Player *player, Creature* pCreature)
{
    ScriptedInstance *pInstance = (ScriptedInstance *) pCreature->GetInstanceData();
    if(!pInstance) return true;
    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
        player->RemoveAurasDueToSpell(SPELL_LIGHT_ESSENCE);
//        player->CastSpell(player,SPELL_REMOVE_TOUCH,false); // Not worked now
        player->CastSpell(player,SPELL_DARK_ESSENCE,false);
            player->RemoveAurasDueToSpell(SPELL_DARK_TOUCH); // Override for REMOVE_TOUCH
        player->CLOSE_GOSSIP_MENU();
    return true;
}

struct mob_unleashed_darkAI : public ScriptedAI
{
    mob_unleashed_darkAI(Creature *pCreature) : ScriptedAI(pCreature) 
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        Reset();
    }

    ScriptedInstance* m_pInstance;
    uint32 m_uiRangeCheck_Timer;
    Creature* pboss1;
    Creature* pboss2;

    void Reset()
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        SetCombatMovement(false); 
        me->GetMotionMaster()->MoveRandom();
        m_uiRangeCheck_Timer = 1000;
        pboss1 = (Creature*)Unit::GetUnit((*me),m_pInstance->GetData64(NPC_DARKBANE));
        pboss2 = (Creature*)Unit::GetUnit((*me),m_pInstance->GetData64(NPC_LIGHTBANE));
    }

    void AttackStart(Unit *pWho)
    {
        return;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_pInstance || m_pInstance->GetData(TYPE_VALKIRIES) != IN_PROGRESS) 
              me->ForcedDespawn();
 
        if (m_uiRangeCheck_Timer < uiDiff)
        {
                    Map* pMap = me->GetMap();
                    Map::PlayerList const &lPlayers = pMap->GetPlayers();
                    for(Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
                    {
                       Unit* pPlayer = itr->getSource();
                       if (!pPlayer) continue;
                           if (pPlayer->isAlive() && pPlayer->IsWithinDistInMap(me, 2.0f))
                                   {
                                   me->CastSpell(me, SPELL_UNLEASHED_DARK, true);
                                   me->ForcedDespawn();
                                   }

                     }
                    if (pboss1 && pboss1->isAlive() && pboss1->IsWithinDistInMap(me, 2.0f))
                                   {
                                   me->CastSpell(me, SPELL_UNLEASHED_DARK, true);
                                   me->ForcedDespawn();
                                   }
                    if (pboss2 && pboss2->isAlive() && pboss2->IsWithinDistInMap(me, 2.0f))
                                   {
                                   me->CastSpell(me, SPELL_UNLEASHED_DARK, true);
                                   me->ForcedDespawn();
                                   }
            m_uiRangeCheck_Timer = 1000;
        }
        else m_uiRangeCheck_Timer -= uiDiff;
    }

};

CreatureAI* GetAI_mob_unleashed_dark(Creature *pCreature)
{
    return new mob_unleashed_darkAI(pCreature);
}

struct mob_unleashed_lightAI : public ScriptedAI
{
    mob_unleashed_lightAI(Creature *pCreature) : ScriptedAI(pCreature) 
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        Reset();
    }

    ScriptedInstance* m_pInstance;
    uint32 m_uiRangeCheck_Timer;
    Creature* pboss1;
    Creature* pboss2;

    void Reset()
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        SetCombatMovement(false); 
        me->GetMotionMaster()->MoveRandom();
        m_uiRangeCheck_Timer = 1000;
        pboss1 = (Creature*)Unit::GetUnit((*me),m_pInstance->GetData64(NPC_DARKBANE));
        pboss2 = (Creature*)Unit::GetUnit((*me),m_pInstance->GetData64(NPC_LIGHTBANE));
    }

    void AttackStart(Unit *pWho)
    {
        return;
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_pInstance || m_pInstance->GetData(TYPE_VALKIRIES) != IN_PROGRESS) 
              me->ForcedDespawn();
 
        if (m_uiRangeCheck_Timer < uiDiff)
        {
                    Map* pMap = me->GetMap();
                    Map::PlayerList const &lPlayers = pMap->GetPlayers();
                    for(Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
                    {
                       Unit* pPlayer = itr->getSource();
                       if (!pPlayer) continue;
                           if (pPlayer->isAlive() && pPlayer->IsWithinDistInMap(me, 2.0f))
                                   {
                                   me->CastSpell(me, SPELL_UNLEASHED_LIGHT, true);
                                   me->ForcedDespawn();
                                   }
                     }
                    if (pboss1 && pboss1->isAlive() && pboss1->IsWithinDistInMap(me, 2.0f))
                                   {
                                   me->CastSpell(me, SPELL_UNLEASHED_LIGHT, true);
                                   me->ForcedDespawn();
                                   }
                    if (pboss2 && pboss2->isAlive() && pboss2->IsWithinDistInMap(me, 2.0f))
                                   {
                                   me->CastSpell(me, SPELL_UNLEASHED_LIGHT, true);
                                   me->ForcedDespawn();
                                   }
            m_uiRangeCheck_Timer = 1000;
        }
        else m_uiRangeCheck_Timer -= uiDiff;
    }

};

CreatureAI* GetAI_mob_unleashed_light(Creature *pCreature)
{
    return new mob_unleashed_lightAI(pCreature);
}

void AddSC_twin_valkyr()
{
    Script* newscript;

    newscript = new Script;
    newscript->Name = "boss_fjola";
    newscript->GetAI = &GetAI_boss_fjola;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "boss_eydis";
    newscript->GetAI = &GetAI_boss_eydis;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_unleashed_light";
    newscript->GetAI = &GetAI_mob_unleashed_light;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_unleashed_dark";
    newscript->GetAI = &GetAI_mob_unleashed_dark;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_light_essence";
    newscript->GetAI = &GetAI_mob_light_essence;
    newscript->pGossipHello = &GossipHello_mob_light_essence;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_dark_essence";
    newscript->GetAI = &GetAI_mob_dark_essence;
    newscript->pGossipHello = &GossipHello_mob_dark_essence;
    newscript->RegisterSelf();

}