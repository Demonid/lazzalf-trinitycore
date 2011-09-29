/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: Instance_Blood_Furnace
SD%Complete: 85
SDComment:
SDCategory: Hellfire Citadel, Blood Furnace
EndScriptData */

#include "ScriptPCH.h"
#include "blood_furnace.h"

#define ENTRY_SEWER1                 181823
#define ENTRY_SEWER2                 181766
#define MAX_ENCOUNTER                   3

class instance_blood_furnace : public InstanceMapScript
{
    public:
        instance_blood_furnace()
            : InstanceMapScript("instance_blood_furnace", 542)
        {
        }

        struct instance_blood_furnace_InstanceMapScript : public InstanceScript
        {
            instance_blood_furnace_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {}

            uint64 The_MakerGUID;
            uint64 BroggokGUID;
            uint64 Kelidan_The_BreakerGUID;

            uint64 Door1GUID;
            uint64 Door2GUID;
            uint64 Door3GUID;
            uint64 Door4GUID;
            uint64 Door5GUID;
            uint64 Door6GUID;

            uint64 PrisonCell1GUID;
            uint64 PrisonCell2GUID;
            uint64 PrisonCell3GUID;
            uint64 PrisonCell4GUID;
            uint64 PrisonCell5GUID;
            uint64 PrisonCell6GUID;
            uint64 PrisonCell7GUID;
            uint64 PrisonCell8GUID;

            uint32 m_auiEncounter[MAX_ENCOUNTER];
            std::string str_data;

            void Initialize()
            {
                memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

                The_MakerGUID = 0;
                BroggokGUID = 0;
                Kelidan_The_BreakerGUID = 0;

                Door1GUID = 0;
                Door2GUID = 0;
                Door3GUID = 0;
                Door4GUID = 0;
                Door5GUID = 0;
                Door6GUID = 0;

                PrisonCell1GUID = 0;
                PrisonCell2GUID = 0;
                PrisonCell3GUID = 0;
                PrisonCell4GUID = 0;
                PrisonCell5GUID = 0;
                PrisonCell6GUID = 0;
                PrisonCell7GUID = 0;
                PrisonCell8GUID = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                     case 17381:
                         The_MakerGUID = creature->GetGUID();
                         break;
                     case 17380:
                         BroggokGUID = creature->GetGUID();
                         break;
                     case 17377:
                         Kelidan_The_BreakerGUID = creature->GetGUID();
                         break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                 if (go->GetEntry() == 181766)                //Final exit door
                     Door1GUID = go->GetGUID();
                 if (go->GetEntry() == 181811)               //The Maker Front door
                     Door2GUID = go->GetGUID();
                 if (go->GetEntry() == 181812)                //The Maker Rear door
                     Door3GUID = go->GetGUID();
                 if (go->GetEntry() == 181822)               //Broggok Front door
                     Door4GUID = go->GetGUID();
                 if (go->GetEntry() == 181819)               //Broggok Rear door
                     Door5GUID = go->GetGUID();
                 if (go->GetEntry() == 181823)               //Kelidan exit door
                     Door6GUID = go->GetGUID();

                 if (go->GetEntry() == 181813)               //The Maker prison cell front right
                     PrisonCell1GUID = go->GetGUID();
                 if (go->GetEntry() == 181814)               //The Maker prison cell back right
                     PrisonCell2GUID = go->GetGUID();
                 if (go->GetEntry() == 181816)               //The Maker prison cell front left
                     PrisonCell3GUID = go->GetGUID();
                 if (go->GetEntry() == 181815)               //The Maker prison cell back left
                     PrisonCell4GUID = go->GetGUID();
                 if (go->GetEntry() == 181821)               //Broggok prison cell front right
                     PrisonCell5GUID = go->GetGUID();
                 if (go->GetEntry() == 181818)               //Broggok prison cell back right
                     PrisonCell6GUID = go->GetGUID();
                 if (go->GetEntry() == 181820)               //Broggok prison cell front left
                     PrisonCell7GUID = go->GetGUID();
                 if (go->GetEntry() == 181817)               //Broggok prison cell back left
                     PrisonCell8GUID = go->GetGUID();
            }

            uint64 GetData64(uint32 data)
            {
                switch (data)
                {
                     case DATA_THE_MAKER:            return The_MakerGUID;
                     case DATA_BROGGOK:              return BroggokGUID;
                     case DATA_KELIDAN_THE_MAKER:    return Kelidan_The_BreakerGUID;
                     case DATA_DOOR1:                return Door1GUID;
                     case DATA_DOOR2:                return Door2GUID;
                     case DATA_DOOR3:                return Door3GUID;
                     case DATA_DOOR4:                return Door4GUID;
                     case DATA_DOOR5:                return Door5GUID;
                     case DATA_DOOR6:                return Door6GUID;
                     case DATA_PRISON_CELL1:         return PrisonCell1GUID;
                     case DATA_PRISON_CELL2:         return PrisonCell2GUID;
                     case DATA_PRISON_CELL3:         return PrisonCell3GUID;
                     case DATA_PRISON_CELL4:         return PrisonCell4GUID;
                     case DATA_PRISON_CELL5:         return PrisonCell5GUID;
                     case DATA_PRISON_CELL6:         return PrisonCell6GUID;
                     case DATA_PRISON_CELL7:         return PrisonCell7GUID;
                     case DATA_PRISON_CELL8:         return PrisonCell8GUID;
                }

                return 0;
            }

            void SetData(uint32 /*type*/, uint32 data)
            {
                 switch (data)
                 {
                     case TYPE_THE_MAKER_EVENT:             m_auiEncounter[0] = data;     break;
                     case TYPE_BROGGOK_EVENT:               m_auiEncounter[1] = data;     break;
                     case TYPE_KELIDAN_THE_BREAKER_EVENT:   m_auiEncounter[2] = data;     break;
                 }

                if (data == DONE)
                {
                    OUT_SAVE_INST_DATA;

                    std::ostringstream saveStream;
                    saveStream << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2];

                    str_data = saveStream.str();

                    SaveToDB();
                    OUT_SAVE_INST_DATA_COMPLETE;
                }
            }

            uint32 GetData(uint32 data)
            {
                switch (data)
                {
                    case TYPE_THE_MAKER_EVENT:             return m_auiEncounter[0];
                    case TYPE_BROGGOK_EVENT:               return m_auiEncounter[1];
                    case TYPE_KELIDAN_THE_BREAKER_EVENT:   return m_auiEncounter[2];
                }

                return 0;
            }

            const char* Save()
            {
                return str_data.c_str();
            }

            void Load(const char* in)
            {
                if (!in)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(in);

                std::istringstream loadStream(in);
                loadStream >> m_auiEncounter[0] >> m_auiEncounter[1] >> m_auiEncounter[2];

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS || m_auiEncounter[i] == FAIL)
                        m_auiEncounter[i] = NOT_STARTED;

                OUT_LOAD_INST_DATA_COMPLETE;
            }
        };

        InstanceScript* GetInstanceScript(InstanceMap* pMap) const
        {
            return new instance_blood_furnace_InstanceMapScript(pMap);
        }
};

void AddSC_instance_blood_furnace()
{
    new instance_blood_furnace();
}

