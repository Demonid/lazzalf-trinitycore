/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#ifndef TRINITYCORE_GUILD_H
#define TRINITYCORE_GUILD_H

#include "World.h"
#include "Item.h"
#include "WorldPacket.h"
#include "ObjectMgr.h"
#include "Player.h"

class Item;

enum GuildMisc
{
    GUILD_BANK_MAX_TABS                 = 6,                    // send by client for money log also
    GUILD_BANK_MAX_SLOTS                = 98,
    GUILD_BANK_MONEY_LOGS_TAB           = 100,                  // used for money log in DB
    GUILD_RANKS_MIN_COUNT               = 5,
    GUILD_RANKS_MAX_COUNT               = 10,
    GUILD_RANK_NONE                     = 0xFF,
    GUILD_WITHDRAW_MONEY_UNLIMITED      = 0xFFFFFFFF,
    GUILD_WITHDRAW_SLOT_UNLIMITED       = 0xFFFFFFFF,
    GUILD_EVENT_LOG_GUID_UNDEFINED      = 0xFFFFFFFF,
};

enum GuildDefaultRanks
{
    // These ranks can be modified, but they cannot be deleted
    GR_GUILDMASTER  = 0,
    GR_OFFICER      = 1,
    GR_VETERAN      = 2,
    GR_MEMBER       = 3,
    GR_INITIATE     = 4,
    // When promoting member server does: rank--
    // When demoting member server does: rank++
};

enum GuildRankRights
{
    GR_RIGHT_EMPTY              = 0x00000040,
    GR_RIGHT_GCHATLISTEN        = GR_RIGHT_EMPTY | 0x00000001,
    GR_RIGHT_GCHATSPEAK         = GR_RIGHT_EMPTY | 0x00000002,
    GR_RIGHT_OFFCHATLISTEN      = GR_RIGHT_EMPTY | 0x00000004,
    GR_RIGHT_OFFCHATSPEAK       = GR_RIGHT_EMPTY | 0x00000008,
    GR_RIGHT_INVITE             = GR_RIGHT_EMPTY | 0x00000010,
    GR_RIGHT_REMOVE             = GR_RIGHT_EMPTY | 0x00000020,
    GR_RIGHT_PROMOTE            = GR_RIGHT_EMPTY | 0x00000080,
    GR_RIGHT_DEMOTE             = GR_RIGHT_EMPTY | 0x00000100,
    GR_RIGHT_SETMOTD            = GR_RIGHT_EMPTY | 0x00001000,
    GR_RIGHT_EPNOTE             = GR_RIGHT_EMPTY | 0x00002000,
    GR_RIGHT_VIEWOFFNOTE        = GR_RIGHT_EMPTY | 0x00004000,
    GR_RIGHT_EOFFNOTE           = GR_RIGHT_EMPTY | 0x00008000,
    GR_RIGHT_MODIFY_GUILD_INFO  = GR_RIGHT_EMPTY | 0x00010000,
    GR_RIGHT_WITHDRAW_GOLD_LOCK = 0x00020000,                   // remove money withdraw capacity
    GR_RIGHT_WITHDRAW_REPAIR    = 0x00040000,                   // withdraw for repair
    GR_RIGHT_WITHDRAW_GOLD      = 0x00080000,                   // withdraw gold
    GR_RIGHT_CREATE_GUILD_EVENT = 0x00100000,                   // wotlk
    GR_RIGHT_ALL                = 0x001DF1FF
};

enum GuildCommandType
{
    GUILD_CREATE_S  = 0x00,
    GUILD_INVITE_S  = 0x01,
    GUILD_QUIT_S    = 0x03,
    GUILD_FOUNDER_S = 0x0E,
    GUILD_UNK1      = 0x13,
    GUILD_UNK2      = 0x14
};

enum GuildCommandError
{
    ERR_PLAYER_NO_MORE_IN_GUILD     = 0x00,
    ERR_GUILD_INTERNAL              = 0x01,
    ERR_ALREADY_IN_GUILD            = 0x02,
    ERR_ALREADY_IN_GUILD_S          = 0x03,
    ERR_INVITED_TO_GUILD            = 0x04,
    ERR_ALREADY_INVITED_TO_GUILD_S  = 0x05,
    ERR_GUILD_NAME_INVALID          = 0x06,
    ERR_GUILD_NAME_EXISTS_S         = 0x07,
    ERR_GUILD_LEADER_LEAVE          = 0x08,
    ERR_GUILD_PERMISSIONS           = 0x08,
    ERR_GUILD_PLAYER_NOT_IN_GUILD   = 0x09,
    ERR_GUILD_PLAYER_NOT_IN_GUILD_S = 0x0A,
    ERR_GUILD_PLAYER_NOT_FOUND_S    = 0x0B,
    ERR_GUILD_NOT_ALLIED            = 0x0C,
    ERR_GUILD_RANK_TOO_HIGH_S       = 0x0D,
    ERR_GUILD_RANK_TOO_LOW_S        = 0x0E,
    ERR_GUILD_RANKS_LOCKED          = 0x11,
    ERR_GUILD_RANK_IN_USE           = 0x12,
    ERR_GUILD_IGNORING_YOU_S        = 0x13,
    ERR_GUILD_UNK1                  = 0x14,
    ERR_GUILD_WITHDRAW_LIMIT        = 0x19,
    ERR_GUILD_NOT_ENOUGH_MONEY      = 0x1A,
    ERR_GUILD_BANK_FULL             = 0x1C,
    ERR_GUILD_ITEM_NOT_FOUND        = 0x1D
};

enum GuildEvents
{
    GE_PROMOTION                    = 0x00,
    GE_DEMOTION                     = 0x01,
    GE_MOTD                         = 0x02,
    GE_JOINED                       = 0x03,
    GE_LEFT                         = 0x04,
    GE_REMOVED                      = 0x05,
    GE_LEADER_IS                    = 0x06,
    GE_LEADER_CHANGED               = 0x07,
    GE_DISBANDED                    = 0x08,
    GE_TABARDCHANGE                 = 0x09,
    GE_UNK1                         = 0x0A,                 // string, string EVENT_GUILD_ROSTER_UPDATE tab content change?
    GE_UNK2                         = 0x0B,                 // EVENT_GUILD_ROSTER_UPDATE
    GE_SIGNED_ON                    = 0x0C,                 // ERR_FRIEND_ONLINE_SS
    GE_SIGNED_OFF                   = 0x0D,                 // ERR_FRIEND_OFFLINE_S
    GE_GUILDBANK_BAGSLOTS_CHANGED   = 0x0E,                 // EVENT_GUILDBANK_BAGSLOTS_CHANGED
    GE_GUILDBANK_TAB_PURCHASED      = 0x0F,                 // EVENT_GUILDBANK_UPDATE_TABS
    GE_UNK5                         = 0x10,                 // EVENT_GUILDBANK_UPDATE_TABS
    GE_GUILDBANK_MONEY_UPDATE       = 0x11,                 // EVENT_GUILDBANK_UPDATE_MONEY, string 0000000000002710 is 1 gold
    GE_GUILDBANK_MONEY_WITHDRAWN    = 0x12,                 // MSG_GUILD_BANK_MONEY_WITHDRAWN
    GE_GUILDBANK_TEXT_CHANGED       = 0x13                  // EVENT_GUILDBANK_TEXT_CHANGED
};

enum PetitionTurns
{
    PETITION_TURN_OK                    = 0,
    PETITION_TURN_ALREADY_IN_GUILD      = 2,
    PETITION_TURN_NEED_MORE_SIGNATURES  = 4,
};

enum PetitionSigns
{
    PETITION_SIGN_OK                = 0,
    PETITION_SIGN_ALREADY_SIGNED    = 1,
    PETITION_SIGN_ALREADY_IN_GUILD  = 2,
    PETITION_SIGN_CANT_SIGN_OWN     = 3,
    PETITION_SIGN_NOT_SERVER        = 4,
};

enum GuildBankRights
{
    GUILD_BANK_RIGHT_VIEW_TAB       = 0x01,
    GUILD_BANK_RIGHT_PUT_ITEM       = 0x02,
    GUILD_BANK_RIGHT_UPDATE_TEXT    = 0x04,

    GUILD_BANK_RIGHT_DEPOSIT_ITEM   = GUILD_BANK_RIGHT_VIEW_TAB | GUILD_BANK_RIGHT_PUT_ITEM,
    GUILD_BANK_RIGHT_FULL           = 0xFF,
};

enum GuildBankEventLogTypes
{
    GUILD_BANK_LOG_DEPOSIT_ITEM     = 1,
    GUILD_BANK_LOG_WITHDRAW_ITEM    = 2,
    GUILD_BANK_LOG_MOVE_ITEM        = 3,
    GUILD_BANK_LOG_DEPOSIT_MONEY    = 4,
    GUILD_BANK_LOG_WITHDRAW_MONEY   = 5,
    GUILD_BANK_LOG_REPAIR_MONEY     = 6,
    GUILD_BANK_LOG_MOVE_ITEM2       = 7,
    GUILD_BANK_LOG_UNK1             = 8,
    GUILD_BANK_LOG_UNK2             = 9,
};

enum GuildEventLogTypes
{
    GUILD_EVENT_LOG_INVITE_PLAYER     = 1,
    GUILD_EVENT_LOG_JOIN_GUILD        = 2,
    GUILD_EVENT_LOG_PROMOTE_PLAYER    = 3,
    GUILD_EVENT_LOG_DEMOTE_PLAYER     = 4,
    GUILD_EVENT_LOG_UNINVITE_PLAYER   = 5,
    GUILD_EVENT_LOG_LEAVE_GUILD       = 6,
};

enum GuildEmblemError
{
    ERR_GUILDEMBLEM_SUCCESS               = 0,
    ERR_GUILDEMBLEM_INVALID_TABARD_COLORS = 1,
    ERR_GUILDEMBLEM_NOGUILD               = 2,
    ERR_GUILDEMBLEM_NOTGUILDMASTER        = 3,
    ERR_GUILDEMBLEM_NOTENOUGHMONEY        = 4,
    ERR_GUILDEMBLEM_INVALIDVENDOR         = 5
};

////////////////////////////////////////////////////////////////////////////////////////////
// Emblem info
class EmblemInfo
{
public:
    EmblemInfo() : m_style(0), m_color(0), m_borderStyle(0), m_borderColor(0), m_backgroundColor(0) { }

    void LoadFromDB(Field* fields);
    void SaveToDB(uint32 guildId) const;
    void ReadPacket(WorldPacket& recv) { recv >> m_style >> m_color >> m_borderStyle >> m_borderColor >> m_backgroundColor; }
    void WritePacket(WorldPacket& data) const;

    uint32 GetStyle() const { return m_style; }
    uint32 GetColor() const { return m_color; }
    uint32 GetBorderStyle() const { return m_borderStyle; }
    uint32 GetBorderColor() const { return m_borderColor; }
    uint32 GetBackgroundColor() const { return m_backgroundColor; }

private:
    uint32 m_style;
    uint32 m_color;
    uint32 m_borderStyle;
    uint32 m_borderColor;
    uint32 m_backgroundColor;
};

// Structure for storing guild bank rights and remaining slots together.
struct GuildBankRightsAndSlots
{
    GuildBankRightsAndSlots() : rights(0), slots(0) { }
    GuildBankRightsAndSlots(uint8 _rights, uint32 _slots) : rights(_rights), slots(_slots) { }

    inline bool IsEqual(GuildBankRightsAndSlots const& rhs) const { return rights == rhs.rights && slots == rhs.slots; }
    void SetGuildMasterValues()
    {
        rights = GUILD_BANK_RIGHT_FULL;
        slots = uint32(GUILD_WITHDRAW_SLOT_UNLIMITED);
    }

    uint8  rights;
    uint32 slots;
};
typedef std::vector <GuildBankRightsAndSlots> GuildBankRightsAndSlotsVec;

typedef std::set <uint8> SlotIds;

class Guild
{
private:
    // Class representing guild member
    class Member
    {
        struct RemainingValue
        {
            RemainingValue() : value(0), resetTime(0) { }

            uint32 value;
            uint32 resetTime;
        };

    public:
        Member(uint32 guildId, uint64 guid, uint8 rankId) : m_guildId(guildId), m_guid(guid), m_logoutTime(::time(NULL)), m_rankId(rankId) { }

        void SetStats(Player* player);
        void SetStats(const std::string& name, uint8 level, uint8 _class, uint32 zoneId, uint32 accountId);
        bool CheckStats() const;

        void SetPublicNote(const std::string& publicNote);
        void SetOfficerNote(const std::string& officerNote);

        bool LoadFromDB(Field* fields);
        void SaveToDB(SQLTransaction& trans) const;
        void WritePacket(WorldPacket& data) const;

        uint64 GetGUID() const { return m_guid; }
        std::string GetName() const { return m_name; }
        uint32 GetAccountId() const { return m_accountId; }
        uint8 GetRankId() const { return m_rankId; }

        void ChangeRank(uint8 newRank);

        inline void UpdateLogoutTime() { m_logoutTime = ::time(NULL); }
        inline bool IsRank(uint8 rankId) const { return m_rankId == rankId; }
        inline bool IsRankNotLower(uint8 rankId) const { return m_rankId <= rankId; }
        inline bool IsSamePlayer(uint64 guid) const { return m_guid == guid; }

        void DecreaseBankRemainingValue(SQLTransaction& trans, uint8 tabId, uint32 amount);
        uint32 GetBankRemainingValue(uint8 tabId, const Guild* guild) const;

        void ResetTabTimes();
        void ResetMoneyTime();

        inline Player* FindPlayer() const { return ObjectAccessor::FindPlayer(m_guid); }

    private:
        uint32 m_guildId;
        // Fields from characters table
        uint64 m_guid;
        std::string m_name;
        uint32 m_zoneId;
        uint8  m_level;
        uint8  m_class;
        uint64 m_logoutTime;
        uint32 m_accountId;
        // Fields from guild_member table
        uint8  m_rankId;
        std::string m_publicNote;
        std::string m_officerNote;

        RemainingValue m_bankRemaining[GUILD_BANK_MAX_TABS + 1];
    };

    // Base class for event entries
    class LogEntry
    {
    public:
        LogEntry(uint32 guildId, uint32 guid) : m_guildId(guildId), m_guid(guid), m_timestamp(::time(NULL)) { }
        LogEntry(uint32 guildId, uint32 guid, time_t timestamp) : m_guildId(guildId), m_guid(guid), m_timestamp(timestamp) { }
        virtual ~LogEntry() { }

        uint32 GetGUID() const { return m_guid; }

        virtual void SaveToDB(SQLTransaction& trans) const = 0;
        virtual void WritePacket(WorldPacket& data) const = 0;

    protected:
        uint32 m_guildId;
        uint32 m_guid;
        uint64 m_timestamp;
    };

    // Event log entry
    class EventLogEntry : public LogEntry
    {
    public:
        EventLogEntry(uint32 guildId, uint32 guid, GuildEventLogTypes eventType, uint32 playerGuid1, uint32 playerGuid2, uint8 newRank) :
            LogEntry(guildId, guid), m_eventType(eventType), m_playerGuid1(playerGuid1), m_playerGuid2(playerGuid2), m_newRank(newRank) { }

        EventLogEntry(uint32 guildId, uint32 guid, time_t timestamp, GuildEventLogTypes eventType, uint32 playerGuid1, uint32 playerGuid2, uint8 newRank) :
            LogEntry(guildId, guid, timestamp), m_eventType(eventType), m_playerGuid1(playerGuid1), m_playerGuid2(playerGuid2), m_newRank(newRank) { }

        ~EventLogEntry() { }

        void SaveToDB(SQLTransaction& trans) const;
        void WritePacket(WorldPacket& data) const;

    private:
        GuildEventLogTypes m_eventType;
        uint32 m_playerGuid1;
        uint32 m_playerGuid2;
        uint8  m_newRank;
    };

    // Bank event log entry
    class BankEventLogEntry : public LogEntry
    {
    public:
        static bool IsMoneyEvent(GuildBankEventLogTypes eventType)
        {
            return
                eventType == GUILD_BANK_LOG_DEPOSIT_MONEY ||
                eventType == GUILD_BANK_LOG_WITHDRAW_MONEY ||
                eventType == GUILD_BANK_LOG_REPAIR_MONEY;
        }

        BankEventLogEntry(uint32 guildId, uint32 guid, GuildBankEventLogTypes eventType, uint8 tabId, uint32 playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId) :
            LogEntry(guildId, guid), m_eventType(eventType), m_bankTabId(tabId), m_playerGuid(playerGuid),
            m_itemOrMoney(itemOrMoney), m_itemStackCount(itemStackCount), m_destTabId(destTabId) { }

        BankEventLogEntry(uint32 guildId, uint32 guid, time_t timestamp, uint8 tabId, GuildBankEventLogTypes eventType, uint32 playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId) :
            LogEntry(guildId, guid, timestamp), m_eventType(eventType), m_bankTabId(tabId), m_playerGuid(playerGuid),
            m_itemOrMoney(itemOrMoney), m_itemStackCount(itemStackCount), m_destTabId(destTabId) { }

        ~BankEventLogEntry() { }

        void SaveToDB(SQLTransaction& trans) const;
        void WritePacket(WorldPacket& data) const;

    private:
        GuildBankEventLogTypes m_eventType;
        uint8  m_bankTabId;
        uint32 m_playerGuid;
        uint32 m_itemOrMoney;
        uint16 m_itemStackCount;
        uint8  m_destTabId;
    };

    // Class encapsulating work with events collection
    class LogHolder
    {
    public:
        LogHolder(uint32 guildId, uint32 maxRecords) : m_guildId(guildId), m_maxRecords(maxRecords), m_nextGUID(uint32(GUILD_EVENT_LOG_GUID_UNDEFINED)) { }
        ~LogHolder();

        uint8 GetSize() const { return uint8(m_log.size()); }
        // Checks if new log entry can be added to holder when loading from DB
        inline bool CanInsert() const { return m_log.size() < m_maxRecords; }
        // Adds event from DB to collection
        void LoadEvent(LogEntry* entry);
        // Adds new event to collection and saves it to DB
        void AddEvent(SQLTransaction& trans, LogEntry* entry);
        // Writes information about all events to packet
        void WritePacket(WorldPacket& data) const;
        uint32 GetNextGUID();

    private:
        typedef std::list<LogEntry*> GuildLog;
        GuildLog m_log;
        uint32 m_guildId;
        uint32 m_maxRecords;
        uint32 m_nextGUID;
    };

    // Class incapsulating guild rank data
    class RankInfo
    {
    public:
        RankInfo(uint32 guildId) : m_guildId(guildId), m_rankId(GUILD_RANK_NONE), m_rights(GR_RIGHT_EMPTY), m_bankMoneyPerDay(0) { }
        RankInfo(uint32 guildId, uint8 rankId, const std::string& name, uint32 rights, uint32 money) :
            m_guildId(guildId), m_rankId(rankId), m_name(name), m_rights(rights), m_bankMoneyPerDay(money) { }

        void LoadFromDB(Field* fields);
        void SaveToDB(SQLTransaction& trans) const;
        void WritePacket(WorldPacket& data) const;

        uint8 GetId() const { return m_rankId; }

        std::string GetName() const { return m_name; }
        void SetName(const std::string& name);

        uint32 GetRights() const { return m_rights; }
        void SetRights(uint32 rights);

        uint32 GetBankMoneyPerDay() const { return m_rankId == GR_GUILDMASTER ? GUILD_WITHDRAW_MONEY_UNLIMITED : m_bankMoneyPerDay; }
        void SetBankMoneyPerDay(uint32 money);

        inline uint8 GetBankTabRights(uint8 tabId) const { return tabId < GUILD_BANK_MAX_TABS ? m_bankTabRightsAndSlots[tabId].rights : 0; }
        inline uint32 GetBankTabSlotsPerDay(uint8 tabId) const
        {
            if (tabId < GUILD_BANK_MAX_TABS)
                return m_rankId == GR_GUILDMASTER ? GUILD_WITHDRAW_SLOT_UNLIMITED : m_bankTabRightsAndSlots[tabId].slots;
            return 0;
        }
        void SetBankTabSlotsAndRights(uint8 tabId, GuildBankRightsAndSlots rightsAndSlots, bool saveToDB);

    private:
        uint32 m_guildId;

        uint8  m_rankId;
        std::string m_name;
        uint32 m_rights;
        uint32 m_bankMoneyPerDay;
        GuildBankRightsAndSlots m_bankTabRightsAndSlots[GUILD_BANK_MAX_TABS];
    };

    class BankTab
    {
    public:
        BankTab(uint32 guildId, uint8 tabId) : m_guildId(guildId), m_tabId(tabId)
        {
            memset(m_items, 0, GUILD_BANK_MAX_SLOTS * sizeof(Item*));
        }

        bool LoadFromDB(Field* fields);
        bool LoadItemFromDB(Field* fields);
        void Delete(SQLTransaction& trans, bool removeItemsFromDB = false);

        void WritePacket(WorldPacket& data) const;
        void WriteSlotPacket(WorldPacket& data, uint8 slotId) const;
        void WriteInfoPacket(WorldPacket& data) const
        {
            data << m_name;
            data << m_icon;
        }

        void SetInfo(const std::string& name, const std::string& icon);
        void SetText(const std::string& text);
        void SendText(const Guild* guild, WorldSession* session) const;

        inline Item* GetItem(uint8 slotId) const { return slotId < GUILD_BANK_MAX_SLOTS ?  m_items[slotId] : NULL; }
        bool SetItem(SQLTransaction& trans, uint8 slotId, Item* pItem);

    private:
        uint32 m_guildId;
        uint8 m_tabId;

        Item* m_items[GUILD_BANK_MAX_SLOTS];
        std::string m_name;
        std::string m_icon;
        std::string m_text;
    };

    // Movement data
    class MoveItemData
    {
    public:
        MoveItemData(Guild* guild, Player* player, uint8 container, uint8 slotId) : m_pGuild(guild), m_pPlayer(player),
            m_container(container), m_slotId(slotId), m_pItem(NULL), m_pClonedItem(NULL) { }
        virtual ~MoveItemData() { }

        virtual bool IsBank() const = 0;
        // Initializes item pointer. Returns true, if item exists, false otherwise.
        virtual bool InitItem() = 0;
        // Checks splited amount against item. Splited amount cannot be more that number of items in stack.
        virtual bool CheckItem(uint32& splitedAmount);
        // Defines if player has rights to save item in container
        virtual bool HasStoreRights(MoveItemData* /*pOther*/) const { return true; }
        // Defines if player has rights to withdraw item from container
        virtual bool HasWithdrawRights(MoveItemData* /*pOther*/) const { return true; }
        // Checks if container can store specified item
        bool CanStore(Item* pItem, bool swap, bool sendError);
        // Clones stored item
        bool CloneItem(uint32 count);
        // Remove item from container (if splited update items fields)
        virtual void RemoveItem(SQLTransaction& trans, MoveItemData* pOther, uint32 splitedAmount = 0) = 0;
        // Saves item to container
        virtual Item* StoreItem(SQLTransaction& trans, Item* pItem) = 0;
        // Log bank event
        virtual void LogBankEvent(SQLTransaction& trans, MoveItemData* pFrom, uint32 count) const = 0;
        // Log GM action
        virtual void LogAction(MoveItemData* pFrom) const;
        // Copy slots id from position vector
        void CopySlots(SlotIds& ids) const;

        Item* GetItem(bool isCloned = false) const { return isCloned ? m_pClonedItem : m_pItem; }
        uint8 GetContainer() const { return m_container; }
        uint8 GetSlotId() const { return m_slotId; }
    protected:
        virtual InventoryResult CanStore(Item* pItem, bool swap) = 0;

        Guild* m_pGuild;
        Player* m_pPlayer;
        uint8 m_container;
        uint8 m_slotId;
        Item* m_pItem;
        Item* m_pClonedItem;
        ItemPosCountVec m_vec;
    };

    class PlayerMoveItemData : public MoveItemData
    {
    public:
        PlayerMoveItemData(Guild* guild, Player* player, uint8 container, uint8 slotId) :
            MoveItemData(guild, player, container, slotId) { }

        bool IsBank() const { return false; }
        bool InitItem();
        void RemoveItem(SQLTransaction& trans, MoveItemData* pOther, uint32 splitedAmount = 0);
        Item* StoreItem(SQLTransaction& trans, Item* pItem);
        void LogBankEvent(SQLTransaction& trans, MoveItemData* pFrom, uint32 count) const;
    protected:
        InventoryResult CanStore(Item* pItem, bool swap);
    };

    class BankMoveItemData : public MoveItemData
    {
    public:
        BankMoveItemData(Guild* guild, Player* player, uint8 container, uint8 slotId) :
            MoveItemData(guild, player, container, slotId) { }

        bool IsBank() const { return true; }
        bool InitItem();
        bool HasStoreRights(MoveItemData* pOther) const;
        bool HasWithdrawRights(MoveItemData* pOther) const;
        void RemoveItem(SQLTransaction& trans, MoveItemData* pOther, uint32 splitedAmount);
        Item* StoreItem(SQLTransaction& trans, Item* pItem);
        void LogBankEvent(SQLTransaction& trans, MoveItemData* pFrom, uint32 count) const;
        void LogAction(MoveItemData* pFrom) const;

    protected:
        InventoryResult CanStore(Item* pItem, bool swap);

    private:
        Item* _StoreItem(SQLTransaction& trans, BankTab* pTab, Item* pItem, ItemPosCount& pos, bool clone) const;
        bool _ReserveSpace(uint8 slotId, Item* pItem, Item* pItemDest, uint32& count);
        void CanStoreItemInTab(Item* pItem, uint8 skipSlotId, bool merge, uint32& count);
    };

    typedef UNORDERED_MAP<uint32, Member*> Members;
    typedef std::vector<RankInfo> Ranks;
    typedef std::vector<BankTab*> BankTabs;

public:
    static void SendCommandResult(WorldSession* session, GuildCommandType type, GuildCommandError errCode, const std::string& param = "");
    static void SendSaveEmblemResult(WorldSession* session, GuildEmblemError errCode);

    Guild();
    ~Guild();

    bool Create(Player* pLeader, const std::string& name);
    void Disband();

    // Getters
    uint32 GetId() const { return m_id; }
    uint64 GetLeaderGUID() const { return m_leaderGuid; }
    const std::string& GetName() const { return m_name; }
    const std::string& GetMOTD() const { return m_motd; }
    const std::string& GetInfo() const { return m_info; }

    // Handle client commands
    void HandleRoster(WorldSession* session = NULL);          // NULL = broadcast
    void HandleQuery(WorldSession* session);
    void HandleSetMOTD(WorldSession* session, const std::string& motd);
    void HandleSetInfo(WorldSession* session, const std::string& info);
    void HandleSetEmblem(WorldSession* session, const EmblemInfo& emblemInfo);
    void HandleSetLeader(WorldSession* session, const std::string& name);
    void HandleSetBankTabInfo(WorldSession* session, uint8 tabId, const std::string& name, const std::string& icon);
    void HandleSetMemberNote(WorldSession* session, const std::string& name, const std::string& note, bool officer);
    void HandleSetRankInfo(WorldSession* session, uint8 rankId, const std::string& name, uint32 rights, uint32 moneyPerDay, GuildBankRightsAndSlotsVec rightsAndSlots);
    void HandleBuyBankTab(WorldSession* session, uint8 tabId);
    void HandleInviteMember(WorldSession* session, const std::string& name);
    void HandleAcceptMember(WorldSession* session);
    void HandleLeaveMember(WorldSession* session);
    void HandleRemoveMember(WorldSession* session, const std::string& name);
    void HandleUpdateMemberRank(WorldSession* session, const std::string& name, bool demote);
    void HandleAddNewRank(WorldSession* session, const std::string& name);
    void HandleRemoveLowestRank(WorldSession* session);
    void HandleMemberDepositMoney(WorldSession* session, uint32 amount);
    bool HandleMemberWithdrawMoney(WorldSession* session, uint32 amount, bool repair = false);
    void HandleMemberLogout(WorldSession* session);
    void HandleDisband(WorldSession* session);

    // Send info to client
    void SendInfo(WorldSession* session) const;
    void SendEventLog(WorldSession* session) const;
    void SendBankLog(WorldSession* session, uint8 tabId) const;
    void SendBankTabsInfo(WorldSession* session) const;
    void SendBankTabData(WorldSession* session, uint8 tabId) const;
    void SendBankTabText(WorldSession* session, uint8 tabId) const;
    void SendPermissions(WorldSession* session) const;
    void SendMoneyInfo(WorldSession* session) const;
    void SendLoginInfo(WorldSession* session) const;

    // Load from DB
    bool LoadFromDB(Field* fields);
    void LoadRankFromDB(Field* fields);
    bool LoadMemberFromDB(Field* fields);
    bool LoadEventLogFromDB(Field* fields);
    void LoadBankRightFromDB(Field* fields);
    bool LoadBankTabFromDB(Field* fields);
    bool LoadBankEventLogFromDB(Field* fields);
    bool LoadBankItemFromDB(Field* fields);
    bool Validate();

    // Broadcasts
    void BroadcastToGuild(WorldSession* session, bool officerOnly, const std::string& msg, uint32 language = LANG_UNIVERSAL) const;
    void BroadcastPacketToRank(WorldPacket* packet, uint8 rankId) const;
    void BroadcastPacket(WorldPacket* packet) const;

    template<class Do>
    void BroadcastWorker(Do& _do, Player* except = NULL)
    {
        for (Members::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
            if (Player* player = itr->second->FindPlayer())
                if (player != except)
                    _do(player);
    }

    // Members
    // Adds member to guild. If rankId == GUILD_RANK_NONE, lowest rank is assigned.
    bool AddMember(uint64 guid, uint8 rankId = GUILD_RANK_NONE);
    void DeleteMember(uint64 guid, bool isDisbanding = false, bool isKicked = false);
    bool ChangeMemberRank(uint64 guid, uint8 newRank);

    // Bank
    void SwapItems(Player* player, uint8 tabId, uint8 slotId, uint8 destTabId, uint8 destSlotId, uint32 splitedAmount);
    void SwapItemsWithInventory(Player* player, bool toChar, uint8 tabId, uint8 slotId, uint8 playerBag, uint8 playerSlotId, uint32 splitedAmount);

    // Bank tabs
    void SetBankTabText(uint8 tabId, const std::string& text);

protected:
    uint32 m_id;
    std::string m_name;
    uint64 m_leaderGuid;
    std::string m_motd;
    std::string m_info;
    time_t m_createdDate;

    EmblemInfo m_emblemInfo;
    uint32 m_accountsNumber;
    uint64 m_bankMoney;

    Ranks m_ranks;
    Members m_members;
    BankTabs m_bankTabs;

    // These are actually ordered lists. The first element is the oldest entry.
    LogHolder* m_eventLog;
    LogHolder* m_bankEventLog[GUILD_BANK_MAX_TABS + 1];

private:
    inline uint8 _GetRanksSize() const { return uint8(m_ranks.size()); }
    inline const RankInfo* GetRankInfo(uint8 rankId) const { return rankId < _GetRanksSize() ? &m_ranks[rankId] : NULL; }
    inline RankInfo* GetRankInfo(uint8 rankId) { return rankId < _GetRanksSize() ? &m_ranks[rankId] : NULL; }
    inline bool _HasRankRight(Player* player, uint32 right) const { return (_GetRankRights(player->GetRank()) & right) != GR_RIGHT_EMPTY; }
    inline uint8 _GetLowestRankId() const { return uint8(m_ranks.size() - 1); }

    inline uint8 _GetPurchasedTabsSize() const { return uint8(m_bankTabs.size()); }
    inline BankTab* GetBankTab(uint8 tabId) { return tabId < m_bankTabs.size() ? m_bankTabs[tabId] : NULL; }
    inline const BankTab* GetBankTab(uint8 tabId) const { return tabId < m_bankTabs.size() ? m_bankTabs[tabId] : NULL; }

    inline const Member* GetMember(uint64 guid) const
    {
        Members::const_iterator itr = m_members.find(GUID_LOPART(guid));
        return itr != m_members.end() ? itr->second : NULL;
    }
    inline Member* GetMember(uint64 guid)
    {
        Members::iterator itr = m_members.find(GUID_LOPART(guid));
        return itr != m_members.end() ? itr->second : NULL;
    }
    inline Member* GetMember(WorldSession* session, const std::string& name)
    {
        for (Members::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
            if (itr->second->GetName() == name)
                return itr->second;

        SendCommandResult(session, GUILD_INVITE_S, ERR_GUILD_PLAYER_NOT_IN_GUILD_S, name);
        return NULL;
    }
    inline void _DeleteMemberFromDB(uint32 lowguid) const
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GUILD_MEMBER);
        stmt->setUInt32(0, lowguid);
        CharacterDatabase.Execute(stmt);
    }

    // Creates log holders (either when loading or when creating guild)
    void _CreateLogHolders();
    // Tries to create new bank tab
    bool _CreateNewBankTab();
    // Creates default guild ranks with names in given locale
    void _CreateDefaultGuildRanks(LocaleConstant loc);
    // Creates new rank
    void _CreateRank(const std::string& name, uint32 rights);
    // Update account number when member added/removed from guild
    void _UpdateAccountsNumber();
    bool _IsLeader(Player* player) const;
    void _DeleteBankItems(SQLTransaction& trans, bool removeItemsFromDB = false);
    bool _ModifyBankMoney(SQLTransaction& trans, uint64 amount, bool add);
    void _SetLeaderGUID(Member* pLeader);

    void _SetRankBankMoneyPerDay(uint8 rankId, uint32 moneyPerDay);
    void _SetRankBankTabRightsAndSlots(uint8 rankId, uint8 tabId, GuildBankRightsAndSlots rightsAndSlots, bool saveToDB = true);
    uint8 _GetRankBankTabRights(uint8 rankId, uint8 tabId) const;
    uint32 _GetRankRights(uint8 rankId) const;
    uint32 _GetRankBankMoneyPerDay(uint8 rankId) const;
    uint32 _GetRankBankTabSlotsPerDay(uint8 rankId, uint8 tabId) const;
    std::string _GetRankName(uint8 rankId) const;

    uint32 _GetMemberRemainingSlots(uint64 guid, uint8 tabId) const;
    uint32 _GetMemberRemainingMoney(uint64 guid) const;
    void _DecreaseMemberRemainingSlots(SQLTransaction& trans, uint64 guid, uint8 tabId);
    bool _MemberHasTabRights(uint64 guid, uint8 tabId, uint32 rights) const;

    void _LogEvent(GuildEventLogTypes eventType, uint32 playerGuid1, uint32 playerGuid2 = 0, uint8 newRank = 0);
    void _LogBankEvent(SQLTransaction& trans, GuildBankEventLogTypes eventType, uint8 tabId, uint32 playerGuid, uint32 itemOrMoney, uint16 itemStackCount = 0, uint8 destTabId = 0);

    Item* _GetItem(uint8 tabId, uint8 slotId) const;
    void _RemoveItem(SQLTransaction& trans, uint8 tabId, uint8 slotId);
    void _MoveItems(MoveItemData* pSrc, MoveItemData* pDest, uint32 splitedAmount);
    bool _DoItemsMove(MoveItemData* pSrc, MoveItemData* pDest, bool sendError, uint32 splitedAmount = 0);

    void _SendBankContent(WorldSession* session, uint8 tabId) const;
    void _SendBankMoneyUpdate(WorldSession* session) const;
    void _SendBankContentUpdate(MoveItemData* pSrc, MoveItemData* pDest) const;
    void _SendBankContentUpdate(uint8 tabId, SlotIds slots) const;

    void _BroadcastEvent(GuildEvents guildEvent, uint64 guid, const char* param1 = NULL, const char* param2 = NULL, const char* param3 = NULL) const;
};
#endif
