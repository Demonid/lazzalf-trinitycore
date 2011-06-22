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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"
#include "ulduar.h"

const DoorData doorData[] =
{
    {194416,    BOSS_LEVIATHAN, DOOR_TYPE_ROOM,     0},
    {194905,    BOSS_LEVIATHAN, DOOR_TYPE_PASSAGE,  0},
    {194631,    BOSS_XT002,     DOOR_TYPE_ROOM,     0},
    {194554,    BOSS_ASSEMBLY,  DOOR_TYPE_ROOM,     0},
    {194556,    BOSS_ASSEMBLY,  DOOR_TYPE_PASSAGE,  0},
    {194553,    BOSS_KOLOGARN,  DOOR_TYPE_ROOM,     0},
    {194441,    BOSS_HODIR,     DOOR_TYPE_PASSAGE,  0},
    {194634,    BOSS_HODIR,     DOOR_TYPE_PASSAGE,  0},
    {194442,    BOSS_HODIR,     DOOR_TYPE_ROOM,     0},
    {194559,    BOSS_THORIM,    DOOR_TYPE_ROOM,     0},
    {194774,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194775,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194776,    BOSS_MIMIRON,   DOOR_TYPE_ROOM,     0},
    {194750,    BOSS_VEZAX,     DOOR_TYPE_PASSAGE,  0},
    {194773,    BOSS_YOGGSARON, DOOR_TYPE_ROOM,     0},
    {194767,    BOSS_ALGALON,   DOOR_TYPE_ROOM,     0},
    {0,         0,              DOOR_TYPE_ROOM,     0}, // EOF
};

#define ACHIEVEMENT_DWARFAGEDDON_10         3097
#define ACHIEVEMENT_DWARFAGEDDON_25         3098
#define DWARFAGEDDON_MAX_TIMER              10 * 1000 // 10s
#define DWARFAGEDDON_MIN_COUNT              100
#define ACHIEVEMENT_LUMBERJACKED_10         2979
#define ACHIEVEMENT_LUMBERJACKED_25         3118
#define LUMBERJACKED_MAX_TIMER              15 * 1000 // 15s
#define ELDERS_NUMBER                       3
#define CONSPEEDATORY_MAX_TIMER             20 * MINUTE * IN_MILLISECONDS // 20 min
#define ACHI_COMING_OUT_OF_THE_WALLS_10     3014
#define ACHI_COMING_OUT_OF_THE_WALLS_25     3017
#define COMING_OUT_MAX_TIMER                12 * 1000 // 12s
#define COMING_OUT_MIN_COUNT                9

class instance_ulduar : public InstanceMapScript
{
    public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", 603) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_ulduar_InstanceMapScript(pMap);
    }
    
    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript (Map* pMap) : InstanceScript(pMap)
        {
            SetBossNumber(MAX_BOSS_NUMBER);
            LoadDoorData(doorData);            
        }

        uint64 uiLeviathanGUID;
        uint64 uiLeviathanLoot;
        uint64 uiNorgannon;
        uint64 uiIgnis;
        uint64 uiRazorscale;
        uint64 uiExpCommander;
        uint64 uiXT002;
        uint64 uiSteelbreaker;
        uint64 uiMolgeim;
        uint64 uiBrundir;
        uint64 uiKologarn;
        uint64 uiRightArm;
        uint64 uiLeftArm;
        uint64 uiKologarnBridge;
        uint64 uiAuriaya;
        uint64 uiBrightleaf;
        uint64 uiIronbranch;
        uint64 uiStonebark;
        uint64 uiFreya;
        uint64 uiThorim;
        uint64 uiRunicColossus;
        uint64 uiRuneGiant;
        uint64 uiMimiron;
        uint64 uiLeviathanMKII;
        uint64 uiVX001;
        uint64 uiAerialUnit;
        uint64 uiMagneticCore;
        uint64 KeepersGateGUID;
        uint64 uiVezax;
        uint64 uiFreyaImage;
        uint64 uiThorimImage;
        uint64 uiMimironImage;
        uint64 uiHodirImage;
        uint64 uiFreyaYS;
        uint64 uiThorimYS;
        uint64 uiMimironYS;
        uint64 uiHodirYS;
        uint64 uiYoggSaronBrain;
        uint64 uiYoggSaron;

        uint64 uiLeviathanDoor[7];
        uint8  flag;
        
        int32 towerDestroyedCount;
        bool towerOfStorms;
        bool towerOfLife;
        bool towerOfFlames;
        bool towerOfFrost;

        uint32 activeKeepers;

        // Achievements
        // Unbroken
        bool vehicleRepaired;
        // Dwarfageddon
        uint32 steelforgedDefendersCount;
        uint32 dwarfageddonTimer;
        uint32 achievementDwarfageddon;
        // Can't Do That While Stunned
        bool wasHitByLightning;
        // Lumberjacked
        uint8 eldersCount;
        uint32 lumberjackedTimer;
        uint32 achievementLumberjacked;
        // Con-speed-atory
        uint32 conspeedatoryTimer;
        // They're Coming Out of the Walls
        uint32 guardiansCount;
        uint32 comingOutTimer;
        uint32 achievementComingOut;
        // Set Up Us the Bomb
        bool proximityMineHit;
        bool bombBotHit;
        bool rocketStrikeHit;
        // In His House He Waits Dreaming
        uint32 currentIllusion;

        // Champion/Conqueror of Ulduar
        uint32 leviathanStatus;
        uint32 ignisStatus;
        uint32 razorscaleStatus;
        uint32 xtStatus;
        uint32 assemblyStatus;
        uint32 kologarnStatus;
        uint32 auriayaStatus;
        uint32 mimironStatus;
        uint32 hodirStatus;
        uint32 thorimStatus;
        uint32 freyaStatus;
        uint32 vezaxStatus;
        uint32 yoggStatus;
        uint32 algalonStatus;

        // Algalon
        uint64 uiAlgalonGUID;
        uint64 uiAlgalonBridgeGUID;
        uint64 uiAlgalonBridgeVisualGUID;
        uint64 uiAlgalonBridgeDoorGUID;
        uint64 uiAlgalonGlobeGUID;
        uint64 uiAlgalonDoor1GUID;
        uint64 uiAlgalonDoor2GUID;
        uint64 uiAlgalonAccessGUID;

        uint32 uiCountdownTimer;
        uint32 uiAlgalonCountdown;
        //   62 - not ready to engage
        //   61 - ready to engage, not engaged yet
        // < 61 - engaged, timer running
        //    0 - failed
            
        GameObject* pLeviathanDoor, *KologarnChest, *HodirChest, *HodirRareChest, *ThorimChest, *ThorimRareChest, *pRunicDoor, *pStoneDoor, *pThorimLever,
            *MimironTram, *MimironElevator;

        void Initialize()
        {
            uiLeviathanGUID = 0;
            uiLeviathanLoot = 0;
            uiNorgannon = 0;
            uiIgnis = 0;
            uiRazorscale = 0;
            uiExpCommander = 0;
            uiXT002 = 0;
            uiSteelbreaker = 0;
            uiMolgeim = 0;
            uiBrundir = 0;
            uiKologarn = 0;
            uiRightArm = 0;
            uiLeftArm = 0;
            uiKologarnBridge = 0;
            uiAuriaya = 0;
            uiBrightleaf = 0;
            uiIronbranch = 0;
            uiStonebark = 0;
            uiFreya = 0;
            uiThorim = 0;
            uiRunicColossus = 0;
            uiRuneGiant = 0;
            uiMimiron = 0;
            uiLeviathanMKII = 0;
            uiVX001 = 0;
            uiAerialUnit = 0;
            uiMagneticCore = 0;
            KeepersGateGUID = 0;
            uiVezax = 0;
            uiFreyaImage = 0;
            uiThorimImage = 0;
            uiMimironImage = 0;
            uiHodirImage = 0;
            uiFreyaYS = 0;
            uiThorimYS = 0;
            uiMimironYS = 0;
            uiHodirYS = 0;
            uiYoggSaronBrain = 0;
            uiYoggSaron = 0;

            uiAlgalonGUID             = 0;
            uiAlgalonBridgeGUID       = 0;
            uiAlgalonBridgeVisualGUID = 0;
            uiAlgalonBridgeDoorGUID   = 0;
            uiAlgalonGlobeGUID        = 0;
            uiAlgalonDoor1GUID        = 0;
            uiAlgalonDoor2GUID        = 0;
            uiAlgalonAccessGUID       = 0;

            uiCountdownTimer          = 1*MINUTE*IN_MILLISECONDS;
            uiAlgalonCountdown        = 62;

            pLeviathanDoor = NULL;
            KologarnChest = NULL;
            HodirChest = NULL;
            HodirRareChest = NULL;
            ThorimChest = NULL;
            ThorimRareChest = NULL;
            pRunicDoor = NULL;
            pStoneDoor = NULL;
            pThorimLever = NULL;
            MimironTram = NULL;
            MimironElevator = NULL;

            towerDestroyedCount = 0;
            towerOfStorms = true;
            towerOfLife = true;
            towerOfFlames = true;
            towerOfFrost = true;
            vehicleRepaired = false;
            steelforgedDefendersCount = 0;
            dwarfageddonTimer = 0;
            achievementDwarfageddon = 0;
            wasHitByLightning = false;
            eldersCount = 0;
            lumberjackedTimer = 0;
            achievementLumberjacked = 0;
            conspeedatoryTimer = 0;
            guardiansCount = 0;
            comingOutTimer = 0;
            achievementComingOut = 0;
            proximityMineHit = false;
            bombBotHit = false;
            rocketStrikeHit = false;
            flag = 0;
            activeKeepers = 0;
            currentIllusion = 0;
            memset(&uiLeviathanDoor, 0, sizeof(uiLeviathanDoor));

            // Champion/Conqueror of Ulduar
            leviathanStatus = CRITERIA_MEETED;
            ignisStatus = CRITERIA_MEETED;
            razorscaleStatus = CRITERIA_MEETED;
            xtStatus = CRITERIA_MEETED;
            assemblyStatus = CRITERIA_MEETED;
            kologarnStatus = CRITERIA_MEETED;
            auriayaStatus = CRITERIA_MEETED;
            mimironStatus = CRITERIA_MEETED;
            hodirStatus = CRITERIA_MEETED;
            thorimStatus = CRITERIA_MEETED;
            freyaStatus = CRITERIA_MEETED;
            vezaxStatus = CRITERIA_MEETED;
            yoggStatus = CRITERIA_MEETED;
            algalonStatus = CRITERIA_MEETED;
        }

        void OnGameObjectCreate(GameObject* go)
        {
            AddDoor(go, true);

            switch(go->GetEntry())
            {
                case GO_LEVIATHAN_DOOR:                    
                    uiLeviathanDoor[flag] = go->GetGUID();
                    HandleGameObject(NULL, true, go);
                    flag++;
                    if (flag == 7)
                        flag = 0;
                    break;
                case GO_LEVIATHAN_GATE:
                    pLeviathanDoor = go;
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_KOLOGARN_CHEST_HERO: 
                    KologarnChest = go;
                    break;
                case GO_KOLOGARN_CHEST: 
                    KologarnChest = go;
                    break;
                case GO_KOLOGARN_BRIDGE: 
                    uiKologarnBridge = go->GetGUID(); 
                    HandleGameObject(uiKologarnBridge, true); 
                    break;
                case GO_Hodir_CHEST_HERO: 
                    HodirChest = go; 
                    break;
                case GO_Hodir_CHEST: 
                    HodirChest = go; 
                    break;                
                case GO_Hodir_Rare_CHEST_HERO: 
                    HodirRareChest = go; 
                    break;
                case GO_Hodir_Rare_CHEST: 
                    HodirRareChest = go; 
                    break;
                case GO_Thorim_CHEST_HERO: 
                    ThorimChest = go; 
                    break;
                case GO_Thorim_CHEST: 
                    ThorimChest = go; 
                    break;
                case GO_Thorim_Rare_CHEST_HERO: 
                    ThorimRareChest = go; 
                    break;                    
                case GO_Thorim_Rare_CHEST: 
                    ThorimRareChest = go; 
                    break;
                case GO_Runic_DOOR: 
                    pRunicDoor = go; 
                    break;
                case GO_Stone_DOOR: 
                    pStoneDoor = go; 
                    break;
                case GO_Thorim_LEVER: 
                    pThorimLever = go; 
                    break;
                case GO_Mimiron_TRAM: 
                    MimironTram = go; 
                    break;
                case GO_Mimiron_ELEVATOR: 
                    MimironElevator = go; 
                    break;
                case GO_Keepers_DOOR: KeepersGateGUID = go->GetGUID();
                {
                    InstanceScript *data = go->GetInstanceScript();
                    go->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                    if (data)
                        for (uint32 i = BOSS_MIMIRON; i < BOSS_VEZAX; ++i)
                            if (data->GetBossState(i) != DONE)
                                go->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                    break;
                }
                case GO_ALGALON_PLATFORM:
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_BRIDGE:
                    uiAlgalonBridgeGUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_B_VISUAL:
                    uiAlgalonBridgeVisualGUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_B_DOOR:
                    uiAlgalonBridgeDoorGUID = go->GetGUID();
                    HandleGameObject(NULL, true, go);
                    break;
                case GO_ALGALON_GLOBE:
                    uiAlgalonGlobeGUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_DOOR_1:
                    uiAlgalonDoor1GUID = go->GetGUID();
                    HandleGameObject(NULL, uiAlgalonCountdown < 62 ? true : false, go);
                    break;
                case GO_ALGALON_DOOR_2:
                    uiAlgalonDoor2GUID = go->GetGUID();
                    HandleGameObject(NULL, uiAlgalonCountdown < 62 ? true : false, go);
                    break;
                case GO_ALGALON_ACCESS:
                    uiAlgalonAccessGUID = go->GetGUID();
                    if (uiAlgalonCountdown < 62)
                    {
                        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_UNK1);
                        go->SetGoState(GO_STATE_ACTIVE);
                    }
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go)
        {
            AddDoor(go, false);
        }

        void OnCreatureCreate(Creature* creature)
        {
            Map::PlayerList const &players = instance->GetPlayers();
            uint32 TeamInInstance = 0;

            if (!players.isEmpty())
                if (Player* pPlayer = players.begin()->getSource())
                    TeamInInstance = pPlayer->GetTeam();
            
            switch(creature->GetEntry())
            {
                case NPC_LEVIATHAN: 
                    uiLeviathanGUID = creature->GetGUID(); 
                    return;
                case NPC_LEVIATHAN_LOOT:
                    uiLeviathanLoot  = creature->GetGUID();
                    return;
                case 33686: 
                    uiNorgannon = creature->GetGUID(); 
                    return;
                case NPC_IGNIS: 
                    uiIgnis = creature->GetGUID(); 
                    return;
                case NPC_RAZORSCALE: 
                    uiRazorscale = creature->GetGUID(); 
                    return;
                case NPC_EXPEDITION_COMMANDER: 
                    uiExpCommander = creature->GetGUID(); 
                    return;
                case NPC_XT002: 
                    uiXT002 = creature->GetGUID(); 
                    return;
                case NPC_STEELBREAKER: 
                    uiSteelbreaker = creature->GetGUID(); 
                    return;
                case NPC_MOLGEIM: 
                    uiMolgeim = creature->GetGUID(); 
                    return;
                case NPC_BRUNDIR: 
                    uiBrundir = creature->GetGUID(); 
                    return;
                case NPC_KOLOGARN: 
                    uiKologarn = creature->GetGUID(); 
                    return;
                case NPC_RIGHT_ARM: 
                    uiRightArm = creature->GetGUID(); 
                    return;
                case NPC_LEFT_ARM: 
                    uiLeftArm = creature->GetGUID(); 
                    return;
                case NPC_AURIAYA: 
                    uiAuriaya = creature->GetGUID(); 
                    return;
                case 32915: 
                    uiBrightleaf = creature->GetGUID(); 
                    return;
                case 32913: 
                    uiIronbranch = creature->GetGUID(); 
                    return;
                case 32914: 
                    uiStonebark = creature->GetGUID(); 
                    return;
                case NPC_FREYA: 
                    uiFreya = creature->GetGUID(); 
                    return;
                case NPC_THORIM: 
                    uiThorim = creature->GetGUID(); 
                    return;
                case 32872: 
                    uiRunicColossus = creature->GetGUID(); 
                    return;
                case 32873: 
                    uiRuneGiant = creature->GetGUID(); 
                    return;
                case NPC_MIMIRON: 
                    uiMimiron = creature->GetGUID(); 
                    return;
                case 33432: 
                    uiLeviathanMKII = creature->GetGUID(); 
                    return;
                case 33651: 
                    uiVX001 = creature->GetGUID(); 
                    return;
                case 33670: 
                    uiAerialUnit = creature->GetGUID(); 
                    return;
                case 34068: 
                    uiMagneticCore = creature->GetGUID(); 
                    return;
                case NPC_VEZAX: 
                    uiVezax = creature->GetGUID(); 
                    return;
                case 33410: 
                    uiFreyaYS = creature->GetGUID(); 
                    return;
                case 33413: 
                    uiThorimYS = creature->GetGUID(); 
                    return;
                case 33412: 
                    uiMimironYS = creature->GetGUID(); 
                    return;
                case 33411: 
                    uiHodirYS = creature->GetGUID(); 
                    return;
                case 33890: 
                    uiYoggSaronBrain = creature->GetGUID(); 
                    return;
                case NPC_YOGGSARON: 
                    uiYoggSaron = creature->GetGUID(); 
                    return;

                // Keeper's Images
                case 33241: 
                    uiFreyaImage = creature->GetGUID();
                    {
                        InstanceScript *data = creature->GetInstanceScript();
                        creature->SetVisible(false);
                        if (data && data->GetBossState(BOSS_VEZAX) == DONE)
                            creature->SetVisible(true);
                    }
                    return;
                case 33242: 
                    uiThorimImage = creature->GetGUID();
                    {
                        InstanceScript *data = creature->GetInstanceScript();
                        creature->SetVisible(false);
                        if (data && data->GetBossState(BOSS_VEZAX) == DONE)
                            creature->SetVisible(true);
                    }
                    return;
                case 33244: 
                    uiMimironImage = creature->GetGUID();
                    {
                        InstanceScript *data = creature->GetInstanceScript();
                        creature->SetVisible(false);
                        if (data && data->GetBossState(BOSS_VEZAX) == DONE)
                            creature->SetVisible(true);
                    }            
                    return;
                case 33213: 
                    uiHodirImage = creature->GetGUID();
                    {
                        InstanceScript *data = creature->GetInstanceScript();
                        creature->SetVisible(false);
                        if (data && data->GetBossState(BOSS_VEZAX) == DONE)
                            creature->SetVisible(true);
                    }
                    return;

                case NPC_ALGALON:
                    uiAlgalonGUID = creature->GetGUID();
                    if (uiAlgalonCountdown < 62)
                    {
                        creature->setFaction(7);
                        creature->setActive(true);
                    }
                    else
                        creature->SetVisible(false);
                    return;
            }

            // Hodir: Alliance npcs are spawned by default
            if (TeamInInstance == HORDE)
                switch(creature->GetEntry())
                {
                    case 33325: creature->UpdateEntry(32941, HORDE); return;
                    case 32901: creature->UpdateEntry(33333, HORDE); return;
                    case 33328: creature->UpdateEntry(33332, HORDE); return;
                    case 32900: creature->UpdateEntry(32950, HORDE); return;
                    case 32893: creature->UpdateEntry(33331, HORDE); return;
                    case 33327: creature->UpdateEntry(32946, HORDE); return;
                    case 32897: creature->UpdateEntry(32948, HORDE); return;
                    case 33326: creature->UpdateEntry(33330, HORDE); return;
                    case 32908: creature->UpdateEntry(32907, HORDE); return;
                    case 32885: creature->UpdateEntry(32883, HORDE); return;
                }
        }

        /*
        void OnPlayerKilled(Player* player) 
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (uiEncounter[i] == IN_PROGRESS)
                {
                    if (i < TYPE_ALGALON)
                        uiPlayerDeathFlag |= UlduarBossDeadFlags(TypeToDeadFlag(i));
                    else if (i == TYPE_ALGALON)
                        uiAlgalonKillCount++; // He feeds on your tears
                }
            }
        }
        */

        uint64 GetData64(uint32 id)
        {
            switch(id)
            {
                case DATA_LEVIATHAN:
                    return uiLeviathanGUID;
                case DATA_NPC_LEVIATHAN_LOOT:
                    return uiLeviathanLoot;
                case DATA_NORGANNON:
                    return uiNorgannon;
                case DATA_IGNIS:
                    return uiIgnis;
                case DATA_RAZORSCALE:
                    return uiRazorscale;
                case DATA_EXP_COMMANDER:
                    return uiExpCommander;
                case DATA_XT002:
                    return uiXT002;
                case DATA_STEELBREAKER:
                    return uiSteelbreaker;
                case DATA_MOLGEIM:
                    return uiMolgeim;
                case DATA_BRUNDIR:
                    return uiBrundir;
                case DATA_KOLOGARN:
                    return uiKologarn;
                case DATA_RIGHT_ARM:
                    return uiRightArm;
                case DATA_LEFT_ARM:
                    return uiLeftArm;
                case DATA_AURIAYA:
                    return uiAuriaya;
                case DATA_BRIGHTLEAF:
                    return uiBrightleaf;
                case DATA_IRONBRANCH:
                    return uiIronbranch;
                case DATA_STONEBARK:
                    return uiStonebark;
                case DATA_FREYA:
                    return uiFreya;
                case DATA_THORIM:
                    return uiThorim;
                case DATA_RUNIC_COLOSSUS:
                    return uiRunicColossus;
                case DATA_RUNE_GIANT:
                    return uiRuneGiant;
                case DATA_MIMIRON:
                    return uiMimiron;
                case DATA_LEVIATHAN_MK_II:
                    return uiLeviathanMKII;
                case DATA_VX_001:
                    return uiVX001;
                case DATA_AERIAL_UNIT:
                    return uiAerialUnit;
                case DATA_MAGNETIC_CORE:
                    return uiMagneticCore;
                case DATA_VEZAX:
                    return uiVezax;
                case DATA_YS_FREYA:
                    return uiFreyaYS;
                case DATA_YS_THORIM:
                    return uiThorimYS;
                case DATA_YS_MIMIRON:
                    return uiMimironYS;
                case DATA_YS_HODIR:
                    return uiHodirYS;
                case DATA_YOGGSARON_BRAIN:
                    return uiYoggSaronBrain;
                case DATA_YOGGSARON:
                    return uiYoggSaron;
                case DATA_ALGALON:              
                    return uiAlgalonGUID;
            }
            return 0;
        }
        
        void SetData(uint32 id, uint32 value)
        {
            switch(id)
            {                
                case DATA_LEVIATHAN_DOOR:
                    if (pLeviathanDoor)
                        pLeviathanDoor->SetGoState(GOState(value));
                    break;
                case DATA_TOWER_DESTROYED:
                    {                        
                        switch(value)
                        {                                
                            case TOWER_OF_STORM_DESTROYED:
                                towerOfStorms = false;
                                ++towerDestroyedCount;
                                break;
                            case TOWER_OF_LIFE_DESTROYED:
                                towerOfLife = false;
                                ++towerDestroyedCount;
                                break;
                            case TOWER_OF_FLAMES_DESTROYED:
                                towerOfFlames = false;
                                ++towerDestroyedCount;
                                break;
                            case TOWER_OF_FROST_DESTROYED:
                                towerOfFrost = false;
                                ++towerDestroyedCount;
                                break;
                            default:
                                break;
                        }
                    }
                    break;
                case DATA_RUNIC_DOOR:
                    if (pRunicDoor)
                        pRunicDoor->SetGoState(GOState(value));
                    break;
                case DATA_STONE_DOOR:
                    if (pStoneDoor)
                        pStoneDoor->SetGoState(GOState(value));
                    break;
                case DATA_CALL_TRAM:
                    if (MimironTram && instance)
                    {
                        // Load Mimiron Tram (unfortunally only server side)
                        instance->LoadGrid(2307, 284.632f);
                    
                        if (value == 0)
                            MimironTram->SetGoState(GO_STATE_READY);
                        if (value == 1)
                            MimironTram->SetGoState(GO_STATE_ACTIVE);
                        
                        // Send movement update to players
                        if (Map* pMap = MimironTram->GetMap())
                            if (pMap->IsDungeon())
                            {
                                Map::PlayerList const &PlayerList = pMap->GetPlayers();

                                if (!PlayerList.isEmpty())
                                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                        if (i->getSource())
                                        {
                                            UpdateData data;
                                            WorldPacket pkt;
                                            MimironTram->BuildValuesUpdateBlockForPlayer(&data, i->getSource());
                                            data.BuildPacket(&pkt);
                                            i->getSource()->GetSession()->SendPacket(&pkt);
                                        }
                            }
                    }
                    break;
                case DATA_MIMIRON_ELEVATOR:
                    if (MimironElevator)
                        MimironElevator->SetGoState(GOState(value));
                    break; 
                case DATA_HODIR_CHEST:
                    if (HodirChest && value == GO_STATE_READY)
                        HodirChest->SetRespawnTime(HodirChest->GetRespawnDelay());
                    break;
                case DATA_HODIR_RARE_CHEST:
                    if (HodirRareChest && value == GO_STATE_READY)
                        HodirRareChest->SetRespawnTime(HodirRareChest->GetRespawnDelay());
                    break;
                case DATA_THORIM_CHEST:
                    if (ThorimChest && value == GO_STATE_READY)
                        ThorimChest->SetRespawnTime(ThorimChest->GetRespawnDelay());
                    break;
                case DATA_THORIM_RARE_CHEST:
                    if (ThorimRareChest && value == GO_STATE_READY)
                        ThorimRareChest->SetRespawnTime(ThorimRareChest->GetRespawnDelay());
                    break;
                // Achievement
                case DATA_ACHI_UNBROKEN:
                    if (value == ACHI_FAILED)
                        vehicleRepaired = true;
                    break;
                case DATA_DWARFAGEDDON:
                    if (value == ACHI_START)
                        dwarfageddonTimer = DWARFAGEDDON_MAX_TIMER;
                    else if (value == ACHI_INCREASE)
                        steelforgedDefendersCount++;
                    else if (value == ACHI_RESET)
                    {
                        dwarfageddonTimer = 0;
                        steelforgedDefendersCount = 0;
                    }
                    break;                    
                case DATA_CANT_WHILE_STUNNED:
                    if (value == ACHI_FAILED || value == ACHI_COMPLETED)
                        wasHitByLightning = true;
                    else if (value == ACHI_START)
                        wasHitByLightning = false;
                    break;
                case DATA_LUMBERJACKED:
                    if (value == ACHI_START)
                        lumberjackedTimer = LUMBERJACKED_MAX_TIMER;
                    else if (value == ACHI_FAILED || value == ACHI_COMPLETED)
                        lumberjackedTimer = 0;
                    else if (value == ACHI_INCREASE)
                        eldersCount++;
                    break;                    
                case DATA_CONSPEEDATORY:
                    if (value == ACHI_START)
                        conspeedatoryTimer = CONSPEEDATORY_MAX_TIMER;
                    else if (value == ACHI_FAILED || value == ACHI_COMPLETED)
                        conspeedatoryTimer = 0;
                    break;
                case DATA_COMING_OUT:
                    if (value == ACHI_START)
                        comingOutTimer = COMING_OUT_MAX_TIMER;
                    else if (value == ACHI_INCREASE)
                        guardiansCount++;
                    else if (value == ACHI_RESET)
                    {
                        comingOutTimer = 0;
                        guardiansCount = 0;
                    }
                    break;
                case DATA_CRITERIA_PROXIMITY_MINE:
                    if (value == CRITERIA_NOT_MEETED)
                        proximityMineHit = true;
                    else if (value == ACHI_RESET)
                        proximityMineHit = false;
                    break;
                case DATA_CRITERIA_BOMB_BOT:
                    if (value == CRITERIA_NOT_MEETED)
                        bombBotHit = true;
                    else if (value == ACHI_RESET)
                        bombBotHit = false;
                    break;
                case DATA_CRITERIA_ROCKET_STRIKE:
                    if (value == CRITERIA_NOT_MEETED)
                        rocketStrikeHit = true;
                    else if (value == ACHI_RESET)
                        rocketStrikeHit = false;
                    break;
                case DATA_ACTIVE_KEEPERS:
                    if (value == 1 && activeKeepers < 4)
                        activeKeepers += value;
                    break;
                case CRITERIA_LEVIATHAN:
                    leviathanStatus = value;
                    break;
                case CRITERIA_IGNIS:
                    ignisStatus = value;
                    break;
                case CRITERIA_RAZORSCALE:
                    razorscaleStatus = value;
                    break;
                case CRITERIA_XT002:
                    xtStatus = value;
                    break;
                case CRITERIA_ASSEMBLY:
                    assemblyStatus = value;
                    break;
                case CRITERIA_KOLOGARN:
                    kologarnStatus = value;
                    break;
                case CRITERIA_AURIAYA:
                    auriayaStatus = value;
                    break;
                case CRITERIA_MIMIRON:
                    mimironStatus = value;
                    break;
                case CRITERIA_HODIR:
                    hodirStatus = value;
                    break;
                case CRITERIA_THORIM:
                    thorimStatus = value;
                    break;
                case CRITERIA_FREYA:
                    freyaStatus = value;
                    break;
                case CRITERIA_VEZAX:
                    vezaxStatus = value;
                    break;
                case CRITERIA_YOGGSARON:
                    yoggStatus = value;
                    break;
                case DATA_FEED:
                    algalonStatus = value;
                    break;
                case DATA_ILLUSION:
                    currentIllusion = value;
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 id)
        {
            switch (id)
            {
                case DATA_TOWER_DESTROYED:
                    return towerDestroyedCount;
                case DATA_TOWER_OF_STORMS:
                    if (towerOfStorms)
                        return 1;
                    else
                        return 0;
                    break;
                case DATA_TOWER_OF_LIFE:
                    if (towerOfLife)
                        return 1;
                    else
                        return 0;
                    break;
                case DATA_TOWER_OF_FLAMES:
                    if (towerOfFlames)
                        return 1;
                    else
                        return 0;
                    break;
                case DATA_TOWER_OF_FROST:
                    if (towerOfFrost)
                        return 1;
                    else
                        return 0;
                    break;
                case DATA_ACHI_UNBROKEN:
                    if (vehicleRepaired == true)
                        return ACHI_FAILED;
                    else
                        return ACHI_IS_IN_PROGRESS;
                case DATA_DWARFAGEDDON:
                    if (dwarfageddonTimer > 0)
                        return ACHI_IS_IN_PROGRESS;
                    else
                        return ACHI_IS_NOT_STARTED;
                case DATA_CANT_WHILE_STUNNED:
                    if (wasHitByLightning == true)
                        return ACHI_FAILED;
                    else
                        return ACHI_IS_IN_PROGRESS;
                case DATA_LUMBERJACKED:
                    if (lumberjackedTimer > 0)
                        return ACHI_IS_IN_PROGRESS;
                    else
                        return ACHI_IS_NOT_STARTED;
                case DATA_CONSPEEDATORY:
                    if (conspeedatoryTimer > 0)
                        return ACHI_IS_IN_PROGRESS;
                    else
                        return ACHI_IS_NOT_STARTED;
                case DATA_COMING_OUT:
                    if (comingOutTimer > 0)
                        return ACHI_IS_IN_PROGRESS;
                    else
                        return ACHI_IS_NOT_STARTED;
                case DATA_CRITERIA_PROXIMITY_MINE:
                    if (proximityMineHit)
                        return CRITERIA_NOT_MEETED;
                    else
                        return CRITERIA_MEETED;
                case DATA_CRITERIA_BOMB_BOT:
                    if (bombBotHit)
                        return CRITERIA_NOT_MEETED;
                    else
                        return CRITERIA_MEETED;
                case DATA_CRITERIA_ROCKET_STRIKE:
                    if (rocketStrikeHit)
                        return CRITERIA_NOT_MEETED;
                    else
                        return CRITERIA_MEETED;
                case DATA_ACTIVE_KEEPERS:
                    return activeKeepers;
                case CRITERIA_LEVIATHAN:
                    return leviathanStatus;
                case CRITERIA_IGNIS:
                    return ignisStatus;
                case CRITERIA_RAZORSCALE:
                    return razorscaleStatus;
                case CRITERIA_XT002:
                    return xtStatus;
                case CRITERIA_ASSEMBLY:
                    return assemblyStatus;
                case CRITERIA_KOLOGARN:
                    return kologarnStatus;
                case CRITERIA_AURIAYA:
                    return auriayaStatus;
                case CRITERIA_MIMIRON:
                    return mimironStatus;
                case CRITERIA_HODIR:
                    return hodirStatus;
                case CRITERIA_THORIM:
                    return thorimStatus;
                case CRITERIA_FREYA:
                    return freyaStatus;
                case CRITERIA_VEZAX:
                    return vezaxStatus;
                case CRITERIA_YOGGSARON:
                    return yoggStatus;
                case DATA_FEED:
                    return algalonStatus;
                case DATA_ILLUSION:
                    return currentIllusion;
                default:
                    return 0;
            }
        }

        //void ProcessEvent(GameObject* /*go*/, uint32 uiEventId, Player* /*player*/)
        /*{
            // Flame Leviathan's Tower Event triggers
           Creature* pFlameLeviathan = instance->GetCreature(uiLeviathanGUID);

            if (pFlameLeviathan && pFlameLeviathan->isAlive()) //No leviathan, no event triggering ;)
                switch(uiEventId)
                {
                    case EVENT_TOWER_OF_STORM_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(1);
                        break;
                    case EVENT_TOWER_OF_FROST_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(2);
                        break;
                    case EVENT_TOWER_OF_FLAMES_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(3);
                        break;
                    case EVENT_TOWER_OF_LIFE_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(4);
                        break;
                }
        }*/

        bool SetBossState(uint32 id, EncounterState state)
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;
                
            switch (id)
            {
                case BOSS_KOLOGARN:
                    if (state == DONE)
                    {
                        HandleGameObject(uiKologarnBridge, false);
                        if (KologarnChest)
                            KologarnChest->SetRespawnTime(KologarnChest->GetRespawnDelay());
                    }
                    break;
                case BOSS_HODIR:
                    CheckKeepersState();
                    break;
                case BOSS_THORIM:
                    if (state == IN_PROGRESS)
                        pThorimLever->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_UNK1);
                    CheckKeepersState();
                    break;
                case BOSS_MIMIRON:
                    CheckKeepersState();
                    break;
                case BOSS_FREYA:
                    CheckKeepersState();
                    break;
                case BOSS_VEZAX:
                    if (state == DONE)
                    {
                        // Keeper's Images
                        if (Creature* pFreya = instance->GetCreature(uiFreyaImage))
                            pFreya->SetVisible(true);
                        if (Creature* pThorim = instance->GetCreature(uiThorimImage))
                            pThorim->SetVisible(true);
                        if (Creature* pMimiron = instance->GetCreature(uiMimironImage))
                            pMimiron->SetVisible(true);
                        if (Creature* pHodir = instance->GetCreature(uiHodirImage))
                            pHodir->SetVisible(true);
                    }
                    break;
                case BOSS_ALGALON:
                    switch (state)
                    {
                        case SPECIAL:
                            if (Creature* algalon = instance->GetCreature(uiAlgalonGUID))
                            {
                                algalon->setFaction(7);
                                algalon->setActive(true);
                                algalon->SetVisible(true);
                            }
                            HandleGameObject(uiAlgalonDoor1GUID, true);
                            HandleGameObject(uiAlgalonDoor2GUID, true);
                            uiAlgalonCountdown = 61;
                            SaveToDB();
                            break;
                        case NOT_STARTED:
                            HandleGameObject(uiAlgalonGlobeGUID, false);
                            HandleGameObject(uiAlgalonBridgeGUID, false);
                            HandleGameObject(uiAlgalonBridgeVisualGUID, false);
                            HandleGameObject(uiAlgalonBridgeDoorGUID, true);
                            break;
                        case IN_PROGRESS:
                            if (uiAlgalonCountdown > 60)
                            {
                                uiAlgalonCountdown = 60;
                                DoUpdateWorldState(WORLDSTATE_ALGALON_SHOW, 1);
                                DoUpdateWorldState(WORLDSTATE_ALGALON_TIME, uiAlgalonCountdown);
                                SaveToDB();
                            }
                            HandleGameObject(uiAlgalonGlobeGUID, true);
                            HandleGameObject(uiAlgalonBridgeGUID, true);
                            HandleGameObject(uiAlgalonBridgeVisualGUID, true);
                            HandleGameObject(uiAlgalonBridgeDoorGUID, false);
                            break;
                        case DONE:
                            uiAlgalonCountdown = 0;
                            DoUpdateWorldState(WORLDSTATE_ALGALON_SHOW, 0);
                            SaveToDB();
                            HandleGameObject(uiAlgalonGlobeGUID, false);
                            HandleGameObject(uiAlgalonBridgeGUID, false);
                            HandleGameObject(uiAlgalonBridgeVisualGUID, false);
                            HandleGameObject(uiAlgalonBridgeDoorGUID, true);
                            break;
                    }
                    break;
            }
            
            return true;
        }
        
        void CheckKeepersState()
        {
            if (GameObject* go = instance->GetGameObject(KeepersGateGUID))
            {
                InstanceScript *data = go->GetInstanceScript();
                go->RemoveFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
                if (data)
                    for (uint32 i = BOSS_MIMIRON; i < BOSS_VEZAX; ++i)
                        if (data->GetBossState(i) != DONE)
                            go->SetFlag(GAMEOBJECT_FLAGS,GO_FLAG_LOCKED);
            }
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "U U " << GetBossSaveData() << " " << uiAlgalonCountdown;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn)
        {
            if (!strIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(strIn);

            char dataHead1, dataHead2;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'U' && dataHead2 == 'U')
            {
                for (uint8 i = 0; i < MAX_BOSS_NUMBER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;

                    SetBossState(i, EncounterState(tmpState));
                }
                uint32 tmpState;
                loadStream >> tmpState;
                uiAlgalonCountdown = tmpState;
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        void Update(uint32 diff)
        {
            if (uiAlgalonCountdown > 0 && uiAlgalonCountdown < 61)
            {
                if (uiCountdownTimer < diff)
                {
                    uiAlgalonCountdown--;

                    if (uiAlgalonCountdown)
                    {
                        DoUpdateWorldState(WORLDSTATE_ALGALON_SHOW, 1);
                        DoUpdateWorldState(WORLDSTATE_ALGALON_TIME, uiAlgalonCountdown);
                    }
                    else
                    {
                        if (Creature* algalon = instance->GetCreature(uiAlgalonGUID))
                            algalon->AI()->DoAction(1);
                    }
                    SaveToDB();
                    uiCountdownTimer += 1*MINUTE*IN_MILLISECONDS;
                }
                uiCountdownTimer -= diff;
            }

            // Achievement Dwarfageddon control            
            if (dwarfageddonTimer)
            {
                if (steelforgedDefendersCount >= DWARFAGEDDON_MIN_COUNT)
                {
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_10MAN_NORMAL)
                        achievementDwarfageddon = ACHIEVEMENT_DWARFAGEDDON_10;
                    else if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_25MAN_NORMAL)
                        achievementDwarfageddon = ACHIEVEMENT_DWARFAGEDDON_25;

                    AchievementEntry const *AchievDwarfageddon = GetAchievementStore()->LookupEntry(achievementDwarfageddon);
                    if (AchievDwarfageddon)
                        DoCompleteAchievement(achievementDwarfageddon);

                    SetData(DATA_DWARFAGEDDON, ACHI_RESET);
                    return;
                }

                if (dwarfageddonTimer <= diff)
                    SetData(DATA_DWARFAGEDDON, ACHI_RESET);
                else dwarfageddonTimer -= diff;
            }

            // Achievement Lumberjacked control
            if (lumberjackedTimer)
            {
                if (eldersCount == ELDERS_NUMBER)
                {
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_10MAN_NORMAL)
                        achievementLumberjacked = ACHIEVEMENT_LUMBERJACKED_10;
                    else if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_25MAN_NORMAL)
                        achievementLumberjacked = ACHIEVEMENT_LUMBERJACKED_25;

                    AchievementEntry const *AchievLumberjacked = GetAchievementStore()->LookupEntry(achievementLumberjacked);
                    if (AchievLumberjacked)                        
                        DoCompleteAchievement(achievementLumberjacked);

                    SetData(DATA_LUMBERJACKED, ACHI_COMPLETED);
                    return;
                }

                if (lumberjackedTimer <= diff)
                    SetData(DATA_LUMBERJACKED, ACHI_FAILED);
                else lumberjackedTimer -= diff;
            }

            // Achievement Con-speed-atory Timer
            if (conspeedatoryTimer)
            {
                if (conspeedatoryTimer <= diff)
                    SetData(DATA_CONSPEEDATORY, ACHI_FAILED);
                else conspeedatoryTimer -= diff;
            }

            // Achievement They're Coming Out of the Walls control
            if (comingOutTimer)
            {
                if (guardiansCount >= COMING_OUT_MIN_COUNT)
                {
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_10MAN_NORMAL)
                        achievementComingOut = ACHI_COMING_OUT_OF_THE_WALLS_10;
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_25MAN_NORMAL)
                        achievementComingOut = ACHI_COMING_OUT_OF_THE_WALLS_25;

                    AchievementEntry const *AchievComingOut = GetAchievementStore()->LookupEntry(achievementComingOut);
                    if (AchievComingOut)
                        DoCompleteAchievement(achievementComingOut);

                    SetData(DATA_COMING_OUT, ACHI_RESET);
                    return;
                }

                if (comingOutTimer <= diff)
                    SetData(DATA_COMING_OUT, ACHI_RESET);
                else comingOutTimer -= diff;
            }
        }
    };
};

// Mimiron Tram
class go_call_tram : public GameObjectScript
{
    public:
    go_call_tram() : GameObjectScript("go_call_tram") {}
    
    bool OnGossipHello(Player* pPlayer, GameObject* go)
    {
        InstanceScript* pInstance = go->GetInstanceScript();

        if (!pInstance)
            return false;

        switch(go->GetEntry())
        {
            case 194914:
            case 194438:
                pInstance->SetData(DATA_CALL_TRAM, 0);
                break;
            case 194912:
            case 194437:
                pInstance->SetData(DATA_CALL_TRAM, 1);
                break;
        }
        return true;
    };
};

// Archivum Console
/*
enum ConsoleActions
{
    VALANYR,
    FREYA,
    HODIR,
    MIMIRON,
    THORIM,
};

enum ConsoleQuests
{
    QUEST_ANCIENT_HISTORY = 13622,
    QUEST_CELESTIAL_PLANETARIUM_10 = 13607,
    QUEST_CELESTIAL_PLANETARIUM_25 = 13816,
};

class go_archivum_console : public GameObjectScript
{
    public:
        go_archivum_console() : GameObjectScript("go_archivum_console") { }

    bool OnGossipHello(Player *pPlayer, GameObject *go)
    {
        InstanceScript* pInstance = go->GetInstanceScript();

        if (!pInstance)
            return false;

        if (pPlayer->GetQuestStatus(QUEST_ANCIENT_HISTORY) == QUEST_STATUS_COMPLETE)
            pPlayer->ADD_GOSSIP_ITEM(0, "Tell me about the Fragments", GOSSIP_SENDER_MAIN, VALANYR);

        if (pPlayer->GetQuestStatus(QUEST_CELESTIAL_PLANETARIUM_10) == QUEST_STATUS_COMPLETE || 
            pPlayer->GetQuestStatus(QUEST_CELESTIAL_PLANETARIUM_25) == QUEST_STATUS_COMPLETE)
        {
            pPlayer->ADD_GOSSIP_ITEM(0, "Tell me about Freya and her sigil", GOSSIP_SENDER_MAIN, FREYA);
            pPlayer->ADD_GOSSIP_ITEM(0, "Tell me about Hodir and his sigil", GOSSIP_SENDER_MAIN, HODIR);
            pPlayer->ADD_GOSSIP_ITEM(0, "Tell me about Mimiron and his sigil", GOSSIP_SENDER_MAIN, MIMIRON);
            pPlayer->ADD_GOSSIP_ITEM(0, "Tell me about Thorim and his sigil", GOSSIP_SENDER_MAIN, THORIM);
        }

        pPlayer->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, go->GetGUID());

        return true;
    };

    bool OnGossipSelect(Player *pPlayer, GameObject *go, uint32 sender, uint32 action)
    {
        if (sender != GOSSIP_SENDER_MAIN) 
            return true;

        switch(action)
        {
            case VALANYR:
            case FREYA:
            case HODIR:
            case MIMIRON:
            case THORIM:
                go->MonsterSay("Entry denied. Access level insufficient.", LANG_UNIVERSAL, 0);
                pPlayer->CLOSE_GOSSIP_MENU();
                //go->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                break;
        }

        return true;
    }
        
    void UpdateAI(const uint32 diff)
    {
        if (valanyrAnalysisPhase == 1)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("Fragment analysis underway.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 2000;
                valanyrAnalysisPhase = 2;
            }
            else valanyrAnalysisTimer -= diff;
        }
        else if (valanyrAnalysisPhase == 2)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("Object identified: Val'anyr, Hammer of Ancient Kings.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 6000;
                valanyrAnalysisPhase = 3;
            }
            else valanyrAnalysisTimer -= diff;
        }
        else if (valanyrAnalysisPhase == 3)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("Created by the titans themselves, Val'anyr was given to the first Earthen king, Urel Stoneheart. With the hammer he was to create and give life to the rest of his brethren.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 2500;
                valanyrAnalysisPhase = 4;
            }
            else valanyrAnalysisTimer -= diff;
        }
        else if (valanyrAnalysisPhase == 4)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("Val'anyr was shattered during the first war between the Earthen and the Iron Dwarves.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 2000;
                valanyrAnalysisPhase = 5;
            }
            else valanyrAnalysisTimer -= diff;
        }
        else if (valanyrAnalysisPhase == 5)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("The Weapon's remnants were believed lost in the conflict.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 2500;
                valanyrAnalysisPhase = 6;
            }
            else valanyrAnalysisTimer -= diff;
        }
        else if (valanyrAnalysisPhase == 6)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("Probability of successful repair by ordinary means available in this world is close to nil.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 2000;
                valanyrAnalysisPhase = 7;
            }
            else valanyrAnalysisTimer -= diff;
        }
        else if (valanyrAnalysisPhase == 7)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("Please hold while theoretical means are analyzed.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 6000;
                valanyrAnalysisPhase = 8;
            }
            else valanyrAnalysisTimer -= diff;
        }
        else if (valanyrAnalysisPhase == 8)
        {
            if (valanyrAnalysisTimer <= diff)
            {
                go->MonsterSay("Powerful acidic content theoretically found inside the being Yogg-Saron would count for the liquefaction of Saronite. Submersion in this substance might be sufficient to rebind an alloy of titan origin.", LANG_UNIVERSAL, 0);
                valanyrAnalysisTimer = 0;
                valanyrAnalysisPhase = 0;
                go->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }
            else valanyrAnalysisTimer -= diff;
        }
    }
};
*/

void AddSC_instance_ulduar()
{
    new instance_ulduar();
    new go_call_tram();
    //new go_archivum_console();
}
