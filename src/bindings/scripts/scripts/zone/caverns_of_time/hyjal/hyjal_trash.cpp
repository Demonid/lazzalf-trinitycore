
#include "precompiled.h"
#include "def_hyjal.h"
#include "hyjal_trash.h"
#include "hyjalAI.h"

#define SPELL_METEOR 33814 //infernal visual
#define SPELL_IMMOLATION 37059
#define SPELL_FLAME_BUFFET 31724
#define NPC_TRIGGER  21987 //World Trigger (Tiny)
#define MODEL_INVIS  11686 //invisible model

float HordeWPs[8][3]=//basic waypoints from spawn to leader
{
    {5492.91,    -2404.61,    1462.63},
    {5531.76,    -2460.87,    1469.55},
    {5554.58,    -2514.66,    1476.12},
    {5554.16,    -2567.23,    1479.90},
    {5540.67,    -2625.99,    1480.89},
    {5508.16,    -2659.20,    1480.15},//random rush starts from here
    {5489.62,    -2704.05,    1482.18},
    {5457.04,    -2726.26,    1485.10}
};
float AllianceWPs[8][3]=//basic waypoints from spawn to leader
{
    {4896.08,    -1576.35,    1333.65},
    {4898.68,    -1615.02,    1329.48},
    {4907.12,    -1667.08,    1321.00},
    {4963.18,    -1699.35,    1340.51},
    {4989.16,    -1716.67,    1335.74},//first WP in the base, after the gate
    {5026.27,    -1736.89,    1323.02},
    {5037.77,    -1770.56,    1324.36},
    {5067.23,    -1789.95,    1321.17}    
};

float FrostWyrmWPs[3][3]=//waypoints for the frost wyrms in horde base
{
    {5580.82,    -2628.83,    1528.28},
    {5550.90,    -2667.16,    1505.45},
    {5459.64,    -2725.91,    1484.83}    
};

float GargoyleWPs[3][3]=//waypoints for the gargoyles in horde base
{    
    {5533.66,    -2634.32,    1495.33},
    {5517.88,    -2712.05,    1490.54},    
    {5459.64,    -2725.91,    1484.83}    
};

float FlyPathWPs[3][3]=//waypoints for the gargoyls and frost wyrms in horde base in wave 1/3
{
    {5531.96, -2772.83, 1516.68},
    {5498.32, -2734.84, 1497.01},
    {5456.67, -2725.48, 1493.08}
};

float AllianceOverrunWP[55][3]=//waypoints in the alliance base used in the end in the cleaning wave
{
    {4976.37,-1708.02,1339.43},//0spawn
    {4994.83,-1725.52,1333.25},//1 start
    {4982.92,-1753.7,1330.69},//2 end
    {4996.75,-1721.47,1332.95},//3 start
    {5015.74,-1755.05,1322.49},//4
    {4998.68,-1773.44,1329.59},//5
    {4994.83,-1725.52,1333.25},//6 start
    {5022.8,-1735.46,1323.53},//7
    {5052.15,-1729.02,1320.88},//8
    {5082.43,-1726.29,1327.87},//9
    {4994.83,-1725.52,1333.25},//10 start
    {5018.92,-1751.14,1322.19},//11
    {5040.09,-1792.09,1322.1},//12
    {4994.83,-1725.52,1333.25},//13 start
    {5023.47,-1748.1,1322.51},//14
    {5013.43,-1842.39,1322.07},//15
    {4994.83,-1725.52,1333.25},//16 start
    {5020.8,-1756.86,1322.2},//17
    {5019.53,-1824.6,1321.96},//18
    {5043.42,-1853.75,1324.52},//19
    {5053.02,-1864.13,1330.36},//20
    {5062.49,-1852.47,1330.49},//21
    {5049.32, -1726.31, 1320.64},//22 start
    {5065.81, -1729.43, 1325.66},//23
    {5096.63, -1742.22, 1329.61},//24
    {5138.97, -1755.88, 1334.57},//25
    {5163.27, -1789.08, 1337.04},//26
    {5127.90, -1825.14, 1335.58},//27
    {5089.68, -1846.88, 1328.99},//28
    {5049.32, -1886.54, 1331.69},//29
    {5002.33, -1893.98, 1325.88},//30
    {4981.51, -1883.7, 1322.34},//31
    {4983.25, -1857.4, 1320.48},//32
    {5015.94, -1821.24, 1321.86},//33
    {5027.97, -1775.25, 1321.87},//34
    {5015.27, -1738.77, 1324.83},//35
    {5081.07, -1902.10, 1346.36},//36 abo start
    {5107.65, -1912.03, 1356.49},//37
    {5132.83, -1927.07, 1362.42},//38
    {5147.78, -1954.41, 1365.98},//39
    {5164.96, -1966.48, 1367.04},//40
    {5189.04, -1961.06, 1367.90},//41
    {5212.27, -1975.30, 1365.58},//42
    {5221.82, -1994.18, 1364.97},//43 end1
    {5202.23, -1994.94, 1367.59},//44 end2
    {5279.94, -2049.68, 1311.38},//45 garg1
    {5289.15, -2219.06, 1291.12},//46 garg2
    {5202.07, -2136.10, 1305.07},//47 garg3
    {5071.52, -2425.63, 1454.48},//48 garg4
    {5120.65, -2467.92, 1463.93},//49 garg5
    {5283.04, -2043.26, 1300.11},//50 garg target1
    {5313.22, -2207.60, 1290.06},//51 garg target2
    {5180.41, -2121.87, 1292.62},//52 garg target3
    {5088.68, -2432.04, 1441.73},//53 garg target4
    {5111.26, -2454.73, 1449.63}//54 garg target5

};

float HordeOverrunWP[21][3]=//waypoints in the horde base used in the end in the cleaning wave
{    
    {5490.72,-2702.94,1482.14},//0 start
    {5469.77,-2741.34,1486.95},
    {5439.47,-2771.02,1494.59},
    {5408.85,-2811.92,1505.68},
    {5423.87,-2857.80,1515.55},
    {5428.19,-2898.15,1524.61},
    {5394.59,-2930.05,1528.23},
    {5351.11,-2935.80,1532.24},
    {5312.37,-2959.06,1536.21},
    {5264.93,-2989.80,1545.70},
    {5256.63,-3056.16,1559.24},
    {5267.32,-3119.55,1575.36},
    {5305.61,-3139.88,1586.38},
    {5330.56,-3135.37,1588.58},
    {5365.87,-3139.78,1583.96},
    {5389.39,-3163.57,1582.57},//15 end
    {5500.86,-2669.89,1481.04},//16 start
    {5472.08,-2715.14,1483.55},
    {5450.11,-2721.47,1485.61},
    {5433.25,-2712.93,1493.02},//19 end 1
    {5429.91,-2718.44,1493.42}//20 end 2
};

void hyjal_trashAI::Reset(){}

hyjal_trashAI::hyjal_trashAI(Creature *c) : npc_escortAI(c)
{
    pInstance = ((ScriptedInstance*)c->GetInstanceData());
    IsEvent = false;
    Delay = 0;
    LastOverronPos = 0;
    IsOverrun = false;
    OverrunType = 0;
    SetupOverrun = false;
    faction = 0;
    useFlyPath = false;
    damageTaken = 0;
    Reset();
}

void hyjal_trashAI::DamageTaken(Unit *done_by, uint32 &damage)
{
    if(done_by->GetTypeId() == TYPEID_PLAYER || (done_by->GetTypeId() == TYPEID_UNIT && ((Creature*)done_by)->isPet()))
    {
        damageTaken += damage;
        if(pInstance)
            pInstance->SetData(DATA_RAIDDAMAGE,damage);//store raid's damage    
    }
}

void hyjal_trashAI::Aggro(Unit *who){}

void hyjal_trashAI::UpdateAI(const uint32 diff)
{
    if(IsOverrun && !SetupOverrun)
    {
        SetupOverrun = true;
        if(faction == 0)
        {     
            if(m_creature->GetEntry() == GARGOYLE)
            {
                switch(OverrunType)
                {
                    case 0:
                        {
                            DummyTarget[0] = AllianceOverrunWP[50][0];
                            DummyTarget[1] = AllianceOverrunWP[50][1];
                            DummyTarget[2] = AllianceOverrunWP[50][2];
                        }
                        break;
                    case 1:
                        {
                            DummyTarget[0] = AllianceOverrunWP[51][0];
                            DummyTarget[1] = AllianceOverrunWP[51][1];
                            DummyTarget[2] = AllianceOverrunWP[51][2];
                        }
                        break;
                    case 2:
                        {
                            DummyTarget[0] = AllianceOverrunWP[52][0];
                            DummyTarget[1] = AllianceOverrunWP[52][1];
                            DummyTarget[2] = AllianceOverrunWP[52][2];
                        }
                        break;
                    case 3:
                        {
                            DummyTarget[0] = AllianceOverrunWP[53][0];
                            DummyTarget[1] = AllianceOverrunWP[53][1];
                            DummyTarget[2] = AllianceOverrunWP[53][2];
                        }
                        break;
                    case 4:
                        {
                            DummyTarget[0] = AllianceOverrunWP[54][0];
                            DummyTarget[1] = AllianceOverrunWP[54][1];
                            DummyTarget[2] = AllianceOverrunWP[54][2];
                        }
                        break;
                }
                
            }
            if(m_creature->GetEntry() == ABOMINATION)
            {
                for(uint8 i = 0; i < 4; i++)
                    AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3), AllianceWPs[i][1]+irand(-3,3), AllianceWPs[i][2]);
                switch(OverrunType)
                {
                    case 0:
                        AddWaypoint( 4, AllianceOverrunWP[35][0]+irand(-3,3), AllianceOverrunWP[35][1]+irand(-3,3), AllianceOverrunWP[35][2]);
                        AddWaypoint( 5, AllianceOverrunWP[34][0]+irand(-3,3), AllianceOverrunWP[34][1]+irand(-3,3), AllianceOverrunWP[34][2]);
                        AddWaypoint( 6, AllianceOverrunWP[33][0]+irand(-3,3), AllianceOverrunWP[33][1]+irand(-3,3), AllianceOverrunWP[33][2]);
                        AddWaypoint( 7, AllianceOverrunWP[32][0]+irand(-3,3), AllianceOverrunWP[32][1]+irand(-3,3), AllianceOverrunWP[32][2]);
                        AddWaypoint( 8, AllianceOverrunWP[31][0]+irand(-3,3), AllianceOverrunWP[31][1]+irand(-3,3), AllianceOverrunWP[31][2]);
                        AddWaypoint( 9, AllianceOverrunWP[30][0]+irand(-3,3), AllianceOverrunWP[30][1]+irand(-3,3), AllianceOverrunWP[30][2]);
                        AddWaypoint(10, AllianceOverrunWP[29][0]+irand(-3,3), AllianceOverrunWP[29][1]+irand(-3,3), AllianceOverrunWP[29][2]);
                        AddWaypoint(11, AllianceOverrunWP[36][0]+irand(-3,3), AllianceOverrunWP[36][1]+irand(-3,3), AllianceOverrunWP[36][2]);
                        AddWaypoint(12, AllianceOverrunWP[37][0]+irand(-3,3), AllianceOverrunWP[37][1]+irand(-3,3), AllianceOverrunWP[37][2]);
                        AddWaypoint(13, AllianceOverrunWP[38][0]+irand(-3,3), AllianceOverrunWP[38][1]+irand(-3,3), AllianceOverrunWP[38][2]);
                        AddWaypoint(14, AllianceOverrunWP[39][0]+irand(-3,3), AllianceOverrunWP[39][1]+irand(-3,3), AllianceOverrunWP[39][2]);
                        AddWaypoint(15, AllianceOverrunWP[40][0]+irand(-3,3), AllianceOverrunWP[40][1]+irand(-3,3), AllianceOverrunWP[40][2]);
                        AddWaypoint(16, AllianceOverrunWP[41][0]+irand(-3,3), AllianceOverrunWP[41][1]+irand(-3,3), AllianceOverrunWP[41][2]);
                        AddWaypoint(17, AllianceOverrunWP[42][0]+irand(-3,3), AllianceOverrunWP[42][1]+irand(-3,3), AllianceOverrunWP[42][2]);
                        AddWaypoint(18, AllianceOverrunWP[43][0]+irand(-3,3), AllianceOverrunWP[43][1]+irand(-3,3), AllianceOverrunWP[43][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[43][0]+irand(-3,3), AllianceOverrunWP[43][1]+irand(-3,3), AllianceOverrunWP[43][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 18;
                        Start(true, true, true);
                        break;
                     case 1:
                        AddWaypoint( 4, AllianceOverrunWP[35][0]+irand(-3,3), AllianceOverrunWP[35][1]+irand(-3,3), AllianceOverrunWP[35][2]);
                        AddWaypoint( 5, AllianceOverrunWP[34][0]+irand(-3,3), AllianceOverrunWP[34][1]+irand(-3,3), AllianceOverrunWP[34][2]);
                        AddWaypoint( 6, AllianceOverrunWP[33][0]+irand(-3,3), AllianceOverrunWP[33][1]+irand(-3,3), AllianceOverrunWP[33][2]);
                        AddWaypoint( 7, AllianceOverrunWP[32][0]+irand(-3,3), AllianceOverrunWP[32][1]+irand(-3,3), AllianceOverrunWP[32][2]);
                        AddWaypoint( 8, AllianceOverrunWP[31][0]+irand(-3,3), AllianceOverrunWP[31][1]+irand(-3,3), AllianceOverrunWP[31][2]);
                        AddWaypoint( 9, AllianceOverrunWP[30][0]+irand(-3,3), AllianceOverrunWP[30][1]+irand(-3,3), AllianceOverrunWP[30][2]);
                        AddWaypoint(10, AllianceOverrunWP[29][0]+irand(-3,3), AllianceOverrunWP[29][1]+irand(-3,3), AllianceOverrunWP[29][2]);
                        AddWaypoint(11, AllianceOverrunWP[36][0]+irand(-3,3), AllianceOverrunWP[36][1]+irand(-3,3), AllianceOverrunWP[36][2]);
                        AddWaypoint(12, AllianceOverrunWP[37][0]+irand(-3,3), AllianceOverrunWP[37][1]+irand(-3,3), AllianceOverrunWP[37][2]);
                        AddWaypoint(13, AllianceOverrunWP[38][0]+irand(-3,3), AllianceOverrunWP[38][1]+irand(-3,3), AllianceOverrunWP[38][2]);
                        AddWaypoint(14, AllianceOverrunWP[39][0]+irand(-3,3), AllianceOverrunWP[39][1]+irand(-3,3), AllianceOverrunWP[39][2]);
                        AddWaypoint(15, AllianceOverrunWP[40][0]+irand(-3,3), AllianceOverrunWP[40][1]+irand(-3,3), AllianceOverrunWP[40][2]);
                        AddWaypoint(16, AllianceOverrunWP[41][0]+irand(-3,3), AllianceOverrunWP[41][1]+irand(-3,3), AllianceOverrunWP[41][2]);
                        AddWaypoint(17, AllianceOverrunWP[42][0]+irand(-3,3), AllianceOverrunWP[42][1]+irand(-3,3), AllianceOverrunWP[42][2]);
                        AddWaypoint(18, AllianceOverrunWP[44][0]+irand(-3,3), AllianceOverrunWP[44][1]+irand(-3,3), AllianceOverrunWP[44][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[44][0]+irand(-3,3), AllianceOverrunWP[44][1]+irand(-3,3), AllianceOverrunWP[44][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 18;
                        Start(true, true, true);
                        break;
                    default:
                        AddWaypoint( 4, AllianceOverrunWP[35][0]+irand(-3,3), AllianceOverrunWP[35][1]+irand(-3,3), AllianceOverrunWP[35][2]);
                        AddWaypoint( 5, AllianceOverrunWP[34][0]+irand(-3,3), AllianceOverrunWP[34][1]+irand(-3,3), AllianceOverrunWP[34][2]);
                        AddWaypoint( 6, AllianceOverrunWP[33][0]+irand(-3,3), AllianceOverrunWP[33][1]+irand(-3,3), AllianceOverrunWP[33][2]);
                        AddWaypoint( 7, AllianceOverrunWP[32][0]+irand(-3,3), AllianceOverrunWP[32][1]+irand(-3,3), AllianceOverrunWP[32][2]);
                        AddWaypoint( 8, AllianceOverrunWP[31][0]+irand(-3,3), AllianceOverrunWP[31][1]+irand(-3,3), AllianceOverrunWP[31][2]);
                        AddWaypoint( 9, AllianceOverrunWP[30][0]+irand(-3,3), AllianceOverrunWP[30][1]+irand(-3,3), AllianceOverrunWP[30][2]);
                        AddWaypoint(10, AllianceOverrunWP[29][0]+irand(-3,3), AllianceOverrunWP[29][1]+irand(-3,3), AllianceOverrunWP[29][2]);
                        AddWaypoint(11, AllianceOverrunWP[28][0]+irand(-3,3), AllianceOverrunWP[28][1]+irand(-3,3), AllianceOverrunWP[28][2]);
                        AddWaypoint(12, AllianceOverrunWP[27][0]+irand(-3,3), AllianceOverrunWP[27][1]+irand(-3,3), AllianceOverrunWP[27][2]);
                        AddWaypoint(13, AllianceOverrunWP[26][0]+irand(-3,3), AllianceOverrunWP[26][1]+irand(-3,3), AllianceOverrunWP[26][2]);
                        AddWaypoint(14, AllianceOverrunWP[25][0]+irand(-3,3), AllianceOverrunWP[25][1]+irand(-3,3), AllianceOverrunWP[25][2]);
                        AddWaypoint(15, AllianceOverrunWP[24][0]+irand(-3,3), AllianceOverrunWP[24][1]+irand(-3,3), AllianceOverrunWP[24][2]);
                        AddWaypoint(16, AllianceOverrunWP[23][0]+irand(-3,3), AllianceOverrunWP[23][1]+irand(-3,3), AllianceOverrunWP[23][2]);
                        AddWaypoint(17, AllianceOverrunWP[22][0]+irand(-3,3), AllianceOverrunWP[22][1]+irand(-3,3), AllianceOverrunWP[22][2]);
                        //m_creature->SetHomePosition(AllianceOverrunWP[0][0]+irand(-3,3), AllianceOverrunWP[0][1]+irand(-3,3), AllianceOverrunWP[0][2],0);
                        SetDespawnAtEnd(true);
                        LastOverronPos = 17;
                        Start(true, true, true);
                        break;
                }
            }
            if(m_creature->GetEntry() == GHOUL)
            {
                for(uint8 i = 0; i < 4; i++)
                    AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3), AllianceWPs[i][1]+irand(-3,3), AllianceWPs[i][2]);
                switch(OverrunType)
                {
                    case 0:
                        AddWaypoint(4, AllianceOverrunWP[1][0]+irand(-3,3), AllianceOverrunWP[1][1]+irand(-3,3), AllianceOverrunWP[1][2]);
                        AddWaypoint(5, AllianceOverrunWP[2][0]+irand(-3,3), AllianceOverrunWP[2][1]+irand(-3,3), AllianceOverrunWP[2][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[2][0]+irand(-3,3), AllianceOverrunWP[2][1]+irand(-3,3), AllianceOverrunWP[2][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 5;
                        Start(true, true, true);
                        break;
                    case 1:
                        AddWaypoint(4, AllianceOverrunWP[3][0]+irand(-3,3), AllianceOverrunWP[3][1]+irand(-3,3), AllianceOverrunWP[3][2]);
                        AddWaypoint(5, AllianceOverrunWP[4][0]+irand(-3,3), AllianceOverrunWP[4][1]+irand(-3,3), AllianceOverrunWP[4][2]);
                        AddWaypoint(6, AllianceOverrunWP[5][0]+irand(-3,3), AllianceOverrunWP[5][1]+irand(-3,3), AllianceOverrunWP[5][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[5][0]+irand(-3,3), AllianceOverrunWP[5][1]+irand(-3,3), AllianceOverrunWP[5][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 6;
                        Start(true, true, true);
                        break;
                    case 2:
                        AddWaypoint(4, AllianceOverrunWP[6][0]+irand(-3,3), AllianceOverrunWP[6][1]+irand(-3,3), AllianceOverrunWP[6][2]);
                        AddWaypoint(5, AllianceOverrunWP[7][0]+irand(-3,3), AllianceOverrunWP[7][1]+irand(-3,3), AllianceOverrunWP[7][2]);
                        AddWaypoint(6, AllianceOverrunWP[8][0]+irand(-3,3), AllianceOverrunWP[8][1]+irand(-3,3), AllianceOverrunWP[8][2]);
                        AddWaypoint(7, AllianceOverrunWP[9][0]+irand(-3,3), AllianceOverrunWP[9][1]+irand(-3,3), AllianceOverrunWP[9][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[9][0]+irand(-3,3), AllianceOverrunWP[9][1]+irand(-3,3), AllianceOverrunWP[9][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 7;
                        Start(true, true, true);
                        break;
                    case 3:
                        AddWaypoint(4, AllianceOverrunWP[10][0]+irand(-3,3), AllianceOverrunWP[10][1]+irand(-3,3), AllianceOverrunWP[10][2]);
                        AddWaypoint(5, AllianceOverrunWP[11][0]+irand(-3,3), AllianceOverrunWP[11][1]+irand(-3,3), AllianceOverrunWP[11][2]);
                        AddWaypoint(6, AllianceOverrunWP[12][0]+irand(-3,3), AllianceOverrunWP[12][1]+irand(-3,3), AllianceOverrunWP[12][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[12][0]+irand(-3,3), AllianceOverrunWP[12][1]+irand(-3,3), AllianceOverrunWP[12][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 6;
                        Start(true, true, true);
                        break;
                    case 4:
                        AddWaypoint(4, AllianceOverrunWP[13][0]+irand(-3,3), AllianceOverrunWP[13][1]+irand(-3,3), AllianceOverrunWP[13][2]);
                        AddWaypoint(5, AllianceOverrunWP[14][0]+irand(-3,3), AllianceOverrunWP[14][1]+irand(-3,3), AllianceOverrunWP[14][2]);
                        AddWaypoint(6, AllianceOverrunWP[15][0]+irand(-3,3), AllianceOverrunWP[15][1]+irand(-3,3), AllianceOverrunWP[15][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[15][0]+irand(-3,3), AllianceOverrunWP[15][1]+irand(-3,3), AllianceOverrunWP[15][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 6;
                        Start(true, true, true);
                        break;
                    case 5:
                        AddWaypoint(4, AllianceOverrunWP[16][0]+irand(-3,3), AllianceOverrunWP[16][1]+irand(-3,3), AllianceOverrunWP[16][2]);
                        AddWaypoint(5, AllianceOverrunWP[17][0]+irand(-3,3), AllianceOverrunWP[17][1]+irand(-3,3), AllianceOverrunWP[17][2]);
                        AddWaypoint(6, AllianceOverrunWP[18][0]+irand(-3,3), AllianceOverrunWP[18][1]+irand(-3,3), AllianceOverrunWP[18][2]);
                        AddWaypoint(7, AllianceOverrunWP[19][0]+irand(-3,3), AllianceOverrunWP[19][1]+irand(-3,3), AllianceOverrunWP[19][2]);
                        AddWaypoint(8, AllianceOverrunWP[20][0]+irand(-3,3), AllianceOverrunWP[20][1]+irand(-3,3), AllianceOverrunWP[20][2]);
                        AddWaypoint(9, AllianceOverrunWP[21][0]+irand(-3,3), AllianceOverrunWP[21][1]+irand(-3,3), AllianceOverrunWP[21][2]);
                        m_creature->SetHomePosition(AllianceOverrunWP[21][0]+irand(-3,3), AllianceOverrunWP[21][1]+irand(-3,3), AllianceOverrunWP[21][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 9;
                        Start(true, true, true);
                        break;
                    default:
                        AddWaypoint( 4, AllianceOverrunWP[35][0]+irand(-3,3), AllianceOverrunWP[35][1]+irand(-3,3), AllianceOverrunWP[35][2]);
                        AddWaypoint( 5, AllianceOverrunWP[34][0]+irand(-3,3), AllianceOverrunWP[34][1]+irand(-3,3), AllianceOverrunWP[34][2]);
                        AddWaypoint( 6, AllianceOverrunWP[33][0]+irand(-3,3), AllianceOverrunWP[33][1]+irand(-3,3), AllianceOverrunWP[33][2]);
                        AddWaypoint( 7, AllianceOverrunWP[32][0]+irand(-3,3), AllianceOverrunWP[32][1]+irand(-3,3), AllianceOverrunWP[32][2]);
                        AddWaypoint( 8, AllianceOverrunWP[31][0]+irand(-3,3), AllianceOverrunWP[31][1]+irand(-3,3), AllianceOverrunWP[31][2]);
                        AddWaypoint( 9, AllianceOverrunWP[30][0]+irand(-3,3), AllianceOverrunWP[30][1]+irand(-3,3), AllianceOverrunWP[30][2]);
                        AddWaypoint(10, AllianceOverrunWP[29][0]+irand(-3,3), AllianceOverrunWP[29][1]+irand(-3,3), AllianceOverrunWP[29][2]);
                        AddWaypoint(11, AllianceOverrunWP[28][0]+irand(-3,3), AllianceOverrunWP[28][1]+irand(-3,3), AllianceOverrunWP[28][2]);
                        AddWaypoint(12, AllianceOverrunWP[27][0]+irand(-3,3), AllianceOverrunWP[27][1]+irand(-3,3), AllianceOverrunWP[27][2]);
                        AddWaypoint(13, AllianceOverrunWP[26][0]+irand(-3,3), AllianceOverrunWP[26][1]+irand(-3,3), AllianceOverrunWP[26][2]);
                        AddWaypoint(14, AllianceOverrunWP[25][0]+irand(-3,3), AllianceOverrunWP[25][1]+irand(-3,3), AllianceOverrunWP[25][2]);
                        AddWaypoint(15, AllianceOverrunWP[24][0]+irand(-3,3), AllianceOverrunWP[24][1]+irand(-3,3), AllianceOverrunWP[24][2]);
                        AddWaypoint(16, AllianceOverrunWP[23][0]+irand(-3,3), AllianceOverrunWP[23][1]+irand(-3,3), AllianceOverrunWP[23][2]);
                        AddWaypoint(17, AllianceOverrunWP[22][0]+irand(-3,3), AllianceOverrunWP[22][1]+irand(-3,3), AllianceOverrunWP[22][2]);
                        //m_creature->SetHomePosition(AllianceOverrunWP[0][0]+irand(-3,3), AllianceOverrunWP[0][1]+irand(-3,3), AllianceOverrunWP[0][2],0);
                        SetDespawnAtEnd(true);
                        LastOverronPos = 17;
                        Start(true, true, true);
                        break;
                }        
            }        
        }
        if(faction == 1)
        {     
            if(m_creature->GetEntry() == GHOUL)
            {
                for(uint8 i = 0; i < 6; i++)
                    AddWaypoint(i, HordeWPs[i][0]+irand(-3,3), HordeWPs[i][1]+irand(-3,3), HordeWPs[i][2]);
                switch(OverrunType)
                {
                    case 0:
                        AddWaypoint( 5, HordeOverrunWP[16][0]+irand(-10,10), HordeOverrunWP[16][1]+irand(-10,10), HordeOverrunWP[16][2]);
                        AddWaypoint( 6, HordeOverrunWP[17][0]+irand(-10,10), HordeOverrunWP[17][1]+irand(-10,10), HordeOverrunWP[17][2]);
                        AddWaypoint( 7, HordeOverrunWP[18][0], HordeOverrunWP[18][1], HordeOverrunWP[18][2]);
                        AddWaypoint( 8, HordeOverrunWP[19][0], HordeOverrunWP[19][1], HordeOverrunWP[19][2]);
                        m_creature->SetHomePosition(HordeOverrunWP[19][0], HordeOverrunWP[19][1], HordeOverrunWP[19][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 8;
                        Start(true, true, true);
                        break;
                    case 1:
                        AddWaypoint( 5, HordeOverrunWP[16][0]+irand(-10,10), HordeOverrunWP[16][1]+irand(-10,10), HordeOverrunWP[16][2]);
                        AddWaypoint( 6, HordeOverrunWP[17][0]+irand(-10,10), HordeOverrunWP[17][1]+irand(-10,10), HordeOverrunWP[17][2]);
                        AddWaypoint( 7, HordeOverrunWP[18][0], HordeOverrunWP[18][1], HordeOverrunWP[18][2]);
                        AddWaypoint( 8, HordeOverrunWP[20][0], HordeOverrunWP[20][1], HordeOverrunWP[20][2]);
                        m_creature->SetHomePosition(HordeOverrunWP[20][0], HordeOverrunWP[20][1], HordeOverrunWP[20][2],0);
                        SetDespawnAtEnd(false);
                        LastOverronPos = 8;
                        Start(true, true, true);
                        break;
                    default:
                        AddWaypoint( 5, HordeOverrunWP[0][0]+irand(-10,10), HordeOverrunWP[0][1]+irand(-10,10), HordeOverrunWP[0][2]);
                        AddWaypoint( 6, HordeOverrunWP[1][0]+irand(-10,10), HordeOverrunWP[1][1]+irand(-10,10), HordeOverrunWP[1][2]);
                        AddWaypoint( 7, HordeOverrunWP[2][0]+irand(-10,10), HordeOverrunWP[2][1]+irand(-10,10), HordeOverrunWP[2][2]);
                        AddWaypoint( 8, HordeOverrunWP[3][0]+irand(-10,10), HordeOverrunWP[3][1]+irand(-10,10), HordeOverrunWP[3][2]);
                        AddWaypoint( 9, HordeOverrunWP[4][0]+irand(-10,10), HordeOverrunWP[4][1]+irand(-10,10), HordeOverrunWP[4][2]);
                        AddWaypoint(10, HordeOverrunWP[5][0]+irand(-10,10), HordeOverrunWP[5][1]+irand(-10,10), HordeOverrunWP[5][2]);
                        AddWaypoint(11, HordeOverrunWP[6][0]+irand(-10,10), HordeOverrunWP[6][1]+irand(-10,10), HordeOverrunWP[6][2]);
                        AddWaypoint(12, HordeOverrunWP[7][0]+irand(-10,10), HordeOverrunWP[7][1]+irand(-10,10), HordeOverrunWP[7][2]);
                        AddWaypoint(13, HordeOverrunWP[8][0]+irand(-10,10), HordeOverrunWP[8][1]+irand(-10,10), HordeOverrunWP[8][2]);
                        AddWaypoint(14, HordeOverrunWP[9][0]+irand(-10,10), HordeOverrunWP[9][1]+irand(-10,10), HordeOverrunWP[9][2]);
                        AddWaypoint(15, HordeOverrunWP[10][0]+irand(-10,10), HordeOverrunWP[10][1]+irand(-10,10), HordeOverrunWP[10][2]);
                        AddWaypoint(16, HordeOverrunWP[11][0]+irand(-10,10), HordeOverrunWP[11][1]+irand(-10,10), HordeOverrunWP[11][2]);
                        AddWaypoint(17, HordeOverrunWP[12][0]+irand(-10,10), HordeOverrunWP[12][1]+irand(-10,10), HordeOverrunWP[12][2]);
                        AddWaypoint(18, HordeOverrunWP[13][0]+irand(-10,10), HordeOverrunWP[13][1]+irand(-10,10), HordeOverrunWP[13][2]);
                        AddWaypoint(19, HordeOverrunWP[14][0]+irand(-10,10), HordeOverrunWP[14][1]+irand(-10,10), HordeOverrunWP[14][2]);
                        AddWaypoint(20, HordeOverrunWP[15][0]+irand(-10,10), HordeOverrunWP[15][1]+irand(-10,10), HordeOverrunWP[15][2]);
                       //m_creature->SetHomePosition(AllianceOverrunWP[2][0]+irand(-10,10), AllianceOverrunWP[2][1]+irand(-10,10), AllianceOverrunWP[2][2],0);
                        SetDespawnAtEnd(true);
                        LastOverronPos = 20;
                        Start(true, true, true);
                        break;
                }
            }
            if(m_creature->GetEntry() == ABOMINATION)
            {
                for(uint8 i = 0; i < 6; i++)
                    AddWaypoint(i, HordeWPs[i][0]+irand(-10,10), HordeWPs[i][1]+irand(-10,10), HordeWPs[i][2]);
                switch(OverrunType)
                {
                    case 0:
                    default:
                        AddWaypoint( 5, HordeOverrunWP[0][0]+irand(-10,10), HordeOverrunWP[0][1]+irand(-10,10), HordeOverrunWP[0][2]);
                        AddWaypoint( 6, HordeOverrunWP[1][0]+irand(-10,10), HordeOverrunWP[1][1]+irand(-10,10), HordeOverrunWP[1][2]);
                        AddWaypoint( 7, HordeOverrunWP[2][0]+irand(-10,10), HordeOverrunWP[2][1]+irand(-10,10), HordeOverrunWP[2][2]);
                        AddWaypoint( 8, HordeOverrunWP[3][0]+irand(-10,10), HordeOverrunWP[3][1]+irand(-10,10), HordeOverrunWP[3][2]);
                        AddWaypoint( 9, HordeOverrunWP[4][0]+irand(-10,10), HordeOverrunWP[4][1]+irand(-10,10), HordeOverrunWP[4][2]);
                        AddWaypoint(10, HordeOverrunWP[5][0]+irand(-10,10), HordeOverrunWP[5][1]+irand(-10,10), HordeOverrunWP[5][2]);
                        AddWaypoint(11, HordeOverrunWP[6][0]+irand(-10,10), HordeOverrunWP[6][1]+irand(-10,10), HordeOverrunWP[6][2]);
                        AddWaypoint(12, HordeOverrunWP[7][0]+irand(-10,10), HordeOverrunWP[7][1]+irand(-10,10), HordeOverrunWP[7][2]);
                        AddWaypoint(13, HordeOverrunWP[8][0]+irand(-10,10), HordeOverrunWP[8][1]+irand(-10,10), HordeOverrunWP[8][2]);
                        AddWaypoint(14, HordeOverrunWP[9][0]+irand(-10,10), HordeOverrunWP[9][1]+irand(-10,10), HordeOverrunWP[9][2]);
                        AddWaypoint(15, HordeOverrunWP[10][0]+irand(-10,10), HordeOverrunWP[10][1]+irand(-10,10), HordeOverrunWP[10][2]);
                        AddWaypoint(16, HordeOverrunWP[11][0]+irand(-10,10), HordeOverrunWP[11][1]+irand(-10,10), HordeOverrunWP[11][2]);
                        AddWaypoint(17, HordeOverrunWP[12][0]+irand(-10,10), HordeOverrunWP[12][1]+irand(-10,10), HordeOverrunWP[12][2]);
                        AddWaypoint(18, HordeOverrunWP[13][0]+irand(-10,10), HordeOverrunWP[13][1]+irand(-10,10), HordeOverrunWP[13][2]);
                        AddWaypoint(19, HordeOverrunWP[14][0]+irand(-10,10), HordeOverrunWP[14][1]+irand(-10,10), HordeOverrunWP[14][2]);
                        AddWaypoint(20, HordeOverrunWP[15][0]+irand(-10,10), HordeOverrunWP[15][1]+irand(-10,10), HordeOverrunWP[15][2]);
                        //m_creature->SetHomePosition(AllianceOverrunWP[2][0]+irand(-10,10), AllianceOverrunWP[2][1]+irand(-10,10), AllianceOverrunWP[2][2],0);
                        SetDespawnAtEnd(true);
                        LastOverronPos = 20;
                        Start(true, true, true);
                        break;
                }
            }
        }
    }
}

void hyjal_trashAI::JustDied(Unit *victim)
{
    if(!pInstance)return;
    if(IsEvent && !m_creature->isWorldBoss())
        pInstance->SetData(DATA_TRASH, 0);//signal trash is dead

    if((pInstance->GetData(DATA_RAIDDAMAGE) < MINRAIDDAMAGE && !m_creature->isWorldBoss()) || (damageTaken < m_creature->GetMaxHealth()/4 && m_creature->isWorldBoss()))
        m_creature->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);//no loot

    if(IsOverrun)
    {
        float x,y,z,o;
        m_creature->GetHomePosition(x,y,z,o);
        Creature* pUnit = m_creature->SummonCreature(m_creature->GetEntry(),x,y,z,o, TEMPSUMMON_MANUAL_DESPAWN, 2*60*1000);
        if(pUnit)
        {
            ((hyjal_trashAI*)pUnit->AI())->faction = faction;                    
            ((hyjal_trashAI*)pUnit->AI())->IsOverrun = true;
            ((hyjal_trashAI*)pUnit->AI())->OverrunType = OverrunType;
            ((hyjal_trashAI*)pUnit->AI())->SetupOverrun = true;
            ((hyjal_trashAI*)pUnit->AI())->DummyTarget[0] = DummyTarget[0];
            ((hyjal_trashAI*)pUnit->AI())->DummyTarget[1] = DummyTarget[1];
            ((hyjal_trashAI*)pUnit->AI())->DummyTarget[2] = DummyTarget[2];
            pUnit->setActive(true);
            pUnit->AI()->EnterEvadeMode();
        }
    }
}

struct mob_giant_infernalAI : public hyjal_trashAI
{
    mob_giant_infernalAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        meteor = false;//call once!
        CanMove = false;
        Delay = rand()%30000;
        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        m_creature->SetUInt32Value(UNIT_FIELD_DISPLAYID, MODEL_INVIS);
        go = false;    
        pos = 0;
        Reset();
    }

    bool meteor;
    bool CanMove;
    bool WpEnabled;
    bool go;
    uint32 pos;
    uint32 spawnTimer;
    uint32 FlameBuffetTimer;
    bool imol;

    void Reset()
    {        
        spawnTimer = 2000;
        FlameBuffetTimer= 2000;
        imol = false;
    }

    void Aggro(Unit* who) {}

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 0 && pInstance && !IsOverrun)
        {
            if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, attack thrall
            {
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(Delay<diff)
        {
            Delay=0;
        }else{
            Delay-=diff;
            return;
        }
        if (!meteor)
        {
            float x,y,z;
            m_creature->GetPosition(x,y,z);
            Creature* trigger = m_creature->SummonCreature(NPC_TRIGGER,x+8,y+8,z+25+rand()%10,m_creature->GetOrientation(),TEMPSUMMON_TIMED_DESPAWN,1000);
            if(trigger)
            {
                trigger->SetVisibility(VISIBILITY_OFF);
                trigger->setFaction(m_creature->getFaction());
                trigger->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT + MOVEMENTFLAG_LEVITATING);
                trigger->CastSpell(m_creature,SPELL_METEOR,true);
            }
            m_creature->GetMotionMaster()->Clear();
            meteor = true;
        }else if (!CanMove){
            if(spawnTimer<diff)
            {
                m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                m_creature->SetUInt32Value(UNIT_FIELD_DISPLAYID, m_creature->GetUInt32Value(UNIT_FIELD_NATIVEDISPLAYID));
                CanMove = true;
                /*if (m_creature->getVictim())
                    m_creature->GetMotionMaster()->MoveChase(m_creature->getVictim());*/
                if (pInstance)
                {
                    if (pInstance->GetData(DATA_ALLIANCE_RETREAT) && !pInstance->GetData(DATA_HORDE_RETREAT))
                    {
                        Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                        if (target && target->isAlive())
                            m_creature->AddThreat(target,0.0);
                    }else if (pInstance->GetData(DATA_ALLIANCE_RETREAT) && pInstance->GetData(DATA_HORDE_RETREAT)){
                        //do overrun
                    }
                }        
            }else spawnTimer -= diff;
        }
        if(!CanMove)return;
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
            npc_escortAI::UpdateAI(diff);
        if (IsEvent)
        {
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(0, HordeWPs[7][0]+irand(-3,3),    HordeWPs[7][1]+irand(-3,3),    HordeWPs[7][2]);//HordeWPs[7] infront of thrall
                    ((npc_escortAI*)(m_creature->AI()))->Start(true, true, true);
                    ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                }
            }
        }

        if (!UpdateVictim())
            return;
        if(!imol)
        {
            DoCast(m_creature,SPELL_IMMOLATION);
            imol=true;
        }
        if(FlameBuffetTimer<diff)
        {
            DoCast(m_creature->getVictim(),SPELL_FLAME_BUFFET,true);
            FlameBuffetTimer = 7000;
        }else FlameBuffetTimer -= diff;
        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_mob_giant_infernal(Creature* _Creature)
{
    return new mob_giant_infernalAI(_Creature);
}

#define SPELL_DISEASE_CLOUD 31607
#define SPELL_KNOCKDOWN 31610

struct mob_abominationAI : public hyjal_trashAI
{
    mob_abominationAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;    
        pos = 0;
        Reset();
    }

    bool go;
    uint32 KnockDownTimer;
    uint32 pos;
    void Reset()
    {
        KnockDownTimer = 10000;
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance && !IsOverrun)
        {
            if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, attack thrall
            {
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }else{
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }
        }    
        if (i == LastOverronPos && IsOverrun)
        {
            if(faction == 0 && LastOverronPos == 17)//alliance round
            {
                Creature* pUnit = m_creature->SummonCreature(m_creature->GetEntry(),4928.48+irand(-10,10),    -1526.38+irand(-10,10),    1326.83,0, TEMPSUMMON_MANUAL_DESPAWN, 2*60*1000);
                if(pUnit)
                {
                    ((hyjal_trashAI*)pUnit->AI())->faction = faction;                    
                    ((hyjal_trashAI*)pUnit->AI())->IsOverrun = true;
                    ((hyjal_trashAI*)pUnit->AI())->OverrunType = 2;//default
                    ((hyjal_trashAI*)pUnit->AI())->SetupOverrun = false;
                    pUnit->setActive(true);
                }
            }
            if(faction == 1 && LastOverronPos == 20)//horde round
            {
                Creature* pUnit = m_creature->SummonCreature(m_creature->GetEntry(),5458.01+irand(-10,10),-2340.27+irand(-10,10),1459.60,0, TEMPSUMMON_MANUAL_DESPAWN, 2*60*1000);
                if(pUnit)
                {
                    ((hyjal_trashAI*)pUnit->AI())->faction = faction;                    
                    ((hyjal_trashAI*)pUnit->AI())->IsOverrun = true;
                    ((hyjal_trashAI*)pUnit->AI())->OverrunType = 10;//default
                    ((hyjal_trashAI*)pUnit->AI())->SetupOverrun = false;
                    pUnit->setActive(true);
                }
            }
        }
    }

    void Aggro(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
            npc_escortAI::UpdateAI(diff);
        if (IsEvent)
        {            
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, use horde WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, HordeWPs[i][0]+irand(-3,3),    HordeWPs[i][1]+irand(-3,3),    HordeWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else//use alliance WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3),    AllianceWPs[i][1]+irand(-3,3),    AllianceWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }
                }            
            }
        }
        if(!m_creature->HasAura(SPELL_DISEASE_CLOUD,0))
            DoCast(m_creature,SPELL_DISEASE_CLOUD);
        if (!UpdateVictim())
            return;
        if(KnockDownTimer<diff)
        {
            DoCast(m_creature->getVictim(),SPELL_KNOCKDOWN);
            KnockDownTimer = 30000+rand()%25000;
        }else KnockDownTimer -= diff;
        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_mob_abomination(Creature* _Creature)
{
    return new mob_abominationAI(_Creature);
}

#define SPELL_FRENZY 31540

struct mob_ghoulAI : public hyjal_trashAI
{
    mob_ghoulAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;    
        pos = 0;
        Reset();
    }

    bool go;
    uint32 FrenzyTimer;
    uint32 pos;
    uint32 MoveTimer;
    bool RandomMove;
    void Reset()
    {
        FrenzyTimer = 5000+rand()%5000;
        MoveTimer = 2000;
        RandomMove = false;
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance && !IsOverrun)
        {
            if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, attack thrall
            {
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }else{
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }
        }
        if (i == LastOverronPos && IsOverrun)
        {
            m_creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACKUNARMED);
            if(faction == 0 && LastOverronPos == 17)//alliance round
            {
                Creature* pUnit = m_creature->SummonCreature(m_creature->GetEntry(),4928.48+irand(-10,10), -1526.38+irand(-10,10), 1326.83,0, TEMPSUMMON_MANUAL_DESPAWN, 2*60*1000);
                if(pUnit)
                {
                    ((hyjal_trashAI*)pUnit->AI())->faction = faction;                    
                    ((hyjal_trashAI*)pUnit->AI())->IsOverrun = true;
                    ((hyjal_trashAI*)pUnit->AI())->OverrunType = 6;//default
                    ((hyjal_trashAI*)pUnit->AI())->SetupOverrun = false;
                    pUnit->setActive(true);
                }
            }
            if(faction == 1 && LastOverronPos == 20)//horde round
            {
                Creature* pUnit = m_creature->SummonCreature(m_creature->GetEntry(),5458.01+irand(-10,10), -2340.27+irand(-10,10), 1459.60,0, TEMPSUMMON_MANUAL_DESPAWN, 2*60*1000);
                if(pUnit)
                {
                    ((hyjal_trashAI*)pUnit->AI())->faction = faction;                    
                    ((hyjal_trashAI*)pUnit->AI())->IsOverrun = true;
                    ((hyjal_trashAI*)pUnit->AI())->OverrunType = 10;//default
                    ((hyjal_trashAI*)pUnit->AI())->SetupOverrun = false;
                    pUnit->setActive(true);
                }
            }
        }
    }

    void Aggro(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
            npc_escortAI::UpdateAI(diff);
        if (IsEvent)
        {
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, use horde WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, HordeWPs[i][0]+irand(-3,3),    HordeWPs[i][1]+irand(-3,3),    HordeWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else//use alliance WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3),    AllianceWPs[i][1]+irand(-3,3),    AllianceWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }
                }            
            }        
        }
        if(FrenzyTimer<diff)
        {
            DoCast(m_creature,SPELL_FRENZY);
            FrenzyTimer = 15000+rand()%15000;
        }else FrenzyTimer -= diff;        
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_mob_ghoul(Creature* _Creature)
{
    return new mob_ghoulAI(_Creature);
}

#define SPELL_RAISE_DEAD_1 31617
#define SPELL_RAISE_DEAD_2 31624
#define SPELL_RAISE_DEAD_3 31625
#define SPELL_SHADOW_BOLT 31627

struct mob_necromancerAI : public hyjal_trashAI
{
    mob_necromancerAI(Creature* c) : hyjal_trashAI(c), summons(m_creature)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;    
        pos = 0;
        Reset();
    }
    SummonList summons;
    bool go;
    uint32 ShadowBoltTimer;
    uint32 pos;
    void Reset()
    {
        ShadowBoltTimer = 1000+rand()%5000;
        summons.DespawnAll();
    }

    void JustSummoned(Creature* summon)
    {
        Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0,30,true);
        if(target && summon)
            summon->Attack(target,false);
        summons.Summon(summon);
    }
    void SummonedCreatureDespawn(Creature *summon) {summons.Despawn(summon);}
    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance && !IsOverrun)
        {
            if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, attack thrall
            {
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }else{
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }
        }        
        if (i == LastOverronPos && IsOverrun)
        {
            Creature* pUnit = m_creature->SummonCreature(17931, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 2*60*1000);
            if(pUnit)
            {
                pUnit->SetVisibility(VISIBILITY_OFF);
                pUnit->SetMaxHealth(10000000);
                pUnit->SetHealth(10000000);
                pUnit->setFaction(17772);
                pUnit->Attack(m_creature, true);
                m_creature->AddThreat(pUnit,0);
            }
        }
    }

    void KilledUnit(Unit* victim)
    {
        switch (rand()%3)
        {
            case 0:
                DoSpawnCreature(17902,3,0,0,0,TEMPSUMMON_TIMED_DESPAWN, 60000);
                DoSpawnCreature(17902,-3,0,0,0,TEMPSUMMON_TIMED_DESPAWN, 60000);
                break;
            case 1:
                DoSpawnCreature(17903,3,0,0,0,TEMPSUMMON_TIMED_DESPAWN, 60000);
                DoSpawnCreature(17903,-3,0,0,0,TEMPSUMMON_TIMED_DESPAWN, 60000);
                break;
            case 2:
                if(rand()%2)
                    DoSpawnCreature(17902,3,0,0,0,TEMPSUMMON_TIMED_DESPAWN, 60000);
                else
                    DoSpawnCreature(17903,3,0,0,0,TEMPSUMMON_TIMED_DESPAWN, 60000);
                break;
        }
    }

    void Aggro(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
            npc_escortAI::UpdateAI(diff);
        if (IsEvent)
        {
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, use horde WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, HordeWPs[i][0]+irand(-3,3),    HordeWPs[i][1]+irand(-3,3),    HordeWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(true, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else//use alliance WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3),    AllianceWPs[i][1]+irand(-3,3),    AllianceWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(true, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }
                }            
            }        
        }
        if (!UpdateVictim())
            return;
        if(ShadowBoltTimer<diff)
        {
            DoCast(m_creature->getVictim(),SPELL_SHADOW_BOLT);
            ShadowBoltTimer = 20000+rand()%10000;
        }else ShadowBoltTimer -= diff;        

        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_mob_necromancer(Creature* _Creature)
{
    return new mob_necromancerAI(_Creature);
}

#define SPELL_BANSHEE_CURSE 31651
#define SPELL_BANSHEE_WAIL 38183
#define SPELL_ANTI_MAGIC_SHELL 31662

struct mob_bansheeAI : public hyjal_trashAI
{
    mob_bansheeAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;    
        pos = 0;
        Reset();
    }

    bool go;
    uint32 CourseTimer;
    uint32 WailTimer;
    uint32 ShellTimer;
    uint32 pos;
    void Reset()
    {
        CourseTimer = 20000+rand()%5000;
        WailTimer = 15000+rand()%5000;
        ShellTimer = 50000+rand()%10000;
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance && !IsOverrun)
        {
            if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, attack thrall
            {
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }else{
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }
        }        
        if (i == LastOverronPos && IsOverrun)
        {
            Creature* pUnit = m_creature->SummonCreature(17931, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 2*60*1000);
            if(pUnit)
            {
                pUnit->SetVisibility(VISIBILITY_OFF);
                pUnit->SetMaxHealth(10000000);
                pUnit->SetHealth(10000000);
                pUnit->setFaction(17772);
                pUnit->Attack(m_creature, true);
                m_creature->AddThreat(pUnit,0);
            }
        }
    }

    void Aggro(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
            npc_escortAI::UpdateAI(diff);
        if (IsEvent)
        {
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, use horde WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, HordeWPs[i][0]+irand(-3,3),    HordeWPs[i][1]+irand(-3,3),    HordeWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else//use alliance WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3),    AllianceWPs[i][1]+irand(-3,3),    AllianceWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }
                }            
            }        
        }
        if (!UpdateVictim())
            return;
        if(CourseTimer<diff)
        {
            DoCast(m_creature->getVictim(),SPELL_BANSHEE_CURSE);
            CourseTimer = 20000+rand()%5000;
        }else CourseTimer -= diff;
        if(WailTimer<diff)
        {
            DoCast(m_creature->getVictim(),SPELL_BANSHEE_WAIL);
            WailTimer = 15000+rand()%5000;
        }else WailTimer -= diff;
        if(ShellTimer<diff)
        {
            DoCast(m_creature,SPELL_ANTI_MAGIC_SHELL);
            ShellTimer = 50000+rand()%10000;
        }else ShellTimer -= diff;
        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_mob_banshee(Creature* _Creature)
{
    return new mob_bansheeAI(_Creature);
}

#define SPELL_WEB 28991

struct mob_crypt_fiendAI : public hyjal_trashAI
{
    mob_crypt_fiendAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;    
        pos = 0;
        Reset();
    }

    bool go;
    uint32 WebTimer;
    uint32 pos;
    void Reset()
    {
        WebTimer = 20000+rand()%5000;
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance && !IsOverrun)
        {
            if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, attack thrall
            {
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }else{
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }
        }        
        if (i == LastOverronPos && IsOverrun)
        {
            Creature* pUnit = m_creature->SummonCreature(17931, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 2*60*1000);
            if(pUnit)
            {
                pUnit->SetVisibility(VISIBILITY_OFF);
                pUnit->SetMaxHealth(10000000);
                pUnit->SetHealth(10000000);
                pUnit->setFaction(17772);
                pUnit->Attack(m_creature, true);
                m_creature->AddThreat(pUnit,0);
            }
        }
    }

    void Aggro(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
            npc_escortAI::UpdateAI(diff);
        if (IsEvent)
        {
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, use horde WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, HordeWPs[i][0]+irand(-3,3),    HordeWPs[i][1]+irand(-3,3),    HordeWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else//use alliance WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3),    AllianceWPs[i][1]+irand(-3,3),    AllianceWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }

                }            
            }        
        }
        if (!UpdateVictim())
            return;
        if(WebTimer<diff)
        {
            DoCast(m_creature->getVictim(),SPELL_WEB);
            WebTimer = 20000+rand()%5000;
        }else WebTimer -= diff;
        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_mob_crypt_fiend(Creature* _Creature)
{
    return new mob_crypt_fiendAI(_Creature);
}

#define SPELL_MANA_BURN 31729

struct mob_fel_stalkerAI : public hyjal_trashAI
{
    mob_fel_stalkerAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;    
        pos = 0;
        Reset();
    }

    bool go;
    uint32 ManaBurnTimer;
    uint32 pos;
    void Reset()
    {
        ManaBurnTimer = 9000+rand()%5000;
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 7 && pInstance && !IsOverrun)
        {
            if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, attack thrall
            {
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }else{
                Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_JAINAPROUDMOORE));
                if (target && target->isAlive())
                    m_creature->AddThreat(target,0.0);
            }
        }        
        if (i == LastOverronPos && IsOverrun)
        {
            Creature* pUnit = m_creature->SummonCreature(17931, m_creature->GetPositionX(), m_creature->GetPositionY(), m_creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 2*60*1000);
            if(pUnit)
            {
                pUnit->SetVisibility(VISIBILITY_OFF);
                pUnit->SetMaxHealth(10000000);
                pUnit->SetHealth(10000000);
                pUnit->setFaction(17772);
                pUnit->Attack(m_creature, true);
                m_creature->AddThreat(pUnit,0);
            }
        }
    }

    void Aggro(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
            npc_escortAI::UpdateAI(diff);
        if (IsEvent)
        {
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if (pInstance->GetData(DATA_ALLIANCE_RETREAT))//2.alliance boss down, use horde WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, HordeWPs[i][0]+irand(-3,3),    HordeWPs[i][1]+irand(-3,3),    HordeWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else//use alliance WPs
                    {
                        for (uint8 i = 0; i < 8; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, AllianceWPs[i][0]+irand(-3,3),    AllianceWPs[i][1]+irand(-3,3),    AllianceWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }

                }            
            }        
        }
        if (!UpdateVictim())
            return;
        if(ManaBurnTimer<diff)
        {
            DoCast(m_creature->getVictim(),SPELL_MANA_BURN);
            ManaBurnTimer = 9000+rand()%5000;
        }else ManaBurnTimer -= diff;
        DoMeleeAttackIfReady();
    }
};


CreatureAI* GetAI_mob_fel_stalker(Creature* _Creature)
{
    return new mob_fel_stalkerAI(_Creature);
}

#define SPELL_FROST_BREATH 31688

struct mob_frost_wyrmAI : public hyjal_trashAI
{
    mob_frost_wyrmAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;
        pos = 0;
        Reset();
    }

    bool go;
    uint32 FrostBreathTimer;
    uint32 pos;
    uint32 MoveTimer;

    void Reset()
    {
        FrostBreathTimer = 5000;
        MoveTimer = 0;        
        m_creature->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT + MOVEMENTFLAG_LEVITATING);
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 2 && pInstance && !IsOverrun)
        {
            Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
            if (target && target->isAlive())
            {
                m_creature->AddThreat(target,0.0);
                DoCast(target,SPELL_FROST_BREATH,true);
            }
        }        
    }

    void JustDied(Unit *victim)
    {
        if(pInstance && IsEvent)
            pInstance->SetData(DATA_TRASH, 0);//signal trash is dead

        float x,y,z;
        m_creature->GetPosition(x,y,z);
        z = m_creature->GetMap()->GetVmapHeight(x, y, z, true);
        m_creature->GetMotionMaster()->MovePoint(0,x,y,z);
        m_creature->Relocate(x,y,z,0);
    }

    void Aggro(Unit* who) {}

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
        {
            ((hyjal_trashAI*)m_creature->AI())->SetCanMelee(false);
            npc_escortAI::UpdateAI(diff);
        }
        if (IsEvent)        
        {            
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if(!useFlyPath)
                    {
                        for (uint8 i = 0; i < 3; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, FrostWyrmWPs[i][0],    FrostWyrmWPs[i][1],    FrostWyrmWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else{//fly path FlyPathWPs
                        for (uint8 i = 0; i < 3; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, FlyPathWPs[i][0]+irand(-10,10),    FlyPathWPs[i][1]+irand(-10,10),    FlyPathWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }
                }            
            }        
        }
        if (!UpdateVictim())
            return;
        if(m_creature->GetDistance(m_creature->getVictim()) >= 25){
            if(MoveTimer<diff)
            {
                m_creature->GetMotionMaster()->MoveChase(m_creature->getVictim());
                MoveTimer = 2000;
            }else MoveTimer-=diff;
        }
                
        if(FrostBreathTimer<diff)
        {
            if(m_creature->GetDistance(m_creature->getVictim()) < 25)
            {
                DoCast(m_creature->getVictim(),SPELL_FROST_BREATH);
                m_creature->StopMoving();
                m_creature->GetMotionMaster()->Clear();
                FrostBreathTimer = 4000;
            }            
        }else FrostBreathTimer -= diff;
    }
};


CreatureAI* GetAI_mob_frost_wyrm(Creature* _Creature)
{
    return new mob_frost_wyrmAI(_Creature);
}

#define SPELL_GARGOYLE_STRIKE 31664

struct mob_gargoyleAI : public hyjal_trashAI
{
    mob_gargoyleAI(Creature* c) : hyjal_trashAI(c)
    {
        pInstance = ((ScriptedInstance*)c->GetInstanceData());
        go = false;
        pos = 0;
        DummyTarget[0] = 0;DummyTarget[1] = 0;DummyTarget[2] = 0;
        Reset();
    }

    bool go;
    uint32 StrikeTimer;
    uint32 pos;
    uint32 MoveTimer;
    float Zpos;
    bool forcemove;    

    void Reset()
    {
        forcemove = true;
        Zpos = 10.0;
        StrikeTimer = 2000+rand()%5000;
        MoveTimer = 0;        
        m_creature->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT + MOVEMENTFLAG_LEVITATING);        
    }

    void WaypointReached(uint32 i)
    {
        pos = i;
        if (i == 2 && pInstance && !IsOverrun)
        {
            Unit* target = Unit::GetUnit((*m_creature), pInstance->GetData64(DATA_THRALL));
            if (target && target->isAlive())
            {
                m_creature->AddThreat(target,0.0);
                DoCast(target,SPELL_GARGOYLE_STRIKE,true);
            }
        }    
        if (IsOverrun && i == LastOverronPos)
        {
            AddWaypoint(0, 5536.65+irand(-80,80), -2710.66+irand(-80,80), 1504.45+irand(-10,10));
            AddWaypoint(1, 5536.65+irand(-80,80), -2710.66+irand(-80,80), 1504.45+irand(-10,10));
            SetDespawnAtEnd(false);
            LastOverronPos = 1;
            Start(false, true, true);
        }
    }

    void JustDied(Unit *victim)
    {
        float x,y,z;
        m_creature->GetPosition(x,y,z);
        z = m_creature->GetMap()->GetVmapHeight(x, y, z, true);
        m_creature->GetMotionMaster()->MovePoint(0,x,y,z);
        m_creature->Relocate(x,y,z,0);
        hyjal_trashAI::JustDied(victim); 
    }

    void UpdateAI(const uint32 diff)
    {
        hyjal_trashAI::UpdateAI(diff);
        if(IsEvent || IsOverrun)
        {
            ((hyjal_trashAI*)m_creature->AI())->SetCanMelee(false);
            npc_escortAI::UpdateAI(diff);
        }
        if (IsEvent)
        {
            if(!go)
            {
                go = true;
                if(pInstance)
                {
                    if(!useFlyPath)
                    {
                        for (uint8 i = 0; i < 3; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, GargoyleWPs[i][0]+irand(-10,10), GargoyleWPs[i][1]+irand(-10,10), GargoyleWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }else{//fly path FlyPathWPs
                        for (uint8 i = 0; i < 3; ++i)
                            ((npc_escortAI*)(m_creature->AI()))->AddWaypoint(i, FlyPathWPs[i][0]+irand(-10,10),    FlyPathWPs[i][1]+irand(-10,10),    FlyPathWPs[i][2]);
                        ((npc_escortAI*)(m_creature->AI()))->Start(false, true, true);
                        ((npc_escortAI*)(m_creature->AI()))->SetDespawnAtEnd(false);
                    }
                }            
            }        
        }
        if(IsOverrun && !UpdateVictim())
        {
            if(faction == 0)//alliance
            {
                if(StrikeTimer<diff)
                {
                    m_creature->CastSpell(DummyTarget[0],DummyTarget[1],DummyTarget[2],SPELL_GARGOYLE_STRIKE,false);                
                    StrikeTimer = 2000+rand()%1000;
                }else StrikeTimer -= diff;
                }
        }
        if (!UpdateVictim())
            return;
        if(m_creature->GetDistance(m_creature->getVictim()) >= 20 || forcemove)
        {
            forcemove = false;
            if(forcemove)
            {
                Unit *target = SelectUnit(SELECT_TARGET_RANDOM, 0);
                if(target)
                    m_creature->Attack(target,false);
            }
            if(MoveTimer<diff)
            {
                float x,y,z;
                m_creature->getVictim()->GetPosition(x,y,z);
                m_creature->GetMotionMaster()->MovePoint(0,x,y,z+Zpos);
                Zpos-=1.0;
                if(Zpos<=0)Zpos=0;                
                MoveTimer = 2000;
            }else MoveTimer-=diff;
        }                
        if(StrikeTimer<diff)
        {
            if(m_creature->GetDistance(m_creature->getVictim()) < 20)
            {
                DoCast(m_creature->getVictim(),SPELL_GARGOYLE_STRIKE);
                m_creature->StopMoving();
                m_creature->GetMotionMaster()->Clear();
                StrikeTimer = 2000+rand()%1000;
            }else StrikeTimer=0;
        }else StrikeTimer -= diff;
    }
};


CreatureAI* GetAI_mob_gargoyle(Creature* _Creature)
{
    return new mob_gargoyleAI(_Creature);
}

#define SPELL_EXPLODING_SHOT 7896

struct TRINITY_DLL_DECL alliance_riflemanAI : public Scripted_NoMovementAI
{
    alliance_riflemanAI(Creature *c) : Scripted_NoMovementAI(c)
    {
        Reset();
    }

    uint32 ExplodeTimer;

    void JustDied(Unit*)
    {
    }

    void Reset()
    {
        ExplodeTimer = 5000+rand()%5000;
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (!who || m_creature->getVictim())
            return;

        if (who->isTargetableForAttack() && m_creature->IsHostileTo(who))
        {
            float attackRadius = m_creature->GetAttackDistance(who);
            if (m_creature->IsWithinDistInMap(who, 30))
            {
                AttackStart(who);
            }
        }
    }

    void Aggro(Unit *who)
    {
    }

    void UpdateAI(const uint32 diff)
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;
        if(ExplodeTimer < diff)
        {
            if (!m_creature->IsWithinDistInMap(m_creature->getVictim(), 30))
            {
                EnterEvadeMode();
                return;
            }
            int dmg = 500+rand()%700;
            m_creature->CastCustomSpell(m_creature->getVictim(), SPELL_EXPLODING_SHOT, &dmg, 0, 0, false);
            ExplodeTimer = 5000+rand()%5000;
        }else ExplodeTimer -= diff;
        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_alliance_rifleman(Creature* _Creature)
{
    return new alliance_riflemanAI(_Creature);
}

void AddSC_hyjal_trash()
{
    Script *newscript = new Script;
    newscript->Name = "mob_giant_infernal";
    newscript->GetAI = &GetAI_mob_giant_infernal;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_abomination";
    newscript->GetAI = &GetAI_mob_abomination;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_ghoul";
    newscript->GetAI = &GetAI_mob_ghoul;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_necromancer";
    newscript->GetAI = &GetAI_mob_necromancer;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_banshee";
    newscript->GetAI = &GetAI_mob_banshee;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_crypt_fiend";
    newscript->GetAI = &GetAI_mob_crypt_fiend;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_fel_stalker";
    newscript->GetAI = &GetAI_mob_fel_stalker;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_frost_wyrm";
    newscript->GetAI = &GetAI_mob_frost_wyrm;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "mob_gargoyle";
    newscript->GetAI = &GetAI_mob_gargoyle;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "alliance_rifleman";
    newscript->GetAI = &GetAI_alliance_rifleman;
    newscript->RegisterSelf();
}
