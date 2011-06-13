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
#include "Object.h"

enum eCheat
{
	CHEAT_MULTIJUMP = 0,
	CHEAT_SPEED,
	CHEAT_TELEPORT,
	CHEAT_FLY,
	CHEAT_WATERWALK,
	CHEAT_TELETOPLANE,
    CHEAT_CLIMB,
    MAX_CHEAT
};

enum eWardenCheat
{
	CHECK_WARDEN_CHECKSUM = 0,
	CHECK_WARDEN_MEMORY,
	CHECK_WARDEN_KEY
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

        bool activateACCheck;
        uint32 alarmACCheckTimer;
        uint32 disableACCheckTimer;

        MovementInfo lastpMovementInfo;
        uint32 uiLastOpcode;

        bool cheat_find;

        bool warden_cheat_find;

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

		bool fly_auras;

        float angle;

        uint32 number_cheat_find;
        int32 ac_goactivate;

        uint32 m_CheatList[MAX_CHEAT];
        uint32 m_CheatList_reset_diff;        
	
        time_t m_anti_LastServerTime;           // last movement server time
        time_t m_anti_DeltaServerTime;          // server side session time
        time_t m_logfile_time;
        time_t m_logdb_time;

        uint32 m_anti_TeleToPlane_Count;        // Teleport To Plane alarm counter
		
		void CalcDeltas(MovementInfo& pNewPacket, MovementInfo& pOldPacket);
		void CalcVariables(MovementInfo& pOldPacket, MovementInfo& pNewPacket, Unit* mover);
        bool CanFly(MovementInfo& pMovementInfo);
		
		bool CheckAntiMultiJump(MovementInfo& pNewPacket, uint32 uiOpcode);
        bool CheckAntiSpeed(MovementInfo& pOldPacket, MovementInfo& pNewPacket, uint32 uiOpcode);
        bool CheckAntiTele(MovementInfo& pNewPacket, uint32 uiOpcode);
		bool CheckAntiFly(MovementInfo& pOldPacket, MovementInfo& pNewPacket);
		bool CheckAntiWaterwalk(MovementInfo& pOldPacket, MovementInfo& pNewPacket);
		bool CheckAntiTeleToPlane(MovementInfo& pOldPacket, MovementInfo& pNewPacket);
        bool CheckAntiClimb(MovementInfo& pOldPacket, MovementInfo& pNewPacket, uint32 uiOpcode);
        void LogCheat(eCheat /*m_cheat*/, MovementInfo& /*pMovementInfo*/);
        bool AntiCheatPunisher();
        inline bool ControllPunisher();
	
    public:
        AntiCheat(Player* new_plMover);
		bool DoAntiCheatCheck(uint16 /*opcode*/, MovementInfo& /*pMovementInfo*/, Unit* /*mover*/);
	
        void UpdateDiffAntiCheat(uint32 diff);
        void UpdateAntiCheat();
		void SetAlarm(uint32 delta);
        int32 GetDelta();
        void SetSleep(uint32 delta);
        void ResetCheatList(uint32 /*diff*/);
        void SaveLastPacket(MovementInfo& pMovementInfo) { lastpMovementInfo = pMovementInfo; }
        MovementInfo& GetLastPacket() { return lastpMovementInfo; }
        void SetLastOpcode(uint32 uiOpcode) { uiLastOpcode = uiOpcode; }
        uint32 GetLastOpcode() { return uiLastOpcode; }

        void CheckWarden(eWardenCheat wardCheat, uint8 wardenType);
};

#endif