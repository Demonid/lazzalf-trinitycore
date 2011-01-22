#ifndef ANTI_CHEAT_H
#define ANTI_CHEAT_H

/**
 *
 * @File : AntiCheat.h
 *
 * @Authors : Lazzalf based on AC2 and Manuel AntiCheat
 *
 **/

#include "Common.h"
#include "WorldSession.h"

enum eCheat
{
	CHEAT_MULTIJUMP = 0,
	CHEAT_SPEED,
	CHEAT_TELEPORT,
	CHEAT_FLY,
	CHEAT_WATERWALK,
	CHEAT_TELETOPLANE,
    MAX_CHEAT
};

enum ePuniType
{
    PUNI_NONE = 0,
    PUNI_BLOCK,
	PUNI_KILL,
	PUNI_KICK,
	PUNI_BAN_CHAR,
    PUNI_BAN_ACC,
    PUNI_BAN_IP,
    MAX_PUNI
};

class AntiCheat
{
    private:
        Player* plMover;

		bool ac_block;        
		int32 ac_delta;

        MovementInfo lastpMovementInfo;
        uint32 uiLastOpcode;

        bool cheat_find;

        bool map_count;
        bool map_block;
        bool map_puni;

		// Delthas
		uint64 cServerTime;		
		uint32 cServerTimeDelta;
        uint32 difftime_log_file;
        uint32 difftime_log_db;
        uint32 uiDiffTime_packets;

		// Variables
        uint32 uSpeedRate;         
        uint32 uClientSpeedRate;
        uint32 uDistance2D;

		float delta_z;
		bool fly_auras;
		bool swim_in_water;
		float tg_z;
		float JumpHeight;       
		
		void CalcDeltas(MovementInfo& pNewPacket, MovementInfo& pOldPacket);
		void CalcVariables(MovementInfo& pOldPacket, MovementInfo& pNewPacket, Unit* mover);
        bool CanFly(MovementInfo& pMovementInfo);
		
		bool CheckAntiMultiJump(MovementInfo& pNewPacket, uint32 uiOpcode);
        bool CheckAntiSpeed(MovementInfo& pOldPacket, MovementInfo& pNewPacket, uint32 uiOpcode);
        bool CheckAntiTele(MovementInfo& pNewPacket, uint32 uiOpcode);
		bool CheckAntiFly(MovementInfo& pOldPacket, MovementInfo& pNewPacket);
		bool CheckAntiWaterwalk(MovementInfo& pOldPacket, MovementInfo& pNewPacket);
		bool CheckAntiTeleToPlane(MovementInfo& pOldPacket, MovementInfo& pNewPacket);
        void LogCheat(eCheat /*m_cheat*/, MovementInfo& /*pMovementInfo*/);
        bool AntiCheatPunisher(MovementInfo& /*pMovementInfo*/);
        inline bool ControllPunisher();
	
    public:
        AntiCheat(Player* new_plMover);
		bool DoAntiCheatCheck(uint16 /*opcode*/, MovementInfo& /*pMovementInfo*/, Unit* /*mover*/);

    public:
        uint32 number_cheat_find;
        int32 ac_goactivate;

        uint32 m_CheatList[MAX_CHEAT];
        uint32 m_CheatList_reset_diff;        
	
        time_t m_anti_LastServerTime;           // last movement server time
        time_t m_anti_DeltaServerTime;          // server side session time
        time_t m_logfile_time;
        time_t m_logdb_time;

        float m_anti_Last_VSpeed;               // vertical speed, default max jump height

        uint32 m_anti_TeleToPlane_Count;        // Teleport To Plane alarm counter

        uint64 m_anti_AlarmCount;               // alarm counter

        uint16 m_anti_JumpCount;                // Jump already began, anti air jump check
        float m_anti_JumpBaseZ;                 // Z coord before jump
		
		void SetBlock(bool /*block*/);
		bool GetBlock();
		bool GetAndUpdateDelta(int32 /*diff*/);
		void SetDelta(int32 /*delta*/);
        int32 GetDelta();
        void SetSleep(int32 delta, bool forced = true);
        void ResetCheatList(uint32 /*diff*/);
        void SaveLastPacket(MovementInfo& pMovementInfo) { lastpMovementInfo = pMovementInfo; }
        MovementInfo& GetLastPacket() { return lastpMovementInfo; }
        void SetLastOpcode(uint32 uiOpcode) { uiLastOpcode = uiOpcode; }
        uint32 GetLastOpcode() { return uiLastOpcode; }
};

#endif