/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
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
#include "naxxramas.h"

#define SPELL_MORTAL_WOUND      25646
#define SPELL_ENRAGE            RAID_MODE(28371,54427)
#define SPELL_DECIMATE          RAID_MODE(28374,54426)
#define SPELL_BERSERK           26662
#define SPELL_INFECTED_WOUND    29306

#define MOB_ZOMBIE  16360

const Position PosSummon[3] =
{
    {3267.9, -3172.1, 297.42, 0.94},
    {3253.2, -3132.3, 297.42, 0},
    {3308.3, -3185.8, 297.42, 1.58},
};

enum Events
{
    EVENT_NONE,
    EVENT_WOUND,
    EVENT_ENRAGE,
    EVENT_DECIMATE,
    EVENT_BERSERK,
    EVENT_SUMMON,
};

#define EMOTE_NEARBY    " spots a nearby zombie to devour!"

struct boss_gluthAI : public BossAI
{
    boss_gluthAI(Creature *c) : BossAI(c, BOSS_GLUTH)
    {
        // Do not let Gluth be affected by zombies' debuff
        me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_INFECTED_WOUND, true);

        pMap = NULL;
	    if(me)	
                pMap = me->GetMap();        
	    // valuta il team in instance 
        if(pMap)
	    {	
	        Map::PlayerList const& players = pMap->GetPlayers();
            if (!players.isEmpty())
            {
                if (Player* pPlayer = players.begin()->getSource())
                {
                    TeamInInstance = pPlayer->GetTeam();
                }
            }
	    }	
    }

    Map* pMap;
    uint32 TeamInInstance;

    void MoveInLineOfSight(Unit *who)
    {
        if (who->GetEntry() == MOB_ZOMBIE && me->IsWithinDistInMap(who, 7))
        {
            SetGazeOn(who);
            // TODO: use a script text
            me->MonsterTextEmote(EMOTE_NEARBY, 0, true);
        }
        else
            BossAI::MoveInLineOfSight(who);
    }

    void EnterCombat(Unit * /*who*/)
    {
        _EnterCombat();
        events.ScheduleEvent(EVENT_WOUND, 10000);
        events.ScheduleEvent(EVENT_ENRAGE, 15000);
        events.ScheduleEvent(EVENT_DECIMATE, 105000);
        events.ScheduleEvent(EVENT_BERSERK, 8*60000);
        events.ScheduleEvent(EVENT_SUMMON, 15000);
    }

    void JustSummoned(Creature *summon)
    {
        if (summon->GetEntry() == MOB_ZOMBIE)
            summon->AI()->AttackStart(me);
        summons.Summon(summon);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictimWithGaze() || !CheckInRoom())
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch(eventId)
            {
                case EVENT_WOUND:
                    DoCast(me->getVictim(), SPELL_MORTAL_WOUND);
                    events.ScheduleEvent(EVENT_WOUND, 10000);
                    break;
                case EVENT_ENRAGE:
                    // TODO : Add missing text
                    DoCast(me, SPELL_ENRAGE);
                    events.ScheduleEvent(EVENT_ENRAGE, 15000);
                    break;
                case EVENT_DECIMATE:
                    {
                        // TODO : Add missing text
                        DoCastAOE(SPELL_DECIMATE);
                        events.ScheduleEvent(EVENT_DECIMATE, 105000);
                        std::list<Creature*> ZombieList;
                        me->GetCreatureListWithEntryInGrid(ZombieList, MOB_ZOMBIE, 100.0f);
                        if (!ZombieList.empty())
                            for (std::list<Creature*>::iterator iter = ZombieList.begin(); iter != ZombieList.end(); iter++)
                            {  
                                Creature* zombie = (*iter);
                                if (zombie)
                                    zombie->SetHealth(zombie->GetMaxHealth() * 5 /100);     
                            }
                    }
                    break; 
                case EVENT_BERSERK:
                    DoCast(me, SPELL_BERSERK);
                    events.ScheduleEvent(EVENT_BERSERK, 5*60000);
                    break;
                case EVENT_SUMMON:
                    for (uint32 i = 0; i < RAID_MODE(1,2); ++i)
                    {
                        Creature* current = DoSummon(MOB_ZOMBIE, PosSummon[rand()%3]);
                        if(current)
			            {
			                 if (TeamInInstance == ALLIANCE)
                                current->setFaction(2);
                             else
                                current->setFaction(1);
			            }
                    }
                    events.ScheduleEvent(EVENT_SUMMON, 10000);
                    break;
            }
        }

        if (me->getVictim() && me->getVictim()->GetEntry() == MOB_ZOMBIE)
        {
            if (me->IsWithinMeleeRange(me->getVictim()))
            {
                me->Kill(me->getVictim());
                me->ModifyHealth(me->GetMaxHealth() * 0.05f);
            }
        }
        else
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_gluth(Creature* pCreature)
{
    return new boss_gluthAI (pCreature);
}

void AddSC_boss_gluth()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "boss_gluth";
    newscript->GetAI = &GetAI_boss_gluth;
    newscript->RegisterSelf();
}

