/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Instance_Gruuls_Lair
SD%Complete: 100
SDComment:
SDCategory: Gruul's Lair
EndScriptData */

#include "precompiled.h"
#include "def_gruuls_lair.h"

#define ENCOUNTERS 2

/* Gruuls Lair encounters:
1 - High King Maulgar event
2 - Gruul event
*/

struct TRINITY_DLL_DECL instance_gruuls_lair : public ScriptedInstance
{
    instance_gruuls_lair(Map *map) : ScriptedInstance(map) {Initialize();};

    bool Encounters[ENCOUNTERS];

    uint64 MaulgarEvent_Tank;
    uint64 KigglerTheCrazed;
    uint64 BlindeyeTheSeer;
    uint64 OlmTheSummoner;
    uint64 KroshFirehand;
       uint64 Maulgar;

       uint64 MaulgarDoor;
       uint64 GruulDoor;

    void Initialize()
    {
        MaulgarEvent_Tank = 0;
        KigglerTheCrazed = 0;
        BlindeyeTheSeer = 0;
        OlmTheSummoner = 0;
        KroshFirehand = 0;
               Maulgar = 0;

               MaulgarDoor = 0;
               GruulDoor = 0;


        for(uint8 i = 0; i < ENCOUNTERS; i++)
            Encounters[i] = false;
    }

    bool IsEncounterInProgress() const
    {
        for(uint8 i = 0; i < ENCOUNTERS; i++)
            if(Encounters[i]) return true;

        return false;
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch(creature_entry)
        {
            case 18835: KigglerTheCrazed = creature->GetGUID(); break;
            case 18836: BlindeyeTheSeer = creature->GetGUID(); break;
            case 18834: OlmTheSummoner = creature->GetGUID(); break;
            case 18832: KroshFirehand = creature->GetGUID(); break;
                       case 18831: Maulgar = creature->GetGUID();break;
        }
    }

       void OnObjectCreate(GameObject* go)
    {
               switch(go->GetEntry())
               {
               case 184468: MaulgarDoor = go->GetGUID();break;
               case 184662: GruulDoor = go->GetGUID();break;
               }
       }

    void SetData64(uint32 type, uint64 data)
    {
        if(type == DATA_MAULGAREVENT_TANK)
            MaulgarEvent_Tank = data;
    }

    uint64 GetData64(uint32 identifier)
    {
        switch(identifier)
        {
            case DATA_MAULGAREVENT_TANK: return MaulgarEvent_Tank;
            case DATA_KIGGLERTHECRAZED: return KigglerTheCrazed;
                       case DATA_BLINDEYETHESEER: return BlindeyeTheSeer;
            case DATA_OLMTHESUMMONER: return OlmTheSummoner;
            case DATA_KROSHFIREHAND: return KroshFirehand;
                       case DATA_MAULGARDOOR: return MaulgarDoor;
                       case DATA_GRUULDOOR: return GruulDoor;
                       case DATA_MAULGAR: return Maulgar;
        }
        return 0;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch(type)
        {
            case DATA_MAULGAREVENT:
                Encounters[0] = data; break;
            case DATA_GRUULEVENT:
                Encounters[1] = data; break;
        }

               if(data == DONE)
                       SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case DATA_MAULGAREVENT: return Encounters[0];
            case DATA_GRUULEVENT: return Encounters[1];
        }
        return 0;
    }


               const char* Save()
    {
        OUT_SAVE_INST_DATA;
        std::ostringstream stream;
        stream << Encounters[0] << " " << Encounters[1];
        char* out = new char[stream.str().length() + 1];
        strcpy(out, stream.str().c_str());
        if(out)
        {
            OUT_SAVE_INST_DATA_COMPLETE;
            return out;
        }

        return NULL;
    }

    void Load(const char* in)
    {
        if(!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);
        std::istringstream stream(in);
        stream >> Encounters[0] >> Encounters[1];
        for(uint8 i = 0; i < ENCOUNTERS; ++i)
            if(Encounters[i] == IN_PROGRESS)                // Do not load an encounter as "In Progress" - reset it instead.
                Encounters[i] = NOT_STARTED;
        OUT_LOAD_INST_DATA_COMPLETE;
    }
};
InstanceData* GetInstanceData_instance_gruuls_lair(Map* map)
{
    return new instance_gruuls_lair(map);
}

void AddSC_instance_gruuls_lair()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_gruuls_lair";
    newscript->GetInstanceData = &GetInstanceData_instance_gruuls_lair;
    newscript->RegisterSelf();
}
