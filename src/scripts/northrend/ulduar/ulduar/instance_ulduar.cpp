/*
 * Copyright (C) 2008 - 2009 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "ScriptedPch.h"
#include "ulduar.h"

const DoorData doorData[] =
{
    {194905,    BOSS_LEVIATHAN, DOOR_TYPE_ROOM,     0},
    {194630,    BOSS_LEVIATHAN, DOOR_TYPE_PASSAGE,  0},
    {194631,    BOSS_XT002,     DOOR_TYPE_ROOM,     0},
    {0,         0,              DOOR_TYPE_ROOM,     0}, // EOF
};

struct instance_ulduar : public InstanceData
{
    instance_ulduar(Map* pMap) : InstanceData(pMap)
    {
        SetBossNumber(MAX_BOSS_NUMBER);
        LoadDoorData(doorData);
    }

    uint64 uiLeviathan;
    uint64 uiLeviathan_Trigger;
    uint64 uiIgnis;
    uint64 uiXT002;

    void OnGameObjectCreate(GameObject* pGo, bool add)
    {
        AddDoor(pGo, add);
    }

    void OnCreatureCreate(Creature* pCreature, bool add)
    {
        switch(pCreature->GetEntry())
        {
            case 33113: uiLeviathan = pCreature->GetGUID(); return;
            case 33115: uiLeviathan_Trigger = pCreature->GetGUID(); return;
            case 33118: uiIgnis = pCreature->GetGUID(); return;
            case 33293: uiXT002 = pCreature->GetGUID(); return;
        }

        AddMinion(pCreature, add);
    }

    uint64 GetData64(uint32 id)
    {
        switch(id)
        {
        case DATA_LEVIATHAN:
            return uiLeviathan;
        case DATA_LEVIATHAN_TRIGGER:
            return uiLeviathan_Trigger;
        case DATA_IGNIS:
            return uiIgnis;
        case DATA_XT002:
            return uiXT002;
        }
        return 0;
    }

    bool SetBossState(uint32 id, EncounterState state)
    {
        if (!InstanceData::SetBossState(id, state))
            return false;

        return true;
    }
};

InstanceData* GetInstanceData_instance_ulduar(Map* pMap)
{
    return new instance_ulduar(pMap);
}

void AddSC_instance_ulduar()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_ulduar";
    newscript->GetInstanceData = &GetInstanceData_instance_ulduar;
    newscript->RegisterSelf();
}
/*enum Spells
{
    SPELL_DEVOURINGFLAME    = 64709
};

enum eGameObjects
{
    GO_Kologarn_CHEST_HERO  = 195047,
    GO_Kologarn_CHEST       = 195046,
    GO_Thorim_CHEST_HERO    = 194315,
    GO_Thorim_CHEST         = 194314,
    GO_Hodir_CHEST_HERO     = 194308,
    GO_Hodir_CHEST          = 194307,
    GO_Freya_CHEST_HERO     = 194325,
    GO_Freya_CHEST          = 194324,
    GO_XT002_DOOR           = 194631,
    GO_LEVIATHAN_DOOR       = 194905,
    GO_LEVIATHAN_GATE       = 194630,
    GO_HARPOON              = 194565
};

struct instance_ulduar : public ScriptedInstance
{
    instance_ulduar(Map* pMap) : ScriptedInstance(pMap), KologarnChest(NULL), ThorimChest(NULL), HodirChest(NULL), FreyaChest(NULL) { Initialize(); };

    uint32 m_auiEncounter[MAX_ENCOUNTER];
    uint32  flag;
    uint32  flag2;
    std::string m_strInstData;

    uint64 m_uiLeviathanGUID;
    uint64 m_uiIgnisGUID;
    uint64 m_uiRazorscaleGUID;
    uint64 m_uiXT002GUID;
    uint64 m_auiAssemblyGUIDs[3];
    uint64 m_uiKologarnGUID;
    uint64 m_uiAuriayaGUID;
    uint64 m_uiMimironGUID;
    uint64 m_uiHodirGUID;
    uint64 m_uiThorimGUID;
    uint64 m_uiFreyaGUID;
    uint64 m_uiVezaxGUID;
    uint64 m_uiYoggSaronGUID;
    uint64 m_uiAlgalonGUID;
	
    uint64 m_uiXT002Door;
    uint64 m_uiLeviathanGate;
    uint64 m_uiLeviathanDoor[7];
    uint64 m_uiCommanderGUID;
    uint64 m_uiHarpoon[2];
    uint64 mole_machine[3];

    GameObject* KologarnChest, *ThorimChest, *HodirChest, *FreyaChest;

    void Initialize()
    {
        m_uiLeviathanGUID       = 0;
        m_uiIgnisGUID           = 0;
        m_uiRazorscaleGUID      = 0;
        m_uiXT002GUID           = 0;
        m_uiKologarnGUID        = 0;
        m_uiAuriayaGUID         = 0;
        m_uiMimironGUID         = 0;
        m_uiHodirGUID           = 0;
        m_uiThorimGUID          = 0;
        m_uiFreyaGUID           = 0;
        m_uiVezaxGUID           = 0;
        m_uiYoggSaronGUID       = 0;
        m_uiAlgalonGUID         = 0;
        KologarnChest           = 0;
        ThorimChest             = 0;
        HodirChest              = 0;
        FreyaChest              = 0;

        m_uiXT002Door           = 0;
        m_uiLeviathanGate       = 0;
        flag                    = 0;
        flag2                   = 0;
        m_uiCommanderGUID       = 0;

        memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
        memset(&m_auiAssemblyGUIDs, 0, sizeof(m_auiAssemblyGUIDs));
    }

    bool IsEncounterInProgress() const
    {
        for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
        {
            if (m_auiEncounter[i] == IN_PROGRESS)
                return true;
        }

        return false;
    }

    void OnCreatureCreate(Creature* pCreature, bool add)
    {
        switch(pCreature->GetEntry())
        {
            case NPC_LEVIATHAN:
                m_uiLeviathanGUID = pCreature->GetGUID();
                break;
            case NPC_IGNIS:
                m_uiIgnisGUID = pCreature->GetGUID();
                break;
            case NPC_RAZORSCALE:
                m_uiRazorscaleGUID = pCreature->GetGUID();
                break;
            case NPC_XT002:
                m_uiXT002GUID = pCreature->GetGUID();
                break;

            // Assembly of Iron
            case NPC_STEELBREAKER:
                m_auiAssemblyGUIDs[0] = pCreature->GetGUID();
                break;
            case NPC_MOLGEIM:
                m_auiAssemblyGUIDs[1] = pCreature->GetGUID();
                break;
            case NPC_BRUNDIR:
                m_auiAssemblyGUIDs[2] = pCreature->GetGUID();
                break;

            case NPC_KOLOGARN:
                m_uiKologarnGUID = pCreature->GetGUID();
                break;
            case NPC_AURIAYA:
                m_uiAuriayaGUID = pCreature->GetGUID();
                break;
            case NPC_MIMIRON:
                m_uiMimironGUID = pCreature->GetGUID();
                break;
            case NPC_HODIR:
                m_uiHodirGUID = pCreature->GetGUID();
                break;
            case NPC_THORIM:
                m_uiThorimGUID = pCreature->GetGUID();
                break;
            case NPC_FREYA:
                m_uiFreyaGUID = pCreature->GetGUID();
                break;
            case NPC_VEZAX:
                m_uiVezaxGUID = pCreature->GetGUID();
                break;
            case NPC_YOGGSARON:
                m_uiYoggSaronGUID = pCreature->GetGUID();
                break;
            case NPC_ALGALON:
                m_uiAlgalonGUID = pCreature->GetGUID();
                break;
            case NPC_COMMANDER:
                m_uiCommanderGUID = pCreature->GetGUID();
                break;
        }

     }

    void OnGameObjectCreate(GameObject* pGo, bool add)
    {
        switch(pGo->GetEntry())
        {
            case GO_Kologarn_CHEST_HERO: KologarnChest = add ? pGo : NULL; break;
            case GO_Kologarn_CHEST: KologarnChest = add ? pGo : NULL; break;
            case GO_Thorim_CHEST_HERO: ThorimChest = add ? pGo : NULL; break;
            case GO_Thorim_CHEST: ThorimChest = add ? pGo : NULL; break;
            case GO_Hodir_CHEST_HERO: HodirChest = add ? pGo : NULL; break;
            case GO_Hodir_CHEST: HodirChest = add ? pGo : NULL; break;
            case GO_Freya_CHEST_HERO: FreyaChest = add ? pGo : NULL; break;
            case GO_Freya_CHEST: FreyaChest = add ? pGo : NULL; break;
            case 194631:
                m_uiXT002Door = pGo->GetGUID();
                HandleGameObject(NULL, true, pGo);
                break;
            case 194905:
                m_uiLeviathanDoor[flag] = pGo->GetGUID();
                HandleGameObject(NULL, true, pGo);
                flag++;
            if (flag == 7)
                flag =0;
                break;
            case 194630:
                m_uiLeviathanGate = pGo->GetGUID();
                HandleGameObject(NULL, false, pGo);
                break;
            case 186880:
                mole_machine[flag2] = pGo->GetGUID();
                HandleGameObject(NULL, false, pGo);
                flag2++;
                break;
        }
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case TYPE_LEVIATHAN:
                if (data == IN_PROGRESS)
                {
                    HandleGameObject(m_uiLeviathanGate,true);
                    //m_uiLeviathanGate -> DoCast(m_uiLeviathanGate, SEAFORIUM_BLAST);
                    HandleGameObject(m_uiLeviathanDoor[0],false);
                    HandleGameObject(m_uiLeviathanDoor[1],false);
                    HandleGameObject(m_uiLeviathanDoor[2],false);
                    HandleGameObject(m_uiLeviathanDoor[3],false);
                    HandleGameObject(m_uiLeviathanDoor[4],false);
                    HandleGameObject(m_uiLeviathanDoor[5],false);
                    HandleGameObject(m_uiLeviathanDoor[6],false);				  
                }
                else
                {
                    HandleGameObject(m_uiLeviathanDoor[0],true);
                    HandleGameObject(m_uiLeviathanDoor[1],true);
                    HandleGameObject(m_uiLeviathanDoor[2],true);
                    HandleGameObject(m_uiLeviathanDoor[3],true);
                    HandleGameObject(m_uiLeviathanDoor[4],true);
                    HandleGameObject(m_uiLeviathanDoor[5],true);
                    HandleGameObject(m_uiLeviathanDoor[6],true);
                }
            case TYPE_IGNIS:
            case TYPE_RAZORSCALE:
                if (data == IN_PROGRESS)
                {
                    HandleGameObject(mole_machine[0],true);
                    HandleGameObject(mole_machine[1],true);
                    HandleGameObject(mole_machine[2],true);
                }
                else
                {
                    HandleGameObject(mole_machine[0],false);
                    HandleGameObject(mole_machine[1],false);
                    HandleGameObject(mole_machine[2],false);
                }
            case TYPE_XT002:
                if (data == IN_PROGRESS) 
                    HandleGameObject(m_uiXT002Door,false);
                else 
                    HandleGameObject(m_uiXT002Door,true);
            case TYPE_ASSEMBLY:
            case TYPE_KOLOGARN:
                m_auiEncounter[TYPE_KOLOGARN] = data;
                if (data == DONE && KologarnChest)
                KologarnChest->SetRespawnTime(KologarnChest->GetRespawnDelay());
            case TYPE_AURIAYA:
            case TYPE_MIMIRON:
            case TYPE_HODIR:
                m_auiEncounter[TYPE_HODIR] = data;
                if (data == DONE && HodirChest)
                HodirChest->SetRespawnTime(HodirChest->GetRespawnDelay());
            case TYPE_THORIM:
                m_auiEncounter[TYPE_THORIM] = data;
                if (data == DONE && ThorimChest)
                ThorimChest->SetRespawnTime(ThorimChest->GetRespawnDelay());
            case TYPE_FREYA:
                m_auiEncounter[TYPE_FREYA] = data;
                if (data == DONE && FreyaChest)
                FreyaChest->SetRespawnTime(FreyaChest->GetRespawnDelay());
            case TYPE_VEZAX:
            case TYPE_YOGGSARON:
            case TYPE_ALGALON:
                m_auiEncounter[type] = data;
                break;
        }

        if (data == DONE)
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;

            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                saveStream << m_auiEncounter[i] << " ";

            m_strInstData = saveStream.str();

            SaveToDB();
            OUT_SAVE_INST_DATA_COMPLETE;
        }
    }

    uint64 GetData64(uint32 data)
    {
        switch(data)
        {
            case TYPE_LEVIATHAN:
                return m_uiLeviathanGUID;
            case TYPE_IGNIS:
                return m_uiIgnisGUID;
            case TYPE_RAZORSCALE:
                return m_uiRazorscaleGUID;
            case TYPE_XT002:
                return m_uiXT002GUID;
            case TYPE_KOLOGARN:
                return m_uiKologarnGUID;
            case TYPE_AURIAYA:
                return m_uiAuriayaGUID;
            case TYPE_MIMIRON:
                return m_uiMimironGUID;
            case TYPE_HODIR:
                return m_uiMimironGUID;
            case TYPE_THORIM:
                return m_uiThorimGUID;
            case TYPE_FREYA:
                return m_uiFreyaGUID;
            case TYPE_VEZAX:
                return m_uiVezaxGUID;
            case TYPE_YOGGSARON:
                return m_uiYoggSaronGUID;
            case TYPE_ALGALON:
                return m_uiAlgalonGUID;

            // Assembly of Iron
            case DATA_STEELBREAKER:
                return m_auiAssemblyGUIDs[0];
            case DATA_MOLGEIM:
                return m_auiAssemblyGUIDs[1];
            case DATA_BRUNDIR:
                return m_auiAssemblyGUIDs[2];
        }

        return 0;
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case TYPE_LEVIATHAN:
            case TYPE_IGNIS:
            case TYPE_RAZORSCALE:
            case TYPE_XT002:
            case TYPE_ASSEMBLY:
            case TYPE_KOLOGARN:
            case TYPE_AURIAYA:
            case TYPE_MIMIRON:
            case TYPE_HODIR:
            case TYPE_THORIM:
            case TYPE_FREYA:
            case TYPE_VEZAX:
            case TYPE_YOGGSARON:
            case TYPE_ALGALON:
                return m_auiEncounter[type];
        }

        return 0;
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream saveStream;
        saveStream << "U U " << m_auiEncounter[0] << " " << m_auiEncounter[1] << " " << m_auiEncounter[2] << " " << m_auiEncounter[3]
                   << m_auiEncounter[4] << " " << m_auiEncounter[5] << " " << m_auiEncounter[6] << " " << m_auiEncounter[7]
                   << m_auiEncounter[8] << " " << m_auiEncounter[9] << " " << m_auiEncounter[10] << " " << m_auiEncounter[11]
                   << m_auiEncounter[12] << " " << m_auiEncounter[13];

        m_strInstData = saveStream.str();

        OUT_SAVE_INST_DATA_COMPLETE;
        return m_strInstData;
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
        uint32 data0, data1, data2, data3, data4, data5, data6,
            data7, data8, data9, data10, data11, data12, data13;

        std::istringstream loadStream(strIn);
        loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3 >> data4 >> data5 >> data6
            >> data7 >> data8 >> data9 >> data10 >> data11 >> data12 >> data13;

        if (dataHead1 == 'U' && dataHead2 == 'U')
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                loadStream >> m_auiEncounter[i];

                if (m_auiEncounter[i] == IN_PROGRESS)
                    m_auiEncounter[i] = NOT_STARTED;
            }
        }
        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_ulduar(Map* pMap)
{
    return new instance_ulduar(pMap);
}

struct devouring_flame : public ScriptedAI
{
    devouring_flame(Creature *pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceData();
    }
    ScriptedInstance* pInstance;
	
    uint32 DevouringFlameTimer;
	
    void EnterCombat(Unit* who)
    {
        m_creature->CastSpell(m_creature,SPELL_DEVOURINGFLAME,true);
    }
	
    void Reset()
    {
        DevouringFlameTimer = 25000;
    }
	
    void UpdateAI(const uint32 diff)
    {
        if (DevouringFlameTimer <= diff)
        {
            m_creature->setDeathState(JUST_DIED);
        }else DevouringFlameTimer -= diff;
    }
};

CreatureAI* GetAI_devouring_flame(Creature* pCreature)
{
    return new devouring_flame(pCreature);
}

void AddSC_instance_ulduar()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_ulduar";
    newscript->GetInstanceData = &GetInstanceData_instance_ulduar;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "devouring_flame";
    newscript->GetAI = &GetAI_devouring_flame;
    newscript->RegisterSelf();
}*/
