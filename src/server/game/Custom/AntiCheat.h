#ifndef ANTI_CHEAT_H
#define ANTI_CHEAT_H

/**
 *
 * @File : AntiCheat.h
 *
 * @Authors : Lazzalf based on AC2
 *
 **/

#include "Common.h"
#include "WorldSession.h"

#define FROSTBROOD_VANQUISHER 28670

enum eCheat
{
	CHEAT_MISTIMING = 0,
	CHEAT_GRAVITY,
	CHEAT_MULTIJUMP,
	CHEAT_SPEED,
	CHEAT_TELEPORT,
	CHEAT_MOUNTAIN,
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

class AntiCheat_Local
{
	private:
		bool ac_block;        
		int32 ac_delta;

	public:
		AntiCheat_Local();

        bool ac_find_cheat;
        int32 ac_goactivate;

        uint32 m_CheatList[MAX_CHEAT];
        uint32 m_CheatList_reset_diff;
	
		time_t m_anti_LastClientTime;           // last movement client time
        time_t m_anti_LastServerTime;           // last movement server time
        time_t m_anti_DeltaClientTime;          // client side session time
        time_t m_anti_DeltaServerTime;          // server side session time
        uint32 m_anti_MistimingCount;           // mistiming count
        time_t m_logfile_time;
        time_t m_logdb_time;        

        time_t m_anti_LastSpeedChangeTime;      // last speed change time

        float m_anti_Last_HSpeed;               // horizontal speed, default RUN speed
        float m_anti_Last_VSpeed;               // vertical speed, default max jump height

        uint32 m_anti_TeleToPlane_Count;        // Teleport To Plane alarm counter

        uint64 m_anti_AlarmCount;               // alarm counter

        uint16 m_anti_JumpCount;                // Jump already began, anti air jump check
        float m_anti_JumpBaseZ;                 // Z coord before jump
		
		void SetBlock(bool /*block*/);
		bool GetBlock();
		bool GetAndUpdateDelta(int32 /*diff*/);
		void SetDelta(int32 /*delta*/);
        void ResetCheatList(uint32 /*diff*/);
};

class AntiCheat
{        
	private: 
        bool cheat_find;

		// Delthas
		int32 cClientTimeDelta;
		uint64 cServerTime;		
		uint32 cServerTimeDelta;
		int32 sync_time;
        uint32 difftime_log_file;
        uint32 difftime_log_db;

		// Variables
		float current_speed;
		uint32 vehicleEntry;		
		float delta_x;
		float delta_y;
		float delta_z;
		float real_delta;
		bool no_fly_auras;
		bool no_fly_flags;
		bool no_swim_flags;
		bool no_swim_in_water;
		bool no_swim_above_water;
		bool no_swim_water;
		bool no_waterwalk_flags;
		bool no_waterwalk_auras;
		float time_delta;
		float tg_z;
		float allowed_delta;
		float JumpHeight;
		
		void CalcDeltas(Player* /*plMover*/, MovementInfo& /*movementInfo*/);
		void CalcVariables(Player* /*plMover*/, MovementInfo& /*movementInfo*/, Unit* /*mover*/);
        void CalcVariablesSmall(Player* /*plMover*/, MovementInfo& /*movementInfo*/, Unit* /*mover*/);
		
		bool CheckMistiming(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
		bool CheckAntiGravity(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
		bool CheckAntiMultiJump(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
		bool CheckAntiSpeedTeleport(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
		bool CheckAntiMountain(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
		bool CheckAntiFly(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
		bool CheckAntiWaterwalk(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
		bool CheckAntiTeleToPlane(Player* /*plMover*/, Vehicle* /*vehMover*/, MovementInfo& /*movementInfo*/);
        void LogCheat(eCheat /*m_cheat*/, Player* /*plMover*/, MovementInfo& /*movementInfo*/);
        bool AntiCheatPunisher(Player* /*plMover*/, MovementInfo& /*movementInfo*/);
        inline bool ControllPunisher(Player* /*plMover*/);
	
    public:
        AntiCheat();
		bool Check(Player* /*plMover*/, Vehicle* /*vehMover*/, uint16 /*opcode*/, MovementInfo& /*movementInfo*/, Unit* /*mover*/);		
};

#endif