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
#include "naxxramas.h"

const DoorData doorData[] =
{
    {181126,    BOSS_ANUBREKHAN, DOOR_TYPE_ROOM,     BOUNDARY_S},
    {181195,    BOSS_ANUBREKHAN, DOOR_TYPE_PASSAGE,  0},
    {194022,    BOSS_FAERLINA,  DOOR_TYPE_PASSAGE,  0},
    {181209,    BOSS_FAERLINA,  DOOR_TYPE_PASSAGE,  0},
    {181209,    BOSS_MAEXXNA,   DOOR_TYPE_ROOM,     BOUNDARY_SW},
    {181200,    BOSS_NOTH,      DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181201,    BOSS_NOTH,      DOOR_TYPE_PASSAGE,  BOUNDARY_E},
    {181202,    BOSS_NOTH,      DOOR_TYPE_PASSAGE,  0},
    {181202,    BOSS_HEIGAN,    DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181203,    BOSS_HEIGAN,    DOOR_TYPE_PASSAGE,  BOUNDARY_E},
    {181241,    BOSS_HEIGAN,    DOOR_TYPE_PASSAGE,  0},
    {181241,    BOSS_LOATHEB,   DOOR_TYPE_ROOM,     BOUNDARY_W},
    {181123,    BOSS_PATCHWERK, DOOR_TYPE_PASSAGE,  0},
    {181123,    BOSS_GROBBULUS, DOOR_TYPE_ROOM,     0},
    {181120,    BOSS_GLUTH,     DOOR_TYPE_PASSAGE,  BOUNDARY_NW},
    {181121,    BOSS_GLUTH,     DOOR_TYPE_PASSAGE,  0},
    {181121,    BOSS_THADDIUS,  DOOR_TYPE_ROOM,     0},
    {181124,    BOSS_RAZUVIOUS, DOOR_TYPE_PASSAGE,  0},
    {181124,    BOSS_GOTHIK,    DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181125,    BOSS_GOTHIK,    DOOR_TYPE_PASSAGE,  BOUNDARY_S},
    {181119,    BOSS_GOTHIK,    DOOR_TYPE_PASSAGE,  0},
    {181119,    BOSS_HORSEMEN,  DOOR_TYPE_ROOM,     BOUNDARY_NE},
    {181225,    BOSS_SAPPHIRON, DOOR_TYPE_PASSAGE,  BOUNDARY_W},
    {181228,    BOSS_KELTHUZAD, DOOR_TYPE_ROOM,     BOUNDARY_S},
    {0,         0,              DOOR_TYPE_ROOM,     0}, // EOF
};

const MinionData minionData[] =
{
    //{16573,     BOSS_ANUBREKHAN},     there is no spawn point in db, so we do not add them here
    {16506,     BOSS_FAERLINA},
    {16803,     BOSS_RAZUVIOUS},
    {16063,     BOSS_HORSEMEN},
    {16064,     BOSS_HORSEMEN},
    {16065,     BOSS_HORSEMEN},
    {30549,     BOSS_HORSEMEN},
    {0,         0, }
};

enum eEnums
{
    GO_HORSEMEN_CHEST_HERO  = 193426,
    GO_HORSEMEN_CHEST       = 181366,                   //four horsemen event, DoRespawnGameObject() when event == DONE
    GO_GOTHIK_GATE          = 181170,
    GO_KELTHUZAD_PORTAL01   = 181402,
    GO_KELTHUZAD_PORTAL02   = 181403,
    GO_KELTHUZAD_PORTAL03   = 181404,
    GO_KELTHUZAD_PORTAL04   = 181405,
    GO_KELTHUZAD_TRIGGER    = 181444,

    SPELL_ERUPTION          = 29371
};

const float HeiganPos[2] = {2796, -3707};
const float HeiganEruptionSlope[3] =
{
    (-3685 - HeiganPos[1]) /(2724 - HeiganPos[0]),
    (-3647 - HeiganPos[1]) /(2749 - HeiganPos[0]),
    (-3637 - HeiganPos[1]) /(2771 - HeiganPos[0]),
};

// 0  H      x
//  1        ^
//   2       |
//    3  y<--o
inline uint32 GetEruptionSection(float x, float y)
{
    y -= HeiganPos[1];
    if (y < 1.0f)
        return 0;

    x -= HeiganPos[0];
    if (x > -1.0f)
        return 3;

    float slope = y/x;
    for (uint32 i = 0; i < 3; ++i)
        if (slope > HeiganEruptionSlope[i])
            return i;
    return 3;
}

#define MR_BIGGLESWORTH_DEATH_YELL -1533089

class instance_naxxramas : public InstanceMapScript
{
public:
    instance_naxxramas() : InstanceMapScript("instance_naxxramas", 533) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_naxxramas_InstanceMapScript(pMap);
    }

    struct instance_naxxramas_InstanceMapScript : public InstanceScript
    {
        instance_naxxramas_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetBossNumber(MAX_BOSS_NUMBER);
            LoadDoorData(doorData);
            LoadMinionData(minionData);
            
            /*somebodyDiedAnub = false;
            somebodyDiedPatch = false;
            somebodyDiedRazu = false;
            somebodyDiedNoth = false;
            somebodyDiedSapphi = false;

            somebodyDiedArachnid = true;
            somebodyDiedConstruct = true;
            somebodyDiedMilitary = true;
            somebodyDiedPlague = true;
            somebodyDiedFrostwyrm = true;*/
        }

        //std::set<uint64> HeiganEruptionGUID[4];
        std::set<GameObject*> HeiganEruption[4];
        uint64 GothikGateGUID;
        uint64 HorsemenChestGUID;
        uint64 SapphironGUID;
        uint64 uiFaerlina;
        uint64 uiThane;
        uint64 uiLady;
        uint64 uiBaron;
        uint64 uiSir;

        uint64 uiThaddius;
        uint64 uiFeugen;
        uint64 uiStalagg;

        uint64 uiKelthuzad;
        uint64 uiKelthuzadTrigger;
        uint64 uiPortals[4];

        uint64 uiKelthuzad_2;

        GOState gothikDoorState;

        time_t minHorsemenDiedTime;
        time_t maxHorsemenDiedTime;

        uint32 arachnidStatus;
        uint32 constructStatus;
        uint32 militaryStatus;
        uint32 plagueStatus;
        uint32 frostwyrmStatus;

        uint32 anubStatus;
        uint32 patchStatus;
        uint32 razuStatus;
        uint32 nothStatus;
        uint32 sapphiStatus;

        void Inizialize()
        {
            GothikGateGUID = 0;
            HorsemenChestGUID = 0;
            SapphironGUID = 0;
            arachnidStatus = CRITERIA_NOT_MEETED;
            constructStatus = CRITERIA_NOT_MEETED;
            militaryStatus = CRITERIA_NOT_MEETED;
            plagueStatus = CRITERIA_NOT_MEETED;
            frostwyrmStatus = CRITERIA_NOT_MEETED;
            anubStatus = CRITERIA_MEETED;
            patchStatus = CRITERIA_MEETED;
            razuStatus = CRITERIA_MEETED;
            nothStatus = CRITERIA_MEETED;
            sapphiStatus = CRITERIA_MEETED;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch(creature->GetEntry())
            {
                case 15989: SapphironGUID = creature->GetGUID(); return;
                case 15953: uiFaerlina = creature->GetGUID(); return;
                case 16064: uiThane = creature->GetGUID(); return;
                case 16065: uiLady = creature->GetGUID(); return;
                case 30549: uiBaron = creature->GetGUID(); return;
                case 16063: uiSir = creature->GetGUID(); return;
                case 15928: uiThaddius = creature->GetGUID(); return;
                case 15930: uiFeugen = creature->GetGUID(); return;
                case 15929: uiStalagg = creature->GetGUID(); return;
                case 15990: uiKelthuzad = creature->GetGUID(); return;
                case 60201: uiKelthuzad_2 = creature->GetGUID(); return;
            }

            AddMinion(creature, true);
        }

        void OnCreatureRemove(Creature* creature)
        {
            AddMinion(creature, false);
        }

        void OnGameObjectCreate(GameObject* go)
        {
            if (go->GetGOInfo()->displayId == 6785 || go->GetGOInfo()->displayId == 1287)
            {
                uint32 section = GetEruptionSection(go->GetPositionX(), go->GetPositionY());
                HeiganEruption[section].insert(go);
                return;
            }

            switch(go->GetEntry())
            {
                case GO_GOTHIK_GATE:
                    GothikGateGUID = go->GetGUID();
                    go->SetGoState(gothikDoorState);
                    break;
                case GO_HORSEMEN_CHEST: 
                    HorsemenChestGUID = go->GetGUID(); 
                    break;
                case GO_HORSEMEN_CHEST_HERO: 
                    HorsemenChestGUID = go->GetGUID(); 
                    break;
                case GO_KELTHUZAD_PORTAL01: 
                    uiPortals[0] = go->GetGUID(); 
                    break;
                case GO_KELTHUZAD_PORTAL02: 
                    uiPortals[1] = go->GetGUID(); 
                    break;
                case GO_KELTHUZAD_PORTAL03: 
                    uiPortals[2] = go->GetGUID(); 
                    break;
                case GO_KELTHUZAD_PORTAL04: 
                    uiPortals[3] = go->GetGUID(); 
                    break;
                case GO_KELTHUZAD_TRIGGER: 
                    uiKelthuzadTrigger = go->GetGUID(); 
                    break;
                default:
                    break;
            }

            AddDoor(go, true);
        }
        
        void OnGameObjectRemove(GameObject* go)
        {
            if (go->GetGOInfo()->displayId == 6785 || go->GetGOInfo()->displayId == 1287)
            {
                uint32 section = GetEruptionSection(go->GetPositionX(), go->GetPositionY());

                HeiganEruption[section].erase(go);
                return;
            }

            switch (go->GetEntry())
            {
                case GO_BIRTH:
                    if (SapphironGUID)
                    {
                        if (Creature* pSapphiron = instance->GetCreature(SapphironGUID))
                            pSapphiron->AI()->DoAction(DATA_SAPPHIRON_BIRTH);
                        return;
                    }
                    break;
                default:
                    break;
            }

            AddDoor(go, false);
        }

        void SetData(uint32 id, uint32 value)
        {
            switch(id)
            {
                case DATA_HEIGAN_ERUPT:
                    HeiganErupt(value);
                    break;
                case DATA_GOTHIK_GATE:
                    if (GameObject* gothikGate = instance->GetGameObject(GothikGateGUID))
                        gothikGate->SetGoState(GOState(value));
                    gothikDoorState = GOState(value);
                    break;

                case DATA_HORSEMEN0:
                case DATA_HORSEMEN1:
                case DATA_HORSEMEN2:
                case DATA_HORSEMEN3:
                    if (value == NOT_STARTED)
                    {
                        minHorsemenDiedTime = 0;
                        maxHorsemenDiedTime = 0;
                    }
                    else if (value == DONE)
                    {
                        time_t now = time(NULL);

                        if (minHorsemenDiedTime == 0)
                            minHorsemenDiedTime = now;

                        maxHorsemenDiedTime = now;
                    }
                    break;
                case DATA_IMMORTAL_ARACHNID:
                    arachnidStatus = value;
                    break;
                case DATA_IMMORTAL_CONSTRUCT:
                    constructStatus = value;
                    break;
                case DATA_IMMORTAL_MILITARY:
                    militaryStatus = value;
                    break;
                case DATA_IMMORTAL_PLAGUE:
                    plagueStatus = value;
                    break;
                case DATA_IMMORTAL_FROSTWYRM:
                    frostwyrmStatus = value;
                    break;
                case DATA_IMMORTAL_ANUB:
                    anubStatus = value;
                    break;
                case DATA_IMMORTAL_PATCH:
                    patchStatus = value;
                    break;
                case DATA_IMMORTAL_RAZU:
                    razuStatus = value;
                    break;
                case DATA_IMMORTAL_NOTH:
                    nothStatus = value;
                    break;
                case DATA_IMMORTAL_SAPPHI:
                    sapphiStatus = value;
                    break;
            }
        }

        uint32 GetData(uint32 id)
        {
            switch(id)
            {
                case DATA_IMMORTAL_ARACHNID:
                    return arachnidStatus;
                case DATA_IMMORTAL_CONSTRUCT:
                    return constructStatus;
                case DATA_IMMORTAL_MILITARY:
                    return militaryStatus;
                case DATA_IMMORTAL_PLAGUE:
                    return plagueStatus;
                case DATA_IMMORTAL_FROSTWYRM:
                    return frostwyrmStatus;
                case DATA_IMMORTAL_ANUB:
                    return anubStatus;
                case DATA_IMMORTAL_PATCH:
                    return patchStatus;
                case DATA_IMMORTAL_RAZU:
                    return razuStatus;
                case DATA_IMMORTAL_NOTH:
                    return nothStatus;
                case DATA_IMMORTAL_SAPPHI:
                    return sapphiStatus;
                default:
                    return 0;
            }
        }

        uint64 GetData64(uint32 id)
        {
            switch(id)
            {
            case DATA_FAERLINA:
                return uiFaerlina;
            case DATA_THANE:
                return uiThane;
            case DATA_LADY:
                return uiLady;
            case DATA_BARON:
                return uiBaron;
            case DATA_SIR:
                return uiSir;
            case DATA_THADDIUS:
                return uiThaddius;
            case DATA_FEUGEN:
                return uiFeugen;
            case DATA_STALAGG:
                return uiStalagg;
            case DATA_KELTHUZAD:
                return uiKelthuzad;
            case DATA_KELTHUZAD_PORTAL01:
                return uiPortals[0];
            case DATA_KELTHUZAD_PORTAL02:
                return uiPortals[1];
            case DATA_KELTHUZAD_PORTAL03:
                return uiPortals[2];
            case DATA_KELTHUZAD_PORTAL04:
                return uiPortals[3];
            case DATA_KELTHUZAD_TRIGGER:
                return uiKelthuzadTrigger;
            case DATA_KELTHUZAD_2:
                return uiKelthuzad_2;
            }
            return 0;
        }

        bool SetBossState(uint32 id, EncounterState state)
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;

            if (id == BOSS_HORSEMEN && state == DONE)
            {
                if (GameObject *pHorsemenChest = instance->GetGameObject(HorsemenChestGUID))
                    pHorsemenChest->SetRespawnTime(pHorsemenChest->GetRespawnDelay());
            }

            return true;
        }

        /*void HeiganErupt(uint32 section)
        {
            for (uint32 i = 0; i < 4; ++i)
            {
                if (i == section)
                    continue;

                for (std::set<uint64>::const_iterator itr = HeiganEruptionGUID[i].begin(); itr != HeiganEruptionGUID[i].end(); ++itr)
                {
                    if (GameObject *pHeiganEruption = instance->GetGameObject(*itr))
                    {
                        pHeiganEruption->SendCustomAnim(pHeiganEruption->GetGoAnimProgress());
                        pHeiganEruption->CastSpell(NULL, SPELL_ERUPTION);
                    }
                }
            }
        }*/
    
        void HeiganErupt(uint32 section)
        {
            for (uint32 i = 0; i < 4; ++i)
            {
                if (i == section)
                    continue;

                for (std::set<GameObject*>::iterator itr = HeiganEruption[i].begin(); itr != HeiganEruption[i].end(); ++itr)
                {
                    if (*itr)
                    {
                        (*itr)->SendCustomAnim((*itr)->GetGoAnimProgress());
                        (*itr)->CastSpell(NULL, SPELL_ERUPTION);
                    }
                }
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target = NULL*/, uint32 /*miscvalue1 = 0*/)
        {
            switch(criteria_id)
            {
                case 7600:  // Criteria for achievement 2176: And They Would All Go Down Together 15sec of each other 10-man
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_10MAN_NORMAL && (maxHorsemenDiedTime - minHorsemenDiedTime) < 15)
                        return true;
                    return false;
                case 7601:  // Criteria for achievement 2177: And They Would All Go Down Together 15sec of each other 25-man
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_25MAN_NORMAL && (maxHorsemenDiedTime - minHorsemenDiedTime) < 15)
                        return true;
                    return false;
            }
            return false;
        }

        std::string GetSaveData()
        {
            std::ostringstream saveStream;
            saveStream << GetBossSaveData() << gothikDoorState;
            for (uint32 i = DATA_IMMORTAL_ARACHNID; i <= DATA_IMMORTAL_SAPPHI; ++i)
            {
                saveStream << " " << GetData(i);
            }
            return saveStream.str();
        }

        void Load(const char * data)
        {
            /* Load bosses data */
            LoadBossState(data);

            std::istringstream loadStream(data);

            uint32 buff;

            /* Bosses data are loaded in LoadBossState(data) */
            for (uint32 i = 1; i <= MAX_BOSS_NUMBER; ++i)
            {
                
                loadStream >> buff;
                continue;
            }
            
            /* Load Gothik's door state */   
            loadStream >> buff;
            //sLog->outError("State: '%u'", buff);
            gothikDoorState = GOState(buff);

            /* Load Immortal data */
            for (uint32 i = DATA_IMMORTAL_ARACHNID; i <= DATA_IMMORTAL_SAPPHI; ++i)
            {
                loadStream >> buff;
                //sLog->outError("type='%u', value='%u'", i, buff);
                SetData(i, buff);
            }

        }
    };

};

class naxxramas_teleporter_npc : public CreatureScript
{
    public:
        naxxramas_teleporter_npc(): CreatureScript("naxxramas_teleporter_npc") {}

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (!player)
            return true;

        player->ADD_GOSSIP_ITEM(5, "Teletrasportami all'entrata", GOSSIP_SENDER_MAIN, 1);
        player->ADD_GOSSIP_ITEM(5, "No, grazie", GOSSIP_SENDER_MAIN, 2);
         
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());

        return true;
    };

    void SendDefaultMenu_naxxramas_teleporter_npc(Player* player, Creature* creature, uint32 action)
    {
        if (!player)
            return;

        // Not allow in combat
        if (!player->getAttackers().empty())
        {
            player->CLOSE_GOSSIP_MENU();
            creature->MonsterSay("Sei in combat!", LANG_UNIVERSAL, 0);
            return;
        }
        
        switch(action)
        {
            case 1:
                // Teletrasporta all'entrata
                player->TeleportTo(533, 3021.639f, -3402.989f, 298.220f, 2.973f);
                player->CLOSE_GOSSIP_MENU();
                creature->MonsterWhisper("Ecco fatto!", player->GetGUID());
                break;
            case 2:
                creature->MonsterWhisper("Ok, come preferisci...", player->GetGUID());
                player->CLOSE_GOSSIP_MENU();
                break;
            default:
                break;
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();

        // Main menu
        if (sender == GOSSIP_SENDER_MAIN)
            SendDefaultMenu_naxxramas_teleporter_npc(player, creature, action);

        return true;
    };
};

class mr_bigglesworth_npc : public CreatureScript
{
    public:
        mr_bigglesworth_npc(): CreatureScript("mr_bigglesworth_npc") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mr_bigglesworth_npcAI (creature);
    }

    struct mr_bigglesworth_npcAI : public ScriptedAI
    {
        mr_bigglesworth_npcAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;

        void JustDied(Unit* killer)
        {
            if (Creature* KelThuzad = Unit::GetCreature(*me, pInstance ? pInstance->GetData64(DATA_KELTHUZAD_2) : 0))
                KelThuzad->MonsterYellToZone(MR_BIGGLESWORTH_DEATH_YELL, LANG_UNIVERSAL, 0);
        }
    };
};

#define NAXXRAMAS_MAP 533

class achievement_immortal : public AchievementCriteriaScript
{
    public:
        achievement_immortal() : AchievementCriteriaScript("achievement_immortal") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            InstanceScript* instance = source->GetInstanceScript();

            if (!instance || source->GetMapId() != NAXXRAMAS_MAP)
                return false;

            if (instance->GetData(DATA_IMMORTAL_ARACHNID) == CRITERIA_NOT_MEETED)
                return false;

            if (instance->GetData(DATA_IMMORTAL_CONSTRUCT) == CRITERIA_NOT_MEETED)
                return false;

            if (instance->GetData(DATA_IMMORTAL_MILITARY) == CRITERIA_NOT_MEETED)
                return false;

            if (instance->GetData(DATA_IMMORTAL_PLAGUE) == CRITERIA_NOT_MEETED)
                return false;

            if (instance->GetData(DATA_IMMORTAL_FROSTWYRM) == CRITERIA_NOT_MEETED)
                return false;

            return true;
        }
};

void AddSC_instance_naxxramas()
{
    new instance_naxxramas();
    new naxxramas_teleporter_npc();
    new mr_bigglesworth_npc();
    new achievement_immortal();
}
