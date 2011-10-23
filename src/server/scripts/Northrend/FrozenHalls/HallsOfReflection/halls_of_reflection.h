/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
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

#ifndef DEF_HALLS_OF_REFLECTION_H
#define DEF_HALLS_OF_REFLECTION_H

enum Data
{
    TYPE_PHASE              = 0,
    TYPE_EVENT              = 1,
    TYPE_FALRIC             = 2,
    TYPE_MARWYN             = 3,
    TYPE_FROST_GENERAL      = 4,
    TYPE_LICH_KING          = 5,
    TYPE_ICE_WALL_01        = 6,
    TYPE_ICE_WALL_02        = 7,
    TYPE_ICE_WALL_03        = 8,
    TYPE_ICE_WALL_04        = 9,
    TYPE_HALLS              = 10,
    MAX_ENCOUNTERS,

    DATA_ESCAPE_LIDER       = 101,
    DATA_LIDER              = 102,
    DATA_SUMMONS            = 103,
    DATA_TEAM_IN_INSTANCE   = 104,

    /*UNITS*/
    NPC_DARK_1                   = 38177, //Shadowy Mercenary
    NPC_DARK_2                   = 38176, //Tortured Rifleman
    NPC_DARK_3                   = 38173, //Spectral Footman
    NPC_DARK_4                   = 38172, //Phantom Mage
    NPC_DARK_5                   = 38567, //Phantom Hallucination
    NPC_DARK_6                   = 38175, //Ghostly Priest
    NPC_JAINA                    = 37221,
    NPC_SYLVANA                  = 37223,
    NPC_JAINA_OUTRO              = 36955,
    NPC_SYLVANA_OUTRO            = 37554,
    NPC_ALTAR_TARGET             = 37704,
    NPC_UTHER                    = 37225,
    NPC_LICH_KING                = 36954,
    BOSS_LICH_KING               = 37226,
    NPC_ICE_WALL                 = 37014,
    NPC_FALRIC                   = 38112,
    NPC_MARWYN                   = 38113,
    NPC_GHOSTLY_ROGUE            = 38177,
    NPC_GHOSTLY_PRIEST           = 38175,
    NPC_GHOSTLY_MAGE             = 38172,
    NPC_GHOSTLY_FOOTMAN          = 38173,
    NPC_GHOSTLY_RIFLEMAN         = 38176,
    NPC_GLUK                     = 38567,

    NPC_RAGING_GNOUL             = 36940,
    NPC_RISEN_WITCH_DOCTOR       = 36941,
    NPC_ABON                     = 37069,

    NPC_FROST_GENERAL            = 36723,
	NPC_WAVES_RESTORE			 = 60101,
	LK_KILL_CREDIT               = 72830, // Da Inserire

    GO_ICECROWN_DOOR             = 201976, //72802
    GO_ICECROWN_DOOR_2           = 197342,
    GO_ICECROWN_DOOR_3           = 197343,
    GO_IMPENETRABLE_DOOR         = 197341, //72801
    GO_FROSTMOURNE_ALTAR         = 202236, //3551
    GO_FROSTMOURNE               = 202302, //364

    GO_ICE_WALL_1                = 201385,
    GO_ICE_WALL_2                = 201885,
    GO_ICE_WALL_3                = 202396,
    GO_ICE_WALL_4                = 500001,
    GO_CAVE                      = 201596,
    GO_PORTAL                    = 202079,

    GO_CAPTAIN_CHEST_1           = 202212, //3145
    GO_CAPTAIN_CHEST_2           = 201710, //30357
    GO_CAPTAIN_CHEST_3           = 202337, //3246
    GO_CAPTAIN_CHEST_4           = 202336, //3333
};

struct Locations
{
    float x, y, z, o;
    uint32 id;
};

enum eEnum
{
    ENCOUNTER_WAVE_MERCENARY                      = 6,
    ENCOUNTER_WAVE_FOOTMAN                        = 10,
    ENCOUNTER_WAVE_RIFLEMAN                       = 6,
    ENCOUNTER_WAVE_PRIEST                         = 6,
    ENCOUNTER_WAVE_MAGE                           = 6,
};

static Position PriestSpawnPos[ENCOUNTER_WAVE_PRIEST] =
{
    {5277.74f,2016.88f,707.778f,5.96903f},
    {5295.88f,2040.34f,707.778f,5.07891f},
    {5320.37f,1980.13f,707.778f,2.00713f},
    {5280.51f,1997.84f,707.778f,0.296706f},
    {5302.45f,2042.22f,707.778f,4.90438f},
    {5306.57f,1977.47f,707.778f,1.50098f},
};

static Position MageSpawnPos[ENCOUNTER_WAVE_MAGE] =
{
    {5312.75f,2037.12f,707.778f,4.59022f},
    {5309.58f,2042.67f,707.778f,4.69494f},
    {5275.08f,2008.72f,707.778f,6.21337f},
    {5279.65f,2004.66f,707.778f,0.069813f},
    {5275.48f,2001.14f,707.778f,0.174533f},
    {5316.7f,2041.55f,707.778f,4.50295f},
};

static Position MercenarySpawnPos[ENCOUNTER_WAVE_MERCENARY] =
{
    {5302.25f,1972.41f,707.778f,1.37881f},
    {5311.03f,1972.23f,707.778f,1.64061f},
    {5277.36f,1993.23f,707.778f,0.401426f},
    {5318.7f,2036.11f,707.778f,4.2237f},
    {5335.72f,1996.86f,707.778f,2.74017f},
    {5299.43f,1979.01f,707.778f,1.23918f},
};

static Position FootmenSpawnPos[ENCOUNTER_WAVE_FOOTMAN] =
{
    {5306.06f,2037,707.778f,4.81711f},
    {5344.15f,2007.17f,707.778f,3.15905f},
    {5337.83f,2010.06f,707.778f,3.22886f},
    {5343.29f,1999.38f,707.778f,2.9147f},
    {5340.84f,1992.46f,707.778f,2.75762f},
    {5325.07f,1977.6f,707.778f,2.07694f},
    {5336.6f,2017.28f,707.778f,3.47321f},
    {5313.82f,1978.15f,707.778f,1.74533f},
    {5280.63f,2012.16f,707.778f,6.05629f},
    {5322.96f,2040.29f,707.778f,4.34587f},
};

static Position RiflemanSpawnPos[ENCOUNTER_WAVE_RIFLEMAN] =
{
    {5343.47f,2015.95f,707.778f,3.49066f},
    {5337.86f,2003.4f,707.778f,2.98451f},
    {5319.16f,1974,707.778f,1.91986f},
    {5299.25f,2036,707.778f,5.02655f},
    {5295.64f,1973.76f,707.778f,1.18682f},
    {5282.9f,2019.6f,707.778f,5.88176f},
};

enum HorWorldStates
{
    WORLD_STATE_HOR                               = 4884,
    WORLD_STATE_HOR_WAVE_COUNT                    = 4882,
};

enum data
{
       DATA_THE_HALLS_OF_REFLECTION = 1,
       DATA_H_THE_HALLS_OF_REFLECTION = 2,
};

#endif
