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

#ifndef DEF_ULDUAR_H
#define DEF_ULDUAR_H

#define ULDUAR_MAP 603

enum Encounter
{
    BOSS_LEVIATHAN,
    BOSS_IGNIS,
    BOSS_RAZORSCALE,
    BOSS_XT002,
    BOSS_ASSEMBLY,
    BOSS_KOLOGARN,
    BOSS_AURIAYA,
    BOSS_MIMIRON,
    BOSS_HODIR,
    BOSS_THORIM,
    BOSS_FREYA,
    BOSS_VEZAX,
    BOSS_YOGGSARON,
    BOSS_ALGALON,
    MAX_BOSS_NUMBER
};

enum Data
{
    DATA_LEVIATHAN,
    DATA_NPC_LEVIATHAN_LOOT,
    DATA_NORGANNON,
    DATA_IGNIS,
    DATA_RAZORSCALE,
    DATA_EXP_COMMANDER,
    DATA_XT002,
    DATA_STEELBREAKER,
    DATA_MOLGEIM,
    DATA_BRUNDIR,
    DATA_KOLOGARN,
    DATA_RIGHT_ARM,
    DATA_LEFT_ARM,
    DATA_AURIAYA,
    DATA_BRIGHTLEAF,
    DATA_IRONBRANCH,
    DATA_STONEBARK,
    DATA_FREYA,
    DATA_THORIM,
    DATA_RUNIC_COLOSSUS,
    DATA_RUNE_GIANT,
    DATA_MIMIRON,
    DATA_LEVIATHAN_MK_II,
    DATA_VX_001,
    DATA_AERIAL_UNIT,
    DATA_MAGNETIC_CORE,
    DATA_VEZAX,
    DATA_YS_FREYA,
    DATA_YS_THORIM,
    DATA_YS_MIMIRON,
    DATA_YS_HODIR,
    DATA_YOGGSARON_BRAIN,
    DATA_YOGGSARON,
    DATA_ALGALON,

    DATA_LEVIATHAN_DOOR,
    DATA_TOWER_DESTROYED,
    DATA_TOWER_OF_STORMS,
    DATA_TOWER_OF_LIFE,
    DATA_TOWER_OF_FLAMES,
    DATA_TOWER_OF_FROST,
    DATA_RUNIC_DOOR,
    DATA_STONE_DOOR,
    DATA_CALL_TRAM,
    DATA_MIMIRON_ELEVATOR,
    DATA_HODIR_CHEST,
    DATA_HODIR_RARE_CHEST,
    DATA_THORIM_CHEST,
    DATA_THORIM_RARE_CHEST,
    DATA_ACHI_UNBROKEN,
    DATA_DWARFAGEDDON,
    DATA_CANT_WHILE_STUNNED,
    DATA_LUMBERJACKED,
    DATA_CONSPEEDATORY,
    DATA_COMING_OUT,  
    DATA_CRITERIA_PROXIMITY_MINE,
    DATA_CRITERIA_BOMB_BOT,
    DATA_CRITERIA_ROCKET_STRIKE,
    DATA_ACTIVE_KEEPERS,
    DATA_FEED,
};

enum eNPCs
{
    NPC_LEVIATHAN               = 33113,
    NPC_LEVIATHAN_LOOT          = 60029,
    NPC_IGNIS                   = 33118,
    NPC_RAZORSCALE              = 33186,
    NPC_EXPEDITION_COMMANDER    = 33210,
    NPC_XT002                   = 33293,
    NPC_STEELBREAKER            = 32867,
    NPC_MOLGEIM                 = 32927,
    NPC_BRUNDIR                 = 32857,
    NPC_KOLOGARN                = 32930,
    NPC_KOLOGARN_BRIDGE         = 34297,
    NPC_FOCUSED_EYEBEAM         = 33632,
    NPC_FOCUSED_EYEBEAM_RIGHT   = 33802,
    NPC_RUBBLE                  = 33768,
    NPC_LEFT_ARM                = 32933,
    NPC_RIGHT_ARM               = 32934,
    NPC_AURIAYA                 = 33515,
    NPC_MIMIRON                 = 33350,
    NPC_HODIR                   = 32845,
    NPC_THORIM                  = 32865,
    NPC_FREYA                   = 32906,
    NPC_VEZAX                   = 33271,
    NPC_YOGGSARON               = 33288,
    NPC_ALGALON                 = 32871,
    //NPC_LEVIATHAN_MKII          = 33432,
    //NPC_VX_001                  = 33651,
    //NPC_AERIAL_COMMAND_UNIT     = 33670,
};

enum AchievementControl
{
    ACHI_IS_NOT_STARTED = 1,
    ACHI_START,
    ACHI_IS_IN_PROGRESS,
    ACHI_COMPLETED,
    ACHI_FAILED,
    ACHI_RESET,
    ACHI_INCREASE,
    CRITERIA_MEETED,
    CRITERIA_NOT_MEETED,
};

/*enum eTowerEvents
{
    EVENT_TOWER_OF_STORM_DESTROYED     = 21031,
    EVENT_TOWER_OF_FROST_DESTROYED     = 21032,
    EVENT_TOWER_OF_FLAMES_DESTROYED    = 21033,
    EVENT_TOWER_OF_LIFE_DESTROYED      = 21030
};*/

enum eTowerEvents
{
    TOWER_OF_STORM_DESTROYED = 1,
    TOWER_OF_LIFE_DESTROYED,
    TOWER_OF_FLAMES_DESTROYED,
    TOWER_OF_FROST_DESTROYED,    
};
#endif
