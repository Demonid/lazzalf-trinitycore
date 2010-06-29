/*
 * Copyright (C) 2009-2010 Trilogy <http://www.wowtrilogy.com/>
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

/**
 *
 * @File : GuildHouse_npc.cpp
 *
 * @Authors : ?
 * @Modific : Lazzalf
 *
 * @Date : 31/03/2010
 *
 * @Version : 0.1
 *
 **/

#include "ScriptPCH.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "World.h"
#include "Guild.h"
#include "GuildHouse.h"
#include "Zones/OutdoorPvPWG.h"
#include "OutdoorPvPMgr.h"

#define SPELL_ID_PASSIVE_RESURRECTION_SICKNESS 15007

#define MSG_GOSSIP_TELE          "Teletrasportami Alla sede di gilda"
#define MSG_GOSSIP_BUY           "Crea Sede di gilda"
#define MSG_GOSSIP_SELL          "Vendi sede di gilda"
#define MSG_GOSSIP_ADD           "Compra aggiunte per la sede di Gilda"
#define MSG_GOSSIP_NEXTPAGE      "Successivo -->"
#define MSG_GOSSIP_CLOSE         "Chiudi"
#define MSG_INCOMBAT             "Sei in combat!"
#define MSG_NOGUILDHOUSE         "La tua gilda non possiede una casa!"
#define MSG_NOFREEGH             "Purtroppo tutte le case sono occupate oppure non hai abbastanza membri per acquistarne una di quelle libere."
#define MSG_NOADDGH              "Non hai altre GHAdd da comprare"
#define MSG_ALREADYHAVEGH        "La tua gilda possiede gi� una sede. (%s)."
#define MSG_ALREADYHAVEGHADD     "La tua gilda possiede gi� questo GHAdd."
#define MSG_NOTENOUGHMONEY       "Non hai abbastanza soldi per acquistare. Hai bisogno di %u gold."
#define MSG_NOTENOUGHGUILDMEMBERS "Non hai abbastanza membri in gilda per acquistare la casa. Hai bisogno di %u membri."
#define MSG_GHOCCUPIED           "Sfortunatamente questa casa � gi� occupata."
#define MSG_CONGRATULATIONS      "Congratulazioni! La sede � stata creata."
#define MSG_SOLD                 "La gilda � stata venduta. ??? ???? %u ??????."
#define MSG_NOTINGUILD           "Non sei in nessuna gilda."
#define MSG_CONFIRM_BUY          "Conferma l'acquisto"
#define MSG_NEGATE_BUY           "Nega l'acquisto"

#define CODE_SELL                "SELL"
#define MSG_CODEBOX_SELL         "Scrivi \"" CODE_SELL "\" in maiuscolo per vendere la casa, dopo premi accept."

#define OFFSET_CONFIRM_BUY_ID_TO_ACTION       2000
#define OFFSET_CONFIRM_BUY_ADD_ID_TO_ACTION   5000
#define OFFSET_GH_ID_TO_ACTION                7000
#define OFFSET_SHOWBUY_FROM                   12000
#define OFFSET_GH_ADD_ID_TO_ACTION            17000
#define OFFSET_SHOWBUY_FROM_ADD               20000

#define ACTION_TELE               1001
#define ACTION_SHOW_BUYLIST       1002
#define ACTION_SELL_GUILDHOUSE    1003
#define ACTION_SHOW_BUYADD_LIST   1004
#define ACTION_CLOSE              1005
#define ACTION_NEGATE_BUY         1011
#define ACTION_NEGATE_BUY_ADD     1021

#define ICON_GOSSIP_BALOON       0
#define ICON_GOSSIP_WING         2
#define ICON_GOSSIP_BOOK         3
#define ICON_GOSSIP_WHEEL1       4
#define ICON_GOSSIP_WHEEL2       5
#define ICON_GOSSIP_GOLD         6
#define ICON_GOSSIP_BALOONDOTS   7
#define ICON_GOSSIP_TABARD       8
#define ICON_GOSSIP_XSWORDS      9

#define GOSSIP_COUNT_MAX         7

bool isPlayerGuildLeader(Player *player)
{
    return ((player->GetRank() == 0) && (player->GetGuildId() != 0));
}

bool isPlayerHasGuildhouseAdd(Player *player, Creature *_creature, uint32 add, bool whisper = false)
{
    uint32 guildadd = GHobj.GetGuildHouse_Add(player->GetGuildId());
    bool comprato = ((uint32(1) << (add - 1)) & guildadd);
    if(comprato)
    {         
        if (whisper)
        {            
            char msg[200];
            sprintf(msg, MSG_ALREADYHAVEGHADD);
            _creature->MonsterWhisper(msg, player->GetGUID());
        }        
        return true;
    }
    return false;
}

bool isPlayerHasGuildhouse(Player *player, Creature *_creature, bool whisper = false)
{
    QueryResult_AutoPtr result;

    result = WorldDatabase.PQuery("SELECT `comment` FROM `guildhouses` WHERE `guildId` = %u", player->GetGuildId());

    if (result)
    {
        if (whisper)
        {
            //whisper to player "already have etc..."
            Field *fields = result->Fetch();
            char msg[200];
            sprintf(msg, MSG_ALREADYHAVEGH, fields[0].GetString());
            _creature->MonsterWhisper(msg, player->GetGUID());
        }        
        return true;
    }
    return false;
}

void teleportPlayerToGuildHouse(Player *player, Creature *_creature)
{
    if (player->GetGuildId() == 0)
    {
        //if player has no guild
        _creature->MonsterWhisper(MSG_NOTINGUILD, player->GetGUID());
        return;
    }

    if (!player->getAttackers().empty())
    {
        //if player in combat
        _creature->MonsterSay(MSG_INCOMBAT, LANG_UNIVERSAL, 0);
        return;
    }

    float x, y, z, o;
    uint32 map;

    if (GHobj.GetGuildHouseLocation(player->GetGuildId(), x, y, z, o, map))
    {
        //teleport player to the specified location
        player->TeleportTo(map, x, y, z, o);
    }
    else
        _creature->MonsterWhisper(MSG_NOGUILDHOUSE, player->GetGUID());
}

bool showBuyList(Player *player, Creature *_creature, uint32 showFromId = 0)
{
    if (!player)
        return false;

    //show not occupied guildhouses

    QueryResult_AutoPtr result;

    uint32 guildsize = 1;

    Guild *guild = objmgr.GetGuildById(player->GetGuildId());
    if (guild)
        guildsize = guild->GetMemberSize();

    if (player->isGameMaster())
        guildsize = 20000;

    result = WorldDatabase.PQuery("SELECT `id`, `comment`, `price` FROM `guildhouses` WHERE `guildId` = 0 AND (`faction` = 3 OR `faction` = %u) AND `id` > %u AND `minguildsize` <= %u ORDER BY `id` ASC LIMIT %u",
        (player->GetTeam() == HORDE)?1:0, showFromId, guildsize, GOSSIP_COUNT_MAX);

    if (result)
    {
        uint32 guildhouseId = 0;
        std::string comment = "";
        uint32 price = 0;
        do
        {
            Field *fields = result->Fetch();

            guildhouseId = fields[0].GetInt32();
            comment = fields[1].GetString();
            price = fields[2].GetUInt32();
            
            std::stringstream complete_comment;
            complete_comment << "price " << price << " - " << comment;

            //send comment as a gossip item
            //transmit guildhouseId in Action variable
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_TABARD, complete_comment.str().c_str(), GOSSIP_SENDER_MAIN,
                guildhouseId + OFFSET_GH_ID_TO_ACTION);

        } while (result->NextRow());

        if (result->GetRowCount() == GOSSIP_COUNT_MAX)
        {
            //assume that we have additional page
            //add link to next GOSSIP_COUNT_MAX items
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_GOSSIP_NEXTPAGE, GOSSIP_SENDER_MAIN, 
                guildhouseId + OFFSET_SHOWBUY_FROM);
        }
        player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_GOSSIP_CLOSE, GOSSIP_SENDER_MAIN, 
            ACTION_CLOSE);

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());

        return true;
    } 
    else
    {
        if (showFromId == 0)
        {
            //all guildhouses are occupied
            _creature->MonsterWhisper(MSG_NOFREEGH, player->GetGUID());
            player->CLOSE_GOSSIP_MENU();
        } 
        else
        {
            //this condition occurs when COUNT(guildhouses) % GOSSIP_COUNT_MAX == 0
            //just show GHs from beginning
            showBuyList(player, _creature, 0);
        }
    }

    return false;
}

bool showBuyAddList(Player *player, Creature *_creature, uint32 showFromId = 0)
{
    if (!player)
        return false;

    QueryResult_AutoPtr result;

    uint32 guildsize = 1;
    uint32 guild_add = GHobj.GetGuildHouse_Add(player->GetGuildId());

    Guild *guild = objmgr.GetGuildById(player->GetGuildId());
    if (guild)
        guildsize = guild->GetMemberSize();

    if (player->isGameMaster())
        guildsize = 20000;
    
    result = WorldDatabase.PQuery("SELECT `add_type`, `comment`, `price` FROM `guildhouses_addtype` WHERE `minguildsize` <= %u AND `add_type` > %u ORDER BY `add_type` ASC LIMIT %u",
        guildsize, showFromId, GOSSIP_COUNT_MAX);
 
    if (result)
    {
        uint32 add_typeId = 0;
        std::string comment = "";
        uint32 price = 0;
        do
        {
            Field *fields = result->Fetch();

            add_typeId = fields[0].GetInt32();
            comment = fields[1].GetString();
            price = fields[2].GetUInt32();

            uint32 comprato = ((uint32(1) << (add_typeId - 1)) & guild_add);
            
            std::stringstream complete_comment;
            if(comprato)
                complete_comment << "(Comprato) "<< comment;
            else
                complete_comment << "price " << price << " - " << comment;

            //send comment as a gossip item
            //transmit guildhouseId in Action variable
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_TABARD, complete_comment.str().c_str(), GOSSIP_SENDER_MAIN,
                add_typeId + OFFSET_GH_ADD_ID_TO_ACTION);

        } while (result->NextRow());

        if (result->GetRowCount() == GOSSIP_COUNT_MAX)
        {
            //assume that we have additional page
            //add link to next GOSSIP_COUNT_MAX items
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_GOSSIP_NEXTPAGE, GOSSIP_SENDER_MAIN, 
                add_typeId + OFFSET_SHOWBUY_FROM_ADD);
        }       

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());

        return true;
    } 
    else
    {
        if (showFromId == 0)
        {
            //all no GhAdd to Show
            _creature->MonsterWhisper(MSG_NOADDGH, player->GetGUID());
            player->CLOSE_GOSSIP_MENU();
        } 
        else
        {
            //just show GHsAdd from beginning
            showBuyAddList(player, _creature, 0);
        }
    }
    return false;
}


bool confirmBuy(Player *player, Creature *_creature, uint32 guildhouseId)
{
    if (!player)
        return false;

    if (isPlayerHasGuildhouse(player, _creature, true))
    {
        //player already have GH
        return false;
    }

    player->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, MSG_CONFIRM_BUY, GOSSIP_SENDER_MAIN,
        guildhouseId + OFFSET_CONFIRM_BUY_ID_TO_ACTION);
    player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_NEGATE_BUY, GOSSIP_SENDER_MAIN, 
                ACTION_NEGATE_BUY);

    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());

    return true;
}

void buyGuildhouse(Player *player, Creature *_creature, uint32 guildhouseId)
{
    if (!player)
        return;

    if (isPlayerHasGuildhouse(player, _creature, true))
    {
        //player already have GH
        return;
    }

    QueryResult_AutoPtr result;

    result = WorldDatabase.PQuery("SELECT `price` FROM `guildhouses` WHERE `id` = %u AND `guildId` = 0" , guildhouseId);

    if (!result)
    {
        _creature->MonsterWhisper(MSG_GHOCCUPIED, player->GetGUID());
        return;
    }   
    
    Field *fields = result->Fetch();
    int32 price = fields[0].GetInt32();

    if (player->GetMoney() < price * 10000)
    {
        //show how much money player need to buy GH (in gold)
        char msg[200];
        sprintf(msg, MSG_NOTENOUGHMONEY, price);
        _creature->MonsterWhisper(msg, player->GetGUID());
        return;
    }

    GHobj.ChangeGuildHouse(player->GetGuildId(), guildhouseId);

    player->ModifyMoney(-(price*10000));
    _creature->MonsterSay(MSG_CONGRATULATIONS, LANG_UNIVERSAL, 0);    
}

bool confirmBuyAdd(Player *player, Creature *_creature, uint32 gh_Add)
{
    if (!player)
        return false;

    player->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, MSG_CONFIRM_BUY, GOSSIP_SENDER_MAIN,
        gh_Add + OFFSET_CONFIRM_BUY_ADD_ID_TO_ACTION);
    player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_NEGATE_BUY, GOSSIP_SENDER_MAIN, 
                ACTION_NEGATE_BUY_ADD);

    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());

    return true;
}

void buyGuildhouseAdd(Player *player, Creature *_creature, uint32 gh_Add)
{
    if (!player)
        return;

    if (isPlayerHasGuildhouseAdd(player, _creature, gh_Add, true))
    {
        //player already have GHAdd
        return;
    }

    QueryResult_AutoPtr result;
    result = WorldDatabase.PQuery("SELECT `price` FROM `guildhouses_addtype` WHERE `add_type` = %u ", gh_Add);
    if (!result)
    {
        return;
    }   
    
    Field *fields = result->Fetch();
    int32 price = fields[0].GetInt32();

    if (player->GetMoney() < price * 10000)
    {
        //show how much money player need to buy GH (in gold)
        char msg[200];
        sprintf(msg, MSG_NOTENOUGHMONEY, price);
        _creature->MonsterWhisper(msg, player->GetGUID());
        return;
    }

    GHobj.Add_GuildhouseAdd(player->GetGuildId(), gh_Add);

    player->ModifyMoney(-(price*10000));    
}

void sellGuildhouse(Player *player, Creature *_creature)
{
    if (isPlayerHasGuildhouse(player, _creature))
    {
        QueryResult_AutoPtr result;

        result = WorldDatabase.PQuery("SELECT `price` FROM `guildhouses` WHERE `guildId` = %u", player->GetGuildId());

        if (!result)
            return;
    
        Field *fields = result->Fetch();
        uint32 price = fields[0].GetUInt32();

        GHobj.ChangeGuildHouse(player->GetGuildId(),0);

        player->ModifyMoney(price*5000);

        //display message e.g. "here your money etc."
        char msg[200];
        sprintf(msg, MSG_SOLD, price / 2);
        _creature->MonsterWhisper(msg, player->GetGUID());
    }
}

bool GossipHello_guildmaster(Player *player, Creature *_creature)
{
    player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, MSG_GOSSIP_TELE, 
        GOSSIP_SENDER_MAIN, ACTION_TELE);

    if (isPlayerGuildLeader(player))
    {
        //show additional menu for guild leader
        player->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, MSG_GOSSIP_BUY, GOSSIP_SENDER_MAIN, ACTION_SHOW_BUYLIST);
        if (isPlayerHasGuildhouse(player, _creature))
        {
            //and additional for guildhouse owner
            player->PlayerTalkClass->GetGossipMenu().AddMenuItem(ICON_GOSSIP_GOLD, MSG_GOSSIP_SELL, GOSSIP_SENDER_MAIN, ACTION_SELL_GUILDHOUSE, MSG_CODEBOX_SELL, 0, true);
            player->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, MSG_GOSSIP_ADD, GOSSIP_SENDER_MAIN, ACTION_SHOW_BUYADD_LIST);
        }
    }
    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
    return true;
}


bool GossipSelect_guildmaster(Player *player, Creature *_creature, uint32 sender, uint32 action )
{
    if (sender != GOSSIP_SENDER_MAIN)
        return false;

    switch (action)
    {
        case ACTION_TELE:
            //teleport player to GH
            player->CLOSE_GOSSIP_MENU();
            teleportPlayerToGuildHouse(player, _creature);
            break;
        case ACTION_SHOW_BUYLIST:
            //show list of GHs which currently not occupied
            showBuyList(player, _creature);
            break;
        case ACTION_SHOW_BUYADD_LIST:
            //show list of GHs add
            showBuyAddList(player, _creature);
            break;
        case ACTION_CLOSE:
            player->CLOSE_GOSSIP_MENU();
            break;
        case ACTION_NEGATE_BUY:
            player->CLOSE_GOSSIP_MENU();
            break;
         case ACTION_NEGATE_BUY_ADD:
            player->CLOSE_GOSSIP_MENU();
            break;
        default:     
            if (action > OFFSET_SHOWBUY_FROM_ADD)
            {
                showBuyAddList(player, _creature, action - OFFSET_SHOWBUY_FROM_ADD);
            } 
            else if (action > OFFSET_GH_ADD_ID_TO_ACTION)
            {
                confirmBuyAdd(player, _creature, action - OFFSET_GH_ADD_ID_TO_ACTION);
            }
            else if (action > OFFSET_SHOWBUY_FROM)
            {
                showBuyList(player, _creature, action - OFFSET_SHOWBUY_FROM);
            } 
            else if (action > OFFSET_GH_ID_TO_ACTION)
            {
                confirmBuy(player, _creature, action - OFFSET_GH_ID_TO_ACTION);
            }
            else if (action > OFFSET_CONFIRM_BUY_ADD_ID_TO_ACTION)
            {
                //player clicked on buy list
                player->CLOSE_GOSSIP_MENU();
                //get guildhouseAddId from action
                //guildhouseAddId = action - OFFSET_CONFIRM_BUY_ADD_ID_TO_ACTION
                buyGuildhouseAdd(player, _creature, action - OFFSET_CONFIRM_BUY_ADD_ID_TO_ACTION);
            }
            else if (action > OFFSET_CONFIRM_BUY_ID_TO_ACTION)
            {
                //player clicked on buy list
                player->CLOSE_GOSSIP_MENU();
                //get guildhouseId from action
                //guildhouseId = action - OFFSET_CONFIRM_BUY_ID_TO_ACTION
                buyGuildhouse(player, _creature, action - OFFSET_CONFIRM_BUY_ID_TO_ACTION);
            }
            break;
    }
    
    return true;
}

bool GossipSelectWithCode_guildmaster( Player *player, Creature *_creature,
                                      uint32 sender, uint32 action, const char* sCode )
{
    if(sender == GOSSIP_SENDER_MAIN)
    {
        if(action == ACTION_SELL_GUILDHOUSE)
        {
            int i = -1;
            try
            {
                //compare code
                if (strlen(sCode) + 1 == sizeof CODE_SELL)
                    i = strcmp(CODE_SELL, sCode);

            } catch(char *str) {sLog.outErrorDb(str);}

            if (i == 0)
            {
                //right code
                sellGuildhouse(player, _creature);
            }
            player->CLOSE_GOSSIP_MENU();
            return true;
        }
    }
    return false;
}

/*########
# guild_guard
#########*/
#define SAY_AGGRO "Tu non fai parte di questa gilda!"
struct guild_guardAI : public ScriptedAI
{
    guild_guardAI(Creature *c) : ScriptedAI(c) {}

    uint32 Check_Timer;

    void Reset()
    {
        Check_Timer = 1000;
    }

    void EnterCombat(Unit* who)
    {
        if (who->isPet() && who->GetOwner())
        {
            me->Kill(who->GetOwner());
            me->Attack(who->GetOwner(), true);
        }
        me->MonsterYell(SAY_AGGRO, LANG_UNIVERSAL, 0);
    }

    void AttackStart(Unit *who) 
    {
        if (!who)
            return;

        if (who->GetTypeId() != TYPEID_PLAYER)
            return;

        uint32 guild =((Player*)who)->GetGuildId();

        uint32 guardguild = GHobj.GetGuildByGuardID(me->GetGUID());

        if ( guardguild && guild != guardguild && me->Attack(who, true) )
        {
            me->AddThreat(who, 0.0f);

            if (!me->isInCombat())
            {
                me->SetInCombatWith(who);                
            }
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!UpdateVictim())
            return;
        
        if (Check_Timer <= uiDiff)
        {
            me->Kill(me->getVictim());
        } else Check_Timer -= uiDiff;

        DoMeleeAttackIfReady();
    }           
};

CreatureAI* GetAI_guild_guardAI(Creature *_Creature)
{
    return new guild_guardAI(_Creature);
}

bool GossipHello_buffnpc(Player *player, Creature *_Creature)
{
    //player->SetTaxiCheater(true);

    // Main Menu for Alliance
    if ( player->GetTeam() == ALLIANCE )
    {
        player->ADD_GOSSIP_ITEM( 5, "Remove Res Sickness"                           , GOSSIP_SENDER_MAIN, 1180);
        //player->ADD_GOSSIP_ITEM( 5, "Give me gold"                                , GOSSIP_SENDER_MAIN, 1185);
        //player->ADD_GOSSIP_ITEM( 5, "Give me Soul Shards"                         , GOSSIP_SENDER_MAIN, 1190);
        player->ADD_GOSSIP_ITEM( 5, "Heal me please"                                , GOSSIP_SENDER_MAIN, 1195);
        player->ADD_GOSSIP_ITEM( 5, "Ritual of Souls please"                        , GOSSIP_SENDER_MAIN, 1200);
        player->ADD_GOSSIP_ITEM( 5, "Table please"                                  , GOSSIP_SENDER_MAIN, 1205);                     
        player->ADD_GOSSIP_ITEM( 5, "Buff me Arcane Intelect"                       , GOSSIP_SENDER_MAIN, 1210);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Mark of the Wild"                      , GOSSIP_SENDER_MAIN, 1215);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Thorns"                                , GOSSIP_SENDER_MAIN, 1220);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Sanctuary"         , GOSSIP_SENDER_MAIN, 1225);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Might"             , GOSSIP_SENDER_MAIN, 1230);
        //player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Light"             , GOSSIP_SENDER_MAIN, 1235);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Wisdom"            , GOSSIP_SENDER_MAIN, 1240);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Kings"             , GOSSIP_SENDER_MAIN, 1245);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Divine Spirit"                         , GOSSIP_SENDER_MAIN, 1250);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Shadow Protection"                     , GOSSIP_SENDER_MAIN, 1251);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Power Word: Fortitude"                 , GOSSIP_SENDER_MAIN, 1252);
    }
    else // Main Menu for Horde
    {
        player->ADD_GOSSIP_ITEM( 5, "Remove Res Sickness"                           , GOSSIP_SENDER_MAIN, 1180);
        //player->ADD_GOSSIP_ITEM( 5, "Give me gold"                                , GOSSIP_SENDER_MAIN, 1185);
        //player->ADD_GOSSIP_ITEM( 5, "Give me Soul Shards"                         , GOSSIP_SENDER_MAIN, 1190);
        player->ADD_GOSSIP_ITEM( 5, "Heal me please"                                , GOSSIP_SENDER_MAIN, 1195);
        player->ADD_GOSSIP_ITEM( 5, "Ritual of Souls please"                        , GOSSIP_SENDER_MAIN, 1200);
        player->ADD_GOSSIP_ITEM( 5, "Table please"                                  , GOSSIP_SENDER_MAIN, 1205);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Arcane Intelect"                       , GOSSIP_SENDER_MAIN, 1210);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Mark of the Wild"                      , GOSSIP_SENDER_MAIN, 1215);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Thorns"                                , GOSSIP_SENDER_MAIN, 1220);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Sanctuary"         , GOSSIP_SENDER_MAIN, 1225);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Might"             , GOSSIP_SENDER_MAIN, 1230);
        //player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Light"             , GOSSIP_SENDER_MAIN, 1235);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Wisdom"            , GOSSIP_SENDER_MAIN, 1240);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Kings"             , GOSSIP_SENDER_MAIN, 1245);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Divine Spirit"                         , GOSSIP_SENDER_MAIN, 1250);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Shadow Protection"                     , GOSSIP_SENDER_MAIN, 1251);
        player->ADD_GOSSIP_ITEM( 5, "Buff me Power Word: Fortitude"                 , GOSSIP_SENDER_MAIN, 1252);
    }

    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());

return true;
}

void SendDefaultMenu_buffnpc(Player *player, Creature *_Creature, uint32 action )
{
    // Not allow in combat
    if(!player->getAttackers().empty())
    {
        player->CLOSE_GOSSIP_MENU();
        _Creature->MonsterSay(MSG_INCOMBAT, LANG_UNIVERSAL, 0);
        return;
    }

    switch(action)
    {
        case 1180://Remove Res Sickness
            if(!player->HasAura(SPELL_ID_PASSIVE_RESURRECTION_SICKNESS,0)) 
            {
                GossipHello_buffnpc(player, _Creature);
                return;
            }

            _Creature->CastSpell(player,38588,false); // Healing effect
            player->RemoveAurasDueToSpell(SPELL_ID_PASSIVE_RESURRECTION_SICKNESS);
            player->CLOSE_GOSSIP_MENU();
            break;

        /*case 1185://Give me Gold
            _Creature->CastSpell(player,46642,false); // 5000 gold
        break;*/

        /*case 1190://Give me Soul Shards
            player->CastSpell(player,24827,false);
        break;*/

        case 1195: // Heal me please
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,/*38588*/25840,false);
            break;
        case 1200: // Ritual of Souls please
            player->CLOSE_GOSSIP_MENU();
            player->CastSpell(player,58889,false);
            break;
        case 1205: // Table please
            player->CLOSE_GOSSIP_MENU();
            player->CastSpell(player,58661,false);
            break;
        case 1210: // Buff me Arcane Intelect
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,42995,false);
            break;
        case 1215: // Buff me Mark of the Wild
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,48469,false);
            break;
        case 1220: // Buff me Thorns
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,26992,false);
            break;
        case 1225: // Buff me Greater Blessing of Sanctuary
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,25899,false);
            break;
        case 1230: // Buff me Greater Blessing of Might
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,48934,false);
            break;
        case 1235: // Buff me Greater Blessing of Light
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,27145,false);
            break;
        case 1240: // Buff me Greater Blessing of Wisdom
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,48938,false);
            break;
        case 1245: // Buff me Greater Blessing of Kings
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,25898,false);
            break;
        case 1250: // Buff me Divine Spirit
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,48073,false);
            break;
        case 1251: // Buff me Shadow Protection
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,48169,false);
            break;
        case 1252: // Buff me Power Word: Fortitude
            player->CLOSE_GOSSIP_MENU();
            _Creature->CastSpell(player,48161,false);
            break;
    }
}

bool GossipSelect_buffnpc(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    // Main menu
    if (sender == GOSSIP_SENDER_MAIN)
    SendDefaultMenu_buffnpc( player, _Creature, action );

return true;
}

bool GossipHello_portal_npc(Player *player, Creature *_Creature)
{ 
    player->ADD_GOSSIP_ITEM( 5, "Teleport Dalaran"              , GOSSIP_SENDER_MAIN, 1005);
    player->ADD_GOSSIP_ITEM( 5, "Teleport Shattrath"            , GOSSIP_SENDER_MAIN, 1010);
    player->ADD_GOSSIP_ITEM( 5, "Teleport Wintergrasp"          , GOSSIP_SENDER_MAIN, 1100);

    // Main Menu for Alliance
    if ( player->GetTeam() == ALLIANCE )
    {
        player->ADD_GOSSIP_ITEM( 5, "Teleport Stormwind"            , GOSSIP_SENDER_MAIN, 1015);
        player->ADD_GOSSIP_ITEM( 5, "Teleport Ironforge"            , GOSSIP_SENDER_MAIN, 1020);                     
        player->ADD_GOSSIP_ITEM( 5, "Teleport Darnassus"            , GOSSIP_SENDER_MAIN, 1025);
        player->ADD_GOSSIP_ITEM( 5, "Teleport Exodar"               , GOSSIP_SENDER_MAIN, 1030);
    }
    else // Main Menu for Horde
    {
        player->ADD_GOSSIP_ITEM( 5, "Teleport Orgrimmar"            , GOSSIP_SENDER_MAIN, 1035);
        player->ADD_GOSSIP_ITEM( 5, "Teleport Undercity"            , GOSSIP_SENDER_MAIN, 1040);                     
        player->ADD_GOSSIP_ITEM( 5, "Teleport Thunder Bluff"        , GOSSIP_SENDER_MAIN, 1045);
        player->ADD_GOSSIP_ITEM( 5, "Teleport Silvermoon"           , GOSSIP_SENDER_MAIN, 1050);
    }

    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());

    return true;
}

void SendDefaultMenu_portal_npc(Player *player, Creature *_Creature, uint32 action )
{
    // Not allow in combat
    if(!player->getAttackers().empty())
    {
        player->CLOSE_GOSSIP_MENU();
        _Creature->MonsterSay(MSG_INCOMBAT, LANG_UNIVERSAL, 0);
        return;
    }

    OutdoorPvPWG *pvpWG = (OutdoorPvPWG*) sOutdoorPvPMgr.GetOutdoorPvPToZoneId(NORTHREND_WINTERGRASP);

    switch(action)
    {
        case 1005: //Dalaran
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(571, 5804.15, 624.77, 647.8, 1.64);
            break;
        case 1010: // Shattrath
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(530, -1838.16, 5301.79, -12.5, 5.95);
            break;
        case 1015: // Stormwind
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(0, -8992.20, 848.46, 29.63, 0);
            break;
        case 1020: // Ironforge
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(0, -4602.75, -906.53, 502.76, 0);
            break;
        case 1025: // Darnassus
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(1, 966.80, 2513.63, 1331.66, 0);
            break;
        case 1030: // Exodar
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(530, -4021.21, -11561.82, -138.14, 0);
            break;
        case 1035: // Orgrimmar
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(1, 1469.64, -4221.07, 59.23, 0);
            break;
        case 1040: // Undercity
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(0, 1769.64, 64.17, -46.33, 0);
            break;
        case 1045: // Thunder Bluff
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(1, -970.36, 284.84, 111.41, 0);
            break;
        case 1050: // Silvermoon
            player->CLOSE_GOSSIP_MENU();
            player->TeleportTo(530, 10000.25, -7112.02, 47.71, 0);
            break;
        case 1100: //Wintergrasp
            player->CLOSE_GOSSIP_MENU();
            if (pvpWG)
            {
                if ((player->GetTeam() == ALLIANCE && pvpWG->getDefenderTeamId() == TEAM_ALLIANCE)
                    || (player->GetTeam() == TEAM_HORDE && pvpWG->getDefenderTeamId() == TEAM_HORDE))
                    player->TeleportTo(571, 5333.40, 2841.76, 410, 3.23); //In the Fortress                
                else
                    player->TeleportTo(571, 4525.60, 2828.08, 390, 0.28); //Out the Fortress
                    
            }
            break;
    }
}

bool GossipSelect_portal_npc(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    // Main menu
    if (sender == GOSSIP_SENDER_MAIN)
        SendDefaultMenu_portal_npc( player, _Creature, action );

    return true;
}

void AddSC_guildhouse_npcs()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "guildmaster";
    newscript->pGossipHello = &GossipHello_guildmaster;
    newscript->pGossipSelect = &GossipSelect_guildmaster;
    newscript->pGossipSelectWithCode =  &GossipSelectWithCode_guildmaster;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "guild_guard";
    newscript->GetAI = &GetAI_guild_guardAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="buffnpc";
    newscript->pGossipHello = &GossipHello_buffnpc;
    newscript->pGossipSelect = &GossipSelect_buffnpc;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="portal_npc";
    newscript->pGossipHello = &GossipHello_portal_npc;
    newscript->pGossipSelect = &GossipSelect_portal_npc;
    newscript->RegisterSelf();
}