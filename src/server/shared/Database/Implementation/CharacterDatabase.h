/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
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

#ifndef _CHARACTERDATABASE_H
#define _CHARACTERDATABASE_H

#include "DatabaseWorkerPool.h"
#include "MySQLConnection.h"

class CharacterDatabaseConnection : public MySQLConnection
{
    public:
        //- Constructors for sync and async connections
        CharacterDatabaseConnection(MySQLConnectionInfo& connInfo) : MySQLConnection(connInfo) {}
        CharacterDatabaseConnection(ACE_Activation_Queue* q, MySQLConnectionInfo& connInfo) : MySQLConnection(q, connInfo) {}

        //- Loads databasetype specific prepared statements
        bool Open();
};

typedef DatabaseWorkerPool<CharacterDatabaseConnection> CharacterDatabaseWorkerPool;

enum CharacterDatabaseStatements
{
    /*  Naming standard for defines:
        {DB}_{SET/DEL/ADD/REP}_{Summary of data changed}
        When updating more than one field, consider looking at the calling function
        name for a suiting suffix.
    */

    CHAR_DEL_QUEST_POOL_SAVE,
    CHAR_ADD_QUEST_POOL_SAVE,
    CHAR_DEL_OLD_GUILD_EVENT_LOGS,
    CHAR_DEL_OLD_GUILD_BANK_EVENT_LOGS,
    CHAR_DEL_NONEXISTENT_GUILD_BANK_ITEM,
    CHAR_DEL_NONEXISTENT_CHARACTER_GROUP_MEMBERS,
    CHAR_DEL_LEADERLESS_GROUPS,
    CHAR_DEL_TINY_GROUPS,
    CHAR_DEL_NONEXISTENT_GROUP_MEMBERS,
    CHAR_DEL_NONEXISTENT_GROUP_INSTANCES,
    CHAR_DEL_EXPIRED_BANS,
    CHAR_GET_GUID_BY_NAME,
    CHAR_ADD_BAN,
    CHAR_SET_NOT_BANNED,
    CHAR_GET_BANINFO,
    CHAR_GET_GUID_BY_NAME_FILTER,
    CHAR_GET_BANINFO_LIST,
    CHAR_GET_BANNED_NAME,
    CHAR_LOAD_PLAYER,
    CHAR_LOAD_PLAYER_GROUP,
    CHAR_LOAD_PLAYER_BOUNDINSTANCES,
    CHAR_LOAD_PLAYER_AURAS,
    CHAR_LOAD_PLAYER_SPELLS,
    CHAR_LOAD_PLAYER_QUESTSTATUS,
    CHAR_LOAD_PLAYER_DAILYQUESTSTATUS,
    CHAR_LOAD_PLAYER_WEKLYQUESTSTATUS,
    CHAR_LOAD_PLAYER_REPUTATION,
    CHAR_LOAD_PLAYER_INVENTORY,
    CHAR_LOAD_PLAYER_ACTIONS,
    CHAR_LOAD_PLAYER_ACTIONS_SPEC,
    CHAR_LOAD_PLAYER_MAILCOUNT,
    CHAR_LOAD_PLAYER_MAILDATE,
    CHAR_LOAD_PLAYER_SOCIALLIST,
    CHAR_LOAD_PLAYER_HOMEBIND,
    CHAR_LOAD_PLAYER_SPELLCOOLDOWNS,
    CHAR_LOAD_PLAYER_DECLINEDNAMES,
    CHAR_LOAD_PLAYER_GUILD,
    CHAR_LOAD_PLAYER_ARENAINFO,
    CHAR_LOAD_PLAYER_ACHIEVEMENTS,
    CHAR_LOAD_PLAYER_CRITERIAPROGRESS,
    CHAR_LOAD_PLAYER_EQUIPMENTSETS,
    CHAR_LOAD_PLAYER_BGDATA,
    CHAR_LOAD_PLAYER_GLYPHS,
    CHAR_LOAD_PLAYER_TALENTS,
    CHAR_LOAD_PLAYER_ACCOUNTDATA,
    CHAR_LOAD_PLAYER_SKILLS,
    CHAR_LOAD_PLAYER_RANDOMBG,
    CHAR_LOAD_PLAYER_ARENASTATS,
    CHAR_LOAD_PLAYER_BANNED,
    CHAR_LOAD_ACCOUNT_DATA,
    CHAR_LOAD_PLAYER_MAILITEMS,
    CHAR_LOAD_AUCTION_ITEMS,
    CHAR_ADD_AUCTION,
    CHAR_DEL_AUCTION,
    CHAR_LOAD_AUCTIONS,
    CHAR_ADD_MAIL,
    CHAR_DEL_MAIL,
    CHAR_ADD_MAIL_ITEM,
    CHAR_DEL_EMPTY_EXPIRED_MAIL,
    CHAR_GET_EXPIRED_MAIL,
    CHAR_GET_MAIL_ITEM_LITE,
    CHAR_SET_MAIL_RETURNED,
    CHAR_SET_MAIL_ITEM_RECEIVER,
    CHAR_SET_ITEM_OWNER,
    CHAR_LOAD_GUILD_BANK_ITEMS,
    CHAR_LOAD_ITEM_REFUNDS,
    CHAR_LOAD_ITEM_BOP_TRADE,
    CHAR_DEL_ITEM_BOP_TRADE,
    CHAR_ADD_ITEM_BOP_TRADE,
    CHAR_ADD_INVENTORY_ITEM,
    CHAR_UPDATE_INVENTORY_ITEM,
    CHAR_DEL_INVENTORY_ITEM,
    CHAR_ADD_ITEM_INSTANCE,
    CHAR_UPDATE_ITEM_INSTANCE,
    CHAR_UPDATE_ITEM_INSTANCE_ON_LOAD,
    CHAR_DEL_ITEM_INSTANCE,
    CHAR_UPDATE_GIFT_OWNER,
    CHAR_DEL_GIFT,
    CHAR_GET_ACCOUNT_BY_NAME,

    CHAR_ADD_GUILD,
    CHAR_DEL_GUILD,
    CHAR_ADD_GUILD_MEMBER,
    CHAR_DEL_GUILD_MEMBER,
    CHAR_DEL_GUILD_MEMBERS,
    CHAR_ADD_GUILD_RANK,
    CHAR_DEL_GUILD_RANKS,
    CHAR_DEL_GUILD_LOWEST_RANK,
    CHAR_ADD_GUILD_BANK_TAB,
    CHAR_DEL_GUILD_BANK_TAB,
    CHAR_DEL_GUILD_BANK_TABS,
    CHAR_ADD_GUILD_BANK_ITEM,
    CHAR_DEL_GUILD_BANK_ITEM,
    CHAR_DEL_GUILD_BANK_ITEMS,
    CHAR_ADD_GUILD_BANK_RIGHT_DEFAULT,
    CHAR_ADD_GUILD_BANK_RIGHT,
    CHAR_DEL_GUILD_BANK_RIGHT,
    CHAR_DEL_GUILD_BANK_RIGHTS,
    CHAR_DEL_GUILD_BANK_RIGHTS_FOR_RANK,
    CHAR_ADD_GUILD_BANK_EVENTLOG,
    CHAR_DEL_GUILD_BANK_EVENTLOG,
    CHAR_DEL_GUILD_BANK_EVENTLOGS,
    CHAR_ADD_GUILD_EVENTLOG,
    CHAR_DEL_GUILD_EVENTLOG,
    CHAR_DEL_GUILD_EVENTLOGS,
    CHAR_SET_GUILD_MEMBER_PNOTE,
    CHAR_SET_GUILD_MEMBER_OFFNOTE,
    CHAR_SET_GUILD_MEMBER_RANK,
    CHAR_SET_GUILD_MOTD,
    CHAR_SET_GUILD_INFO,
    CHAR_SET_GUILD_LEADER,
    CHAR_SET_GUILD_RANK_NAME,
    CHAR_SET_GUILD_RANK_RIGHTS,
    CHAR_SET_GUILD_EMBLEM_INFO,
    CHAR_SET_GUILD_BANK_TAB_INFO,
    CHAR_SET_GUILD_BANK_MONEY,
    CHAR_SET_GUILD_BANK_EVENTLOG_TAB,
    CHAR_SET_GUILD_MEMBER_BANK_REM_MONEY,
    CHAR_SET_GUILD_MEMBER_BANK_TIME_MONEY,
    CHAR_RESET_GUILD_RANK_BANK_RESET_TIME,
    CHAR_SET_GUILD_RANK_BANK_MONEY,
    CHAR_SET_GUILD_BANK_TAB_TEXT,
    CHAR_SET_GUILD_MEMBER_BANK_TIME_REM_SLOTS0,
    CHAR_SET_GUILD_MEMBER_BANK_TIME_REM_SLOTS1,
    CHAR_SET_GUILD_MEMBER_BANK_TIME_REM_SLOTS2,
    CHAR_SET_GUILD_MEMBER_BANK_TIME_REM_SLOTS3,
    CHAR_SET_GUILD_MEMBER_BANK_TIME_REM_SLOTS4,
    CHAR_SET_GUILD_MEMBER_BANK_TIME_REM_SLOTS5,
    CHAR_SET_GUILD_MEMBER_BANK_REM_SLOTS0,
    CHAR_SET_GUILD_MEMBER_BANK_REM_SLOTS1,
    CHAR_SET_GUILD_MEMBER_BANK_REM_SLOTS2,
    CHAR_SET_GUILD_MEMBER_BANK_REM_SLOTS3,
    CHAR_SET_GUILD_MEMBER_BANK_REM_SLOTS4,
    CHAR_SET_GUILD_MEMBER_BANK_REM_SLOTS5,
    CHAR_RESET_GUILD_RANK_BANK_TIME0,
    CHAR_RESET_GUILD_RANK_BANK_TIME1,
    CHAR_RESET_GUILD_RANK_BANK_TIME2,
    CHAR_RESET_GUILD_RANK_BANK_TIME3,
    CHAR_RESET_GUILD_RANK_BANK_TIME4,
    CHAR_RESET_GUILD_RANK_BANK_TIME5,
    CHAR_LOAD_GUILDS,
    CHAR_LOAD_GUILD_RANKS,
    CHAR_LOAD_CHAR_DATA_FOR_GUILD,
    CHAR_LOAD_GUILD_MEMBERS,
    CHAR_LOAD_GUILD_BANK_RIGHTS,
    CHAR_LOAD_GUILD_BANK_TABS,
    CHAR_LOAD_GUILD_EVENTLOGS,
    CHAR_LOAD_GUILD_BANK_EVENTLOGS,
    CHAR_CLEAN_GUILD_RANKS,
    CHAR_CLEAN_GUILD_MEMBERS,
    CHAR_CLEAN_GUILD_BANK_TABS,
    CHAR_CLEAN_GUILD_BANK_RIGHTS,
    CHAR_CLEAN_GUILD_BANK_ITEMS,

    CHAR_DEL_GAMEOBJECT_RESPAWN_TIMES,
    CHAR_DEL_CRESPAWNTIME,
    CHAR_ADD_CRESPAWNTIME,

    CHAR_LOAD_CHANNEL,
    CHAR_ADD_CHANNEL,
    CHAR_SET_CHANNEL,
    CHAR_SET_CHANNEL_USAGE,
    CHAR_CLEAN_CHANNEL,

    CHAR_SET_EQUIP_SET,
    CHAR_ADD_EQUIP_SET,
    CHAR_DEL_EQUIP_SET,

    CHAR_DEL_AURA,
    CHAR_ADD_AURA,

    MAX_CHARACTERDATABASE_STATEMENTS,
};

#endif
