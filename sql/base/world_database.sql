-- Remove the following line to import this
+++DO NOT IMPORT THIS UNLESS YOU WANT A *BLANK* DATABASE.+++
-- MySQL dump 10.13  Distrib 5.1.36, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: world
-- ------------------------------------------------------
-- Server version	5.1.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_requirement`
--

DROP TABLE IF EXISTS `access_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_requirement` (
  `mapId` mediumint(8) unsigned NOT NULL,
  `difficulty` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level_min` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level_max` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_done_A` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_done_H` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `completed_achievement` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_failed_text` text,
  `comment` text,
  PRIMARY KEY (`mapId`,`difficulty`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Access Requirements';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_requirement`
--

LOCK TABLES `access_requirement` WRITE;
/*!40000 ALTER TABLE `access_requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `achievement_criteria_data`
--

DROP TABLE IF EXISTS `achievement_criteria_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achievement_criteria_data` (
  `criteria_id` mediumint(8) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`criteria_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Achievment system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievement_criteria_data`
--

LOCK TABLES `achievement_criteria_data` WRITE;
/*!40000 ALTER TABLE `achievement_criteria_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `achievement_criteria_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `achievement_reward`
--

DROP TABLE IF EXISTS `achievement_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achievement_reward` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title_A` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title_H` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `sender` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievement_reward`
--

LOCK TABLES `achievement_reward` WRITE;
/*!40000 ALTER TABLE `achievement_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `achievement_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areatrigger_involvedrelation`
--

DROP TABLE IF EXISTS `areatrigger_involvedrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_involvedrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areatrigger_involvedrelation`
--

LOCK TABLES `areatrigger_involvedrelation` WRITE;
/*!40000 ALTER TABLE `areatrigger_involvedrelation` DISABLE KEYS */;
/*!40000 ALTER TABLE `areatrigger_involvedrelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areatrigger_scripts`
--

DROP TABLE IF EXISTS `areatrigger_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_scripts` (
  `entry` mediumint(8) NOT NULL,
  `ScriptName` char(64) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areatrigger_scripts`
--

LOCK TABLES `areatrigger_scripts` WRITE;
/*!40000 ALTER TABLE `areatrigger_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `areatrigger_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areatrigger_tavern`
--

DROP TABLE IF EXISTS `areatrigger_tavern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_tavern` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areatrigger_tavern`
--

LOCK TABLES `areatrigger_tavern` WRITE;
/*!40000 ALTER TABLE `areatrigger_tavern` DISABLE KEYS */;
/*!40000 ALTER TABLE `areatrigger_tavern` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areatrigger_teleport`
--

DROP TABLE IF EXISTS `areatrigger_teleport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areatrigger_teleport` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` text,
  `target_map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `target_position_x` float NOT NULL DEFAULT '0',
  `target_position_y` float NOT NULL DEFAULT '0',
  `target_position_z` float NOT NULL DEFAULT '0',
  `target_orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areatrigger_teleport`
--

LOCK TABLES `areatrigger_teleport` WRITE;
/*!40000 ALTER TABLE `areatrigger_teleport` DISABLE KEYS */;
/*!40000 ALTER TABLE `areatrigger_teleport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autobroadcast`
--

DROP TABLE IF EXISTS `autobroadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autobroadcast` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autobroadcast`
--

LOCK TABLES `autobroadcast` WRITE;
/*!40000 ALTER TABLE `autobroadcast` DISABLE KEYS */;
/*!40000 ALTER TABLE `autobroadcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `battleground_template`
--

DROP TABLE IF EXISTS `battleground_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_template` (
  `id` mediumint(8) unsigned NOT NULL,
  `MinPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MaxPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MinLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllianceStartLoc` mediumint(8) unsigned NOT NULL,
  `AllianceStartO` float NOT NULL,
  `HordeStartLoc` mediumint(8) unsigned NOT NULL,
  `HordeStartO` float NOT NULL,
  `Weight` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `ScriptName` char(64) NOT NULL DEFAULT '',
  `Comment` char(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `battleground_template`
--

LOCK TABLES `battleground_template` WRITE;
/*!40000 ALTER TABLE `battleground_template` DISABLE KEYS */;
INSERT INTO `battleground_template` (`id`,`MinPlayersPerTeam`,`MaxPlayersPerTeam`,`MinLvl`,`MaxLvl`,`AllianceStartLoc`,`AllianceStartO`,`HordeStartLoc`,`HordeStartO`, `Weight`, `Comment`) VALUES
(1,20,40,51,80,611,2.72532,610,2.27452,1,'Alterac Valley'),
(2,5,10,10,80,769,3.14159,770,3.14159,1,'Warsong Gulch'),
(3,8,15,20,80,890,3.40156,889,0.263892,1,'Arathi Basin'),
(4,0,2,10,80,929,0,936,3.14159,1,'Nagrand Arena'),
(5,0,2,10,80,939,0,940,3.14159,1,'Blades''s Edge Arena'),
(6,0,2,10,80,0,0,0,0,1,'All Arena'),
(7,8,15,61,80,1103,3.40156,1104,0.263892,1,'Eye of The Storm'),
(8,0,2,10,80,1258,0,1259,3.14159,1,'Ruins of Lordaeron'),
(9,7,15,71,80,1367,0,1368,0,1,'Strand of the Ancients'),
(10,5,5,10,80,1362,0,1363,0,1,'Dalaran Sewers'),
(11,5,5,10,80,1364,0,1365,0,1,'The Ring of Valor'),
(30,20,40,71,80,1485,0,1486,0,1,'Isle of Conquest'),
(32,10,10,0,80,0,0,0,0,1,'Random battleground');
/*!40000 ALTER TABLE `battleground_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `battlemaster_entry`
--

DROP TABLE IF EXISTS `battlemaster_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battlemaster_entry` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Entry of a creature',
  `bg_template` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Battleground template id',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `battlemaster_entry`
--

LOCK TABLES `battlemaster_entry` WRITE;
/*!40000 ALTER TABLE `battlemaster_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `battlemaster_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `security` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `help` longtext,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Chat System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command`
--

LOCK TABLES `command` WRITE;
/*!40000 ALTER TABLE `command` DISABLE KEYS */;
INSERT INTO `command` VALUES
('account',0,'Syntax: .account\r\n\r\nDisplay the access level of your account.'),
('account addon',1,'Syntax: .account addon #addon\nSet expansion addon level allowed. Addon values: 0 - normal, 1 - tbc, 2 - wotlk.'),
('account create',4,'Syntax: .account create $account $password\r\n\r\nCreate account and set password to it.'),
('account delete',4,'Syntax: .account delete $account\r\n\r\nDelete account with all characters.'),
('account lock',0,'Syntax: .account lock [on|off]\r\n\r\nAllow login from account only from current used IP or remove this requirement.'),
('account onlinelist',4,'Syntax: .account onlinelist\r\n\r\nShow list of online accounts.'),
('account password',0,'Syntax: .account password $old_password $new_password $new_password\r\n\r\nChange your account password.'),
('account set',3,'Syntax: .account set $subcommand\nType .account set to see the list of possible subcommands or .help account set $subcommand to see info on subcommands'),
('account set addon',3,'Syntax: .account set addon [$account] #addon\r\n\r\nSet user (possible targeted) expansion addon level allowed. Addon values: 0 - normal, 1 - tbc, 2 - wotlk.'),
('account set gmlevel',4,'Syntax: .account set gmlevel [$account] #level [#realmid]\r\n\r\nSet the security level for targeted player (can''t be used at self) or for account $name to a level of #level on the realm #realmID.\r\n\r\n#level may range from 0 to 3.\r\n\r\n#reamID may be -1 for all realms.'),
('account set password',4,'Syntax: .account set password $account $password $password\r\n\r\nSet password for account.'),
('achievement',4,'Syntax: .achievement $subcommand\nType .achievement to see the list of possible subcommands or .help achievement $subcommand to see info on subcommands'),
('achievement add',4,'Syntax: .achievement add $achievement\nAdd an achievement to the targeted player.\n$achievement: can be either achievement id or achievement link'),
('additem',3,'Syntax: .additem #itemid/[#itemname]/#shift-click-item-link #itemcount\r\n\r\nAdds the specified number of items of id #itemid (or exact (!) name $itemname in brackets, or link created by shift-click at item in inventory or recipe) to your or selected character inventory. If #itemcount is omitted, only one item will be added.\r\n.'),
('additemset',3,'Syntax: .additemset #itemsetid\r\n\r\nAdd items from itemset of id #itemsetid to your or selected character inventory. Will add by one example each item from itemset.'),
('announce',1,'Syntax: .announce $MessageToBroadcast\r\n\r\nSend a global message to all players online in chat log.'),
('appear',1,'Syntax: .appear [$charactername]\r\n\r\nTeleport to the given character. Either specify the character name or click on the character''s portrait, e.g. when you are in a group. Character can be offline.'),
('aura',3,'Syntax: .aura #spellid\r\n\r\nAdd the aura from spell #spellid to the selected Unit.'),
('ban',3,'Syntax: .ban $subcommand\nType .ban to see the list of possible subcommands or .help ban $subcommand to see info on subcommands'),
('ban account',3,'Syntax: .ban account $Name $bantime $reason\r\nBan account kick player.\r\n$bantime: negative value leads to permban, otherwise use a timestring like \"4d20h3s\".'),
('ban character',3,'Syntax: .ban character $Name $bantime $reason\nBan character and kick player.\n$bantime: negative value leads to permban, otherwise use a timestring like "4d20h3s".'),
('ban playeraccount',3,'Syntax: .ban playeraccount $Name $bantime $reason\nBan account and kick player.\n$bantime: negative value leads to permban, otherwise use a timestring like "4d20h3s".'),
('ban ip',3,'Syntax: .ban ip $Ip $bantime $reason\r\nBan IP.\r\n$bantime: negative value leads to permban, otherwise use a timestring like \"4d20h3s\".'),
('baninfo',3,'Syntax: .baninfo $subcommand\nType .baninfo to see the list of possible subcommands or .help baninfo $subcommand to see info on subcommands'),
('baninfo account',3,'Syntax: .baninfo account $accountid\r\nWatch full information about a specific ban.'),
('baninfo character',3,'Syntax: .baninfo character $charactername \r\nWatch full information about a specific ban.'),
('baninfo ip',3,'Syntax: .baninfo ip $ip\r\nWatch full information about a specific ban.'),
('bank',3,'Syntax: .bank\r\n\r\nShow your bank inventory.'),
('banlist',3,'Syntax: .banlist $subcommand\nType .banlist to see the list of possible subcommands or .help banlist $subcommand to see info on subcommands'),
('banlist account',3,'Syntax: .banlist account [$Name]\r\nSearches the banlist for a account name pattern or show full list account bans.'),
('banlist character',3,'Syntax: .banlist character $Name\r\nSearches the banlist for a character name pattern. Pattern required.'),
('banlist ip',3,'Syntax: .banlist ip [$Ip]\r\nSearches the banlist for a IP pattern or show full list of IP bans.'),
('bindsight',3,'Syntax: .bindsight\r\n\r\nBinds vision to the selected unit indefinitely. Cannot be used while currently possessing a target.'),
('cast',3,'Syntax: .cast #spellid [triggered]\r\n  Cast #spellid to selected target. If no target selected cast to self. If ''trigered'' or part provided then spell casted with triggered flag.'),
('cast back',3,'Syntax: .cast back #spellid [triggered]\r\n  Selected target will cast #spellid to your character. If ''trigered'' or part provided then spell casted with triggered flag.'),
('cast dist',3,'Syntax: .cast dist #spellid [#dist [triggered]]\r\n  You will cast spell to pint at distance #dist. If ''trigered'' or part provided then spell casted with triggered flag. Not all spells can be casted as area spells.'),
('cast self',3,'Syntax: .cast self #spellid [triggered]\r\nCast #spellid by target at target itself. If ''trigered'' or part provided then spell casted with triggered flag.'),
('cast target',3,'Syntax: .cast target #spellid [triggered]\r\n  Selected target will cast #spellid to his victim. If ''trigered'' or part provided then spell casted with triggered flag.'),
('character customize',2,'Syntax: .character customize [$name]\r\n\r\nMark selected in game or by $name in command character for customize at next login.'),
('character erase',4,'Syntax: .character erase $name\r\n\r\nDelete character $name. Character finally deleted in case any deleting options.'),
('character deleted delete', 4, 'Syntax: .character deleted delete #guid|$name\r\n\r\nCompletely deletes the selected characters.\r\nIf $name is supplied, only characters with that string in their name will be deleted, if #guid is supplied, only the character with that GUID will be deleted.'),
('character deleted list', 3, 'Syntax: .character deleted list [#guid|$name]\r\n\r\nShows a list with all deleted characters.\r\nIf $name is supplied, only characters with that string in their name will be selected, if #guid is supplied, only the character with that GUID will be selected.'),
('character deleted old', 4, 'Syntax: .character deleted old [#keepDays]\r\n\r\nCompletely deletes all characters with deleted time longer #keepDays. If #keepDays not provided the  used value from mangosd.conf option ''CharDelete.KeepDays''. If referenced config option disabled (use 0 value) then command can''t be used without #keepDays.'),
('character deleted restore', 3, 'Syntax: .character deleted restore #guid|$name [$newname] [#new account]\r\n\r\nRestores deleted characters.\r\nIf $name is supplied, only characters with that string in their name will be restored, if $guid is supplied, only the character with that GUID will be restored.\r\nIf $newname is set, the character will be restored with that name instead of the original one. If #newaccount is set, the character will be restored to specific account character list. This works only with one character!'),
('character level',3,'Syntax: .character level [$playername] [#level]\r\n\r\nSet the level of character with $playername (or the selected if not name provided) by #numberoflevels Or +1 if no #numberoflevels provided). If #numberoflevels is omitted, the level will be increase by 1. If #numberoflevels is 0, the same level will be restarted. If no character is selected and name not provided, increase your level. Command can be used for offline character. All stats and dependent values recalculated. At level decrease talents can be reset if need. Also at level decrease equipped items with greater level requirement can be lost.'),
('character rename',2,'Syntax: .character rename [$name]\r\n\r\nMark selected in game or by $name in command character for rename at next login.'),
('character reputation',2,'Syntax: .character reputation [$player_name]\r\n\r\nShow reputation information for selected player or player find by $player_name.'),
('character titles',2,'Syntax: .character titles [$player_name]\r\n\r\nShow known titles list for selected player or player find by $player_name.'),
('character changefaction',2,'Syntax: .character changefaction $name\r\n\r\nChange character faction.'),
('character changerace',2,'Syntax: .character changerace $name\r\n\r\nChange character race.'),
('channel set public', 3, 'Syntax: .channel set public  $channel $public\r\n\r\nChange password-changing ability for a channel. 1 for possible, 0 for GM only.'),
('combatstop',2,'Syntax: .combatstop [$playername]\r\nStop combat for selected character. If selected non-player then command applied to self. If $playername provided then attempt applied to online player $playername.'),
('cometome',3,'SYntax: .cometome $parameter\nMake selected creature come to your current location (new position not saved to DB).'),
('commands',0,'Syntax: .commands\r\n\r\nDisplay a list of available commands for your account level.'),
('cooldown',3,'Syntax: .cooldown [#spell_id]\r\n\r\nRemove all (if spell_id not provided) or #spel_id spell cooldown from selected character or you (if no selection).'),
('damage',3,'Syntax: .damage $damage_amount [$school [$spellid]]\r\n\r\nApply $damage to target. If not $school and $spellid provided then this flat clean melee damage without any modifiers. If $school provided then damage modified by armor reduction (if school physical), and target absorbing modifiers and result applied as melee damage to target. If spell provided then damage modified and applied as spell damage. $spellid can be shift-link.'),
('debug',1,'Syntax: .debug $subcommand\nType .debug to see the list of possible subcommands or .help debug $subcommand to see info on subcommands'),
('debug arena',3,'Syntax: .debug arena\r\n\r\nToggle debug mode for arenas. In debug mode GM can start arena with single player.'),
('debug bg',3,'Syntax: .debug bg\r\n\r\nToggle debug mode for battlegrounds. In debug mode GM can start battleground with single player.'),
('debug Mod32Value',3,'Syntax: .debug Mod32Value #field #value\r\n\r\nAdd #value to field #field of your character.'),
('debug play cinematic',1,'Syntax: .debug play cinematic #cinematicid\r\n\r\nPlay cinematic #cinematicid for you. You stay at place while your mind fly.\r\n'),
('debug play movie',1,'Syntax: .debug play movie #movieid\r\n\r\nPlay movie #movieid for you.'),
('debug play sound',1,'Syntax: .debug play sound #soundid\r\n\r\nPlay sound with #soundid.\r\nSound will be play only for you. Other players do not hear this.\r\nWarning: client may have more 5000 sounds...'),
('demorph',2,'Syntax: .demorph\r\n\r\nDemorph the selected player.'),
('die',3,'Syntax: .die\r\n\r\nKill the selected player. If no player is selected, it will kill you.'),
('dismount',0,'Syntax: .dismount\r\n\r\nDismount you, if you are mounted.'),
('distance',3,'Syntax: .distance\r\n\r\nDisplay the distance from your character to the selected creature.'),
('event',2,'Syntax: .event #event_id\r\nShow details about event with #event_id.'),
('event activelist',2,'Syntax: .event activelist\r\nShow list of currently active events.'),
('event start',2,'Syntax: .event start #event_id\r\nStart event #event_id. Set start time for event to current moment (change not saved in DB).'),
('event stop',2,'Syntax: .event stop #event_id\r\nStop event #event_id. Set start time for event to time in past that make current moment is event stop time (change not saved in DB).'),
('explorecheat',3,'Syntax: .explorecheat #flag\r\n\r\nReveal  or hide all maps for the selected player. If no player is selected, hide or reveal maps to you.\r\n\r\nUse a #flag of value 1 to reveal, use a #flag value of 0 to hide all maps.'),
('flusharenapoints',3,'Syntax: .flusharenapoints\r\n\r\nUse it to distribute arena points based on arena team ratings, and start a new week.'),
('freeze',1,'Syntax: .freeze (#player)\r\n\"Freezes\" #player and disables his chat. When using this without #name it will freeze your target.'),
('gm',1,'Syntax: .gm [on/off]\r\n\r\nEnable or Disable in game GM MODE or show current state of on/off not provided.'),
('gm chat',1,'Syntax: .gm chat [on/off]\r\n\r\nEnable or disable chat GM MODE (show gm badge in messages) or show current state of on/off not provided.'),
('gm fly',3,'Syntax: .gm fly [on/off]\r\nEnable/disable gm fly mode.'),
('gm ingame',0,'Syntax: .gm ingame\r\n\r\nDisplay a list of available in game Game Masters.'),
('gm list',3,'Syntax: .gm list\r\n\r\nDisplay a list of all Game Masters accounts and security levels.'),
('gm visible',1,'Syntax: .gm visible on/off\r\n\r\nOutput current visibility state or make GM visible(on) and invisible(off) for other players.'),
('gmannounce',1,'Syntax: .gmannounce $announcement\r\nSend an announcement to online Gamemasters.'),
('gmnameannounce',1,'Syntax: .gmnameannounce $announcement.\r\nSend an announcement to all online GM''s, displaying the name of the sender.'),
('gmnotify',1,'Syntax: .gmnotify $notification\r\nDisplays a notification on the screen of all online GM''s.'),
('go',1,'Syntax: .go $subcommand\nType .go to see the list of possible subcommands or .help go $subcommand to see info on subcommands'),
('go creature',1,'Syntax: .go creature #creature_guid\r\nTeleport your character to creature with guid #creature_guid.\r\n.gocreature #creature_name\r\nTeleport your character to creature with this name.\r\n.gocreature id #creature_id\r\nTeleport your character to a creature that was spawned from the template with this entry.\r\n*If* more than one creature is found, then you are teleported to the first that is found inside the database.'),
('go graveyard',1,'Syntax: .go graveyard #graveyardId\r\n Teleport to graveyard with the graveyardId specified.'),
('go grid',1,'Syntax: .go grid #gridX #gridY [#mapId]\r\n\r\nTeleport the gm to center of grid with provided indexes at map #mapId (or current map if it not provided).'),
('go object',1,'Syntax: .go object #object_guid\r\nTeleport your character to gameobject with guid #object_guid'),
('go taxinode',1,'Syntax: .go taxinode #taxinode\r\n\r\nTeleport player to taxinode coordinates. You can look up zone using .lookup taxinode $namepart'),
('go ticket',1,'Syntax: .go ticket #ticketid\r\nTeleports the user to the location where $ticketid was created.'),
('go trigger',1,'Syntax: .go trigger #trigger_id\r\n\r\nTeleport your character to areatrigger with id #trigger_id. Character will be teleported to trigger target if selected areatrigger is telporting trigger.'),
('go xy',1,'Syntax: .go xy #x #y [#mapid]\r\n\r\nTeleport player to point with (#x,#y) coordinates at ground(water) level at map #mapid or same map if #mapid not provided.'),
('go xyz',1,'Syntax: .go xyz #x #y #z [#mapid]\r\n\r\nTeleport player to point with (#x,#y,#z) coordinates at ground(water) level at map #mapid or same map if #mapid not provided.'),
('go zonexy',1,'Syntax: .go zonexy #x #y [#zone]\r\n\r\nTeleport player to point with (#x,#y) client coordinates at ground(water) level in zone #zoneid or current zone if #zoneid not provided. You can look up zone using .lookup area $namepart'),
('gobject',2,'Syntax: .gobject $subcommand\nType .gobject to see the list of possible subcommands or .help gobject $subcommand to see info on subcommands'),
('gobject activate',2,'Syntax: .gobject activate #guid\r\n\r\nActivates an object like a door or a button.'),
('gobject add',2,'Syntax: .gobject add #id <spawntimeSecs>\r\n\r\nAdd a game object from game object templates to the world at your current location using the #id.\r\nspawntimesecs sets the spawntime, it is optional.\r\n\r\nNote: this is a copy of .gameobject.'),
('gobject delete',2,'Syntax: .gobject delete #go_guid\r\nDelete gameobject with guid #go_guid.'),
('gobject info', 2, 'Syntax: .gobject info [$object_entry]\r\n\r\nQuery Gameobject information for selected gameobject or given entry.'),
('gobject move',2,'Syntax: .gobject move #goguid [#x #y #z]\r\n\r\nMove gameobject #goguid to character coordinates (or to (#x,#y,#z) coordinates if its provide).'),
('gobject near',2,'Syntax: .gobject near  [#distance]\r\n\r\nOutput gameobjects at distance #distance from player. Output gameobject guids and coordinates sorted by distance from character. If #distance not provided use 10 as default value.'),
('gobject setphase',2,'Syntax: .gobject setphase #guid #phasemask\r\n\r\nGameobject with DB guid #guid phasemask changed to #phasemask with related world vision update for players. Gameobject state saved to DB and persistent.'),
('gobject target',2,'Syntax: .gobject target [#go_id|#go_name_part]\r\n\r\nLocate and show position nearest gameobject. If #go_id or #go_name_part provide then locate and show position of nearest gameobject with gameobject template id #go_id or name included #go_name_part as part.'),
('gobject tempadd',2,'Adds a temporary gameobject that is not saved to DB.'),
('gobject turn',2,'Syntax: .gobject turn #goguid \r\n\r\nSet for gameobject #goguid orientation same as current character orientation.'),
('gps',1,'Syntax: .gps [$name|$shift-link]\r\n\r\nDisplay the position information for a selected character or creature (also if player name $name provided then for named player, or if creature/gameobject shift-link provided then pointed creature/gameobject if it loaded). Position information includes X, Y, Z, and orientation, map Id and zone Id'),
('groupsummon',1,'Syntax: .groupsummon [$charactername]\r\n\r\nTeleport the given character and his group to you. Teleported only online characters but original selected group member can be offline.'),
('guid',2,'Syntax: .guid\r\n\r\nDisplay the GUID for the selected character.'),
('guild',3,'Syntax: .guild $subcommand\nType .guild to see the list of possible subcommands or .help guild $subcommand to see info on subcommands'),
('guild create',2,'Syntax: .guild create [$GuildLeaderName] \"$GuildName\"\r\n\r\nCreate a guild named $GuildName with the player $GuildLeaderName (or selected) as leader.  Guild name must in quotes.'),
('guild delete',2,'Syntax: .guild delete \"$GuildName\"\r\n\r\nDelete guild $GuildName. Guild name must in quotes.'),
('guild invite',2,'Syntax: .guild invite [$CharacterName] \"$GuildName\"\r\n\r\nAdd player $CharacterName (or selected) into a guild $GuildName. Guild name must in quotes.'),
('guild rank',2,'Syntax: .guild rank [$CharacterName] #Rank\r\n\r\nSet for player $CharacterName (or selected) rank #Rank in a guild.'),
('guild uninvite',2,'Syntax: .guild uninvite [$CharacterName]\r\n\r\nRemove player $CharacterName (or selected) from a guild.'),
('help',0,'Syntax: .help [$command]\r\n\r\nDisplay usage instructions for the given $command. If no $command provided show list available commands.'),
('hidearea',3,'Syntax: .hidearea #areaid\r\n\r\nHide the area of #areaid to the selected character. If no character is selected, hide this area to you.'),
('honor',2,'Syntax: .honor $subcommand\nType .honor to see the list of possible subcommands or .help honor $subcommand to see info on subcommands'),
('honor add',2,'Syntax: .honor add $amount\r\n\r\nAdd a certain amount of honor (gained today) to the selected player.'),
('honor addkill',2,'Syntax: .honor addkikll\r\n\r\nAdd the targeted unit as one of your pvp kills today (you only get honor if it''s a racial leader or a player)'),
('honor update',2,'Syntax: .honor update\r\n\r\nForce the yesterday''s honor fields to be updated with today''s data, which will get reset for the selected player.'),
('hover',3,'Syntax: .hover #flag\r\n\r\nEnable or disable hover mode for your character.\r\n\r\nUse a #flag of value 1 to enable, use a #flag value of 0 to disable hover.'),
('instance',3,'Syntax: .instance $subcommand\nType .instance to see the list of possible subcommands or .help instance $subcommand to see info on subcommands'),
('instance listbinds',3,'Syntax: .instance listbinds\r\n  Lists the binds of the selected player.'),
('instance savedata',3,'Syntax: .instance savedata\r\n  Save the InstanceData for the current player''s map to the DB.'),
('instance stats',3,'Syntax: .instance stats\r\n  Shows statistics about instances.'),
('instance unbind',3,'Syntax: .instance unbind <mapid|all> [difficulty]\r\n  Clear all/some of player''s binds'),
('itemmove',2,'Syntax: .itemmove #sourceslotid #destinationslotid\r\n\r\nMove an item from slots #sourceslotid to #destinationslotid in your inventory\r\n\r\nNot yet implemented'),
('kick',2,'Syntax: .kick [$charactername] [$reason]\r\n\r\nKick the given character name from the world with or without reason. If no character name is provided then the selected player (except for yourself) will be kicked. If no reason is provided, default is \"No Reason\".'),
('learn',3,'Syntax: .learn #spell [all]\r\n\r\nSelected character learn a spell of id #spell. If ''all'' provided then all ranks learned.'),
('learn all',3,'Syntax: .learn all\r\n\r\nLearn all big set different spell maybe useful for Administaror.'),
('learn all_crafts',2,'Syntax: .learn crafts\r\n\r\nLearn all professions and recipes.'),
('learn all_default',1,'Syntax: .learn all_default [$playername]\r\n\r\nLearn for selected/$playername player all default spells for his race/class and spells rewarded by completed quests.'),
('learn all_gm',2,'Syntax: .learn all_gm\r\n\r\nLearn all default spells for Game Masters.'),
('learn all_lang',1,'Syntax: .learn all_lang\r\n\r\nLearn all languages'),
('learn all_myclass',3,'Syntax: .learn all_myclass\r\n\r\nLearn all spells and talents available for his class.'),
('learn all_mypettalents',3,'Syntax: .learn all_mypettalents\r\n\r\nLearn all talents for your pet available for his creature type (only for hunter pets).'),
('learn all_myspells',3,'Syntax: .learn all_myspells\r\n\r\nLearn all spells (except talents and spells with first rank learned as talent) available for his class.'),
('learn all_mytalents',3,'Syntax: .learn all_mytalents\r\n\r\nLearn all talents (and spells with first rank learned as talent) available for his class.'),
('learn all_recipes',2,'Syntax: .learn all_recipes [$profession]\r\rLearns all recipes of specified profession and sets skill level to max.\rExample: .learn all_recipes enchanting'),
('levelup',3,'Syntax: .levelup [$playername] [#numberoflevels]\r\n\r\nIncrease/decrease the level of character with $playername (or the selected if not name provided) by #numberoflevels Or +1 if no #numberoflevels provided). If #numberoflevels is omitted, the level will be increase by 1. If #numberoflevels is 0, the same level will be restarted. If no character is selected and name not provided, increase your level. Command can be used for offline character. All stats and dependent values recalculated. At level decrease talents can be reset if need. Also at level decrease equipped items with greater level requirement can be lost.'),
('linkgrave',3,'Syntax: .linkgrave #graveyard_id [alliance|horde]\r\n\r\nLink current zone to graveyard for any (or alliance/horde faction ghosts). This let character ghost from zone teleport to graveyard after die if graveyard is nearest from linked to zone and accept ghost of this faction. Add only single graveyard at another map and only if no graveyards linked (or planned linked at same map).'),
('list',3,'Syntax: .list $subcommand\nType .list to see the list of possible subcommands or .help list $subcommand to see info on subcommands'),
('list auras',3,'Syntax: .list auras\nList auras (passive and active) of selected creature or player. If no creature or player is selected, list your own auras.'),
('list creature',3,'Syntax: .list creature #creature_id [#max_count]\r\n\r\nOutput creatures with creature id #creature_id found in world. Output creature guids and coordinates sorted by distance from character. Will be output maximum #max_count creatures. If #max_count not provided use 10 as default value.'),
('list item',3,'Syntax: .list item #item_id [#max_count]\r\n\r\nOutput items with item id #item_id found in all character inventories, mails, auctions, and guild banks. Output item guids, item owner guid, owner account and owner name (guild name and guid in case guild bank). Will be output maximum #max_count items. If #max_count not provided use 10 as default value.'),
('list object',3,'Syntax: .list object #gameobject_id [#max_count]\r\n\r\nOutput gameobjects with gameobject id #gameobject_id found in world. Output gameobject guids and coordinates sorted by distance from character. Will be output maximum #max_count gameobject. If #max_count not provided use 10 as default value.'),
('listfreeze',1,'Syntax: .listfreeze\r\n\r\nSearch and output all frozen players.'),
('loadpath',3,'Syntax: .loadpath $pathid\nLoad path changes ingame - IMPORTANT: must be applied first for new paths before .path load #pathid '),
('lookup',3,'Syntax: .lookup $subcommand\nType .lookup to see the list of possible subcommands or .help lookup $subcommand to see info on subcommands'),
('lookup area',1,'Syntax: .lookup area $namepart\r\n\r\nLooks up an area by $namepart, and returns all matches with their area ID''s.'),
('lookup creature',3,'Syntax: .lookup creature $namepart\r\n\r\nLooks up a creature by $namepart, and returns all matches with their creature ID''s.'),
('lookup event',2,'Syntax: .lookup event $name\r\nAttempts to find the ID of the event with the provided $name.'),
('lookup faction',3,'Syntax: .lookup faction $name\r\nAttempts to find the ID of the faction with the provided $name.'),
('lookup item',3,'Syntax: .lookup item $itemname\r\n\r\nLooks up an item by $itemname, and returns all matches with their Item ID''s.'),
('lookup itemset',3,'Syntax: .lookup itemset $itemname\r\n\r\nLooks up an item set by $itemname, and returns all matches with their Item set ID''s.'),
('lookup map',3,'Syntax: .lookup map $namepart\r\n\r\nLooks up a map by $namepart, and returns all matches with their map ID''s.'),
('lookup object',3,'Syntax: .lookup object $objname\r\n\r\nLooks up an gameobject by $objname, and returns all matches with their Gameobject ID''s.'),
('lookup player account',2,'Syntax: .lookup player account $account ($limit) \r\n\r\n Searchs players, which account username is $account with optional parametr $limit of results.'),
('lookup player email',2,'Syntax: .lookup player email $email ($limit) \r\n\r\n Searchs players, which account email is $email with optional parametr $limit of results.'),
('lookup player ip',2,'Syntax: .lookup player ip $ip ($limit) \r\n\r\n Searchs players, which account ast_ip is $ip with optional parametr $limit of results.'),
('lookup quest',3,'Syntax: .lookup quest $namepart\r\n\r\nLooks up a quest by $namepart, and returns all matches with their quest ID''s.'),
('lookup skill',3,'Syntax: .lookup skill $$namepart\r\n\r\nLooks up a skill by $namepart, and returns all matches with their skill ID''s.'),
('lookup spell',3,'Syntax: .lookup spell $namepart\r\n\r\nLooks up a spell by $namepart, and returns all matches with their spell ID''s.'),
('lookup taxinode',3,'Syntax: .lookup taxinode $substring\r\n\r\nSearch and output all taxinodes with provide $substring in name.'),
('lookup tele',1,'Syntax: .lookup tele $substring\r\n\r\nSearch and output all .tele command locations with provide $substring in name.'),
('maxskill',3,'Syntax: .maxskill\r\nSets all skills of the targeted player to their maximum values for its current level.'),
('modify',1,'Syntax: .modify $subcommand\nType .modify to see the list of possible subcommands or .help modify $subcommand to see info on subcommands'),
('modify arena',1,'Syntax: .modify arena #value\r\nAdd $amount arena points to the selected player.'),
('modify aspeed',1,'Syntax: .modify aspeed #rate\r\n\r\nModify all speeds -run,swim,run back,swim back- of the selected player to \"normalbase speed for this move type\"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify bit',1,'Syntax: .modify bit #field #bit\r\n\r\nToggle the #bit bit of the #field field for the selected player. If no player is selected, modify your character.'),
('modify bwalk',1,'Syntax: .modify bwalk #rate\r\n\r\nModify the speed of the selected player while running backwards to \"normal walk back speed\"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify drunk',1,'Syntax: .modify drunk #value\r\n Set drunk level to #value (0..100). Value 0 remove drunk state, 100 is max drunked state.'),
('modify energy',1,'Syntax: .modify energy #energy\r\n\r\nModify the energy of the selected player. If no player is selected, modify your energy.'),
('modify faction',1,'Syntax: .modify faction #factionid #flagid #npcflagid #dynamicflagid\r\n\r\nModify the faction and flags of the selected creature. Without arguments, display the faction and flags of the selected creature.'),
('modify fly',1,'.modify fly $parameter\nModify the flying speed of the selected player to \"normal flying speed\"*rate. If no player is selected, modify your speed.\n #rate may range from 0.1 to 50.'),
('modify gender',2,'Syntax: .modify gender male/female\r\n\r\nChange gender of selected player.'),
('modify honor',1,'Syntax: .modify honor $amount\r\n\r\nAdd $amount honor points to the selected player.'),
('modify hp',1,'Syntax: .modify hp #newhp\r\n\r\nModify the hp of the selected player. If no player is selected, modify your hp.'),
('modify mana',1,'Syntax: .modify mana #newmana\r\n\r\nModify the mana of the selected player. If no player is selected, modify your mana.'),
('modify money',1,'Syntax: .modify money #money\r\n.money #money\r\n\r\nAdd or remove money to the selected player. If no player is selected, modify your money.\r\n\r\n #gold can be negative to remove money.'),
('modify morph',2,'Syntax: .modify morph #displayid\r\n\r\nChange your current model id to #displayid.'),
('modify mount',1,'Syntax: .modify mount #id #speed\r\nDisplay selected player as mounted at #id creature and set speed to #speed value.'),
('modify phase',3,'Syntax: .modify phase #phasemask\r\n\r\nSelected character phasemask changed to #phasemask with related world vision update. Change active until in game phase changed, or GM-mode enable/disable, or re-login. Character pts pasemask update to same value.'),
('modify rage',1,'Syntax: .modify rage #newrage\r\n\r\nModify the rage of the selected player. If no player is selected, modify your rage.'),
('modify rep',2,'Syntax: .modify rep #repId (#repvalue | $rankname [#delta])\r\nSets the selected players reputation with faction #repId to #repvalue or to $reprank.\r\nIf the reputation rank name is provided, the resulting reputation will be the lowest reputation for that rank plus the delta amount, if specified.\r\nYou can use ''.pinfo rep'' to list all known reputation ids, or use ''.lookup faction $name'' to locate a specific faction id.'),
('modify runicpower',1,'Syntax: .modify runicpower #newrunicpower\r\n\r\nModify the runic power of the selected player. If no player is selected, modify your runic power.'),
('modify scale',1,'.modify scale $parameter\nModify size of the selected player to \"normal scale\"*rate. If no player is selected, modify your size.\n#rate may range from 0.1 to 10.'),
('modify speed',1,'Syntax: .modify speed #rate\r\n.speed #rate\r\n\r\nModify the running speed of the selected player to \"normal base run speed\"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify spell',1,'TODO'),
('modify standstate',2,'Syntax: .modify standstate #emoteid\r\n\r\nChange the emote of your character while standing to #emoteid.'),
('modify swim',1,'Syntax: .modify swim #rate\r\n\r\nModify the swim speed of the selected player to \"normal swim speed\"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify tp',1,'Syntax: .modify tp #amount\r\n\r\nSet free talent pointes for selected character or character''s pet. It will be reset to default expected at next levelup/login/quest reward.'),
('movegens',3,'Syntax: .movegens\r\n  Show movement generators stack for selected creature or player.'),
('mute',1,'Syntax: .mute [$playerName] $timeInMinutes [$reason]\r\n\r\nDisible chat messaging for any character from account of character $playerName (or currently selected) at $timeInMinutes minutes. Player can be offline.'),
('nameannounce',1,'Syntax: .nameannounce $announcement.\nSend an announcement to all online players, displaying the name of the sender.'),
('neargrave',3,'Syntax: .neargrave [alliance|horde]\r\n\r\nFind nearest graveyard linked to zone (or only nearest from accepts alliance or horde faction ghosts).'),
('notify',1,'Syntax: .notify $MessageToBroadcast\r\n\r\nSend a global message to all players online in screen.'),
('npc',1,'Syntax: .npc $subcommand\nType .npc to see the list of possible subcommands or .help npc $subcommand to see info on subcommands'),
('npc add',2,'Syntax: .npc add #creatureid\r\n\r\nSpawn a creature by the given template id of #creatureid.'),
('npc addformation',1,'Syntax: .npc addformation $leader\nAdd selected creature to a leader''s formation.'),
('npc additem',2,'Syntax: .npc additem #itemId <#maxcount><#incrtime><#extendedcost>r\r\n\r\nAdd item #itemid to item list of selected vendor. Also optionally set max count item in vendor item list and time to item count restoring and items ExtendedCost.'),
('npc addmove',2,'Syntax: .npc addmove #creature_guid [#waittime]\r\n\r\nAdd your current location as a waypoint for creature with guid #creature_guid. And optional add wait time.'),
('npc allowmove',3,'Syntax: .npc allowmove\r\n\r\nEnable or disable movement creatures in world. Not implemented.'),
('npc changeentry',3,'Syntax: .npc changeentry $entry\nSwitch selected creature with another entry from creature_template. - New creature.id value not saved to DB.'),
('npc changelevel',2,'Syntax: .npc changelevel #level\r\n\r\nChange the level of the selected creature to #level.\r\n\r\n#level may range from 1 to 63.'),
('npc delete',2,'Syntax: .npc delete [#guid]\r\n\r\nDelete creature with guid #guid (or the selected if no guid is provided)'),
('npc delitem',2,'Syntax: .npc delitem #itemId\r\n\r\nRemove item #itemid from item list of selected vendor.'),
('npc factionid',2,'Syntax: .npc factionid #factionid\r\n\r\nSet the faction of the selected creature to #factionid.'),
('npc flag',2,'Syntax: .npc flag #npcflag\r\n\r\nSet the NPC flags of creature template of the selected creature and selected creature to #npcflag. NPC flags will applied to all creatures of selected creature template after server restart or grid unload/load.'),
('npc follow',2,'Syntax: .npc follow\r\n\r\nSelected creature start follow you until death/fight/etc.'),
('npc info',3,'Syntax: .npc info\r\n\r\nDisplay a list of details for the selected creature.\r\n\r\nThe list includes:\r\n- GUID, Faction, NPC flags, Entry ID, Model ID,\r\n- Level,\r\n- Health (current/maximum),\r\n\r\n- Field flags, dynamic flags, faction template, \r\n- Position information,\r\n- and the creature type, e.g. if the creature is a vendor.'),
('npc move',2,'Syntax: .npc move [#creature_guid]\r\n\r\nMove the targeted creature spawn point to your coordinates.'),
('npc playemote',3,'Syntax: .npc playemote #emoteid\r\n\r\nMake the selected creature emote with an emote of id #emoteid.'),
('npc say',1,'Syntax: .npc say $message\nMake selected creature say specified message.'),
('npc setdeathstate',2,'Syntax: .npc setdeathstate on/off\r\n\r\nSet default death state (dead/alive) for npc at spawn.'),
('npc setlink',2,'Syntax: .npc setlink $creatureGUID\r\n\r\nLinks respawn of selected creature to the condition that $creatureGUID defined is alive.'),
('npc setmodel',2,'Syntax: .npc setmodel #displayid\r\n\r\nChange the model id of the selected creature to #displayid.'),
('npc setmovetype',2,'Syntax: .npc setmovetype [#creature_guid] stay/random/way [NODEL]\r\n\r\nSet for creature pointed by #creature_guid (or selected if #creature_guid not provided) movement type and move it to respawn position (if creature alive). Any existing waypoints for creature will be removed from the database if you do not use NODEL. If the creature is dead then movement type will applied at creature respawn.\r\nMake sure you use NODEL, if you want to keep the waypoints.'),
('npc setphase',2,'Syntax: .npc setphase #phasemask\r\n\r\nSelected unit or pet phasemask changed to #phasemask with related world vision update for players. In creature case state saved to DB and persistent. In pet case change active until in game phase changed for owner, owner re-login, or GM-mode enable/disable..'),
('npc spawndist',2,'Syntax: .npc spawndist #dist\r\n\r\nAdjust spawndistance of selected creature to dist.'),
('npc spawntime',2,'Syntax: .npc spawntime #time \r\n\r\nAdjust spawntime of selected creature to time.'),
('npc tempadd',2,'Adds temporary NPC, not saved to database.'),
('npc textemote',1,'Syntax: .npc textemote #emoteid\r\n\r\nMake the selected creature to do textemote with an emote of id #emoteid.'),
('npc unfollow',2,'Syntax: .npc unfollow\r\n\r\nSelected creature (non pet) stop follow you.'),
('npc whisper',1,'Syntax: .npc whisper #playerguid #text\r\nMake the selected npc whisper #text to  #playerguid.'),
('npc yell',1,'Syntax: .npc yell $message\nMake selected creature yell specified message.'),
('pdump',3,'Syntax: .pdump $subcommand\nType .pdump to see the list of possible subcommands or .help pdump $subcommand to see info on subcommands'),
('pdump load',3,'Syntax: .pdump load $filename $account [$newname] [$newguid]\r\nLoad character dump from dump file into character list of $account with saved or $newname, with saved (or first free) or $newguid guid.'),
('pdump write',3,'Syntax: .pdump write $filename $playerNameOrGUID\r\nWrite character dump with name/guid $playerNameOrGUID to file $filename.'),
('pet',2,'Syntax: .pet $subcommand\nType .pet to see the list of possible subcommands or .help pet $subcommand to see info on subcommands'),
('pet create',2,'Syntax: .pet create\r\n\r\nCreates a pet of the selected creature.'),
('pet learn',2,'Syntax: .pet learn\r\n\r\nLearn #spellid to pet.'),
('pet tp',2,'Syntax: .pet tp #\r\n\r\nChange pet''s amount of training points.'),
('pet unlearn',2,'Syntax: .pet unlean\r\n\r\nunLearn #spellid to pet.'),
('pinfo',2,'Syntax: .pinfo [$player_name]\r\n\r\nOutput account information for selected player or player find by $player_name.'),
('playall',2,'Syntax: .playall #soundid\r\n\r\nPlayer a sound to whole server.'),
('possess',3,'Syntax: .possess\r\n\r\nPossesses indefinitely the selected creature.'),
('quest',3,'Syntax: .quest $subcommand\nType .quest to see the list of possible subcommands or .help quest $subcommand to see info on subcommands'),
('quest add',3,'Syntax: .quest add #quest_id\r\n\r\nAdd to character quest log quest #quest_id. Quest started from item can''t be added by this command but correct .additem call provided in command output.'),
('quest complete',3,'Syntax: .quest complete #questid\r\nMark all quest objectives as completed for target character active quest. After this target character can go and get quest reward.'),
('quest remove',3,'Syntax: .quest remove #quest_id\r\n\r\nSet quest #quest_id state to not completed and not active (and remove from active quest list) for selected player.'),
('recall',1,'Syntax: .recall [$playername]\r\n\r\nTeleport $playername or selected player to the place where he has been before last use of a teleportation command. If no $playername is entered and no player is selected, it will teleport you.'),
('reload',3,'Syntax: .reload $subcommand\nType .reload to see the list of possible subcommands or .help reload $subcommand to see info on subcommands'),
('reload all',3,'Syntax: .reload all\r\n\r\nReload all tables with reload support added and that can be _safe_ reloaded.'),
('reload all_gossips',3,'Syntax: .reload all_gossips\nReload gossip_menu, gossip_menu_option, gossip_scripts, npc_gossip, points_of_interest tables.'),
('reload all_item',3,'Syntax: .reload all_item\nReload page_text, item_enchantment_table tables.'),
('reload all_locales',3,'Syntax: .reload all_locales\r\n\r\nReload all `locales_*` tables with reload support added and that can be _safe_ reloaded.'),
('reload all_loot',3,'Syntax: .reload all_loot\r\n\r\nReload all `*_loot_template` tables. This can be slow operation with lags for server run.'),
('reload all_npc',3,'Syntax: .reload all_npc\nReload npc_gossip, npc_option, npc_trainer, npc vendor, points of interest tables.'),
('reload all_quest',3,'Syntax: .reload all_quest\r\n\r\nReload all quest related tables if reload support added for this table and this table can be _safe_ reloaded.'),
('reload all_scripts',3,'Syntax: .reload all_scripts\nReload gameobject_scripts, event_scripts, quest_end_scripts, quest_start_scripts, spell_scripts, db_script_string, waypoint_scripts tables.'),
('reload all_spell',3,'Syntax: .reload all\r\n\r\nReload all `spell_*` tables with reload support added and that can be _safe_ reloaded.'),
('reload areatrigger_involvedrelation',3,'Syntax: .reload areatrigger_involvedrelation\nReload areatrigger_involvedrelation table.'),
('reload areatrigger_tavern',3,'Syntax: .reload areatrigger_tavern\nReload areatrigger_tavern table.'),
('reload areatrigger_teleport',3,'Syntax: .reload areatrigger_teleport\nReload areatrigger_teleport table.'),
('reload autobroadcast',3,'Syntax: .reload autobroadcast\nReload autobroadcast table.'),
('reload command',3,'Syntax: .reload command\nReload command table.'),
('reload conditions', 3, 'Reload conditions table.'),
('reload config',3,'Syntax: .reload config\r\n\r\nReload config settings (by default stored in trinityd.conf). Not all settings can be change at reload: some new setting values will be ignored until restart, some values will applied with delay or only to new objects/maps, some values will explicitly rejected to change at reload.'),
('reload creature_involvedrelation',3,'Syntax: .reload creature_involvedrelation\nReload creature_involvedrelation table.'),
('reload creature_linked_respawn',2,'Syntax: .reload creature_linked_respawn\r\nReload creature_linked_respawn table.'),
('reload creature_loot_template',3,'Syntax: .reload creature_loot_template\nReload creature_loot_template table.'),
('reload creature_onkill_reputation','3','Syntax: .reload creature_onkill_reputation\r\nReload creature_onkill_reputation table.'),
('reload creature_questrelation',3,'Syntax: .reload creature_questrelation\nReload creature_questrelation table.'),
('reload disables',3,'Syntax: .reload disables\r\nReload disables table.'),
('reload disenchant_loot_template',3,'Syntax: .reload disenchant_loot_template\nReload disenchant_loot_template table.'),
('reload event_scripts',3,'Syntax: .reload event_scripts\nReload event_scripts table.'),
('reload fishing_loot_template',3,'Syntax: .reload fishing_loot_template\nReload fishing_loot_template table.'),
('reload gameobject_involvedrelation',3,'Syntax: .reload gameobject_involvedrelation\nReload gameobject_involvedrelation table.'),
('reload gameobject_loot_template',3,'Syntax: .reload gameobject_loot_template\nReload gameobject_loot_template table.'),
('reload gameobject_questrelation',3,'Syntax: .reload gameobject_questrelation\nReload gameobject_questrelation table.'),
('reload gameobject_scripts',3,'Syntax: .reload gameobject_scripts\nReload gameobject_scripts table.'),
('reload game_graveyard_zone',3,'Syntax: .reload game_graveyard_zone\nReload game_graveyard_zone table.'),
('reload game_tele',3,'Syntax: .reload game_tele\nReload game_tele table.'),
('reload gossip_menu',3,'Syntax: .reload gossip_menu\nReload gossip_menu table.'),
('reload gossip_menu_option',3,'Syntax: .reload gossip_menu_option\nReload gossip_menu_option table.'),
('reload gossip_scripts',3,'Syntax: .reload gossip_scripts\nReload gossip_scripts table.'),
('reload gm_tickets',3,'Syntax: .reload gm_tickets\nReload gm_tickets table.'),
('reload item_enchantment_template',3,'Syntax: .reload item_enchantment_template\nReload item_enchantment_template table.'),
('reload item_loot_template',3,'Syntax: .reload item_loot_template\nReload item_loot_template table.'),
('reload item_set_names',3,'Syntax: .reload item_set_names\nReload item_set_names table.'),
('reload lfg_dungeon_encounters',3,'Syntax: .reload lfg_dungeon_encounters\nReload lfg_dungeon_encounters table.'),
('reload lfg_dungeon_rewards',3,'Syntax: .reload lfg_dungeon_rewards\nReload lfg_dungeon_rewards table.'),
('reload locales_creature',3,'Syntax: .reload locales_creature\nReload locales_creature table.'),
('reload locales_gameobject',3,'Syntax: .reload locales_gameobject\nReload locales_gameobject table.'),
('reload locales_gossip_menu_option',3, 'Syntax: .reload locales_gossip_menu_option\nReload locales_gossip_menu_option table.'),
('reload locales_item',3,'Syntax: .reload locales_item\nReload locales_item table.'),
('reload locales_item_set_name',3,'Syntax: .reload locales_item_set_name\nReload locales_item_set_name table.'),
('reload locales_npc_text',3,'Syntax: .reload locales_npc_text\nReload locales_npc_text table.'),
('reload locales_page_text',3,'Syntax: .reload locales_page_text\nReload locales_page_text table.'),
('reload locales_points_of_interest',3,'Syntax: .reload locales_points_of_interest\nReload locales_point_of_interest table.'),
('reload locales_quest',3,'Syntax: .reload locales_quest\nReload locales_quest table.'),
('reload milling_loot_template',3,'Syntax: .reload milling_loot_template\nReload milling_loot_template table.'),
('reload npc_gossip',3,'Syntax: .reload npc_gossip\nReload npc_gossip table.'),
('reload npc_trainer',3,'Syntax: .reload npc_trainer\nReload npc_trainer table.'),
('reload npc_vendor',3,'Syntax: .reload npc_vendor\nReload npc_vendor table.'),
('reload page_text',3,'Syntax: .reload page_text\nReload page_text table.'),
('reload pickpocketing_loot_template',3,'Syntax: .reload pickpocketing_loot_template\nReload pickpocketing_loot_template table.'),
('reload points_of_interest',3,'Syntax: .reload points_of_interest\nReload points_of_interest table.'),
('reload prospecting_loot_template',3,'Syntax: .reload prospecting_loot_template\nReload prospecting_loot_template table.'),
('reload quest_end_scripts',3,'Syntax: .reload quest_end_scripts\nReload quest_end_scripts table.'),
('reload mail_loot_template',3,'Syntax: .reload mail_loot_template\nReload mail_loot_template table.'),
('reload quest_poi',3,'Syntax: .reload quest_poi\nReload quest_poi table.'),
('reload quest_start_scripts',3,'Syntax: .reload quest_start_scripts\nReload quest_start_scripts table.'),
('reload quest_template',3,'Syntax: .reload quest_template\nReload quest_template table.'),
('reload reference_loot_template',3,'Syntax: .reload reference_loot_template\nReload reference_loot_template table.'),
('reload reserved_name',3,'Syntax: .reload reserved_name\nReload reserved_name table.'),
('reload skill_discovery_template',3,'Syntax: .reload skill_discovery_template\nReload skill_discovery_template table.'),
('reload skill_extra_item_template',3,'Syntax: .reload skill_extra_item_template\nReload skill_extra_item_template table.'),
('reload skill_fishing_base_level',3,'Syntax: .reload skill_fishing_base_level\nReload skill_fishing_base_level table.'),
('reload skinning_loot_template',3,'Syntax: .reload skinning_loot_template\nReload skinning_loot_template table.'),
('reload spell_area',3,'Syntax: .reload spell_area\nReload spell_area table.'),
('reload spell_bonus_data',3,'Syntax: .reload spell_bonus_data\nReload spell_bonus_data table.'),
('reload spell_group',3,'Syntax: .reload spell_group\nReload spell_group table.'),
('reload spell_group_stack_rules',3,'Syntax: .reload spell_group\nReload spell_group_stack_rules table.'),
('reload spell_learn_spell',3,'Syntax: .reload spell_learn_spell\nReload spell_learn_spell table.'),
('reload spell_linked_spell',3,'Usage: .reload spell_linked_spell\r\nReloads the spell_linked_spell DB table.'),
('reload spell_loot_template',3,'Syntax: .reload spell_loot_template\nReload spell_loot_template table.'),
('reload spell_pet_auras',3,'Syntax: .reload spell_pet_auras\nReload spell_pet_auras table.'),
('reload spell_proc_event',3,'Syntax: .reload spell_proc_event\nReload spell_proc_event table.'),
('reload spell_required',3,'Syntax: .reload spell_required\nReload spell_required table.'),
('reload spell_scripts',3,'Syntax: .reload spell_scripts\nReload spell_scripts table.'),
('reload spell_target_position',3,'Syntax: .reload spell_target_position\nReload spell_target_position table.'),
('reload spell_threats',3,'Syntax: .reload spell_threats\nReload spell_threats table.'),
('reload creature_template','3','Syntax: .reload creature_template $entry\r\nReload the specified creature''s template.'),
('reload trinity_string',3,'Syntax: .reload trinity_string\nReload trinity_string table.'),
('reload waypoint_scripts',3,'Syntax: .reload waypoint_scripts\nReload waypoint_scripts table.'),
('repairitems',2,'Syntax: .repairitems\r\n\r\nRepair all selected player''s items.'),
('reset',3,'Syntax: .reset $subcommand\nType .reset to see the list of possible subcommands or .help reset $subcommand to see info on subcommands'),
('reset achievements',3,'Syntax: .reset achievements [$playername]\r\n\r\nReset achievements data for selected or named (online or offline) character. Achievements for persistance progress data like completed quests/etc re-filled at reset. Achievements for events like kills/casts/etc will lost.'),
('reset all',3,'Syntax: .reset all spells\r\n\r\nSyntax: .reset all talents\r\n\r\nRequest reset spells or talents (including talents for all character''s pets if any) at next login each existed character.'),
('reset honor',3,'Syntax: .reset honor [Playername]\r\n  Reset all honor data for targeted character.'),
('reset level',3,'Syntax: .reset level [Playername]\r\n  Reset level to 1 including reset stats and talents.  Equipped items with greater level requirement can be lost.'),
('reset spells',3,'Syntax: .reset spells [Playername]\r\n  Removes all non-original spells from spellbook.\r\n. Playername can be name of offline character.'),
('reset stats',3,'Syntax: .reset stats [Playername]\r\n  Resets(recalculate) all stats of the targeted player to their original VALUESat current level.'),
('reset talents',3,'Syntax: .reset talents [Playername]\r\n  Removes all talents of the targeted player or pet or named player. Playername can be name of offline character. With player talents also will be reset talents for all character''s pets if any.'),
('respawn',3,'Syntax: .respawn\r\n\r\nRespawn all nearest creatures and GO without waiting respawn time expiration.'),
('revive',3,'Syntax: .revive\r\n\r\nRevive the selected player. If no player is selected, it will revive you.'),
('save',0,'Syntax: .save\r\n\r\nSaves your character.'),
('saveall',1,'Syntax: .saveall\r\n\r\nSave all characters in game.'),
('send items',3,'Syntax: .send items #playername \"#subject\" \"#text\" itemid1[:count1] itemid2[:count2] ... itemidN[:countN]\r\n\r\nSend a mail to a player. Subject and mail text must be in \"\". If for itemid not provided related count values then expected 1, if count > max items in stack then items will be send in required amount stacks. All stacks amount in mail limited to 12.'),
('send mail',1,'Syntax: .send mail #playername \"#subject\" \"#text\"\r\n\r\nSend a mail to a player. Subject and mail text must be in \"\".'),
('send message',3,'Syntax: .send message $playername $message\r\n\r\nSend screen message to player from ADMINISTRATOR.'),
('send money',3,'Syntax: .send money #playername \"#subject\" \"#text\" #money\r\n\r\nSend mail with money to a player. Subject and mail text must be in \"\".'),
('server',3,'Syntax: .server $subcommand\nType .server to see the list of possible subcommands or .help server $subcommand to see info on subcommands'),
('server corpses',2,'Syntax: .server corpses\r\n\r\nTriggering corpses expire check in world.'),
('server exit',4,'Syntax: .server exit\r\n\r\nTerminate trinity-core NOW. Exit code 0.'),
('server idlerestart',3,'Syntax: .server idlerestart #delay\r\n\r\nRestart the server after #delay seconds if no active connections are present (no players). Use #exist_code or 2 as program exist code.'),
('server idlerestart cancel',3,'Syntax: .server idlerestart cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('server idleshutdown',3,'Syntax: .server idleshutdown #delay [#exist_code]\r\n\r\nShut the server down after #delay seconds if no active connections are present (no players). Use #exist_code or 0 as program exist code.'),
('server idleshutdown cancel',3,'Syntax: .server idleshutdown cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('server info',0,'Syntax: .server info\r\n\r\nDisplay server version and the number of connected players.'),
('server motd',0,'Syntax: .server motd\r\n\r\nShow server Message of the day.'),
('server plimit',3,'Syntax: .server plimit [#num|-1|-2|-3|reset|player|moderator|gamemaster|administrator]\r\n\r\nWithout arg show current player amount and security level limitations for login to server, with arg set player linit ($num > 0) or securiti limitation ($num < 0 or security leme name. With `reset` sets player limit to the one in the config file'),
('server restart',3,'Syntax: .server restart #delay\r\n\r\nRestart the server after #delay seconds. Use #exist_code or 2 as program exist code.'),
('server restart cancel',3,'Syntax: .server restart cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('server set closed',3,'Syntax: server set closed on/off\r\n\r\nSets whether the world accepts new client connectsions.'),
('server set loglevel',4,'Syntax: .server set loglevel #level\r\n\r\nSet server log level (0 - errors only, 1 - basic, 2 - detail, 3 - debug).'),
('server set motd',3,'Syntax: .server set motd $MOTD\r\n\r\nSet server Message of the day.'),
('server shutdown',3,'Syntax: .server shutdown #delay [#exit_code]\r\n\r\nShut the server down after #delay seconds. Use #exit_code or 0 as program exit code.'),
('server shutdown cancel',3,'Syntax: .server shutdown cancel\r\n\r\nCancel the restart/shutdown timer if any.'),
('setskill',3,'Syntax: .setskill #skill #level [#max]\r\n\r\nSet a skill of id #skill with a current skill value of #level and a maximum value of #max (or equal current maximum if not provide) for the selected character. If no character is selected, you learn the skill.'),
('showarea',3,'Syntax: .showarea #areaid\r\n\r\nReveal the area of #areaid to the selected character. If no character is selected, reveal this area to you.'),
('start',0,'Syntax: .start\r\n\r\nTeleport you to the starting area of your character.'),
('summon',1,'Syntax: .summon [$charactername]\r\n\r\nTeleport the given character to you. Character can be offline.'),
('taxicheat',1,'Syntax: .taxicheat on/off\r\n\r\nTemporary grant access or remove to all taxi routes for the selected character. If no character is selected, hide or reveal all routes to you.\r\n\r\nVisited taxi nodes sill accessible after removing access.'),
('tele',1,'Syntax: .tele #location\r\n\r\nTeleport player to a given location.'),
('tele add',3,'Syntax: .tele add $name\r\n\r\nAdd current your position to .tele command target locations list with name $name.'),
('tele del',3,'Syntax: .tele del $name\r\n\r\nRemove location with name $name for .tele command locations list.'),
('tele group',1,'Syntax: .tele group#location\r\n\r\nTeleport a selected player and his group members to a given location.'),
('tele name',1,'Syntax: .tele name [#playername] #location\r\n\r\nTeleport the given character to a given location. Character can be offline.'),
('ticket',1,'Syntax: .ticket $subcommand\nType .ticket to see the list of possible subcommands or .help ticket $subcommand to see info on subcommands'),
('ticket assign',1,'Usage: .ticket assign $ticketid $gmname.\r\nAssigns the specified ticket to the specified Game Master.'),
('ticket close',1,'Usage: .ticket close $ticketid.\r\nCloses the specified ticket. Does not delete permanently.'),
('ticket closedlist',1,'Displays a list of closed GM tickets.'),
('ticket comment',1,'Usage: .ticket comment $ticketid $comment.\r\nAllows the adding or modifying of a comment to the specified ticket.'),
('ticket delete',3,'Usage: .ticket delete $ticketid.\r\nDeletes the specified ticket permanently. Ticket must be closed first.'),
('ticket list',1,'Displays a list of open GM tickets.'),
('ticket onlinelist',1,'Displays a list of open GM tickets whose owner is online.'),
('ticket unassign',1,'Usage: .ticket unassign $ticketid.\r\nUnassigns the specified ticket from the current assigned Game Master.'),
('ticket viewid',1,'Usage: .ticket viewid $ticketid.\r\nReturns details about specified ticket. Ticket must be open and not deleted.'),
('ticket viewname',1,'Usage: .ticket viewname $creatorname. \r\nReturns details about specified ticket. Ticket must be open and not deleted.'),
('titles add',2,'Syntax: .titles add #title\r\nAdd title #title (id or shift-link) to known titles list for selected player.'),
('titles current',2,'Syntax: .titles current #title\r\nSet title #title (id or shift-link) as current selected titl for selected player. If title not in known title list for player then it will be added to list.'),
('titles remove',2,'Syntax: .titles remove #title\r\nRemove title #title (id or shift-link) from known titles list for selected player.'),
('titles setmask',2,'Syntax: .titles setmask #mask\r\n\r\nAllows user to use all titles from #mask.\r\n\r\n #mask=0 disables the title-choose-field'),
('unaura',3,'Syntax: .unaura #spellid\r\n\r\nRemove aura due to spell #spellid from the selected Unit.'),
('unban',3,'Syntax: .unban $subcommand\nType .unban to see the list of possible subcommands or .help unban $subcommand to see info on subcommands'),
('unban account',3,'Syntax: .unban account $Name\r\nUnban accounts for account name pattern.'),
('unban character',3,'Syntax: .unban character $Name\r\nUnban accounts for character name pattern.'),
('unban ip',3,'Syntax : .unban ip $Ip\r\nUnban accounts for IP pattern.'),
('unbindsight',3,'Syntax: .unbindsight\r\n\r\nRemoves bound vision. Cannot be used while currently possessing a target.'),
('unfreeze',1,'Syntax: .unfreeze (#player)\r\n\"Unfreezes\" #player and enables his chat again. When using this without #name it will unfreeze your target.'),
('unlearn',3,'Syntax: .unlearn #spell [all]\r\n\r\nUnlearn for selected player a spell #spell.  If ''all'' provided then all ranks unlearned.'),
('unmute',1,'Syntax: .unmute [$playerName]\r\n\r\nRestore chat messaging for any character from account of character $playerName (or selected). Character can be ofline.'),
('unpossess',3,'Syntax: .unpossess\r\n\r\nIf you are possessed, unpossesses yourself; otherwise unpossesses current possessed target.'),
('waterwalk',2,'Syntax: .waterwalk on/off\r\n\r\nSet on/off waterwalk state for selected player or self if no player selected.'),
('wchange',3,'Syntax: .wchange #weathertype #status\r\n\r\nSet current weather to #weathertype with an intensity of #status.\r\n\r\n#weathertype can be 1 for rain, 2 for snow, and 3 for sand. #status can be 0 for disabled, and 1 for enabled.'),
('whispers',1,'Syntax: .whispers on|off\r\nEnable/disable accepting whispers by GM from players. By default use trinityd.conf setting.'),
('wp event',2,'Syntax: .wp event $subcommand\nType .path event to see the list of possible subcommands or .help path event $subcommand to see info on subcommands.'),
('wp load',2,'Syntax: .wp load $pathid\nLoad pathid number for selected creature. Creature must have no waypoint data.'),
('wp show',2,'Syntax: .wp show $option\nOptions:\non $pathid (or selected creature with loaded path) - Show path\noff - Hide path\ninfo $slected_waypoint - Show info for selected waypoint.'),
('wp unload',2,'Syntax: .wp unload\nUnload path for selected creature.');
/*!40000 ALTER TABLE `command` ENABLE KEYS */;
UNLOCK TABLES;

-- 
-- Table structure for `conditions`
-- 

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `SourceTypeOrReferenceId` mediumint(8) NOT NULL DEFAULT '0',
  `SourceGroup` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `SourceEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ElseGroup` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ConditionTypeOrReference` mediumint(8) NOT NULL DEFAULT '0',
  `ConditionValue1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ConditionValue2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ConditionValue3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ErrorTextId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) NOT NULL DEFAULT '',
  `Comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Condition System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature`
--

DROP TABLE IF EXISTS `creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `spawnMask` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `phaseMask` smallint(5) unsigned NOT NULL DEFAULT '1',
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipment_id` mediumint(9) NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `spawntimesecs` int(10) unsigned NOT NULL DEFAULT '120',
  `spawndist` float NOT NULL DEFAULT '0',
  `currentwaypoint` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `curhealth` int(10) unsigned NOT NULL DEFAULT '1',
  `curmana` int(10) unsigned NOT NULL DEFAULT '0',
  `DeathState` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MovementType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `idx_id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `creature` AUTO_INCREMENT=250001;

--
-- Dumping data for table `creature`
--

LOCK TABLES `creature` WRITE;
/*!40000 ALTER TABLE `creature` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_addon`
--

DROP TABLE IF EXISTS `creature_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_addon` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `path_id` int(11) unsigned NOT NULL DEFAULT '0',
  `mount` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `bytes1` int(10) unsigned NOT NULL DEFAULT '0',
  `bytes2` int(10) unsigned NOT NULL DEFAULT '0',
  `emote` int(10) unsigned NOT NULL DEFAULT '0',
  `auras` text,
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_addon`
--

LOCK TABLES `creature_addon` WRITE;
/*!40000 ALTER TABLE `creature_addon` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_addon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_ai_scripts`
--

DROP TABLE IF EXISTS `creature_ai_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_scripts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `creature_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Template Identifier',
  `event_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type',
  `event_inverse_phase_mask` int(11) NOT NULL DEFAULT '0' COMMENT 'Mask which phases this event will not trigger in',
  `event_chance` int(3) unsigned NOT NULL DEFAULT '100',
  `event_flags` int(3) unsigned NOT NULL DEFAULT '0',
  `event_param1` int(11) NOT NULL DEFAULT '0',
  `event_param2` int(11) NOT NULL DEFAULT '0',
  `event_param3` int(11) NOT NULL DEFAULT '0',
  `event_param4` int(11) NOT NULL DEFAULT '0',
  `action1_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action1_param1` int(11) NOT NULL DEFAULT '0',
  `action1_param2` int(11) NOT NULL DEFAULT '0',
  `action1_param3` int(11) NOT NULL DEFAULT '0',
  `action2_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action2_param1` int(11) NOT NULL DEFAULT '0',
  `action2_param2` int(11) NOT NULL DEFAULT '0',
  `action2_param3` int(11) NOT NULL DEFAULT '0',
  `action3_type` tinyint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type',
  `action3_param1` int(11) NOT NULL DEFAULT '0',
  `action3_param2` int(11) NOT NULL DEFAULT '0',
  `action3_param3` int(11) NOT NULL DEFAULT '0',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Event Comment',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='EventAI Scripts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_ai_scripts`
--

LOCK TABLES `creature_ai_scripts` WRITE;
/*!40000 ALTER TABLE `creature_ai_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_ai_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_ai_summons`
--

DROP TABLE IF EXISTS `creature_ai_summons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_summons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Location Identifier',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `spawntimesecs` int(11) unsigned NOT NULL DEFAULT '120',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Summon Comment',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='EventAI Summoning Locations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_ai_summons`
--

LOCK TABLES `creature_ai_summons` WRITE;
/*!40000 ALTER TABLE `creature_ai_summons` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_ai_summons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_ai_texts`
--

DROP TABLE IF EXISTS `creature_ai_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_ai_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Script Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_ai_texts`
--

LOCK TABLES `creature_ai_texts` WRITE;
/*!40000 ALTER TABLE `creature_ai_texts` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_ai_texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_classlevelstats`
--

DROP TABLE IF EXISTS `creature_classlevelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_classlevelstats` (
  `level` tinyint(1) NOT NULL,
  `class` tinyint(1) NOT NULL,
  `basehp0` smallint(2) NOT NULL,
  `basehp1` smallint(2) NOT NULL,  
  `basehp2` smallint(2) NOT NULL,  
  `basemana` smallint(2) NOT NULL,
  `basearmor` smallint(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_classlevelstats`;
--

LOCK TABLES `creature_classlevelstats` WRITE;
/*!40000 ALTER TABLE `creature_classlevelstats` DISABLE KEYS */;
INSERT INTO `creature_classlevelstats` (`class`,`level`,`basehp0`,`basehp1`,`basehp2`,`basemana`,`basearmor`) VALUES
(1,1,42,1,1,0,8),
(1,2,55,1,1,0,20),
(1,3,71,1,1,0,33),
(1,4,86,1,1,0,68),
(1,5,102,1,1,0,111),
(1,6,120,1,1,0,165),
(1,7,137,1,1,0,230),
(1,8,156,1,1,0,306),
(1,9,176,1,1,0,387),
(1,10,198,1,1,0,463),
(1,11,222,1,1,0,528),
(1,12,247,1,1,0,562),
(1,13,273,1,1,0,596),
(1,14,300,1,1,0,630),
(1,15,328,1,1,0,665),
(1,16,356,1,1,0,700),
(1,17,386,1,1,0,734),
(1,18,417,1,1,0,768),
(1,19,449,1,1,0,802),
(1,20,484,1,1,0,836),
(1,21,521,1,1,0,872),
(1,22,562,1,1,0,906),
(1,23,605,1,1,0,940),
(1,24,651,1,1,0,975),
(1,25,699,1,1,0,1008),
(1,26,750,1,1,0,1043),
(1,27,800,1,1,0,1078),
(1,28,853,1,1,0,1111),
(1,29,905,1,1,0,1145),
(1,30,955,1,1,0,1179),
(1,31,1006,1,1,0,1213),
(1,32,1057,1,1,0,1249),
(1,33,1110,1,1,0,1281),
(1,34,1163,1,1,0,1317),
(1,35,1220,1,1,0,1349),
(1,36,1277,1,1,0,1456),
(1,37,1336,1,1,0,1568),
(1,38,1395,1,1,0,1684),
(1,39,1459,1,1,0,1808),
(1,40,1524,1,1,0,1938),
(1,41,1585,1,1,0,2074),
(1,42,1651,1,1,0,2218),
(1,43,1716,1,1,0,2369),
(1,44,1782,1,1,0,2528),
(1,45,1848,1,1,0,2695),
(1,46,1919,1,1,0,2750),
(1,47,1990,1,1,0,2804),
(1,48,2062,1,1,0,2857),
(1,49,2138,1,1,0,2912),
(1,50,2215,1,1,0,2966),
(1,51,2292,1,1,0,3018),
(1,52,2371,1,1,0,3060),
(1,53,2453,1,1,0,3128),
(1,54,2533,1,1,0,3180),
(1,55,2614,1,1,0,3234),
(1,56,2699,1,1,0,3289),
(1,57,2784,1,1,0,3342),
(1,58,2871,3989,1,0,3396),
(1,59,2961,4142,1,0,3449),
(1,60,3052,4979,1,0,3750),
(1,61,3144,5158,1,0,4047),
(1,62,3237,5341,1,0,4344),
(1,63,3331,5527,1,0,4641),
(1,64,3427,5715,1,0,4937),
(1,65,3524,5914,1,0,5234),
(1,66,3624,6116,1,0,5531),
(1,67,3728,6326,1,0,5829),
(1,68,3834,6542,6986,0,6126),
(1,69,3942,6761,7984,0,6423),
(1,70,4050,6986,8982,0,6719),
(1,71,4163,7181,9291,0,7018),
(1,72,4278,7380,9610,0,7318),
(1,73,4399,7588,9940,0,7618),
(1,74,4524,7804,10282,0,7918),
(1,75,4652,8025,10635,0,8219),
(1,76,4781,8247,11001,0,8520),
(1,77,4916,8480,11379,0,8822),
(1,78,5052,8715,11770,0,9124),
(1,79,5194,8960,12175,0,9426),
(1,80,5342,9215,12600,0,9729),
(1,81,5492,9474,13033,0,10033),
(1,82,5647,1,13481,0,10356),
(1,83,5808,1,13945,0,10673),
(1,84,1,1,1,0,1),
(1,85,1,1,1,0,1),
(1,86,1,1,1,0,1),
(1,87,1,1,1,0,1),
(1,88,1,1,1,0,1),
(1,89,1,1,1,0,1),
(1,90,1,1,1,0,1),
(1,91,1,1,1,0,1),
(1,92,1,1,1,0,1),
(1,93,1,1,1,0,1),
(1,94,1,1,1,0,1),
(1,95,1,1,1,0,1),
(1,96,1,1,1,0,1),
(1,97,1,1,1,0,1),
(1,98,1,1,1,0,1),
(1,99,1,1,1,0,1),
(1,100,1,1,1,0,1),
(2,1,41,1,1,60,7),
(2,2,54,1,1,69,19),
(2,3,69,1,1,79,33),
(2,4,83,1,1,104,66),
(2,5,98,1,1,115,109),
(2,6,115,1,1,126,163),
(2,7,131,1,1,138,208),
(2,8,148,1,1,165,303),
(2,9,166,1,1,178,369),
(2,10,186,1,1,191,460),
(2,11,208,1,1,205,526),
(2,12,230,1,1,249,560),
(2,13,253,1,1,264,596),
(2,14,276,1,1,295,630),
(2,15,301,1,1,326,665),
(2,16,325,1,1,357,700),
(2,17,350,1,1,390,734),
(2,18,377,1,1,408,768),
(2,19,404,1,1,456,802),
(2,20,433,1,1,490,836),
(2,21,464,1,1,510,872),
(2,22,498,1,1,545,906),
(2,23,533,1,1,581,940),
(2,24,571,1,1,618,975),
(2,25,610,1,1,655,1008),
(2,26,651,1,1,693,1042),
(2,27,690,1,1,732,1078),
(2,28,732,1,1,756,1110),
(2,29,773,1,1,811,1145),
(2,30,811,1,1,852,1178),
(2,31,850,1,1,878,1213),
(2,32,888,1,1,935,1248),
(2,33,928,1,1,963,1281),
(2,34,967,1,1,1007,1316),
(2,35,1009,1,1,1067,1349),
(2,36,1050,1,1,1097,1455),
(2,37,1093,1,1,1142,1567),
(2,38,1135,1,1,1189,1683),
(2,39,1180,1,1,1236,1807),
(2,40,1226,1,1,1283,1937),
(2,41,1268,1,1,1332,2072),
(2,42,1321,1,1,1381,2216),
(2,43,1373,1,1,1432,2367),
(2,44,1426,1,1,1483,2527),
(2,45,1478,1,1,1534,2692),
(2,46,1535,1,1,1587,2749),
(2,47,1592,1,1,1640,2802),
(2,48,1650,1,1,1695,2855),
(2,49,1710,1,1,1750,2910),
(2,50,1772,1,1,1807,2964),
(2,51,1834,1,1,1864,3017),
(2,52,1897,1,1,1923,3072),
(2,53,1962,1,1,1982,3126),
(2,54,2026,1,1,2041,3178),
(2,55,2091,1,1,2117,3232),
(2,56,2159,1,1,2163,3287),
(2,57,2227,1,1,2241,3340),
(2,58,2297,3191,1,2289,3394),
(2,59,2369,3314,1,2369,3447),
(2,60,2442,3984,1,2434,3748),
(2,61,2515,4126,1,2486,4044),
(2,62,2590,4274,1,2568,4340),
(2,63,2665,4422,1,2620,4637),
(2,64,2740,4572,1,2705,4933),
(2,65,2819,4731,1,2790,5228),
(2,66,2899,4892,6116,2846,5523),
(2,67,2982,5060,1,2933,5821),
(2,68,3067,5233,6986,2991,6116),
(2,69,3153,5409,7984,3080,6412),
(2,70,3240,5589,8982,3155,6708),
(2,71,3330,5744,9291,3231,7007),
(2,72,3422,5903,9610,3309,7305),
(2,73,3519,6070,9940,3387,7604),
(2,74,3619,6243,10282,3466,7903),
(2,75,3722,6420,10635,3561,8204),
(2,76,3825,6602,11001,3643,8503),
(2,77,3933,6784,11379,3725,8803),
(2,78,4042,6972,11770,3809,9104),
(2,79,4155,7167,12175,3893,9405),
(2,80,4274,7373,12600,3994,9706),
(2,81,4394,7581,13033,4081,10007),
(2,82,4518,7794,13481,4169,10253),
(2,83,4646,1,13945,4258,10573),
(2,84,1,1,1,1,1),
(2,85,1,1,1,1,1),
(2,86,1,1,1,1,1),
(2,87,1,1,1,1,1),
(2,88,1,1,1,1,1),
(2,89,1,1,1,1,1),
(2,90,1,1,1,1,1),
(2,91,1,1,1,1,1),
(2,92,1,1,1,1,1),
(2,93,1,1,1,1,1),
(2,94,1,1,1,1,1),
(2,95,1,1,1,1,1),
(2,96,1,1,1,1,1),
(2,97,1,1,1,1,1),
(2,98,1,1,1,1,1),
(2,99,1,1,1,1,1),
(2,100,1,1,1,1,1),
(4,1,42,1,1,0,6),
(4,2,55,1,1,0,18),
(4,3,71,1,1,0,31),
(4,4,86,1,1,0,63),
(4,5,102,1,1,0,102),
(4,6,120,1,1,0,152),
(4,7,137,1,1,0,212),
(4,8,156,1,1,0,286),
(4,9,176,1,1,0,363),
(4,10,198,1,1,0,443),
(4,11,222,1,1,0,488),
(4,12,247,1,1,0,519),
(4,13,273,1,1,0,553),
(4,14,300,1,1,0,577),
(4,15,328,1,1,0,612),
(4,16,356,1,1,0,645),
(4,17,386,1,1,0,676),
(4,18,417,1,1,0,706),
(4,19,449,1,1,0,738),
(4,20,484,1,1,0,769),
(4,21,521,1,1,0,801),
(4,22,562,1,1,0,833),
(4,23,605,1,1,0,863),
(4,24,651,1,1,0,895),
(4,25,699,1,1,0,926),
(4,26,750,1,1,0,957),
(4,27,800,1,1,0,989),
(4,28,853,1,1,0,1020),
(4,29,905,1,1,0,1051),
(4,30,955,1,1,0,1082),
(4,31,1006,1,1,0,1113),
(4,32,1057,1,1,0,1146),
(4,33,1110,1,1,0,1173),
(4,34,1163,1,1,0,1208),
(4,35,1220,1,1,0,1237),
(4,36,1277,1,1,0,1349),
(4,37,1336,1,1,0,1434),
(4,38,1395,1,1,0,1538),
(4,39,1459,1,1,0,1649),
(4,40,1524,1,1,0,1764),
(4,41,1585,1,1,0,1886),
(4,42,1651,1,1,0,2015),
(4,43,1716,1,1,0,2148),
(4,44,1782,1,1,0,2303),
(4,45,1848,1,1,0,2436),
(4,46,1919,1,1,0,2485),
(4,47,1990,1,1,0,2535),
(4,48,2062,1,1,0,2582),
(4,49,2138,1,1,0,2631),
(4,50,2215,1,1,0,2680),
(4,51,2292,1,1,0,2728),
(4,52,2371,1,1,0,2778),
(4,53,2453,1,1,0,2826),
(4,54,2533,1,1,0,2874),
(4,55,2614,1,1,0,2922),
(4,56,2699,1,1,0,2972),
(4,57,2784,1,1,0,3020),
(4,58,2871,3989,1,0,3068),
(4,59,2961,4142,1,0,3117),
(4,60,3052,4979,1,0,3388),
(4,61,3144,5158,1,0,3655),
(4,62,3237,5341,1,0,3922),
(4,63,3331,5527,1,0,4189),
(4,64,3427,5715,1,0,4457),
(4,65,3524,5914,1,0,4724),
(4,66,3624,6116,1,0,5104),
(4,67,3728,6326,1,0,5326),
(4,68,3834,6542,6986,0,5527),
(4,69,3942,6761,7984,0,5795),
(4,70,4050,6986,8982,0,6062),
(4,71,4163,7181,9291,0,6332),
(4,72,4278,7380,9610,0,6602),
(4,73,4399,7580,9940,0,6872),
(4,74,4524,1,10282,0,7143),
(4,75,4652,1,10635,0,7415),
(4,76,4781,1,11001,0,7686),
(4,77,4916,1,11379,0,7958),
(4,78,5052,1,11770,0,8230),
(4,79,5194,1,12175,0,8503),
(4,80,5342,1,12600,0,8776),
(4,81,5496,1,13033,0,9068),
(4,82,5647,1,13481,0,9348),
(4,83,5808,1,13945,0,9589),
(4,84,1,1,1,0,1),
(4,85,1,1,1,0,1),
(4,86,1,1,1,0,1),
(4,87,1,1,1,0,1),
(4,88,1,1,1,0,1),
(4,89,1,1,1,0,1),
(4,90,1,1,1,0,1),
(4,91,1,1,1,0,1),
(4,92,1,1,1,0,1),
(4,93,1,1,1,0,1),
(4,94,1,1,1,0,1),
(4,95,1,1,1,0,1),
(4,96,1,1,1,0,1),
(4,97,1,1,1,0,1),
(4,98,1,1,1,0,1),
(4,99,1,1,1,0,1),
(4,100,1,1,1,0,1),
(8,1,40,1,1,120,5),
(8,2,52,1,1,147,16),
(8,3,67,1,1,174,28),
(8,4,81,1,1,202,57),
(8,5,95,1,1,230,93),
(8,6,111,1,1,259,139),
(8,7,126,1,1,289,194),
(8,8,143,1,1,319,265),
(8,9,160,1,1,350,339),
(8,10,178,1,1,382,423),
(8,11,199,1,1,459,447),
(8,12,219,1,1,537,475),
(8,13,241,1,1,601,509),
(8,14,263,1,1,710,523),
(8,15,285,1,1,790,559),
(8,16,307,1,1,856,589),
(8,17,330,1,1,938,617),
(8,18,354,1,1,1020,643),
(8,19,379,1,1,1118,674),
(8,20,405,1,1,1202,701),
(8,21,432,1,1,1272,729),
(8,22,463,1,1,1357,759),
(8,23,494,1,1,1443,786),
(8,24,528,1,1,1545,815),
(8,25,562,1,1,1633,843),
(8,26,598,1,1,1707,871),
(8,27,633,1,1,1812,900),
(8,28,669,1,1,1977,928),
(8,29,704,1,1,2068,957),
(8,30,737,1,1,2175,984),
(8,31,770,1,1,2253,1012),
(8,32,802,1,1,2362,1042),
(8,33,835,1,1,2457,1065),
(8,34,867,1,1,2553,1098),
(8,35,902,1,1,2680,1124),
(8,36,935,1,1,2763,1241),
(8,37,970,1,1,2861,1300),
(8,38,1004,1,1,2975,1391),
(8,39,1040,1,1,3075,1489),
(8,40,1077,1,1,3191,1590),
(8,41,1110,1,1,3293,1697),
(8,42,1156,1,1,3471,1811),
(8,43,1201,1,1,3575,1926),
(8,44,1247,1,1,3680,2078),
(8,45,1294,1,1,3801,2177),
(8,46,1343,1,1,3923,2220),
(8,47,1393,1,1,4031,2265),
(8,48,1443,1,1,4140,2307),
(8,49,1497,1,1,4281,2349),
(8,50,1551,1,1,4393,2393),
(8,51,1604,1,1,4506,2437),
(8,52,1660,1,1,4650,2481),
(8,53,1717,1,1,4765,2524),
(8,54,1773,1,1,4896,2567),
(8,55,1830,1,1,5013,2609),
(8,56,1889,1,1,5206,2654),
(8,57,1949,1,1,5340,2698),
(8,58,2010,2793,1,5461,2740),
(8,59,2073,2899,1,5598,2784),
(8,60,2136,3484,1,5751,3025),
(8,61,2201,3611,1,5875,3263),
(8,62,2266,3739,1,6015,3500),
(8,63,2332,3870,1,6156,3736),
(8,64,2399,4000,1,6229,3977),
(8,65,2467,4140,4731,6443,4214),
(8,66,2552,4281,4892,6588,4460),
(8,67,2610,4429,1,6749,4710),
(8,68,2684,4580,5588,6882,4928),
(8,69,2759,4733,6387,7031,5167),
(8,70,2835,4890,7185,7196,5404),
(8,71,2914,5027,7432,7332,5645),
(8,72,2995,5166,7688,7500,5886),
(8,73,3098,5311,7952,7654,6126),
(8,74,3186,1,8225,7809,6368),
(8,75,3256,5617,8508,7981,6610),
(8,76,3367,1,8800,8139,6851),
(8,77,3462,1,9103,8313,7094),
(8,78,3558,1,9416,8459,7335),
(8,79,3658,1,9740,8636,7579),
(8,80,3739,1,10080,8814,7822),
(8,81,3870,1,10486,8979,8102),
(8,82,3977,1,10784,9160,8340),
(8,83,4090,1,11156,9325,8505),
(8,84,1,1,1,1,1),
(8,85,1,1,1,1,1),
(8,86,1,1,1,1,1),
(8,87,1,1,1,1,1),
(8,88,1,1,1,1,1),
(8,89,1,1,1,1,1),
(8,90,1,1,1,1,1),
(8,91,1,1,1,1,1),
(8,92,1,1,1,1,1),
(8,93,1,1,1,1,1),
(8,94,1,1,1,1,1),
(8,95,1,1,1,1,1),
(8,96,1,1,1,1,1),
(8,97,1,1,1,1,1),
(8,98,1,1,1,1,1),
(8,99,1,1,1,1,1),
(8,100,1,1,1,1,1);
/*!40000 ALTER TABLE `creature_classlevelstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_equip_template`
--

DROP TABLE IF EXISTS `creature_equip_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_equip_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique entry',
  `equipentry1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipentry2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipentry3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Equipment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_equip_template`
--

LOCK TABLES `creature_equip_template` WRITE;
/*!40000 ALTER TABLE `creature_equip_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_equip_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_formations`
--

DROP TABLE IF EXISTS `creature_formations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_formations` (
  `leaderGUID` int(11) unsigned NOT NULL,
  `memberGUID` int(11) unsigned NOT NULL,
  `dist` float unsigned NOT NULL,
  `angle` float unsigned NOT NULL,
  `groupAI` int(11) unsigned NOT NULL,
  PRIMARY KEY (`memberGUID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_formations`
--

LOCK TABLES `creature_formations` WRITE;
/*!40000 ALTER TABLE `creature_formations` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_formations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_involvedrelation`
--

DROP TABLE IF EXISTS `creature_involvedrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_involvedrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_involvedrelation`
--

LOCK TABLES `creature_involvedrelation` WRITE;
/*!40000 ALTER TABLE `creature_involvedrelation` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_involvedrelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_linked_respawn`
--

DROP TABLE IF EXISTS `creature_linked_respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_linked_respawn` (
  `guid` int(10) unsigned NOT NULL COMMENT 'dependent creature',
  `linkedGuid` int(10) unsigned NOT NULL COMMENT 'master creature',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature Respawn Link System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_linked_respawn`
--

LOCK TABLES `creature_linked_respawn` WRITE;
/*!40000 ALTER TABLE `creature_linked_respawn` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_linked_respawn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_loot_template`
--

DROP TABLE IF EXISTS `creature_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_loot_template`
--

LOCK TABLES `creature_loot_template` WRITE;
/*!40000 ALTER TABLE `creature_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_model_info`
--

DROP TABLE IF EXISTS `creature_model_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_model_info` (
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `bounding_radius` float NOT NULL DEFAULT '0',
  `combat_reach` float NOT NULL DEFAULT '0',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `modelid_other_gender` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`modelid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Creature System (Model related info)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_model_info`
--

LOCK TABLES `creature_model_info` WRITE;
/*!40000 ALTER TABLE `creature_model_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_model_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_onkill_reputation`
--

DROP TABLE IF EXISTS `creature_onkill_reputation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_onkill_reputation` (
  `creature_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `RewOnKillRepFaction1` smallint(6) NOT NULL DEFAULT '0',
  `RewOnKillRepFaction2` smallint(6) NOT NULL DEFAULT '0',
  `MaxStanding1` tinyint(4) NOT NULL DEFAULT '0',
  `IsTeamAward1` tinyint(4) NOT NULL DEFAULT '0',
  `RewOnKillRepValue1` mediumint(9) NOT NULL DEFAULT '0',
  `MaxStanding2` tinyint(4) NOT NULL DEFAULT '0',
  `IsTeamAward2` tinyint(4) NOT NULL DEFAULT '0',
  `RewOnKillRepValue2` mediumint(9) NOT NULL DEFAULT '0',
  `TeamDependent` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`creature_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Creature OnKill Reputation gain';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_onkill_reputation`
--

LOCK TABLES `creature_onkill_reputation` WRITE;
/*!40000 ALTER TABLE `creature_onkill_reputation` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_onkill_reputation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_questrelation`
--

DROP TABLE IF EXISTS `creature_questrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_questrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_questrelation`
--

LOCK TABLES `creature_questrelation` WRITE;
/*!40000 ALTER TABLE `creature_questrelation` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_questrelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_respawn`
--

DROP TABLE IF EXISTS `creature_respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Grid Loading System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_respawn`
--

LOCK TABLES `creature_respawn` WRITE;
/*!40000 ALTER TABLE `creature_respawn` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_respawn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_template`
--

DROP TABLE IF EXISTS `creature_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `difficulty_entry_1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `difficulty_entry_2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `difficulty_entry_3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `KillCredit1` int(11) unsigned NOT NULL DEFAULT '0',
  `KillCredit2` int(11) unsigned NOT NULL DEFAULT '0',
  `modelid1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `modelid2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `modelid3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `modelid4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` char(100) NOT NULL DEFAULT '0',
  `subname` char(100) DEFAULT NULL,
  `IconName` char(100) DEFAULT NULL,
  `gossip_menu_id` mediumint(8) unsigned NOT NULL default '0',
  `minlevel` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `maxlevel` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `exp` smallint(2) NOT NULL DEFAULT '0',
  `faction_A` smallint(5) unsigned NOT NULL DEFAULT '0',
  `faction_H` smallint(5) unsigned NOT NULL DEFAULT '0',
  `npcflag` int(10) unsigned NOT NULL DEFAULT '0',
  `speed_walk` float NOT NULL default '1' COMMENT 'Result of 2.5/2.5, most common value',
  `speed_run` float NOT NULL default '1.14286' COMMENT 'Result of 8.0/7.0, most common value',
  `scale` float NOT NULL DEFAULT '1',
  `rank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mindmg` float NOT NULL DEFAULT '0',
  `maxdmg` float NOT NULL DEFAULT '0',
  `dmgschool` tinyint(4) NOT NULL DEFAULT '0',
  `attackpower` int(10) unsigned NOT NULL DEFAULT '0',
  `dmg_multiplier` float NOT NULL DEFAULT '1',
  `baseattacktime` int(10) unsigned NOT NULL DEFAULT '0',
  `rangeattacktime` int(10) unsigned NOT NULL DEFAULT '0',
  `unit_class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `unit_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `dynamicflags` int(10) unsigned NOT NULL DEFAULT '0',
  `family` tinyint(4) NOT NULL DEFAULT '0',
  `trainer_type` tinyint(4) NOT NULL DEFAULT '0',
  `trainer_spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `trainer_class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `trainer_race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `minrangedmg` float NOT NULL DEFAULT '0',
  `maxrangedmg` float NOT NULL DEFAULT '0',
  `rangedattackpower` smallint(5) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `type_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `lootid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `pickpocketloot` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `skinloot` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `resistance1` smallint(5) NOT NULL DEFAULT '0',
  `resistance2` smallint(5) NOT NULL DEFAULT '0',
  `resistance3` smallint(5) NOT NULL DEFAULT '0',
  `resistance4` smallint(5) NOT NULL DEFAULT '0',
  `resistance5` smallint(5) NOT NULL DEFAULT '0',
  `resistance6` smallint(5) NOT NULL DEFAULT '0',
  `spell1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell6` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell7` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell8` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `PetSpellDataId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `VehicleId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mingold` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `maxgold` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `AIName` char(64) NOT NULL DEFAULT '',
  `MovementType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `InhabitType` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `Health_mod` float NOT NULL DEFAULT '1',
  `Mana_mod` float NOT NULL DEFAULT '1',
  `Armor_mod` float NOT NULL DEFAULT '1',
  `RacialLeader` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `questItem1` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem2` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem3` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem4` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem5` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem6` int(11) unsigned NOT NULL DEFAULT '0',
  `movementId` int(11) unsigned NOT NULL DEFAULT '0',
  `RegenHealth` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `equipment_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mechanic_immune_mask` int(10) unsigned NOT NULL DEFAULT '0',
  `flags_extra` int(10) unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) NOT NULL DEFAULT '',
  `WDBVerified` smallint(5) signed DEFAULT '1',
  PRIMARY KEY (`entry`),
  KEY `idx_name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_template`
--

LOCK TABLES `creature_template` WRITE;
/*!40000 ALTER TABLE `creature_template` DISABLE KEYS */;
INSERT INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction_A`,`faction_H`,`npcflag`,`speed_walk`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`equipment_id`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`) VALUES
(1,0,0,0,0,0,10045,0,0,0,'Waypoint (Only GM can see it)','Visual',NULL,0,1,80,0,35,35,0,0.91,1,0,7,7,0,3,1,2000,2200,1,4096,0,0,0,0,0,0,1.76,2.42,100,8,5242886,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,7,0.0125,1,1,0,0,0,0,0,0,0,0,1,0,0,130,'');
/*!40000 ALTER TABLE `creature_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_template_addon`
--

DROP TABLE IF EXISTS `creature_template_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_template_addon` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `path_id` int(11) unsigned NOT NULL DEFAULT '0',
  `mount` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `bytes1` int(10) unsigned NOT NULL DEFAULT '0',
  `bytes2` int(10) unsigned NOT NULL DEFAULT '0',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `auras` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_template_addon`
--

LOCK TABLES `creature_template_addon` WRITE;
/*!40000 ALTER TABLE `creature_template_addon` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_template_addon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creature_transport`
--

DROP TABLE IF EXISTS `creature_transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `creature_transport` (
  `guid` int(16) NOT NULL AUTO_INCREMENT COMMENT 'GUID of NPC on transport - not the same as creature.guid',
  `transport_entry` int(8) NOT NULL COMMENT 'Transport entry',
  `npc_entry` int(8) NOT NULL COMMENT 'NPC entry',
  `TransOffsetX` float NOT NULL DEFAULT '0',
  `TransOffsetY` float NOT NULL DEFAULT '0',
  `TransOffsetZ` float NOT NULL DEFAULT '0',
  `TransOffsetO` float NOT NULL DEFAULT '0',
  `emote` int(16) NOT NULL,
  PRIMARY KEY (`transport_entry`,`guid`),
  UNIQUE KEY `entry` (`transport_entry`,`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creature_transport`
--

LOCK TABLES `creature_transport` WRITE;
/*!40000 ALTER TABLE `creature_transport` DISABLE KEYS */;
/*!40000 ALTER TABLE `creature_transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_texts`
--

DROP TABLE IF EXISTS `custom_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_texts` (
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Custom Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_texts`
--

LOCK TABLES `custom_texts` WRITE;
/*!40000 ALTER TABLE `custom_texts` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_script_string`
--

DROP TABLE IF EXISTS `db_script_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_script_string` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0',
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_script_string`
--

LOCK TABLES `db_script_string` WRITE;
/*!40000 ALTER TABLE `db_script_string` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_script_string` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disables`
--

DROP TABLE IF EXISTS `disables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disables` (
  `sourceType` int(10) unsigned NOT NULL,
  `entry` int(10) unsigned NOT NULL,
  `flags` tinyint(3) unsigned NOT NULL default '0',
  `comment` varchar(255) character set utf8 NOT NULL default '',
  PRIMARY KEY  (`sourceType`,`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disables`
--

LOCK TABLES `disables` WRITE;
/*!40000 ALTER TABLE `disables` DISABLE KEYS */;
/*!40000 ALTER TABLE `disables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disenchant_loot_template`
--

DROP TABLE IF EXISTS `disenchant_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disenchant_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Recommended id selection: item_level*100 + item_quality',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disenchant_loot_template`
--

LOCK TABLES `disenchant_loot_template` WRITE;
/*!40000 ALTER TABLE `disenchant_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `disenchant_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_scripts`
--

DROP TABLE IF EXISTS `event_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_scripts` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_scripts`
--

LOCK TABLES `event_scripts` WRITE;
/*!40000 ALTER TABLE `event_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exploration_basexp`
--

DROP TABLE IF EXISTS `exploration_basexp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exploration_basexp` (
  `level` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `basexp` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Exploration System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exploration_basexp`
--

LOCK TABLES `exploration_basexp` WRITE;
/*!40000 ALTER TABLE `exploration_basexp` DISABLE KEYS */;
INSERT INTO `exploration_basexp` VALUES
(0,0),
(1,5),
(2,15),
(3,25),
(4,35),
(5,45),
(6,55),
(7,65),
(8,70),
(9,80),
(10,85),
(11,90),
(12,90),
(13,90),
(14,100),
(15,105),
(16,115),
(17,125),
(18,135),
(19,145),
(20,155),
(21,165),
(22,175),
(23,185),
(24,195),
(25,200),
(26,210),
(27,220),
(28,230),
(29,240),
(30,245),
(31,250),
(32,255),
(33,265),
(34,270),
(35,275),
(36,280),
(37,285),
(38,285),
(39,300),
(40,315),
(41,330),
(42,345),
(43,360),
(44,375),
(45,390),
(46,405),
(47,420),
(48,440),
(49,455),
(50,470),
(51,490),
(52,510),
(53,530),
(54,540),
(55,560),
(56,580),
(57,600),
(58,620),
(59,640),
(60,660),
(61,970),
(62,1000),
(63,1050),
(64,1080),
(65,1100),
(66,1130),
(67,1160),
(68,1200),
(69,1230),
(70,1300),
(71,1330),
(72,1370),
(73,1410),
(74,1440),
(75,1470),
(76,1510),
(77,1530),
(78,1600),
(79,1630);
/*!40000 ALTER TABLE `exploration_basexp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fishing_loot_template`
--

DROP TABLE IF EXISTS `fishing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_loot_template`
--

LOCK TABLES `fishing_loot_template` WRITE;
/*!40000 ALTER TABLE `fishing_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `fishing_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event`
--

DROP TABLE IF EXISTS `game_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event` (
  `entry` mediumint(8) unsigned NOT NULL COMMENT 'Entry of the game event',
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute start date, the event will never start before',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute end date, the event will never start afler',
  `occurence` bigint(20) unsigned NOT NULL DEFAULT '5184000' COMMENT 'Delay in minutes between occurences of the event',
  `length` bigint(20) unsigned NOT NULL DEFAULT '2592000' COMMENT 'Length in minutes of the event',
  `holiday` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Client side holiday id',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of the event displayed in console',
  `world_event` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 if normal event, 1 if world event',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event`
--

LOCK TABLES `game_event` WRITE;
/*!40000 ALTER TABLE `game_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_battleground_holiday`
--

DROP TABLE IF EXISTS `game_event_battleground_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_battleground_holiday` (
  `event` int(10) unsigned NOT NULL,
  `bgflag` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_battleground_holiday`
--

LOCK TABLES `game_event_battleground_holiday` WRITE;
/*!40000 ALTER TABLE `game_event_battleground_holiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_battleground_holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_condition`
--

DROP TABLE IF EXISTS `game_event_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_condition` (
  `event_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `req_num` float DEFAULT '0',
  `max_world_state_field` smallint(5) unsigned NOT NULL DEFAULT '0',
  `done_world_state_field` smallint(5) unsigned NOT NULL DEFAULT '0',
  `description` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`event_id`,`condition_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_condition`
--

LOCK TABLES `game_event_condition` WRITE;
/*!40000 ALTER TABLE `game_event_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_creature`
--

DROP TABLE IF EXISTS `game_event_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature` (
  `guid` int(10) unsigned NOT NULL,
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Put negatives values to remove during event',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_creature`
--

LOCK TABLES `game_event_creature` WRITE;
/*!40000 ALTER TABLE `game_event_creature` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_creature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_creature_quest`
--

DROP TABLE IF EXISTS `game_event_creature_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_creature_quest` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `event` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_creature_quest`
--

LOCK TABLES `game_event_creature_quest` WRITE;
/*!40000 ALTER TABLE `game_event_creature_quest` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_creature_quest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_gameobject`
--

DROP TABLE IF EXISTS `game_event_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_gameobject` (
  `guid` int(10) unsigned NOT NULL,
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Put negatives values to remove during event',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_gameobject`
--

LOCK TABLES `game_event_gameobject` WRITE;
/*!40000 ALTER TABLE `game_event_gameobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_gameobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_gameobject_quest`
--

DROP TABLE IF EXISTS `game_event_gameobject_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_gameobject_quest` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `event` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`quest`,`event`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_gameobject_quest`
--

LOCK TABLES `game_event_gameobject_quest` WRITE;
/*!40000 ALTER TABLE `game_event_gameobject_quest` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_gameobject_quest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_model_equip`
--

DROP TABLE IF EXISTS `game_event_model_equip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_model_equip` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `modelid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `equipment_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `event` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_model_equip`
--

LOCK TABLES `game_event_model_equip` WRITE;
/*!40000 ALTER TABLE `game_event_model_equip` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_model_equip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_npc_gossip`
--

DROP TABLE IF EXISTS `game_event_npc_gossip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_npc_gossip` (
  `guid` int(10) unsigned NOT NULL,
  `event_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `textid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_npc_gossip`
--

LOCK TABLES `game_event_npc_gossip` WRITE;
/*!40000 ALTER TABLE `game_event_npc_gossip` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_npc_gossip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_npc_vendor`
--

DROP TABLE IF EXISTS `game_event_npc_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_npc_vendor` (
  `event` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `guid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `slot` smallint(6) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) NOT NULL DEFAULT '0',
  `maxcount` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `incrtime` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ExtendedCost` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '',
  PRIMARY KEY (`guid`,`item`),
  INDEX (`slot`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_npc_vendor`
--

LOCK TABLES `game_event_npc_vendor` WRITE;
/*!40000 ALTER TABLE `game_event_npc_vendor` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_npc_vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_npcflag`
--

DROP TABLE IF EXISTS `game_event_npcflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_npcflag` (
  `guid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `event_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `npcflag` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`event_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_npcflag`
--

LOCK TABLES `game_event_npcflag` WRITE;
/*!40000 ALTER TABLE `game_event_npcflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_npcflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_pool`
--

DROP TABLE IF EXISTS `game_event_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_pool` (
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Id of the pool',
  `event` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Put negatives values to remove during event',
  PRIMARY KEY (`pool_entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_pool`
--

LOCK TABLES `game_event_pool` WRITE;
/*!40000 ALTER TABLE `game_event_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_prerequisite`
--

DROP TABLE IF EXISTS `game_event_prerequisite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_prerequisite` (
  `event_id` mediumint(8) unsigned NOT NULL,
  `prerequisite_event` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`event_id`,`prerequisite_event`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_prerequisite`
--

LOCK TABLES `game_event_prerequisite` WRITE;
/*!40000 ALTER TABLE `game_event_prerequisite` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_prerequisite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event_quest_condition`
--

DROP TABLE IF EXISTS `game_event_quest_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_quest_condition` (
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `event_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `num` float DEFAULT '0',
  PRIMARY KEY (`quest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_quest_condition`
--

LOCK TABLES `game_event_quest_condition` WRITE;
/*!40000 ALTER TABLE `game_event_quest_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_event_quest_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_graveyard_zone`
--

DROP TABLE IF EXISTS `game_graveyard_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_graveyard_zone` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ghost_zone` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ghost_zone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Trigger System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_graveyard_zone`
--

LOCK TABLES `game_graveyard_zone` WRITE;
/*!40000 ALTER TABLE `game_graveyard_zone` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_graveyard_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_tele`
--

DROP TABLE IF EXISTS `game_tele`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_tele` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Tele Command';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_tele`
--

LOCK TABLES `game_tele` WRITE;
/*!40000 ALTER TABLE `game_tele` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_tele` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_weather`
--

DROP TABLE IF EXISTS `game_weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_weather` (
  `zone` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spring_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `spring_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `spring_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `summer_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `summer_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `summer_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `fall_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `fall_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `fall_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `winter_rain_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `winter_snow_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `winter_storm_chance` tinyint(3) unsigned NOT NULL DEFAULT '25',
  `ScriptName` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`zone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Weather System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_weather`
--

LOCK TABLES `game_weather` WRITE;
/*!40000 ALTER TABLE `game_weather` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_weather` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject`
--

DROP TABLE IF EXISTS `gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Gameobject Identifier',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `spawnMask` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `phaseMask` smallint(5) unsigned NOT NULL DEFAULT '1',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `rotation0` float NOT NULL DEFAULT '0',
  `rotation1` float NOT NULL DEFAULT '0',
  `rotation2` float NOT NULL DEFAULT '0',
  `rotation3` float NOT NULL DEFAULT '0',
  `spawntimesecs` int(11) NOT NULL DEFAULT '0',
  `animprogress` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `gameobject` AUTO_INCREMENT=200001;

--
-- Dumping data for table `gameobject`
--

LOCK TABLES `gameobject` WRITE;
/*!40000 ALTER TABLE `gameobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject_involvedrelation`
--

DROP TABLE IF EXISTS `gameobject_involvedrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_involvedrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameobject_involvedrelation`
--

LOCK TABLES `gameobject_involvedrelation` WRITE;
/*!40000 ALTER TABLE `gameobject_involvedrelation` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameobject_involvedrelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject_loot_template`
--

DROP TABLE IF EXISTS `gameobject_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameobject_loot_template`
--

LOCK TABLES `gameobject_loot_template` WRITE;
/*!40000 ALTER TABLE `gameobject_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameobject_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject_questrelation`
--

DROP TABLE IF EXISTS `gameobject_questrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_questrelation` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameobject_questrelation`
--

LOCK TABLES `gameobject_questrelation` WRITE;
/*!40000 ALTER TABLE `gameobject_questrelation` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameobject_questrelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject_respawn`
--

DROP TABLE IF EXISTS `gameobject_respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Grid Loading System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameobject_respawn`
--

LOCK TABLES `gameobject_respawn` WRITE;
/*!40000 ALTER TABLE `gameobject_respawn` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameobject_respawn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject_scripts`
--

DROP TABLE IF EXISTS `gameobject_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_scripts` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameobject_scripts`
--

LOCK TABLES `gameobject_scripts` WRITE;
/*!40000 ALTER TABLE `gameobject_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameobject_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameobject_template`
--

DROP TABLE IF EXISTS `gameobject_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `displayId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  `IconName` varchar(100) NOT NULL DEFAULT '',
  `castBarCaption` varchar(100) NOT NULL DEFAULT '',
  `unk1` varchar(100) NOT NULL DEFAULT '',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `size` float NOT NULL DEFAULT '1',
  `questItem1` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem2` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem3` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem4` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem5` int(11) unsigned NOT NULL DEFAULT '0',
  `questItem6` int(11) unsigned NOT NULL DEFAULT '0',
  `data0` int(10) unsigned NOT NULL DEFAULT '0',
  `data1` int(11) signed NOT NULL DEFAULT '-1',
  `data2` int(10) unsigned NOT NULL DEFAULT '0',
  `data3` int(10) unsigned NOT NULL DEFAULT '0',
  `data4` int(10) unsigned NOT NULL DEFAULT '0',
  `data5` int(10) unsigned NOT NULL DEFAULT '0',
  `data6` int(11) signed NOT NULL DEFAULT '-1',
  `data7` int(10) unsigned NOT NULL DEFAULT '0',
  `data8` int(10) unsigned NOT NULL DEFAULT '0',
  `data9` int(10) unsigned NOT NULL DEFAULT '0',
  `data10` int(10) unsigned NOT NULL DEFAULT '0',
  `data11` int(10) unsigned NOT NULL DEFAULT '0',
  `data12` int(10) unsigned NOT NULL DEFAULT '0',
  `data13` int(10) unsigned NOT NULL DEFAULT '0',
  `data14` int(10) unsigned NOT NULL DEFAULT '0',
  `data15` int(10) unsigned NOT NULL DEFAULT '0',
  `data16` int(10) unsigned NOT NULL DEFAULT '0',
  `data17` int(10) unsigned NOT NULL DEFAULT '0',
  `data18` int(10) unsigned NOT NULL DEFAULT '0',
  `data19` int(10) unsigned NOT NULL DEFAULT '0',
  `data20` int(10) unsigned NOT NULL DEFAULT '0',
  `data21` int(10) unsigned NOT NULL DEFAULT '0',
  `data22` int(10) unsigned NOT NULL DEFAULT '0',
  `data23` int(10) unsigned NOT NULL DEFAULT '0',
  `ScriptName` varchar(64) NOT NULL DEFAULT '',
  `WDBVerified` smallint(5) signed DEFAULT '1',
  PRIMARY KEY (`entry`),
  KEY `idx_name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Gameobject System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameobject_template`
--

LOCK TABLES `gameobject_template` WRITE;
/*!40000 ALTER TABLE `gameobject_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameobject_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gossip_scripts`
--

DROP TABLE IF EXISTS `gossip_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_scripts` (
  `id` mediumint(8) unsigned NOT NULL default '0',
  `delay` int(10) unsigned NOT NULL default '0',
  `command` mediumint(8) unsigned NOT NULL default '0',
  `datalong` mediumint(8) unsigned NOT NULL default '0',
  `datalong2` int(10) unsigned NOT NULL default '0',
  `dataint` int(11) NOT NULL default '0',
  `x` float NOT NULL default '0',
  `y` float NOT NULL default '0',
  `z` float NOT NULL default '0',
  `o` float NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gossip_scripts`
--

LOCK TABLES `gossip_scripts` WRITE;
/*!40000 ALTER TABLE `gossip_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `gossip_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gossip_menu`
--

DROP TABLE IF EXISTS `gossip_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gossip_menu` (
  entry smallint(6) unsigned NOT NULL default '0',
  text_id mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY (entry, text_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gossip_menu`
--

LOCK TABLES `gossip_menu` WRITE;
/*!40000 ALTER TABLE `gossip_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `gossip_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gossip_menu_option`
--

DROP TABLE IF EXISTS `gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE gossip_menu_option (
  menu_id smallint(6) unsigned NOT NULL default '0',
  id smallint(6) unsigned NOT NULL default '0',
  option_icon mediumint(8) unsigned NOT NULL default '0',
  option_text text,
  option_id tinyint(3) unsigned NOT NULL default '0',
  npc_option_npcflag int(10) unsigned NOT NULL default '0',
  action_menu_id mediumint(8) unsigned NOT NULL default '0',
  action_poi_id mediumint(8) unsigned NOT NULL default '0',
  action_script_id mediumint(8) unsigned NOT NULL default '0',
  box_coded tinyint(3) unsigned NOT NULL default '0',
  box_money int(11) unsigned NOT NULL default '0',
  box_text text,
  PRIMARY KEY (menu_id, id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gossip_menu_option`
--

LOCK TABLES `gossip_menu_option` WRITE;
/*!40000 ALTER TABLE `gossip_menu_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `gossip_menu_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_template`
--

DROP TABLE IF EXISTS `instance_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_template` (
  `map` smallint(5) unsigned NOT NULL,
  `parent` int(10) unsigned NOT NULL,
  `startLocX` float DEFAULT NULL,
  `startLocY` float DEFAULT NULL,
  `startLocZ` float DEFAULT NULL,
  `startLocO` float DEFAULT NULL,
  `script` varchar(128) NOT NULL DEFAULT '',
  `allowMount` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`map`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_template`
--

LOCK TABLES `instance_template` WRITE;
/*!40000 ALTER TABLE `instance_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_enchantment_template`
--

DROP TABLE IF EXISTS `item_enchantment_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_enchantment_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ench` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`ench`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item Random Enchantment System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_enchantment_template`
--

LOCK TABLES `item_enchantment_template` WRITE;
/*!40000 ALTER TABLE `item_enchantment_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_enchantment_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_loot_template`
--

DROP TABLE IF EXISTS `item_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` smallint(5) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_loot_template`
--

LOCK TABLES `item_loot_template` WRITE;
/*!40000 ALTER TABLE `item_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_set_names`
--

DROP TABLE IF EXISTS `item_set_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_set_names` (
  `entry` mediumint(8) unsigned NOT NULL,
  `name` varchar(255) character set utf8 NOT NULL default '',
  `InventoryType` tinyint(3) unsigned NOT NULL default '0',
  `WDBVerified` smallint(5) signed NOT NULL DEFAULT '1',
  PRIMARY KEY  (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_set_names`
--

LOCK TABLES `item_set_names` WRITE;
/*!40000 ALTER TABLE `item_set_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_set_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_required_target`
--

DROP TABLE IF EXISTS `item_required_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_required_target` (
  `entry` mediumint(8) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `targetEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_required_target`
--

LOCK TABLES `item_required_target` WRITE;
/*!40000 ALTER TABLE `item_required_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_required_target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_template`
--

DROP TABLE IF EXISTS `item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `subclass` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `unk0` int(11) NOT NULL DEFAULT '-1',
  `name` varchar(255) NOT NULL DEFAULT '',
  `displayid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Quality` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Flags` bigint(20) signed NOT NULL DEFAULT '0',
  `FlagsExtra` int(10) unsigned NOT NULL DEFAULT '0',
  `BuyCount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `BuyPrice` bigint(20) signed NOT NULL DEFAULT '0',
  `SellPrice` int(10) unsigned NOT NULL DEFAULT '0',
  `InventoryType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllowableClass` int(11) NOT NULL DEFAULT '-1',
  `AllowableRace` int(11) NOT NULL DEFAULT '-1',
  `ItemLevel` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkillRank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `requiredspell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `requiredhonorrank` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RequiredCityRank` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationRank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `maxcount` int(11) signed NOT NULL DEFAULT '0',
  `stackable` int(11) signed NOT NULL DEFAULT '1',
  `ContainerSlots` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StatsCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_type1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value1` smallint(6) NOT NULL DEFAULT '0',
  `stat_type2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value2` smallint(6) NOT NULL DEFAULT '0',
  `stat_type3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value3` smallint(6) NOT NULL DEFAULT '0',
  `stat_type4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value4` smallint(6) NOT NULL DEFAULT '0',
  `stat_type5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value5` smallint(6) NOT NULL DEFAULT '0',
  `stat_type6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value6` smallint(6) NOT NULL DEFAULT '0',
  `stat_type7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value7` smallint(6) NOT NULL DEFAULT '0',
  `stat_type8` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value8` smallint(6) NOT NULL DEFAULT '0',
  `stat_type9` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value9` smallint(6) NOT NULL DEFAULT '0',
  `stat_type10` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value10` smallint(6) NOT NULL DEFAULT '0',
  `ScalingStatDistribution` smallint(6) NOT NULL DEFAULT '0',
  `ScalingStatValue` int(6) unsigned NOT NULL DEFAULT '0',
  `dmg_min1` float NOT NULL DEFAULT '0',
  `dmg_max1` float NOT NULL DEFAULT '0',
  `dmg_type1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min2` float NOT NULL DEFAULT '0',
  `dmg_max2` float NOT NULL DEFAULT '0',
  `dmg_type2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `armor` smallint(5) unsigned NOT NULL DEFAULT '0',
  `holy_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fire_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `nature_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `frost_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `shadow_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `arcane_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `delay` smallint(5) unsigned NOT NULL DEFAULT '1000',
  `ammo_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RangedModRange` float NOT NULL DEFAULT '0',
  `spellid_1` mediumint(8) signed NOT NULL DEFAULT '0',
  `spelltrigger_1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_1` smallint(4) NOT NULL DEFAULT '0',
  `spellppmRate_1` float NOT NULL DEFAULT '0',
  `spellcooldown_1` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_1` int(11) NOT NULL DEFAULT '-1',
  `spellid_2` mediumint(8) signed NOT NULL DEFAULT '0',
  `spelltrigger_2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_2` smallint(4) NOT NULL DEFAULT '0',
  `spellppmRate_2` float NOT NULL DEFAULT '0',
  `spellcooldown_2` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_2` int(11) NOT NULL DEFAULT '-1',
  `spellid_3` mediumint(8) signed NOT NULL DEFAULT '0',
  `spelltrigger_3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_3` smallint(4) NOT NULL DEFAULT '0',
  `spellppmRate_3` float NOT NULL DEFAULT '0',
  `spellcooldown_3` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_3` int(11) NOT NULL DEFAULT '-1',
  `spellid_4` mediumint(8) signed NOT NULL DEFAULT '0',
  `spelltrigger_4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_4` smallint(4) NOT NULL DEFAULT '0',
  `spellppmRate_4` float NOT NULL DEFAULT '0',
  `spellcooldown_4` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_4` int(11) NOT NULL DEFAULT '-1',
  `spellid_5` mediumint(8) signed NOT NULL DEFAULT '0',
  `spelltrigger_5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_5` smallint(4) NOT NULL DEFAULT '0',
  `spellppmRate_5` float NOT NULL DEFAULT '0',
  `spellcooldown_5` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_5` int(11) NOT NULL DEFAULT '-1',
  `bonding` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `PageText` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `LanguageID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PageMaterial` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `startquest` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `lockid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Material` tinyint(4) NOT NULL DEFAULT '0',
  `sheath` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RandomProperty` mediumint(8) signed NOT NULL DEFAULT '0',
  `RandomSuffix` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `block` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `itemset` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `MaxDurability` smallint(5) unsigned NOT NULL DEFAULT '0',
  `area` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Map` smallint(6) NOT NULL DEFAULT '0',
  `BagFamily` mediumint(9) NOT NULL DEFAULT '0',
  `TotemCategory` mediumint(9) NOT NULL DEFAULT '0',
  `socketColor_1` tinyint(4) NOT NULL DEFAULT '0',
  `socketContent_1` mediumint(9) NOT NULL DEFAULT '0',
  `socketColor_2` tinyint(4) NOT NULL DEFAULT '0',
  `socketContent_2` mediumint(9) NOT NULL DEFAULT '0',
  `socketColor_3` tinyint(4) NOT NULL DEFAULT '0',
  `socketContent_3` mediumint(9) NOT NULL DEFAULT '0',
  `socketBonus` mediumint(9) NOT NULL DEFAULT '0',
  `GemProperties` mediumint(9) NOT NULL DEFAULT '0',
  `RequiredDisenchantSkill` smallint(6) NOT NULL DEFAULT '-1',
  `ArmorDamageModifier` float NOT NULL DEFAULT '0',
  `Duration` int(11) NOT NULL DEFAULT '0' COMMENT 'Duration in seconds. Negative value means realtime, postive value ingame time',
  `ItemLimitCategory` smallint(6) NOT NULL DEFAULT '0',
  `HolidayId` int(11) unsigned NOT NULL DEFAULT '0',
  `ScriptName` varchar(64) NOT NULL DEFAULT '',
  `DisenchantID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `FoodType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `minMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0',
  `maxMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0',
  `WDBVerified` smallint(5) signed DEFAULT '1',
  PRIMARY KEY (`entry`),
  KEY `idx_name` (`name`),
  KEY `items_index` (`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_template`
--

LOCK TABLES `item_template` WRITE;
/*!40000 ALTER TABLE `item_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lfg_dungeon_encounters`
--

DROP TABLE IF EXISTS `lfg_dungeon_encounters`;
CREATE TABLE `lfg_dungeon_encounters` (
  `achievementId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Achievement marking final boss completion',
  `dungeonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Dungeon entry from dbc',
  PRIMARY KEY (`achievementId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lfg_dungeon_encounters`
--

LOCK TABLES `lfg_dungeon_encounters` WRITE;
/*!40000 ALTER TABLE `lfg_dungeon_encounters` DISABLE KEYS */;
/*!40000 ALTER TABLE `lfg_dungeon_encounters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lfg_dungeon_rewards`
--

DROP TABLE IF EXISTS `lfg_dungeon_rewards`;
CREATE TABLE `lfg_dungeon_rewards` (
  `dungeonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Dungeon entry from dbc',
  `maxLevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Max level at which this reward is rewarded',
  `firstQuestId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for first dungeon this day',
  `firstMoneyVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Money multiplier for completing the dungeon first time in a day with less players than max',
  `firstXPVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Experience multiplier for completing the dungeon first time in a day with less players than max',
  `otherQuestId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for Nth dungeon this day',
  `otherMoneyVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Money multiplier for completing the dungeon Nth time in a day with less players than max',
  `otherXPVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Experience multiplier for completing the dungeon Nth time in a day with less players than max',
  PRIMARY KEY (`dungeonId`,`maxLevel`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lfg_dungeon_rewards`
--

LOCK TABLES `lfg_dungeon_rewards` WRITE;
/*!40000 ALTER TABLE `lfg_dungeon_rewards` DISABLE KEYS */;
/*!40000 ALTER TABLE `lfg_dungeon_rewards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_achievement_reward`
--

DROP TABLE IF EXISTS `locales_achievement_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_achievement_reward` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `subject_loc1` varchar(100) NOT NULL DEFAULT '',
  `subject_loc2` varchar(100) NOT NULL DEFAULT '',
  `subject_loc3` varchar(100) NOT NULL DEFAULT '',
  `subject_loc4` varchar(100) NOT NULL DEFAULT '',
  `subject_loc5` varchar(100) NOT NULL DEFAULT '',
  `subject_loc6` varchar(100) NOT NULL DEFAULT '',
  `subject_loc7` varchar(100) NOT NULL DEFAULT '',
  `subject_loc8` varchar(100) NOT NULL DEFAULT '',
  `text_loc1` text,
  `text_loc2` text,
  `text_loc3` text,
  `text_loc4` text,
  `text_loc5` text,
  `text_loc6` text,
  `text_loc7` text,
  `text_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_achievement_reward`
--

LOCK TABLES `locales_achievement_reward` WRITE;
/*!40000 ALTER TABLE `locales_achievement_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_achievement_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_creature`
--

DROP TABLE IF EXISTS `locales_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_creature` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name_loc1` varchar(100) NOT NULL DEFAULT '',
  `name_loc2` varchar(100) NOT NULL DEFAULT '',
  `name_loc3` varchar(100) NOT NULL DEFAULT '',
  `name_loc4` varchar(100) NOT NULL DEFAULT '',
  `name_loc5` varchar(100) NOT NULL DEFAULT '',
  `name_loc6` varchar(100) NOT NULL DEFAULT '',
  `name_loc7` varchar(100) NOT NULL DEFAULT '',
  `name_loc8` varchar(100) NOT NULL DEFAULT '',
  `subname_loc1` varchar(100) DEFAULT NULL,
  `subname_loc2` varchar(100) DEFAULT NULL,
  `subname_loc3` varchar(100) DEFAULT NULL,
  `subname_loc4` varchar(100) DEFAULT NULL,
  `subname_loc5` varchar(100) DEFAULT NULL,
  `subname_loc6` varchar(100) DEFAULT NULL,
  `subname_loc7` varchar(100) DEFAULT NULL,
  `subname_loc8` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_creature`
--

LOCK TABLES `locales_creature` WRITE;
/*!40000 ALTER TABLE `locales_creature` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_creature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_gameobject`
--

DROP TABLE IF EXISTS `locales_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gameobject` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name_loc1` varchar(100) NOT NULL DEFAULT '',
  `name_loc2` varchar(100) NOT NULL DEFAULT '',
  `name_loc3` varchar(100) NOT NULL DEFAULT '',
  `name_loc4` varchar(100) NOT NULL DEFAULT '',
  `name_loc5` varchar(100) NOT NULL DEFAULT '',
  `name_loc6` varchar(100) NOT NULL DEFAULT '',
  `name_loc7` varchar(100) NOT NULL DEFAULT '',
  `name_loc8` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc1` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc2` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc3` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc4` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc5` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc6` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc7` varchar(100) NOT NULL DEFAULT '',
  `castbarcaption_loc8` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_gameobject`
--

LOCK TABLES `locales_gameobject` WRITE;
/*!40000 ALTER TABLE `locales_gameobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_gameobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_item`
--

DROP TABLE IF EXISTS `locales_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_item` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name_loc1` varchar(100) NOT NULL DEFAULT '',
  `name_loc2` varchar(100) NOT NULL DEFAULT '',
  `name_loc3` varchar(100) NOT NULL DEFAULT '',
  `name_loc4` varchar(100) NOT NULL DEFAULT '',
  `name_loc5` varchar(100) NOT NULL DEFAULT '',
  `name_loc6` varchar(100) NOT NULL DEFAULT '',
  `name_loc7` varchar(100) NOT NULL DEFAULT '',
  `name_loc8` varchar(100) NOT NULL DEFAULT '',
  `description_loc1` varchar(255) DEFAULT NULL,
  `description_loc2` varchar(255) DEFAULT NULL,
  `description_loc3` varchar(255) DEFAULT NULL,
  `description_loc4` varchar(255) DEFAULT NULL,
  `description_loc5` varchar(255) DEFAULT NULL,
  `description_loc6` varchar(255) DEFAULT NULL,
  `description_loc7` varchar(255) DEFAULT NULL,
  `description_loc8` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_item`
--

LOCK TABLES `locales_item` WRITE;
/*!40000 ALTER TABLE `locales_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_item_set_names`
--

DROP TABLE IF EXISTS `locales_item_set_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_item_set_names` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name_loc1` varchar(100) NOT NULL DEFAULT '',
  `name_loc2` varchar(100) NOT NULL DEFAULT '',
  `name_loc3` varchar(100) NOT NULL DEFAULT '',
  `name_loc4` varchar(100) NOT NULL DEFAULT '',
  `name_loc5` varchar(100) NOT NULL DEFAULT '',
  `name_loc6` varchar(100) NOT NULL DEFAULT '',
  `name_loc7` varchar(100) NOT NULL DEFAULT '',
  `name_loc8` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_item_set_names`
--

LOCK TABLES `locales_item_set_names` WRITE;
/*!40000 ALTER TABLE `locales_item_set_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_item_set_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_gossip_menu_option`
--

DROP TABLE IF EXISTS `locales_gossip_menu_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_gossip_menu_option` (
  `menu_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `option_text_loc1` text,
  `option_text_loc2` text,
  `option_text_loc3` text,
  `option_text_loc4` text,
  `option_text_loc5` text,
  `option_text_loc6` text,
  `option_text_loc7` text,
  `option_text_loc8` text,
  `box_text_loc1` text,
  `box_text_loc2` text,
  `box_text_loc3` text,
  `box_text_loc4` text,
  `box_text_loc5` text,
  `box_text_loc6` text,
  `box_text_loc7` text,
  `box_text_loc8` text,
  PRIMARY KEY (`menu_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_gossip_menu_option`
--

LOCK TABLES `locales_gossip_menu_option` WRITE;
/*!40000 ALTER TABLE `locales_gossip_menu_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_gossip_menu_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_npc_text`
--

DROP TABLE IF EXISTS `locales_npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_npc_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Text0_0_loc1` longtext,
  `Text0_0_loc2` longtext,
  `Text0_0_loc3` longtext,
  `Text0_0_loc4` longtext,
  `Text0_0_loc5` longtext,
  `Text0_0_loc6` longtext,
  `Text0_0_loc7` longtext,
  `Text0_0_loc8` longtext,
  `Text0_1_loc1` longtext,
  `Text0_1_loc2` longtext,
  `Text0_1_loc3` longtext,
  `Text0_1_loc4` longtext,
  `Text0_1_loc5` longtext,
  `Text0_1_loc6` longtext,
  `Text0_1_loc7` longtext,
  `Text0_1_loc8` longtext,
  `Text1_0_loc1` longtext,
  `Text1_0_loc2` longtext,
  `Text1_0_loc3` longtext,
  `Text1_0_loc4` longtext,
  `Text1_0_loc5` longtext,
  `Text1_0_loc6` longtext,
  `Text1_0_loc7` longtext,
  `Text1_0_loc8` longtext,
  `Text1_1_loc1` longtext,
  `Text1_1_loc2` longtext,
  `Text1_1_loc3` longtext,
  `Text1_1_loc4` longtext,
  `Text1_1_loc5` longtext,
  `Text1_1_loc6` longtext,
  `Text1_1_loc7` longtext,
  `Text1_1_loc8` longtext,
  `Text2_0_loc1` longtext,
  `Text2_0_loc2` longtext,
  `Text2_0_loc3` longtext,
  `Text2_0_loc4` longtext,
  `Text2_0_loc5` longtext,
  `Text2_0_loc6` longtext,
  `Text2_0_loc7` longtext,
  `Text2_0_loc8` longtext,
  `Text2_1_loc1` longtext,
  `Text2_1_loc2` longtext,
  `Text2_1_loc3` longtext,
  `Text2_1_loc4` longtext,
  `Text2_1_loc5` longtext,
  `Text2_1_loc6` longtext,
  `Text2_1_loc7` longtext,
  `Text2_1_loc8` longtext,
  `Text3_0_loc1` longtext,
  `Text3_0_loc2` longtext,
  `Text3_0_loc3` longtext,
  `Text3_0_loc4` longtext,
  `Text3_0_loc5` longtext,
  `Text3_0_loc6` longtext,
  `Text3_0_loc7` longtext,
  `Text3_0_loc8` longtext,
  `Text3_1_loc1` longtext,
  `Text3_1_loc2` longtext,
  `Text3_1_loc3` longtext,
  `Text3_1_loc4` longtext,
  `Text3_1_loc5` longtext,
  `Text3_1_loc6` longtext,
  `Text3_1_loc7` longtext,
  `Text3_1_loc8` longtext,
  `Text4_0_loc1` longtext,
  `Text4_0_loc2` longtext,
  `Text4_0_loc3` longtext,
  `Text4_0_loc4` longtext,
  `Text4_0_loc5` longtext,
  `Text4_0_loc6` longtext,
  `Text4_0_loc7` longtext,
  `Text4_0_loc8` longtext,
  `Text4_1_loc1` longtext,
  `Text4_1_loc2` longtext,
  `Text4_1_loc3` longtext,
  `Text4_1_loc4` longtext,
  `Text4_1_loc5` longtext,
  `Text4_1_loc6` longtext,
  `Text4_1_loc7` longtext,
  `Text4_1_loc8` longtext,
  `Text5_0_loc1` longtext,
  `Text5_0_loc2` longtext,
  `Text5_0_loc3` longtext,
  `Text5_0_loc4` longtext,
  `Text5_0_loc5` longtext,
  `Text5_0_loc6` longtext,
  `Text5_0_loc7` longtext,
  `Text5_0_loc8` longtext,
  `Text5_1_loc1` longtext,
  `Text5_1_loc2` longtext,
  `Text5_1_loc3` longtext,
  `Text5_1_loc4` longtext,
  `Text5_1_loc5` longtext,
  `Text5_1_loc6` longtext,
  `Text5_1_loc7` longtext,
  `Text5_1_loc8` longtext,
  `Text6_0_loc1` longtext,
  `Text6_0_loc2` longtext,
  `Text6_0_loc3` longtext,
  `Text6_0_loc4` longtext,
  `Text6_0_loc5` longtext,
  `Text6_0_loc6` longtext,
  `Text6_0_loc7` longtext,
  `Text6_0_loc8` longtext,
  `Text6_1_loc1` longtext,
  `Text6_1_loc2` longtext,
  `Text6_1_loc3` longtext,
  `Text6_1_loc4` longtext,
  `Text6_1_loc5` longtext,
  `Text6_1_loc6` longtext,
  `Text6_1_loc7` longtext,
  `Text6_1_loc8` longtext,
  `Text7_0_loc1` longtext,
  `Text7_0_loc2` longtext,
  `Text7_0_loc3` longtext,
  `Text7_0_loc4` longtext,
  `Text7_0_loc5` longtext,
  `Text7_0_loc6` longtext,
  `Text7_0_loc7` longtext,
  `Text7_0_loc8` longtext,
  `Text7_1_loc1` longtext,
  `Text7_1_loc2` longtext,
  `Text7_1_loc3` longtext,
  `Text7_1_loc4` longtext,
  `Text7_1_loc5` longtext,
  `Text7_1_loc6` longtext,
  `Text7_1_loc7` longtext,
  `Text7_1_loc8` longtext,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_npc_text`
--

LOCK TABLES `locales_npc_text` WRITE;
/*!40000 ALTER TABLE `locales_npc_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_npc_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_page_text`
--

DROP TABLE IF EXISTS `locales_page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_page_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Text_loc1` longtext,
  `Text_loc2` longtext,
  `Text_loc3` longtext,
  `Text_loc4` longtext,
  `Text_loc5` longtext,
  `Text_loc6` longtext,
  `Text_loc7` longtext,
  `Text_loc8` longtext,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_page_text`
--

LOCK TABLES `locales_page_text` WRITE;
/*!40000 ALTER TABLE `locales_page_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_page_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_points_of_interest`
--

DROP TABLE IF EXISTS `locales_points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_points_of_interest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `icon_name_loc1` text,
  `icon_name_loc2` text,
  `icon_name_loc3` text,
  `icon_name_loc4` text,
  `icon_name_loc5` text,
  `icon_name_loc6` text,
  `icon_name_loc7` text,
  `icon_name_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_points_of_interest`
--

LOCK TABLES `locales_points_of_interest` WRITE;
/*!40000 ALTER TABLE `locales_points_of_interest` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_points_of_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_quest`
--

DROP TABLE IF EXISTS `locales_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_quest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title_loc1` text,
  `Title_loc2` text,
  `Title_loc3` text,
  `Title_loc4` text,
  `Title_loc5` text,
  `Title_loc6` text,
  `Title_loc7` text,
  `Title_loc8` text,
  `Details_loc1` text,
  `Details_loc2` text,
  `Details_loc3` text,
  `Details_loc4` text,
  `Details_loc5` text,
  `Details_loc6` text,
  `Details_loc7` text,
  `Details_loc8` text,
  `Objectives_loc1` text,
  `Objectives_loc2` text,
  `Objectives_loc3` text,
  `Objectives_loc4` text,
  `Objectives_loc5` text,
  `Objectives_loc6` text,
  `Objectives_loc7` text,
  `Objectives_loc8` text,
  `OfferRewardText_loc1` text,
  `OfferRewardText_loc2` text,
  `OfferRewardText_loc3` text,
  `OfferRewardText_loc4` text,
  `OfferRewardText_loc5` text,
  `OfferRewardText_loc6` text,
  `OfferRewardText_loc7` text,
  `OfferRewardText_loc8` text,
  `RequestItemsText_loc1` text,
  `RequestItemsText_loc2` text,
  `RequestItemsText_loc3` text,
  `RequestItemsText_loc4` text,
  `RequestItemsText_loc5` text,
  `RequestItemsText_loc6` text,
  `RequestItemsText_loc7` text,
  `RequestItemsText_loc8` text,
  `EndText_loc1` text,
  `EndText_loc2` text,
  `EndText_loc3` text,
  `EndText_loc4` text,
  `EndText_loc5` text,
  `EndText_loc6` text,
  `EndText_loc7` text,
  `EndText_loc8` text,
  `CompletedText_loc1` text,
  `CompletedText_loc2` text,
  `CompletedText_loc3` text,
  `CompletedText_loc4` text,
  `CompletedText_loc5` text,
  `CompletedText_loc6` text,
  `CompletedText_loc7` text,
  `CompletedText_loc8` text,
  `ObjectiveText1_loc1` text,
  `ObjectiveText1_loc2` text,
  `ObjectiveText1_loc3` text,
  `ObjectiveText1_loc4` text,
  `ObjectiveText1_loc5` text,
  `ObjectiveText1_loc6` text,
  `ObjectiveText1_loc7` text,
  `ObjectiveText1_loc8` text,
  `ObjectiveText2_loc1` text,
  `ObjectiveText2_loc2` text,
  `ObjectiveText2_loc3` text,
  `ObjectiveText2_loc4` text,
  `ObjectiveText2_loc5` text,
  `ObjectiveText2_loc6` text,
  `ObjectiveText2_loc7` text,
  `ObjectiveText2_loc8` text,
  `ObjectiveText3_loc1` text,
  `ObjectiveText3_loc2` text,
  `ObjectiveText3_loc3` text,
  `ObjectiveText3_loc4` text,
  `ObjectiveText3_loc5` text,
  `ObjectiveText3_loc6` text,
  `ObjectiveText3_loc7` text,
  `ObjectiveText3_loc8` text,
  `ObjectiveText4_loc1` text,
  `ObjectiveText4_loc2` text,
  `ObjectiveText4_loc3` text,
  `ObjectiveText4_loc4` text,
  `ObjectiveText4_loc5` text,
  `ObjectiveText4_loc6` text,
  `ObjectiveText4_loc7` text,
  `ObjectiveText4_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_quest`
--

LOCK TABLES `locales_quest` WRITE;
/*!40000 ALTER TABLE `locales_quest` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_quest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_level_reward`
--

DROP TABLE IF EXISTS `mail_level_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_level_reward` (
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `raceMask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `senderEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`,`raceMask`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Mail System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_level_reward`
--

LOCK TABLES `mail_level_reward` WRITE;
/*!40000 ALTER TABLE `mail_level_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_level_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_loot_template`
--

DROP TABLE IF EXISTS `mail_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_loot_template`
--

LOCK TABLES `mail_loot_template` WRITE;
/*!40000 ALTER TABLE `mail_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milling_loot_template`
--

DROP TABLE IF EXISTS `milling_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milling_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milling_loot_template`
--

LOCK TABLES `milling_loot_template` WRITE;
/*!40000 ALTER TABLE `milling_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `milling_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_gossip`
--

DROP TABLE IF EXISTS `npc_gossip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_gossip` (
  `npc_guid` int(10) unsigned NOT NULL DEFAULT '0',
  `textid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`npc_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_gossip`
--

LOCK TABLES `npc_gossip` WRITE;
/*!40000 ALTER TABLE `npc_gossip` DISABLE KEYS */;
/*!40000 ALTER TABLE `npc_gossip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_spellclick_spells`
--

DROP TABLE IF EXISTS `npc_spellclick_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_spellclick_spells` (
  `npc_entry` int(10) unsigned NOT NULL COMMENT 'reference to creature_template',
  `spell_id` int(10) unsigned NOT NULL COMMENT 'spell which should be casted ',
  `quest_start` mediumint(8) unsigned NOT NULL COMMENT 'reference to quest_template',
  `quest_start_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `quest_end` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `cast_flags` tinyint(3) unsigned NOT NULL COMMENT 'first bit defines caster: 1=player, 0=creature; second bit defines target, same mapping as caster bit',
  `aura_required` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'player without aura cant click',
  `aura_forbidden` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'player with aura cant click',
  `user_type` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'relation with summoner: 0-no 1-friendly 2-raid 3-party player can click'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_spellclick_spells`
--

LOCK TABLES `npc_spellclick_spells` WRITE;
/*!40000 ALTER TABLE `npc_spellclick_spells` DISABLE KEYS */;
/*!40000 ALTER TABLE `npc_spellclick_spells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_text`
--

DROP TABLE IF EXISTS `npc_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_text` (
  `ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `text0_0` longtext,
  `text0_1` longtext,
  `lang0` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob0` float NOT NULL DEFAULT '0',
  `em0_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em0_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em0_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em0_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em0_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em0_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `text1_0` longtext,
  `text1_1` longtext,
  `lang1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob1` float NOT NULL DEFAULT '0',
  `em1_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em1_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em1_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em1_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em1_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em1_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `text2_0` longtext,
  `text2_1` longtext,
  `lang2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob2` float NOT NULL DEFAULT '0',
  `em2_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em2_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em2_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em2_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em2_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em2_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `text3_0` longtext,
  `text3_1` longtext,
  `lang3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob3` float NOT NULL DEFAULT '0',
  `em3_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em3_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em3_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em3_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em3_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em3_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `text4_0` longtext,
  `text4_1` longtext,
  `lang4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob4` float NOT NULL DEFAULT '0',
  `em4_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em4_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em4_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em4_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em4_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em4_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `text5_0` longtext,
  `text5_1` longtext,
  `lang5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob5` float NOT NULL DEFAULT '0',
  `em5_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em5_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em5_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em5_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em5_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em5_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `text6_0` longtext,
  `text6_1` longtext,
  `lang6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob6` float NOT NULL DEFAULT '0',
  `em6_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em6_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em6_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em6_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em6_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em6_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `text7_0` longtext,
  `text7_1` longtext,
  `lang7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prob7` float NOT NULL DEFAULT '0',
  `em7_0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em7_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em7_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em7_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em7_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `em7_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `WDBVerified` smallint(5) signed DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_text`
--

LOCK TABLES `npc_text` WRITE;
/*!40000 ALTER TABLE `npc_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `npc_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_trainer`
--

DROP TABLE IF EXISTS `npc_trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_trainer` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spell` mediumint(8) NOT NULL DEFAULT '0',
  `spellcost` int(10) unsigned NOT NULL DEFAULT '0',
  `reqskill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `reqskillvalue` smallint(5) unsigned NOT NULL DEFAULT '0',
  `reqlevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_trainer`
--

LOCK TABLES `npc_trainer` WRITE;
/*!40000 ALTER TABLE `npc_trainer` DISABLE KEYS */;
/*!40000 ALTER TABLE `npc_trainer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_vendor`
--

DROP TABLE IF EXISTS `npc_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_vendor` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `slot` smallint(6) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `incrtime` int(10) unsigned NOT NULL DEFAULT '0',
  `ExtendedCost` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`,`extendedCost`),
  INDEX (`slot`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Npc System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_vendor`
--

LOCK TABLES `npc_vendor` WRITE;
/*!40000 ALTER TABLE `npc_vendor` DISABLE KEYS */;
/*!40000 ALTER TABLE `npc_vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outdoorpvp_template`
--

DROP TABLE IF EXISTS `outdoorpvp_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outdoorpvp_template` (
  `TypeId` tinyint(2) unsigned NOT NULL,
  `ScriptName` char(64) NOT NULL DEFAULT '',
  `comment` text,
  PRIMARY KEY (`TypeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='OutdoorPvP Templates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outdoorpvp_template`
--

LOCK TABLES `outdoorpvp_template` WRITE;
/*!40000 ALTER TABLE `outdoorpvp_template` DISABLE KEYS */;
INSERT INTO `outdoorpvp_template` (`TypeId`, `Comment`) VALUES
(1, 'Hellfire Peninsula'),
(2, 'Nagrand'),
(3, 'Terokkar Forest'),
(4, 'Zangarmarsh'),
(5, 'Silithus'),
(6, 'Eastern Plaguelands');
/*!40000 ALTER TABLE `outdoorpvp_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_text`
--

DROP TABLE IF EXISTS `page_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `text` longtext NOT NULL,
  `next_page` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `WDBVerified` smallint(5) signed DEFAULT '1',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_text`
--

LOCK TABLES `page_text` WRITE;
/*!40000 ALTER TABLE `page_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_levelstats`
--

DROP TABLE IF EXISTS `pet_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_levelstats` (
  `creature_entry` mediumint(8) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `hp` smallint(5) unsigned NOT NULL,
  `mana` smallint(5) unsigned NOT NULL,
  `armor` int(10) unsigned NOT NULL DEFAULT '0',
  `str` smallint(5) unsigned NOT NULL,
  `agi` smallint(5) unsigned NOT NULL,
  `sta` smallint(5) unsigned NOT NULL,
  `inte` smallint(5) unsigned NOT NULL,
  `spi` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`creature_entry`,`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores pet levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_levelstats`
--

LOCK TABLES `pet_levelstats` WRITE;
/*!40000 ALTER TABLE `pet_levelstats` DISABLE KEYS */;
INSERT INTO `pet_levelstats` VALUES
(1,1,42,1,20,22,20,22,20,20),
(1,2,55,1,21,23,21,23,20,20),
(1,3,71,1,46,24,21,24,20,21),
(1,4,86,1,82,25,22,25,21,21),
(1,5,102,1,126,26,23,25,21,21),
(1,6,120,1,180,27,24,26,21,22),
(1,7,137,1,245,28,24,27,21,22),
(1,8,156,1,322,29,25,28,22,22),
(1,9,176,1,412,30,26,29,22,23),
(1,10,198,1,518,31,26,30,22,23),
(1,11,222,1,545,32,27,34,22,24),
(1,12,247,1,580,33,28,38,23,25),
(1,13,273,1,615,34,30,42,23,25),
(1,14,300,1,650,35,31,46,23,27),
(1,15,328,1,685,37,32,51,24,28),
(1,16,356,1,721,38,33,55,25,29),
(1,17,386,1,756,40,34,59,25,30),
(1,18,417,1,791,42,36,63,25,30),
(1,19,449,1,826,44,37,67,26,32),
(1,20,484,1,861,45,39,72,27,33),
(1,21,521,1,897,47,39,76,27,34),
(1,22,562,1,932,49,40,80,27,35),
(1,23,605,1,967,50,42,84,28,36),
(1,24,651,1,1002,52,43,88,28,37),
(1,25,699,1,1037,53,45,94,29,39),
(1,26,750,1,1072,55,46,98,30,39),
(1,27,800,1,1108,56,47,102,30,40),
(1,28,853,1,1142,58,49,106,30,41),
(1,29,905,1,1177,60,50,110,31,42),
(1,30,955,1,1212,61,52,115,32,44),
(1,31,1006,1,1247,63,53,120,32,44),
(1,32,1057,1,1283,64,54,124,33,46),
(1,33,1110,1,1317,66,56,128,33,46),
(1,34,1163,1,1353,67,57,132,33,48),
(1,35,1220,1,1387,69,59,138,35,49),
(1,36,1277,1,1494,70,60,142,35,50),
(1,37,1336,1,1607,72,61,146,35,52),
(1,38,1395,1,1724,74,63,151,36,52),
(1,39,1459,1,1849,76,64,155,36,54),
(1,40,1524,1,1980,78,66,160,37,55),
(1,41,1585,1,2117,81,68,165,38,56),
(1,42,1651,1,2262,86,69,169,38,57),
(1,43,1716,1,2414,91,71,174,39,58),
(1,44,1782,1,2574,97,72,178,39,59),
(1,45,1848,1,2742,102,74,184,40,61),
(1,46,1919,1,2798,104,75,188,41,62),
(1,47,1990,1,2853,106,77,193,41,63),
(1,48,2062,1,2907,108,79,197,42,64),
(1,49,2138,1,2963,110,80,202,42,66),
(1,50,2215,1,3018,113,82,207,43,67),
(1,51,2292,1,3072,115,84,212,44,68),
(1,52,2371,1,3128,117,85,216,44,69),
(1,53,2453,1,3183,119,87,221,45,70),
(1,54,2533,1,3237,122,89,226,45,72),
(1,55,2614,1,3292,124,91,231,47,73),
(1,56,2699,1,3348,127,92,236,47,74),
(1,57,2784,1,3402,129,94,241,48,76),
(1,58,2871,1,3457,131,96,245,48,77),
(1,59,2961,1,3512,134,98,250,49,78),
(1,60,3052,1,3814,136,100,256,50,80),
(1,61,3144,1,4113,139,102,161,51,81),
(1,62,3237,1,4410,141,105,266,52,83),
(1,63,3331,1,4708,144,107,271,53,85),
(1,64,3425,1,5006,146,110,276,54,87),
(1,65,3524,1,5303,149,113,281,55,89),
(1,66,3624,1,5601,151,116,287,56,91),
(1,67,3728,1,5900,154,119,292,57,93),
(1,68,3834,1,6197,156,122,297,58,95),
(1,69,3941,1,6495,159,125,302,59,97),
(1,70,4051,1,6794,162,128,307,60,99),
(416,70,1528,2568,2207,145,39,101,334,264),
(416,69,1464,2351,2008,144,36,100,327,262),
(416,68,1429,2298,1987,143,34,98,320,260),
(416,67,1401,2244,1900,142,33,98,313,258),
(416,66,1357,2191,1872,141,33,97,306,255),
(416,65,1335,2137,1844,140,33,97,299,250),
(416,64,1292,2084,1809,139,33,95,292,247),
(416,63,1188,2030,1732,137,32,92,285,244),
(416,62,1050,1977,1663,135,31,90,278,241),
(416,61,973,1925,1608,132,29,88,271,239),
(416,60,920,1898,1163,122,27,86,264,197),
(416,59,878,1824,1150,127,27,85,258,192),
(416,58,862,1763,1125,125,27,84,250,189),
(416,57,850,1714,1101,123,27,83,243,185),
(416,56,846,1666,1091,121,27,83,236,181),
(416,55,836,1620,1078,119,26,81,229,177),
(416,54,820,1573,1055,115,26,80,222,172),
(416,53,787,1527,1039,114,25,78,215,168),
(416,52,764,1481,1013,112,24,76,208,165),
(416,51,750,1435,996,109,22,74,202,161),
(416,50,747,1391,983,107,22,72,194,158),
(416,49,734,1347,964,105,22,69,188,155),
(416,48,726,1320,946,102,22,68,184,152),
(416,47,718,1294,928,100,22,68,181,151),
(416,46,709,1267,910,98,22,67,177,149),
(416,45,701,1240,884,96,21,67,174,148),
(416,44,693,1214,853,91,21,66,170,146),
(416,43,685,1187,808,87,20,66,167,145),
(416,42,676,1103,756,81,20,65,163,144),
(416,41,668,1063,694,77,20,65,160,143),
(416,40,650,1026,639,74,20,64,156,142),
(416,39,642,988,561,72,19,64,69,118),
(416,38,634,952,549,70,19,63,68,115),
(416,37,626,916,537,69,19,63,68,112),
(416,36,617,879,525,67,19,62,66,110),
(416,35,609,845,513,64,19,62,66,107),
(416,34,601,793,501,63,19,60,65,104),
(416,33,598,742,488,62,18,60,65,101),
(416,32,590,720,476,60,17,58,64,98),
(416,31,581,676,462,59,16,58,64,95),
(416,30,579,648,449,57,16,57,63,92),
(416,29,576,620,436,57,16,55,62,89),
(416,28,574,592,424,55,15,54,62,86),
(416,27,571,564,411,53,14,52,61,81),
(416,26,569,534,399,52,13,49,60,78),
(416,25,540,504,386,50,13,46,98,100),
(416,24,520,476,373,49,13,43,97,95),
(416,23,473,447,360,47,13,40,96,90),
(416,22,449,420,346,46,13,38,95,86),
(416,21,425,393,320,44,13,37,91,83),
(416,20,403,377,303,42,13,35,87,78),
(416,19,393,351,291,40,13,33,74,75),
(416,18,362,314,278,39,13,32,70,70),
(416,17,350,300,265,38,13,31,65,65),
(416,16,329,275,253,36,13,30,62,56),
(416,15,309,251,240,34,13,29,57,52),
(416,14,299,227,228,33,13,28,54,47),
(416,13,289,203,215,32,13,26,50,43),
(416,12,250,180,203,31,12,26,41,39),
(416,11,232,158,190,30,11,24,37,35),
(416,10,223,147,180,29,10,24,33,31),
(416,9,213,136,147,25,9,27,32,30),
(416,8,204,125,117,23,8,23,31,29),
(416,7,195,114,92,22,7,23,30,28),
(416,6,186,103,68,20,7,22,29,27),
(416,5,177,92,49,18,5,22,28,27),
(416,4,168,81,33,17,5,21,27,26),
(416,3,158,70,20,15,5,21,26,25),
(416,2,149,59,20,21,5,20,25,24),
(416,1,140,48,20,20,5,20,24,23),
(417,70,3112,2420,4400,153,108,280,133,122),
(417,69,3056,2360,4229,150,105,276,130,120),
(417,68,3000,2300,4061,148,103,271,127,117),
(417,67,2944,2252,3900,146,101,267,124,115),
(417,66,2888,2195,3745,143,99,262,121,113),
(417,65,2823,2139,3597,141,97,258,119,111),
(417,64,2758,2084,3454,139,95,253,116,109),
(417,63,2693,2030,3317,137,93,249,113,107),
(417,62,2638,1977,3186,134,91,244,111,105),
(417,61,2583,1925,3059,132,89,240,108,103),
(417,60,2529,1874,2938,130,87,235,106,101),
(417,59,2476,1824,2821,127,85,231,103,99),
(417,58,2424,1763,2709,125,83,226,101,97),
(417,57,2371,1714,2602,123,82,222,99,94),
(417,56,2318,1666,2499,120,80,217,96,92),
(417,55,2266,1620,2400,118,78,213,94,90),
(417,54,2213,1573,2305,116,77,208,92,88),
(417,53,2161,1527,2213,113,75,204,90,86),
(417,52,2108,1481,2125,111,74,199,88,84),
(417,51,2055,1435,2041,109,72,195,86,82),
(417,50,2003,1391,1959,107,71,190,84,80),
(417,49,1950,1347,1925,104,69,186,82,78),
(417,48,1889,1320,1888,102,68,181,80,76),
(417,47,1828,1294,1853,100,66,177,78,75),
(417,46,1768,1267,1817,98,65,173,77,73),
(417,45,1708,1240,1750,95,64,168,75,71),
(417,44,1648,1214,1650,91,61,164,73,70),
(417,43,1588,1187,1550,87,60,160,71,68),
(417,42,1528,1103,1484,81,59,156,70,67),
(417,41,1468,1063,1390,76,58,151,68,65),
(417,40,1408,1026,1250,73,57,146,67,64),
(417,39,1348,988,1048,71,56,142,68,62),
(417,38,1288,952,1024,70,55,139,69,61),
(417,37,1227,916,1001,68,54,138,70,60),
(417,36,1167,879,977,67,53,138,72,58),
(417,35,1107,845,953,65,52,137,73,57),
(417,34,1047,793,929,63,50,135,76,56),
(417,33,987,742,905,62,49,131,74,54),
(417,32,921,720,882,60,47,127,73,53),
(417,31,856,676,858,59,47,123,71,52),
(417,30,800,648,834,57,46,118,69,51),
(417,29,775,620,810,55,45,114,67,50),
(417,28,740,592,786,54,44,110,65,49),
(417,27,705,564,763,52,43,105,63,48),
(417,26,678,543,739,51,42,101,61,47),
(417,25,630,504,715,49,41,97,59,46),
(417,24,595,476,691,47,40,93,57,45),
(417,23,558,447,667,46,39,88,55,44),
(417,22,528,423,644,44,38,84,53,43),
(417,21,500,400,620,43,37,80,51,42),
(417,20,471,377,596,41,36,75,49,41),
(417,19,438,351,572,39,35,71,47,40),
(417,18,392,314,548,38,34,67,45,39),
(417,17,375,300,525,36,33,62,43,38),
(417,16,343,275,501,35,32,58,41,37),
(417,15,313,251,477,33,31,54,39,36),
(417,14,284,227,453,31,30,50,37,35),
(417,13,254,203,429,30,29,45,35,34),
(417,12,225,180,406,28,28,41,33,33),
(417,11,198,158,382,27,27,37,31,32),
(417,10,184,147,358,25,26,34,29,31),
(417,9,170,136,334,23,25,32,27,30),
(417,8,156,125,310,22,24,29,25,29),
(417,7,152,114,287,20,23,27,23,28),
(417,6,129,103,263,19,22,24,21,27),
(417,5,115,92,239,17,21,22,19,26),
(417,4,101,81,215,15,20,19,17,25),
(417,3,87,70,191,14,19,17,15,24),
(417,2,73,59,168,12,18,14,13,23),
(417,1,60,48,144,11,17,12,11,22),
(1860,70,4860,2885,9109,153,109,280,133,190),
(1860,69,4764,2751,8876,151,106,278,130,185),
(1860,68,4529,2598,8409,148,104,276,127,175),
(1860,67,4321,2444,7944,146,101,272,124,170),
(1860,66,4145,2391,7481,144,99,268,122,168),
(1860,65,3934,2237,7020,142,97,264,119,167),
(1860,64,3830,2184,6561,139,95,259,102,164),
(1860,63,3726,2030,6104,137,93,255,93,160),
(1860,62,3627,1977,5649,135,91,253,86,158),
(1860,61,3522,1925,5196,132,89,251,78,153),
(1860,60,3419,1874,4745,129,85,249,70,150),
(1860,59,3318,1824,4673,127,83,230,69,147),
(1860,58,3222,1763,4579,125,82,224,68,144),
(1860,57,3110,1714,4500,123,81,220,67,142),
(1860,56,3006,1666,4428,121,80,215,66,139),
(1860,55,2876,1620,4362,119,79,211,65,135),
(1860,54,2840,1573,4302,115,76,207,64,133),
(1860,53,2757,1527,4207,114,75,203,63,131),
(1860,52,2661,1481,4136,112,74,198,62,128),
(1860,51,2560,1435,4068,109,72,194,60,127),
(1860,50,2527,1391,4013,107,71,190,59,123),
(1860,49,2474,1347,3943,105,69,186,58,78),
(1860,48,2436,1320,3868,102,68,181,57,76),
(1860,47,2358,1294,3796,100,66,177,57,75),
(1860,46,2349,1267,3722,98,65,173,57,73),
(1860,45,2303,1240,3620,96,64,169,55,72),
(1860,44,2290,1214,3463,91,61,164,54,71),
(1860,43,2260,1187,3228,87,60,160,52,69),
(1860,42,2215,1103,3034,81,59,156,51,67),
(1860,41,2135,1063,2826,77,58,152,51,66),
(1860,40,2052,1026,2675,74,57,147,50,64),
(1860,39,1974,988,2496,72,56,142,49,62),
(1860,38,1924,952,2331,70,55,139,49,61),
(1860,37,1830,916,2246,69,53,138,48,59),
(1860,36,1760,879,2150,67,52,137,47,58),
(1860,35,1690,845,1911,64,51,136,46,57),
(1860,34,1574,793,1861,63,50,135,46,56),
(1860,33,1457,742,1812,62,49,131,45,54),
(1860,32,1386,720,1766,60,47,127,43,53),
(1860,31,1292,676,1715,59,47,123,42,52),
(1860,30,1215,648,1667,57,46,118,41,51),
(1860,29,1127,620,1619,57,44,114,40,49),
(1860,28,1035,592,1572,55,43,110,39,48),
(1860,27,968,564,1524,53,42,105,38,47),
(1860,26,911,534,1474,52,41,101,37,46),
(1860,25,854,504,1427,50,40,97,36,44),
(1860,24,823,476,1378,49,39,93,35,43),
(1860,23,746,447,1330,47,38,89,34,42),
(1860,22,699,420,1282,46,36,84,33,41),
(1860,21,653,393,1232,44,36,80,32,39),
(1860,20,606,377,1165,42,35,67,31,49),
(1860,19,566,351,1120,40,33,63,30,46),
(1860,18,528,314,1068,39,33,59,28,38),
(1860,17,490,300,1022,38,31,55,28,42),
(1860,16,455,275,975,36,30,52,27,39),
(1860,15,421,251,925,34,30,48,26,37),
(1860,14,368,227,878,33,28,44,25,35),
(1860,13,354,203,827,32,28,43,26,32),
(1860,12,322,180,782,31,26,36,24,31),
(1860,11,291,158,734,30,25,32,22,28),
(1860,10,260,147,694,29,25,29,22,26),
(1860,9,113,136,180,25,22,27,4,0),
(1860,8,104,125,160,23,21,25,4,0),
(1860,7,95,114,140,22,20,21,3,0),
(1860,6,86,103,120,20,19,16,3,0),
(1860,5,77,92,100,18,18,12,2,0),
(1860,4,68,81,80,17,17,8,2,0),
(1860,3,58,70,60,15,16,4,1,0),
(1860,2,49,59,40,14,15,2,1,0),
(1860,1,40,48,20,12,14,1,1,0),
(1863,70,2164,2405,4293,153,108,280,133,122),
(1863,69,2118,2351,3800,151,106,271,130,119),
(1863,68,2073,2298,3450,148,104,266,127,117),
(1863,67,2027,2244,3150,146,101,262,124,114),
(1863,66,1982,2191,2910,144,99,258,122,112),
(1863,65,1936,2137,2700,142,97,254,119,109),
(1863,64,1891,2084,2550,139,95,249,116,107),
(1863,63,1845,2030,2440,137,93,245,113,105),
(1863,62,1800,1977,2380,135,91,241,111,103),
(1863,61,1754,1925,2300,132,89,237,108,101),
(1863,60,1709,1874,2261,130,87,232,106,98),
(1863,59,1666,1824,2230,128,86,228,103,96),
(1863,58,1623,1763,2189,125,84,224,101,94),
(1863,57,1580,1714,2156,123,82,220,99,92),
(1863,56,1536,1666,2113,121,80,215,96,90),
(1863,55,1493,1620,2089,119,79,211,94,88),
(1863,54,1450,1573,2056,116,77,207,92,87),
(1863,53,1407,1527,2020,114,75,203,90,85),
(1863,52,1364,1481,1984,112,74,198,88,83),
(1863,51,1320,1435,1945,109,72,194,86,81),
(1863,50,1277,1391,1912,107,71,190,84,80),
(1863,49,1234,1347,1878,105,69,186,82,78),
(1863,48,1196,1320,1843,102,68,181,80,76),
(1863,47,1158,1294,1808,100,66,177,78,75),
(1863,46,1119,1267,1773,98,65,173,77,73),
(1863,45,1081,1240,1738,96,64,169,75,72),
(1863,44,1043,1214,1670,91,61,164,74,71),
(1863,43,1005,1187,1560,87,60,160,72,69),
(1863,42,976,1103,1448,81,59,156,70,67),
(1863,41,928,1063,1338,77,58,152,68,66),
(1863,40,890,1026,1244,74,57,147,67,64),
(1863,39,852,988,1163,72,56,142,68,62),
(1863,38,814,952,1095,70,55,139,69,61),
(1863,37,776,916,1038,69,53,138,70,59),
(1863,36,737,879,990,67,52,137,72,58),
(1863,35,699,845,950,63,51,136,73,57),
(1863,34,661,793,908,64,50,135,76,56),
(1863,33,728,742,884,62,49,131,74,54),
(1863,32,680,720,862,60,47,127,73,53),
(1863,31,631,676,838,59,47,123,71,52),
(1863,30,599,648,815,57,46,118,69,51),
(1863,29,566,620,791,57,44,114,67,49),
(1863,28,534,592,768,55,43,110,65,48),
(1863,27,501,564,745,53,42,105,63,47),
(1863,26,469,534,721,52,41,101,62,46),
(1863,25,440,504,699,50,40,97,60,44),
(1863,24,400,476,675,49,39,93,57,43),
(1863,23,373,447,652,47,38,89,56,42),
(1863,22,349,420,628,46,36,84,54,41),
(1863,21,325,393,604,44,36,80,53,39),
(1863,20,303,377,563,42,35,67,31,49),
(1863,19,293,351,550,40,33,72,29,39),
(1863,18,262,314,510,39,32,67,24,38),
(1863,17,250,300,460,37,31,63,20,37),
(1863,16,229,275,400,36,30,59,16,36),
(1863,15,209,251,360,34,29,55,14,35),
(1863,14,189,227,320,33,28,50,11,35),
(1863,13,169,203,280,31,27,46,9,34),
(1863,12,150,180,240,29,26,42,8,33),
(1863,11,132,158,220,28,25,38,6,32),
(1863,10,123,147,200,26,23,33,5,31),
(1863,9,113,136,180,25,22,29,4,31),
(1863,8,104,125,160,23,21,25,4,30),
(1863,7,95,114,140,22,20,21,3,29),
(1863,6,86,103,120,20,19,16,3,29),
(1863,5,77,92,100,18,18,12,2,28),
(1863,4,68,81,80,17,17,8,2,27),
(1863,3,58,70,60,15,16,4,1,27),
(1863,2,49,59,40,14,15,2,1,26),
(1863,1,40,48,20,12,14,1,1,25),
(510,1,60,60,0,20,16,20,13,8),
(510,2,73,73,0,21,17,21,14,10),
(510,3,87,87,0,22,18,22,15,12),
(510,4,101,101,0,23,19,23,16,14),
(510,5,115,115,0,24,20,24,17,16),
(510,6,129,129,0,25,21,25,18,18),
(510,7,152,152,0,26,22,26,19,20),
(510,8,156,156,0,27,23,27,20,22),
(510,9,170,170,0,28,24,28,21,24),
(510,10,184,184,0,29,25,29,22,26),
(510,11,198,198,0,30,25,32,22,28),
(510,12,225,225,0,31,26,36,24,31),
(510,13,254,254,0,32,28,43,26,32),
(510,14,284,254,0,33,28,44,25,35),
(510,15,313,313,0,34,30,48,26,37),
(510,16,343,343,0,36,30,52,27,39),
(510,17,375,375,0,38,31,55,28,42),
(510,18,392,392,0,39,33,59,28,44),
(510,19,438,438,0,40,33,63,30,46),
(510,20,471,471,0,42,35,67,31,49),
(510,21,500,500,0,44,36,80,31,51),
(510,22,528,528,0,46,36,84,32,53),
(510,23,558,558,0,47,38,89,33,55),
(510,24,595,595,0,49,39,83,34,58),
(510,25,630,630,0,50,40,87,35,61),
(510,26,678,678,0,52,41,91,36,62),
(510,27,705,705,0,53,42,95,37,65),
(510,28,740,740,0,55,43,99,38,67),
(510,29,775,775,0,56,44,103,39,70),
(510,30,800,800,0,58,46,107,40,72),
(510,31,856,856,0,59,47,111,40,74),
(510,32,921,921,0,61,48,115,41,77),
(510,33,987,987,0,62,49,119,42,79),
(510,34,1047,1047,0,63,51,123,43,82),
(510,35,1107,1107,0,65,52,127,44,84),
(510,36,1167,1167,0,66,53,131,45,87),
(510,37,1227,1227,0,68,53,135,46,89),
(510,38,1288,1288,0,70,55,139,47,91),
(510,39,1348,1348,0,72,56,143,48,94),
(510,40,1408,1408,0,74,58,148,49,97),
(510,41,1468,1468,0,76,59,152,50,99),
(510,42,1528,1528,0,81,59,156,51,102),
(510,43,1588,1588,0,86,61,160,52,104),
(510,44,1648,1648,0,89,62,164,53,107),
(510,45,1708,1708,0,91,64,169,54,109),
(510,46,1768,1768,0,94,65,173,55,112),
(510,47,1828,1828,0,96,66,178,56,115),
(510,48,1889,1889,0,99,68,182,57,117),
(510,49,1950,1950,0,101,69,186,58,120),
(510,50,2003,2003,0,104,71,191,59,123),
(510,51,2055,2055,0,107,72,195,61,126),
(510,52,2108,2108,0,109,73,199,62,128),
(510,53,2161,2161,0,112,75,204,63,131),
(510,54,2213,2213,0,114,76,208,64,134),
(510,55,2266,2266,0,117,77,213,65,136),
(510,56,2318,2318,0,119,79,217,66,139),
(510,57,2371,2371,0,122,80,221,67,142),
(510,58,2424,2425,0,124,82,226,68,144),
(510,59,2476,2476,0,127,83,230,69,147),
(510,60,2529,1874,0,129,85,234,70,150),
(510,61,2582,2682,0,130,86,238,71,153),
(510,62,2635,2735,0,131,87,242,72,156),
(510,63,2688,2788,0,132,88,246,73,159),
(510,64,2741,2841,0,133,89,250,74,162),
(510,65,2794,2894,0,134,90,254,75,165),
(510,66,2847,2947,0,135,91,258,76,168),
(510,67,2900,3000,0,136,92,262,77,171),
(510,68,2953,3053,0,137,93,266,78,174),
(510,69,3006,3100,0,138,94,280,79,177),
(510,70,3059,3212,0,139,95,284,80,180),
(19668,1,100,0,100,10,10,0,0,0),
(19668,2,100,0,100,10,10,0,0,0),
(19668,3,100,0,100,10,10,0,0,0),
(19668,4,100,0,100,10,10,0,0,0),
(19668,5,100,0,100,10,10,0,0,0),
(19668,6,100,0,100,10,10,0,0,0),
(19668,7,100,0,100,10,10,0,0,0),
(19668,8,100,0,100,10,10,0,0,0),
(19668,9,100,0,100,10,10,0,0,0),
(19668,10,100,0,100,10,10,0,0,0),
(19668,11,100,0,100,10,10,0,0,0),
(19668,12,100,0,100,10,10,0,0,0),
(19668,13,100,0,100,10,10,0,0,0),
(19668,14,100,0,100,10,10,0,0,0),
(19668,15,100,0,100,10,10,0,0,0),
(19668,16,100,0,100,10,10,0,0,0),
(19668,17,100,0,100,10,10,0,0,0),
(19668,18,100,0,100,10,10,0,0,0),
(19668,19,100,0,100,10,10,0,0,0),
(19668,20,100,0,100,10,10,0,0,0),
(19668,21,100,0,100,10,10,0,0,0),
(19668,22,100,0,100,10,10,0,0,0),
(19668,23,100,0,100,10,10,0,0,0),
(19668,24,100,0,100,10,10,0,0,0),
(19668,25,100,0,100,10,10,0,0,0),
(19668,26,100,0,100,10,10,0,0,0),
(19668,27,100,0,100,10,10,0,0,0),
(19668,28,100,0,100,10,10,0,0,0),
(19668,29,100,0,100,10,10,0,0,0),
(19668,30,100,0,100,10,10,0,0,0),
(19668,31,100,0,100,10,10,0,0,0),
(19668,32,100,0,100,10,10,0,0,0),
(19668,33,100,0,100,10,10,0,0,0),
(19668,34,100,0,100,10,10,0,0,0),
(19668,35,100,0,100,10,10,0,0,0),
(19668,36,100,0,100,10,10,0,0,0),
(19668,37,100,0,100,10,10,0,0,0),
(19668,38,100,0,100,10,10,0,0,0),
(19668,39,100,0,100,10,10,0,0,0),
(19668,40,100,0,100,10,10,0,0,0),
(19668,41,100,0,100,10,10,0,0,0),
(19668,42,100,0,100,10,10,0,0,0),
(19668,43,100,0,100,10,10,0,0,0),
(19668,44,100,0,100,10,10,0,0,0),
(19668,45,100,0,100,10,10,0,0,0),
(19668,46,100,0,100,10,10,0,0,0),
(19668,47,100,0,100,10,10,0,0,0),
(19668,48,100,0,100,10,10,0,0,0),
(19668,49,100,0,100,10,10,0,0,0),
(19668,50,100,0,100,10,10,0,0,0),
(19668,51,100,0,100,10,10,0,0,0),
(19668,52,100,0,100,10,10,0,0,0),
(19668,53,100,0,100,10,10,0,0,0),
(19668,54,100,0,100,10,10,0,0,0),
(19668,55,100,0,100,10,10,0,0,0),
(19668,56,100,0,100,10,10,0,0,0),
(19668,57,100,0,100,10,10,0,0,0),
(19668,58,100,0,100,10,10,0,0,0),
(19668,59,100,0,100,10,10,0,0,0),
(19668,60,100,0,100,10,10,0,0,0),
(19668,61,100,0,100,10,10,0,0,0),
(19668,62,100,0,100,10,10,0,0,0),
(19668,63,100,0,100,10,10,0,0,0),
(19668,64,100,0,100,10,10,0,0,0),
(19668,65,100,0,100,10,10,0,0,0),
(19668,66,7500,0,100,140,10,0,0,0),
(19668,67,8000,0,100,140,10,0,0,0),
(19668,68,8500,0,100,140,10,0,0,0),
(19668,69,9000,0,100,140,10,0,0,0),
(19668,70,9630,0,100,140,10,0,0,0),
(575,1,100,0,100,10,10,0,0,0),
(575,2,100,0,100,10,10,0,0,0),
(575,3,100,0,100,10,10,0,0,0),
(575,4,100,0,100,10,10,0,0,0),
(575,5,100,0,100,10,10,0,0,0),
(575,6,100,0,100,10,10,0,0,0),
(575,7,100,0,100,10,10,0,0,0),
(575,8,100,0,100,10,10,0,0,0),
(575,9,100,0,100,10,10,0,0,0),
(575,10,100,0,100,10,10,0,0,0),
(575,11,100,0,100,10,10,0,0,0),
(575,12,100,0,100,10,10,0,0,0),
(575,13,100,0,100,10,10,0,0,0),
(575,14,100,0,100,10,10,0,0,0),
(575,15,100,0,100,10,10,0,0,0),
(575,16,100,0,100,10,10,0,0,0),
(575,17,100,0,100,10,10,0,0,0),
(575,18,100,0,100,10,10,0,0,0),
(575,19,100,0,100,10,10,0,0,0),
(575,20,100,0,100,10,10,0,0,0),
(575,21,100,0,100,10,10,0,0,0),
(575,22,100,0,100,10,10,0,0,0),
(575,23,100,0,100,10,10,0,0,0),
(575,24,100,0,100,10,10,0,0,0),
(575,25,100,0,100,10,10,0,0,0),
(575,26,100,0,100,10,10,0,0,0),
(575,27,100,0,100,10,10,0,0,0),
(575,28,100,0,100,10,10,0,0,0),
(575,29,100,0,100,10,10,0,0,0),
(575,30,100,0,100,10,10,0,0,0),
(575,31,100,0,100,10,10,0,0,0),
(575,32,100,0,100,10,10,0,0,0),
(575,33,100,0,100,10,10,0,0,0),
(575,34,100,0,100,10,10,0,0,0),
(575,35,1400,0,50,10,10,0,0,0),
(575,36,1700,0,50,10,10,0,0,0),
(575,37,100,0,100,10,10,0,0,0),
(575,38,100,0,100,10,10,0,0,0),
(575,39,100,0,100,10,10,0,0,0),
(575,40,100,0,100,10,10,0,0,0),
(575,41,100,0,100,10,10,0,0,0),
(575,42,100,0,100,10,10,0,0,0),
(575,43,100,0,100,10,10,0,0,0),
(575,44,100,0,100,10,10,0,0,0),
(575,45,100,0,100,10,10,0,0,0),
(575,46,100,0,100,10,10,0,0,0),
(575,47,100,0,100,10,10,0,0,0),
(575,48,100,0,100,10,10,0,0,0),
(575,49,100,0,100,10,10,0,0,0),
(575,50,100,0,100,10,10,0,0,0),
(575,51,100,0,100,10,10,0,0,0),
(575,52,100,0,100,10,10,0,0,0),
(575,53,100,0,100,10,10,0,0,0),
(575,54,100,0,100,10,10,0,0,0),
(575,55,100,0,100,10,10,0,0,0),
(575,56,100,0,100,10,10,0,0,0),
(575,57,100,0,100,10,10,0,0,0),
(575,58,100,0,100,10,10,0,0,0),
(575,59,100,0,100,10,10,0,0,0),
(575,60,100,0,100,10,10,0,0,0),
(575,61,100,0,100,10,10,0,0,0),
(575,62,100,0,100,10,10,0,0,0),
(575,63,100,0,100,10,10,0,0,0),
(575,64,100,0,100,10,10,0,0,0),
(575,65,100,0,100,10,10,0,0,0),
(575,66,7500,0,100,140,10,0,0,0),
(575,67,8000,0,100,140,10,0,0,0),
(575,68,8500,0,100,140,10,0,0,0),
(575,69,9000,0,100,140,10,0,0,0),
(575,70,9630,0,100,140,10,0,0,0),
(17252,1,40,48,20,12,14,1,1,25),
(17252,2,49,59,40,14,15,2,1,26),
(17252,3,58,70,60,15,16,4,1,27),
(17252,4,68,81,80,17,17,8,2,27),
(17252,5,77,92,100,18,18,12,2,28),
(17252,6,86,103,120,20,19,16,3,29),
(17252,7,95,114,140,22,20,21,3,29),
(17252,8,104,125,160,23,21,25,4,30),
(17252,9,113,136,180,25,22,29,4,31),
(17252,10,123,147,200,26,23,33,5,31),
(17252,11,132,158,220,28,25,38,6,32),
(17252,12,150,180,240,29,26,42,8,33),
(17252,13,169,203,280,31,27,46,9,34),
(17252,14,189,227,320,33,28,50,11,35),
(17252,15,209,251,360,34,29,55,14,35),
(17252,16,229,275,400,36,30,59,16,36),
(17252,17,250,300,460,37,31,63,20,37),
(17252,18,262,314,510,39,32,67,24,38),
(17252,19,293,351,550,40,33,72,29,39),
(17252,20,303,377,563,42,35,67,31,49),
(17252,21,325,393,604,44,36,80,53,39),
(17252,22,349,420,628,46,36,84,54,41),
(17252,23,373,447,652,47,38,89,56,42),
(17252,24,400,476,675,49,39,93,57,43),
(17252,25,440,504,699,50,40,97,60,44),
(17252,26,469,534,721,52,41,101,62,46),
(17252,27,501,564,745,53,42,105,63,47),
(17252,28,534,592,768,55,43,110,65,48),
(17252,29,566,620,791,57,44,114,67,49),
(17252,30,599,648,815,57,46,118,69,51),
(17252,31,631,676,838,59,47,123,71,52),
(17252,32,680,720,862,60,47,127,73,53),
(17252,33,728,742,884,62,49,131,74,54),
(17252,34,661,793,908,64,50,135,76,56),
(17252,35,699,845,950,63,51,136,73,57),
(17252,36,737,879,990,67,52,137,72,58),
(17252,37,776,916,1038,69,53,138,70,59),
(17252,38,814,952,1095,70,55,139,69,61),
(17252,39,852,988,1163,72,56,142,68,62),
(17252,40,890,1026,1244,74,57,147,67,64),
(17252,41,928,1063,1338,77,58,152,68,66),
(17252,42,976,1103,1448,81,59,156,70,67),
(17252,43,1005,1187,1560,87,60,160,72,69),
(17252,44,1043,1214,1670,91,61,164,74,71),
(17252,45,1081,1240,1738,96,64,169,75,72),
(17252,46,1119,1267,1773,98,65,173,77,73),
(17252,47,1158,1294,1808,100,66,177,78,75),
(17252,48,1196,1320,1843,102,68,181,80,76),
(17252,49,1234,1347,1878,105,69,186,82,78),
(17252,50,2877,2391,3494,107,71,190,84,80),
(17252,51,2920,2435,3559,109,72,223,97,81),
(17252,52,3164,2481,3624,112,74,228,100,82),
(17252,53,3207,2527,3686,113,75,233,102,84),
(17252,54,3350,2573,3752,116,77,238,104,87),
(17252,55,3493,2620,3814,119,78,243,106,88),
(17252,56,3536,2766,3878,120,79,248,108,89),
(17252,57,3680,2814,3941,123,82,251,111,92),
(17252,58,3723,2913,4006,125,84,255,113,94),
(17252,59,3866,2924,4067,128,86,258,115,96),
(17252,60,3909,3174,4635,130,87,270,118,98),
(17252,61,4054,3225,6300,132,90,274,121,101),
(17252,62,4300,3377,6380,135,92,280,122,103),
(17252,63,4545,3430,6440,137,93,286,123,105),
(17252,64,4691,3584,6550,139,95,295,128,107),
(17252,65,4749,3646,6612,142,98,300,129,110),
(17252,66,4876,3778,6910,144,99,306,130,112),
(17252,67,4984,3863,7150,146,101,310,131,114),
(17252,68,5197,3949,7450,148,105,325,132,117),
(17252,69,5208,4035,7800,151,107,335,133,119),
(17252,70,5320,4170,7927,153,108,351,196,122),
(14385,1,48,80,10,20,16,13,20,8),
(14385,2,105,106,67,22,17,14,21,9),
(14385,3,162,132,124,24,18,15,22,10),
(14385,4,219,158,181,26,19,16,23,11),
(14385,5,276,184,238,28,20,17,24,12),
(14385,6,333,210,295,30,21,18,25,13),
(14385,7,390,236,352,32,22,19,26,14),
(14385,8,447,262,409,34,23,20,27,15),
(14385,9,504,288,466,36,24,21,28,16),
(14385,10,561,314,523,38,25,22,29,17),
(14385,11,618,340,580,40,26,23,30,18),
(14385,12,675,366,637,42,27,24,31,19),
(14385,13,732,392,694,44,28,25,32,20),
(14385,14,789,418,751,46,29,26,33,21),
(14385,15,846,444,808,48,30,27,34,22),
(14385,16,903,470,865,50,31,28,35,23),
(14385,17,960,496,922,52,32,29,36,24),
(14385,18,1017,522,979,54,33,30,37,25),
(14385,19,1074,548,1036,56,34,31,38,26),
(14385,20,1131,574,1093,58,35,32,39,27),
(14385,21,1188,600,1150,60,36,33,40,28),
(14385,22,1245,626,1207,62,37,34,41,29),
(14385,23,1302,652,1264,64,38,35,42,30),
(14385,24,1359,678,1321,66,39,36,43,31),
(14385,25,1416,704,1378,68,40,37,44,32),
(14385,26,1473,730,1435,70,41,38,45,33),
(14385,27,1530,756,1492,72,42,39,46,34),
(14385,28,1587,782,1549,74,43,40,47,35),
(14385,29,1644,808,1606,76,44,41,48,36),
(14385,30,1701,834,1663,78,45,42,49,37),
(14385,31,1758,860,1720,80,46,43,50,38),
(14385,32,1815,886,1777,82,47,44,51,39),
(14385,33,1872,912,1834,84,48,45,52,40),
(14385,34,1929,938,1891,86,49,46,53,41),
(14385,35,1986,964,1948,88,50,47,54,42),
(14385,36,2043,990,2005,90,51,48,55,43),
(14385,37,2100,1016,2062,92,52,49,56,44),
(14385,38,2157,1042,2119,94,53,50,57,45),
(14385,39,2214,1068,2176,96,54,51,58,46),
(14385,40,2271,1094,2233,98,55,52,59,47),
(14385,41,2328,1120,2290,100,56,53,60,48),
(14385,42,2385,1146,2347,102,57,54,61,49),
(14385,43,2442,1172,2404,104,58,55,62,50),
(14385,44,2499,1198,2461,106,59,56,63,51),
(14385,45,2556,1224,2518,108,60,57,64,52),
(14385,46,2613,1250,2575,110,61,58,65,53),
(14385,47,2670,1276,2632,112,62,59,66,54),
(14385,48,2727,1302,2689,114,63,60,67,55),
(14385,49,2784,1328,2746,116,64,61,68,56),
(14385,50,2841,1354,2803,118,65,62,69,57),
(14385,51,2898,1380,2860,120,66,63,70,58),
(14385,52,2955,1406,2917,122,67,64,71,59),
(14385,53,3012,1432,2974,124,68,65,72,60),
(14385,54,3069,1458,3031,126,69,66,73,61),
(14385,55,3126,1484,3088,128,70,67,74,62),
(14385,56,3183,1510,3145,130,71,68,75,63),
(14385,57,3240,1536,3202,132,72,69,76,64),
(14385,58,3297,1562,3259,134,73,70,77,65),
(14385,59,3354,1588,3316,136,74,71,78,66),
(14385,60,3411,1614,3373,138,75,72,79,67),
(14385,61,3468,1640,3430,140,76,73,80,68),
(14385,62,3525,1666,3487,142,77,74,81,69),
(14385,63,3582,1692,3544,144,78,75,82,70),
(14385,64,3639,1718,3601,146,79,76,83,71),
(14385,65,3696,1744,3658,148,80,77,84,72),
(14385,66,3753,1770,3715,150,81,78,85,73),
(14385,67,3810,1796,3772,152,82,79,86,74),
(14385,68,3867,1822,3829,154,83,80,87,75),
(14385,69,3924,1848,3886,156,84,81,88,76),
(14385,70,3981,1874,3943,158,85,82,89,77),
(3450,1,14,40,0,20,20,20,24,23),
(3450,2,19,49,0,21,20,20,25,24),
(3450,3,24,58,0,22,20,21,26,25),
(3450,4,29,67,0,23,21,21,27,26),
(3450,5,34,76,0,23,21,22,28,27),
(3450,6,40,85,0,24,21,22,29,27),
(3450,7,46,95,0,25,21,23,30,28),
(3450,8,52,105,0,26,21,23,31,29),
(3450,9,58,116,0,27,21,23,32,30),
(3450,10,64,126,0,27,22,24,33,31),
(3450,11,75,151,0,28,22,24,37,35),
(3450,12,83,177,0,29,22,26,41,39),
(3450,13,91,198,0,30,22,26,44,43),
(3450,14,120,234,0,31,22,28,50,47),
(3450,15,129,262,0,32,23,29,54,52),
(3450,16,138,290,0,34,23,30,57,56),
(3450,17,147,318,0,36,23,31,61,60),
(3450,18,156,346,0,37,23,32,65,65),
(3450,19,165,374,0,38,23,33,70,69),
(3450,20,175,402,0,40,24,35,74,74),
(3450,21,184,430,0,42,24,37,87,78),
(3450,22,193,458,0,44,24,39,91,82),
(3450,23,202,486,0,45,24,40,95,86),
(3450,24,212,514,0,46,25,42,94,90),
(3450,25,224,539,0,47,25,43,94,95),
(3450,26,237,568,0,48,25,43,98,100),
(3450,27,249,598,0,50,25,42,102,104),
(3450,28,262,632,0,51,25,44,109,110),
(3450,29,274,667,0,52,26,44,114,114),
(3450,30,287,702,0,54,26,45,120,118),
(3450,31,299,734,0,55,26,46,124,123),
(3450,32,312,772,0,57,26,47,128,128),
(3450,33,324,807,0,58,27,48,132,131),
(3450,34,338,842,0,60,27,50,136,135),
(3450,35,360,898,0,62,27,51,139,136),
(3450,36,382,954,0,65,27,52,142,137),
(3450,37,404,1010,0,67,27,54,146,138),
(3450,38,427,1066,0,70,28,55,149,139),
(3450,39,449,1122,0,73,28,56,153,141),
(3450,40,471,1178,0,75,28,58,156,142),
(3450,41,493,1234,0,78,28,59,160,143),
(3450,42,516,1290,0,80,29,60,163,144),
(3450,43,538,1346,0,83,29,62,167,145),
(3450,44,560,1402,0,86,29,63,170,147),
(3450,45,582,1458,0,88,29,64,174,148),
(3450,46,605,1514,0,91,30,66,177,149),
(3450,47,627,1570,0,93,30,67,181,151),
(3450,48,649,1627,0,96,30,68,184,152),
(3450,49,672,1685,0,99,31,70,188,155),
(3450,50,694,1704,0,101,31,71,194,160),
(3450,51,716,1723,0,103,31,72,201,170),
(3450,52,738,1743,0,105,32,74,208,180),
(3450,53,761,1762,0,107,32,75,215,190),
(3450,54,783,1781,0,109,32,77,222,200),
(3450,55,805,1801,0,111,33,78,229,210),
(3450,56,827,1820,0,113,33,80,236,220),
(3450,57,850,1839,0,115,33,81,243,230),
(3450,58,872,1859,0,117,34,83,250,240),
(3450,59,894,1878,0,120,34,84,257,250),
(3450,60,917,1898,0,122,35,86,264,260),
(3450,61,939,1918,0,125,35,88,271,270),
(3450,62,961,1937,0,128,36,89,278,280),
(3450,63,983,1956,0,131,36,91,285,290),
(3450,64,1005,1975,0,134,36,93,292,300),
(3450,65,1027,1994,0,137,37,94,299,310),
(3450,66,1049,2013,0,140,37,96,306,320),
(3450,67,1072,2032,0,143,37,97,313,330),
(3450,68,1094,2052,0,146,38,99,320,340),
(3450,69,1126,2071,0,149,38,100,327,350),
(3450,70,1149,2090,0,152,39,102,334,360),
(8996,1,80,48,0,0,0,0,0,0),
(8996,2,100,59,0,0,0,0,0,0),
(8996,3,120,70,0,0,0,0,0,0),
(8996,4,140,81,0,0,0,0,0,0),
(8996,5,160,92,0,0,0,0,0,0),
(8996,6,180,103,0,0,0,0,0,0),
(8996,7,200,114,0,0,0,0,0,0),
(8996,8,220,125,0,0,0,0,0,0),
(8996,9,240,136,0,0,0,0,0,0),
(8996,10,260,147,694,29,25,29,22,26),
(8996,11,291,158,734,30,25,32,23,28),
(8996,12,322,180,782,31,26,36,24,31),
(8996,13,354,203,827,32,28,43,26,32),
(8996,14,368,227,878,33,28,44,25,35),
(8996,15,421,251,925,34,30,48,26,37),
(8996,16,455,275,975,36,30,52,27,39),
(8996,17,490,300,1022,38,31,55,28,42),
(8996,18,528,314,1068,39,33,59,28,44),
(8996,19,566,351,1120,40,33,63,29,46),
(8996,20,606,377,1165,42,35,67,30,49),
(8996,21,653,400,1232,44,36,80,31,51),
(8996,22,699,423,1282,46,36,84,32,53),
(8996,23,746,447,1330,47,38,89,33,55),
(8996,24,823,476,1378,49,39,93,34,58),
(8996,25,854,504,1427,50,40,97,35,61),
(8996,26,911,543,1474,52,41,101,36,62),
(8996,27,966,564,1524,53,42,105,37,65),
(8996,28,1047,592,1572,55,43,110,38,67),
(8996,29,1129,620,1619,56,44,114,39,70),
(8996,30,1210,648,1667,58,46,118,40,72),
(8996,31,1292,676,1715,59,47,123,40,74),
(8996,32,1373,720,1766,61,48,127,41,77),
(8996,33,1455,742,1812,62,49,131,42,79),
(8996,34,1573,793,1861,63,51,135,43,82),
(8996,35,1690,845,2000,65,52,136,44,84),
(8996,36,1760,879,2154,66,53,137,45,87),
(8996,37,1827,916,2248,68,53,138,46,89),
(8996,38,1900,952,2331,70,55,139,47,91),
(8996,39,1974,988,2483,72,56,144,48,94),
(8996,40,2041,1026,2770,74,58,150,49,97),
(8996,41,2127,1063,2856,76,59,153,50,99),
(8996,42,2171,1103,3034,81,59,156,51,102),
(8996,43,2215,1187,3228,86,61,169,52,104),
(8996,44,2259,1214,2463,89,62,172,53,107),
(8996,45,2303,1240,2638,91,64,175,54,109),
(8996,46,2347,1267,2862,94,65,178,55,112),
(8996,47,2391,1294,3021,96,66,181,56,115),
(8996,48,2435,1320,3218,99,68,184,57,117),
(8996,49,2479,1347,3370,101,69,187,58,120),
(8996,50,2523,1391,3528,104,71,190,59,123),
(8996,51,2568,1435,3963,107,72,193,61,126),
(8996,52,2661,1481,4132,109,73,199,62,128),
(8996,53,2755,1527,4286,112,75,203,63,131),
(8996,54,2848,1573,4307,114,76,207,64,133),
(8996,55,2942,1620,4389,117,77,213,65,136),
(8996,56,3036,1666,4476,119,79,218,66,139),
(8996,57,3129,1714,4532,122,80,222,67,142),
(8996,58,3223,1763,4599,124,82,227,68,144),
(8996,59,3317,1824,4673,127,83,230,69,147),
(8996,60,3419,1874,4745,129,85,249,70,150),
(8996,61,3522,1925,5238,131,87,252,78,153),
(8996,62,3624,1977,5670,135,90,255,86,157),
(8996,63,3727,2030,6133,138,94,258,93,160),
(8996,64,3830,2084,6492,142,97,261,102,164),
(8996,65,3934,2139,6981,145,101,264,110,167),
(8996,66,4039,2195,7429,149,104,267,119,171),
(8996,67,4143,2252,7912,152,108,270,125,175),
(8996,68,4248,2310,8320,156,111,273,127,180),
(8996,69,4352,2369,8693,159,115,276,130,185),
(8996,70,4460,2429,9070,153,109,280,133,189),
(10928,1,40,48,0,0,0,0,0,0),
(10928,2,49,59,0,0,0,0,0,0),
(10928,3,58,70,0,0,0,0,0,0),
(10928,4,68,81,0,0,0,0,0,0),
(10928,5,77,92,0,0,0,0,0,0),
(10928,6,86,103,0,0,0,0,0,0),
(10928,7,95,114,0,0,0,0,0,0),
(10928,8,104,125,0,0,0,0,0,0),
(10928,9,113,136,0,0,0,0,0,0),
(10928,10,123,147,0,0,0,0,0,0),
(10928,11,132,158,0,0,0,0,0,0),
(10928,12,150,180,0,0,0,0,0,0),
(10928,13,169,203,0,0,0,0,0,0),
(10928,14,189,227,0,0,0,0,0,0),
(10928,15,209,251,0,0,0,0,0,0),
(10928,16,229,275,0,0,0,0,0,0),
(10928,17,250,300,0,0,0,0,0,0),
(10928,18,262,314,0,0,0,0,0,0),
(10928,19,293,351,0,0,0,0,0,0),
(10928,20,303,377,0,42,35,67,31,49),
(10928,21,325,393,0,44,36,80,31,51),
(10928,22,349,420,0,46,36,84,32,53),
(10928,23,373,447,0,47,38,79,33,55),
(10928,24,400,476,0,49,39,83,34,58),
(10928,25,440,504,0,50,40,87,35,61),
(10928,26,469,534,0,52,41,91,36,62),
(10928,27,501,564,0,53,42,95,37,65),
(10928,28,534,592,0,55,43,99,38,67),
(10928,29,566,620,0,56,44,103,39,70),
(10928,30,599,648,800,58,46,107,40,72),
(10928,31,631,676,856,59,47,111,40,74),
(10928,32,680,720,921,61,48,115,41,77),
(10928,33,728,742,987,62,49,119,42,79),
(10928,34,661,793,1047,63,51,123,43,82),
(10928,35,699,845,1107,65,52,127,44,84),
(10928,36,737,879,1167,66,53,131,45,87),
(10928,37,776,916,1227,68,53,135,46,89),
(10928,38,814,952,1288,70,55,139,47,91),
(10928,39,852,988,1345,72,56,143,48,94),
(10928,40,890,1026,1409,74,58,148,49,97),
(10928,41,928,1063,1462,76,59,152,50,99),
(10928,42,976,1103,1528,81,59,156,51,102),
(10928,43,1005,1187,1586,86,61,160,52,104),
(10928,44,1043,1214,1642,89,62,164,53,107),
(10928,45,1081,1240,1708,91,64,169,54,109),
(10928,46,1119,1267,1769,94,65,173,55,112),
(10928,47,1158,1294,1826,96,66,178,56,115),
(10928,48,1196,1320,1889,99,68,182,57,117),
(10928,49,1234,1347,1950,101,69,186,58,120),
(10928,50,1277,1391,2003,104,71,191,59,123),
(10928,51,1320,1435,2055,107,72,195,61,126),
(10928,52,1364,1481,2108,109,73,199,62,128),
(10928,53,1407,1527,2161,112,75,204,63,131),
(10928,54,1450,1573,2213,114,76,208,64,134),
(10928,55,1493,1620,2266,117,77,213,65,136),
(10928,56,1536,1666,2318,119,79,217,66,139),
(10928,57,1580,1714,2371,122,80,221,67,142),
(10928,58,1623,1763,2424,124,82,226,68,144),
(10928,59,1666,1824,2476,127,83,230,69,147),
(10928,60,1709,1874,2529,129,85,234,70,150),
(10928,61,1754,1925,2583,132,86,239,72,154),
(10928,62,1800,1977,2638,136,87,245,73,159),
(10928,63,1845,2030,2693,140,88,250,74,163),
(10928,64,1891,2084,2758,143,89,256,75,168),
(10928,65,1936,2137,2823,147,90,261,76,172),
(10928,66,1982,2191,2888,150,91,266,77,177),
(10928,67,2027,2244,2944,154,92,272,78,181),
(10928,68,2073,2298,3000,157,93,277,79,186),
(10928,69,2118,2351,3056,161,94,283,80,190),
(10928,70,2164,2405,3112,165,95,289,81,195),
(12922,1,14,40,0,20,20,20,24,23),
(12922,2,19,49,0,21,20,20,25,24),
(12922,3,24,58,0,22,20,21,26,25),
(12922,4,29,67,0,23,21,21,27,26),
(12922,5,34,76,0,23,21,22,28,27),
(12922,6,40,85,0,24,21,22,29,27),
(12922,7,46,95,0,25,21,23,30,28),
(12922,8,52,105,0,26,21,23,31,29),
(12922,9,58,116,0,27,21,23,32,30),
(12922,10,64,126,0,27,22,24,33,31),
(12922,11,75,151,0,28,22,24,37,35),
(12922,12,83,177,0,29,22,26,41,39),
(12922,13,91,198,0,30,22,26,44,43),
(12922,14,120,234,0,31,22,28,50,47),
(12922,15,129,262,0,32,23,29,54,52),
(12922,16,138,290,0,34,23,30,57,56),
(12922,17,147,318,0,36,23,31,61,60),
(12922,18,156,346,0,37,23,32,65,65),
(12922,19,165,374,0,38,23,33,70,69),
(12922,20,175,402,0,40,24,35,74,74),
(12922,21,184,430,0,42,24,37,87,78),
(12922,22,193,458,0,44,24,39,91,82),
(12922,23,202,486,0,45,24,40,95,86),
(12922,24,212,514,0,46,25,42,94,90),
(12922,25,224,539,0,47,25,43,94,95),
(12922,26,237,568,0,48,25,43,98,100),
(12922,27,249,598,0,50,25,42,102,104),
(12922,28,262,632,0,51,25,44,109,110),
(12922,29,274,667,0,52,26,44,114,114),
(12922,30,287,702,0,54,26,45,120,118),
(12922,31,299,734,0,55,26,46,124,123),
(12922,32,312,772,0,57,26,47,128,128),
(12922,33,324,807,0,58,27,48,132,131),
(12922,34,338,842,0,60,27,50,136,135),
(12922,35,360,898,0,62,27,51,139,136),
(12922,36,382,954,0,65,27,52,142,137),
(12922,37,404,1010,0,67,27,54,146,138),
(12922,38,427,1066,0,70,28,55,149,139),
(12922,39,449,1122,0,73,28,56,153,141),
(12922,40,471,1178,0,75,28,58,156,142),
(12922,41,493,1234,0,78,28,59,160,143),
(12922,42,516,1290,0,80,29,60,163,144),
(12922,43,538,1346,0,83,29,62,167,145),
(12922,44,560,1402,0,86,29,63,170,147),
(12922,45,582,1458,0,88,29,64,174,148),
(12922,46,605,1514,0,91,30,66,177,149),
(12922,47,627,1570,0,93,30,67,181,151),
(12922,48,649,1627,0,96,30,68,184,152),
(12922,49,672,1685,0,99,31,70,188,155),
(12922,50,694,1704,0,101,31,71,194,160),
(12922,51,716,1723,0,103,31,72,201,170),
(12922,52,738,1743,0,105,32,74,208,180),
(12922,53,761,1762,0,107,32,75,215,190),
(12922,54,783,1781,0,109,32,77,222,200),
(12922,55,805,1801,0,111,33,78,229,210),
(12922,56,827,1820,0,113,33,80,236,220),
(12922,57,850,1839,0,115,33,81,243,230),
(12922,58,872,1859,0,117,34,83,250,240),
(12922,59,894,1878,0,120,34,84,257,250),
(12922,60,917,1898,0,122,35,86,264,260),
(12922,61,939,1918,0,125,35,88,271,270),
(12922,62,961,1937,0,128,36,89,278,280),
(12922,63,983,1956,0,131,36,91,285,290),
(12922,64,1005,1975,0,134,36,93,292,300),
(12922,65,1027,1994,0,137,37,94,299,310),
(12922,66,1049,2013,0,140,37,96,306,320),
(12922,67,1072,2032,0,143,37,97,313,330),
(12922,68,1094,2052,0,146,38,99,320,340),
(12922,69,1126,2071,0,149,38,100,327,350),
(12922,70,1149,2090,0,152,39,102,334,360),
(8477,1,80,48,0,0,0,0,0,0),
(8477,2,100,59,0,0,0,0,0,0),
(8477,3,120,70,0,0,0,0,0,0),
(8477,4,140,81,0,0,0,0,0,0),
(8477,5,160,92,0,0,0,0,0,0),
(8477,6,180,103,0,0,0,0,0,0),
(8477,7,200,114,0,0,0,0,0,0),
(8477,8,220,125,0,0,0,0,0,0),
(8477,9,240,136,0,0,0,0,0,0),
(8477,10,260,147,694,29,25,29,22,26),
(8477,11,291,158,734,30,25,32,23,28),
(8477,12,322,180,782,31,26,36,24,31),
(8477,13,354,203,827,32,28,43,26,32),
(8477,14,368,227,878,33,28,44,25,35),
(8477,15,421,251,925,34,30,48,26,37),
(8477,16,455,275,975,36,30,52,27,39),
(8477,17,490,300,1022,38,31,55,28,42),
(8477,18,528,314,1068,39,33,59,28,44),
(8477,19,566,351,1120,40,33,63,29,46),
(8477,20,606,377,1165,42,35,67,30,49),
(8477,21,653,400,1232,44,36,80,31,51),
(8477,22,699,423,1282,46,36,84,32,53),
(8477,23,746,447,1330,47,38,89,33,55),
(8477,24,823,476,1378,49,39,93,34,58),
(8477,25,854,504,1427,50,40,97,35,61),
(8477,26,911,543,1474,52,41,101,36,62),
(8477,27,966,564,1524,53,42,105,37,65),
(8477,28,1047,592,1572,55,43,110,38,67),
(8477,29,1129,620,1619,56,44,114,39,70),
(8477,30,1210,648,1667,58,46,118,40,72),
(8477,31,1292,676,1715,59,47,123,40,74),
(8477,32,1373,720,1766,61,48,127,41,77),
(8477,33,1455,742,1812,62,49,131,42,79),
(8477,34,1573,793,1861,63,51,135,43,82),
(8477,35,1690,845,2000,65,52,136,44,84),
(8477,36,1760,879,2154,66,53,137,45,87),
(8477,37,1827,916,2248,68,53,138,46,89),
(8477,38,1900,952,2331,70,55,139,47,91),
(8477,39,1974,988,2483,72,56,144,48,94),
(8477,40,2041,1026,2770,74,58,150,49,97),
(8477,41,2127,1063,2856,76,59,153,50,99),
(8477,42,2171,1103,3034,81,59,156,51,102),
(8477,43,2215,1187,3228,86,61,169,52,104),
(8477,44,2259,1214,2463,89,62,172,53,107),
(8477,45,2303,1240,2638,91,64,175,54,109),
(8477,46,2347,1267,2862,94,65,178,55,112),
(8477,47,2391,1294,3021,96,66,181,56,115),
(8477,48,2435,1320,3218,99,68,184,57,117),
(8477,49,2479,1347,3370,101,69,187,58,120),
(8477,50,2523,1391,3528,104,71,190,59,123),
(8477,51,2568,1435,3963,107,72,193,61,126),
(8477,52,2661,1481,4132,109,73,199,62,128),
(8477,53,2755,1527,4286,112,75,203,63,131),
(8477,54,2848,1573,4307,114,76,207,64,133),
(8477,55,2942,1620,4389,117,77,213,65,136),
(8477,56,3036,1666,4476,119,79,218,66,139),
(8477,57,3129,1714,4532,122,80,222,67,142),
(8477,58,3223,1763,4599,124,82,227,68,144),
(8477,59,3317,1824,4673,127,83,230,69,147),
(8477,60,3419,1874,4745,129,85,249,70,150),
(8477,61,3522,1925,5238,131,87,252,78,153),
(8477,62,3624,1977,5670,135,90,255,86,157),
(8477,63,3727,2030,6133,138,94,258,93,160),
(8477,64,3830,2084,6492,142,97,261,102,164),
(8477,65,3934,2139,6981,145,101,264,110,167),
(8477,66,4039,2195,7429,149,104,267,119,171),
(8477,67,4143,2252,7912,152,108,270,125,175),
(8477,68,4248,2310,8320,156,111,273,127,180),
(8477,69,4352,2369,8693,159,115,276,130,185),
(8477,70,4460,2429,9070,153,109,280,133,189),
(24815,1,14,40,0,20,20,20,24,23),
(24815,2,19,49,0,21,20,20,25,24),
(24815,3,24,58,0,22,20,21,26,25),
(24815,4,29,67,0,23,21,21,27,26),
(24815,5,34,76,0,23,21,22,28,27),
(24815,6,40,85,0,24,21,22,29,27),
(24815,7,46,95,0,25,21,23,30,28),
(24815,8,52,105,0,26,21,23,31,29),
(24815,9,58,116,0,27,21,23,32,30),
(24815,10,64,126,0,27,22,24,33,31),
(24815,11,75,151,0,28,22,24,37,35),
(24815,12,83,177,0,29,22,26,41,39),
(24815,13,91,198,0,30,22,26,44,43),
(24815,14,120,234,0,31,22,28,50,47),
(24815,15,129,262,0,32,23,29,54,52),
(24815,16,138,290,0,34,23,30,57,56),
(24815,17,147,318,0,36,23,31,61,60),
(24815,18,156,346,0,37,23,32,65,65),
(24815,19,165,374,0,38,23,33,70,69),
(24815,20,175,402,0,40,24,35,74,74),
(24815,21,184,430,0,42,24,37,87,78),
(24815,22,193,458,0,44,24,39,91,82),
(24815,23,202,486,0,45,24,40,95,86),
(24815,24,212,514,0,46,25,42,94,90),
(24815,25,224,539,0,47,25,43,94,95),
(24815,26,237,568,0,48,25,43,98,100),
(24815,27,249,598,0,50,25,42,102,104),
(24815,28,262,632,0,51,25,44,109,110),
(24815,29,274,667,0,52,26,44,114,114),
(24815,30,287,702,0,54,26,45,120,118),
(24815,31,299,734,0,55,26,46,124,123),
(24815,32,312,772,0,57,26,47,128,128),
(24815,33,324,807,0,58,27,48,132,131),
(24815,34,338,842,0,60,27,50,136,135),
(24815,35,360,898,0,62,27,51,139,136),
(24815,36,382,954,0,65,27,52,142,137),
(24815,37,404,1010,0,67,27,54,146,138),
(24815,38,427,1066,0,70,28,55,149,139),
(24815,39,449,1122,0,73,28,56,153,141),
(24815,40,471,1178,0,75,28,58,156,142),
(24815,41,493,1234,0,78,28,59,160,143),
(24815,42,516,1290,0,80,29,60,163,144),
(24815,43,538,1346,0,83,29,62,167,145),
(24815,44,560,1402,0,86,29,63,170,147),
(24815,45,582,1458,0,88,29,64,174,148),
(24815,46,605,1514,0,91,30,66,177,149),
(24815,47,627,1570,0,93,30,67,181,151),
(24815,48,649,1627,0,96,30,68,184,152),
(24815,49,672,1685,0,99,31,70,188,155),
(24815,50,694,1704,0,101,31,71,194,160),
(24815,51,716,1723,0,103,31,72,201,170),
(24815,52,738,1743,0,105,32,74,208,180),
(24815,53,761,1762,0,107,32,75,215,190),
(24815,54,783,1781,0,109,32,77,222,200),
(24815,55,805,1801,0,111,33,78,229,210),
(24815,56,827,1820,0,113,33,80,236,220),
(24815,57,850,1839,0,115,33,81,243,230),
(24815,58,872,1859,0,117,34,83,250,240),
(24815,59,894,1878,0,120,34,84,257,250),
(24815,60,917,1898,0,122,35,86,264,260),
(24815,61,939,1918,0,125,35,88,271,270),
(24815,62,961,1937,0,128,36,89,278,280),
(24815,63,983,1956,0,131,36,91,285,290),
(24815,64,1005,1975,0,134,36,93,292,300),
(24815,65,1027,1994,0,137,37,94,299,310),
(24815,66,1049,2013,0,140,37,96,306,320),
(24815,67,1072,2032,0,143,37,97,313,330),
(24815,68,1094,2052,0,146,38,99,320,340),
(24815,69,1126,2071,0,149,38,100,327,350),
(24815,70,1149,2090,0,152,39,102,334,360),
(22362,1,14,40,20,20,20,20,24,23),
(22362,2,19,49,24,21,20,20,25,24),
(22362,3,24,58,28,22,20,21,26,25),
(22362,4,29,67,33,23,21,21,27,26),
(22362,5,34,76,49,23,21,22,28,27),
(22362,6,40,85,68,24,21,22,29,27),
(22362,7,46,95,92,25,21,23,30,28),
(22362,8,52,105,117,26,21,23,31,29),
(22362,9,58,116,147,27,21,23,32,30),
(22362,10,64,126,180,27,22,24,33,31),
(22362,11,75,151,190,28,22,24,37,35),
(22362,12,83,177,203,29,22,26,41,39),
(22362,13,91,198,215,30,22,26,44,43),
(22362,14,120,234,228,31,22,28,50,47),
(22362,15,129,262,240,32,23,29,54,52),
(22362,16,138,290,253,34,23,30,57,56),
(22362,17,147,318,265,36,23,31,61,60),
(22362,18,156,346,278,37,23,32,65,65),
(22362,19,165,374,291,38,23,33,70,69),
(22362,20,175,402,303,40,24,35,74,74),
(22362,21,184,430,320,42,24,37,87,78),
(22362,22,193,458,346,44,24,39,91,82),
(22362,23,202,486,360,45,24,40,95,86),
(22362,24,212,514,373,46,25,42,94,90),
(22362,25,224,539,386,47,25,43,94,95),
(22362,26,237,568,399,48,25,43,98,100),
(22362,27,249,598,411,50,25,42,102,104),
(22362,28,262,632,424,51,25,44,109,110),
(22362,29,274,667,436,52,26,44,114,114),
(22362,30,287,702,449,54,26,45,120,118),
(22362,31,299,734,462,55,26,46,124,123),
(22362,32,312,772,478,57,26,47,128,128),
(22362,33,324,807,488,58,27,48,132,131),
(22362,34,338,842,501,60,27,50,136,135),
(22362,35,360,898,536,62,27,51,139,136),
(22362,36,382,954,572,65,27,52,142,137),
(22362,37,404,1010,604,67,27,54,146,138),
(22362,38,427,1066,643,70,28,55,149,139),
(22362,39,449,1122,682,73,28,56,153,141),
(22362,40,471,1178,701,75,28,58,156,142),
(22362,41,493,1234,726,78,28,59,160,143),
(22362,42,516,1290,756,80,29,60,163,144),
(22362,43,538,1346,782,83,29,62,167,145),
(22362,44,560,1402,815,86,29,63,170,147),
(22362,45,582,1458,843,88,29,64,174,148),
(22362,46,605,1514,878,91,30,66,177,149),
(22362,47,627,1570,900,93,30,67,181,151),
(22362,48,649,1627,924,96,30,68,184,152),
(22362,49,672,1685,946,99,31,70,188,155),
(22362,50,694,1704,979,101,31,71,194,160),
(22362,51,716,1723,999,103,31,72,201,170),
(22362,52,738,1743,1020,105,32,74,208,180),
(22362,53,761,1762,1039,107,32,75,215,190),
(22362,54,783,1781,1055,109,32,77,222,200),
(22362,55,805,1801,1073,111,33,78,229,210),
(22362,56,827,1820,1091,113,33,80,236,220),
(22362,57,850,1839,1107,115,33,81,243,230),
(22362,58,872,1859,1123,117,34,83,250,240),
(22362,59,894,1878,1148,120,34,84,257,250),
(22362,60,917,1898,1163,122,35,86,264,260),
(22362,61,939,1918,1260,125,35,88,271,270),
(22362,62,961,1937,1398,128,36,89,278,280),
(22362,63,983,1956,1420,131,36,91,285,290),
(22362,64,1005,1975,1572,134,36,93,292,300),
(22362,65,1027,1994,1699,137,37,94,299,310),
(22362,66,1049,2013,1840,140,37,96,306,320),
(22362,67,1072,2032,1939,143,37,97,313,330),
(22362,68,1094,2052,2070,146,38,99,320,340),
(22362,69,1126,2071,2130,149,38,100,327,350),
(22362,70,1149,2090,2207,152,39,102,334,360),
(10979,1,14,40,0,20,20,20,24,23),
(10979,2,19,49,0,21,20,20,25,24),
(10979,3,24,58,0,22,20,21,26,25),
(10979,4,29,67,0,23,21,21,27,26),
(10979,5,34,76,0,23,21,22,28,27),
(10979,6,40,85,0,24,21,22,29,27),
(10979,7,46,95,0,25,21,23,30,28),
(10979,8,52,105,0,26,21,23,31,29),
(10979,9,58,116,0,27,21,23,32,30),
(10979,10,64,126,0,27,22,24,33,31),
(10979,11,75,151,0,28,22,24,37,35),
(10979,12,83,177,0,29,22,26,41,39),
(10979,13,91,198,0,30,22,26,44,43),
(10979,14,120,234,0,31,22,28,50,47),
(10979,15,129,262,0,32,23,29,54,52),
(10979,16,138,290,0,34,23,30,57,56),
(10979,17,147,318,0,36,23,31,61,60),
(10979,18,156,346,0,37,23,32,65,65),
(10979,19,165,374,0,38,23,33,70,69),
(10979,20,175,402,0,40,24,35,74,74),
(10979,21,184,430,0,42,24,37,87,78),
(10979,22,193,458,0,44,24,39,91,82),
(10979,23,202,486,0,45,24,40,95,86),
(10979,24,212,514,0,46,25,42,94,90),
(10979,25,224,539,0,47,25,43,94,95),
(10979,26,237,568,0,48,25,43,98,100),
(10979,27,249,598,0,50,25,42,102,104),
(10979,28,262,632,0,51,25,44,109,110),
(10979,29,274,667,0,52,26,44,114,114),
(10979,30,287,702,0,54,26,45,120,118),
(10979,31,299,734,0,55,26,46,124,123),
(10979,32,312,772,0,57,26,47,128,128),
(10979,33,324,807,0,58,27,48,132,131),
(10979,34,338,842,0,60,27,50,136,135),
(10979,35,360,898,0,62,27,51,139,136),
(10979,36,382,954,0,65,27,52,142,137),
(10979,37,404,1010,0,67,27,54,146,138),
(10979,38,427,1066,0,70,28,55,149,139),
(10979,39,449,1122,0,73,28,56,153,141),
(10979,40,471,1178,0,75,28,58,156,142),
(10979,41,493,1234,0,78,28,59,160,143),
(10979,42,516,1290,0,80,29,60,163,144),
(10979,43,538,1346,0,83,29,62,167,145),
(10979,44,560,1402,0,86,29,63,170,147),
(10979,45,582,1458,0,88,29,64,174,148),
(10979,46,605,1514,0,91,30,66,177,149),
(10979,47,627,1570,0,93,30,67,181,151),
(10979,48,649,1627,0,96,30,68,184,152),
(10979,49,672,1685,0,99,31,70,188,155),
(10979,50,694,1704,0,101,31,71,194,160),
(10979,51,716,1723,0,103,31,72,201,170),
(10979,52,738,1743,0,105,32,74,208,180),
(10979,53,761,1762,0,107,32,75,215,190),
(10979,54,783,1781,0,109,32,77,222,200),
(10979,55,805,1801,0,111,33,78,229,210),
(10979,56,827,1820,0,113,33,80,236,220),
(10979,57,850,1839,0,115,33,81,243,230),
(10979,58,872,1859,0,117,34,83,250,240),
(10979,59,894,1878,0,120,34,84,257,250),
(10979,60,917,1898,0,122,35,86,264,260),
(10979,61,939,1918,0,125,35,88,271,270),
(10979,62,961,1937,0,128,36,89,278,280),
(10979,63,983,1956,0,131,36,91,285,290),
(10979,64,1005,1975,0,134,36,93,292,300),
(10979,65,1027,1994,0,137,37,94,299,310),
(10979,66,1049,2013,0,140,37,96,306,320),
(10979,67,1072,2032,0,143,37,97,313,330),
(10979,68,1094,2052,0,146,38,99,320,340),
(10979,69,1126,2071,0,149,38,100,327,350),
(10979,70,1149,2090,0,152,39,102,334,360),
(15352,1,1,0,1,1,1,1,1,1),
(15352,2,1,0,1,1,1,1,1,1),
(15352,3,1,0,1,1,1,1,1,1),
(15352,4,1,0,1,1,1,1,1,1),
(15352,5,1,0,1,1,1,1,1,1),
(15352,6,1,0,1,1,1,1,1,1),
(15352,7,1,0,1,1,1,1,1,1),
(15352,8,1,0,1,1,1,1,1,1),
(15352,9,1,0,1,1,1,1,1,1),
(15352,10,1,0,1,1,1,1,1,1),
(15352,11,1,0,1,1,1,1,1,1),
(15352,12,1,0,1,1,1,1,1,1),
(15352,13,1,0,1,1,1,1,1,1),
(15352,14,1,0,1,1,1,1,1,1),
(15352,15,1,0,1,1,1,1,1,1),
(15352,16,1,0,1,1,1,1,1,1),
(15352,17,1,0,1,1,1,1,1,1),
(15352,18,1,0,1,1,1,1,1,1),
(15352,19,1,0,1,1,1,1,1,1),
(15352,20,1,0,1,1,1,1,1,1),
(15352,21,1,0,1,1,1,1,1,1),
(15352,22,1,0,1,1,1,1,1,1),
(15352,23,1,0,1,1,1,1,1,1),
(15352,24,1,0,1,1,1,1,1,1),
(15352,25,1,0,1,1,1,1,1,1),
(15352,26,1,0,1,1,1,1,1,1),
(15352,27,1,0,1,1,1,1,1,1),
(15352,28,1,0,1,1,1,1,1,1),
(15352,29,1,0,1,1,1,1,1,1),
(15352,30,1,0,1,1,1,1,1,1),
(15352,31,1,0,1,1,1,1,1,1),
(15352,32,1,0,1,1,1,1,1,1),
(15352,33,1,0,1,1,1,1,1,1),
(15352,34,1,0,1,1,1,1,1,1),
(15352,35,1,0,1,1,1,1,1,1),
(15352,36,1,0,1,1,1,1,1,1),
(15352,37,1,0,1,1,1,1,1,1),
(15352,38,1,0,1,1,1,1,1,1),
(15352,39,1,0,1,1,1,1,1,1),
(15352,40,1,0,1,1,1,1,1,1),
(15352,41,1,0,1,1,1,1,1,1),
(15352,42,1,0,1,1,1,1,1,1),
(15352,43,1,0,1,1,1,1,1,1),
(15352,44,1,0,1,1,1,1,1,1),
(15352,45,1,0,1,1,1,1,1,1),
(15352,46,1,0,1,1,1,1,1,1),
(15352,47,1,0,1,1,1,1,1,1),
(15352,48,1,0,1,1,1,1,1,1),
(15352,49,1,0,1,1,1,1,1,1),
(15352,50,1,0,1,1,1,1,1,1),
(15352,51,1,0,1,1,1,1,1,1),
(15352,52,1,0,1,1,1,1,1,1),
(15352,53,1,0,1,1,1,1,1,1),
(15352,54,1,0,1,1,1,1,1,1),
(15352,55,1,0,1,1,1,1,1,1),
(15352,56,1,0,1,1,1,1,1,1),
(15352,57,1,0,1,1,1,1,1,1),
(15352,58,1,0,1,1,1,1,1,1),
(15352,59,1,0,1,1,1,1,1,1),
(15352,60,1,0,1,1,1,1,1,1),
(15352,61,1,0,1,1,1,1,1,1),
(15352,62,1,0,1,1,1,1,1,1),
(15352,63,1,0,1,1,1,1,1,1),
(15352,64,1,0,1,1,1,1,1,1),
(15352,65,1,0,1,1,1,1,1,1),
(15352,66,6600,0,6200,132,62,96,132,320),
(15352,67,6700,0,6400,134,64,97,134,330),
(15352,68,6800,0,6600,136,66,99,136,340),
(15352,69,6900,0,6800,138,68,100,138,350),
(15352,70,7000,0,7000,140,70,102,140,360),
(15438,1,1,1,1,1,1,1,1,1),
(15438,2,1,1,1,1,1,1,1,1),
(15438,3,1,1,1,1,1,1,1,1),
(15438,4,1,1,1,1,1,1,1,1),
(15438,5,1,1,1,1,1,1,1,1),
(15438,6,1,1,1,1,1,1,1,1),
(15438,7,1,1,1,1,1,1,1,1),
(15438,8,1,1,1,1,1,1,1,1),
(15438,9,1,1,1,1,1,1,1,1),
(15438,10,1,1,1,1,1,1,1,1),
(15438,11,1,1,1,1,1,1,1,1),
(15438,12,1,1,1,1,1,1,1,1),
(15438,13,1,1,1,1,1,1,1,1),
(15438,14,1,1,1,1,1,1,1,1),
(15438,15,1,1,1,1,1,1,1,1),
(15438,16,1,1,1,1,1,1,1,1),
(15438,17,1,1,1,1,1,1,1,1),
(15438,18,1,1,1,1,1,1,1,1),
(15438,19,1,1,1,1,1,1,1,1),
(15438,20,1,1,1,1,1,1,1,1),
(15438,21,1,1,1,1,1,1,1,1),
(15438,22,1,1,1,1,1,1,1,1),
(15438,23,1,1,1,1,1,1,1,1),
(15438,24,1,1,1,1,1,1,1,1),
(15438,25,1,1,1,1,1,1,1,1),
(15438,26,1,1,1,1,1,1,1,1),
(15438,27,1,1,1,1,1,1,1,1),
(15438,28,1,1,1,1,1,1,1,1),
(15438,29,1,1,1,1,1,1,1,1),
(15438,30,1,1,1,1,1,1,1,1),
(15438,31,1,1,1,1,1,1,1,1),
(15438,32,1,1,1,1,1,1,1,1),
(15438,33,1,1,1,1,1,1,1,1),
(15438,34,1,1,1,1,1,1,1,1),
(15438,35,1,1,1,1,1,1,1,1),
(15438,36,1,1,1,1,1,1,1,1),
(15438,37,1,1,1,1,1,1,1,1),
(15438,38,1,1,1,1,1,1,1,1),
(15438,39,1,1,1,1,1,1,1,1),
(15438,40,1,1,1,1,1,1,1,1),
(15438,41,1,1,1,1,1,1,1,1),
(15438,42,1,1,1,1,1,1,1,1),
(15438,43,1,1,1,1,1,1,1,1),
(15438,44,1,1,1,1,1,1,1,1),
(15438,45,1,1,1,1,1,1,1,1),
(15438,46,1,1,1,1,1,1,1,1),
(15438,47,1,1,1,1,1,1,1,1),
(15438,48,1,1,1,1,1,1,1,1),
(15438,49,1,1,1,1,1,1,1,1),
(15438,50,1,1,1,1,1,1,1,1),
(15438,51,1,1,1,1,1,1,1,1),
(15438,52,1,1,1,1,1,1,1,1),
(15438,53,1,1,1,1,1,1,1,1),
(15438,54,1,1,1,1,1,1,1,1),
(15438,55,1,1,1,1,1,1,1,1),
(15438,56,1,1,1,1,1,1,1,1),
(15438,57,1,1,1,1,1,1,1,1),
(15438,58,1,1,1,1,1,1,1,1),
(15438,59,1,1,1,1,1,1,1,1),
(15438,60,1,1,1,1,1,1,1,1),
(15438,61,1,1,1,1,1,1,1,1),
(15438,62,1,1,1,1,1,1,1,1),
(15438,63,1,1,1,1,1,1,1,1),
(15438,64,1,1,1,1,1,1,1,1),
(15438,65,1,1,1,1,1,1,1,1),
(15438,66,1,1,1,1,1,1,1,1),
(15438,67,1,1,1,1,1,1,1,1),
(15438,68,6800,2052,980,198,136,99,320,340),
(15438,69,6900,2071,990,204,138,100,327,350),
(15438,70,7000,2090,1000,210,140,102,334,360),
(26101,1,1,1,0,1,1,1,1,1),
(26101,2,1,1,0,1,1,1,1,1),
(26101,3,1,1,0,1,1,1,1,1),
(26101,4,1,1,0,1,1,1,1,1),
(26101,5,1,1,0,1,1,1,1,1),
(26101,6,1,1,0,1,1,1,1,1),
(26101,7,1,1,0,1,1,1,1,1),
(26101,8,1,1,0,1,1,1,1,1),
(26101,9,1,1,0,1,1,1,1,1),
(26101,10,1,1,0,1,1,1,1,1),
(26101,11,1,1,0,1,1,1,1,1),
(26101,12,1,1,0,1,1,1,1,1),
(26101,13,1,1,0,1,1,1,1,1),
(26101,14,1,1,0,1,1,1,1,1),
(26101,15,1,1,0,1,1,1,1,1),
(26101,16,1,1,0,1,1,1,1,1),
(26101,17,1,1,0,1,1,1,1,1),
(26101,18,1,1,0,1,1,1,1,1),
(26101,19,1,1,0,1,1,1,1,1),
(26101,20,1,1,0,1,1,1,1,1),
(26101,21,1,1,0,1,1,1,1,1),
(26101,22,1,1,0,1,1,1,1,1),
(26101,23,1,1,0,1,1,1,1,1),
(26101,24,1,1,0,1,1,1,1,1),
(26101,25,1,1,0,1,1,1,1,1),
(26101,26,1,1,0,1,1,1,1,1),
(26101,27,1,1,0,1,1,1,1,1),
(26101,28,1,1,0,1,1,1,1,1),
(26101,29,1,1,0,1,1,1,1,1),
(26101,30,1,1,0,1,1,1,1,1),
(26101,31,1,1,0,1,1,1,1,1),
(26101,32,1,1,0,1,1,1,1,1),
(26101,33,1,1,0,1,1,1,1,1),
(26101,34,1,1,0,1,1,1,1,1),
(26101,35,1,1,0,1,1,1,1,1),
(26101,36,1,1,0,1,1,1,1,1),
(26101,37,1,1,0,1,1,1,1,1),
(26101,38,1,1,0,1,1,1,1,1),
(26101,39,1,1,0,1,1,1,1,1),
(26101,40,1,1,0,1,1,1,1,1),
(26101,41,1,1,0,1,1,1,1,1),
(26101,42,1,1,0,1,1,1,1,1),
(26101,43,1,1,0,1,1,1,1,1),
(26101,44,1,1,0,1,1,1,1,1),
(26101,45,1,1,0,1,1,1,1,1),
(26101,46,1,1,0,1,1,1,1,1),
(26101,47,1,1,0,1,1,1,1,1),
(26101,48,1,1,0,1,1,1,1,1),
(26101,49,1,1,0,1,1,1,1,1),
(26101,50,1,1,0,1,1,1,1,1),
(26101,51,1,1,0,1,1,1,1,1),
(26101,52,1,1,0,1,1,1,1,1),
(26101,53,1,1,0,1,1,1,1,1),
(26101,54,1,1,0,1,1,1,1,1),
(26101,55,1,1,0,1,1,1,1,1),
(26101,56,1,1,0,1,1,1,1,1),
(26101,57,1,1,0,1,1,1,1,1),
(26101,58,1,1,0,1,1,1,1,1),
(26101,59,1,1,0,1,1,1,1,1),
(26101,60,1,1,0,1,1,1,1,1),
(26101,61,1,1,0,1,1,1,1,1),
(26101,62,1,1,0,1,1,1,1,1),
(26101,63,1,1,0,1,1,1,1,1),
(26101,64,1,1,0,1,1,1,1,1),
(26101,65,1,1,0,1,1,1,1,1),
(26101,66,1,1,0,1,1,1,1,1),
(26101,67,1,1,0,1,1,1,1,1),
(26101,68,1,1,0,1,1,1,1,1),
(26101,69,1,1,0,1,1,1,1,1),
(26101,70,11352,3155,6792,152,39,102,334,360),
(26101,71,1172,2109,0,155,39,104,341,370),
(26101,72,1195,2128,0,158,40,106,348,380),
(26101,73,1218,2147,0,161,40,108,355,390),
(26101,74,1241,2166,0,164,40,110,362,400),
(26101,75,1264,2185,0,167,41,112,369,410),
(26101,76,1287,2204,0,170,41,114,376,420),
(26101,77,1310,2223,0,173,41,116,383,430),
(26101,78,1333,2242,0,176,42,118,390,440),
(26101,79,1356,2261,0,179,42,120,397,450),
(26101,80,1379,2280,0,182,42,122,404,460),
(24815,71,1174,2110,0,158,40,105,347,370),
(24815,72,1190,2132,0,164,40,106,354,380),
(24815,73,1204,2145,0,179,42,108,363,390),
(24815,74,1219,2159,0,188,43,110,377,400),
(24815,75,1231,2172,0,200,44,113,390,410),
(24815,76,1250,2190,0,211,45,115,402,420),
(24815,77,1269,2203,0,225,46,118,420,430),
(24815,78,1281,2220,0,236,47,131,439,440),
(24815,79,1299,2239,0,249,48,140,450,450),
(24815,80,1314,2252,0,261,50,162,470,460),
(22362,71,1174,2110,0,158,40,105,347,370),
(22362,72,1190,2132,0,164,40,106,354,380),
(22362,73,1204,2145,0,179,42,108,363,390),
(22362,74,1219,2159,0,188,43,110,377,400),
(22362,75,1231,2172,0,200,44,113,390,410),
(22362,76,1250,2190,0,211,45,115,402,420),
(22362,77,1269,2203,0,225,46,118,420,430),
(22362,78,1281,2220,0,236,47,131,439,440),
(22362,79,1299,2239,0,249,48,140,450,450),
(22362,80,1314,2252,0,261,50,162,470,460),
(14385,71,4046,1902,4233,160,88,84,91,78),
(14385,72,4112,1931,4528,162,88,84,92,80),
(14385,73,4179,1960,4828,163,90,86,94,81),
(14385,74,4247,1990,5133,164,90,87,95,82),
(14385,75,4315,2021,5438,166,94,88,97,84),
(14385,76,4384,2051,5748,168,95,90,98,86),
(14385,77,4454,2084,6058,170,95,91,99,87),
(14385,78,4525,2116,6368,174,96,92,100,88),
(14385,79,4597,2149,6683,178,97,92,101,88),
(14385,80,4665,2186,6993,181,98,95,103,90),
(12922,71,1174,2110,0,158,40,105,347,370),
(12922,72,1190,2132,0,164,40,106,354,380),
(12922,73,1204,2145,0,179,42,108,363,390),
(12922,74,1219,2159,0,188,43,110,377,400),
(12922,75,1231,2172,0,200,44,113,390,410),
(12922,76,1250,2190,0,211,45,115,402,420),
(12922,77,1269,2203,0,225,46,118,420,430),
(12922,78,1281,2220,0,236,47,131,439,440),
(12922,79,1299,2239,0,249,48,140,450,450),
(12922,80,1314,2252,0,261,50,162,470,460),
(10979,71,1174,2110,0,158,40,105,347,370),
(10979,72,1190,2132,0,164,40,106,354,380),
(10979,73,1204,2145,0,179,42,108,363,390),
(10979,74,1219,2159,0,188,43,110,377,400),
(10979,75,1231,2172,0,200,44,113,390,410),
(10979,76,1250,2190,0,211,45,115,402,420),
(10979,77,1269,2203,0,225,46,118,420,430),
(10979,78,1281,2220,0,236,47,131,439,440),
(10979,79,1299,2239,0,249,48,140,450,450),
(10979,80,1314,2252,0,261,50,162,470,460),
(10928,71,1174,2110,0,158,40,105,347,370),
(10928,72,1190,2132,0,164,40,106,354,380),
(10928,73,1204,2145,0,179,42,108,363,390),
(10928,74,1219,2159,0,188,43,110,377,400),
(10928,75,1231,2172,0,200,44,113,390,410),
(10928,76,1250,2190,0,211,45,115,402,420),
(10928,77,1269,2203,0,225,46,118,420,430),
(10928,78,1281,2220,0,236,47,131,439,440),
(10928,79,1299,2239,0,249,48,140,450,450),
(10928,80,1314,2252,0,261,50,162,470,460),
(8996,71,1174,2110,0,158,40,105,347,370),
(8996,72,1190,2132,0,164,40,106,354,380),
(8996,73,1204,2145,0,179,42,108,363,390),
(8996,74,1219,2159,0,188,43,110,377,400),
(8996,75,1231,2172,0,200,44,113,390,410),
(8996,76,1250,2190,0,211,45,115,402,420),
(8996,77,1269,2203,0,225,46,118,420,430),
(8996,78,1281,2220,0,236,47,131,439,440),
(8996,79,1299,2239,0,249,48,140,450,450),
(8996,80,1314,2252,0,261,50,162,470,460),
(8477,71,1174,2110,0,158,40,105,347,370),
(8477,72,1190,2132,0,164,40,106,354,380),
(8477,73,1204,2145,0,179,42,108,363,390),
(8477,74,1219,2159,0,188,43,110,377,400),
(8477,75,1231,2172,0,200,44,113,390,410),
(8477,76,1250,2190,0,211,45,115,402,420),
(8477,77,1269,2203,0,225,46,118,420,430),
(8477,78,1281,2220,0,236,47,131,439,440),
(8477,79,1299,2239,0,249,48,140,450,450),
(8477,80,1314,2252,0,261,50,162,470,460),
(3450,71,1174,2110,0,158,40,105,347,370),
(3450,72,1190,2132,0,164,40,106,354,380),
(3450,73,1204,2145,0,179,42,108,363,390),
(3450,74,1219,2159,0,188,43,110,377,400),
(3450,75,1231,2172,0,200,44,113,390,410),
(3450,76,1250,2190,0,211,45,115,402,420),
(3450,77,1269,2203,0,225,46,118,420,430),
(3450,78,1281,2220,0,236,47,131,439,440),
(3450,79,1299,2239,0,249,48,140,450,450),
(3450,80,1314,2252,0,261,50,162,470,460),
(1,71,4162,1,7093,165,131,311,61,97),
(1,72,4273,1,7392,168,134,316,62,99),
(1,73,4384,1,7691,171,137,321,63,101),
(1,74,4495,1,7990,174,140,326,64,103),
(1,75,4606,1,8289,177,143,331,65,105),
(1,76,4717,1,8588,180,146,336,66,107),
(1,77,4828,1,8887,183,149,341,67,109),
(1,78,4939,1,9186,186,152,346,68,111),
(1,79,5050,1,9485,189,155,351,69,113),
(1,80,5161,1,9784,192,158,356,70,115),
(15438,71,7100,2109,1010,218,142,105,342,370),
(15438,72,7200,2133,1020,224,144,106,349,380),
(15438,73,7300,2149,1030,229,146,108,356,390),
(15438,74,7400,2169,1040,238,148,110,363,400),
(15438,75,7500,2188,1050,247,150,113,370,410),
(15438,76,7600,2209,1060,253,152,115,377,420),
(15438,77,7700,2228,1070,260,154,118,384,430),
(15438,78,7800,2246,1080,268,156,120,391,440),
(15438,79,7900,2264,1090,276,158,124,398,450),
(15438,80,8000,2280,1100,283,160,125,405,460),
(15352,71,7100,0,7200,158,72,105,142,370),
(15352,72,7200,0,7400,164,74,106,144,380),
(15352,73,7300,0,7600,179,77,108,147,390),
(15352,74,7400,0,7800,188,80,110,150,400),
(15352,75,7500,0,8000,200,83,113,152,410),
(15352,76,7600,0,8200,211,84,115,155,420),
(15352,77,7700,0,8400,225,86,118,158,430),
(15352,78,7800,0,8600,236,89,131,160,440),
(15352,79,7900,0,8800,249,89,140,163,450),
(15352,80,8000,0,9000,261,90,162,165,460),
(575,71,4501,4560,0,164,122,81,297,192),
(575,72,4797,4664,0,167,125,82,303,196),
(575,73,5093,4768,0,170,129,83,309,200),
(575,74,5389,4872,0,174,132,84,315,204),
(575,75,5685,4976,0,177,136,85,321,208),
(575,76,5980,5080,0,180,139,86,326,212),
(575,77,6276,5184,0,183,142,87,332,216),
(575,78,6572,5288,0,186,146,88,338,220),
(575,79,6868,5392,0,189,149,89,344,224),
(575,80,7164,5496,0,193,153,90,350,228),
(19668,71,2458,4560,0,177,122,81,297,192),
(19668,72,2511,4664,0,181,125,82,303,196),
(19668,73,2564,4768,0,186,129,83,309,200),
(19668,74,2618,4872,0,191,132,84,315,204),
(19668,75,2671,4976,0,196,136,85,321,208),
(19668,76,2724,5080,0,200,139,86,326,212),
(19668,77,2777,5184,0,205,142,87,332,216),
(19668,78,2831,5288,0,210,146,88,338,220),
(19668,79,2884,5392,0,215,149,89,344,224),
(19668,80,2937,5496,0,219,153,90,350,228),
(416,71,1580,2632,2319,148,40,102,342,269),
(416,72,1639,2695,2431,150,41,104,351,274),
(416,73,1699,2763,2544,153,44,104,358,280),
(416,74,1761,2830,2660,156,45,108,365,283),
(416,75,1821,2896,2760,159,46,109,373,288),
(416,76,1882,2964,2890,164,48,110,381,295),
(416,77,1949,3033,2999,166,49,113,390,300),
(416,78,2011,3100,3110,168,50,114,397,308),
(416,79,2073,3167,3150,171,51,115,392,313),
(416,80,2129,3228,3191,175,54,119,402,319),
(417,71,3169,2478,4561,156,111,285,136,124),
(417,72,3227,2535,4721,159,113,290,139,126),
(417,73,3283,2594,4882,162,116,294,143,128),
(417,74,3342,2653,5041,165,118,298,146,129),
(417,75,3403,2711,5199,167,121,304,150,131),
(417,76,3459,2772,5363,170,124,309,153,132),
(417,77,3518,2833,5526,172,127,313,156,135),
(417,78,3576,2894,5688,175,129,319,157,137),
(417,79,3645,2954,5868,177,130,324,158,140),
(417,80,3733,3025,6008,179,133,329,162,142),
(510,71,2489,4568,0,167,123,81,299,195),
(510,72,2549,4676,0,171,127,82,305,200),
(510,73,2609,4784,0,175,131,83,311,205),
(510,74,2669,4892,0,179,135,84,317,210),
(510,75,2729,5000,0,183,139,85,323,215),
(510,76,2789,5108,0,187,143,86,329,220),
(510,77,2849,5216,0,191,147,87,335,225),
(510,78,2909,5324,0,195,151,88,341,230),
(510,79,2969,5432,0,199,155,89,347,235),
(510,80,3029,5540,0,203,159,90,353,240),
(1860,71,5010,2992,9484,155,112,283,137,194),
(1860,72,5161,3100,9861,157,114,286,141,197),
(1860,73,5313,3208,10231,159,116,289,145,201),
(1860,74,5466,3317,10603,163,120,293,151,205),
(1860,75,5620,3426,10983,165,123,296,156,214),
(1860,76,5775,3535,11362,167,125,300,160,218),
(1860,77,5930,3645,11743,170,127,303,165,222),
(1860,78,6086,3758,12125,172,129,306,172,226),
(1860,79,6243,3874,12508,174,131,310,178,231),
(1860,80,6401,3997,13011,177,134,313,185,235),
(1863,71,2211,2460,4479,155,110,284,136,124),
(1863,72,2259,2516,4666,157,111,288,139,125),
(1863,73,2308,2573,4854,159,113,293,143,127),
(1863,74,2358,2631,5042,161,115,298,147,131),
(1863,75,2409,2660,5231,164,118,303,150,134),
(1863,76,2461,2735,5421,167,120,309,154,137),
(1863,77,2512,2793,5612,170,122,314,156,141),
(1863,78,2562,2852,5804,172,124,319,158,143),
(1863,79,2612,2911,5997,175,127,324,160,147),
(1863,80,2665,2989,6204,178,130,330,163,150),
(17252,71,5471,4277,8267,155,109,359,204,124),
(17252,72,5623,4384,8607,158,111,367,211,125),
(17252,73,5776,4492,8952,161,113,375,219,128),
(17252,74,5930,4600,9297,164,115,382,227,130),
(17252,75,6085,4709,9647,166,118,390,235,132),
(17252,76,6241,4818,9997,170,121,399,242,135),
(17252,77,6398,4927,10352,172,124,407,250,138),
(17252,78,6556,5036,10712,174,125,414,257,141),
(17252,79,6711,5144,11067,176,127,423,266,145),
(17252,80,6872,5266,11454,177,130,432,275,150),
(329,1,140,48,20,20,5,20,24,23),
(329,2,149,59,20,21,5,2,25,24),
(329,3,158,70,20,15,5,4,26,25),
(329,4,168,81,33,17,5,8,27,26),
(329,5,177,92,49,18,5,12,28,27),
(329,6,186,103,68,20,7,16,29,27),
(329,7,195,114,92,22,7,21,30,28),
(329,8,204,125,117,23,8,25,31,29),
(329,9,213,136,147,25,9,27,32,30),
(329,10,223,147,180,29,10,29,33,31),
(329,11,232,158,190,30,11,32,37,35),
(329,12,250,180,203,31,12,36,41,39),
(329,13,289,203,215,32,13,43,50,43),
(329,14,299,227,228,33,13,44,54,47),
(329,15,309,251,240,34,13,48,57,52),
(329,16,329,275,253,36,13,52,62,56),
(329,17,350,300,265,38,13,55,65,65),
(329,18,362,314,278,39,13,59,70,70),
(329,19,393,351,291,40,13,63,74,75),
(329,20,403,377,303,42,13,67,87,78),
(329,21,425,393,320,44,13,80,91,83),
(329,22,449,420,346,46,13,84,95,86),
(329,23,473,447,360,47,13,89,96,90),
(329,24,520,476,373,49,13,93,97,95),
(329,25,540,504,386,50,13,97,98,100),
(329,26,569,534,399,52,13,101,60,78),
(329,27,571,564,411,53,14,105,61,81),
(329,28,574,592,424,55,15,110,62,86),
(329,29,576,620,436,57,16,114,62,89),
(329,30,579,648,449,57,16,118,63,92),
(329,31,581,676,462,59,16,123,64,95),
(329,32,590,720,476,60,17,127,64,98),
(329,33,598,742,488,62,18,131,65,101),
(329,34,601,793,501,63,19,135,65,104),
(329,35,609,845,513,64,19,136,66,107),
(329,36,617,879,525,67,19,137,66,110),
(329,37,626,916,537,69,19,138,68,112),
(329,38,634,952,549,70,19,139,68,115),
(329,39,642,988,561,72,19,142,69,118),
(329,40,650,1026,639,74,20,147,156,142),
(329,41,668,1063,694,77,20,152,160,143),
(329,42,676,1103,756,81,20,156,163,144),
(329,43,685,1187,808,87,20,160,167,145),
(329,44,693,1214,853,91,21,164,170,146),
(329,45,701,1240,884,96,21,169,174,148),
(329,46,709,1267,910,98,22,173,177,149),
(329,47,718,1294,928,100,22,177,181,151),
(329,48,726,1320,946,102,22,181,184,152),
(329,49,734,1347,964,105,22,186,188,155),
(329,50,747,1391,983,107,22,190,194,158),
(329,51,750,1435,996,109,22,194,202,161),
(329,52,764,1481,1013,112,24,198,208,165),
(329,53,787,1527,1039,114,25,203,215,168),
(329,54,820,1573,1055,115,26,207,222,172),
(329,55,836,1620,1078,119,26,211,229,177),
(329,56,846,1666,1091,121,27,215,236,181),
(329,57,850,1714,1101,123,27,220,243,185),
(329,58,862,1763,1125,125,27,224,250,189),
(329,59,878,1824,1150,127,27,230,258,192),
(329,60,920,1898,1163,122,27,128,264,197),
(329,61,973,1925,1608,132,29,251,271,239),
(329,62,1050,1977,1663,135,31,253,278,241),
(329,63,1188,2030,1732,137,32,255,285,244),
(329,64,1292,2084,1809,139,33,259,292,247),
(329,65,1335,2137,1844,142,33,264,299,250),
(329,66,1357,2191,1872,144,33,268,306,255),
(329,67,1401,2244,1900,146,33,272,313,258),
(329,68,1429,2298,1987,148,34,276,320,260),
(329,69,1464,2351,2008,151,36,278,327,262),
(329,70,1528,2568,2227,152,39,103,334,264),
(329,71,7100,2109,1010,71,39,104,341,370),
(329,72,7200,2128,1020,72,39,105,348,380),
(329,73,7300,2147,1030,73,40,107,355,390),
(329,74,7400,2167,1040,74,40,108,362,400),
(329,75,7500,2186,1050,75,40,110,369,410),
(329,76,7600,2205,1060,76,41,111,376,420),
(329,77,7700,2224,1070,77,41,113,383,430),
(329,78,7800,2243,1080,78,42,115,390,440),
(329,79,7900,2262,1090,79,42,116,397,450),
(329,80,8000,2282,1100,80,42,118,404,460),
(3939,1,140,48,20,20,5,20,24,23),
(3939,2,149,59,20,21,5,2,25,24),
(3939,3,158,70,20,15,5,4,26,25),
(3939,4,168,81,33,17,5,8,27,26),
(3939,5,177,92,49,18,5,12,28,27),
(3939,6,186,103,68,20,7,16,29,27),
(3939,7,195,114,92,22,7,21,30,28),
(3939,8,204,125,117,23,8,25,31,29),
(3939,9,213,136,147,25,9,27,32,30),
(3939,10,223,147,180,29,10,29,33,31),
(3939,11,232,158,190,30,11,32,37,35),
(3939,12,250,180,203,31,12,36,41,39),
(3939,13,289,203,215,32,13,43,50,43),
(3939,14,299,227,228,33,13,44,54,47),
(3939,15,309,251,240,34,13,48,57,52),
(3939,16,329,275,253,36,13,52,62,56),
(3939,17,350,300,265,38,13,55,65,65),
(3939,18,362,314,278,39,13,59,70,70),
(3939,19,393,351,291,40,13,63,74,75),
(3939,20,403,377,303,42,13,67,87,78),
(3939,21,425,393,320,44,13,80,91,83),
(3939,22,449,420,346,46,13,84,95,86),
(3939,23,473,447,360,47,13,89,96,90),
(3939,24,520,476,373,49,13,93,97,95),
(3939,25,540,504,386,50,13,97,98,100),
(3939,26,569,534,399,52,13,101,60,78),
(3939,27,571,564,411,53,14,105,61,81),
(3939,28,574,592,424,55,15,110,62,86),
(3939,29,576,620,436,57,16,114,62,89),
(3939,30,579,648,449,57,16,118,63,92),
(3939,31,581,676,462,59,16,123,64,95),
(3939,32,590,720,476,60,17,127,64,98),
(3939,33,598,742,488,62,18,131,65,101),
(3939,34,601,793,501,63,19,135,65,104),
(3939,35,609,845,513,64,19,136,66,107),
(3939,36,617,879,525,67,19,137,66,110),
(3939,37,626,916,537,69,19,138,68,112),
(3939,38,634,952,549,70,19,139,68,115),
(3939,39,642,988,561,72,19,142,69,118),
(3939,40,650,1026,639,74,20,147,156,142),
(3939,41,668,1063,694,77,20,152,160,143),
(3939,42,676,1103,756,81,20,156,163,144),
(3939,43,685,1187,808,87,20,160,167,145),
(3939,44,693,1214,853,91,21,164,170,146),
(3939,45,701,1240,884,96,21,169,174,148),
(3939,46,709,1267,910,98,22,173,177,149),
(3939,47,718,1294,928,100,22,177,181,151),
(3939,48,726,1320,946,102,22,181,184,152),
(3939,49,734,1347,964,105,22,186,188,155),
(3939,50,747,1391,983,107,22,190,194,158),
(3939,51,750,1435,996,109,22,194,202,161),
(3939,52,764,1481,1013,112,24,198,208,165),
(3939,53,787,1527,1039,114,25,203,215,168),
(3939,54,820,1573,1055,115,26,207,222,172),
(3939,55,836,1620,1078,119,26,211,229,177),
(3939,56,846,1666,1091,121,27,215,236,181),
(3939,57,850,1714,1101,123,27,220,243,185),
(3939,58,862,1763,1125,125,27,224,250,189),
(3939,59,878,1824,1150,127,27,230,258,192),
(3939,60,920,1898,1163,122,27,128,264,197),
(3939,61,973,1925,1608,132,29,251,271,239),
(3939,62,1050,1977,1663,135,31,253,278,241),
(3939,63,1188,2030,1732,137,32,255,285,244),
(3939,64,1292,2084,1809,139,33,259,292,247),
(3939,65,1335,2137,1844,142,33,264,299,250),
(3939,66,1357,2191,1872,144,33,268,306,255),
(3939,67,1401,2244,1900,146,33,272,313,258),
(3939,68,1429,2298,1987,148,34,276,320,260),
(3939,69,1464,2351,2008,151,36,278,327,262),
(3939,70,1528,2568,2227,152,39,103,334,264),
(3939,71,5654,4225,8300,155,112,325,135,124),
(3939,72,5750,4377,8380,157,115,329,136,126),
(3939,73,5945,4430,8440,159,118,332,137,129),
(3939,74,6191,4584,8550,162,121,335,138,131),
(3939,75,6349,4646,8612,164,123,338,139,134),
(3939,76,6676,4778,8910,166,126,343,140,136),
(3939,77,6884,4863,9150,169,129,347,141,138),
(3939,78,7097,4949,9450,172,132,351,142,141),
(3939,79,7208,5035,9800,174,135,355,143,143),
(3939,80,7320,5170,10087,177,137,361,144,146),
(5058,1,40,48,20,12,14,1,1,25),
(5058,2,49,59,40,14,15,2,1,26),
(5058,3,58,70,60,15,16,4,1,27),
(5058,4,68,81,80,17,17,8,2,27),
(5058,5,77,92,100,18,18,12,2,28),
(5058,6,86,103,120,20,19,16,3,29),
(5058,7,95,114,140,22,20,21,3,29),
(5058,8,104,125,160,23,21,25,4,30),
(5058,9,113,136,180,25,22,29,4,31),
(5058,10,123,147,200,26,23,33,5,31),
(5058,11,132,158,220,28,25,38,6,32),
(5058,12,150,180,240,29,26,42,8,33),
(5058,13,169,203,280,31,27,46,9,34),
(5058,14,189,227,320,33,28,50,11,35),
(5058,15,209,251,360,34,29,55,14,35),
(5058,16,229,275,400,36,30,59,16,36),
(5058,17,250,300,460,37,31,63,20,37),
(5058,18,262,314,510,39,32,67,24,38),
(5058,19,293,351,550,40,33,72,29,39),
(5058,20,303,377,563,42,35,67,31,49),
(5058,21,325,393,604,44,36,80,53,39),
(5058,22,349,420,628,46,36,84,54,41),
(5058,23,373,447,652,47,38,89,56,42),
(5058,24,400,476,675,49,39,93,57,43),
(5058,25,440,504,699,50,40,97,60,44),
(5058,26,469,534,721,52,41,101,62,46),
(5058,27,501,564,745,53,42,105,63,47),
(5058,28,534,592,768,55,43,110,65,48),
(5058,29,566,620,791,57,44,114,67,49),
(5058,30,599,648,815,57,46,118,69,51),
(5058,31,631,676,838,59,47,123,71,52),
(5058,32,680,720,862,60,47,127,73,53),
(5058,33,728,742,884,62,49,131,74,54),
(5058,34,661,793,908,64,50,135,76,56),
(5058,35,699,845,950,63,51,136,73,57),
(5058,36,737,879,990,67,52,137,72,58),
(5058,37,776,916,1038,69,53,138,70,59),
(5058,38,814,952,1095,70,55,139,69,61),
(5058,39,852,988,1163,72,56,142,68,62),
(5058,40,890,1026,1244,74,57,147,67,64),
(5058,41,928,1063,1338,77,58,152,68,66),
(5058,42,976,1103,1448,81,59,156,70,67),
(5058,43,1005,1187,1560,87,60,160,72,69),
(5058,44,1043,1214,1670,91,61,164,74,71),
(5058,45,1081,1240,1738,96,64,169,75,72),
(5058,46,1119,1267,1773,98,65,173,77,73),
(5058,47,1158,1294,1808,100,66,177,78,75),
(5058,48,1196,1320,1843,102,68,181,80,76),
(5058,49,1234,1347,1878,105,69,186,82,78),
(5058,50,2877,2391,3494,107,71,219,95,80),
(5058,51,2920,2435,3559,109,72,223,97,81),
(5058,52,3164,2481,3624,112,74,228,100,82),
(5058,53,3207,2527,3686,113,75,233,102,84),
(5058,54,3350,2573,3752,116,77,238,104,87),
(5058,55,3493,2620,3814,119,78,243,106,88),
(5058,56,3536,2766,3878,120,79,248,108,89),
(5058,57,3680,2814,3941,123,82,251,111,92),
(5058,58,3723,2913,4006,125,84,255,113,94),
(5058,59,3866,2924,4067,128,86,258,115,96),
(5058,60,3909,3174,4635,130,87,270,118,98),
(5058,61,4054,3225,6300,132,90,274,121,101),
(5058,62,4300,3377,6380,135,92,280,122,103),
(5058,63,4545,3430,6440,137,93,286,123,105),
(5058,64,4691,3584,6550,139,95,295,128,107),
(5058,65,4749,3646,6612,142,98,300,129,110),
(5058,66,4876,3778,6910,144,99,306,130,112),
(5058,67,4984,3863,7150,146,101,310,131,114),
(5058,68,5197,3949,7450,148,105,315,132,117),
(5058,69,5208,4035,7800,151,107,318,133,119),
(5058,70,5320,4170,8087,153,109,322,134,122),
(5058,71,4162,1,7093,165,131,311,61,97),
(5058,72,4273,1,7392,168,134,316,62,99),
(5058,73,4384,1,7691,171,137,321,63,101),
(5058,74,4495,1,7990,174,140,326,64,103),
(5058,75,4606,1,8289,177,143,331,65,105),
(5058,76,4717,1,8588,180,146,336,66,107),
(5058,77,4828,1,8887,183,149,341,67,109),
(5058,78,4939,1,9186,186,152,346,68,111),
(5058,79,5050,1,9485,189,155,351,69,113),
(5058,80,5161,1,9784,192,158,356,70,115),
(5766,1,140,48,20,20,5,20,24,23),
(5766,2,149,59,20,21,5,2,25,24),
(5766,3,158,70,20,15,5,4,26,25),
(5766,4,168,81,33,17,5,8,27,26),
(5766,5,177,92,49,18,5,12,28,27),
(5766,6,186,103,68,20,7,16,29,27),
(5766,7,195,114,92,22,7,21,30,28),
(5766,8,204,125,117,23,8,25,31,29),
(5766,9,213,136,147,25,9,27,32,30),
(5766,10,223,147,180,29,10,29,33,31),
(5766,11,232,158,190,30,11,32,37,35),
(5766,12,250,180,203,31,12,36,41,39),
(5766,13,289,203,215,32,13,43,50,43),
(5766,14,299,227,228,33,13,44,54,47),
(5766,15,309,251,240,34,13,48,57,52),
(5766,16,329,275,253,36,13,52,62,56),
(5766,17,350,300,265,38,13,55,65,65),
(5766,18,362,314,278,39,13,59,70,70),
(5766,19,393,351,291,40,13,63,74,75),
(5766,20,403,377,303,42,13,67,87,78),
(5766,21,425,393,320,44,13,80,91,83),
(5766,22,449,420,346,46,13,84,95,86),
(5766,23,473,447,360,47,13,89,96,90),
(5766,24,520,476,373,49,13,93,97,95),
(5766,25,540,504,386,50,13,97,98,100),
(5766,26,569,534,399,52,13,101,60,78),
(5766,27,571,564,411,53,14,105,61,81),
(5766,28,574,592,424,55,15,110,62,86),
(5766,29,576,620,436,57,16,114,62,89),
(5766,30,579,648,449,57,16,118,63,92),
(5766,31,581,676,462,59,16,123,64,95),
(5766,32,590,720,476,60,17,127,64,98),
(5766,33,598,742,488,62,18,131,65,101),
(5766,34,601,793,501,63,19,135,65,104),
(5766,35,609,845,513,64,19,136,66,107),
(5766,36,617,879,525,67,19,137,66,110),
(5766,37,626,916,537,69,19,138,68,112),
(5766,38,634,952,549,70,19,139,68,115),
(5766,39,642,988,561,72,19,142,69,118),
(5766,40,650,1026,639,74,20,147,156,142),
(5766,41,668,1063,694,77,20,152,160,143),
(5766,42,676,1103,756,81,20,156,163,144),
(5766,43,685,1187,808,87,20,160,167,145),
(5766,44,693,1214,853,91,21,164,170,146),
(5766,45,701,1240,884,96,21,169,174,148),
(5766,46,709,1267,910,98,22,173,177,149),
(5766,47,718,1294,928,100,22,177,181,151),
(5766,48,726,1320,946,102,22,181,184,152),
(5766,49,734,1347,964,105,22,186,188,155),
(5766,50,747,1391,983,107,22,190,194,158),
(5766,51,750,1435,996,109,22,194,202,161),
(5766,52,764,1481,1013,112,24,198,208,165),
(5766,53,787,1527,1039,114,25,203,215,168),
(5766,54,820,1573,1055,115,26,207,222,172),
(5766,55,836,1620,1078,119,26,211,229,177),
(5766,56,846,1666,1091,121,27,215,236,181),
(5766,57,850,1714,1101,123,27,220,243,185),
(5766,58,862,1763,1125,125,27,224,250,189),
(5766,59,878,1824,1150,127,27,230,258,192),
(5766,60,920,1898,1163,122,27,128,264,197),
(5766,61,973,1925,1608,132,29,251,271,239),
(5766,62,1050,1977,1663,135,31,253,278,241),
(5766,63,1188,2030,1732,137,32,255,285,244),
(5766,64,1292,2084,1809,139,33,259,292,247),
(5766,65,1335,2137,1844,142,33,264,299,250),
(5766,66,1357,2191,1872,144,33,268,306,255),
(5766,67,1401,2244,1900,146,33,272,313,258),
(5766,68,1429,2298,1987,148,34,276,320,260),
(5766,69,1464,2351,2008,151,36,278,327,262),
(5766,70,1528,2568,2227,152,39,103,334,264),
(5766,71,4162,1,7093,165,131,311,61,97),
(5766,72,4273,1,7392,168,134,316,62,99),
(5766,73,4384,1,7691,171,137,321,63,101),
(5766,74,4495,1,7990,174,140,326,64,103),
(5766,75,4606,1,8289,177,143,331,65,105),
(5766,76,4717,1,8588,180,146,336,66,107),
(5766,77,4828,1,8887,183,149,341,67,109),
(5766,78,4939,1,9186,186,152,346,68,111),
(5766,79,5050,1,9485,189,155,351,69,113),
(5766,80,5161,1,9784,192,158,356,70,115),
(6250,1,140,48,20,20,5,20,24,23),
(6250,2,149,59,20,21,5,2,25,24),
(6250,3,158,70,20,15,5,4,26,25),
(6250,4,168,81,33,17,5,8,27,26),
(6250,5,177,92,49,18,5,12,28,27),
(6250,6,186,103,68,20,7,16,29,27),
(6250,7,195,114,92,22,7,21,30,28),
(6250,8,204,125,117,23,8,25,31,29),
(6250,9,213,136,147,25,9,27,32,30),
(6250,10,223,147,180,29,10,29,33,31),
(6250,11,232,158,190,30,11,32,37,35),
(6250,12,250,180,203,31,12,36,41,39),
(6250,13,289,203,215,32,13,43,50,43),
(6250,14,299,227,228,33,13,44,54,47),
(6250,15,309,251,240,34,13,48,57,52),
(6250,16,329,275,253,36,13,52,62,56),
(6250,17,350,300,265,38,13,55,65,65),
(6250,18,362,314,278,39,13,59,70,70),
(6250,19,393,351,291,40,13,63,74,75),
(6250,20,403,377,303,42,13,67,87,78),
(6250,21,425,393,320,44,13,80,91,83),
(6250,22,449,420,346,46,13,84,95,86),
(6250,23,473,447,360,47,13,89,96,90),
(6250,24,520,476,373,49,13,93,97,95),
(6250,25,540,504,386,50,13,97,98,100),
(6250,26,569,534,399,52,13,101,60,78),
(6250,27,571,564,411,53,14,105,61,81),
(6250,28,574,592,424,55,15,110,62,86),
(6250,29,576,620,436,57,16,114,62,89),
(6250,30,579,648,449,57,16,118,63,92),
(6250,31,581,676,462,59,16,123,64,95),
(6250,32,590,720,476,60,17,127,64,98),
(6250,33,598,742,488,62,18,131,65,101),
(6250,34,601,793,501,63,19,135,65,104),
(6250,35,609,845,513,64,19,136,66,107),
(6250,36,617,879,525,67,19,137,66,110),
(6250,37,626,916,537,69,19,138,68,112),
(6250,38,634,952,549,70,19,139,68,115),
(6250,39,642,988,561,72,19,142,69,118),
(6250,40,650,1026,639,74,20,147,156,142),
(6250,41,668,1063,694,77,20,152,160,143),
(6250,42,676,1103,756,81,20,156,163,144),
(6250,43,685,1187,808,87,20,160,167,145),
(6250,44,693,1214,853,91,21,164,170,146),
(6250,45,701,1240,884,96,21,169,174,148),
(6250,46,709,1267,910,98,22,173,177,149),
(6250,47,718,1294,928,100,22,177,181,151),
(6250,48,726,1320,946,102,22,181,184,152),
(6250,49,734,1347,964,105,22,186,188,155),
(6250,50,747,1391,983,107,22,190,194,158),
(6250,51,750,1435,996,109,22,194,202,161),
(6250,52,764,1481,1013,112,24,198,208,165),
(6250,53,787,1527,1039,114,25,203,215,168),
(6250,54,820,1573,1055,115,26,207,222,172),
(6250,55,836,1620,1078,119,26,211,229,177),
(6250,56,846,1666,1091,121,27,215,236,181),
(6250,57,850,1714,1101,123,27,220,243,185),
(6250,58,862,1763,1125,125,27,224,250,189),
(6250,59,878,1824,1150,127,27,230,258,192),
(6250,60,920,1898,1163,122,27,128,264,197),
(6250,61,973,1925,1608,132,29,251,271,239),
(6250,62,1050,1977,1663,135,31,253,278,241),
(6250,63,1188,2030,1732,137,32,255,285,244),
(6250,64,1292,2084,1809,139,33,259,292,247),
(6250,65,1335,2137,1844,142,33,264,299,250),
(6250,66,1357,2191,1872,144,33,268,306,255),
(6250,67,1401,2244,1900,146,33,272,313,258),
(6250,68,1429,2298,1987,148,34,276,320,260),
(6250,69,1464,2351,2008,151,36,278,327,262),
(6250,70,1528,2568,2227,152,39,103,334,264),
(6250,71,4162,1,7093,165,131,311,61,97),
(6250,72,4273,1,7392,168,134,316,62,99),
(6250,73,4384,1,7691,171,137,321,63,101),
(6250,74,4495,1,7990,174,140,326,64,103),
(6250,75,4606,1,8289,177,143,331,65,105),
(6250,76,4717,1,8588,180,146,336,66,107),
(6250,77,4828,1,8887,183,149,341,67,109),
(6250,78,4939,1,9186,186,152,346,68,111),
(6250,79,5050,1,9485,189,155,351,69,113),
(6250,80,5161,1,9784,192,158,356,70,115),
(15214,1,140,48,20,20,5,20,24,23),
(15214,2,149,59,20,21,5,2,25,24),
(15214,3,158,70,20,15,5,4,26,25),
(15214,4,168,81,33,17,5,8,27,26),
(15214,5,177,92,49,18,5,12,28,27),
(15214,6,186,103,68,20,7,16,29,27),
(15214,7,195,114,92,22,7,21,30,28),
(15214,8,204,125,117,23,8,25,31,29),
(15214,9,213,136,147,25,9,27,32,30),
(15214,10,223,147,180,29,10,29,33,31),
(15214,11,232,158,190,30,11,32,37,35),
(15214,12,250,180,203,31,12,36,41,39),
(15214,13,289,203,215,32,13,43,50,43),
(15214,14,299,227,228,33,13,44,54,47),
(15214,15,309,251,240,34,13,48,57,52),
(15214,16,329,275,253,36,13,52,62,56),
(15214,17,350,300,265,38,13,55,65,65),
(15214,18,362,314,278,39,13,59,70,70),
(15214,19,393,351,291,40,13,63,74,75),
(15214,20,403,377,303,42,13,67,87,78),
(15214,21,425,393,320,44,13,80,91,83),
(15214,22,449,420,346,46,13,84,95,86),
(15214,23,473,447,360,47,13,89,96,90),
(15214,24,520,476,373,49,13,93,97,95),
(15214,25,540,504,386,50,13,97,98,100),
(15214,26,569,534,399,52,13,101,60,78),
(15214,27,571,564,411,53,14,105,61,81),
(15214,28,574,592,424,55,15,110,62,86),
(15214,29,576,620,436,57,16,114,62,89),
(15214,30,579,648,449,57,16,118,63,92),
(15214,31,581,676,462,59,16,123,64,95),
(15214,32,590,720,476,60,17,127,64,98),
(15214,33,598,742,488,62,18,131,65,101),
(15214,34,601,793,501,63,19,135,65,104),
(15214,35,609,845,513,64,19,136,66,107),
(15214,36,617,879,525,67,19,137,66,110),
(15214,37,626,916,537,69,19,138,68,112),
(15214,38,634,952,549,70,19,139,68,115),
(15214,39,642,988,561,72,19,142,69,118),
(15214,40,650,1026,639,74,20,147,156,142),
(15214,41,668,1063,694,77,20,152,160,143),
(15214,42,676,1103,756,81,20,156,163,144),
(15214,43,685,1187,808,87,20,160,167,145),
(15214,44,693,1214,853,91,21,164,170,146),
(15214,45,701,1240,884,96,21,169,174,148),
(15214,46,709,1267,910,98,22,173,177,149),
(15214,47,718,1294,928,100,22,177,181,151),
(15214,48,726,1320,946,102,22,181,184,152),
(15214,49,734,1347,964,105,22,186,188,155),
(15214,50,747,1391,983,107,22,190,194,158),
(15214,51,750,1435,996,109,22,194,202,161),
(15214,52,764,1481,1013,112,24,198,208,165),
(15214,53,787,1527,1039,114,25,203,215,168),
(15214,54,820,1573,1055,115,26,207,222,172),
(15214,55,836,1620,1078,119,26,211,229,177),
(15214,56,846,1666,1091,121,27,215,236,181),
(15214,57,850,1714,1101,123,27,220,243,185),
(15214,58,862,1763,1125,125,27,224,250,189),
(15214,59,878,1824,1150,127,27,230,258,192),
(15214,60,920,1898,1163,122,27,128,264,197),
(15214,61,973,1925,1608,132,29,251,271,239),
(15214,62,1050,1977,1663,135,31,253,278,241),
(15214,63,1188,2030,1732,137,32,255,285,244),
(15214,64,1292,2084,1809,139,33,259,292,247),
(15214,65,1335,2137,1844,142,33,264,299,250),
(15214,66,1357,2191,1872,144,33,268,306,255),
(15214,67,1401,2244,1900,146,33,272,313,258),
(15214,68,1429,2298,1987,148,34,276,320,260),
(15214,69,1464,2351,2008,151,36,278,327,262),
(15214,70,1528,2568,2227,152,39,103,334,264),
(15214,71,5654,4225,8300,155,112,325,135,124),
(15214,72,5750,4377,8380,157,115,329,136,126),
(15214,73,5945,4430,8440,159,118,332,137,129),
(15214,74,6191,4584,8550,162,121,335,138,131),
(15214,75,6349,4646,8612,164,123,338,139,134),
(15214,76,6676,4778,8910,166,126,343,140,136),
(15214,77,6884,4863,9150,169,129,347,141,138),
(15214,78,7097,4949,9450,172,132,351,142,141),
(15214,79,7208,5035,9800,174,135,355,143,143),
(15214,80,7320,5170,10087,177,137,361,144,146),
(24476,1,140,48,20,20,5,20,24,23),
(24476,2,149,59,20,21,5,2,25,24),
(24476,3,158,70,20,15,5,4,26,25),
(24476,4,168,81,33,17,5,8,27,26),
(24476,5,177,92,49,18,5,12,28,27),
(24476,6,186,103,68,20,7,16,29,27),
(24476,7,195,114,92,22,7,21,30,28),
(24476,8,204,125,117,23,8,25,31,29),
(24476,9,213,136,147,25,9,27,32,30),
(24476,10,223,147,180,29,10,29,33,31),
(24476,11,232,158,190,30,11,32,37,35),
(24476,12,250,180,203,31,12,36,41,39),
(24476,13,289,203,215,32,13,43,50,43),
(24476,14,299,227,228,33,13,44,54,47),
(24476,15,309,251,240,34,13,48,57,52),
(24476,16,329,275,253,36,13,52,62,56),
(24476,17,350,300,265,38,13,55,65,65),
(24476,18,362,314,278,39,13,59,70,70),
(24476,19,393,351,291,40,13,63,74,75),
(24476,20,403,377,303,42,13,67,87,78),
(24476,21,425,393,320,44,13,80,91,83),
(24476,22,449,420,346,46,13,84,95,86),
(24476,23,473,447,360,47,13,89,96,90),
(24476,24,520,476,373,49,13,93,97,95),
(24476,25,540,504,386,50,13,97,98,100),
(24476,26,569,534,399,52,13,101,60,78),
(24476,27,571,564,411,53,14,105,61,81),
(24476,28,574,592,424,55,15,110,62,86),
(24476,29,576,620,436,57,16,114,62,89),
(24476,30,579,648,449,57,16,118,63,92),
(24476,31,581,676,462,59,16,123,64,95),
(24476,32,590,720,476,60,17,127,64,98),
(24476,33,598,742,488,62,18,131,65,101),
(24476,34,601,793,501,63,19,135,65,104),
(24476,35,609,845,513,64,19,136,66,107),
(24476,36,617,879,525,67,19,137,66,110),
(24476,37,626,916,537,69,19,138,68,112),
(24476,38,634,952,549,70,19,139,68,115),
(24476,39,642,988,561,72,19,142,69,118),
(24476,40,650,1026,639,74,20,147,156,142),
(24476,41,668,1063,694,77,20,152,160,143),
(24476,42,676,1103,756,81,20,156,163,144),
(24476,43,685,1187,808,87,20,160,167,145),
(24476,44,693,1214,853,91,21,164,170,146),
(24476,45,701,1240,884,96,21,169,174,148),
(24476,46,709,1267,910,98,22,173,177,149),
(24476,47,718,1294,928,100,22,177,181,151),
(24476,48,726,1320,946,102,22,181,184,152),
(24476,49,734,1347,964,105,22,186,188,155),
(24476,50,747,1391,983,107,22,190,194,158),
(24476,51,750,1435,996,109,22,194,202,161),
(24476,52,764,1481,1013,112,24,198,208,165),
(24476,53,787,1527,1039,114,25,203,215,168),
(24476,54,820,1573,1055,115,26,207,222,172),
(24476,55,836,1620,1078,119,26,211,229,177),
(24476,56,846,1666,1091,121,27,215,236,181),
(24476,57,850,1714,1101,123,27,220,243,185),
(24476,58,862,1763,1125,125,27,224,250,189),
(24476,59,878,1824,1150,127,27,230,258,192),
(24476,60,920,1898,1163,122,27,128,264,197),
(24476,61,973,1925,1608,132,29,251,271,239),
(24476,62,1050,1977,1663,135,31,253,278,241),
(24476,63,1188,2030,1732,137,32,255,285,244),
(24476,64,1292,2084,1809,139,33,259,292,247),
(24476,65,1335,2137,1844,142,33,264,299,250),
(24476,66,1357,2191,1872,144,33,268,306,255),
(24476,67,1401,2244,1900,146,33,272,313,258),
(24476,68,1429,2298,1987,148,34,276,320,260),
(24476,69,1464,2351,2008,151,36,278,327,262),
(24476,70,1528,2568,2227,152,39,103,334,264),
(24476,71,4162,1,7093,165,131,311,61,97),
(24476,72,4273,1,7392,168,134,316,62,99),
(24476,73,4384,1,7691,171,137,321,63,101),
(24476,74,4495,1,7990,174,140,326,64,103),
(24476,75,4606,1,8289,177,143,331,65,105),
(24476,76,4717,1,8588,180,146,336,66,107),
(24476,77,4828,1,8887,183,149,341,67,109),
(24476,78,4939,1,9186,186,152,346,68,111),
(24476,79,5050,1,9485,189,155,351,69,113),
(24476,80,5161,1,9784,192,158,356,70,115),
(24656,1,1,1,0,1,1,1,1,1),
(24656,2,1,1,0,1,1,1,1,1),
(24656,3,1,1,0,1,1,1,1,1),
(24656,4,1,1,0,1,1,1,1,1),
(24656,5,1,1,0,1,1,1,1,1),
(24656,6,1,1,0,1,1,1,1,1),
(24656,7,1,1,0,1,1,1,1,1),
(24656,8,1,1,0,1,1,1,1,1),
(24656,9,1,1,0,1,1,1,1,1),
(24656,10,1,1,0,1,1,1,1,1),
(24656,11,1,1,0,1,1,1,1,1),
(24656,12,1,1,0,1,1,1,1,1),
(24656,13,1,1,0,1,1,1,1,1),
(24656,14,1,1,0,1,1,1,1,1),
(24656,15,1,1,0,1,1,1,1,1),
(24656,16,1,1,0,1,1,1,1,1),
(24656,17,1,1,0,1,1,1,1,1),
(24656,18,1,1,0,1,1,1,1,1),
(24656,19,1,1,0,1,1,1,1,1),
(24656,20,1,1,0,1,1,1,1,1),
(24656,21,1,1,0,1,1,1,1,1),
(24656,22,1,1,0,1,1,1,1,1),
(24656,23,1,1,0,1,1,1,1,1),
(24656,24,1,1,0,1,1,1,1,1),
(24656,25,1,1,0,1,1,1,1,1),
(24656,26,1,1,0,1,1,1,1,1),
(24656,27,1,1,0,1,1,1,1,1),
(24656,28,1,1,0,1,1,1,1,1),
(24656,29,1,1,0,1,1,1,1,1),
(24656,30,1,1,0,1,1,1,1,1),
(24656,31,1,1,0,1,1,1,1,1),
(24656,32,1,1,0,1,1,1,1,1),
(24656,33,1,1,0,1,1,1,1,1),
(24656,34,1,1,0,1,1,1,1,1),
(24656,35,1,1,0,1,1,1,1,1),
(24656,36,1,1,0,1,1,1,1,1),
(24656,37,1,1,0,1,1,1,1,1),
(24656,38,1,1,0,1,1,1,1,1),
(24656,39,1,1,0,1,1,1,1,1),
(24656,40,1,1,0,1,1,1,1,1),
(24656,41,1,1,0,1,1,1,1,1),
(24656,42,1,1,0,1,1,1,1,1),
(24656,43,1,1,0,1,1,1,1,1),
(24656,44,1,1,0,1,1,1,1,1),
(24656,45,1,1,0,1,1,1,1,1),
(24656,46,1,1,0,1,1,1,1,1),
(24656,47,1,1,0,1,1,1,1,1),
(24656,48,1,1,0,1,1,1,1,1),
(24656,49,1,1,0,1,1,1,1,1),
(24656,50,1,1,0,1,1,1,1,1),
(24656,51,1,1,0,1,1,1,1,1),
(24656,52,1,1,0,1,1,1,1,1),
(24656,53,1,1,0,1,1,1,1,1),
(24656,54,1,1,0,1,1,1,1,1),
(24656,55,1,1,0,1,1,1,1,1),
(24656,56,1,1,0,1,1,1,1,1),
(24656,57,1,1,0,1,1,1,1,1),
(24656,58,1,1,0,1,1,1,1,1),
(24656,59,1,1,0,1,1,1,1,1),
(24656,60,1,1,0,1,1,1,1,1),
(24656,61,1,1,0,1,1,1,1,1),
(24656,62,1,1,0,1,1,1,1,1),
(24656,63,1,1,0,1,1,1,1,1),
(24656,64,1,1,0,1,1,1,1,1),
(24656,65,1,1,0,1,1,1,1,1),
(24656,66,1,1,0,1,1,1,1,1),
(24656,67,1,1,0,1,1,1,1,1),
(24656,68,1,1,0,1,1,1,1,1),
(24656,69,1,1,0,1,1,1,1,1),
(24656,70,8782,2878,3696,152,39,102,334,360),
(24656,71,5654,4225,8300,155,112,325,135,124),
(24656,72,5750,4377,8380,157,115,329,136,126),
(24656,73,5945,4430,8440,159,118,332,137,129),
(24656,74,6191,4584,8550,162,121,335,138,131),
(24656,75,6349,4646,8612,164,123,338,139,134),
(24656,76,6676,4778,8910,166,126,343,140,136),
(24656,77,6884,4863,9150,169,129,347,141,138),
(24656,78,7097,4949,9450,172,132,351,142,141),
(24656,79,7208,5035,9800,174,135,355,143,143),
(24656,80,7320,5170,10087,177,137,361,144,146),
(25553,1,140,48,20,20,5,20,24,23),
(25553,2,149,59,20,21,5,2,25,24),
(25553,3,158,70,20,15,5,4,26,25),
(25553,4,168,81,33,17,5,8,27,26),
(25553,5,177,92,49,18,5,12,28,27),
(25553,6,186,103,68,20,7,16,29,27),
(25553,7,195,114,92,22,7,21,30,28),
(25553,8,204,125,117,23,8,25,31,29),
(25553,9,213,136,147,25,9,27,32,30),
(25553,10,223,147,180,29,10,29,33,31),
(25553,11,232,158,190,30,11,32,37,35),
(25553,12,250,180,203,31,12,36,41,39),
(25553,13,289,203,215,32,13,43,50,43),
(25553,14,299,227,228,33,13,44,54,47),
(25553,15,309,251,240,34,13,48,57,52),
(25553,16,329,275,253,36,13,52,62,56),
(25553,17,350,300,265,38,13,55,65,65),
(25553,18,362,314,278,39,13,59,70,70),
(25553,19,393,351,291,40,13,63,74,75),
(25553,20,403,377,303,42,13,67,87,78),
(25553,21,425,393,320,44,13,80,91,83),
(25553,22,449,420,346,46,13,84,95,86),
(25553,23,473,447,360,47,13,89,96,90),
(25553,24,520,476,373,49,13,93,97,95),
(25553,25,540,504,386,50,13,97,98,100),
(25553,26,569,534,399,52,13,101,60,78),
(25553,27,571,564,411,53,14,105,61,81),
(25553,28,574,592,424,55,15,110,62,86),
(25553,29,576,620,436,57,16,114,62,89),
(25553,30,579,648,449,57,16,118,63,92),
(25553,31,581,676,462,59,16,123,64,95),
(25553,32,590,720,476,60,17,127,64,98),
(25553,33,598,742,488,62,18,131,65,101),
(25553,34,601,793,501,63,19,135,65,104),
(25553,35,609,845,513,64,19,136,66,107),
(25553,36,617,879,525,67,19,137,66,110),
(25553,37,626,916,537,69,19,138,68,112),
(25553,38,634,952,549,70,19,139,68,115),
(25553,39,642,988,561,72,19,142,69,118),
(25553,40,650,1026,639,74,20,147,156,142),
(25553,41,668,1063,694,77,20,152,160,143),
(25553,42,676,1103,756,81,20,156,163,144),
(25553,43,685,1187,808,87,20,160,167,145),
(25553,44,693,1214,853,91,21,164,170,146),
(25553,45,701,1240,884,96,21,169,174,148),
(25553,46,709,1267,910,98,22,173,177,149),
(25553,47,718,1294,928,100,22,177,181,151),
(25553,48,726,1320,946,102,22,181,184,152),
(25553,49,734,1347,964,105,22,186,188,155),
(25553,50,747,1391,983,107,22,190,194,158),
(25553,51,750,1435,996,109,22,194,202,161),
(25553,52,764,1481,1013,112,24,198,208,165),
(25553,53,787,1527,1039,114,25,203,215,168),
(25553,54,820,1573,1055,115,26,207,222,172),
(25553,55,836,1620,1078,119,26,211,229,177),
(25553,56,846,1666,1091,121,27,215,236,181),
(25553,57,850,1714,1101,123,27,220,243,185),
(25553,58,862,1763,1125,125,27,224,250,189),
(25553,59,878,1824,1150,127,27,230,258,192),
(25553,60,920,1898,1163,122,27,128,264,197),
(25553,61,973,1925,1608,132,29,251,271,239),
(25553,62,1050,1977,1663,135,31,253,278,241),
(25553,63,1188,2030,1732,137,32,255,285,244),
(25553,64,1292,2084,1809,139,33,259,292,247),
(25553,65,1335,2137,1844,142,33,264,299,250),
(25553,66,1357,2191,1872,144,33,268,306,255),
(25553,67,1401,2244,1900,146,33,272,313,258),
(25553,68,1429,2298,1987,148,34,276,320,260),
(25553,69,1464,2351,2008,151,36,278,327,262),
(25553,70,1528,2568,2227,152,39,103,334,264),
(25553,71,5654,4225,8300,155,112,325,135,124),
(25553,72,5750,4377,8380,157,115,329,136,126),
(25553,73,5945,4430,8440,159,118,332,137,129),
(25553,74,6191,4584,8550,162,121,335,138,131),
(25553,75,6349,4646,8612,164,123,338,139,134),
(25553,76,6676,4778,8910,166,126,343,140,136),
(25553,77,6884,4863,9150,169,129,347,141,138),
(25553,78,7097,4949,9450,172,132,351,142,141),
(25553,79,7208,5035,9800,174,135,355,143,143),
(25553,80,7320,5170,10087,177,137,361,144,146),
(25566,1,14,40,0,20,20,20,24,23),
(25566,2,19,49,0,21,20,20,25,24),
(25566,3,24,58,0,22,20,21,26,25),
(25566,4,29,67,0,23,21,21,27,26),
(25566,5,34,76,0,23,21,22,28,27),
(25566,6,40,85,0,24,21,22,29,27),
(25566,7,46,95,0,25,21,23,30,28),
(25566,8,52,105,0,26,21,23,31,29),
(25566,9,58,116,0,27,21,23,32,30),
(25566,10,64,126,0,27,22,24,33,31),
(25566,11,75,151,0,28,22,24,37,35),
(25566,12,83,177,0,29,22,26,41,39),
(25566,13,91,198,0,30,22,26,44,43),
(25566,14,120,234,0,31,22,28,50,47),
(25566,15,129,262,0,32,23,29,54,52),
(25566,16,138,290,0,34,23,30,57,56),
(25566,17,147,318,0,36,23,31,61,60),
(25566,18,156,346,0,37,23,32,65,65),
(25566,19,165,374,0,38,23,33,70,69),
(25566,20,175,402,0,40,24,35,74,74),
(25566,21,184,430,0,42,24,37,87,78),
(25566,22,193,458,0,44,24,39,91,82),
(25566,23,202,486,0,45,24,40,95,86),
(25566,24,212,514,0,46,25,42,94,90),
(25566,25,224,539,0,47,25,43,94,95),
(25566,26,237,568,0,48,25,43,98,100),
(25566,27,249,598,0,50,25,42,102,104),
(25566,28,262,632,0,51,25,44,109,110),
(25566,29,274,667,0,52,26,44,114,114),
(25566,30,287,702,0,54,26,45,120,118),
(25566,31,299,734,0,55,26,46,124,123),
(25566,32,312,772,0,57,26,47,128,128),
(25566,33,324,807,0,58,27,48,132,131),
(25566,34,338,842,0,60,27,50,136,135),
(25566,35,360,898,0,62,27,51,139,136),
(25566,36,382,954,0,65,27,52,142,137),
(25566,37,404,1010,0,67,27,54,146,138),
(25566,38,427,1066,0,70,28,55,149,139),
(25566,39,449,1122,0,73,28,56,153,141),
(25566,40,471,1178,0,75,28,58,156,142),
(25566,41,493,1234,0,78,28,59,160,143),
(25566,42,516,1290,0,80,29,60,163,144),
(25566,43,538,1346,0,83,29,62,167,145),
(25566,44,560,1402,0,86,29,63,170,147),
(25566,45,582,1458,0,88,29,64,174,148),
(25566,46,605,1514,0,91,30,66,177,149),
(25566,47,627,1570,0,93,30,67,181,151),
(25566,48,649,1627,0,96,30,68,184,152),
(25566,49,672,1685,0,99,31,70,188,155),
(25566,50,694,1704,0,101,31,71,194,160),
(25566,51,716,1723,0,103,31,72,201,170),
(25566,52,738,1743,0,105,32,74,208,180),
(25566,53,761,1762,0,107,32,75,215,190),
(25566,54,783,1781,0,109,32,77,222,200),
(25566,55,805,1801,0,111,33,78,229,210),
(25566,56,827,1820,0,113,33,80,236,220),
(25566,57,850,1839,0,115,33,81,243,230),
(25566,58,872,1859,0,117,34,83,250,240),
(25566,59,894,1878,0,120,34,84,257,250),
(25566,60,917,1898,0,122,35,86,264,260),
(25566,61,939,1918,0,125,35,88,271,270),
(25566,62,961,1937,0,128,36,89,278,280),
(25566,63,983,1956,0,131,36,91,285,290),
(25566,64,1005,1975,0,134,36,93,292,300),
(25566,65,1027,1994,0,137,37,94,299,310),
(25566,66,1049,2013,0,140,37,96,306,320),
(25566,67,1072,2032,0,143,37,97,313,330),
(25566,68,1094,2052,0,146,38,99,320,340),
(25566,69,1126,2071,0,149,38,100,327,350),
(25566,70,1149,2090,0,152,39,102,334,360),
(25566,71,5654,4225,8300,155,112,325,135,124),
(25566,72,5750,4377,8380,157,115,329,136,126),
(25566,73,5945,4430,8440,159,118,332,137,129),
(25566,74,6191,4584,8550,162,121,335,138,131),
(25566,75,6349,4646,8612,164,123,338,139,134),
(25566,76,6676,4778,8910,166,126,343,140,136),
(25566,77,6884,4863,9150,169,129,347,141,138),
(25566,78,7097,4949,9450,172,132,351,142,141),
(25566,79,7208,5035,9800,174,135,355,143,143),
(25566,80,7320,5170,10087,177,137,361,144,146);
/*!40000 ALTER TABLE `pet_levelstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_name_generation`
--

DROP TABLE IF EXISTS `pet_name_generation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_name_generation` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `word` tinytext NOT NULL,
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `half` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=314 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_name_generation`
--

LOCK TABLES `pet_name_generation` WRITE;
/*!40000 ALTER TABLE `pet_name_generation` DISABLE KEYS */;
INSERT INTO `pet_name_generation` VALUES
(1,'Aba',416,0),
(2,'Az',416,0),
(3,'Bel',416,0),
(4,'Biz',416,0),
(5,'Cho',416,0),
(6,'Dag',416,0),
(7,'Gak',416,0),
(8,'Gar',416,0),
(9,'Gel',416,0),
(10,'Gho',416,0),
(11,'Gob',416,0),
(12,'Gra',416,0),
(13,'Jak',416,0),
(14,'Jub',416,0),
(15,'Kar',416,0),
(16,'Kup',416,0),
(17,'Laz',416,0),
(18,'Nal',416,0),
(19,'Nok',416,0),
(20,'Pag',416,0),
(21,'Pig',416,0),
(22,'Pip',416,0),
(23,'Piz',416,0),
(24,'Quz',416,0),
(25,'Rui',416,0),
(26,'Rul',416,0),
(27,'Rup',416,0),
(28,'Tar',416,0),
(29,'Vol',416,0),
(30,'Yaz',416,0),
(31,'Zep',416,0),
(32,'Zig',416,0),
(33,'Zil',416,0),
(34,'Zor',416,0),
(35,'bis',416,1),
(36,'fip',416,1),
(37,'gup',416,1),
(38,'ham',416,1),
(39,'jub',416,1),
(40,'kin',416,1),
(41,'kol',416,1),
(42,'lop',416,1),
(43,'loz',416,1),
(44,'mat',416,1),
(45,'mir',416,1),
(46,'nam',416,1),
(47,'nar',416,1),
(48,'nik',416,1),
(49,'nip',416,1),
(50,'pad',416,1),
(51,'pep',416,1),
(52,'pit',416,1),
(53,'qua',416,1),
(54,'rai',416,1),
(55,'rin',416,1),
(56,'rot',416,1),
(57,'tai',416,1),
(58,'tal',416,1),
(59,'tik',416,1),
(60,'tip',416,1),
(61,'tog',416,1),
(62,'tuk',416,1),
(63,'uri',416,1),
(64,'yal',416,1),
(65,'yap',416,1),
(66,'Bhee',417,0),
(67,'Bruu',417,0),
(68,'Czaa',417,0),
(69,'Droo',417,0),
(70,'Flaa',417,0),
(71,'Fzuu',417,0),
(72,'Ghaa',417,0),
(73,'Gree',417,0),
(74,'Gzaa',417,0),
(75,'Haa',417,0),
(76,'Haad',417,0),
(77,'Haag',417,0),
(78,'Haap',417,0),
(79,'Jhaa',417,0),
(80,'Jhuu',417,0),
(81,'Khaa',417,0),
(82,'Khii',417,0),
(83,'Khuu',417,0),
(84,'Kree',417,0),
(85,'Luu',417,0),
(86,'Maa',417,0),
(87,'Nhee',417,0),
(88,'Phuu',417,0),
(89,'Pryy',417,0),
(90,'Rhuu',417,0),
(91,'Shaa',417,0),
(92,'Sloo',417,0),
(93,'Sruu',417,0),
(94,'Thoo',417,0),
(95,'Traa',417,0),
(96,'Wraa',417,0),
(97,'Zhaa',417,0),
(98,'dhon',417,1),
(99,'dhum',417,1),
(100,'dhun',417,1),
(101,'dom',417,1),
(102,'don',417,1),
(103,'drom',417,1),
(104,'dym',417,1),
(105,'fenn',417,1),
(106,'fum',417,1),
(107,'fun',417,1),
(108,'ghon',417,1),
(109,'ghun',417,1),
(110,'grom',417,1),
(111,'grym',417,1),
(112,'hom',417,1),
(113,'hon',417,1),
(114,'hun',417,1),
(115,'jhom',417,1),
(116,'kun',417,1),
(117,'lum',417,1),
(118,'mmon',417,1),
(119,'mon',417,1),
(120,'myn',417,1),
(121,'nam',417,1),
(122,'nem',417,1),
(123,'nhym',417,1),
(124,'nom',417,1),
(125,'num',417,1),
(126,'phom',417,1),
(127,'roon',417,1),
(128,'rym',417,1),
(129,'shon',417,1),
(130,'thun',417,1),
(131,'tom',417,1),
(132,'zhem',417,1),
(133,'zhum',417,1),
(134,'zun',417,1),
(135,'Bar',1860,0),
(136,'Bel',1860,0),
(137,'Char',1860,0),
(138,'Grak''',1860,0),
(139,'Graz''',1860,0),
(140,'Grim',1860,0),
(141,'Hath',1860,0),
(142,'Hel',1860,0),
(143,'Hok',1860,0),
(144,'Huk',1860,0),
(145,'Jhaz',1860,0),
(146,'Jhom',1860,0),
(147,'Juk''',1860,0),
(148,'Kal''',1860,0),
(149,'Klath',1860,0),
(150,'Kon',1860,0),
(151,'Krag',1860,0),
(152,'Krak',1860,0),
(153,'Mak',1860,0),
(154,'Mezz',1860,0),
(155,'Orm',1860,0),
(156,'Phan',1860,0),
(157,'Sar',1860,0),
(158,'Tang',1860,0),
(159,'Than',1860,0),
(160,'Thog',1860,0),
(161,'Thok',1860,0),
(162,'Thul',1860,0),
(163,'Zag''',1860,0),
(164,'Zang',1860,0),
(165,'Zhar''',1860,0),
(166,'kath',1860,1),
(167,'doc',1860,1),
(168,'dok',1860,1),
(169,'gak',1860,1),
(170,'garth',1860,1),
(171,'gore',1860,1),
(172,'gorg',1860,1),
(173,'grave',1860,1),
(174,'gron',1860,1),
(175,'juk',1860,1),
(176,'krast',1860,1),
(177,'kresh',1860,1),
(178,'krit',1860,1),
(179,'los',1860,1),
(180,'mon',1860,1),
(181,'mos',1860,1),
(182,'moth',1860,1),
(183,'nagma',1860,1),
(184,'nak',1860,1),
(185,'nar',1860,1),
(186,'nos',1860,1),
(187,'nuz',1860,1),
(188,'phog',1860,1),
(189,'rath',1860,1),
(190,'tast',1860,1),
(191,'taz',1860,1),
(192,'thak',1860,1),
(193,'thang',1860,1),
(194,'thyk',1860,1),
(195,'vhug',1860,1),
(196,'zazt',1860,1),
(197,'Ael',1863,0),
(198,'Aez',1863,0),
(199,'Ang',1863,0),
(200,'Ban',1863,0),
(201,'Bet',1863,0),
(202,'Bro',1863,0),
(203,'Bry',1863,0),
(204,'Cat',1863,0),
(205,'Dir',1863,0),
(206,'Dis',1863,0),
(207,'Dom',1863,0),
(208,'Drus',1863,0),
(209,'Fie',1863,0),
(210,'Fier',1863,0),
(211,'Gly',1863,0),
(212,'Hel',1863,0),
(213,'Hes',1863,0),
(214,'Kal',1863,0),
(215,'Lyn',1863,0),
(216,'Mir',1863,0),
(217,'Nim',1863,0),
(218,'Sar',1863,0),
(219,'Sel',1863,0),
(220,'Vil',1863,0),
(221,'Zah',1863,0),
(222,'aith',1863,1),
(223,'anda',1863,1),
(224,'antia',1863,1),
(225,'evere',1863,1),
(226,'lia',1863,1),
(227,'lissa',1863,1),
(228,'neri',1863,1),
(229,'neth',1863,1),
(230,'nia',1863,1),
(231,'nlissa',1863,1),
(232,'nora',1863,1),
(233,'nva',1863,1),
(234,'nys',1863,1),
(235,'ola',1863,1),
(236,'ona',1863,1),
(237,'ora',1863,1),
(238,'rah',1863,1),
(239,'riana',1863,1),
(240,'riel',1863,1),
(241,'rona',1863,1),
(242,'tai',1863,1),
(243,'tevere',1863,1),
(244,'thea',1863,1),
(245,'vina',1863,1),
(246,'wena',1863,1),
(247,'wyn',1863,1),
(248,'xia',1863,1),
(249,'yla',1863,1),
(250,'yssa',1863,1),
(251,'Flaa',17252,0),
(252,'Haa',17252,0),
(253,'Jhuu',17252,0),
(254,'Shaa',17252,0),
(255,'Thoo',17252,0),
(256,'dhun',17252,1),
(257,'ghun',17252,1),
(258,'roon',17252,1),
(259,'thun',17252,1),
(260,'tom',17252,1),
(261,'Stone',26125,0),
(262,'Stone',26125,0),
(263,'Eye',26125,0),
(264,'Dirt',26125,0),
(265,'Blight',26125,0),
(266,'Bat',26125,0),
(267,'Rat',26125,0),
(268,'Corpse',26125,0),
(269,'Grave',26125,0),
(270,'Carrion',26125,0),
(271,'Skull',26125,0),
(272,'Bone',26125,0),
(273,'Crypt',26125,0),
(274,'Rib',26125,0),
(275,'Brain',26125,0),
(276,'Tomb',26125,0),
(277,'Rot',26125,0),
(278,'Gravel',26125,0),
(279,'Plague',26125,0),
(280,'Casket',26125,0),
(281,'Limb',26125,0),
(282,'Worm',26125,0),
(283,'Earth',26125,0),
(284,'Spine',26125,0),
(285,'Pebble',26125,0),
(286,'Root',26125,0),
(287,'Marrow',26125,0),
(288,'Hammer',26125,0),
(289,'ravager',26125,1),
(290,'muncher',26125,1),
(291,'cruncher',26125,1),
(292,'masher',26125,1),
(293,'leaper',26125,1),
(294,'grinder',26125,1),
(295,'stalker',26125,1),
(296,'gobbler',26125,1),
(297,'feeder',26125,1),
(298,'basher',26125,1),
(299,'chewer',26125,1),
(300,'ripper',26125,1),
(301,'slicer',26125,1),
(302,'gnaw',26125,1),
(303,'flayer',26125,1),
(304,'rumbler',26125,1),
(305,'chomp',26125,1),
(306,'breaker',26125,1),
(307,'keeper',26125,1),
(308,'rawler',26125,1),
(309,'stealer',26125,1),
(310,'thief',26125,1),
(311,'catcher',26125,1),
(312,'drinker',26125,1),
(313,'slicer',26125,1);
/*!40000 ALTER TABLE `pet_name_generation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pickpocketing_loot_template`
--

DROP TABLE IF EXISTS `pickpocketing_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickpocketing_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pickpocketing_loot_template`
--

LOCK TABLES `pickpocketing_loot_template` WRITE;
/*!40000 ALTER TABLE `pickpocketing_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `pickpocketing_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_classlevelstats`
--

DROP TABLE IF EXISTS `player_classlevelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_classlevelstats` (
  `class` tinyint(3) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `basehp` smallint(5) unsigned NOT NULL,
  `basemana` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`class`,`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_classlevelstats`
--

LOCK TABLES `player_classlevelstats` WRITE;
/*!40000 ALTER TABLE `player_classlevelstats` DISABLE KEYS */;
INSERT INTO `player_classlevelstats` VALUES
(1,1,20,0),
(1,2,29,0),
(1,3,38,0),
(1,4,47,0),
(1,5,56,0),
(1,6,65,0),
(1,7,74,0),
(1,8,83,0),
(1,9,92,0),
(1,10,101,0),
(1,11,100,0),
(1,12,109,0),
(1,13,118,0),
(1,14,128,0),
(1,15,139,0),
(1,16,151,0),
(1,17,154,0),
(1,18,168,0),
(1,19,183,0),
(1,20,199,0),
(1,21,206,0),
(1,22,224,0),
(1,23,243,0),
(1,24,253,0),
(1,25,274,0),
(1,26,296,0),
(1,27,309,0),
(1,28,333,0),
(1,29,348,0),
(1,30,374,0),
(1,31,401,0),
(1,32,419,0),
(1,33,448,0),
(1,34,468,0),
(1,35,499,0),
(1,36,521,0),
(1,37,545,0),
(1,38,581,0),
(1,39,609,0),
(1,40,649,0),
(1,41,681,0),
(1,42,715,0),
(1,43,761,0),
(1,44,799,0),
(1,45,839,0),
(1,46,881,0),
(1,47,935,0),
(1,48,981,0),
(1,49,1029,0),
(1,50,1079,0),
(1,51,1131,0),
(1,52,1185,0),
(1,53,1241,0),
(1,54,1299,0),
(1,55,1359,0),
(1,56,1421,0),
(1,57,1485,0),
(1,58,1551,0),
(1,59,1619,0),
(1,60,1689,0),
(1,61,1902,0),
(1,62,2129,0),
(1,63,2357,0),
(1,64,2612,0),
(1,65,2883,0),
(1,66,3169,0),
(1,67,3455,0),
(1,68,3774,0),
(1,69,4109,0),
(1,70,4444,0),
(2,1,28,60),
(2,2,36,78),
(2,3,44,98),
(2,4,52,104),
(2,5,60,111),
(2,6,68,134),
(2,7,76,143),
(2,8,84,153),
(2,9,92,179),
(2,10,100,192),
(2,11,108,205),
(2,12,116,219),
(2,13,124,249),
(2,14,132,265),
(2,15,131,282),
(2,16,141,315),
(2,17,152,334),
(2,18,164,354),
(2,19,177,390),
(2,20,191,412),
(2,21,206,435),
(2,22,222,459),
(2,23,239,499),
(2,24,247,525),
(2,25,266,552),
(2,26,286,579),
(2,27,307,621),
(2,28,329,648),
(2,29,342,675),
(2,30,366,702),
(2,31,391,729),
(2,32,407,756),
(2,33,434,798),
(2,34,462,825),
(2,35,481,852),
(2,36,511,879),
(2,37,542,906),
(2,38,564,933),
(2,39,597,960),
(2,40,621,987),
(2,41,656,1014),
(2,42,682,1041),
(2,43,719,1068),
(2,44,747,1110),
(2,45,786,1137),
(2,46,816,1164),
(2,47,857,1176),
(2,48,889,1203),
(2,49,922,1230),
(2,50,966,1257),
(2,51,1001,1284),
(2,52,1037,1311),
(2,53,1084,1338),
(2,54,1122,1365),
(2,55,1161,1392),
(2,56,1201,1419),
(2,57,1252,1446),
(2,58,1294,1458),
(2,59,1337,1485),
(2,60,1381,1512),
(2,61,1540,1656),
(2,62,1708,1800),
(2,63,1884,1944),
(2,64,2068,2088),
(2,65,2262,2232),
(2,66,2466,2377),
(2,67,2679,2521),
(2,68,2901,2665),
(2,69,3134,2809),
(2,70,3377,2953),
(3,1,46,65),
(3,2,53,70),
(3,3,60,76),
(3,4,67,98),
(3,5,74,106),
(3,6,81,130),
(3,7,88,140),
(3,8,95,166),
(3,9,102,193),
(3,10,109,206),
(3,11,116,235),
(3,12,123,250),
(3,13,130,266),
(3,14,138,298),
(3,15,147,316),
(3,16,157,350),
(3,17,168,370),
(3,18,180,391),
(3,19,193,428),
(3,20,207,451),
(3,21,222,475),
(3,22,238,515),
(3,23,255,541),
(3,24,273,568),
(3,25,292,611),
(3,26,312,640),
(3,27,333,670),
(3,28,355,715),
(3,29,378,745),
(3,30,402,775),
(3,31,417,805),
(3,32,443,850),
(3,33,470,880),
(3,34,498,910),
(3,35,527,940),
(3,36,547,970),
(3,37,578,1015),
(3,38,610,1045),
(3,39,643,1075),
(3,40,667,1105),
(3,41,702,1135),
(3,42,738,1180),
(3,43,775,1210),
(3,44,803,1240),
(3,45,842,1270),
(3,46,872,1300),
(3,47,913,1330),
(3,48,955,1360),
(3,49,994,1390),
(3,50,1047,1420),
(3,51,1067,1450),
(3,52,1113,1480),
(3,53,1150,1510),
(3,54,1198,1540),
(3,55,1237,1570),
(3,56,1287,1600),
(3,57,1328,1630),
(3,58,1370,1660),
(3,59,1423,1690),
(3,60,1467,1720),
(3,61,1633,1886),
(3,62,1819,2053),
(3,63,2003,2219),
(3,64,2195,2385),
(3,65,2397,2552),
(3,66,2623,2718),
(3,67,2844,2884),
(3,68,3075,3050),
(3,69,3316,3217),
(3,70,3568,3383),
(4,1,25,0),
(4,2,32,0),
(4,3,49,0),
(4,4,56,0),
(4,5,63,0),
(4,6,70,0),
(4,7,87,0),
(4,8,94,0),
(4,9,101,0),
(4,10,118,0),
(4,11,125,0),
(4,12,142,0),
(4,13,149,0),
(4,14,156,0),
(4,15,173,0),
(4,16,181,0),
(4,17,190,0),
(4,18,200,0),
(4,19,221,0),
(4,20,233,0),
(4,21,246,0),
(4,22,260,0),
(4,23,275,0),
(4,24,301,0),
(4,25,318,0),
(4,26,336,0),
(4,27,355,0),
(4,28,375,0),
(4,29,396,0),
(4,30,428,0),
(4,31,451,0),
(4,32,475,0),
(4,33,500,0),
(4,34,526,0),
(4,35,553,0),
(4,36,581,0),
(4,37,610,0),
(4,38,640,0),
(4,39,671,0),
(4,40,703,0),
(4,41,736,0),
(4,42,770,0),
(4,43,805,0),
(4,44,841,0),
(4,45,878,0),
(4,46,916,0),
(4,47,955,0),
(4,48,995,0),
(4,49,1026,0),
(4,50,1068,0),
(4,51,1111,0),
(4,52,1155,0),
(4,53,1200,0),
(4,54,1246,0),
(4,55,1283,0),
(4,56,1331,0),
(4,57,1380,0),
(4,58,1430,0),
(4,59,1471,0),
(4,60,1523,0),
(4,61,1702,0),
(4,62,1879,0),
(4,63,2077,0),
(4,64,2285,0),
(4,65,2489,0),
(4,66,2717,0),
(4,67,2941,0),
(4,68,3190,0),
(4,69,3450,0),
(4,70,3704,0),
(5,1,52,73),
(5,2,57,76),
(5,3,72,95),
(5,4,77,114),
(5,5,92,133),
(5,6,97,152),
(5,7,112,171),
(5,8,117,190),
(5,9,132,209),
(5,10,137,212),
(5,11,142,215),
(5,12,157,234),
(5,13,172,254),
(5,14,177,260),
(5,15,192,282),
(5,16,197,305),
(5,17,212,329),
(5,18,227,339),
(5,19,232,365),
(5,20,247,377),
(5,21,252,405),
(5,22,268,434),
(5,23,275,449),
(5,24,293,480),
(5,25,302,497),
(5,26,322,530),
(5,27,343,549),
(5,28,355,584),
(5,29,378,605),
(5,30,392,627),
(5,31,417,665),
(5,32,433,689),
(5,33,460,728),
(5,34,478,752),
(5,35,507,776),
(5,36,527,800),
(5,37,548,839),
(5,38,580,863),
(5,39,603,887),
(5,40,637,911),
(5,41,662,950),
(5,42,698,974),
(5,43,725,998),
(5,44,763,1022),
(5,45,792,1046),
(5,46,822,1070),
(5,47,863,1094),
(5,48,895,1118),
(5,49,928,1142),
(5,50,972,1166),
(5,51,1007,1190),
(5,52,1053,1214),
(5,53,1090,1238),
(5,54,1128,1262),
(5,55,1177,1271),
(5,56,1217,1295),
(5,57,1258,1319),
(5,58,1300,1343),
(5,59,1353,1352),
(5,60,1397,1376),
(5,61,1557,1500),
(5,62,1738,1625),
(5,63,1916,1749),
(5,64,2101,1873),
(5,65,2295,1998),
(5,66,2495,2122),
(5,67,2719,2247),
(5,68,2936,2371),
(5,69,3160,2495),
(5,70,3391,2620),
(7,80,6939,4396),
(7,79,6457,4252),
(7,78,6009,4108),
(7,77,5592,3965),
(7,76,5203,3821),
(7,75,4843,3677),
(7,74,4507,3533),
(7,73,4194,3389),
(7,72,3903,3246),
(7,71,3633,3102),
(7,70,3380,2958),
(7,69,3136,2814),
(7,68,2903,2670),
(7,67,2679,2527),
(7,66,2465,2383),
(7,65,2262,2239),
(7,64,2067,2095),
(7,63,1883,1951),
(7,62,1694,1808),
(7,61,1528,1664),
(7,60,1423,1520),
(7,59,1326,1501),
(7,58,1283,1467),
(7,57,1231,1448),
(7,56,1190,1414),
(7,55,1150,1395),
(7,54,1101,1376),
(7,53,1064,1342),
(7,52,1027,1323),
(7,51,981,1289),
(7,50,947,1255),
(7,49,903,1236),
(7,48,871,1202),
(7,47,829,1183),
(7,46,799,1149),
(7,45,760,1115),
(7,44,732,1096),
(7,43,694,1062),
(7,42,669,1028),
(7,41,633,1009),
(7,40,610,975),
(7,39,577,941),
(7,38,545,922),
(7,37,524,888),
(7,36,494,854),
(7,35,465,820),
(7,34,448,786),
(7,33,422,767),
(7,32,396,733),
(7,31,371,699),
(7,30,358,665),
(7,29,336,631),
(7,28,315,598),
(7,27,294,566),
(7,26,275,535),
(7,25,257,505),
(7,24,250,476),
(7,23,234,448),
(7,22,219,421),
(7,21,205,395),
(7,20,193,370),
(7,19,181,346),
(7,18,170,323),
(7,17,161,301),
(7,16,152,280),
(7,15,144,260),
(7,14,137,241),
(7,13,129,223),
(7,12,122,206),
(7,11,114,190),
(8,1,32,100),
(8,2,47,110),
(8,3,52,106),
(8,4,67,118),
(8,5,82,131),
(8,6,97,130),
(8,7,102,145),
(8,8,117,146),
(8,9,132,163),
(8,10,137,196),
(8,11,152,215),
(8,12,167,220),
(8,13,172,241),
(8,14,187,263),
(8,15,202,271),
(8,16,207,295),
(8,17,222,305),
(8,18,237,331),
(8,19,242,343),
(8,20,257,371),
(8,21,272,385),
(8,22,277,415),
(8,23,292,431),
(8,24,298,463),
(8,25,315,481),
(8,26,333,515),
(8,27,342,535),
(8,28,362,556),
(8,29,373,592),
(8,30,395,613),
(8,31,418,634),
(8,32,432,670),
(8,33,457,691),
(8,34,473,712),
(8,35,500,733),
(8,36,518,754),
(8,37,547,790),
(8,38,577,811),
(8,39,598,832),
(8,40,630,853),
(8,41,653,874),
(8,42,687,895),
(8,43,712,916),
(8,44,748,937),
(8,45,775,958),
(8,46,813,979),
(8,47,842,1000),
(8,48,882,1021),
(8,49,913,1042),
(8,50,955,1048),
(8,51,988,1069),
(8,52,1032,1090),
(8,53,1067,1111),
(8,54,1103,1117),
(8,55,1150,1138),
(8,56,1188,1159),
(8,57,1237,1165),
(8,58,1277,1186),
(8,59,1328,1192),
(8,60,1370,1213),
(8,61,1526,1316),
(8,62,1702,1419),
(8,63,1875,1521),
(8,64,2070,1624),
(8,65,2261,1727),
(8,66,2461,1830),
(8,67,2686,1932),
(8,68,2906,2035),
(8,69,3136,2138),
(8,70,3393,2241),
(9,1,23,90),
(9,2,28,98),
(9,3,43,107),
(9,4,48,102),
(9,5,63,113),
(9,6,68,126),
(9,7,83,144),
(9,8,88,162),
(9,9,93,180),
(9,10,108,198),
(9,11,123,200),
(9,12,128,218),
(9,13,143,237),
(9,14,148,257),
(9,15,153,278),
(9,16,168,300),
(9,17,173,308),
(9,18,189,332),
(9,19,196,357),
(9,20,204,383),
(9,21,223,395),
(9,22,233,423),
(9,23,244,452),
(9,24,266,467),
(9,25,279,498),
(9,26,293,530),
(9,27,318,548),
(9,28,334,582),
(9,29,351,602),
(9,30,379,638),
(9,31,398,674),
(9,32,418,695),
(9,33,439,731),
(9,34,471,752),
(9,35,494,788),
(9,36,518,809),
(9,37,543,830),
(9,38,569,866),
(9,39,606,887),
(9,40,634,923),
(9,41,663,944),
(9,42,693,965),
(9,43,724,1001),
(9,44,756,1022),
(9,45,799,1043),
(9,46,832,1064),
(9,47,868,1100),
(9,48,904,1121),
(9,49,941,1142),
(9,50,979,1163),
(9,51,1018,1184),
(9,52,1058,1205),
(9,53,1099,1226),
(9,54,1141,1247),
(9,55,1184,1268),
(9,56,1228,1289),
(9,57,1273,1310),
(9,58,1319,1331),
(9,59,1366,1352),
(9,60,1414,1373),
(9,61,1580,1497),
(9,62,1755,1621),
(9,63,1939,1745),
(9,64,2133,1870),
(9,65,2323,1994),
(9,66,2535,2118),
(9,67,2758,2242),
(9,68,2991,2366),
(9,69,3235,2490),
(9,70,3490,2615),
(11,1,44,60),
(11,2,51,66),
(11,3,58,73),
(11,4,75,81),
(11,5,82,90),
(11,6,89,100),
(11,7,106,111),
(11,8,113,123),
(11,9,120,136),
(11,10,137,150),
(11,11,144,165),
(11,12,151,182),
(11,13,168,200),
(11,14,175,219),
(11,15,182,239),
(11,16,199,260),
(11,17,206,282),
(11,18,214,305),
(11,19,233,329),
(11,20,243,354),
(11,21,254,380),
(11,22,266,392),
(11,23,289,420),
(11,24,303,449),
(11,25,318,479),
(11,26,334,509),
(11,27,361,524),
(11,28,379,554),
(11,29,398,584),
(11,30,418,614),
(11,31,439,629),
(11,32,461,659),
(11,33,494,689),
(11,34,518,704),
(11,35,543,734),
(11,36,569,749),
(11,37,596,779),
(11,38,624,809),
(11,39,653,824),
(11,40,683,854),
(11,41,714,869),
(11,42,746,899),
(11,43,779,914),
(11,44,823,944),
(11,45,858,959),
(11,46,894,989),
(11,47,921,1004),
(11,48,959,1019),
(11,49,998,1049),
(11,50,1038,1064),
(11,51,1079,1079),
(11,52,1121,1109),
(11,53,1164,1124),
(11,54,1208,1139),
(11,55,1253,1154),
(11,56,1299,1169),
(11,57,1346,1199),
(11,58,1384,1214),
(11,59,1433,1229),
(11,60,1483,1244),
(11,61,1657,1357),
(11,62,1840,1469),
(11,63,2020,1582),
(11,64,2222,1694),
(11,65,2433,1807),
(11,66,2640,1919),
(11,67,2872,2032),
(11,68,3114,2145),
(11,69,3351,2257),
(11,70,3614,2370),
(1,71,4720,0),
(1,72,5013,0),
(1,73,5325,0),
(1,74,5656,0),
(1,75,6008,0),
(1,76,6381,0),
(1,77,6778,0),
(1,78,7198,0),
(1,79,7646,0),
(1,80,8121,0),
(2,71,3629,3097),
(2,72,3900,3241),
(2,73,4191,3385),
(2,74,4503,3529),
(2,75,4839,3673),
(2,76,5200,3817),
(2,77,5588,3962),
(2,78,6005,4106),
(2,79,6453,4250),
(2,80,6934,4394),
(3,71,3834,3549),
(3,72,4120,3716),
(3,73,4427,3882),
(3,74,4757,4048),
(3,75,5112,4215),
(3,76,5493,4381),
(3,77,5903,4547),
(3,78,6343,4713),
(3,79,6816,4880),
(3,80,7324,5046),
(4,71,3980,0),
(4,72,4277,0),
(4,73,4596,0),
(4,74,4939,0),
(4,75,5307,0),
(4,76,5703,0),
(4,77,6128,0),
(4,78,6585,0),
(4,79,7076,0),
(4,80,7604,0),
(5,71,3644,2744),
(5,72,3916,2868),
(5,73,4208,2993),
(5,74,4522,3117),
(5,75,4859,3242),
(5,76,5221,3366),
(5,77,5610,3490),
(5,78,6028,3615),
(5,79,6477,3739),
(5,80,6960,3863),
(6,1,22,0),
(6,2,27,0),
(6,3,32,0),
(6,4,37,0),
(6,5,42,0),
(6,6,47,0),
(6,7,52,0),
(6,8,58,0),
(6,9,64,0),
(6,10,70,0),
(6,11,77,0),
(6,12,84,0),
(6,13,92,0),
(6,14,100,0),
(6,15,117,0),
(6,16,127,0),
(6,17,138,0),
(6,18,150,0),
(6,19,163,0),
(6,20,177,0),
(6,21,192,0),
(6,22,208,0),
(6,23,225,0),
(6,24,239,0),
(6,25,258,0),
(6,26,278,0),
(6,27,299,0),
(6,28,321,0),
(6,29,344,0),
(6,30,368,0),
(6,31,393,0),
(6,32,419,0),
(6,33,446,0),
(6,34,474,0),
(6,35,503,0),
(6,36,533,0),
(6,37,564,0),
(6,38,596,0),
(6,39,629,0),
(6,40,698,0),
(6,41,698,0),
(6,42,734,0),
(6,43,771,0),
(6,44,809,0),
(6,45,849,0),
(6,46,891,0),
(6,47,935,0),
(6,48,981,0),
(6,49,1029,0),
(6,50,1079,0),
(6,51,1131,0),
(6,52,1185,0),
(6,53,1241,0),
(6,54,1299,0),
(6,55,1359,0),
(6,56,1421,0),
(6,57,1485,0),
(6,58,1551,0),
(6,59,1619,0),
(6,60,1689,0),
(6,61,1902,0),
(6,62,2129,0),
(6,63,2357,0),
(6,64,2612,0),
(6,65,2883,0),
(6,66,3169,0),
(6,67,3455,0),
(6,68,3774,0),
(6,69,4109,0),
(6,70,4444,0),
(6,71,4720,0),
(6,72,5013,0),
(6,73,5325,0),
(6,74,5656,0),
(6,75,6008,0),
(6,76,6381,0),
(6,77,6778,0),
(6,78,7199,0),
(6,79,7646,0),
(6,80,8121,0),
(7,10,107,175),
(7,9,100,161),
(7,8,92,148),
(7,7,85,136),
(7,6,77,125),
(7,5,70,115),
(7,4,62,106),
(7,3,55,98),
(7,2,47,91),
(7,1,40,85),
(8,71,3646,2343),
(8,72,3918,2446),
(8,73,4210,2549),
(8,74,4524,2652),
(8,75,4861,2754),
(8,76,5223,2857),
(8,77,5612,2960),
(8,78,6030,3063),
(8,79,6480,3165),
(8,80,6963,3268),
(9,71,3750,2739),
(9,72,4025,2863),
(9,73,4330,2987),
(9,74,4646,3111),
(9,75,4997,3235),
(9,76,5373,3360),
(9,77,5774,3483),
(9,78,6207,3608),
(9,79,6667,3732),
(9,80,7136,3856),
(11,71,3883,2482),
(11,72,4172,2595),
(11,73,4483,2708),
(11,74,4817,2820),
(11,75,5176,2933),
(11,76,5562,3045),
(11,77,5977,3158),
(11,78,6423,3270),
(11,79,6902,3383),
(11,80,7417,3496);
/*!40000 ALTER TABLE `player_classlevelstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_factionchange_achievement`
--

DROP TABLE IF EXISTS `player_factionchange_achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_factionchange_achievement` (
 `alliance_id` int(8) NOT NULL,
 `horde_id` int(8) NOT NULL,
 PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_factionchange_achievement`
--

LOCK TABLES `player_factionchange_achievement` WRITE;
/*!40000 ALTER TABLE `player_factionchange_achievement` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_factionchange_achievement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_factionchange_items`
--

DROP TABLE IF EXISTS `player_factionchange_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_factionchange_items` (
 `race_A` int(8) NOT NULL,
 `alliance_id` int(8) NOT NULL,
 `commentA` text,
 `race_H` int(8) NOT NULL,
 `horde_id` int(8) NOT NULL,
 `commentH` text,
PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_factionchange_items`
--

LOCK TABLES `player_factionchange_items` WRITE;
/*!40000 ALTER TABLE `player_factionchange_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_factionchange_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_factionchange_reputations`
--

DROP TABLE IF EXISTS `player_factionchange_reputations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_factionchange_reputations` (
 `alliance_id` int(8) NOT NULL,
 `horde_id` int(8) NOT NULL,
 PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_factionchange_reputations`
--

LOCK TABLES `player_factionchange_reputations` WRITE;
/*!40000 ALTER TABLE `player_factionchange_reputations` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_factionchange_reputations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_factionchange_spells`
--

DROP TABLE IF EXISTS `player_factionchange_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_factionchange_spells` (
 `alliance_id` int(8) NOT NULL,
 `horde_id` int(8) NOT NULL,
 PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_factionchange_spells`
--

LOCK TABLES `player_factionchange_spells` WRITE;
/*!40000 ALTER TABLE `player_factionchange_spells` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_factionchange_spells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_levelstats`
--

DROP TABLE IF EXISTS `player_levelstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_levelstats` (
  `race` tinyint(3) unsigned NOT NULL,
  `class` tinyint(3) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `str` tinyint(3) unsigned NOT NULL,
  `agi` tinyint(3) unsigned NOT NULL,
  `sta` tinyint(3) unsigned NOT NULL,
  `inte` tinyint(3) unsigned NOT NULL,
  `spi` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`race`,`class`,`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores levels stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_levelstats`
--

LOCK TABLES `player_levelstats` WRITE;
/*!40000 ALTER TABLE `player_levelstats` DISABLE KEYS */;
INSERT INTO `player_levelstats` VALUES
(1,1,1,23,20,22,20,20),
(1,1,2,24,21,23,20,20),
(1,1,3,26,22,24,20,21),
(1,1,4,27,22,26,20,21),
(1,1,5,28,23,27,20,21),
(1,1,6,30,24,28,20,21),
(1,1,7,31,25,29,21,22),
(1,1,8,32,26,30,21,22),
(1,1,9,34,26,32,21,22),
(1,1,10,35,27,33,21,23),
(1,1,11,36,28,34,21,23),
(1,1,12,38,29,35,21,23),
(1,1,13,39,30,37,21,24),
(1,1,14,41,31,38,21,24),
(1,1,15,42,32,39,21,24),
(1,1,16,44,33,41,21,25),
(1,1,17,45,34,42,22,25),
(1,1,18,47,34,43,22,25),
(1,1,19,48,35,45,22,26),
(1,1,20,50,36,46,22,26),
(1,1,21,51,37,48,22,26),
(1,1,22,53,38,49,22,27),
(1,1,23,54,39,51,22,27),
(1,1,24,56,40,52,23,28),
(1,1,25,58,41,53,23,28),
(1,1,26,59,42,55,23,28),
(1,1,27,61,43,56,23,29),
(1,1,28,63,44,58,23,29),
(1,1,29,64,45,59,23,30),
(1,1,30,66,46,61,24,30),
(1,1,31,68,47,62,24,30),
(1,1,32,69,48,64,24,31),
(1,1,33,71,50,66,24,31),
(1,1,34,73,51,67,24,32),
(1,1,35,74,52,69,24,32),
(1,1,36,76,53,70,25,33),
(1,1,37,78,54,72,25,33),
(1,1,38,80,55,74,25,34),
(1,1,39,82,56,75,25,34),
(1,1,40,83,57,77,25,35),
(1,1,41,85,58,79,26,35),
(1,1,42,87,60,80,26,35),
(1,1,43,89,61,82,26,36),
(1,1,44,91,62,84,26,36),
(1,1,45,93,63,85,26,37),
(1,1,46,95,64,87,27,37),
(1,1,47,97,66,89,27,38),
(1,1,48,99,67,91,27,38),
(1,1,49,101,68,93,27,39),
(1,1,50,103,69,94,28,40),
(1,1,51,105,71,96,28,40),
(1,1,52,107,72,98,28,41),
(1,1,53,109,73,100,28,41),
(1,1,54,111,74,102,29,42),
(1,1,55,113,76,103,29,42),
(1,1,56,115,77,105,29,43),
(1,1,57,117,78,107,29,43),
(1,1,58,119,79,109,30,44),
(1,1,59,121,81,111,30,44),
(1,1,60,123,82,113,30,45),
(1,1,61,125,83,115,30,46),
(1,1,62,127,85,117,31,46),
(1,1,63,129,86,119,31,47),
(1,1,64,132,88,121,31,47),
(1,1,65,134,89,123,32,48),
(1,1,66,136,90,125,32,49),
(1,1,67,138,92,127,32,49),
(1,1,68,140,93,129,32,50),
(1,1,69,143,95,131,33,50),
(1,1,70,145,96,133,33,51),
(1,1,71,148,97,140,33,53),
(1,1,72,156,99,143,33,54),
(1,1,73,162,101,148,33,55),
(1,1,74,162,102,148,34,55),
(1,1,75,165,104,150,34,56),
(1,1,76,171,106,156,34,57),
(1,1,77,171,108,157,35,58),
(1,1,78,174,109,159,35,58),
(1,1,79,181,111,165,35,59),
(1,1,80,184,113,168,36,60),
(1,2,1,22,20,22,20,21),
(1,2,2,23,21,23,21,22),
(1,2,3,24,21,24,21,22),
(1,2,4,25,22,25,22,23),
(1,2,5,26,22,26,23,24),
(1,2,6,28,23,27,23,25),
(1,2,7,29,24,28,24,25),
(1,2,8,30,24,29,25,26),
(1,2,9,31,25,30,25,27),
(1,2,10,32,25,32,26,27),
(1,2,11,33,26,33,27,28),
(1,2,12,35,27,34,27,29),
(1,2,13,36,27,35,28,30),
(1,2,14,37,28,36,29,31),
(1,2,15,38,29,37,30,31),
(1,2,16,40,29,38,30,32),
(1,2,17,41,30,40,31,33),
(1,2,18,42,31,41,32,34),
(1,2,19,43,31,42,33,35),
(1,2,20,45,32,43,33,35),
(1,2,21,46,33,45,34,36),
(1,2,22,47,33,46,35,37),
(1,2,23,49,34,47,36,38),
(1,2,24,50,35,48,37,39),
(1,2,25,51,36,50,37,40),
(1,2,26,53,36,51,38,41),
(1,2,27,54,37,52,39,42),
(1,2,28,56,38,54,40,43),
(1,2,29,57,39,55,41,43),
(1,2,30,58,39,56,42,44),
(1,2,31,60,40,58,43,45),
(1,2,32,61,41,59,43,46),
(1,2,33,63,42,60,44,47),
(1,2,34,64,43,62,45,48),
(1,2,35,66,44,63,46,49),
(1,2,36,67,44,65,47,50),
(1,2,37,69,45,66,48,51),
(1,2,38,70,46,67,49,52),
(1,2,39,72,47,69,50,53),
(1,2,40,73,48,70,51,54),
(1,2,41,75,49,72,52,55),
(1,2,42,77,49,73,53,56),
(1,2,43,78,50,75,54,57),
(1,2,44,80,51,76,55,58),
(1,2,45,81,52,78,56,59),
(1,2,46,83,53,79,57,61),
(1,2,47,85,54,81,58,62),
(1,2,48,86,55,83,59,63),
(1,2,49,88,56,84,60,64),
(1,2,50,90,57,86,61,65),
(1,2,51,91,58,87,62,66),
(1,2,52,93,59,89,63,67),
(1,2,53,95,60,91,64,68),
(1,2,54,97,61,92,65,69),
(1,2,55,98,61,94,66,71),
(1,2,56,100,62,95,67,72),
(1,2,57,102,63,97,68,73),
(1,2,58,104,64,99,69,74),
(1,2,59,105,65,101,70,75),
(1,2,60,107,66,102,71,77),
(1,2,61,109,67,104,73,78),
(1,2,62,111,69,106,74,79),
(1,2,63,113,70,107,75,80),
(1,2,64,115,71,109,76,81),
(1,2,65,116,72,111,77,83),
(1,2,66,118,73,113,78,84),
(1,2,67,120,74,115,79,85),
(1,2,68,122,75,116,81,86),
(1,2,69,124,76,118,82,88),
(1,2,70,126,77,120,83,89),
(1,2,71,148,78,122,84,92),
(1,2,72,150,79,125,86,94),
(1,2,73,152,80,127,87,96),
(1,2,74,156,82,129,89,97),
(1,2,75,158,83,131,90,99),
(1,2,76,162,84,134,92,100),
(1,2,77,164,86,136,93,103),
(1,2,78,167,87,138,95,105),
(1,2,79,170,88,153,96,106),
(1,2,80,173,90,160,98,108),
(1,4,1,21,23,21,20,20),
(1,4,2,22,24,22,20,20),
(1,4,3,23,26,22,20,21),
(1,4,4,23,27,23,20,21),
(1,4,5,24,29,24,21,21),
(1,4,6,25,30,25,21,22),
(1,4,7,26,32,25,21,22),
(1,4,8,26,33,26,21,23),
(1,4,9,27,35,27,21,23),
(1,4,10,28,36,27,21,23),
(1,4,11,29,38,28,22,24),
(1,4,12,30,39,29,22,24),
(1,4,13,31,41,30,22,25),
(1,4,14,31,43,31,22,25),
(1,4,15,32,44,31,22,25),
(1,4,16,33,46,32,23,26),
(1,4,17,34,48,33,23,26),
(1,4,18,35,49,34,23,27),
(1,4,19,36,51,35,23,27),
(1,4,20,37,53,35,23,28),
(1,4,21,38,54,36,24,28),
(1,4,22,39,56,37,24,29),
(1,4,23,40,58,38,24,29),
(1,4,24,41,60,39,24,30),
(1,4,25,42,61,40,25,30),
(1,4,26,43,63,41,25,31),
(1,4,27,44,65,42,25,31),
(1,4,28,45,67,43,25,32),
(1,4,29,46,69,43,25,32),
(1,4,30,47,71,44,26,33),
(1,4,31,48,72,45,26,33),
(1,4,32,49,74,46,26,34),
(1,4,33,50,76,47,27,34),
(1,4,34,51,78,48,27,35),
(1,4,35,52,80,49,27,35),
(1,4,36,53,82,50,27,36),
(1,4,37,54,84,51,28,36),
(1,4,38,55,86,52,28,37),
(1,4,39,56,88,53,28,38),
(1,4,40,57,90,54,28,38),
(1,4,41,58,92,55,29,39),
(1,4,42,60,94,56,29,39),
(1,4,43,61,96,57,29,40),
(1,4,44,62,98,58,30,40),
(1,4,45,63,100,59,30,41),
(1,4,46,64,103,61,30,42),
(1,4,47,65,105,62,31,42),
(1,4,48,66,107,63,31,43),
(1,4,49,68,109,64,31,44),
(1,4,50,69,111,65,32,44),
(1,4,51,70,113,66,32,45),
(1,4,52,71,116,67,32,45),
(1,4,53,73,118,68,33,46),
(1,4,54,74,120,69,33,47),
(1,4,55,75,122,71,33,47),
(1,4,56,76,125,72,34,48),
(1,4,57,78,127,73,34,49),
(1,4,58,79,129,74,34,49),
(1,4,59,80,131,75,35,50),
(1,4,60,81,134,77,35,51),
(1,4,61,83,136,78,35,51),
(1,4,62,84,138,79,36,52),
(1,4,63,85,141,80,36,53),
(1,4,64,87,143,81,37,54),
(1,4,65,88,146,83,37,54),
(1,4,66,89,148,84,37,55),
(1,4,67,91,151,85,38,56),
(1,4,68,92,153,86,38,57),
(1,4,69,94,156,88,39,57),
(1,4,70,95,158,89,39,58),
(1,4,71,97,161,90,39,60),
(1,4,72,99,164,92,40,60),
(1,4,73,100,167,94,40,61),
(1,4,74,102,170,95,41,62),
(1,4,75,104,173,97,41,63),
(1,4,76,105,176,98,41,64),
(1,4,77,107,179,100,42,65),
(1,4,78,109,183,106,42,66),
(1,4,79,111,186,107,43,67),
(1,4,80,113,189,109,43,69),
(1,5,1,20,20,20,22,23),
(1,5,2,20,20,20,23,24),
(1,5,3,20,20,21,25,26),
(1,5,4,20,21,21,26,27),
(1,5,5,21,21,21,27,28),
(1,5,6,21,21,22,29,30),
(1,5,7,21,21,22,30,31),
(1,5,8,21,22,23,31,33),
(1,5,9,21,22,23,33,34),
(1,5,10,21,22,23,34,36),
(1,5,11,22,22,24,36,37),
(1,5,12,22,23,24,37,39),
(1,5,13,22,23,25,38,40),
(1,5,14,22,23,25,40,42),
(1,5,15,22,23,25,41,43),
(1,5,16,23,24,26,43,45),
(1,5,17,23,24,26,44,46),
(1,5,18,23,24,27,46,48),
(1,5,19,23,24,27,47,49),
(1,5,20,23,25,28,49,51),
(1,5,21,24,25,28,51,53),
(1,5,22,24,25,29,52,54),
(1,5,23,24,26,29,54,56),
(1,5,24,24,26,30,55,58),
(1,5,25,25,26,30,57,59),
(1,5,26,25,27,31,59,61),
(1,5,27,25,27,31,60,63),
(1,5,28,25,27,32,62,65),
(1,5,29,25,28,32,64,66),
(1,5,30,26,28,33,65,68),
(1,5,31,26,28,33,67,70),
(1,5,32,26,29,34,69,72),
(1,5,33,27,29,34,70,73),
(1,5,34,27,29,35,72,75),
(1,5,35,27,30,35,74,77),
(1,5,36,27,30,36,76,79),
(1,5,37,28,30,36,78,81),
(1,5,38,28,31,37,79,83),
(1,5,39,28,31,38,81,85),
(1,5,40,28,31,38,83,87),
(1,5,41,29,32,39,85,88),
(1,5,42,29,32,39,87,90),
(1,5,43,29,33,40,89,92),
(1,5,44,30,33,40,91,94),
(1,5,45,30,33,41,92,96),
(1,5,46,30,34,42,94,98),
(1,5,47,31,34,42,96,100),
(1,5,48,31,35,43,98,102),
(1,5,49,31,35,44,100,104),
(1,5,50,32,36,44,102,106),
(1,5,51,32,36,45,104,109),
(1,5,52,32,36,45,106,111),
(1,5,53,33,37,46,108,113),
(1,5,54,33,37,47,110,115),
(1,5,55,33,38,47,112,117),
(1,5,56,34,38,48,114,119),
(1,5,57,34,39,49,117,121),
(1,5,58,34,39,49,119,124),
(1,5,59,35,40,50,121,126),
(1,5,60,35,40,51,123,128),
(1,5,61,35,41,51,125,130),
(1,5,62,36,41,52,127,132),
(1,5,63,36,41,53,129,135),
(1,5,64,37,42,54,132,137),
(1,5,65,37,42,54,134,139),
(1,5,66,37,43,55,136,142),
(1,5,67,38,43,56,138,144),
(1,5,68,38,44,57,140,146),
(1,5,69,39,44,57,143,149),
(1,5,70,39,45,58,145,151),
(1,5,71,39,46,59,148,158),
(1,5,72,40,46,59,151,161),
(1,5,73,40,47,60,154,164),
(1,5,74,41,47,61,156,167),
(1,5,75,41,48,62,159,170),
(1,5,76,41,49,63,162,174),
(1,5,77,42,49,64,165,177),
(1,5,78,42,50,65,168,180),
(1,5,79,43,50,66,171,183),
(1,5,80,43,51,67,174,186),
(1,6,1,23,20,22,20,20),
(1,6,2,24,21,23,20,20),
(1,6,3,26,22,24,20,21),
(1,6,4,27,22,26,20,21),
(1,6,5,28,23,27,20,21),
(1,6,6,30,24,28,20,21),
(1,6,7,31,25,29,21,22),
(1,6,8,32,26,30,21,22),
(1,6,9,34,26,32,21,22),
(1,6,10,35,27,33,21,23),
(1,6,11,36,28,34,21,23),
(1,6,12,38,29,35,21,23),
(1,6,13,39,30,37,21,24),
(1,6,14,41,31,38,21,24),
(1,6,15,42,32,39,21,24),
(1,6,16,44,33,41,21,25),
(1,6,17,45,34,42,22,25),
(1,6,18,47,34,43,22,25),
(1,6,19,48,35,45,22,26),
(1,6,20,50,36,46,22,26),
(1,6,21,51,37,48,22,26),
(1,6,22,53,38,49,22,27),
(1,6,23,54,39,51,22,27),
(1,6,24,56,40,52,23,28),
(1,6,25,58,41,53,23,28),
(1,6,26,59,42,55,23,28),
(1,6,27,61,43,56,23,29),
(1,6,28,63,44,58,23,29),
(1,6,29,64,45,59,23,30),
(1,6,30,66,46,61,24,30),
(1,6,31,68,47,62,24,30),
(1,6,32,69,48,64,24,31),
(1,6,33,71,50,66,24,31),
(1,6,34,73,51,67,24,32),
(1,6,35,74,52,69,24,32),
(1,6,36,76,53,70,25,33),
(1,6,37,78,54,72,25,33),
(1,6,38,80,55,74,25,34),
(1,6,39,82,56,75,25,34),
(1,6,40,83,57,77,25,35),
(1,6,41,85,58,79,26,35),
(1,6,42,87,60,80,26,35),
(1,6,43,89,61,82,26,36),
(1,6,44,91,62,84,26,36),
(1,6,45,93,63,85,26,37),
(1,6,46,95,64,87,27,37),
(1,6,47,97,66,89,27,38),
(1,6,48,99,67,91,27,38),
(1,6,49,101,68,93,27,39),
(1,6,50,103,69,94,28,40),
(1,6,51,105,71,96,28,40),
(1,6,52,106,72,97,28,41),
(1,6,53,107,72,98,28,41),
(1,6,54,107,73,98,29,42),
(1,6,55,108,73,99,29,43),
(1,6,56,111,75,102,29,44),
(1,6,57,113,76,104,29,44),
(1,6,58,118,77,106,30,45),
(1,6,59,118,79,108,30,45),
(1,6,60,123,80,110,30,46),
(1,6,61,125,81,112,30,47),
(1,6,62,128,83,114,30,47),
(1,6,63,130,84,117,31,48),
(1,6,64,130,86,119,31,48),
(1,6,65,140,87,128,31,49),
(1,6,66,143,89,131,31,50),
(1,6,67,146,90,133,32,50),
(1,6,68,148,92,135,32,51),
(1,6,69,151,93,138,32,52),
(1,6,70,154,95,140,32,52),
(1,6,71,162,97,144,33,53),
(1,6,72,164,98,146,33,54),
(1,6,73,165,100,148,33,55),
(1,6,74,166,102,151,33,55),
(1,6,75,169,103,154,34,56),
(1,6,76,172,105,157,34,57),
(1,6,77,175,107,157,34,58),
(1,6,78,176,108,157,34,58),
(1,6,79,177,110,157,35,59),
(1,6,80,180,112,160,35,60),
(1,8,1,20,20,20,23,22),
(1,8,2,20,20,20,24,23),
(1,8,3,20,20,21,26,25),
(1,8,4,20,20,21,27,26),
(1,8,5,20,21,21,28,27),
(1,8,6,20,21,21,30,29),
(1,8,7,21,21,22,31,30),
(1,8,8,21,21,22,33,31),
(1,8,9,21,21,22,34,33),
(1,8,10,21,21,23,36,34),
(1,8,11,21,22,23,37,36),
(1,8,12,21,22,23,39,37),
(1,8,13,21,22,24,40,38),
(1,8,14,21,22,24,42,40),
(1,8,15,21,22,24,43,41),
(1,8,16,21,23,25,45,43),
(1,8,17,22,23,25,46,44),
(1,8,18,22,23,25,48,46),
(1,8,19,22,23,26,49,47),
(1,8,20,22,23,26,51,49),
(1,8,21,22,24,26,53,51),
(1,8,22,22,24,27,54,52),
(1,8,23,22,24,27,56,54),
(1,8,24,23,24,28,58,55),
(1,8,25,23,25,28,59,57),
(1,8,26,23,25,28,61,59),
(1,8,27,23,25,29,63,60),
(1,8,28,23,25,29,65,62),
(1,8,29,23,25,30,66,64),
(1,8,30,24,26,30,68,65),
(1,8,31,24,26,30,70,67),
(1,8,32,24,26,31,72,69),
(1,8,33,24,27,31,73,70),
(1,8,34,24,27,32,75,72),
(1,8,35,24,27,32,77,74),
(1,8,36,25,27,33,79,76),
(1,8,37,25,28,33,81,78),
(1,8,38,25,28,34,83,79),
(1,8,39,25,28,34,85,81),
(1,8,40,25,28,35,87,83),
(1,8,41,26,29,35,88,85),
(1,8,42,26,29,35,90,87),
(1,8,43,26,29,36,92,89),
(1,8,44,26,30,36,94,91),
(1,8,45,26,30,37,96,92),
(1,8,46,27,30,37,98,94),
(1,8,47,27,31,38,100,96),
(1,8,48,27,31,38,102,98),
(1,8,49,27,31,39,104,100),
(1,8,50,28,32,40,106,102),
(1,8,51,28,32,40,109,104),
(1,8,52,28,32,41,111,106),
(1,8,53,28,33,41,113,108),
(1,8,54,29,33,42,115,110),
(1,8,55,29,33,42,117,112),
(1,8,56,29,34,43,119,114),
(1,8,57,29,34,43,121,117),
(1,8,58,30,34,44,124,119),
(1,8,59,30,35,44,126,121),
(1,8,60,30,35,45,128,123),
(1,8,61,30,35,46,130,125),
(1,8,62,31,36,46,132,127),
(1,8,63,31,36,47,135,129),
(1,8,64,31,37,47,137,132),
(1,8,65,32,37,48,139,134),
(1,8,66,32,37,49,142,136),
(1,8,67,32,38,49,144,138),
(1,8,68,32,38,50,146,140),
(1,8,69,33,39,50,149,143),
(1,8,70,33,39,51,151,145),
(1,8,71,33,39,52,154,152),
(1,8,72,33,40,53,160,155),
(1,8,73,33,40,54,160,158),
(1,8,74,34,41,54,163,160),
(1,8,75,34,41,55,166,163),
(1,8,76,34,41,56,169,166),
(1,8,77,35,42,57,172,169),
(1,8,78,35,42,57,175,173),
(1,8,79,35,43,58,178,176),
(1,8,80,36,43,59,181,179),
(1,9,1,20,20,21,22,22),
(1,9,2,20,20,22,23,23),
(1,9,3,21,21,22,24,24),
(1,9,4,21,21,23,26,25),
(1,9,5,21,21,23,27,27),
(1,9,6,21,22,24,28,28),
(1,9,7,22,22,24,29,29),
(1,9,8,22,23,25,30,30),
(1,9,9,22,23,26,32,31),
(1,9,10,23,23,26,33,33),
(1,9,11,23,24,27,34,34),
(1,9,12,23,24,27,35,35),
(1,9,13,24,25,28,37,36),
(1,9,14,24,25,29,38,38),
(1,9,15,24,25,29,39,39),
(1,9,16,25,26,30,41,40),
(1,9,17,25,26,31,42,42),
(1,9,18,25,27,31,43,43),
(1,9,19,26,27,32,45,44),
(1,9,20,26,28,33,46,46),
(1,9,21,26,28,33,48,47),
(1,9,22,27,29,34,49,49),
(1,9,23,27,29,35,51,50),
(1,9,24,28,30,35,52,51),
(1,9,25,28,30,36,53,53),
(1,9,26,28,31,37,55,54),
(1,9,27,29,31,37,56,56),
(1,9,28,29,32,38,58,57),
(1,9,29,30,32,39,59,59),
(1,9,30,30,33,40,61,60),
(1,9,31,30,33,40,62,62),
(1,9,32,31,34,41,64,63),
(1,9,33,31,34,42,66,65),
(1,9,34,32,35,43,67,66),
(1,9,35,32,35,44,69,68),
(1,9,36,33,36,44,70,69),
(1,9,37,33,36,45,72,71),
(1,9,38,34,37,46,74,73),
(1,9,39,34,38,47,75,74),
(1,9,40,35,38,48,77,76),
(1,9,41,35,39,48,79,78),
(1,9,42,35,39,49,80,79),
(1,9,43,36,40,50,82,81),
(1,9,44,36,40,51,84,83),
(1,9,45,37,41,52,85,84),
(1,9,46,37,42,53,87,86),
(1,9,47,38,42,54,89,88),
(1,9,48,38,43,55,91,89),
(1,9,49,39,44,55,93,91),
(1,9,50,40,44,56,94,93),
(1,9,51,40,45,57,96,95),
(1,9,52,41,45,58,98,97),
(1,9,53,41,46,59,100,98),
(1,9,54,42,47,60,102,100),
(1,9,55,42,47,61,103,102),
(1,9,56,43,48,62,105,104),
(1,9,57,43,49,63,107,106),
(1,9,58,44,49,64,109,108),
(1,9,59,44,50,65,111,109),
(1,9,60,45,51,66,113,111),
(1,9,61,46,51,67,115,113),
(1,9,62,46,52,68,117,115),
(1,9,63,47,53,69,119,117),
(1,9,64,47,54,70,121,119),
(1,9,65,48,54,71,123,121),
(1,9,66,49,55,72,125,123),
(1,9,67,49,56,73,127,125),
(1,9,68,50,57,74,129,127),
(1,9,69,50,57,75,131,129),
(1,9,70,51,58,76,133,131),
(1,9,71,52,59,78,135,146),
(1,9,72,53,59,79,138,148),
(1,9,73,54,60,80,140,151),
(1,9,74,54,61,89,143,154),
(1,9,75,55,62,91,145,156),
(1,9,76,56,63,92,148,159),
(1,9,77,57,64,93,151,162),
(1,9,78,57,65,95,153,165),
(1,9,79,58,66,96,156,168),
(1,9,80,59,67,97,159,170),
(2,1,1,26,17,24,17,23),
(2,1,2,27,18,25,17,23),
(2,1,3,29,19,26,17,24),
(2,1,4,30,19,27,17,24),
(2,1,5,31,20,29,17,24),
(2,1,6,32,21,30,17,24),
(2,1,7,34,22,31,18,25),
(2,1,8,35,23,32,18,25),
(2,1,9,37,24,34,18,25),
(2,1,10,38,24,35,18,26),
(2,1,11,39,25,36,18,26),
(2,1,12,41,26,37,18,26),
(2,1,13,42,27,39,18,27),
(2,1,14,44,28,40,18,27),
(2,1,15,45,29,41,18,27),
(2,1,16,47,30,43,19,28),
(2,1,17,48,31,44,19,28),
(2,1,18,50,32,45,19,28),
(2,1,19,51,33,47,19,29),
(2,1,20,53,34,48,19,29),
(2,1,21,54,34,50,19,29),
(2,1,22,56,35,51,19,30),
(2,1,23,57,36,52,20,30),
(2,1,24,59,37,54,20,30),
(2,1,25,60,38,55,20,31),
(2,1,26,62,39,57,20,31),
(2,1,27,64,40,58,20,32),
(2,1,28,65,41,60,20,32),
(2,1,29,67,43,61,21,32),
(2,1,30,69,44,63,21,33),
(2,1,31,70,45,64,21,33),
(2,1,32,72,46,66,21,34),
(2,1,33,74,47,67,21,34),
(2,1,34,76,48,69,21,35),
(2,1,35,77,49,71,22,35),
(2,1,36,79,50,72,22,36),
(2,1,37,81,51,74,22,36),
(2,1,38,83,52,76,22,36),
(2,1,39,84,53,77,22,37),
(2,1,40,86,55,79,23,37),
(2,1,41,88,56,81,23,38),
(2,1,42,90,57,82,23,38),
(2,1,43,92,58,84,23,39),
(2,1,44,94,59,86,23,39),
(2,1,45,96,60,87,24,40),
(2,1,46,98,62,89,24,40),
(2,1,47,100,63,91,24,41),
(2,1,48,101,64,93,24,41),
(2,1,49,103,65,94,25,42),
(2,1,50,105,66,96,25,42),
(2,1,51,107,68,98,25,43),
(2,1,52,109,69,100,25,43),
(2,1,53,111,70,102,25,44),
(2,1,54,113,71,104,26,45),
(2,1,55,115,73,105,26,45),
(2,1,56,118,74,107,26,46),
(2,1,57,120,75,109,26,46),
(2,1,58,122,77,111,27,47),
(2,1,59,124,78,113,27,47),
(2,1,60,126,79,115,27,48),
(2,1,61,128,81,117,27,48),
(2,1,62,130,82,119,28,49),
(2,1,63,132,83,121,28,50),
(2,1,64,135,85,123,28,50),
(2,1,65,137,86,125,29,51),
(2,1,66,139,87,127,29,52),
(2,1,67,141,89,129,29,52),
(2,1,68,143,90,131,29,53),
(2,1,69,146,92,133,30,53),
(2,1,70,148,93,135,30,54),
(2,1,71,157,94,142,30,55),
(2,1,72,162,96,148,30,56),
(2,1,73,165,98,150,30,57),
(2,1,74,168,99,153,31,57),
(2,1,75,170,101,154,31,58),
(2,1,76,172,103,156,31,59),
(2,1,77,174,105,159,32,60),
(2,1,78,179,106,162,32,60),
(2,1,79,184,108,167,32,61),
(2,1,80,187,110,170,33,62),
(2,3,1,23,20,23,17,24),
(2,3,2,23,21,24,18,25),
(2,3,3,24,23,25,18,25),
(2,3,4,24,24,26,19,26),
(2,3,5,25,25,27,19,26),
(2,3,6,25,27,28,20,27),
(2,3,7,26,28,28,21,28),
(2,3,8,26,30,29,21,28),
(2,3,9,26,31,30,22,29),
(2,3,10,27,33,31,22,30),
(2,3,11,27,34,32,23,30),
(2,3,12,28,36,33,24,31),
(2,3,13,28,37,34,24,32),
(2,3,14,29,39,35,25,33),
(2,3,15,29,40,36,26,33),
(2,3,16,30,42,37,26,34),
(2,3,17,30,43,39,27,35),
(2,3,18,31,45,40,28,35),
(2,3,19,31,47,41,28,36),
(2,3,20,32,48,42,29,37),
(2,3,21,32,50,43,30,38),
(2,3,22,33,51,44,31,39),
(2,3,23,34,53,45,31,39),
(2,3,24,34,55,46,32,40),
(2,3,25,35,57,47,33,41),
(2,3,26,35,58,48,34,42),
(2,3,27,36,60,50,34,43),
(2,3,28,36,62,51,35,43),
(2,3,29,37,63,52,36,44),
(2,3,30,38,65,53,37,45),
(2,3,31,38,67,54,37,46),
(2,3,32,39,69,56,38,47),
(2,3,33,39,71,57,39,48),
(2,3,34,40,72,58,40,49),
(2,3,35,41,74,59,41,49),
(2,3,36,41,76,61,42,50),
(2,3,37,42,78,62,42,51),
(2,3,38,43,80,63,43,52),
(2,3,39,43,82,64,44,53),
(2,3,40,44,84,66,45,54),
(2,3,41,45,86,67,46,55),
(2,3,42,45,88,68,47,56),
(2,3,43,46,90,70,47,57),
(2,3,44,47,91,71,48,58),
(2,3,45,47,93,72,49,59),
(2,3,46,48,95,74,50,60),
(2,3,47,49,98,75,51,61),
(2,3,48,50,100,77,52,62),
(2,3,49,50,102,78,53,63),
(2,3,50,51,104,79,54,64),
(2,3,51,52,106,81,55,65),
(2,3,52,52,108,82,56,66),
(2,3,53,53,110,84,57,67),
(2,3,54,54,112,85,58,68),
(2,3,55,55,114,87,59,69),
(2,3,56,55,116,88,60,70),
(2,3,57,56,118,90,61,71),
(2,3,58,57,121,91,62,72),
(2,3,59,58,123,93,63,73),
(2,3,60,59,125,94,64,74),
(2,3,61,59,127,96,65,76),
(2,3,62,60,130,97,66,77),
(2,3,63,61,132,99,67,78),
(2,3,64,62,134,100,68,79),
(2,3,65,63,136,102,69,80),
(2,3,66,64,139,104,70,81),
(2,3,67,64,141,105,71,82),
(2,3,68,65,143,107,72,84),
(2,3,69,66,146,108,73,85),
(2,3,70,67,148,110,74,86),
(2,3,71,68,151,112,75,87),
(2,3,72,69,154,114,76,88),
(2,3,73,70,157,116,77,90),
(2,3,74,71,160,118,79,91),
(2,3,75,72,163,120,80,93),
(2,3,76,73,166,122,81,94),
(2,3,77,74,169,124,83,96),
(2,3,78,75,172,126,84,97),
(2,3,79,76,175,128,85,99),
(2,3,80,77,178,130,87,100),
(2,4,1,24,20,23,17,23),
(2,4,2,25,21,24,17,23),
(2,4,3,25,23,24,17,24),
(2,4,4,26,24,25,17,24),
(2,4,5,27,26,26,18,24),
(2,4,6,28,27,26,18,25),
(2,4,7,29,29,27,18,25),
(2,4,8,29,30,28,18,26),
(2,4,9,30,32,29,18,26),
(2,4,10,31,33,29,19,26),
(2,4,11,32,35,30,19,27),
(2,4,12,33,37,31,19,27),
(2,4,13,34,38,32,19,28),
(2,4,14,34,40,32,19,28),
(2,4,15,35,41,33,19,28),
(2,4,16,36,43,34,20,29),
(2,4,17,37,45,35,20,29),
(2,4,18,38,46,36,20,30),
(2,4,19,39,48,37,20,30),
(2,4,20,40,50,37,21,31),
(2,4,21,41,52,38,21,31),
(2,4,22,42,53,39,21,31),
(2,4,23,43,55,40,21,32),
(2,4,24,43,57,41,21,32),
(2,4,25,44,59,42,22,33),
(2,4,26,45,60,43,22,33),
(2,4,27,46,62,44,22,34),
(2,4,28,47,64,44,22,34),
(2,4,29,48,66,45,23,35),
(2,4,30,49,68,46,23,35),
(2,4,31,50,70,47,23,36),
(2,4,32,51,72,48,23,36),
(2,4,33,53,73,49,24,37),
(2,4,34,54,75,50,24,38),
(2,4,35,55,77,51,24,38),
(2,4,36,56,79,52,24,39),
(2,4,37,57,81,53,25,39),
(2,4,38,58,83,54,25,40),
(2,4,39,59,85,55,25,40),
(2,4,40,60,87,56,26,41),
(2,4,41,61,89,57,26,41),
(2,4,42,62,91,58,26,42),
(2,4,43,63,93,59,27,43),
(2,4,44,65,95,60,27,43),
(2,4,45,66,98,61,27,44),
(2,4,46,67,100,62,27,44),
(2,4,47,68,102,64,28,45),
(2,4,48,69,104,65,28,46),
(2,4,49,71,106,66,28,46),
(2,4,50,72,108,67,29,47),
(2,4,51,73,110,68,29,48),
(2,4,52,74,113,69,29,48),
(2,4,53,75,115,70,30,49),
(2,4,54,77,117,71,30,50),
(2,4,55,78,119,73,30,50),
(2,4,56,79,122,74,31,51),
(2,4,57,80,124,75,31,52),
(2,4,58,82,126,76,31,52),
(2,4,59,83,129,77,32,53),
(2,4,60,84,131,78,32,54),
(2,4,61,86,133,80,33,54),
(2,4,62,87,136,81,33,55),
(2,4,63,88,138,82,33,56),
(2,4,64,90,140,83,34,57),
(2,4,65,91,143,85,34,57),
(2,4,66,92,145,86,34,58),
(2,4,67,94,148,87,35,59),
(2,4,68,95,150,88,35,59),
(2,4,69,97,153,90,36,60),
(2,4,70,98,155,91,36,61),
(2,4,71,100,158,92,36,62),
(2,4,72,102,161,94,37,62),
(2,4,73,103,164,99,37,63),
(2,4,74,105,167,100,38,64),
(2,4,75,107,170,102,38,65),
(2,4,76,108,173,102,38,66),
(2,4,77,110,176,102,39,67),
(2,4,78,112,180,103,39,68),
(2,4,79,114,183,105,40,69),
(2,4,80,116,186,107,40,70),
(2,6,1,26,17,24,17,23),
(2,6,2,27,18,25,17,23),
(2,6,3,29,19,26,17,24),
(2,6,4,30,19,27,17,24),
(2,6,5,31,20,29,17,24),
(2,6,6,32,21,30,17,24),
(2,6,7,34,22,31,18,25),
(2,6,8,35,23,32,18,25),
(2,6,9,37,24,34,18,25),
(2,6,10,38,24,35,18,26),
(2,6,11,39,25,36,18,26),
(2,6,12,41,26,37,18,26),
(2,6,13,42,27,39,18,27),
(2,6,14,44,28,40,18,27),
(2,6,15,45,29,41,18,27),
(2,6,16,47,30,43,19,28),
(2,6,17,48,31,44,19,28),
(2,6,18,50,32,45,19,28),
(2,6,19,51,33,47,19,29),
(2,6,20,53,34,48,19,29),
(2,6,21,54,34,50,19,29),
(2,6,22,56,35,51,19,30),
(2,6,23,57,36,52,20,30),
(2,6,24,59,37,54,20,30),
(2,6,25,60,38,55,20,31),
(2,6,26,62,39,57,20,31),
(2,6,27,64,40,58,20,32),
(2,6,28,65,41,60,20,32),
(2,6,29,67,43,61,21,32),
(2,6,30,69,44,63,21,33),
(2,6,31,70,45,64,21,33),
(2,6,32,72,46,66,21,34),
(2,6,33,74,47,67,21,34),
(2,6,34,76,48,69,21,35),
(2,6,35,77,49,71,22,35),
(2,6,36,79,50,72,22,36),
(2,6,37,81,51,74,22,36),
(2,6,38,83,52,76,22,36),
(2,6,39,84,53,77,22,37),
(2,6,40,86,55,79,23,37),
(2,6,41,88,56,81,23,38),
(2,6,42,90,57,82,23,38),
(2,6,43,92,58,84,23,39),
(2,6,44,94,59,86,23,39),
(2,6,45,96,60,87,24,40),
(2,6,46,98,62,89,24,40),
(2,6,47,100,63,91,24,41),
(2,6,48,101,64,93,24,41),
(2,6,49,103,65,94,25,42),
(2,6,50,105,66,96,25,42),
(2,6,51,107,68,98,25,43),
(2,6,52,109,69,100,25,43),
(2,6,53,110,69,100,25,44),
(2,6,54,111,70,101,26,45),
(2,6,55,111,70,101,26,45),
(2,6,56,114,72,104,26,46),
(2,6,57,116,73,106,26,46),
(2,6,58,118,74,108,27,47),
(2,6,59,124,76,110,27,47),
(2,6,60,126,77,112,27,48),
(2,6,61,128,78,114,27,49),
(2,6,62,131,80,116,27,49),
(2,6,63,133,81,119,28,50),
(2,6,64,136,83,121,28,50),
(2,6,65,136,84,123,28,51),
(2,6,66,142,86,126,28,52),
(2,6,67,145,87,128,29,52),
(2,6,68,147,89,130,29,53),
(2,6,69,150,90,133,29,54),
(2,6,70,157,92,135,29,54),
(2,6,71,160,94,138,30,55),
(2,6,72,163,95,140,30,56),
(2,6,73,166,97,151,30,57),
(2,6,74,169,99,154,30,57),
(2,6,75,172,100,156,31,58),
(2,6,76,175,102,160,31,59),
(2,6,77,179,104,162,31,60),
(2,6,78,182,105,165,31,60),
(2,6,79,191,107,168,32,61),
(2,6,80,194,109,171,32,62),
(2,7,1,24,17,23,18,25),
(2,7,2,25,17,24,19,26),
(2,7,3,26,18,25,20,27),
(2,7,4,26,18,26,21,28),
(2,7,5,27,19,27,22,29),
(2,7,6,28,19,28,23,30),
(2,7,7,29,20,29,24,31),
(2,7,8,30,20,30,25,32),
(2,7,9,31,21,31,26,33),
(2,7,10,32,21,32,27,34),
(2,7,11,33,22,33,28,36),
(2,7,12,34,22,34,29,37),
(2,7,13,34,23,35,30,38),
(2,7,14,35,23,36,31,39),
(2,7,15,36,24,37,32,40),
(2,7,16,37,24,39,33,41),
(2,7,17,38,25,40,34,43),
(2,7,18,39,25,41,35,44),
(2,7,19,40,26,42,36,45),
(2,7,20,41,26,43,37,46),
(2,7,21,42,27,44,38,47),
(2,7,22,43,27,45,39,49),
(2,7,23,44,28,47,40,50),
(2,7,24,45,28,48,41,51),
(2,7,25,47,29,49,43,52),
(2,7,26,48,30,50,44,54),
(2,7,27,49,30,52,45,55),
(2,7,28,50,31,53,46,56),
(2,7,29,51,31,54,47,58),
(2,7,30,52,32,55,48,59),
(2,7,31,53,33,57,50,60),
(2,7,32,54,33,58,51,62),
(2,7,33,55,34,59,52,63),
(2,7,34,57,34,61,53,65),
(2,7,35,58,35,62,55,66),
(2,7,36,59,36,63,56,67),
(2,7,37,60,36,65,57,69),
(2,7,38,61,37,66,58,70),
(2,7,39,62,38,67,60,72),
(2,7,40,64,38,69,61,73),
(2,7,41,65,39,70,62,75),
(2,7,42,66,40,72,64,76),
(2,7,43,67,40,73,65,78),
(2,7,44,69,41,74,66,79),
(2,7,45,70,42,76,68,81),
(2,7,46,71,42,77,69,82),
(2,7,47,72,43,79,70,84),
(2,7,48,74,44,80,72,85),
(2,7,49,75,45,82,73,87),
(2,7,50,76,45,83,75,89),
(2,7,51,78,46,85,76,90),
(2,7,52,79,47,86,77,92),
(2,7,53,80,47,88,79,93),
(2,7,54,82,48,90,80,95),
(2,7,55,83,49,91,82,97),
(2,7,56,85,50,93,83,98),
(2,7,57,86,50,94,85,100),
(2,7,58,87,51,96,86,102),
(2,7,59,89,52,97,88,103),
(2,7,60,90,53,99,89,105),
(2,7,61,92,54,101,91,107),
(2,7,62,93,54,102,92,109),
(2,7,63,95,55,104,94,110),
(2,7,64,96,56,106,95,112),
(2,7,65,97,57,107,97,114),
(2,7,66,99,58,109,99,116),
(2,7,67,100,58,111,100,118),
(2,7,68,102,59,113,102,119),
(2,7,69,103,60,114,103,121),
(2,7,70,105,61,116,105,123),
(2,7,71,106,62,118,117,125),
(2,7,72,108,63,120,119,128),
(2,7,73,110,64,122,122,130),
(2,7,74,112,65,125,124,132),
(2,7,75,114,66,127,126,134),
(2,7,76,116,67,129,128,137),
(2,7,77,117,68,131,128,139),
(2,7,78,119,69,133,133,141),
(2,7,79,121,70,136,135,144),
(2,7,80,123,71,138,137,146),
(2,9,1,23,17,23,19,25),
(2,9,2,23,17,24,20,26),
(2,9,3,24,18,24,21,27),
(2,9,4,24,18,25,23,28),
(2,9,5,24,18,25,24,30),
(2,9,6,24,19,26,25,31),
(2,9,7,25,19,26,26,32),
(2,9,8,25,20,27,27,33),
(2,9,9,25,20,27,29,34),
(2,9,10,26,20,28,30,36),
(2,9,11,26,21,29,31,37),
(2,9,12,26,21,29,33,38),
(2,9,13,27,22,30,34,39),
(2,9,14,27,22,31,35,41),
(2,9,15,27,23,31,37,42),
(2,9,16,28,23,32,38,43),
(2,9,17,28,23,32,39,45),
(2,9,18,28,24,33,41,46),
(2,9,19,29,24,34,42,47),
(2,9,20,29,25,34,43,49),
(2,9,21,29,25,35,45,50),
(2,9,22,30,26,36,46,51),
(2,9,23,30,26,37,48,53),
(2,9,24,30,27,37,49,54),
(2,9,25,31,27,38,51,56),
(2,9,26,31,28,39,52,57),
(2,9,27,32,28,39,54,59),
(2,9,28,32,29,40,55,60),
(2,9,29,32,29,41,57,62),
(2,9,30,33,30,42,58,63),
(2,9,31,33,30,42,60,65),
(2,9,32,34,31,43,61,66),
(2,9,33,34,31,44,63,68),
(2,9,34,35,32,45,64,69),
(2,9,35,35,32,45,66,71),
(2,9,36,36,33,46,68,72),
(2,9,37,36,34,47,69,74),
(2,9,38,36,34,48,71,76),
(2,9,39,37,35,49,72,77),
(2,9,40,37,35,50,74,79),
(2,9,41,38,36,50,76,80),
(2,9,42,38,36,51,77,82),
(2,9,43,39,37,52,79,84),
(2,9,44,39,38,53,81,85),
(2,9,45,40,38,54,83,87),
(2,9,46,40,39,55,84,89),
(2,9,47,41,39,56,86,91),
(2,9,48,41,40,56,88,92),
(2,9,49,42,41,57,90,94),
(2,9,50,42,41,58,91,96),
(2,9,51,43,42,59,93,98),
(2,9,52,43,43,60,95,99),
(2,9,53,44,43,61,97,101),
(2,9,54,45,44,62,99,103),
(2,9,55,45,45,63,101,105),
(2,9,56,46,45,64,102,107),
(2,9,57,46,46,65,104,109),
(2,9,58,47,47,66,106,110),
(2,9,59,47,47,67,108,112),
(2,9,60,48,48,68,110,114),
(2,9,61,48,49,69,112,116),
(2,9,62,49,49,70,114,118),
(2,9,63,50,50,71,116,120),
(2,9,64,50,51,72,118,122),
(2,9,65,51,51,73,120,124),
(2,9,66,52,52,74,122,126),
(2,9,67,52,53,75,124,128),
(2,9,68,53,54,76,126,130),
(2,9,69,53,54,77,128,132),
(2,9,70,54,55,78,130,134),
(2,9,71,55,56,88,134,145),
(2,9,72,56,56,89,135,147),
(2,9,73,57,57,90,137,150),
(2,9,74,57,58,91,142,153),
(2,9,75,58,59,93,142,155),
(2,9,76,59,60,94,145,158),
(2,9,77,60,61,95,148,161),
(2,9,78,60,62,97,150,164),
(2,9,79,61,63,98,153,167),
(2,9,80,62,64,99,156,169),
(3,1,1,25,16,25,19,19),
(3,1,2,26,17,26,19,19),
(3,1,3,28,18,27,19,20),
(3,1,4,29,18,28,19,20),
(3,1,5,30,19,30,19,20),
(3,1,6,31,20,31,19,20),
(3,1,7,33,21,32,20,21),
(3,1,8,34,22,33,20,21),
(3,1,9,36,23,35,20,21),
(3,1,10,37,23,36,20,22),
(3,1,11,38,24,37,20,22),
(3,1,12,40,25,38,20,22),
(3,1,13,41,26,40,20,23),
(3,1,14,43,27,41,20,23),
(3,1,15,44,28,42,20,23),
(3,1,16,46,29,44,21,24),
(3,1,17,47,30,45,21,24),
(3,1,18,49,31,46,21,24),
(3,1,19,50,32,48,21,25),
(3,1,20,52,33,49,21,25),
(3,1,21,53,34,51,21,26),
(3,1,22,55,34,52,21,26),
(3,1,23,56,35,53,21,26),
(3,1,24,58,36,55,22,27),
(3,1,25,59,37,56,22,27),
(3,1,26,61,38,58,22,27),
(3,1,27,63,39,59,22,28),
(3,1,28,64,41,61,22,28),
(3,1,29,66,42,62,22,29),
(3,1,30,68,43,64,23,29),
(3,1,31,69,44,65,23,30),
(3,1,32,71,45,67,23,30),
(3,1,33,73,46,68,23,30),
(3,1,34,75,47,70,23,31),
(3,1,35,76,48,72,24,31),
(3,1,36,78,49,73,24,32),
(3,1,37,80,50,75,24,32),
(3,1,38,82,51,76,24,33),
(3,1,39,84,52,78,24,33),
(3,1,40,85,54,80,24,34),
(3,1,41,87,55,81,25,34),
(3,1,42,89,56,83,25,35),
(3,1,43,91,57,85,25,35),
(3,1,44,93,58,87,25,36),
(3,1,45,95,59,88,26,36),
(3,1,46,97,61,90,26,37),
(3,1,47,99,62,92,26,37),
(3,1,48,101,63,94,26,38),
(3,1,49,102,64,95,26,38),
(3,1,50,104,65,97,27,39),
(3,1,51,106,67,99,27,39),
(3,1,52,108,68,101,27,40),
(3,1,53,110,69,103,27,40),
(3,1,54,112,70,104,28,41),
(3,1,55,115,72,106,28,41),
(3,1,56,117,73,108,28,42),
(3,1,57,119,74,110,28,42),
(3,1,58,121,76,112,29,43),
(3,1,59,123,77,114,29,43),
(3,1,60,125,78,116,29,44),
(3,1,61,127,80,118,29,45),
(3,1,62,129,81,120,30,45),
(3,1,63,131,82,122,30,46),
(3,1,64,134,84,124,30,46),
(3,1,65,136,85,126,31,47),
(3,1,66,138,86,128,31,48),
(3,1,67,140,88,130,31,48),
(3,1,68,142,89,132,31,49),
(3,1,69,145,91,134,32,49),
(3,1,70,147,92,136,32,50),
(3,1,71,150,93,138,32,51),
(3,1,72,152,95,141,32,52),
(3,1,73,164,97,151,32,53),
(3,1,74,164,98,151,33,53),
(3,1,75,170,100,156,33,54),
(3,1,76,173,102,160,33,55),
(3,1,77,173,104,160,34,56),
(3,1,78,176,105,162,34,56),
(3,1,79,183,107,168,34,57),
(3,1,80,186,109,171,35,58),
(3,2,1,24,16,25,19,20),
(3,2,2,25,17,26,20,21),
(3,2,3,26,17,27,20,21),
(3,2,4,27,18,28,21,22),
(3,2,5,28,18,29,22,23),
(3,2,6,29,19,30,22,24),
(3,2,7,31,20,31,23,24),
(3,2,8,32,20,32,24,25),
(3,2,9,33,21,33,24,26),
(3,2,10,34,21,34,25,26),
(3,2,11,35,22,36,26,27),
(3,2,12,36,23,37,26,28),
(3,2,13,38,23,38,27,29),
(3,2,14,39,24,39,28,30),
(3,2,15,40,25,40,29,30),
(3,2,16,41,25,41,29,31),
(3,2,17,43,26,43,30,32),
(3,2,18,44,27,44,31,33),
(3,2,19,45,28,45,32,34),
(3,2,20,47,28,46,32,35),
(3,2,21,48,29,47,33,35),
(3,2,22,49,30,49,34,36),
(3,2,23,51,30,50,35,37),
(3,2,24,52,31,51,36,38),
(3,2,25,53,32,52,36,39),
(3,2,26,55,33,54,37,40),
(3,2,27,56,33,55,38,41),
(3,2,28,57,34,56,39,42),
(3,2,29,59,35,58,40,43),
(3,2,30,60,36,59,41,43),
(3,2,31,62,37,60,42,44),
(3,2,32,63,37,62,42,45),
(3,2,33,65,38,63,43,46),
(3,2,34,66,39,65,44,47),
(3,2,35,68,40,66,45,48),
(3,2,36,69,41,67,46,49),
(3,2,37,71,41,69,47,50),
(3,2,38,72,42,70,48,51),
(3,2,39,74,43,72,49,52),
(3,2,40,75,44,73,50,53),
(3,2,41,77,45,75,51,54),
(3,2,42,78,46,76,52,55),
(3,2,43,80,47,78,53,56),
(3,2,44,82,47,79,54,57),
(3,2,45,83,48,81,55,59),
(3,2,46,85,49,82,56,60),
(3,2,47,87,50,84,57,61),
(3,2,48,88,51,85,58,62),
(3,2,49,90,52,87,59,63),
(3,2,50,92,53,89,60,64),
(3,2,51,93,54,90,61,65),
(3,2,52,95,55,92,62,66),
(3,2,53,97,56,93,63,67),
(3,2,54,98,57,95,64,69),
(3,2,55,100,58,97,65,70),
(3,2,56,102,59,98,66,71),
(3,2,57,104,60,100,67,72),
(3,2,58,106,61,102,68,73),
(3,2,59,107,62,103,69,74),
(3,2,60,109,63,105,70,76),
(3,2,61,111,64,107,72,77),
(3,2,62,113,65,109,73,78),
(3,2,63,115,66,110,74,79),
(3,2,64,117,67,112,75,80),
(3,2,65,118,68,114,76,82),
(3,2,66,120,69,116,77,83),
(3,2,67,122,70,118,78,84),
(3,2,68,124,71,119,80,85),
(3,2,69,126,72,121,81,87),
(3,2,70,128,73,123,82,88),
(3,2,71,150,74,125,83,89),
(3,2,72,152,75,128,85,91),
(3,2,73,156,76,130,86,93),
(3,2,74,158,78,132,88,94),
(3,2,75,161,79,134,89,96),
(3,2,76,164,80,137,91,97),
(3,2,77,166,82,139,92,99),
(3,2,78,170,83,141,94,101),
(3,2,79,172,84,144,95,102),
(3,2,80,175,86,146,97,104),
(3,3,1,22,19,24,19,20),
(3,3,2,22,20,25,20,21),
(3,3,3,23,22,26,20,21),
(3,3,4,23,23,27,21,22),
(3,3,5,24,25,28,21,23),
(3,3,6,24,26,29,22,23),
(3,3,7,25,27,29,23,24),
(3,3,8,25,29,30,23,25),
(3,3,9,25,30,31,24,25),
(3,3,10,26,32,32,24,26),
(3,3,11,26,33,33,25,27),
(3,3,12,27,35,34,26,27),
(3,3,13,27,36,35,26,28),
(3,3,14,28,38,36,27,29),
(3,3,15,28,39,37,28,29),
(3,3,16,29,41,38,28,30),
(3,3,17,29,42,39,29,31),
(3,3,18,30,44,41,30,32),
(3,3,19,30,46,42,30,32),
(3,3,20,31,47,43,31,33),
(3,3,21,32,49,44,32,34),
(3,3,22,32,51,45,33,35),
(3,3,23,33,52,46,33,36),
(3,3,24,33,54,47,34,36),
(3,3,25,34,56,48,35,37),
(3,3,26,34,57,49,35,38),
(3,3,27,35,59,51,36,39),
(3,3,28,35,61,52,37,40),
(3,3,29,36,63,53,38,40),
(3,3,30,37,64,54,39,41),
(3,3,31,37,66,55,39,42),
(3,3,32,38,68,57,40,43),
(3,3,33,38,70,58,41,44),
(3,3,34,39,71,59,42,45),
(3,3,35,40,73,60,43,46),
(3,3,36,40,75,62,43,47),
(3,3,37,41,77,63,44,47),
(3,3,38,42,79,64,45,48),
(3,3,39,42,81,65,46,49),
(3,3,40,43,83,67,47,50),
(3,3,41,44,85,68,48,51),
(3,3,42,44,87,69,49,52),
(3,3,43,45,89,71,49,53),
(3,3,44,46,91,72,50,54),
(3,3,45,46,93,73,51,55),
(3,3,46,47,95,75,52,56),
(3,3,47,48,97,76,53,57),
(3,3,48,49,99,78,54,58),
(3,3,49,49,101,79,55,59),
(3,3,50,50,103,80,56,60),
(3,3,51,51,105,82,57,61),
(3,3,52,51,107,83,58,62),
(3,3,53,52,109,85,59,63),
(3,3,54,53,111,86,60,64),
(3,3,55,54,113,88,61,65),
(3,3,56,55,115,89,62,66),
(3,3,57,55,118,91,62,67),
(3,3,58,56,120,92,63,68),
(3,3,59,57,122,94,64,70),
(3,3,60,58,124,95,65,71),
(3,3,61,58,126,97,67,72),
(3,3,62,59,129,98,68,73),
(3,3,63,60,131,100,69,74),
(3,3,64,61,133,101,70,75),
(3,3,65,62,135,103,71,76),
(3,3,66,63,138,105,72,77),
(3,3,67,63,140,106,73,78),
(3,3,68,64,142,108,74,80),
(3,3,69,65,145,109,75,81),
(3,3,70,66,147,111,76,82),
(3,3,71,67,150,113,77,83),
(3,3,72,68,153,115,78,84),
(3,3,73,69,156,117,79,86),
(3,3,74,70,159,119,81,87),
(3,3,75,71,162,121,82,89),
(3,3,76,72,165,123,83,90),
(3,3,77,73,168,125,85,92),
(3,3,78,74,171,127,86,93),
(3,3,79,75,174,129,87,95),
(3,3,80,76,177,131,89,96),
(3,4,1,23,19,24,19,19),
(3,4,2,24,20,25,19,19),
(3,4,3,24,22,25,19,20),
(3,4,4,25,23,26,19,20),
(3,4,5,26,25,27,20,20),
(3,4,6,27,26,27,20,21),
(3,4,7,28,28,28,20,21),
(3,4,8,28,29,29,20,22),
(3,4,9,29,31,30,20,22),
(3,4,10,30,32,30,20,22),
(3,4,11,31,34,31,21,23),
(3,4,12,32,36,32,21,23),
(3,4,13,33,37,33,21,24),
(3,4,14,33,39,33,21,24),
(3,4,15,34,40,34,21,25),
(3,4,16,35,42,35,22,25),
(3,4,17,36,44,36,22,25),
(3,4,18,37,45,37,22,26),
(3,4,19,38,47,38,22,26),
(3,4,20,39,49,38,22,27),
(3,4,21,40,51,39,23,27),
(3,4,22,41,52,40,23,28),
(3,4,23,42,54,41,23,28),
(3,4,24,43,56,42,23,29),
(3,4,25,44,58,43,24,29),
(3,4,26,44,59,44,24,30),
(3,4,27,45,61,44,24,30),
(3,4,28,46,63,45,24,31),
(3,4,29,47,65,46,25,31),
(3,4,30,48,67,47,25,32),
(3,4,31,49,69,48,25,32),
(3,4,32,51,71,49,25,33),
(3,4,33,52,72,50,26,33),
(3,4,34,53,74,51,26,34),
(3,4,35,54,76,52,26,34),
(3,4,36,55,78,53,26,35),
(3,4,37,56,80,54,27,35),
(3,4,38,57,82,55,27,36),
(3,4,39,58,84,56,27,37),
(3,4,40,59,86,57,28,37),
(3,4,41,60,88,58,28,38),
(3,4,42,61,90,59,28,38),
(3,4,43,63,92,60,28,39),
(3,4,44,64,95,61,29,39),
(3,4,45,65,97,62,29,40),
(3,4,46,66,99,63,29,41),
(3,4,47,67,101,64,30,41),
(3,4,48,68,103,66,30,42),
(3,4,49,70,105,67,30,43),
(3,4,50,71,107,68,31,43),
(3,4,51,72,110,69,31,44),
(3,4,52,73,112,70,31,44),
(3,4,53,74,114,71,32,45),
(3,4,54,76,116,72,32,46),
(3,4,55,77,118,73,32,46),
(3,4,56,78,121,75,33,47),
(3,4,57,80,123,76,33,48),
(3,4,58,81,125,77,33,48),
(3,4,59,82,128,78,34,49),
(3,4,60,83,130,79,34,50),
(3,4,61,85,132,81,34,51),
(3,4,62,86,135,82,35,51),
(3,4,63,87,137,83,35,52),
(3,4,64,89,139,84,36,53),
(3,4,65,90,142,86,36,53),
(3,4,66,91,144,87,36,54),
(3,4,67,93,147,88,37,55),
(3,4,68,94,149,89,37,56),
(3,4,69,96,152,91,38,56),
(3,4,70,97,154,92,38,57),
(3,4,71,99,157,93,38,58),
(3,4,72,101,160,96,39,58),
(3,4,73,102,163,97,39,59),
(3,4,74,104,166,98,40,60),
(3,4,75,106,169,100,40,61),
(3,4,76,107,172,101,40,62),
(3,4,77,109,175,103,41,63),
(3,4,78,111,179,105,41,64),
(3,4,79,113,182,106,42,65),
(3,4,80,115,185,108,42,66),
(3,5,1,22,16,23,21,22),
(3,5,2,22,16,23,22,23),
(3,5,3,22,16,24,24,25),
(3,5,4,22,17,24,25,26),
(3,5,5,23,17,24,26,27),
(3,5,6,23,17,25,28,29),
(3,5,7,23,17,25,29,30),
(3,5,8,23,18,26,30,32),
(3,5,9,23,18,26,32,33),
(3,5,10,23,18,26,33,35),
(3,5,11,24,18,27,35,36),
(3,5,12,24,19,27,36,38),
(3,5,13,24,19,28,37,39),
(3,5,14,24,19,28,39,41),
(3,5,15,24,19,28,40,42),
(3,5,16,24,20,29,42,44),
(3,5,17,25,20,29,43,45),
(3,5,18,25,20,30,45,47),
(3,5,19,25,21,30,46,49),
(3,5,20,25,21,31,48,50),
(3,5,21,25,21,31,50,52),
(3,5,22,26,22,31,51,53),
(3,5,23,26,22,32,53,55),
(3,5,24,26,22,32,54,57),
(3,5,25,26,22,33,56,58),
(3,5,26,27,23,33,58,60),
(3,5,27,27,23,34,59,62),
(3,5,28,27,23,34,61,64),
(3,5,29,27,24,35,63,65),
(3,5,30,28,24,35,64,67),
(3,5,31,28,24,36,66,69),
(3,5,32,28,25,36,68,71),
(3,5,33,28,25,37,70,72),
(3,5,34,29,26,38,71,74),
(3,5,35,29,26,38,73,76),
(3,5,36,29,26,39,75,78),
(3,5,37,29,27,39,77,80),
(3,5,38,30,27,40,78,82),
(3,5,39,30,27,40,80,84),
(3,5,40,30,28,41,82,86),
(3,5,41,31,28,41,84,88),
(3,5,42,31,29,42,86,89),
(3,5,43,31,29,43,88,91),
(3,5,44,32,29,43,90,93),
(3,5,45,32,30,44,92,95),
(3,5,46,32,30,44,93,97),
(3,5,47,32,30,45,95,99),
(3,5,48,33,31,46,97,101),
(3,5,49,33,31,46,99,103),
(3,5,50,33,32,47,101,106),
(3,5,51,34,32,48,103,108),
(3,5,52,34,33,48,105,110),
(3,5,53,35,33,49,107,112),
(3,5,54,35,33,50,109,114),
(3,5,55,35,34,50,111,116),
(3,5,56,36,34,51,113,118),
(3,5,57,36,35,52,116,120),
(3,5,58,36,35,52,118,123),
(3,5,59,37,36,53,120,125),
(3,5,60,37,36,54,122,127),
(3,5,61,37,37,54,124,129),
(3,5,62,38,37,55,126,131),
(3,5,63,38,38,56,128,134),
(3,5,64,39,38,57,131,136),
(3,5,65,39,39,57,133,138),
(3,5,66,39,39,58,135,141),
(3,5,67,40,40,59,137,143),
(3,5,68,40,40,59,139,145),
(3,5,69,41,40,60,142,148),
(3,5,70,41,41,61,144,150),
(3,5,71,41,42,62,147,153),
(3,5,72,42,42,62,150,163),
(3,5,73,42,43,63,153,166),
(3,5,74,43,43,64,155,170),
(3,5,75,43,44,65,158,173),
(3,5,76,43,45,66,161,176),
(3,5,77,44,45,67,164,179),
(3,5,78,44,46,68,167,182),
(3,5,79,45,46,69,170,184),
(3,5,80,45,47,70,173,189),
(3,6,1,25,16,25,19,19),
(3,6,2,26,17,26,19,19),
(3,6,3,28,18,27,19,20),
(3,6,4,29,18,28,19,20),
(3,6,5,30,19,30,19,20),
(3,6,6,31,20,31,19,20),
(3,6,7,33,21,32,20,21),
(3,6,8,34,22,33,20,21),
(3,6,9,36,23,35,20,21),
(3,6,10,37,23,36,20,22),
(3,6,11,38,24,37,20,22),
(3,6,12,40,25,38,20,22),
(3,6,13,41,26,40,20,23),
(3,6,14,43,27,41,20,23),
(3,6,15,44,28,42,20,23),
(3,6,16,46,29,44,21,24),
(3,6,17,47,30,45,21,24),
(3,6,18,49,31,46,21,24),
(3,6,19,50,32,48,21,25),
(3,6,20,52,33,49,21,25),
(3,6,21,53,34,51,21,26),
(3,6,22,55,34,52,21,26),
(3,6,23,56,35,53,21,26),
(3,6,24,58,36,55,22,27),
(3,6,25,59,37,56,22,27),
(3,6,26,61,38,58,22,27),
(3,6,27,63,39,59,22,28),
(3,6,28,64,41,61,22,28),
(3,6,29,66,42,62,22,29),
(3,6,30,68,43,64,23,29),
(3,6,31,69,44,65,23,30),
(3,6,32,71,45,67,23,30),
(3,6,33,73,46,68,23,30),
(3,6,34,75,47,70,23,31),
(3,6,35,76,48,72,24,31),
(3,6,36,78,49,73,24,32),
(3,6,37,80,50,75,24,32),
(3,6,38,82,51,76,24,33),
(3,6,39,84,52,78,24,33),
(3,6,40,85,54,80,24,34),
(3,6,41,87,55,81,25,34),
(3,6,42,89,56,83,25,35),
(3,6,43,91,57,85,25,35),
(3,6,44,93,58,87,25,36),
(3,6,45,95,59,88,26,36),
(3,6,46,97,61,90,26,37),
(3,6,47,99,62,92,26,37),
(3,6,48,101,63,94,26,38),
(3,6,49,102,64,95,26,38),
(3,6,50,104,65,97,27,39),
(3,6,51,106,67,99,27,39),
(3,6,52,108,68,99,27,40),
(3,6,53,109,68,101,27,40),
(3,6,54,110,69,101,28,41),
(3,6,55,110,69,102,28,41),
(3,6,56,113,71,105,28,42),
(3,6,57,118,72,107,28,42),
(3,6,58,120,73,109,29,43),
(3,6,59,123,75,111,29,43),
(3,6,60,125,76,113,29,44),
(3,6,61,126,77,115,29,45),
(3,6,62,127,79,117,29,45),
(3,6,63,129,80,120,30,46),
(3,6,64,132,82,122,30,46),
(3,6,65,135,83,124,30,47),
(3,6,66,137,85,127,30,48),
(3,6,67,144,86,129,31,48),
(3,6,68,146,88,131,31,49),
(3,6,69,149,89,133,31,50),
(3,6,70,152,91,136,31,50),
(3,6,71,154,93,139,32,51),
(3,6,72,157,94,141,32,52),
(3,6,73,160,96,144,32,53),
(3,6,74,163,98,146,32,53),
(3,6,75,166,99,150,33,54),
(3,6,76,169,101,152,33,55),
(3,6,77,172,103,155,33,56),
(3,6,78,176,104,157,33,56),
(3,6,79,179,106,160,34,57),
(3,6,80,182,108,163,34,58),
(4,1,1,20,25,21,20,20),
(4,1,2,21,26,22,20,20),
(4,1,3,23,27,23,20,21),
(4,1,4,24,27,25,20,21),
(4,1,5,25,28,26,20,21),
(4,1,6,27,29,27,20,21),
(4,1,7,28,30,28,21,22),
(4,1,8,29,31,29,21,22),
(4,1,9,31,31,31,21,22),
(4,1,10,32,32,32,21,23),
(4,1,11,33,33,33,21,23),
(4,1,12,35,34,34,21,23),
(4,1,13,36,35,36,21,24),
(4,1,14,38,36,37,21,24),
(4,1,15,39,37,38,21,24),
(4,1,16,41,37,40,21,25),
(4,1,17,42,38,41,22,25),
(4,1,18,44,39,43,22,25),
(4,1,19,45,40,44,22,26),
(4,1,20,47,41,45,22,26),
(4,1,21,48,42,47,22,26),
(4,1,22,50,43,48,22,27),
(4,1,23,52,44,50,22,27),
(4,1,24,53,45,51,23,28),
(4,1,25,55,46,52,23,28),
(4,1,26,56,47,54,23,28),
(4,1,27,58,48,55,23,29),
(4,1,28,60,49,57,23,29),
(4,1,29,61,50,58,23,30),
(4,1,30,63,51,60,24,30),
(4,1,31,65,52,62,24,30),
(4,1,32,66,53,63,24,31),
(4,1,33,68,54,65,24,31),
(4,1,34,70,55,66,24,32),
(4,1,35,72,56,68,24,32),
(4,1,36,73,58,69,25,33),
(4,1,37,75,59,71,25,33),
(4,1,38,77,60,73,25,34),
(4,1,39,79,61,74,25,34),
(4,1,40,81,62,76,25,35),
(4,1,41,82,63,78,26,35),
(4,1,42,84,64,79,26,35),
(4,1,43,86,66,81,26,36),
(4,1,44,88,67,83,26,36),
(4,1,45,90,68,85,26,37),
(4,1,46,92,69,86,27,37),
(4,1,47,94,70,88,27,38),
(4,1,48,96,72,90,27,38),
(4,1,49,98,73,92,27,39),
(4,1,50,100,74,93,28,40),
(4,1,51,102,75,95,28,40),
(4,1,52,104,77,97,28,41),
(4,1,53,106,78,99,28,41),
(4,1,54,108,79,101,29,42),
(4,1,55,110,80,103,29,42),
(4,1,56,112,82,104,29,43),
(4,1,57,114,83,106,29,43),
(4,1,58,116,84,108,30,44),
(4,1,59,118,86,110,30,44),
(4,1,60,120,87,112,30,45),
(4,1,61,122,88,114,30,46),
(4,1,62,124,90,116,31,46),
(4,1,63,127,91,118,31,47),
(4,1,64,129,92,120,31,47),
(4,1,65,131,94,122,32,48),
(4,1,66,133,95,124,32,49),
(4,1,67,135,97,126,32,49),
(4,1,68,138,98,128,32,50),
(4,1,69,140,100,130,33,50),
(4,1,70,142,101,132,33,51),
(4,1,71,145,102,134,33,52),
(4,1,72,147,104,137,33,53),
(4,1,73,150,106,139,33,54),
(4,1,74,153,107,142,34,54),
(4,1,75,156,109,144,34,55),
(4,1,76,159,111,148,34,56),
(4,1,77,162,113,150,35,57),
(4,1,78,165,114,152,35,57),
(4,1,79,178,116,164,35,58),
(4,1,80,181,118,167,36,59),
(4,3,1,17,28,20,20,21),
(4,3,2,17,29,21,21,22),
(4,3,3,18,31,22,21,22),
(4,3,4,18,32,23,22,23),
(4,3,5,19,33,24,22,24),
(4,3,6,19,35,25,23,24),
(4,3,7,20,36,26,24,25),
(4,3,8,20,38,27,24,25),
(4,3,9,21,39,27,25,26),
(4,3,10,21,40,28,25,27),
(4,3,11,22,42,29,26,28),
(4,3,12,22,43,30,27,28),
(4,3,13,23,45,31,27,29),
(4,3,14,23,46,32,28,30),
(4,3,15,24,48,34,29,30),
(4,3,16,24,50,35,29,31),
(4,3,17,25,51,36,30,32),
(4,3,18,25,53,37,31,33),
(4,3,19,26,54,38,31,33),
(4,3,20,26,56,39,32,34),
(4,3,21,27,57,40,33,35),
(4,3,22,27,59,41,33,36),
(4,3,23,28,61,42,34,36),
(4,3,24,28,62,43,35,37),
(4,3,25,29,64,44,36,38),
(4,3,26,30,66,46,36,39),
(4,3,27,30,68,47,37,40),
(4,3,28,31,69,48,38,41),
(4,3,29,31,71,49,39,41),
(4,3,30,32,73,50,39,42),
(4,3,31,33,75,52,40,43),
(4,3,32,33,76,53,41,44),
(4,3,33,34,78,54,42,45),
(4,3,34,34,80,55,43,46),
(4,3,35,35,82,57,44,47),
(4,3,36,36,84,58,44,48),
(4,3,37,36,86,59,45,48),
(4,3,38,37,87,60,46,49),
(4,3,39,38,89,62,47,50),
(4,3,40,38,91,63,48,51),
(4,3,41,39,93,64,49,52),
(4,3,42,40,95,66,49,53),
(4,3,43,40,97,67,50,54),
(4,3,44,41,99,68,51,55),
(4,3,45,42,101,70,52,56),
(4,3,46,42,103,71,53,57),
(4,3,47,43,105,72,54,58),
(4,3,48,44,107,74,55,59),
(4,3,49,45,109,75,56,60),
(4,3,50,45,111,77,57,61),
(4,3,51,46,113,78,58,62),
(4,3,52,47,115,79,59,63),
(4,3,53,47,118,81,60,64),
(4,3,54,48,120,82,61,65),
(4,3,55,49,122,84,61,66),
(4,3,56,50,124,85,62,67),
(4,3,57,50,126,87,63,68),
(4,3,58,51,128,88,64,69),
(4,3,59,52,131,90,65,70),
(4,3,60,53,133,91,66,72),
(4,3,61,54,135,93,67,73),
(4,3,62,54,137,94,69,74),
(4,3,63,55,140,96,70,75),
(4,3,64,56,142,97,71,76),
(4,3,65,57,144,99,72,77),
(4,3,66,58,147,101,73,78),
(4,3,67,58,149,102,74,79),
(4,3,68,59,151,104,75,81),
(4,3,69,60,154,105,76,82),
(4,3,70,61,156,107,77,83),
(4,3,71,62,159,109,78,84),
(4,3,72,63,162,111,79,85),
(4,3,73,64,165,113,80,87),
(4,3,74,65,168,115,82,88),
(4,3,75,66,171,117,83,90),
(4,3,76,67,174,119,84,91),
(4,3,77,68,177,121,86,93),
(4,3,78,69,180,123,87,94),
(4,3,79,70,190,125,91,96),
(4,3,80,71,193,127,93,97),
(4,4,1,18,28,20,20,20),
(4,4,2,19,29,21,20,20),
(4,4,3,20,31,21,20,21),
(4,4,4,20,32,22,20,21),
(4,4,5,21,34,23,21,21),
(4,4,6,22,35,24,21,22),
(4,4,7,23,37,24,21,22),
(4,4,8,24,38,25,21,23),
(4,4,9,24,40,26,21,23),
(4,4,10,25,41,26,21,23),
(4,4,11,26,43,27,22,24),
(4,4,12,27,44,28,22,24),
(4,4,13,28,46,29,22,25),
(4,4,14,29,48,30,22,25),
(4,4,15,29,49,30,22,25),
(4,4,16,30,51,31,23,26),
(4,4,17,31,52,32,23,26),
(4,4,18,32,54,33,23,27),
(4,4,19,33,56,34,23,27),
(4,4,20,34,57,35,23,28),
(4,4,21,35,59,35,24,28),
(4,4,22,36,61,36,24,29),
(4,4,23,37,63,37,24,29),
(4,4,24,38,64,38,24,30),
(4,4,25,39,66,39,25,30),
(4,4,26,40,68,40,25,31),
(4,4,27,41,70,41,25,31),
(4,4,28,42,72,42,25,32),
(4,4,29,43,73,43,25,32),
(4,4,30,44,75,43,26,33),
(4,4,31,45,77,44,26,33),
(4,4,32,46,79,45,26,34),
(4,4,33,47,81,46,27,34),
(4,4,34,48,83,47,27,35),
(4,4,35,49,85,48,27,35),
(4,4,36,50,87,49,27,36),
(4,4,37,51,89,50,28,36),
(4,4,38,52,91,51,28,37),
(4,4,39,53,93,52,28,38),
(4,4,40,54,95,53,28,38),
(4,4,41,56,97,54,29,39),
(4,4,42,57,99,55,29,39),
(4,4,43,58,101,56,29,40),
(4,4,44,59,103,57,30,40),
(4,4,45,60,105,59,30,41),
(4,4,46,61,107,60,30,42),
(4,4,47,62,109,61,31,42),
(4,4,48,64,112,62,31,43),
(4,4,49,65,114,63,31,44),
(4,4,50,66,116,64,32,44),
(4,4,51,67,118,65,32,45),
(4,4,52,68,120,66,32,45),
(4,4,53,70,123,67,33,46),
(4,4,54,71,125,69,33,47),
(4,4,55,72,127,70,33,47),
(4,4,56,73,129,71,34,48),
(4,4,57,75,132,72,34,49),
(4,4,58,76,134,73,34,49),
(4,4,59,77,136,74,35,50),
(4,4,60,79,139,76,35,51),
(4,4,61,80,141,77,35,51),
(4,4,62,81,143,78,36,52),
(4,4,63,82,146,79,36,53),
(4,4,64,84,148,80,37,54),
(4,4,65,85,151,82,37,54),
(4,4,66,87,153,83,37,55),
(4,4,67,88,156,84,38,56),
(4,4,68,89,158,85,38,57),
(4,4,69,91,160,87,39,57),
(4,4,70,92,163,88,39,58),
(4,4,71,94,166,90,39,59),
(4,4,72,96,169,91,40,59),
(4,4,73,97,172,93,40,60),
(4,4,74,99,175,94,41,61),
(4,4,75,101,178,96,41,62),
(4,4,76,102,181,97,41,63),
(4,4,77,104,184,99,42,64),
(4,4,78,106,188,101,42,65),
(4,4,79,108,191,102,43,66),
(4,4,80,110,194,104,43,67),
(4,5,1,17,25,19,22,23),
(4,5,2,17,25,19,23,24),
(4,5,3,17,25,20,25,26),
(4,5,4,17,26,20,26,27),
(4,5,5,18,26,20,27,28),
(4,5,6,18,26,21,29,30),
(4,5,7,18,26,21,30,31),
(4,5,8,18,26,22,31,33),
(4,5,9,18,27,22,33,34),
(4,5,10,19,27,22,34,36),
(4,5,11,19,27,23,36,37),
(4,5,12,19,27,23,37,39),
(4,5,13,19,28,24,38,40),
(4,5,14,19,28,24,40,42),
(4,5,15,19,28,25,41,43),
(4,5,16,20,28,25,43,45),
(4,5,17,20,29,25,44,46),
(4,5,18,20,29,26,46,48),
(4,5,19,20,29,26,47,49),
(4,5,20,21,30,27,49,51),
(4,5,21,21,30,27,51,53),
(4,5,22,21,30,28,52,54),
(4,5,23,21,30,28,54,56),
(4,5,24,21,31,29,55,58),
(4,5,25,22,31,29,57,59),
(4,5,26,22,31,30,59,61),
(4,5,27,22,32,30,60,63),
(4,5,28,22,32,31,62,65),
(4,5,29,23,32,31,64,66),
(4,5,30,23,33,32,65,68),
(4,5,31,23,33,32,67,70),
(4,5,32,23,33,33,69,72),
(4,5,33,24,34,33,70,73),
(4,5,34,24,34,34,72,75),
(4,5,35,24,34,34,74,77),
(4,5,36,24,35,35,76,79),
(4,5,37,25,35,35,78,81),
(4,5,38,25,35,36,79,83),
(4,5,39,25,36,37,81,85),
(4,5,40,26,36,37,83,87),
(4,5,41,26,37,38,85,88),
(4,5,42,26,37,38,87,90),
(4,5,43,27,37,39,89,92),
(4,5,44,27,38,39,91,94),
(4,5,45,27,38,40,92,96),
(4,5,46,27,39,41,94,98),
(4,5,47,28,39,41,96,100),
(4,5,48,28,39,42,98,102),
(4,5,49,28,40,43,100,104),
(4,5,50,29,40,43,102,106),
(4,5,51,29,41,44,104,109),
(4,5,52,29,41,44,106,111),
(4,5,53,30,42,45,108,113),
(4,5,54,30,42,46,110,115),
(4,5,55,30,43,46,112,117),
(4,5,56,31,43,47,114,119),
(4,5,57,31,43,48,117,121),
(4,5,58,31,44,48,119,124),
(4,5,59,32,44,49,121,126),
(4,5,60,32,45,50,123,128),
(4,5,61,33,45,51,125,130),
(4,5,62,33,46,51,127,132),
(4,5,63,33,46,52,129,135),
(4,5,64,34,47,53,132,137),
(4,5,65,34,47,53,134,139),
(4,5,66,34,48,54,136,142),
(4,5,67,35,48,55,138,144),
(4,5,68,35,49,56,140,146),
(4,5,69,36,49,56,143,149),
(4,5,70,36,50,57,145,151),
(4,5,71,36,51,58,148,161),
(4,5,72,37,51,58,151,164),
(4,5,73,37,52,59,154,168),
(4,5,74,38,52,60,156,171),
(4,5,75,38,53,61,159,174),
(4,5,76,38,54,62,162,177),
(4,5,77,39,54,63,165,180),
(4,5,78,39,55,64,168,183),
(4,5,79,40,55,65,171,186),
(4,5,80,40,56,66,200,191),
(4,6,1,20,25,21,20,20),
(4,6,2,21,26,22,20,20),
(4,6,3,23,27,23,20,21),
(4,6,4,24,27,25,20,21),
(4,6,5,25,28,26,20,21),
(4,6,6,27,29,27,20,21),
(4,6,7,28,30,28,21,22),
(4,6,8,29,31,29,21,22),
(4,6,9,31,31,31,21,22),
(4,6,10,32,32,32,21,23),
(4,6,11,33,33,33,21,23),
(4,6,12,35,34,34,21,23),
(4,6,13,36,35,36,21,24),
(4,6,14,38,36,37,21,24),
(4,6,15,39,37,38,21,24),
(4,6,16,41,37,40,21,25),
(4,6,17,42,38,41,22,25),
(4,6,18,44,39,43,22,25),
(4,6,19,45,40,44,22,26),
(4,6,20,47,41,45,22,26),
(4,6,21,48,42,47,22,26),
(4,6,22,50,43,48,22,27),
(4,6,23,52,44,50,22,27),
(4,6,24,53,45,51,23,28),
(4,6,25,55,46,52,23,28),
(4,6,26,56,47,54,23,28),
(4,6,27,58,48,55,23,29),
(4,6,28,60,49,57,23,29),
(4,6,29,61,50,58,23,30),
(4,6,30,63,51,60,24,30),
(4,6,31,65,52,62,24,30),
(4,6,32,66,53,63,24,31),
(4,6,33,68,54,65,24,31),
(4,6,34,70,55,66,24,32),
(4,6,35,72,56,68,24,32),
(4,6,36,73,58,69,25,33),
(4,6,37,75,59,71,25,33),
(4,6,38,77,60,73,25,34),
(4,6,39,79,61,74,25,34),
(4,6,40,81,62,76,25,35),
(4,6,41,82,63,78,26,35),
(4,6,42,84,64,79,26,35),
(4,6,43,86,66,81,26,36),
(4,6,44,88,67,83,26,36),
(4,6,45,90,68,85,26,37),
(4,6,46,92,69,86,27,37),
(4,6,47,94,70,88,27,38),
(4,6,48,96,72,90,27,38),
(4,6,49,98,73,92,27,39),
(4,6,50,100,74,93,28,40),
(4,6,51,101,75,94,28,40),
(4,6,52,102,76,95,28,41),
(4,6,53,103,77,96,28,41),
(4,6,54,104,77,97,29,42),
(4,6,55,105,78,98,29,42),
(4,6,56,108,80,101,29,43),
(4,6,57,113,81,103,29,43),
(4,6,58,115,82,105,30,44),
(4,6,59,115,84,107,30,44),
(4,6,60,120,85,109,30,45),
(4,6,61,122,86,111,30,46),
(4,6,62,122,88,113,30,46),
(4,6,63,127,89,116,31,47),
(4,6,64,127,91,118,31,47),
(4,6,65,133,92,120,31,48),
(4,6,66,135,94,123,31,49),
(4,6,67,136,95,125,32,49),
(4,6,68,137,97,127,32,50),
(4,6,69,140,98,130,32,51),
(4,6,70,147,100,132,32,51),
(4,6,71,154,102,135,33,52),
(4,6,72,156,103,137,33,53),
(4,6,73,157,105,140,33,54),
(4,6,74,158,107,142,33,54),
(4,6,75,161,108,145,34,55),
(4,6,76,164,110,148,34,56),
(4,6,77,167,112,150,34,57),
(4,6,78,170,113,153,34,57),
(4,6,79,172,115,156,35,58),
(4,6,80,177,117,159,35,59),
(4,11,1,18,25,19,22,22),
(4,11,2,19,25,20,23,23),
(4,11,3,19,26,20,24,24),
(4,11,4,20,26,21,25,26),
(4,11,5,20,27,22,26,27),
(4,11,6,21,27,22,27,28),
(4,11,7,21,28,23,28,29),
(4,11,8,22,28,24,29,30),
(4,11,9,23,29,24,30,32),
(4,11,10,23,29,25,32,33),
(4,11,11,24,30,26,33,34),
(4,11,12,24,31,26,34,35),
(4,11,13,25,31,27,35,37),
(4,11,14,26,32,28,36,38),
(4,11,15,26,32,29,37,39),
(4,11,16,27,33,29,38,41),
(4,11,17,28,33,30,40,42),
(4,11,18,28,34,31,41,43),
(4,11,19,29,35,32,42,45),
(4,11,20,30,35,32,43,46),
(4,11,21,30,36,33,45,48),
(4,11,22,31,36,34,46,49),
(4,11,23,32,37,35,47,51),
(4,11,24,32,38,36,48,52),
(4,11,25,33,38,36,50,53),
(4,11,26,34,39,37,51,55),
(4,11,27,35,40,38,52,56),
(4,11,28,35,40,39,54,58),
(4,11,29,36,41,40,55,59),
(4,11,30,37,42,41,56,61),
(4,11,31,38,42,42,58,62),
(4,11,32,38,43,42,59,64),
(4,11,33,39,44,43,60,66),
(4,11,34,40,44,44,62,67),
(4,11,35,41,45,45,63,69),
(4,11,36,42,46,46,65,70),
(4,11,37,42,47,47,66,72),
(4,11,38,43,47,48,67,74),
(4,11,39,44,48,49,69,75),
(4,11,40,45,49,50,70,77),
(4,11,41,46,50,51,72,79),
(4,11,42,46,50,52,73,80),
(4,11,43,47,51,53,75,82),
(4,11,44,48,52,54,76,84),
(4,11,45,49,53,55,78,85),
(4,11,46,50,54,56,79,87),
(4,11,47,51,54,57,81,89),
(4,11,48,52,55,58,83,91),
(4,11,49,53,56,59,84,93),
(4,11,50,53,57,60,86,94),
(4,11,51,54,58,61,87,96),
(4,11,52,55,59,62,89,98),
(4,11,53,56,59,63,91,100),
(4,11,54,57,60,64,92,102),
(4,11,55,58,61,65,94,103),
(4,11,56,59,62,66,95,105),
(4,11,57,60,63,67,97,107),
(4,11,58,61,64,68,99,109),
(4,11,59,62,65,69,101,111),
(4,11,60,63,66,70,102,113),
(4,11,61,64,66,72,104,115),
(4,11,62,65,67,73,106,117),
(4,11,63,66,68,74,107,119),
(4,11,64,67,69,75,109,121),
(4,11,65,68,70,76,111,123),
(4,11,66,69,71,77,113,125),
(4,11,67,70,72,78,115,127),
(4,11,68,71,73,80,116,129),
(4,11,69,72,74,81,118,131),
(4,11,70,73,75,82,120,133),
(4,11,71,75,76,83,122,135),
(4,11,72,76,78,85,125,138),
(4,11,73,77,79,86,127,140),
(4,11,74,78,80,88,131,143),
(4,11,75,80,81,89,133,145),
(4,11,76,81,82,91,134,148),
(4,11,77,82,83,92,136,151),
(4,11,78,84,85,94,138,153),
(4,11,79,85,86,95,141,156),
(4,11,80,86,87,97,143,159),
(5,1,1,22,18,23,18,25),
(5,1,2,23,19,24,18,25),
(5,1,3,25,20,25,18,26),
(5,1,4,26,20,26,18,26),
(5,1,5,27,21,28,18,26),
(5,1,6,29,22,29,18,26),
(5,1,7,30,23,30,19,27),
(5,1,8,31,24,31,19,27),
(5,1,9,33,25,33,19,27),
(5,1,10,34,25,34,19,28),
(5,1,11,35,26,35,19,28),
(5,1,12,37,27,36,19,28),
(5,1,13,38,28,38,19,28),
(5,1,14,40,29,39,19,29),
(5,1,15,41,30,40,19,29),
(5,1,16,43,31,42,20,29),
(5,1,17,44,32,43,20,30),
(5,1,18,46,33,44,20,30),
(5,1,19,47,34,46,20,31),
(5,1,20,49,34,47,20,31),
(5,1,21,50,35,49,20,31),
(5,1,22,52,36,50,20,32),
(5,1,23,53,37,51,21,32),
(5,1,24,55,38,53,21,32),
(5,1,25,57,39,54,21,33),
(5,1,26,58,40,56,21,33),
(5,1,27,60,41,57,21,34),
(5,1,28,62,42,59,21,34),
(5,1,29,63,43,60,21,34),
(5,1,30,65,44,62,22,35),
(5,1,31,67,46,63,22,35),
(5,1,32,68,47,65,22,36),
(5,1,33,70,48,67,22,36),
(5,1,34,72,49,68,22,36),
(5,1,35,74,50,70,23,37),
(5,1,36,75,51,71,23,37),
(5,1,37,77,52,73,23,38),
(5,1,38,79,53,75,23,38),
(5,1,39,81,54,76,23,39),
(5,1,40,83,55,78,24,39),
(5,1,41,84,57,80,24,40),
(5,1,42,86,58,81,24,40),
(5,1,43,88,59,83,24,41),
(5,1,44,90,60,85,24,41),
(5,1,45,92,61,86,25,42),
(5,1,46,94,62,88,25,42),
(5,1,47,96,64,90,25,43),
(5,1,48,98,65,92,25,43),
(5,1,49,100,66,93,25,44),
(5,1,50,102,67,95,26,44),
(5,1,51,104,69,97,26,45),
(5,1,52,106,70,99,26,45),
(5,1,53,108,71,101,26,46),
(5,1,54,110,72,103,27,46),
(5,1,55,112,74,104,27,47),
(5,1,56,114,75,106,27,48),
(5,1,57,116,76,108,27,48),
(5,1,58,118,78,110,28,49),
(5,1,59,120,79,112,28,49),
(5,1,60,122,80,114,28,50),
(5,1,61,124,82,116,28,50),
(5,1,62,126,83,118,29,51),
(5,1,63,128,84,120,29,52),
(5,1,64,131,86,122,29,52),
(5,1,65,133,87,124,30,53),
(5,1,66,135,88,126,30,53),
(5,1,67,137,90,128,30,54),
(5,1,68,139,91,130,30,55),
(5,1,69,142,93,132,31,55),
(5,1,70,144,94,134,31,56),
(5,1,71,147,95,136,31,57),
(5,1,72,150,97,139,31,58),
(5,1,73,152,99,141,31,59),
(5,1,74,155,100,144,32,59),
(5,1,75,158,102,146,32,60),
(5,1,76,163,104,149,32,61),
(5,1,77,167,106,152,33,62),
(5,1,78,167,107,154,33,62),
(5,1,79,170,109,157,33,63),
(5,1,80,173,111,160,34,64),
(5,4,1,20,21,22,18,25),
(5,4,2,21,22,23,18,25),
(5,4,3,22,24,23,18,26),
(5,4,4,22,25,24,18,26),
(5,4,5,23,27,25,19,26),
(5,4,6,24,28,25,19,27),
(5,4,7,25,30,26,19,27),
(5,4,8,25,31,27,19,27),
(5,4,9,26,33,28,19,28),
(5,4,10,27,34,28,19,28),
(5,4,11,28,36,29,20,29),
(5,4,12,29,38,30,20,29),
(5,4,13,30,39,31,20,29),
(5,4,14,31,41,32,20,30),
(5,4,15,31,42,32,20,30),
(5,4,16,32,44,33,21,31),
(5,4,17,33,46,34,21,31),
(5,4,18,34,47,35,21,32),
(5,4,19,35,49,36,21,32),
(5,4,20,36,51,36,21,32),
(5,4,21,37,52,37,22,33),
(5,4,22,38,54,38,22,33),
(5,4,23,39,56,39,22,34),
(5,4,24,40,58,40,22,34),
(5,4,25,41,60,41,23,35),
(5,4,26,42,61,42,23,35),
(5,4,27,43,63,43,23,36),
(5,4,28,44,65,44,23,36),
(5,4,29,45,67,44,24,37),
(5,4,30,46,69,45,24,37),
(5,4,31,47,71,46,24,38),
(5,4,32,48,72,47,24,38),
(5,4,33,49,74,48,25,39),
(5,4,34,50,76,49,25,39),
(5,4,35,51,78,50,25,40),
(5,4,36,52,80,51,25,41),
(5,4,37,53,82,52,26,41),
(5,4,38,54,84,53,26,42),
(5,4,39,55,86,54,26,42),
(5,4,40,56,88,55,27,43),
(5,4,41,57,90,56,27,43),
(5,4,42,59,92,57,27,44),
(5,4,43,60,94,58,27,45),
(5,4,44,61,96,59,28,45),
(5,4,45,62,99,60,28,46),
(5,4,46,63,101,61,28,46),
(5,4,47,64,103,63,29,47),
(5,4,48,66,105,64,29,48),
(5,4,49,67,107,65,29,48),
(5,4,50,68,109,66,30,49),
(5,4,51,69,111,67,30,50),
(5,4,52,70,114,68,30,50),
(5,4,53,72,116,69,31,51),
(5,4,54,73,118,70,31,52),
(5,4,55,74,120,72,31,52),
(5,4,56,75,123,73,32,53),
(5,4,57,77,125,74,32,54),
(5,4,58,78,127,75,32,54),
(5,4,59,79,130,76,33,55),
(5,4,60,81,132,77,33,56),
(5,4,61,82,134,79,34,56),
(5,4,62,83,137,80,34,57),
(5,4,63,84,139,81,34,58),
(5,4,64,86,141,82,35,59),
(5,4,65,87,144,84,35,59),
(5,4,66,88,146,85,35,60),
(5,4,67,90,149,86,36,61),
(5,4,68,91,151,87,36,61),
(5,4,69,93,154,89,37,62),
(5,4,70,94,156,90,37,63),
(5,4,71,96,159,91,37,64),
(5,4,72,98,162,93,38,64),
(5,4,73,99,165,95,38,65),
(5,4,74,101,168,96,39,66),
(5,4,75,103,171,98,39,67),
(5,4,76,104,174,99,39,68),
(5,4,77,106,177,101,40,69),
(5,4,78,108,181,103,40,70),
(5,4,79,110,184,104,41,71),
(5,4,80,112,187,106,41,72),
(5,5,1,19,18,21,20,28),
(5,5,2,19,18,21,21,29),
(5,5,3,19,18,22,23,31),
(5,5,4,19,19,22,24,32),
(5,5,5,20,19,22,25,33),
(5,5,6,20,19,23,27,35),
(5,5,7,20,19,23,28,36),
(5,5,8,20,20,24,29,38),
(5,5,9,20,20,24,31,39),
(5,5,10,20,20,24,32,40),
(5,5,11,21,20,25,34,42),
(5,5,12,21,21,25,35,43),
(5,5,13,21,21,26,37,45),
(5,5,14,21,21,26,38,46),
(5,5,15,21,21,26,39,48),
(5,5,16,22,22,27,41,50),
(5,5,17,22,22,27,42,51),
(5,5,18,22,22,28,44,53),
(5,5,19,22,23,28,46,54),
(5,5,20,22,23,29,47,56),
(5,5,21,23,23,29,49,57),
(5,5,22,23,23,30,50,59),
(5,5,23,23,24,30,52,61),
(5,5,24,23,24,31,53,62),
(5,5,25,24,24,31,55,64),
(5,5,26,24,25,32,57,66),
(5,5,27,24,25,32,58,68),
(5,5,28,24,25,33,60,69),
(5,5,29,25,26,33,62,71),
(5,5,30,25,26,34,63,73),
(5,5,31,25,26,34,65,75),
(5,5,32,25,27,35,67,76),
(5,5,33,26,27,35,69,78),
(5,5,34,26,27,36,70,80),
(5,5,35,26,28,36,72,82),
(5,5,36,26,28,37,74,84),
(5,5,37,27,28,37,76,86),
(5,5,38,27,29,38,77,87),
(5,5,39,27,29,38,79,89),
(5,5,40,28,30,39,81,91),
(5,5,41,28,30,40,83,93),
(5,5,42,28,30,40,85,95),
(5,5,43,28,31,41,87,97),
(5,5,44,29,31,41,89,99),
(5,5,45,29,32,42,91,101),
(5,5,46,29,32,43,92,103),
(5,5,47,30,32,43,94,105),
(5,5,48,30,33,44,96,107),
(5,5,49,30,33,44,98,109),
(5,5,50,31,34,45,100,111),
(5,5,51,31,34,46,102,113),
(5,5,52,31,35,46,104,115),
(5,5,53,32,35,47,106,118),
(5,5,54,32,35,48,108,120),
(5,5,55,32,36,48,110,122),
(5,5,56,33,36,49,113,124),
(5,5,57,33,37,50,115,126),
(5,5,58,33,37,50,117,128),
(5,5,59,34,38,51,119,131),
(5,5,60,34,38,52,121,133),
(5,5,61,34,39,52,123,135),
(5,5,62,35,39,53,125,137),
(5,5,63,35,40,54,127,140),
(5,5,64,36,40,55,130,142),
(5,5,65,36,41,55,132,144),
(5,5,66,36,41,56,134,147),
(5,5,67,37,41,57,136,149),
(5,5,68,37,42,58,138,151),
(5,5,69,38,42,58,141,154),
(5,5,70,38,43,59,143,156),
(5,5,71,38,44,60,146,159),
(5,5,72,39,44,60,149,162),
(5,5,73,39,45,61,152,165),
(5,5,74,40,45,62,157,168),
(5,5,75,40,46,63,157,171),
(5,5,76,40,47,64,160,174),
(5,5,77,41,47,65,163,177),
(5,5,78,41,48,66,166,180),
(5,5,79,42,48,67,169,183),
(5,5,80,42,49,68,172,186),
(5,6,1,22,18,23,18,25),
(5,6,2,23,19,24,18,25),
(5,6,3,25,20,25,18,26),
(5,6,4,26,20,26,18,26),
(5,6,5,27,21,28,18,26),
(5,6,6,29,22,29,18,26),
(5,6,7,30,23,30,19,27),
(5,6,8,31,24,31,19,27),
(5,6,9,33,25,33,19,27),
(5,6,10,34,25,34,19,28),
(5,6,11,35,26,35,19,28),
(5,6,12,37,27,36,19,28),
(5,6,13,38,28,38,19,28),
(5,6,14,40,29,39,19,29),
(5,6,15,41,30,40,19,29),
(5,6,16,43,31,42,20,29),
(5,6,17,44,32,43,20,30),
(5,6,18,46,33,44,20,30),
(5,6,19,47,34,46,20,31),
(5,6,20,49,34,47,20,31),
(5,6,21,50,35,49,20,31),
(5,6,22,52,36,50,20,32),
(5,6,23,53,37,51,21,32),
(5,6,24,55,38,53,21,32),
(5,6,25,57,39,54,21,33),
(5,6,26,58,40,56,21,33),
(5,6,27,60,41,57,21,34),
(5,6,28,62,42,59,21,34),
(5,6,29,63,43,60,21,34),
(5,6,30,65,44,62,22,35),
(5,6,31,67,46,63,22,35),
(5,6,32,68,47,65,22,36),
(5,6,33,70,48,67,22,36),
(5,6,34,72,49,68,22,36),
(5,6,35,74,50,70,23,37),
(5,6,36,75,51,71,23,37),
(5,6,37,77,52,73,23,38),
(5,6,38,79,53,75,23,38),
(5,6,39,81,54,76,23,39),
(5,6,40,83,55,78,24,39),
(5,6,41,84,57,80,24,40),
(5,6,42,86,58,81,24,40),
(5,6,43,88,59,83,24,41),
(5,6,44,90,60,85,24,41),
(5,6,45,92,61,86,25,42),
(5,6,46,94,62,88,25,42),
(5,6,47,96,64,90,25,43),
(5,6,48,98,65,92,25,43),
(5,6,49,100,66,93,25,44),
(5,6,50,102,67,95,26,44),
(5,6,51,103,67,96,26,45),
(5,6,52,104,68,97,26,45),
(5,6,53,105,69,98,26,46),
(5,6,54,106,70,99,27,46),
(5,6,55,107,71,100,27,47),
(5,6,56,110,73,103,27,48),
(5,6,57,112,74,105,27,48),
(5,6,58,114,75,107,28,49),
(5,6,59,119,77,109,28,49),
(5,6,60,122,78,111,28,50),
(5,6,61,124,79,113,28,51),
(5,6,62,127,81,115,28,51),
(5,6,63,129,82,118,29,52),
(5,6,64,136,84,120,29,52),
(5,6,65,137,85,123,29,53),
(5,6,66,138,87,125,29,54),
(5,6,67,141,88,127,30,54),
(5,6,68,143,90,129,30,55),
(5,6,69,146,91,132,30,56),
(5,6,70,149,93,134,30,56),
(5,6,71,152,95,137,31,57),
(5,6,72,154,96,139,31,58),
(5,6,73,157,98,142,31,59),
(5,6,74,158,100,145,31,59),
(5,6,75,159,101,147,32,60),
(5,6,76,162,103,150,32,61),
(5,6,77,167,105,152,32,62),
(5,6,78,173,106,155,32,62),
(5,6,79,174,108,158,33,63),
(5,6,80,174,110,161,33,64),
(5,8,1,19,18,21,21,27),
(5,8,2,19,18,21,22,28),
(5,8,3,19,18,22,24,30),
(5,8,4,19,18,22,25,31),
(5,8,5,19,19,22,26,32),
(5,8,6,19,19,22,28,34),
(5,8,7,20,19,23,29,35),
(5,8,8,20,19,23,31,36),
(5,8,9,20,19,23,32,38),
(5,8,10,20,19,24,34,39),
(5,8,11,20,20,24,35,40),
(5,8,12,20,20,24,37,42),
(5,8,13,20,20,25,38,43),
(5,8,14,20,20,25,40,45),
(5,8,15,20,20,25,41,46),
(5,8,16,21,21,26,43,48),
(5,8,17,21,21,26,44,49),
(5,8,18,21,21,26,46,51),
(5,8,19,21,21,27,48,52),
(5,8,20,21,21,27,49,54),
(5,8,21,21,22,27,51,55),
(5,8,22,21,22,28,52,57),
(5,8,23,21,22,28,54,58),
(5,8,24,22,22,29,56,60),
(5,8,25,22,23,29,57,62),
(5,8,26,22,23,29,59,63),
(5,8,27,22,23,30,61,65),
(5,8,28,22,23,30,63,67),
(5,8,29,22,24,31,64,68),
(5,8,30,23,24,31,66,70),
(5,8,31,23,24,31,68,72),
(5,8,32,23,24,32,70,73),
(5,8,33,23,25,32,72,75),
(5,8,34,23,25,33,73,77),
(5,8,35,24,25,33,75,79),
(5,8,36,24,25,34,77,80),
(5,8,37,24,26,34,79,82),
(5,8,38,24,26,35,81,84),
(5,8,39,24,26,35,83,86),
(5,8,40,24,27,35,85,88),
(5,8,41,25,27,36,87,90),
(5,8,42,25,27,36,89,91),
(5,8,43,25,27,37,90,93),
(5,8,44,25,28,37,92,95),
(5,8,45,26,28,38,94,97),
(5,8,46,26,28,38,96,99),
(5,8,47,26,29,39,98,101),
(5,8,48,26,29,39,100,103),
(5,8,49,26,29,40,103,105),
(5,8,50,27,30,40,105,107),
(5,8,51,27,30,41,107,109),
(5,8,52,27,30,42,109,111),
(5,8,53,27,31,42,111,113),
(5,8,54,28,31,43,113,115),
(5,8,55,28,31,43,115,117),
(5,8,56,28,32,44,117,119),
(5,8,57,28,32,44,119,121),
(5,8,58,29,32,45,122,123),
(5,8,59,29,33,45,124,126),
(5,8,60,29,33,46,126,128),
(5,8,61,29,34,47,128,130),
(5,8,62,30,34,47,131,132),
(5,8,63,30,34,48,133,134),
(5,8,64,30,35,48,135,136),
(5,8,65,31,35,49,137,139),
(5,8,66,31,35,50,140,141),
(5,8,67,31,36,50,142,143),
(5,8,68,31,36,51,144,145),
(5,8,69,32,37,51,147,148),
(5,8,70,32,37,52,149,150),
(5,8,71,32,37,53,152,153),
(5,8,72,32,38,54,155,156),
(5,8,73,32,38,55,158,159),
(5,8,74,33,39,55,161,161),
(5,8,75,33,39,56,164,164),
(5,8,76,33,39,57,167,167),
(5,8,77,34,40,58,170,170),
(5,8,78,34,40,58,173,173),
(5,8,79,34,41,59,176,176),
(5,8,80,35,41,60,179,179),
(5,9,1,19,18,22,20,27),
(5,9,2,19,18,23,21,28),
(5,9,3,20,19,23,22,29),
(5,9,4,20,19,24,24,30),
(5,9,5,20,19,24,25,32),
(5,9,6,20,20,25,26,33),
(5,9,7,21,20,25,27,34),
(5,9,8,21,21,26,28,35),
(5,9,9,21,21,26,30,36),
(5,9,10,22,21,27,31,38),
(5,9,11,22,22,28,32,39),
(5,9,12,22,22,28,34,40),
(5,9,13,23,23,29,35,41),
(5,9,14,23,23,30,36,43),
(5,9,15,23,24,30,37,44),
(5,9,16,24,24,31,39,45),
(5,9,17,24,24,31,40,47),
(5,9,18,24,25,32,42,48),
(5,9,19,25,25,33,43,49),
(5,9,20,25,26,33,44,51),
(5,9,21,26,26,34,46,52),
(5,9,22,26,27,35,47,53),
(5,9,23,26,27,36,49,55),
(5,9,24,27,28,36,50,56),
(5,9,25,27,28,37,52,58),
(5,9,26,27,29,38,53,59),
(5,9,27,28,29,38,55,60),
(5,9,28,28,30,39,56,62),
(5,9,29,29,30,40,58,63),
(5,9,30,29,31,41,59,65),
(5,9,31,30,31,41,61,66),
(5,9,32,30,32,42,62,68),
(5,9,33,30,32,43,64,69),
(5,9,34,31,33,44,65,71),
(5,9,35,31,33,45,67,73),
(5,9,36,32,34,45,69,74),
(5,9,37,32,34,46,70,76),
(5,9,38,33,35,47,72,77),
(5,9,39,33,36,48,73,79),
(5,9,40,34,36,49,75,81),
(5,9,41,34,37,49,77,82),
(5,9,42,35,37,50,78,84),
(5,9,43,35,38,51,80,86),
(5,9,44,36,39,52,82,87),
(5,9,45,36,39,53,84,89),
(5,9,46,37,40,54,85,91),
(5,9,47,37,40,55,87,92),
(5,9,48,38,41,55,89,94),
(5,9,49,38,42,56,91,96),
(5,9,50,39,42,57,92,98),
(5,9,51,39,43,58,94,100),
(5,9,52,40,44,59,96,101),
(5,9,53,40,44,60,98,103),
(5,9,54,41,45,61,100,105),
(5,9,55,41,45,62,102,107),
(5,9,56,42,46,63,103,109),
(5,9,57,42,47,64,105,111),
(5,9,58,43,47,65,107,112),
(5,9,59,43,48,66,109,114),
(5,9,60,44,49,67,111,116),
(5,9,61,45,50,68,113,118),
(5,9,62,45,50,69,115,120),
(5,9,63,46,51,70,117,122),
(5,9,64,46,52,71,119,124),
(5,9,65,47,52,72,121,126),
(5,9,66,48,53,73,123,128),
(5,9,67,48,54,74,125,130),
(5,9,68,49,55,75,127,132),
(5,9,69,49,55,76,129,134),
(5,9,70,50,56,77,131,136),
(5,9,71,51,57,86,135,147),
(5,9,72,52,57,88,136,149),
(5,9,73,53,58,89,138,152),
(5,9,74,53,59,90,141,155),
(5,9,75,54,60,92,143,157),
(5,9,76,55,61,93,146,160),
(5,9,77,56,62,94,149,163),
(5,9,78,56,63,96,151,166),
(5,9,79,57,64,97,154,169),
(5,9,80,58,65,99,157,171),
(6,1,1,28,15,24,15,22),
(6,1,2,29,16,25,15,22),
(6,1,3,31,17,26,15,23),
(6,1,4,32,17,27,15,23),
(6,1,5,33,18,29,15,23),
(6,1,6,34,19,30,15,23),
(6,1,7,36,20,31,16,24),
(6,1,8,37,21,32,16,24),
(6,1,9,38,22,34,16,24),
(6,1,10,40,22,35,16,25),
(6,1,11,41,23,36,16,25),
(6,1,12,43,24,37,16,25),
(6,1,13,44,25,39,16,26),
(6,1,14,46,26,40,16,26),
(6,1,15,47,27,41,17,26),
(6,1,16,48,28,43,17,27),
(6,1,17,50,29,44,17,27),
(6,1,18,51,30,45,17,27),
(6,1,19,53,31,47,17,28),
(6,1,20,54,32,48,17,28),
(6,1,21,56,33,50,17,28),
(6,1,22,58,34,51,18,29),
(6,1,23,59,35,52,18,29),
(6,1,24,61,36,54,18,30),
(6,1,25,62,37,55,18,30),
(6,1,26,64,38,57,18,30),
(6,1,27,66,39,58,18,31),
(6,1,28,67,40,60,18,31),
(6,1,29,69,41,61,19,32),
(6,1,30,71,42,63,19,32),
(6,1,31,72,43,64,19,32),
(6,1,32,74,44,66,19,33),
(6,1,33,76,45,67,19,33),
(6,1,34,77,46,69,20,34),
(6,1,35,79,47,71,20,34),
(6,1,36,81,48,72,20,35),
(6,1,37,83,49,74,20,35),
(6,1,38,85,50,76,20,35),
(6,1,39,86,51,77,21,36),
(6,1,40,88,53,79,21,36),
(6,1,41,90,54,81,21,37),
(6,1,42,92,55,82,21,37),
(6,1,43,94,56,84,21,38),
(6,1,44,96,57,86,22,38),
(6,1,45,98,58,87,22,39),
(6,1,46,99,60,89,22,39),
(6,1,47,101,61,91,22,40),
(6,1,48,103,62,93,22,40),
(6,1,49,105,63,94,23,41),
(6,1,50,107,65,96,23,41),
(6,1,51,109,66,98,23,42),
(6,1,52,111,67,100,23,42),
(6,1,53,113,68,102,24,43),
(6,1,54,115,70,104,24,44),
(6,1,55,117,71,105,24,44),
(6,1,56,119,72,107,24,45),
(6,1,57,122,73,109,25,45),
(6,1,58,124,75,111,25,46),
(6,1,59,126,76,113,25,46),
(6,1,60,128,77,115,25,47),
(6,1,61,130,79,117,26,48),
(6,1,62,132,80,119,26,48),
(6,1,63,134,81,121,26,49),
(6,1,64,137,83,123,26,49),
(6,1,65,139,84,125,27,50),
(6,1,66,141,85,127,27,51),
(6,1,67,143,87,129,27,51),
(6,1,68,145,88,131,27,52),
(6,1,69,148,90,133,28,52),
(6,1,70,150,91,135,28,53),
(6,1,71,153,92,137,28,54),
(6,1,72,155,94,140,28,55),
(6,1,73,158,96,142,28,56),
(6,1,74,161,97,145,29,56),
(6,1,75,164,99,147,29,57),
(6,1,76,167,101,150,29,58),
(6,1,77,170,103,153,30,59),
(6,1,78,173,104,155,30,59),
(6,1,79,176,106,164,30,60),
(6,1,80,179,108,170,31,61),
(6,3,1,25,18,23,15,23),
(6,3,2,25,19,24,16,24),
(6,3,3,26,21,25,16,24),
(6,3,4,26,22,26,17,25),
(6,3,5,27,24,27,17,25),
(6,3,6,27,25,28,18,26),
(6,3,7,28,26,28,19,27),
(6,3,8,28,28,29,19,27),
(6,3,9,28,29,30,20,28),
(6,3,10,29,31,31,20,29),
(6,3,11,29,32,32,21,29),
(6,3,12,30,34,33,22,30),
(6,3,13,30,35,34,22,31),
(6,3,14,31,37,35,23,32),
(6,3,15,31,38,36,24,32),
(6,3,16,32,40,37,24,33),
(6,3,17,32,41,39,25,34),
(6,3,18,33,43,40,26,35),
(6,3,19,33,45,41,27,35),
(6,3,20,34,46,42,27,36),
(6,3,21,34,48,43,28,37),
(6,3,22,35,50,44,29,38),
(6,3,23,35,51,45,29,38),
(6,3,24,36,53,46,30,39),
(6,3,25,37,55,47,31,40),
(6,3,26,37,56,48,32,41),
(6,3,27,38,58,50,32,42),
(6,3,28,38,60,51,33,42),
(6,3,29,39,62,52,34,43),
(6,3,30,39,63,53,35,44),
(6,3,31,40,65,54,36,45),
(6,3,32,41,67,56,36,46),
(6,3,33,41,69,57,37,47),
(6,3,34,42,71,58,38,48),
(6,3,35,43,72,59,39,48),
(6,3,36,43,74,61,40,49),
(6,3,37,44,76,62,40,50),
(6,3,38,45,78,63,41,51),
(6,3,39,45,80,64,42,52),
(6,3,40,46,82,66,43,53),
(6,3,41,47,84,67,44,54),
(6,3,42,47,86,68,45,55),
(6,3,43,48,88,70,46,56),
(6,3,44,49,90,71,46,57),
(6,3,45,49,92,72,47,58),
(6,3,46,50,94,74,48,59),
(6,3,47,51,96,75,49,60),
(6,3,48,51,98,77,50,61),
(6,3,49,52,100,78,51,62),
(6,3,50,53,102,79,52,63),
(6,3,51,54,104,81,53,64),
(6,3,52,54,106,82,54,65),
(6,3,53,55,108,84,55,66),
(6,3,54,56,110,85,56,67),
(6,3,55,57,112,87,57,68),
(6,3,56,57,114,88,58,69),
(6,3,57,58,117,90,59,70),
(6,3,58,59,119,91,60,71),
(6,3,59,60,121,93,61,72),
(6,3,60,61,123,94,62,74),
(6,3,61,61,125,96,63,75),
(6,3,62,62,128,97,64,76),
(6,3,63,63,130,99,65,77),
(6,3,64,64,132,100,66,78),
(6,3,65,65,134,102,67,79),
(6,3,66,66,137,104,68,80),
(6,3,67,66,139,105,69,81),
(6,3,68,67,141,107,70,83),
(6,3,69,68,144,108,71,84),
(6,3,70,69,146,110,72,85),
(6,3,71,70,149,112,73,86),
(6,3,72,71,152,114,74,87),
(6,3,73,72,155,116,75,89),
(6,3,74,73,158,118,77,90),
(6,3,75,74,161,120,78,92),
(6,3,76,75,164,122,79,93),
(6,3,77,76,167,124,81,95),
(6,3,78,77,176,126,85,96),
(6,3,79,78,179,128,86,98),
(6,3,80,79,183,130,88,99),
(6,6,1,28,15,24,15,22),
(6,6,2,29,16,25,15,22),
(6,6,3,31,17,26,15,23),
(6,6,4,32,17,27,15,23),
(6,6,5,33,18,29,15,23),
(6,6,6,34,19,30,15,23),
(6,6,7,36,20,31,16,24),
(6,6,8,37,21,32,16,24),
(6,6,9,38,22,34,16,24),
(6,6,10,40,22,35,16,25),
(6,6,11,41,23,36,16,25),
(6,6,12,43,24,37,16,25),
(6,6,13,44,25,39,16,26),
(6,6,14,46,26,40,16,26),
(6,6,15,47,27,41,17,26),
(6,6,16,48,28,43,17,27),
(6,6,17,50,29,44,17,27),
(6,6,18,51,30,45,17,27),
(6,6,19,53,31,47,17,28),
(6,6,20,54,32,48,17,28),
(6,6,21,56,33,50,17,28),
(6,6,22,58,34,51,18,29),
(6,6,23,59,35,52,18,29),
(6,6,24,61,36,54,18,30),
(6,6,25,62,37,55,18,30),
(6,6,26,64,38,57,18,30),
(6,6,27,66,39,58,18,31),
(6,6,28,67,40,60,18,31),
(6,6,29,69,41,61,19,32),
(6,6,30,71,42,63,19,32),
(6,6,31,72,43,64,19,32),
(6,6,32,74,44,66,19,33),
(6,6,33,76,45,67,19,33),
(6,6,34,77,46,69,20,34),
(6,6,35,79,47,71,20,34),
(6,6,36,81,48,72,20,35),
(6,6,37,83,49,74,20,35),
(6,6,38,85,50,76,20,35),
(6,6,39,86,51,77,21,36),
(6,6,40,88,53,79,21,36),
(6,6,41,90,54,81,21,37),
(6,6,42,92,55,82,21,37),
(6,6,43,94,56,84,21,38),
(6,6,44,96,57,86,22,38),
(6,6,45,98,58,87,22,39),
(6,6,46,99,60,89,22,39),
(6,6,47,101,60,91,22,40),
(6,6,48,103,61,93,22,40),
(6,6,49,105,62,94,23,41),
(6,6,50,107,63,96,23,41),
(6,6,51,109,64,97,23,42),
(6,6,52,110,65,98,23,42),
(6,6,53,111,66,99,24,43),
(6,6,54,112,67,100,24,44),
(6,6,55,113,68,101,24,44),
(6,6,56,116,70,104,24,45),
(6,6,57,121,71,106,24,45),
(6,6,58,123,72,108,25,46),
(6,6,59,123,74,110,25,46),
(6,6,60,125,75,112,25,47),
(6,6,61,127,76,114,25,48),
(6,6,62,133,78,116,25,48),
(6,6,63,135,79,119,26,49),
(6,6,64,139,81,121,26,49),
(6,6,65,142,82,123,26,50),
(6,6,66,146,84,126,26,51),
(6,6,67,150,85,132,27,51),
(6,6,68,153,87,137,27,52),
(6,6,69,157,88,140,27,53),
(6,6,70,160,90,143,27,53),
(6,6,71,163,92,146,28,54),
(6,6,72,165,93,148,28,55),
(6,6,73,167,95,150,28,56),
(6,6,74,171,97,153,28,56),
(6,6,75,174,98,156,29,57),
(6,6,76,178,100,156,29,58),
(6,6,77,179,102,156,29,59),
(6,6,78,179,103,156,29,59),
(6,6,79,182,105,159,30,60),
(6,6,80,185,107,162,30,61),
(6,7,1,26,15,23,16,24),
(6,7,2,27,15,24,17,25),
(6,7,3,28,16,25,18,26),
(6,7,4,28,16,26,19,27),
(6,7,5,29,17,27,20,28),
(6,7,6,30,17,28,21,29),
(6,7,7,31,18,29,22,30),
(6,7,8,32,18,30,23,31),
(6,7,9,33,19,31,24,32),
(6,7,10,34,19,32,25,33),
(6,7,11,35,20,33,26,35),
(6,7,12,35,20,34,27,36),
(6,7,13,36,21,35,28,37),
(6,7,14,37,21,36,29,38),
(6,7,15,38,22,37,30,39),
(6,7,16,39,22,39,31,40),
(6,7,17,40,23,40,32,42),
(6,7,18,41,23,41,33,43),
(6,7,19,42,24,42,34,44),
(6,7,20,43,24,43,35,45),
(6,7,21,44,25,44,36,46),
(6,7,22,45,25,45,37,48),
(6,7,23,46,26,47,38,49),
(6,7,24,47,27,48,40,50),
(6,7,25,48,27,49,41,51),
(6,7,26,49,28,50,42,53),
(6,7,27,51,28,52,43,54),
(6,7,28,52,29,53,44,55),
(6,7,29,53,29,54,45,57),
(6,7,30,54,30,55,47,58),
(6,7,31,55,31,57,48,59),
(6,7,32,56,31,58,49,61),
(6,7,33,57,32,59,50,62),
(6,7,34,58,33,61,51,64),
(6,7,35,60,33,62,53,65),
(6,7,36,61,34,63,54,66),
(6,7,37,62,34,65,55,68),
(6,7,38,63,35,66,57,69),
(6,7,39,64,36,67,58,71),
(6,7,40,66,36,69,59,72),
(6,7,41,67,37,70,60,74),
(6,7,42,68,38,72,62,75),
(6,7,43,69,38,73,63,77),
(6,7,44,70,39,74,64,78),
(6,7,45,72,40,76,66,80),
(6,7,46,73,41,77,67,81),
(6,7,47,74,41,79,69,83),
(6,7,48,76,42,80,70,84),
(6,7,49,77,43,82,71,86),
(6,7,50,78,43,83,73,88),
(6,7,51,80,44,85,74,89),
(6,7,52,81,45,86,76,91),
(6,7,53,82,46,88,77,92),
(6,7,54,84,46,90,78,94),
(6,7,55,85,47,91,80,96),
(6,7,56,86,48,93,81,97),
(6,7,57,88,49,94,83,99),
(6,7,58,89,49,96,84,101),
(6,7,59,91,50,97,86,102),
(6,7,60,92,51,99,87,104),
(6,7,61,94,52,101,89,106),
(6,7,62,95,52,102,90,108),
(6,7,63,96,53,104,92,109),
(6,7,64,98,54,106,93,111),
(6,7,65,99,55,107,95,113),
(6,7,66,101,56,109,97,115),
(6,7,67,102,57,111,98,117),
(6,7,68,104,57,113,100,118),
(6,7,69,105,58,114,101,120),
(6,7,70,107,59,116,103,122),
(6,7,71,108,60,118,113,124),
(6,7,72,110,61,120,117,127),
(6,7,73,112,62,122,119,129),
(6,7,74,114,63,125,122,131),
(6,7,75,116,64,127,124,133),
(6,7,76,118,65,129,126,136),
(6,7,77,119,66,131,128,138),
(6,7,78,121,67,133,130,140),
(6,7,79,123,68,136,133,143),
(6,7,80,125,69,138,135,145),
(6,11,1,26,15,22,17,24),
(6,11,2,27,16,23,18,25),
(6,11,3,27,16,23,19,26),
(6,11,4,28,17,24,20,27),
(6,11,5,28,17,25,21,29),
(6,11,6,29,18,25,22,30),
(6,11,7,29,18,26,23,31),
(6,11,8,30,19,27,24,32),
(6,11,9,30,19,27,26,34),
(6,11,10,31,20,28,27,35),
(6,11,11,32,20,29,28,36),
(6,11,12,32,21,29,29,37),
(6,11,13,33,21,30,30,39),
(6,11,14,33,22,31,31,40),
(6,11,15,34,23,32,32,41),
(6,11,16,35,23,32,34,43),
(6,11,17,35,24,33,35,44),
(6,11,18,36,24,34,36,45),
(6,11,19,37,25,35,37,47),
(6,11,20,37,26,35,39,48),
(6,11,21,38,26,36,40,50),
(6,11,22,39,27,37,41,51),
(6,11,23,39,28,38,42,52),
(6,11,24,40,28,39,44,54),
(6,11,25,41,29,39,45,55),
(6,11,26,41,30,40,46,57),
(6,11,27,42,30,41,47,58),
(6,11,28,43,31,42,49,60),
(6,11,29,44,32,43,50,61),
(6,11,30,44,32,44,52,63),
(6,11,31,45,33,44,53,64),
(6,11,32,46,34,45,54,66),
(6,11,33,47,34,46,56,67),
(6,11,34,47,35,47,57,69),
(6,11,35,48,36,48,58,71),
(6,11,36,49,36,49,60,72),
(6,11,37,50,37,50,61,74),
(6,11,38,51,38,51,63,76),
(6,11,39,52,39,52,64,77),
(6,11,40,52,39,53,66,79),
(6,11,41,53,40,54,67,81),
(6,11,42,54,41,55,69,82),
(6,11,43,55,42,56,70,84),
(6,11,44,56,43,57,72,86),
(6,11,45,57,43,57,73,87),
(6,11,46,57,44,58,75,89),
(6,11,47,58,45,60,76,91),
(6,11,48,59,46,61,78,93),
(6,11,49,60,47,62,79,94),
(6,11,50,61,47,63,81,96),
(6,11,51,62,48,64,83,98),
(6,11,52,63,49,65,84,100),
(6,11,53,64,50,66,86,102),
(6,11,54,65,51,67,87,104),
(6,11,55,66,51,68,89,105),
(6,11,56,67,52,69,91,107),
(6,11,57,68,53,70,92,109),
(6,11,58,69,54,71,94,111),
(6,11,59,70,55,72,96,113),
(6,11,60,71,56,73,97,115),
(6,11,61,72,57,74,99,117),
(6,11,62,73,58,76,101,119),
(6,11,63,74,59,77,103,121),
(6,11,64,75,59,78,104,123),
(6,11,65,76,60,79,106,125),
(6,11,66,77,61,80,108,127),
(6,11,67,78,62,81,110,129),
(6,11,68,79,63,83,111,131),
(6,11,69,80,64,84,113,133),
(6,11,70,81,65,85,115,135),
(6,11,71,83,66,86,117,137),
(6,11,72,84,68,88,120,140),
(6,11,73,85,69,89,122,142),
(6,11,74,86,70,91,124,145),
(6,11,75,88,71,92,126,147),
(6,11,76,89,72,94,128,150),
(6,11,77,90,73,95,131,153),
(6,11,78,92,75,97,133,155),
(6,11,79,93,76,98,136,158),
(6,11,80,94,77,100,138,185),
(7,1,1,18,23,21,24,20),
(7,1,2,19,24,22,24,20),
(7,1,3,21,25,23,24,21),
(7,1,4,22,25,25,24,21),
(7,1,5,23,26,26,24,21),
(7,1,6,25,27,27,24,21),
(7,1,7,26,28,28,24,22),
(7,1,8,27,29,29,25,22),
(7,1,9,29,29,31,25,22),
(7,1,10,30,30,32,25,23),
(7,1,11,32,31,33,25,23),
(7,1,12,33,32,34,25,23),
(7,1,13,34,33,36,25,24),
(7,1,14,36,34,37,25,24),
(7,1,15,37,35,38,25,24),
(7,1,16,39,36,40,25,25),
(7,1,17,40,36,41,25,25),
(7,1,18,42,37,43,26,25),
(7,1,19,43,38,44,26,26),
(7,1,20,45,39,45,26,26),
(7,1,21,47,40,47,26,26),
(7,1,22,48,41,48,26,27),
(7,1,23,50,42,50,26,27),
(7,1,24,51,43,51,26,28),
(7,1,25,53,44,52,27,28),
(7,1,26,55,45,54,27,28),
(7,1,27,56,46,55,27,29),
(7,1,28,58,47,57,27,29),
(7,1,29,59,48,58,27,30),
(7,1,30,61,49,60,27,30),
(7,1,31,63,50,62,27,30),
(7,1,32,65,51,63,28,31),
(7,1,33,66,52,65,28,31),
(7,1,34,68,53,66,28,32),
(7,1,35,70,55,68,28,32),
(7,1,36,72,56,69,28,33),
(7,1,37,73,57,71,29,33),
(7,1,38,75,58,73,29,34),
(7,1,39,77,59,74,29,34),
(7,1,40,79,60,76,29,35),
(7,1,41,81,61,78,29,35),
(7,1,42,82,62,79,30,35),
(7,1,43,84,64,81,30,36),
(7,1,44,86,65,83,30,36),
(7,1,45,88,66,85,30,37),
(7,1,46,90,67,86,30,37),
(7,1,47,92,68,88,31,38),
(7,1,48,94,70,90,31,38),
(7,1,49,96,71,92,31,39),
(7,1,50,98,72,93,31,40),
(7,1,51,100,73,95,32,40),
(7,1,52,102,75,97,32,41),
(7,1,53,104,76,99,32,41),
(7,1,54,106,77,101,32,42),
(7,1,55,108,78,103,33,42),
(7,1,56,110,80,104,33,43),
(7,1,57,112,81,106,33,43),
(7,1,58,114,82,108,33,44),
(7,1,59,116,84,110,34,44),
(7,1,60,118,85,112,34,45),
(7,1,61,120,86,114,34,46),
(7,1,62,122,88,116,35,46),
(7,1,63,125,89,118,35,47),
(7,1,64,127,91,120,35,47),
(7,1,65,129,92,122,35,48),
(7,1,66,131,93,124,36,49),
(7,1,67,133,95,126,36,49),
(7,1,68,136,96,128,36,50),
(7,1,69,138,98,130,37,50),
(7,1,70,140,99,132,37,51),
(7,1,71,143,100,134,37,52),
(7,1,72,145,102,137,37,53),
(7,1,73,148,104,139,37,54),
(7,1,74,151,105,142,38,54),
(7,1,75,154,107,144,38,55),
(7,1,76,157,109,147,38,56),
(7,1,77,163,111,153,39,57),
(7,1,78,169,112,158,39,57),
(7,1,79,172,114,161,39,58),
(7,1,80,175,116,164,40,59),
(7,4,1,16,26,20,24,20),
(7,4,2,17,27,21,24,20),
(7,4,3,18,29,21,24,21),
(7,4,4,18,30,22,24,21),
(7,4,5,19,32,23,25,21),
(7,4,6,20,33,24,25,22),
(7,4,7,21,35,24,25,22),
(7,4,8,22,36,25,25,23),
(7,4,9,22,38,26,25,23),
(7,4,10,23,39,26,25,23),
(7,4,11,24,41,27,25,24),
(7,4,12,25,42,28,26,24),
(7,4,13,26,44,29,26,25),
(7,4,14,27,46,30,26,25),
(7,4,15,28,47,30,26,25),
(7,4,16,28,49,31,26,26),
(7,4,17,29,50,32,27,26),
(7,4,18,30,52,33,27,27),
(7,4,19,31,54,34,27,27),
(7,4,20,32,56,35,27,28),
(7,4,21,33,57,35,27,28),
(7,4,22,34,59,36,28,29),
(7,4,23,35,61,37,28,29),
(7,4,24,36,62,38,28,30),
(7,4,25,37,64,39,28,30),
(7,4,26,38,66,40,29,31),
(7,4,27,39,68,41,29,31),
(7,4,28,40,70,42,29,32),
(7,4,29,41,72,43,29,32),
(7,4,30,42,73,43,29,33),
(7,4,31,43,75,44,30,33),
(7,4,32,44,77,45,30,34),
(7,4,33,45,79,46,30,34),
(7,4,34,46,81,47,31,35),
(7,4,35,47,83,48,31,35),
(7,4,36,48,85,49,31,36),
(7,4,37,49,87,50,31,36),
(7,4,38,50,89,51,32,37),
(7,4,39,51,91,52,32,38),
(7,4,40,53,93,53,32,38),
(7,4,41,54,95,54,33,39),
(7,4,42,55,97,55,33,39),
(7,4,43,56,99,56,33,40),
(7,4,44,57,101,57,33,40),
(7,4,45,58,103,59,34,41),
(7,4,46,59,105,60,34,42),
(7,4,47,61,107,61,34,42),
(7,4,48,62,110,62,35,43),
(7,4,49,63,112,63,35,44),
(7,4,50,64,114,64,35,44),
(7,4,51,65,116,65,36,45),
(7,4,52,67,118,66,36,45),
(7,4,53,68,121,67,36,46),
(7,4,54,69,123,69,37,47),
(7,4,55,70,125,70,37,47),
(7,4,56,72,127,71,37,48),
(7,4,57,73,130,72,38,49),
(7,4,58,74,132,73,38,49),
(7,4,59,75,134,74,39,50),
(7,4,60,77,137,76,39,51),
(7,4,61,78,139,77,39,51),
(7,4,62,79,141,78,40,52),
(7,4,63,81,144,79,40,53),
(7,4,64,82,146,80,41,54),
(7,4,65,83,149,82,41,54),
(7,4,66,85,151,83,41,55),
(7,4,67,86,154,84,42,56),
(7,4,68,87,156,85,42,57),
(7,4,69,89,158,87,43,57),
(7,4,70,90,161,88,43,58),
(7,4,71,92,164,89,44,59),
(7,4,72,94,167,91,45,59),
(7,4,73,95,170,93,45,60),
(7,4,74,97,173,94,46,61),
(7,4,75,99,176,96,46,62),
(7,4,76,100,179,97,46,63),
(7,4,77,102,182,102,47,64),
(7,4,78,104,186,105,47,65),
(7,4,79,106,189,106,48,66),
(7,4,80,108,192,108,48,67),
(7,6,1,18,23,21,24,20),
(7,6,2,19,24,22,24,20),
(7,6,3,21,25,23,24,21),
(7,6,4,22,25,25,24,21),
(7,6,5,23,26,26,24,21),
(7,6,6,25,27,27,24,21),
(7,6,7,26,28,28,24,22),
(7,6,8,27,29,29,25,22),
(7,6,9,29,29,31,25,22),
(7,6,10,30,30,32,25,23),
(7,6,11,32,31,33,25,23),
(7,6,12,33,32,34,25,23),
(7,6,13,34,33,36,25,24),
(7,6,14,36,34,37,25,24),
(7,6,15,37,35,38,25,24),
(7,6,16,39,36,40,25,25),
(7,6,17,40,36,41,25,25),
(7,6,18,42,37,43,26,25),
(7,6,19,43,38,44,26,26),
(7,6,20,45,39,45,26,26),
(7,6,21,47,40,47,26,26),
(7,6,22,48,41,48,26,27),
(7,6,23,50,42,50,26,27),
(7,6,24,51,43,51,26,28),
(7,6,25,53,44,52,27,28),
(7,6,26,55,45,54,27,28),
(7,6,27,56,46,55,27,29),
(7,6,28,58,47,57,27,29),
(7,6,29,59,48,58,27,30),
(7,6,30,61,49,60,27,30),
(7,6,31,63,50,62,27,30),
(7,6,32,65,51,63,28,31),
(7,6,33,66,52,65,28,31),
(7,6,34,68,53,66,28,32),
(7,6,35,70,55,68,28,32),
(7,6,36,72,56,69,28,33),
(7,6,37,73,57,71,29,33),
(7,6,38,75,58,73,29,34),
(7,6,39,77,59,74,29,34),
(7,6,40,79,60,76,29,35),
(7,6,41,81,61,78,29,35),
(7,6,42,82,62,79,30,35),
(7,6,43,84,64,81,30,36),
(7,6,44,86,65,83,30,36),
(7,6,45,88,66,85,30,37),
(7,6,46,90,67,86,30,37),
(7,6,47,92,68,88,31,38),
(7,6,48,94,70,90,31,38),
(7,6,49,96,71,92,31,39),
(7,6,50,98,72,93,31,40),
(7,6,51,99,72,93,32,40),
(7,6,52,100,73,95,32,41),
(7,6,53,101,74,96,32,41),
(7,6,54,102,75,97,32,42),
(7,6,55,103,76,98,33,42),
(7,6,56,106,78,101,33,43),
(7,6,57,111,79,103,33,43),
(7,6,58,113,80,105,34,44),
(7,6,59,116,82,107,34,44),
(7,6,60,118,83,109,34,45),
(7,6,61,120,84,111,34,46),
(7,6,62,127,86,119,34,46),
(7,6,63,129,87,122,35,47),
(7,6,64,132,89,125,35,47),
(7,6,65,135,90,127,35,48),
(7,6,66,137,92,130,35,49),
(7,6,67,138,93,130,36,49),
(7,6,68,140,95,131,36,50),
(7,6,69,142,96,131,36,51),
(7,6,70,145,98,132,36,51),
(7,6,71,148,100,135,37,52),
(7,6,72,150,101,137,37,53),
(7,6,73,153,103,140,37,54),
(7,6,74,154,105,142,37,54),
(7,6,75,155,106,145,38,55),
(7,6,76,158,108,151,38,56),
(7,6,77,161,110,157,38,57),
(7,6,78,164,111,162,38,57),
(7,6,79,167,113,165,39,58),
(7,6,80,170,115,168,39,59),
(7,8,1,15,23,19,27,22),
(7,8,2,15,23,19,28,23),
(7,8,3,15,23,20,30,25),
(7,8,4,15,23,20,31,26),
(7,8,5,15,24,20,32,27),
(7,8,6,15,24,20,34,29),
(7,8,7,16,24,21,35,30),
(7,8,8,16,24,21,37,31),
(7,8,9,16,24,21,38,33),
(7,8,10,16,24,22,40,34),
(7,8,11,16,25,22,41,36),
(7,8,12,16,25,22,42,37),
(7,8,13,16,25,23,44,38),
(7,8,14,16,25,23,45,40),
(7,8,15,17,25,23,47,41),
(7,8,16,17,25,24,49,43),
(7,8,17,17,26,24,50,44),
(7,8,18,17,26,24,52,46),
(7,8,19,17,26,25,53,47),
(7,8,20,17,26,25,55,49),
(7,8,21,17,26,26,57,51),
(7,8,22,18,27,26,58,52),
(7,8,23,18,27,26,60,54),
(7,8,24,18,27,27,61,55),
(7,8,25,18,27,27,63,57),
(7,8,26,18,28,27,65,59),
(7,8,27,18,28,28,67,60),
(7,8,28,18,28,28,68,62),
(7,8,29,19,28,29,70,64),
(7,8,30,19,29,29,72,65),
(7,8,31,19,29,30,74,67),
(7,8,32,19,29,30,75,69),
(7,8,33,19,29,30,77,70),
(7,8,34,20,30,31,79,72),
(7,8,35,20,30,31,81,74),
(7,8,36,20,30,32,83,76),
(7,8,37,20,30,32,85,78),
(7,8,38,20,31,33,86,79),
(7,8,39,21,31,33,88,81),
(7,8,40,21,31,34,90,83),
(7,8,41,21,32,34,92,85),
(7,8,42,21,32,35,94,87),
(7,8,43,21,32,35,96,89),
(7,8,44,22,32,36,98,91),
(7,8,45,22,33,36,100,92),
(7,8,46,22,33,37,102,94),
(7,8,47,22,33,37,104,96),
(7,8,48,22,34,38,106,98),
(7,8,49,23,34,38,108,100),
(7,8,50,23,34,39,110,102),
(7,8,51,23,35,39,112,104),
(7,8,52,23,35,40,114,106),
(7,8,53,24,35,40,117,108),
(7,8,54,24,36,41,119,110),
(7,8,55,24,36,41,121,112),
(7,8,56,24,37,42,123,114),
(7,8,57,25,37,42,125,117),
(7,8,58,25,37,43,127,119),
(7,8,59,25,38,43,130,121),
(7,8,60,25,38,44,132,123),
(7,8,61,26,38,45,134,125),
(7,8,62,26,39,45,136,127),
(7,8,63,26,39,46,139,129),
(7,8,64,26,40,46,141,132),
(7,8,65,27,40,47,143,134),
(7,8,66,27,40,48,146,136),
(7,8,67,27,41,48,148,138),
(7,8,68,27,41,49,150,140),
(7,8,69,28,42,49,153,143),
(7,8,70,28,42,50,155,145),
(7,8,71,28,42,51,168,148),
(7,8,72,28,43,52,168,151),
(7,8,73,28,43,53,171,154),
(7,8,74,29,44,53,174,156),
(7,8,75,29,44,54,177,159),
(7,8,76,29,44,55,180,162),
(7,8,77,30,45,56,183,165),
(7,8,78,30,45,56,186,168),
(7,8,79,30,46,57,190,171),
(7,8,80,31,46,58,193,174),
(7,9,1,15,23,20,26,22),
(7,9,2,15,23,21,27,23),
(7,9,3,16,24,21,28,24),
(7,9,4,16,24,22,29,25),
(7,9,5,16,24,22,31,27),
(7,9,6,17,25,23,32,28),
(7,9,7,17,25,23,33,29),
(7,9,8,17,26,24,34,30),
(7,9,9,17,26,25,36,31),
(7,9,10,18,26,25,37,33),
(7,9,11,18,27,26,38,34),
(7,9,12,18,27,26,39,35),
(7,9,13,19,28,27,41,36),
(7,9,14,19,28,28,42,38),
(7,9,15,20,28,28,43,39),
(7,9,16,20,29,29,45,40),
(7,9,17,20,29,30,46,42),
(7,9,18,21,30,30,47,43),
(7,9,19,21,30,31,49,44),
(7,9,20,21,31,32,50,46),
(7,9,21,22,31,32,51,47),
(7,9,22,22,31,33,53,49),
(7,9,23,23,32,34,54,50),
(7,9,24,23,32,34,56,51),
(7,9,25,23,33,35,57,53),
(7,9,26,24,33,36,59,54),
(7,9,27,24,34,37,60,56),
(7,9,28,25,34,37,62,57),
(7,9,29,25,35,38,63,59),
(7,9,30,25,35,39,65,60),
(7,9,31,26,36,40,66,62),
(7,9,32,26,36,40,68,63),
(7,9,33,27,37,41,69,65),
(7,9,34,27,38,42,71,66),
(7,9,35,28,38,43,73,68),
(7,9,36,28,39,43,74,69),
(7,9,37,28,39,44,76,71),
(7,9,38,29,40,45,77,73),
(7,9,39,29,40,46,79,74),
(7,9,40,30,41,47,81,76),
(7,9,41,30,41,48,82,78),
(7,9,42,31,42,48,84,79),
(7,9,43,31,43,49,86,81),
(7,9,44,32,43,50,88,83),
(7,9,45,32,44,51,89,84),
(7,9,46,33,44,52,91,86),
(7,9,47,33,45,53,93,88),
(7,9,48,34,46,54,95,89),
(7,9,49,34,46,54,96,91),
(7,9,50,35,47,55,98,93),
(7,9,51,35,48,56,100,95),
(7,9,52,36,48,57,102,97),
(7,9,53,36,49,58,104,98),
(7,9,54,37,50,59,105,100),
(7,9,55,37,50,60,107,102),
(7,9,56,38,51,61,109,104),
(7,9,57,38,52,62,111,106),
(7,9,58,39,52,63,113,108),
(7,9,59,40,53,64,115,109),
(7,9,60,40,54,65,117,111),
(7,9,61,41,54,66,119,113),
(7,9,62,41,55,67,121,115),
(7,9,63,42,56,68,123,117),
(7,9,64,42,57,69,125,119),
(7,9,65,43,57,70,127,121),
(7,9,66,44,58,71,129,123),
(7,9,67,44,59,72,131,125),
(7,9,68,45,59,73,133,127),
(7,9,69,45,60,74,135,129),
(7,9,70,46,61,75,137,131),
(7,9,71,47,62,84,147,142),
(7,9,72,48,62,85,148,144),
(7,9,73,49,63,85,153,147),
(7,9,74,49,64,88,153,150),
(7,9,75,50,65,90,155,152),
(7,9,76,51,66,91,158,155),
(7,9,77,52,67,92,161,158),
(7,9,78,52,68,93,163,161),
(7,9,79,53,69,95,166,164),
(7,9,80,54,70,96,170,166),
(8,1,1,24,22,23,16,21),
(8,1,2,25,23,24,16,21),
(8,1,3,27,24,25,16,22),
(8,1,4,28,24,26,16,22),
(8,1,5,29,25,28,16,22),
(8,1,6,31,26,29,16,22),
(8,1,7,32,27,30,17,23),
(8,1,8,33,28,31,17,23),
(8,1,9,35,28,33,17,23),
(8,1,10,36,29,34,17,24),
(8,1,11,37,30,35,17,24),
(8,1,12,39,31,36,17,24),
(8,1,13,40,32,38,17,25),
(8,1,14,42,33,39,17,25),
(8,1,15,43,34,40,18,25),
(8,1,16,45,35,42,18,26),
(8,1,17,46,35,43,18,26),
(8,1,18,48,36,44,18,26),
(8,1,19,49,37,46,18,27),
(8,1,20,51,38,47,18,27),
(8,1,21,52,39,49,18,27),
(8,1,22,54,40,50,18,28),
(8,1,23,55,41,51,19,28),
(8,1,24,57,42,53,19,29),
(8,1,25,59,43,54,19,29),
(8,1,26,60,44,56,19,29),
(8,1,27,62,45,57,19,30),
(8,1,28,63,46,59,19,30),
(8,1,29,65,47,60,20,31),
(8,1,30,67,48,62,20,31),
(8,1,31,69,49,63,20,31),
(8,1,32,70,50,65,20,32),
(8,1,33,72,51,67,20,32),
(8,1,34,74,53,68,20,33),
(8,1,35,75,54,70,21,33),
(8,1,36,77,55,71,21,34),
(8,1,37,79,56,73,21,34),
(8,1,38,81,57,75,21,35),
(8,1,39,83,58,76,21,35),
(8,1,40,84,59,78,22,35),
(8,1,41,86,60,80,22,36),
(8,1,42,88,62,81,22,36),
(8,1,43,90,63,83,22,37),
(8,1,44,92,64,85,22,37),
(8,1,45,94,65,86,23,38),
(8,1,46,96,66,88,23,38),
(8,1,47,98,67,90,23,39),
(8,1,48,100,69,92,23,39),
(8,1,49,102,70,93,24,40),
(8,1,50,103,71,95,24,40),
(8,1,51,105,72,97,24,41),
(8,1,52,107,74,99,24,42),
(8,1,53,109,75,101,25,42),
(8,1,54,112,76,103,25,43),
(8,1,55,114,78,104,25,43),
(8,1,56,116,79,106,25,44),
(8,1,57,118,80,108,25,44),
(8,1,58,120,81,110,26,45),
(8,1,59,122,83,112,26,45),
(8,1,60,124,84,114,26,46),
(8,1,61,126,85,116,27,47),
(8,1,62,128,87,118,27,47),
(8,1,63,130,88,120,27,48),
(8,1,64,133,90,122,27,48),
(8,1,65,135,91,124,28,49),
(8,1,66,137,92,126,28,50),
(8,1,67,139,94,128,28,50),
(8,1,68,141,95,130,28,51),
(8,1,69,144,97,132,29,51),
(8,1,70,146,98,134,29,52),
(8,1,71,149,99,136,29,53),
(8,1,72,151,101,139,29,54),
(8,1,73,154,103,141,29,55),
(8,1,74,157,104,144,30,55),
(8,1,75,166,106,151,30,56),
(8,1,76,172,108,157,30,57),
(8,1,77,175,110,161,31,58),
(8,1,78,179,111,163,31,58),
(8,1,79,182,113,164,31,59),
(8,1,80,185,115,169,32,60),
(8,3,1,21,25,22,16,22),
(8,3,2,21,26,23,17,23),
(8,3,3,22,28,24,17,23),
(8,3,4,22,29,25,18,24),
(8,3,5,23,30,26,18,25),
(8,3,6,23,32,27,19,25),
(8,3,7,24,33,28,20,26),
(8,3,8,24,35,28,20,26),
(8,3,9,25,36,29,21,27),
(8,3,10,25,38,30,21,28),
(8,3,11,25,39,31,22,29),
(8,3,12,26,41,32,23,29),
(8,3,13,26,42,33,23,30),
(8,3,14,27,44,34,24,31),
(8,3,15,27,45,35,25,31),
(8,3,16,28,47,36,25,32),
(8,3,17,28,48,38,26,33),
(8,3,18,29,50,39,27,34),
(8,3,19,29,51,40,28,34),
(8,3,20,30,53,41,28,35),
(8,3,21,31,55,42,29,36),
(8,3,22,31,56,43,30,37),
(8,3,23,32,58,44,30,37),
(8,3,24,32,60,45,31,38),
(8,3,25,33,61,46,32,39),
(8,3,26,33,63,48,33,40),
(8,3,27,34,65,49,33,41),
(8,3,28,35,66,50,34,41),
(8,3,29,35,68,51,35,42),
(8,3,30,36,70,52,36,43),
(8,3,31,36,72,53,37,44),
(8,3,32,37,73,55,37,45),
(8,3,33,38,75,56,38,46),
(8,3,34,38,77,57,39,47),
(8,3,35,39,79,58,40,48),
(8,3,36,39,81,60,41,48),
(8,3,37,40,83,61,41,49),
(8,3,38,41,85,62,42,50),
(8,3,39,41,86,63,43,51),
(8,3,40,42,88,65,44,52),
(8,3,41,43,90,66,45,53),
(8,3,42,43,92,67,46,54),
(8,3,43,44,94,69,47,55),
(8,3,44,45,96,70,47,56),
(8,3,45,45,98,71,48,57),
(8,3,46,46,100,73,49,58),
(8,3,47,47,102,74,50,59),
(8,3,48,48,104,76,51,60),
(8,3,49,48,106,77,52,61),
(8,3,50,49,108,78,53,62),
(8,3,51,50,110,80,54,63),
(8,3,52,51,113,81,55,64),
(8,3,53,51,115,83,56,65),
(8,3,54,52,117,84,57,66),
(8,3,55,53,119,86,58,67),
(8,3,56,54,121,87,59,68),
(8,3,57,54,123,89,60,69),
(8,3,58,55,126,90,61,70),
(8,3,59,56,128,92,62,71),
(8,3,60,57,130,93,63,73),
(8,3,61,58,132,95,64,74),
(8,3,62,58,134,96,65,75),
(8,3,63,59,137,98,66,76),
(8,3,64,60,139,99,67,77),
(8,3,65,61,141,101,68,78),
(8,3,66,62,144,103,69,79),
(8,3,67,62,146,104,70,80),
(8,3,68,63,148,106,71,82),
(8,3,69,64,151,107,72,83),
(8,3,70,65,153,109,73,84),
(8,3,71,66,156,111,74,85),
(8,3,72,67,159,113,75,86),
(8,3,73,68,162,115,76,88),
(8,3,74,69,165,117,78,89),
(8,3,75,70,174,119,82,91),
(8,3,76,71,177,121,83,92),
(8,3,77,72,180,123,85,94),
(8,3,78,73,184,125,86,95),
(8,3,79,74,187,127,87,97),
(8,3,80,75,190,129,89,98),
(8,4,1,22,25,22,16,21),
(8,4,2,23,26,23,16,21),
(8,4,3,24,28,23,16,22),
(8,4,4,24,29,24,16,22),
(8,4,5,25,31,25,17,22),
(8,4,6,26,32,25,17,23),
(8,4,7,27,34,26,17,23),
(8,4,8,27,35,27,17,24),
(8,4,9,28,37,28,17,24),
(8,4,10,29,38,28,18,24),
(8,4,11,30,40,29,18,25),
(8,4,12,31,41,30,18,25),
(8,4,13,32,43,31,18,26),
(8,4,14,32,45,32,18,26),
(8,4,15,33,46,32,19,26),
(8,4,16,34,48,33,19,27),
(8,4,17,35,50,34,19,27),
(8,4,18,36,51,35,19,28),
(8,4,19,37,53,36,19,28),
(8,4,20,38,55,36,20,29),
(8,4,21,39,56,37,20,29),
(8,4,22,40,58,38,20,30),
(8,4,23,41,60,39,20,30),
(8,4,24,42,62,40,20,31),
(8,4,25,43,63,41,21,31),
(8,4,26,44,65,42,21,32),
(8,4,27,45,67,43,21,32),
(8,4,28,46,69,44,21,33),
(8,4,29,47,71,44,22,33),
(8,4,30,48,72,45,22,34),
(8,4,31,49,74,46,22,34),
(8,4,32,50,76,47,22,35),
(8,4,33,51,78,48,23,35),
(8,4,34,52,80,49,23,36),
(8,4,35,53,82,50,23,36),
(8,4,36,54,84,51,24,37),
(8,4,37,55,86,52,24,37),
(8,4,38,56,88,53,24,38),
(8,4,39,57,90,54,24,38),
(8,4,40,58,92,55,25,39),
(8,4,41,59,94,56,25,40),
(8,4,42,60,96,57,25,40),
(8,4,43,62,98,58,26,41),
(8,4,44,63,100,59,26,41),
(8,4,45,64,102,60,26,42),
(8,4,46,65,104,61,27,43),
(8,4,47,66,107,63,27,43),
(8,4,48,67,109,64,27,44),
(8,4,49,69,111,65,27,44),
(8,4,50,70,113,66,28,45),
(8,4,51,71,115,67,28,46),
(8,4,52,72,117,68,28,46),
(8,4,53,74,120,69,29,47),
(8,4,54,75,122,70,29,48),
(8,4,55,76,124,72,29,48),
(8,4,56,77,126,73,30,49),
(8,4,57,79,129,74,30,50),
(8,4,58,80,131,75,30,50),
(8,4,59,81,133,76,31,51),
(8,4,60,82,136,77,31,52),
(8,4,61,84,138,79,32,52),
(8,4,62,85,140,80,32,53),
(8,4,63,86,143,81,32,54),
(8,4,64,88,145,82,33,55),
(8,4,65,89,148,84,33,55),
(8,4,66,90,150,85,33,56),
(8,4,67,92,153,86,34,57),
(8,4,68,93,155,87,34,58),
(8,4,69,95,157,89,35,58),
(8,4,70,96,160,90,35,59),
(8,4,71,98,163,94,35,60),
(8,4,72,100,166,96,36,60),
(8,4,73,101,169,96,36,61),
(8,4,74,103,172,97,37,62),
(8,4,75,105,175,98,37,63),
(8,4,76,106,178,99,37,64),
(8,4,77,108,181,105,38,65),
(8,4,78,110,185,107,38,66),
(8,4,79,112,188,109,39,67),
(8,4,80,114,191,110,39,68),
(8,5,1,21,22,21,18,24),
(8,5,2,21,22,21,19,25),
(8,5,3,21,22,22,21,27),
(8,5,4,21,23,22,22,28),
(8,5,5,22,23,22,23,29),
(8,5,6,22,23,23,25,31),
(8,5,7,22,23,23,26,32),
(8,5,8,22,24,24,27,34),
(8,5,9,22,24,24,29,35),
(8,5,10,22,24,24,30,37),
(8,5,11,23,24,25,32,38),
(8,5,12,23,24,25,33,40),
(8,5,13,23,25,26,35,41),
(8,5,14,23,25,26,36,43),
(8,5,15,23,25,26,38,44),
(8,5,16,24,26,27,39,46),
(8,5,17,24,26,27,41,47),
(8,5,18,24,26,28,42,49),
(8,5,19,24,26,28,44,50),
(8,5,20,24,27,29,45,52),
(8,5,21,25,27,29,47,54),
(8,5,22,25,27,30,48,55),
(8,5,23,25,28,30,50,57),
(8,5,24,25,28,31,52,59),
(8,5,25,25,28,31,53,60),
(8,5,26,26,28,32,55,62),
(8,5,27,26,29,32,56,64),
(8,5,28,26,29,33,58,65),
(8,5,29,26,29,33,60,67),
(8,5,30,27,30,34,62,69),
(8,5,31,27,30,34,63,71),
(8,5,32,27,30,35,65,73),
(8,5,33,27,31,35,67,74),
(8,5,34,28,31,36,68,76),
(8,5,35,28,32,36,70,78),
(8,5,36,28,32,37,72,80),
(8,5,37,29,32,37,74,82),
(8,5,38,29,33,38,76,84),
(8,5,39,29,33,38,77,86),
(8,5,40,29,33,39,79,87),
(8,5,41,30,34,40,81,89),
(8,5,42,30,34,40,83,91),
(8,5,43,30,35,41,85,93),
(8,5,44,31,35,41,87,95),
(8,5,45,31,35,42,89,97),
(8,5,46,31,36,43,91,99),
(8,5,47,32,36,43,93,101),
(8,5,48,32,37,44,94,103),
(8,5,49,32,37,44,96,105),
(8,5,50,33,37,45,98,107),
(8,5,51,33,38,46,100,110),
(8,5,52,33,38,46,102,112),
(8,5,53,34,39,47,104,114),
(8,5,54,34,39,48,106,116),
(8,5,55,34,40,48,109,118),
(8,5,56,35,40,49,111,120),
(8,5,57,35,41,50,113,122),
(8,5,58,35,41,50,115,125),
(8,5,59,36,42,51,117,127),
(8,5,60,36,42,52,119,129),
(8,5,61,36,42,52,121,131),
(8,5,62,37,43,53,123,133),
(8,5,63,37,43,54,125,136),
(8,5,64,38,44,55,128,138),
(8,5,65,38,44,55,130,140),
(8,5,66,38,45,56,132,143),
(8,5,67,39,45,57,134,145),
(8,5,68,39,46,58,136,147),
(8,5,69,40,46,58,139,150),
(8,5,70,40,47,59,141,152),
(8,5,71,40,48,60,144,155),
(8,5,72,41,48,60,147,158),
(8,5,73,41,49,61,150,161),
(8,5,74,42,49,62,152,164),
(8,5,75,42,50,63,155,167),
(8,5,76,42,51,64,158,170),
(8,5,77,43,51,65,161,173),
(8,5,78,43,52,66,164,176),
(8,5,79,44,52,67,167,179),
(8,5,80,44,53,68,170,182),
(8,6,1,24,22,23,16,21),
(8,6,2,25,23,24,16,21),
(8,6,3,27,24,25,16,22),
(8,6,4,28,24,26,16,22),
(8,6,5,29,25,28,16,22),
(8,6,6,31,26,29,16,22),
(8,6,7,32,27,30,17,23),
(8,6,8,33,28,31,17,23),
(8,6,9,35,28,33,17,23),
(8,6,10,36,29,34,17,24),
(8,6,11,37,30,35,17,24),
(8,6,12,39,31,36,17,24),
(8,6,13,40,32,38,17,25),
(8,6,14,42,33,39,17,25),
(8,6,15,43,34,40,18,25),
(8,6,16,45,35,42,18,26),
(8,6,17,46,35,43,18,26),
(8,6,18,48,36,44,18,26),
(8,6,19,49,37,46,18,27),
(8,6,20,51,38,47,18,27),
(8,6,21,52,39,49,18,27),
(8,6,22,54,40,50,18,28),
(8,6,23,55,41,51,19,28),
(8,6,24,57,42,53,19,29),
(8,6,25,59,43,54,19,29),
(8,6,26,60,44,56,19,29),
(8,6,27,62,45,57,19,30),
(8,6,28,63,46,59,19,30),
(8,6,29,65,47,60,20,31),
(8,6,30,67,48,62,20,31),
(8,6,31,69,49,63,20,31),
(8,6,32,70,50,65,20,32),
(8,6,33,72,51,67,20,32),
(8,6,34,74,53,68,20,33),
(8,6,35,75,54,70,21,33),
(8,6,36,77,55,71,21,34),
(8,6,37,79,56,73,21,34),
(8,6,38,81,57,75,21,35),
(8,6,39,83,58,76,21,35),
(8,6,40,84,59,78,22,35),
(8,6,41,86,60,80,22,36),
(8,6,42,88,62,81,22,36),
(8,6,43,90,63,83,22,37),
(8,6,44,92,64,85,22,37),
(8,6,45,94,65,86,23,38),
(8,6,46,96,66,88,23,38),
(8,6,47,98,67,90,23,39),
(8,6,48,100,69,92,23,39),
(8,6,49,102,70,93,24,40),
(8,6,50,103,71,95,24,40),
(8,6,51,105,72,96,24,41),
(8,6,52,106,74,97,24,42),
(8,6,53,107,73,98,25,42),
(8,6,54,108,74,99,25,43),
(8,6,55,109,75,100,25,43),
(8,6,56,112,77,103,25,44),
(8,6,57,114,78,105,25,44),
(8,6,58,118,79,107,26,45),
(8,6,59,119,81,109,26,45),
(8,6,60,121,82,111,26,46),
(8,6,61,123,83,113,26,47),
(8,6,62,126,85,115,26,47),
(8,6,63,128,86,118,27,48),
(8,6,64,131,88,120,27,48),
(8,6,65,138,89,122,27,49),
(8,6,66,140,91,125,27,50),
(8,6,67,143,92,127,28,50),
(8,6,68,145,94,129,28,51),
(8,6,69,148,95,132,28,52),
(8,6,70,151,97,134,28,52),
(8,6,71,154,99,137,29,53),
(8,6,72,156,100,139,29,54),
(8,6,73,159,102,142,29,55),
(8,6,74,162,104,144,29,55),
(8,6,75,165,105,147,30,56),
(8,6,76,168,107,150,30,57),
(8,6,77,169,109,153,30,58),
(8,6,78,170,110,155,30,58),
(8,6,79,178,112,158,31,59),
(8,6,80,181,114,161,31,60),
(8,7,1,22,22,22,17,23),
(8,7,2,23,22,23,18,24),
(8,7,3,24,23,24,19,25),
(8,7,4,25,23,25,20,26),
(8,7,5,25,24,26,21,27),
(8,7,6,26,24,27,22,28),
(8,7,7,27,25,28,23,29),
(8,7,8,28,25,29,24,30),
(8,7,9,29,25,30,25,31),
(8,7,10,30,26,31,26,33),
(8,7,11,31,26,32,27,34),
(8,7,12,32,27,33,28,35),
(8,7,13,33,27,34,29,36),
(8,7,14,34,28,35,30,37),
(8,7,15,34,28,36,31,38),
(8,7,16,35,29,38,32,39),
(8,7,17,36,29,39,33,41),
(8,7,18,37,30,40,34,42),
(8,7,19,38,30,41,35,43),
(8,7,20,39,31,42,36,44),
(8,7,21,40,32,43,37,45),
(8,7,22,41,32,45,38,47),
(8,7,23,43,33,46,39,48),
(8,7,24,44,33,47,40,49),
(8,7,25,45,34,48,42,51),
(8,7,26,46,34,49,43,52),
(8,7,27,47,35,51,44,53),
(8,7,28,48,35,52,45,54),
(8,7,29,49,36,53,46,56),
(8,7,30,50,37,54,48,57),
(8,7,31,51,37,56,49,59),
(8,7,32,52,38,57,50,60),
(8,7,33,53,38,58,51,61),
(8,7,34,55,39,60,52,63),
(8,7,35,56,40,61,54,64),
(8,7,36,57,40,62,55,66),
(8,7,37,58,41,64,56,67),
(8,7,38,59,42,65,57,68),
(8,7,39,61,42,66,59,70),
(8,7,40,62,43,68,60,71),
(8,7,41,63,44,69,61,73),
(8,7,42,64,44,71,63,74),
(8,7,43,65,45,72,64,76),
(8,7,44,67,46,74,65,77),
(8,7,45,68,46,75,67,79),
(8,7,46,69,47,76,68,80),
(8,7,47,71,48,78,69,82),
(8,7,48,72,49,79,71,83),
(8,7,49,73,49,81,72,85),
(8,7,50,74,50,82,74,87),
(8,7,51,76,51,84,75,88),
(8,7,52,77,51,85,77,90),
(8,7,53,78,52,87,78,92),
(8,7,54,80,53,89,79,93),
(8,7,55,81,54,90,81,95),
(8,7,56,83,55,92,82,96),
(8,7,57,84,55,93,84,98),
(8,7,58,85,56,95,85,100),
(8,7,59,87,57,97,87,102),
(8,7,60,88,58,98,88,103),
(8,7,61,90,58,100,90,105),
(8,7,62,91,59,101,91,107),
(8,7,63,93,60,103,93,108),
(8,7,64,94,61,105,94,110),
(8,7,65,95,62,106,96,112),
(8,7,66,97,63,108,98,114),
(8,7,67,98,63,110,99,116),
(8,7,68,100,64,112,101,117),
(8,7,69,101,65,113,102,119),
(8,7,70,103,66,115,104,121),
(8,7,71,104,67,117,116,123),
(8,7,72,106,68,119,118,126),
(8,7,73,108,69,121,121,128),
(8,7,74,110,70,124,123,130),
(8,7,75,112,71,126,125,132),
(8,7,76,114,72,128,127,135),
(8,7,77,115,73,130,129,137),
(8,7,78,117,74,132,132,139),
(8,7,79,119,75,135,134,142),
(8,7,80,121,76,137,136,144),
(8,8,1,21,22,21,19,23),
(8,8,2,21,22,21,20,24),
(8,8,3,21,22,22,22,26),
(8,8,4,21,22,22,23,27),
(8,8,5,21,23,22,25,28),
(8,8,6,21,23,22,26,30),
(8,8,7,21,23,23,27,31),
(8,8,8,22,23,23,29,32),
(8,8,9,22,23,23,30,34),
(8,8,10,22,23,24,32,35),
(8,8,11,22,24,24,33,37),
(8,8,12,22,24,24,35,38),
(8,8,13,22,24,25,36,39),
(8,8,14,22,24,25,38,41),
(8,8,15,22,24,25,39,42),
(8,8,16,22,24,26,41,44),
(8,8,17,23,25,26,42,45),
(8,8,18,23,25,26,44,47),
(8,8,19,23,25,27,46,48),
(8,8,20,23,25,27,47,50),
(8,8,21,23,25,27,49,51),
(8,8,22,23,26,28,51,53),
(8,8,23,23,26,28,52,55),
(8,8,24,24,26,29,54,56),
(8,8,25,24,26,29,56,58),
(8,8,26,24,27,29,57,60),
(8,8,27,24,27,30,59,61),
(8,8,28,24,27,30,61,63),
(8,8,29,24,27,31,63,65),
(8,8,30,24,28,31,64,66),
(8,8,31,25,28,31,66,68),
(8,8,32,25,28,32,68,70),
(8,8,33,25,28,32,70,71),
(8,8,34,25,29,33,71,73),
(8,8,35,25,29,33,73,75),
(8,8,36,26,29,34,75,77),
(8,8,37,26,29,34,77,79),
(8,8,38,26,30,35,79,80),
(8,8,39,26,30,35,81,82),
(8,8,40,26,30,35,83,84),
(8,8,41,27,31,36,85,86),
(8,8,42,27,31,36,87,88),
(8,8,43,27,31,37,89,90),
(8,8,44,27,32,37,91,91),
(8,8,45,27,32,38,93,93),
(8,8,46,28,32,38,95,95),
(8,8,47,28,32,39,97,97),
(8,8,48,28,33,39,99,99),
(8,8,49,28,33,40,101,101),
(8,8,50,29,33,40,103,103),
(8,8,51,29,34,41,105,105),
(8,8,52,29,34,42,107,107),
(8,8,53,29,35,42,109,109),
(8,8,54,30,35,43,111,111),
(8,8,55,30,35,43,113,113),
(8,8,56,30,36,44,115,115),
(8,8,57,30,36,44,118,118),
(8,8,58,31,36,45,120,120),
(8,8,59,31,37,45,122,122),
(8,8,60,31,37,46,124,124),
(8,8,61,31,37,47,126,126),
(8,8,62,32,38,47,129,128),
(8,8,63,32,38,48,131,130),
(8,8,64,32,39,48,133,133),
(8,8,65,33,39,49,135,135),
(8,8,66,33,39,50,138,137),
(8,8,67,33,40,50,140,139),
(8,8,68,33,40,51,142,141),
(8,8,69,34,41,51,145,144),
(8,8,70,34,41,52,147,146),
(8,8,71,34,41,53,150,149),
(8,8,72,34,42,54,153,152),
(8,8,73,34,42,55,156,155),
(8,8,74,35,43,55,159,157),
(8,8,75,35,43,56,162,160),
(8,8,76,35,43,57,168,163),
(8,8,77,36,44,58,168,166),
(8,8,78,36,44,58,171,169),
(8,8,79,36,45,59,177,172),
(8,8,80,37,45,60,177,175),
(10,2,1,19,22,21,24,20),
(10,2,2,20,23,22,25,21),
(10,2,3,21,23,23,25,21),
(10,2,4,22,24,24,26,22),
(10,2,5,23,24,25,27,23),
(10,2,6,25,25,26,27,24),
(10,2,7,26,25,27,28,24),
(10,2,8,27,26,28,29,25),
(10,2,9,28,27,29,29,26),
(10,2,10,29,27,31,30,26),
(10,2,11,30,28,32,31,27),
(10,2,12,32,29,33,31,28),
(10,2,13,33,29,34,32,29),
(10,2,14,34,30,35,33,30),
(10,2,15,35,31,36,33,30),
(10,2,16,37,31,37,34,31),
(10,2,17,38,32,39,35,32),
(10,2,18,39,33,40,36,33),
(10,2,19,40,33,41,36,34),
(10,2,20,42,34,42,37,35),
(10,2,21,43,35,44,38,35),
(10,2,22,44,35,45,39,36),
(10,2,23,46,36,46,40,37),
(10,2,24,47,37,47,40,38),
(10,2,25,49,38,49,41,39),
(10,2,26,50,38,50,42,40),
(10,2,27,51,39,51,43,41),
(10,2,28,53,40,53,44,42),
(10,2,29,54,41,54,45,43),
(10,2,30,56,41,55,45,43),
(10,2,31,57,42,57,46,44),
(10,2,32,58,43,58,47,45),
(10,2,33,60,44,59,48,46),
(10,2,34,61,45,61,49,47),
(10,2,35,63,45,62,50,48),
(10,2,36,64,46,64,51,49),
(10,2,37,66,47,65,52,50),
(10,2,38,67,48,67,53,51),
(10,2,39,69,49,68,54,52),
(10,2,40,71,50,69,55,53),
(10,2,41,72,50,71,55,54),
(10,2,42,74,51,72,56,55),
(10,2,43,75,52,74,57,56),
(10,2,44,77,53,75,58,57),
(10,2,45,79,54,77,59,59),
(10,2,46,80,55,78,60,60),
(10,2,47,82,56,80,61,61),
(10,2,48,83,57,82,62,62),
(10,2,49,85,58,83,63,63),
(10,2,50,87,59,85,64,64),
(10,2,51,89,60,86,66,65),
(10,2,52,90,61,88,67,66),
(10,2,53,92,61,90,68,67),
(10,2,54,94,62,91,69,69),
(10,2,55,95,63,93,70,70),
(10,2,56,97,64,95,71,71),
(10,2,57,99,65,96,72,72),
(10,2,58,101,66,98,73,73),
(10,2,59,102,67,100,74,74),
(10,2,60,104,68,101,75,76),
(10,2,61,106,69,103,76,77),
(10,2,62,108,70,105,78,78),
(10,2,63,110,72,106,79,79),
(10,2,64,112,73,108,80,80),
(10,2,65,113,74,110,81,82),
(10,2,66,115,75,112,82,83),
(10,2,67,117,76,114,83,84),
(10,2,68,119,77,115,85,85),
(10,2,69,121,78,117,86,87),
(10,2,70,123,79,119,87,88),
(10,2,71,125,80,120,88,89),
(10,2,72,128,81,123,90,91),
(10,2,73,130,82,125,91,93),
(10,2,74,133,84,127,93,94),
(10,2,75,135,85,129,94,96),
(10,2,76,137,86,132,96,97),
(10,2,77,140,88,134,97,99),
(10,2,78,143,89,136,99,101),
(10,2,79,145,90,139,100,102),
(10,2,80,148,92,141,102,104),
(10,3,1,17,25,20,24,20),
(10,3,2,17,26,21,25,21),
(10,3,3,18,28,22,25,21),
(10,3,4,18,29,23,26,22),
(10,3,5,19,30,24,26,23),
(10,3,6,19,32,25,27,23),
(10,3,7,20,33,26,27,24),
(10,3,8,20,35,27,28,25),
(10,3,9,21,36,27,29,25),
(10,3,10,21,38,28,29,26),
(10,3,11,22,39,29,30,27),
(10,3,12,22,41,30,31,27),
(10,3,13,23,42,31,31,28),
(10,3,14,23,44,32,32,29),
(10,3,15,24,45,34,32,29),
(10,3,16,24,47,35,33,30),
(10,3,17,25,48,36,34,31),
(10,3,18,25,50,37,34,32),
(10,3,19,26,51,38,35,32),
(10,3,20,26,53,39,36,33),
(10,3,21,27,55,40,37,34),
(10,3,22,27,56,41,37,35),
(10,3,23,28,58,42,38,36),
(10,3,24,28,60,43,39,36),
(10,3,25,29,61,44,39,37),
(10,3,26,30,63,46,40,38),
(10,3,27,30,65,47,41,39),
(10,3,28,31,66,48,42,40),
(10,3,29,31,68,49,42,40),
(10,3,30,32,70,50,43,41),
(10,3,31,33,72,52,44,42),
(10,3,32,33,73,53,45,43),
(10,3,33,34,75,54,46,44),
(10,3,34,34,77,55,46,45),
(10,3,35,35,79,57,47,46),
(10,3,36,36,81,58,48,47),
(10,3,37,36,83,59,49,47),
(10,3,38,37,85,60,50,48),
(10,3,39,38,86,62,51,49),
(10,3,40,38,88,63,51,50),
(10,3,41,39,90,64,52,51),
(10,3,42,40,92,66,53,52),
(10,3,43,40,94,67,54,53),
(10,3,44,41,96,68,55,54),
(10,3,45,42,98,70,56,55),
(10,3,46,42,100,71,57,56),
(10,3,47,43,102,72,58,57),
(10,3,48,44,104,74,59,58),
(10,3,49,45,106,75,60,59),
(10,3,50,45,108,77,61,60),
(10,3,51,46,110,78,61,61),
(10,3,52,47,113,79,62,62),
(10,3,53,47,115,81,63,63),
(10,3,54,48,117,82,64,64),
(10,3,55,49,119,84,65,65),
(10,3,56,50,121,85,66,66),
(10,3,57,50,123,87,67,67),
(10,3,58,51,126,88,68,68),
(10,3,59,52,128,90,69,70),
(10,3,60,53,130,91,70,71),
(10,3,61,54,132,93,71,72),
(10,3,62,54,134,94,72,73),
(10,3,63,55,137,96,73,74),
(10,3,64,56,139,97,75,75),
(10,3,65,57,141,99,76,76),
(10,3,66,58,144,101,77,77),
(10,3,67,58,146,102,78,78),
(10,3,68,59,148,104,79,80),
(10,3,69,60,151,105,80,81),
(10,3,70,61,153,107,81,82),
(10,3,71,62,156,108,82,83),
(10,3,72,63,159,110,83,84),
(10,3,73,64,162,112,84,86),
(10,3,74,65,165,114,86,87),
(10,3,75,66,168,116,87,89),
(10,3,76,67,171,118,89,90),
(10,3,77,68,174,120,90,92),
(10,3,78,69,177,122,91,93),
(10,3,79,70,180,124,92,95),
(10,3,80,71,183,126,94,96),
(10,4,1,18,25,20,24,19),
(10,4,2,19,26,21,24,19),
(10,4,3,20,28,21,24,20),
(10,4,4,20,29,22,24,20),
(10,4,5,21,31,23,25,20),
(10,4,6,22,32,24,25,21),
(10,4,7,23,34,24,25,21),
(10,4,8,24,35,25,25,22),
(10,4,9,24,37,26,25,22),
(10,4,10,25,38,26,25,22),
(10,4,11,26,40,27,25,23),
(10,4,12,27,41,28,26,23),
(10,4,13,28,43,29,26,24),
(10,4,14,29,45,30,26,24),
(10,4,15,29,46,30,26,25),
(10,4,16,30,48,31,26,25),
(10,4,17,31,50,32,27,25),
(10,4,18,32,51,33,27,26),
(10,4,19,33,53,34,27,26),
(10,4,20,34,55,35,27,27),
(10,4,21,35,56,35,27,27),
(10,4,22,36,58,36,28,28),
(10,4,23,37,60,37,28,28),
(10,4,24,38,62,38,28,29),
(10,4,25,39,63,39,28,29),
(10,4,26,40,65,40,29,30),
(10,4,27,41,67,41,29,30),
(10,4,28,42,69,42,29,31),
(10,4,29,43,71,43,29,31),
(10,4,30,44,72,43,29,32),
(10,4,31,45,74,44,30,32),
(10,4,32,46,76,45,30,33),
(10,4,33,47,78,46,30,33),
(10,4,34,48,80,47,31,34),
(10,4,35,49,82,48,31,34),
(10,4,36,50,84,49,31,35),
(10,4,37,51,86,50,31,35),
(10,4,38,52,88,51,32,36),
(10,4,39,53,90,52,32,37),
(10,4,40,54,92,53,32,37),
(10,4,41,56,94,54,33,38),
(10,4,42,57,96,55,33,38),
(10,4,43,58,98,56,33,39),
(10,4,44,59,100,57,33,39),
(10,4,45,60,102,59,34,40),
(10,4,46,61,104,60,34,41),
(10,4,47,62,107,61,34,41),
(10,4,48,64,109,62,35,42),
(10,4,49,65,111,63,35,43),
(10,4,50,66,113,64,35,43),
(10,4,51,67,115,65,36,44),
(10,4,52,68,117,66,36,44),
(10,4,53,70,120,67,36,45),
(10,4,54,71,122,69,37,46),
(10,4,55,72,124,70,37,46),
(10,4,56,73,126,71,37,47),
(10,4,57,75,129,72,38,48),
(10,4,58,76,131,73,38,48),
(10,4,59,77,133,74,39,49),
(10,4,60,79,136,76,39,50),
(10,4,61,80,138,77,39,51),
(10,4,62,81,140,78,40,51),
(10,4,63,82,143,79,40,52),
(10,4,64,84,145,80,41,53),
(10,4,65,85,148,82,41,53),
(10,4,66,87,150,83,41,54),
(10,4,67,88,153,84,42,55),
(10,4,68,89,155,85,42,56),
(10,4,69,91,157,87,43,56),
(10,4,70,92,160,88,43,57),
(10,4,71,94,163,88,43,58),
(10,4,72,96,166,90,44,58),
(10,4,73,97,169,92,44,59),
(10,4,74,99,172,93,45,60),
(10,4,75,101,175,95,45,61),
(10,4,76,102,178,96,45,62),
(10,4,77,104,181,101,46,63),
(10,4,78,106,185,104,46,64),
(10,4,79,108,188,105,47,65),
(10,4,80,110,191,107,47,66),
(10,5,1,17,22,19,26,22),
(10,5,2,17,22,19,27,23),
(10,5,3,17,22,20,29,25),
(10,5,4,17,23,20,30,26),
(10,5,5,18,23,20,31,27),
(10,5,6,18,23,21,33,29),
(10,5,7,18,23,21,34,30),
(10,5,8,18,24,22,35,32),
(10,5,9,18,24,22,37,33),
(10,5,10,19,24,22,38,35),
(10,5,11,19,24,23,39,36),
(10,5,12,19,24,23,41,38),
(10,5,13,19,25,24,42,39),
(10,5,14,19,25,24,44,41),
(10,5,15,19,25,25,45,42),
(10,5,16,20,26,25,47,44),
(10,5,17,20,26,25,48,45),
(10,5,18,20,26,26,50,47),
(10,5,19,20,26,26,51,49),
(10,5,20,21,27,27,53,50),
(10,5,21,21,27,27,54,52),
(10,5,22,21,27,28,56,53),
(10,5,23,21,28,28,58,55),
(10,5,24,21,28,29,59,57),
(10,5,25,22,28,29,61,58),
(10,5,26,22,28,30,62,60),
(10,5,27,22,29,30,64,62),
(10,5,28,22,29,31,66,64),
(10,5,29,23,29,31,67,65),
(10,5,30,23,30,32,69,67),
(10,5,31,23,30,32,71,69),
(10,5,32,23,30,33,72,71),
(10,5,33,24,31,33,74,72),
(10,5,34,24,31,34,76,74),
(10,5,35,24,32,34,78,76),
(10,5,36,24,32,35,80,78),
(10,5,37,25,32,35,81,80),
(10,5,38,25,33,36,83,82),
(10,5,39,25,33,37,85,84),
(10,5,40,26,33,37,87,86),
(10,5,41,26,34,38,89,88),
(10,5,42,26,34,38,91,89),
(10,5,43,27,35,39,92,91),
(10,5,44,27,35,39,94,93),
(10,5,45,27,35,40,96,95),
(10,5,46,27,36,41,98,97),
(10,5,47,28,36,41,100,99),
(10,5,48,28,37,42,102,101),
(10,5,49,28,37,43,104,103),
(10,5,50,29,37,43,106,106),
(10,5,51,29,38,44,108,108),
(10,5,52,29,38,44,110,110),
(10,5,53,30,39,45,112,112),
(10,5,54,30,39,46,114,114),
(10,5,55,30,40,46,116,116),
(10,5,56,31,40,47,118,118),
(10,5,57,31,41,48,120,120),
(10,5,58,31,41,48,123,123),
(10,5,59,32,42,49,125,125),
(10,5,60,32,42,50,127,127),
(10,5,61,33,42,51,129,129),
(10,5,62,33,43,51,131,131),
(10,5,63,33,43,52,133,134),
(10,5,64,34,44,53,135,136),
(10,5,65,34,44,53,138,138),
(10,5,66,34,45,54,140,141),
(10,5,67,35,45,55,142,143),
(10,5,68,35,46,56,144,145),
(10,5,69,36,46,56,147,148),
(10,5,70,36,47,57,149,150),
(10,5,71,36,48,57,152,153),
(10,5,72,37,48,57,155,156),
(10,5,73,37,49,58,158,159),
(10,5,74,38,49,59,160,163),
(10,5,75,38,50,60,163,165),
(10,5,76,38,51,61,166,170),
(10,5,77,39,51,62,168,175),
(10,5,78,39,52,63,172,174),
(10,5,79,40,52,64,175,177),
(10,5,80,40,53,65,178,180),
(10,6,1,18,23,21,24,20),
(10,6,2,19,24,22,24,20),
(10,6,3,21,25,23,24,21),
(10,6,4,22,25,25,24,21),
(10,6,5,23,26,26,24,21),
(10,6,6,25,27,27,24,21),
(10,6,7,26,28,28,24,22),
(10,6,8,27,29,29,25,22),
(10,6,9,29,29,31,25,22),
(10,6,10,30,30,32,25,23),
(10,6,11,32,31,33,25,23),
(10,6,12,33,32,34,25,23),
(10,6,13,34,33,36,25,24),
(10,6,14,36,34,37,25,24),
(10,6,15,37,35,38,25,24),
(10,6,16,39,36,40,25,25),
(10,6,17,40,36,41,25,25),
(10,6,18,42,37,43,26,25),
(10,6,19,43,38,44,26,26),
(10,6,20,45,39,45,26,26),
(10,6,21,47,40,47,26,26),
(10,6,22,48,41,48,26,27),
(10,6,23,50,42,50,26,27),
(10,6,24,51,43,51,26,28),
(10,6,25,53,44,52,27,28),
(10,6,26,55,45,54,27,28),
(10,6,27,56,46,55,27,29),
(10,6,28,58,47,57,27,29),
(10,6,29,59,48,58,27,30),
(10,6,30,61,49,60,27,30),
(10,6,31,63,50,62,27,30),
(10,6,32,65,51,63,28,31),
(10,6,33,66,52,65,28,31),
(10,6,34,68,53,66,28,32),
(10,6,35,70,55,68,28,32),
(10,6,36,72,56,69,28,33),
(10,6,37,73,57,71,29,33),
(10,6,38,75,58,73,29,34),
(10,6,39,77,59,74,29,34),
(10,6,40,79,60,76,29,35),
(10,6,41,81,61,78,29,35),
(10,6,42,82,62,79,30,35),
(10,6,43,84,64,81,30,36),
(10,6,44,86,65,83,30,36),
(10,6,45,88,66,85,30,37),
(10,6,46,90,67,86,30,37),
(10,6,47,92,68,88,31,38),
(10,6,48,94,69,90,31,38),
(10,6,49,96,69,92,31,39),
(10,6,50,98,70,93,31,40),
(10,6,51,100,71,95,32,40),
(10,6,52,102,72,96,32,41),
(10,6,53,103,73,97,32,41),
(10,6,54,104,74,98,32,41),
(10,6,55,105,75,97,33,41),
(10,6,56,108,77,100,33,42),
(10,6,57,113,78,102,33,42),
(10,6,58,115,79,104,34,43),
(10,6,59,117,81,106,34,43),
(10,6,60,118,82,108,34,44),
(10,6,61,119,83,110,34,45),
(10,6,62,121,85,112,34,45),
(10,6,63,124,86,115,35,46),
(10,6,64,127,88,117,35,46),
(10,6,65,133,89,119,35,47),
(10,6,66,135,91,122,35,48),
(10,6,67,139,92,124,36,48),
(10,6,68,141,94,126,36,49),
(10,6,69,142,95,129,36,50),
(10,6,70,145,97,131,36,50),
(10,6,71,150,99,134,37,51),
(10,6,72,152,100,136,37,52),
(10,6,73,155,102,139,37,53),
(10,6,74,158,104,141,37,53),
(10,6,75,159,105,144,38,54),
(10,6,76,160,107,147,38,55),
(10,6,77,163,109,149,38,56),
(10,6,78,166,110,152,38,56),
(10,6,79,169,112,155,39,57),
(10,6,80,172,114,158,39,58),
(10,8,1,17,22,19,27,21),
(10,8,2,17,22,19,28,22),
(10,8,3,17,22,20,30,24),
(10,8,4,17,22,20,31,25),
(10,8,5,17,23,20,32,26),
(10,8,6,17,23,20,34,28),
(10,8,7,18,23,21,35,29),
(10,8,8,18,23,21,37,30),
(10,8,9,18,23,21,38,32),
(10,8,10,18,23,22,40,33),
(10,8,11,18,24,22,41,35),
(10,8,12,18,24,22,42,36),
(10,8,13,18,24,23,44,37),
(10,8,14,18,24,23,45,39),
(10,8,15,18,24,23,47,40),
(10,8,16,19,24,24,49,42),
(10,8,17,19,25,24,50,43),
(10,8,18,19,25,24,52,45),
(10,8,19,19,25,25,53,46),
(10,8,20,19,25,25,55,48),
(10,8,21,19,25,26,57,50),
(10,8,22,19,26,26,58,51),
(10,8,23,20,26,26,60,53),
(10,8,24,20,26,27,61,54),
(10,8,25,20,26,27,63,56),
(10,8,26,20,27,27,65,58),
(10,8,27,20,27,28,67,59),
(10,8,28,20,27,28,68,61),
(10,8,29,21,27,29,70,63),
(10,8,30,21,28,29,72,64),
(10,8,31,21,28,30,74,66),
(10,8,32,21,28,30,75,68),
(10,8,33,21,28,30,77,70),
(10,8,34,21,29,31,79,71),
(10,8,35,22,29,31,81,73),
(10,8,36,22,29,32,83,75),
(10,8,37,22,29,32,85,77),
(10,8,38,22,30,33,86,78),
(10,8,39,22,30,33,88,80),
(10,8,40,23,30,34,90,82),
(10,8,41,23,31,34,92,84),
(10,8,42,23,31,35,94,86),
(10,8,43,23,31,35,96,88),
(10,8,44,23,32,36,98,90),
(10,8,45,24,32,36,100,92),
(10,8,46,24,32,37,102,93),
(10,8,47,24,32,37,104,95),
(10,8,48,24,33,38,106,97),
(10,8,49,25,33,38,108,99),
(10,8,50,25,33,39,110,101),
(10,8,51,25,34,39,112,103),
(10,8,52,25,34,40,114,105),
(10,8,53,25,35,40,117,107),
(10,8,54,26,35,41,119,109),
(10,8,55,26,35,41,121,111),
(10,8,56,26,36,42,123,113),
(10,8,57,26,36,42,125,116),
(10,8,58,27,36,43,127,118),
(10,8,59,27,37,43,130,120),
(10,8,60,27,37,44,132,122),
(10,8,61,27,37,45,134,124),
(10,8,62,28,38,45,136,126),
(10,8,63,28,38,46,139,128),
(10,8,64,28,39,46,141,131),
(10,8,65,29,39,47,143,133),
(10,8,66,29,39,48,146,135),
(10,8,67,29,40,48,148,137),
(10,8,68,29,40,49,150,139),
(10,8,69,30,41,49,153,142),
(10,8,70,30,41,50,155,144),
(10,8,71,30,41,50,158,147),
(10,8,72,30,42,51,161,150),
(10,8,73,30,42,52,164,153),
(10,8,74,31,43,52,167,155),
(10,8,75,31,43,53,170,158),
(10,8,76,31,43,54,173,161),
(10,8,77,32,44,55,176,164),
(10,8,78,32,44,55,179,167),
(10,8,79,32,45,56,182,170),
(10,8,80,33,45,57,185,173),
(10,9,1,17,22,20,26,21),
(10,9,2,17,22,21,27,22),
(10,9,3,18,23,21,28,23),
(10,9,4,18,23,22,29,24),
(10,9,5,18,23,22,31,26),
(10,9,6,18,24,23,32,27),
(10,9,7,19,24,23,33,28),
(10,9,8,19,25,24,34,29),
(10,9,9,19,25,25,36,30),
(10,9,10,20,25,25,37,32),
(10,9,11,20,26,26,38,33),
(10,9,12,20,26,26,39,34),
(10,9,13,21,27,27,41,36),
(10,9,14,21,27,28,42,37),
(10,9,15,21,27,28,43,38),
(10,9,16,22,28,29,45,39),
(10,9,17,22,28,30,46,41),
(10,9,18,23,29,30,47,42),
(10,9,19,23,29,31,49,43),
(10,9,20,23,30,32,50,45),
(10,9,21,24,30,32,51,46),
(10,9,22,24,31,33,53,48),
(10,9,23,24,31,34,54,49),
(10,9,24,25,31,34,56,50),
(10,9,25,25,32,35,57,52),
(10,9,26,26,32,36,59,53),
(10,9,27,26,33,37,60,55),
(10,9,28,26,33,37,62,56),
(10,9,29,27,34,38,63,58),
(10,9,30,27,34,39,65,59),
(10,9,31,28,35,40,66,61),
(10,9,32,28,36,40,68,62),
(10,9,33,29,36,41,69,64),
(10,9,34,29,37,42,71,65),
(10,9,35,29,37,43,73,67),
(10,9,36,30,38,43,74,69),
(10,9,37,30,38,44,76,70),
(10,9,38,31,39,45,77,72),
(10,9,39,31,39,46,79,73),
(10,9,40,32,40,47,81,75),
(10,9,41,32,41,48,82,77),
(10,9,42,33,41,48,84,78),
(10,9,43,33,42,49,86,80),
(10,9,44,34,42,50,88,82),
(10,9,45,34,43,51,89,83),
(10,9,46,35,44,52,91,85),
(10,9,47,35,44,53,93,87),
(10,9,48,36,45,54,95,89),
(10,9,49,36,45,54,96,90),
(10,9,50,37,46,55,98,92),
(10,9,51,37,47,56,100,94),
(10,9,52,38,47,57,102,96),
(10,9,53,38,48,58,104,97),
(10,9,54,39,49,59,105,99),
(10,9,55,39,49,60,107,101),
(10,9,56,40,50,61,109,103),
(10,9,57,40,51,62,111,105),
(10,9,58,41,51,63,113,107),
(10,9,59,42,52,64,115,108),
(10,9,60,42,53,65,117,110),
(10,9,61,43,53,66,119,112),
(10,9,62,43,54,67,121,114),
(10,9,63,44,55,68,123,116),
(10,9,64,44,56,69,125,118),
(10,9,65,45,56,70,127,120),
(10,9,66,46,57,71,129,122),
(10,9,67,46,58,72,131,124),
(10,9,68,47,58,73,133,126),
(10,9,69,47,59,74,135,128),
(10,9,70,48,60,75,137,130),
(10,9,71,49,61,83,139,141),
(10,9,72,50,61,84,142,143),
(10,9,73,51,62,84,144,146),
(10,9,74,51,63,86,147,149),
(10,9,75,52,64,89,149,151),
(10,9,76,53,65,90,155,154),
(10,9,77,54,66,91,155,157),
(10,9,78,54,67,93,157,160),
(10,9,79,55,68,94,160,163),
(10,9,80,56,69,95,163,165),
(11,1,1,24,17,21,21,22),
(11,1,2,25,18,22,21,22),
(11,1,3,27,19,23,21,23),
(11,1,4,28,19,25,21,23),
(11,1,5,29,20,26,21,23),
(11,1,6,31,21,27,21,23),
(11,1,7,32,22,28,21,24),
(11,1,8,33,23,29,22,24),
(11,1,9,35,24,31,22,24),
(11,1,10,36,24,32,22,25),
(11,1,11,37,25,33,22,25),
(11,1,12,39,26,34,22,25),
(11,1,13,40,27,36,22,26),
(11,1,14,42,28,37,22,26),
(11,1,15,43,29,38,22,26),
(11,1,16,45,30,40,22,27),
(11,1,17,46,31,41,23,27),
(11,1,18,48,32,43,23,27),
(11,1,19,49,33,44,23,28),
(11,1,20,51,34,45,23,28),
(11,1,21,52,34,47,23,28),
(11,1,22,54,35,48,23,29),
(11,1,23,55,36,50,23,29),
(11,1,24,57,37,51,24,30),
(11,1,25,59,38,52,24,30),
(11,1,26,60,39,54,24,30),
(11,1,27,62,40,55,24,31),
(11,1,28,63,41,57,24,31),
(11,1,29,65,43,58,24,32),
(11,1,30,67,44,60,24,32),
(11,1,31,69,45,62,25,32),
(11,1,32,70,46,63,25,33),
(11,1,33,72,47,65,25,33),
(11,1,34,74,48,66,25,34),
(11,1,35,75,49,68,25,34),
(11,1,36,77,50,69,26,35),
(11,1,37,79,51,71,26,35),
(11,1,38,81,52,73,26,35),
(11,1,39,83,53,74,26,36),
(11,1,40,84,55,76,26,36),
(11,1,41,86,56,78,27,37),
(11,1,42,88,57,79,27,37),
(11,1,43,90,58,81,27,38),
(11,1,44,92,59,83,27,38),
(11,1,45,94,60,85,27,39),
(11,1,46,96,62,86,28,39),
(11,1,47,98,63,88,28,40),
(11,1,48,100,64,90,28,40),
(11,1,49,102,65,92,28,41),
(11,1,50,103,66,93,29,41),
(11,1,51,105,68,95,29,42),
(11,1,52,107,69,97,29,42),
(11,1,53,109,70,99,29,43),
(11,1,54,112,71,101,30,44),
(11,1,55,114,73,103,30,44),
(11,1,56,116,74,104,30,45),
(11,1,57,118,75,106,30,45),
(11,1,58,120,77,108,31,46),
(11,1,59,122,78,110,31,46),
(11,1,60,124,79,112,31,47),
(11,1,61,126,81,114,31,48),
(11,1,62,128,82,116,32,48),
(11,1,63,130,83,118,32,49),
(11,1,64,133,85,120,32,49),
(11,1,65,135,86,122,33,50),
(11,1,66,137,87,124,33,51),
(11,1,67,139,89,126,33,51),
(11,1,68,141,90,128,33,52),
(11,1,69,144,92,130,34,52),
(11,1,70,146,93,132,34,53),
(11,1,71,149,94,134,34,54),
(11,1,72,151,96,137,34,55),
(11,1,73,154,98,139,34,56),
(11,1,74,157,99,142,35,56),
(11,1,75,166,101,149,35,57),
(11,1,76,172,103,155,35,58),
(11,1,77,175,105,159,36,59),
(11,1,78,179,106,161,36,59),
(11,1,79,182,108,164,36,60),
(11,1,80,185,110,167,37,61),
(11,2,1,23,17,21,21,23),
(11,2,2,24,18,22,22,24),
(11,2,3,25,18,23,22,24),
(11,2,4,26,19,24,23,25),
(11,2,5,27,19,25,24,26),
(11,2,6,29,20,26,24,26),
(11,2,7,30,21,27,25,27),
(11,2,8,31,21,28,26,28),
(11,2,9,32,22,29,26,29),
(11,2,10,33,22,31,27,29),
(11,2,11,34,23,32,28,30),
(11,2,12,36,24,33,28,31),
(11,2,13,37,24,34,29,32),
(11,2,14,38,25,35,30,32),
(11,2,15,39,26,36,31,33),
(11,2,16,40,26,37,31,34),
(11,2,17,42,27,39,32,35),
(11,2,18,43,28,40,33,36),
(11,2,19,44,28,41,34,37),
(11,2,20,46,29,42,34,37),
(11,2,21,47,30,44,35,38),
(11,2,22,48,31,45,36,39),
(11,2,23,50,31,46,37,40),
(11,2,24,51,32,47,38,41),
(11,2,25,52,33,49,38,42),
(11,2,26,54,34,50,39,43),
(11,2,27,55,34,51,40,44),
(11,2,28,56,35,53,41,44),
(11,2,29,58,36,54,42,45),
(11,2,30,59,37,55,43,46),
(11,2,31,61,37,57,43,47),
(11,2,32,62,38,58,44,48),
(11,2,33,64,39,59,45,49),
(11,2,34,65,40,61,46,50),
(11,2,35,67,41,62,47,51),
(11,2,36,68,42,64,48,52),
(11,2,37,70,42,65,49,53),
(11,2,38,71,43,67,50,54),
(11,2,39,73,44,68,51,55),
(11,2,40,74,45,69,52,56),
(11,2,41,76,46,71,53,57),
(11,2,42,78,47,72,54,58),
(11,2,43,79,47,74,55,59),
(11,2,44,81,48,75,56,60),
(11,2,45,82,49,77,57,61),
(11,2,46,84,50,78,58,62),
(11,2,47,86,51,80,59,64),
(11,2,48,87,52,82,60,65),
(11,2,49,89,53,83,61,66),
(11,2,50,91,54,85,62,67),
(11,2,51,92,55,86,63,68),
(11,2,52,94,56,88,64,69),
(11,2,53,96,57,90,65,70),
(11,2,54,97,58,91,66,71),
(11,2,55,99,59,93,67,73),
(11,2,56,101,60,95,68,74),
(11,2,57,103,61,96,69,75),
(11,2,58,105,62,98,70,76),
(11,2,59,106,63,100,71,77),
(11,2,60,108,64,101,72,78),
(11,2,61,110,65,103,74,80),
(11,2,62,112,66,105,75,81),
(11,2,63,114,67,106,76,82),
(11,2,64,116,68,108,77,83),
(11,2,65,117,69,110,78,85),
(11,2,66,119,70,112,79,86),
(11,2,67,121,71,114,80,87),
(11,2,68,123,72,115,82,88),
(11,2,69,125,73,117,83,90),
(11,2,70,127,74,119,84,91),
(11,2,71,130,75,121,87,92),
(11,2,72,132,76,124,90,94),
(11,2,73,134,77,126,93,96),
(11,2,74,137,79,128,97,97),
(11,2,75,139,80,130,101,99),
(11,2,76,142,81,133,106,100),
(11,2,77,144,83,135,108,102),
(11,2,78,147,84,137,110,104),
(11,2,79,149,85,140,111,105),
(11,2,80,152,87,142,113,107),
(11,3,1,21,20,20,21,23),
(11,3,2,21,21,21,22,24),
(11,3,3,22,23,22,22,24),
(11,3,4,22,24,23,23,25),
(11,3,5,23,25,24,23,25),
(11,3,6,23,27,25,24,26),
(11,3,7,24,28,26,24,27),
(11,3,8,24,30,27,25,27),
(11,3,9,25,31,27,26,28),
(11,3,10,25,33,28,26,29),
(11,3,11,25,34,29,27,29),
(11,3,12,26,36,30,28,30),
(11,3,13,26,37,31,28,31),
(11,3,14,27,39,32,29,32),
(11,3,15,27,40,34,30,32),
(11,3,16,28,42,35,30,33),
(11,3,17,28,43,36,31,34),
(11,3,18,29,45,37,32,35),
(11,3,19,29,47,38,32,35),
(11,3,20,30,48,39,33,36),
(11,3,21,31,50,40,34,37),
(11,3,22,31,51,41,34,38),
(11,3,23,32,53,42,35,38),
(11,3,24,32,55,43,36,39),
(11,3,25,33,57,44,37,40),
(11,3,26,33,58,46,37,41),
(11,3,27,34,60,47,38,42),
(11,3,28,35,62,48,39,42),
(11,3,29,35,63,49,40,43),
(11,3,30,36,65,50,40,44),
(11,3,31,36,67,52,41,45),
(11,3,32,37,69,53,42,46),
(11,3,33,38,71,54,43,47),
(11,3,34,38,72,55,44,48),
(11,3,35,39,74,57,44,48),
(11,3,36,39,76,58,45,49),
(11,3,37,40,78,59,46,50),
(11,3,38,41,80,60,47,51),
(11,3,39,41,82,62,48,52),
(11,3,40,42,84,63,49,53),
(11,3,41,43,86,64,50,54),
(11,3,42,43,88,66,50,55),
(11,3,43,44,90,67,51,56),
(11,3,44,45,91,68,52,57),
(11,3,45,45,93,70,53,58),
(11,3,46,46,95,71,54,59),
(11,3,47,47,98,72,55,60),
(11,3,48,48,100,74,56,61),
(11,3,49,48,102,75,57,62),
(11,3,50,49,104,77,58,63),
(11,3,51,50,106,78,59,64),
(11,3,52,51,108,79,60,65),
(11,3,53,51,110,81,61,66),
(11,3,54,52,112,82,61,67),
(11,3,55,53,114,84,62,68),
(11,3,56,54,116,85,63,69),
(11,3,57,54,118,87,64,70),
(11,3,58,55,121,88,65,71),
(11,3,59,56,123,90,66,72),
(11,3,60,57,125,91,67,74),
(11,3,61,58,127,93,68,75),
(11,3,62,58,130,94,69,76),
(11,3,63,59,132,96,71,77),
(11,3,64,60,134,97,72,78),
(11,3,65,61,136,99,73,79),
(11,3,66,62,139,101,74,80),
(11,3,67,62,141,102,75,81),
(11,3,68,63,143,104,76,83),
(11,3,69,64,146,105,77,84),
(11,3,70,65,148,107,78,85),
(11,3,71,66,151,109,79,86),
(11,3,72,67,154,111,80,87),
(11,3,73,68,157,113,81,89),
(11,3,74,69,160,115,83,90),
(11,3,75,70,163,117,84,92),
(11,3,76,71,166,119,85,93),
(11,3,77,72,169,121,87,95),
(11,3,78,73,172,123,88,96),
(11,3,79,74,175,125,89,98),
(11,3,80,75,178,127,91,99),
(11,5,1,21,17,19,23,25),
(11,5,2,21,17,19,24,26),
(11,5,3,21,17,20,26,28),
(11,5,4,21,18,20,27,29),
(11,5,5,22,18,20,28,30),
(11,5,6,22,18,21,30,32),
(11,5,7,22,18,21,31,33),
(11,5,8,22,19,22,32,35),
(11,5,9,22,19,22,34,36),
(11,5,10,22,19,22,35,38),
(11,5,11,23,19,23,37,39),
(11,5,12,23,20,23,38,41),
(11,5,13,23,20,24,39,42),
(11,5,14,23,20,24,41,44),
(11,5,15,23,20,25,42,45),
(11,5,16,24,21,25,44,47),
(11,5,17,24,21,25,45,48),
(11,5,18,24,21,26,47,50),
(11,5,19,24,22,26,48,51),
(11,5,20,24,22,27,50,53),
(11,5,21,25,22,27,51,55),
(11,5,22,25,22,28,53,56),
(11,5,23,25,23,28,55,58),
(11,5,24,25,23,29,56,60),
(11,5,25,25,23,29,58,61),
(11,5,26,26,24,30,60,63),
(11,5,27,26,24,30,61,65),
(11,5,28,26,24,31,63,66),
(11,5,29,26,25,31,65,68),
(11,5,30,27,25,32,66,70),
(11,5,31,27,25,32,68,72),
(11,5,32,27,26,33,70,73),
(11,5,33,27,26,33,71,75),
(11,5,34,28,26,34,73,77),
(11,5,35,28,27,34,75,79),
(11,5,36,28,27,35,77,81),
(11,5,37,29,28,35,79,83),
(11,5,38,29,28,36,80,85),
(11,5,39,29,28,37,82,86),
(11,5,40,29,29,37,84,88),
(11,5,41,30,29,38,86,90),
(11,5,42,30,29,38,88,92),
(11,5,43,30,30,39,90,94),
(11,5,44,31,30,39,91,96),
(11,5,45,31,31,40,93,98),
(11,5,46,31,31,41,95,100),
(11,5,47,32,31,41,97,102),
(11,5,48,32,32,42,99,104),
(11,5,49,32,32,43,101,106),
(11,5,50,33,33,43,103,108),
(11,5,51,33,33,44,105,110),
(11,5,52,33,34,44,107,113),
(11,5,53,34,34,45,109,115),
(11,5,54,34,34,46,111,117),
(11,5,55,34,35,46,113,119),
(11,5,56,35,35,47,115,121),
(11,5,57,35,36,48,118,123),
(11,5,58,35,36,48,120,126),
(11,5,59,36,37,49,122,128),
(11,5,60,36,37,50,124,130),
(11,5,61,36,38,51,126,132),
(11,5,62,37,38,51,128,134),
(11,5,63,37,39,52,130,137),
(11,5,64,38,39,53,133,139),
(11,5,65,38,40,53,135,141),
(11,5,66,38,40,54,137,144),
(11,5,67,39,40,55,139,146),
(11,5,68,39,41,56,141,148),
(11,5,69,40,41,56,144,151),
(11,5,70,40,42,57,146,153),
(11,5,71,40,43,58,149,156),
(11,5,72,41,43,58,155,159),
(11,5,73,41,44,59,157,160),
(11,5,74,42,44,61,160,163),
(11,5,75,42,45,62,164,166),
(11,5,76,42,46,62,167,169),
(11,5,77,43,46,63,168,172),
(11,5,78,43,47,64,169,177),
(11,5,79,44,47,65,172,180),
(11,5,80,44,48,66,175,183),
(11,6,1,24,17,21,21,22),
(11,6,2,25,18,22,21,22),
(11,6,3,27,19,23,21,23),
(11,6,4,28,19,25,21,23),
(11,6,5,29,20,26,21,23),
(11,6,6,31,21,27,21,23),
(11,6,7,32,22,28,21,24),
(11,6,8,33,23,29,22,24),
(11,6,9,35,24,31,22,24),
(11,6,10,36,24,32,22,25),
(11,6,11,37,25,33,22,25),
(11,6,12,39,26,34,22,25),
(11,6,13,40,27,36,22,26),
(11,6,14,42,28,37,22,26),
(11,6,15,43,29,38,22,26),
(11,6,16,45,30,40,22,27),
(11,6,17,46,31,41,23,27),
(11,6,18,48,32,43,23,27),
(11,6,19,49,33,44,23,28),
(11,6,20,51,34,45,23,28),
(11,6,21,52,34,47,23,28),
(11,6,22,54,35,48,23,29),
(11,6,23,55,36,50,23,29),
(11,6,24,57,37,51,24,30),
(11,6,25,59,38,52,24,30),
(11,6,26,60,39,54,24,30),
(11,6,27,62,40,55,24,31),
(11,6,28,63,41,57,24,31),
(11,6,29,65,43,58,24,32),
(11,6,30,67,44,60,24,32),
(11,6,31,69,45,62,25,32),
(11,6,32,70,46,63,25,33),
(11,6,33,72,47,65,25,33),
(11,6,34,74,48,66,25,34),
(11,6,35,75,49,68,25,34),
(11,6,36,77,50,69,26,35),
(11,6,37,79,51,71,26,35),
(11,6,38,81,52,73,26,35),
(11,6,39,83,53,74,26,36),
(11,6,40,84,55,76,26,36),
(11,6,41,86,56,78,27,37),
(11,6,42,88,57,79,27,37),
(11,6,43,90,58,81,27,38),
(11,6,44,92,59,83,27,38),
(11,6,45,94,60,85,27,39),
(11,6,46,96,62,86,28,39),
(11,6,47,98,63,88,28,40),
(11,6,48,100,64,90,28,40),
(11,6,49,102,65,92,28,41),
(11,6,50,103,65,93,29,41),
(11,6,51,105,66,94,29,42),
(11,6,52,106,67,95,29,42),
(11,6,53,107,68,96,29,43),
(11,6,54,108,69,97,30,44),
(11,6,55,109,70,98,30,44),
(11,6,56,112,72,101,30,45),
(11,6,57,114,73,103,30,45),
(11,6,58,117,74,105,31,46),
(11,6,59,119,76,107,31,46),
(11,6,60,121,77,109,31,47),
(11,6,61,123,78,111,31,48),
(11,6,62,126,80,113,31,48),
(11,6,63,128,81,116,32,49),
(11,6,64,131,83,118,32,49),
(11,6,65,136,84,120,32,50),
(11,6,66,140,86,123,32,51),
(11,6,67,141,87,125,33,51),
(11,6,68,141,89,127,33,52),
(11,6,69,144,90,130,33,53),
(11,6,70,147,92,132,33,53),
(11,6,71,150,94,135,34,54),
(11,6,72,152,95,137,34,55),
(11,6,73,155,97,140,34,56),
(11,6,74,162,99,142,34,56),
(11,6,75,165,100,145,35,57),
(11,6,76,167,102,146,35,58),
(11,6,77,169,104,150,35,59),
(11,6,78,170,105,152,35,59),
(11,6,79,173,107,156,36,60),
(11,6,80,176,109,159,36,61),
(11,7,1,22,17,20,22,24),
(11,7,2,23,17,21,23,25),
(11,7,3,24,18,22,24,26),
(11,7,4,25,18,23,25,27),
(11,7,5,25,19,24,26,28),
(11,7,6,26,19,25,27,29),
(11,7,7,27,20,26,28,30),
(11,7,8,28,20,27,28,31),
(11,7,9,29,21,28,29,32),
(11,7,10,30,21,29,30,33),
(11,7,11,31,22,30,31,35),
(11,7,12,32,22,31,32,36),
(11,7,13,33,23,32,33,37),
(11,7,14,34,23,33,34,38),
(11,7,15,34,24,35,35,39),
(11,7,16,35,24,36,36,40),
(11,7,17,36,25,37,38,42),
(11,7,18,37,25,38,39,43),
(11,7,19,38,26,39,40,44),
(11,7,20,39,26,40,41,45),
(11,7,21,40,27,41,42,46),
(11,7,22,41,27,43,43,48),
(11,7,23,43,28,44,44,49),
(11,7,24,44,28,45,45,50),
(11,7,25,45,29,46,46,51),
(11,7,26,46,30,47,48,53),
(11,7,27,47,30,49,49,54),
(11,7,28,48,31,50,50,55),
(11,7,29,49,31,51,51,57),
(11,7,30,50,32,53,52,58),
(11,7,31,51,33,54,53,59),
(11,7,32,52,33,55,55,61),
(11,7,33,53,34,56,56,62),
(11,7,34,55,34,58,57,64),
(11,7,35,56,35,59,58,65),
(11,7,36,57,36,60,60,66),
(11,7,37,58,36,62,61,68),
(11,7,38,59,37,63,62,69),
(11,7,39,61,38,65,63,71),
(11,7,40,62,38,66,65,72),
(11,7,41,63,39,67,66,74),
(11,7,42,64,40,69,67,75),
(11,7,43,65,40,70,69,77),
(11,7,44,67,41,72,70,78),
(11,7,45,68,42,73,71,80),
(11,7,46,69,42,75,73,81),
(11,7,47,71,43,76,74,83),
(11,7,48,72,44,78,76,84),
(11,7,49,73,45,79,77,86),
(11,7,50,74,45,81,78,88),
(11,7,51,76,46,82,80,89),
(11,7,52,77,47,84,81,91),
(11,7,53,78,47,85,83,92),
(11,7,54,80,48,87,84,94),
(11,7,55,81,49,88,86,96),
(11,7,56,83,50,90,87,97),
(11,7,57,84,50,91,89,99),
(11,7,58,85,51,93,90,101),
(11,7,59,87,52,95,92,102),
(11,7,60,88,53,96,93,104),
(11,7,61,90,54,98,95,106),
(11,7,62,91,54,99,96,108),
(11,7,63,93,55,101,98,109),
(11,7,64,94,56,103,99,111),
(11,7,65,95,57,104,101,113),
(11,7,66,97,58,106,103,115),
(11,7,67,98,58,108,104,117),
(11,7,68,100,59,110,106,118),
(11,7,69,101,60,111,107,120),
(11,7,70,103,61,113,109,122),
(11,7,71,104,62,115,122,124),
(11,7,72,106,63,117,124,127),
(11,7,73,108,64,119,126,129),
(11,7,74,110,65,122,128,131),
(11,7,75,112,66,124,130,133),
(11,7,76,114,67,126,133,136),
(11,7,77,115,68,128,135,138),
(11,7,78,117,69,130,137,140),
(11,7,79,119,70,133,139,143),
(11,7,80,121,71,135,141,145),
(11,8,1,21,17,19,24,24),
(11,8,2,21,17,19,25,25),
(11,8,3,21,17,20,27,27),
(11,8,4,21,17,20,28,28),
(11,8,5,21,18,20,29,29),
(11,8,6,21,18,20,31,31),
(11,8,7,21,18,21,32,32),
(11,8,8,22,18,21,34,33),
(11,8,9,22,18,21,35,35),
(11,8,10,22,19,22,37,36),
(11,8,11,22,19,22,38,37),
(11,8,12,22,19,22,40,39),
(11,8,13,22,19,23,41,40),
(11,8,14,22,19,23,43,42),
(11,8,15,22,19,23,44,43),
(11,8,16,22,20,24,46,45),
(11,8,17,23,20,24,47,46),
(11,8,18,23,20,24,49,48),
(11,8,19,23,20,25,50,49),
(11,8,20,23,21,25,52,51),
(11,8,21,23,21,26,54,52),
(11,8,22,23,21,26,55,54),
(11,8,23,23,21,26,57,56),
(11,8,24,24,21,27,59,57),
(11,8,25,24,22,27,60,59),
(11,8,26,24,22,27,62,60),
(11,8,27,24,22,28,64,62),
(11,8,28,24,22,28,65,64),
(11,8,29,24,23,29,67,65),
(11,8,30,24,23,29,69,67),
(11,8,31,25,23,30,71,69),
(11,8,32,25,23,30,73,71),
(11,8,33,25,24,30,74,72),
(11,8,34,25,24,31,76,74),
(11,8,35,25,24,31,78,76),
(11,8,36,26,24,32,80,78),
(11,8,37,26,25,32,82,79),
(11,8,38,26,25,33,84,81),
(11,8,39,26,25,33,86,83),
(11,8,40,26,26,34,87,85),
(11,8,41,27,26,34,89,87),
(11,8,42,27,26,35,91,89),
(11,8,43,27,27,35,93,91),
(11,8,44,27,27,36,95,92),
(11,8,45,27,27,36,97,94),
(11,8,46,28,27,37,99,96),
(11,8,47,28,28,37,101,98),
(11,8,48,28,28,38,103,100),
(11,8,49,28,28,38,105,102),
(11,8,50,29,29,39,107,104),
(11,8,51,29,29,39,110,106),
(11,8,52,29,29,40,112,108),
(11,8,53,29,30,40,114,110),
(11,8,54,30,30,41,116,112),
(11,8,55,30,30,41,118,114),
(11,8,56,30,31,42,120,116),
(11,8,57,30,31,42,122,118),
(11,8,58,31,31,43,125,121),
(11,8,59,31,32,43,127,123),
(11,8,60,31,32,44,129,125),
(11,8,61,31,33,45,131,127),
(11,8,62,32,33,45,133,129),
(11,8,63,32,33,46,136,131),
(11,8,64,32,34,46,138,134),
(11,8,65,33,34,47,140,136),
(11,8,66,33,34,48,143,138),
(11,8,67,33,35,48,145,140),
(11,8,68,33,35,49,147,142),
(11,8,69,34,36,49,150,145),
(11,8,70,34,36,50,152,147),
(11,8,71,34,36,51,155,150),
(11,8,72,34,37,52,161,153),
(11,8,73,34,37,53,161,156),
(11,8,74,35,38,53,164,158),
(11,8,75,35,38,54,167,161),
(11,8,76,35,38,55,170,164),
(11,8,77,36,39,56,173,167),
(11,8,78,36,39,56,176,170),
(11,8,79,36,40,57,179,173),
(11,8,80,37,40,58,182,176);
/*!40000 ALTER TABLE `player_levelstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_xp_for_level`
--

DROP TABLE IF EXISTS `player_xp_for_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_xp_for_level` (
  `lvl` int(3) unsigned NOT NULL,
  `xp_for_next_level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lvl`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_xp_for_level`
--

LOCK TABLES `player_xp_for_level` WRITE;
/*!40000 ALTER TABLE `player_xp_for_level` DISABLE KEYS */;
INSERT INTO `player_xp_for_level` VALUES
(1,400),
(2,900),
(3,1400),
(4,2100),
(5,2800),
(6,3600),
(7,4500),
(8,5400),
(9,6500),
(10,7600),
(11,8700),
(12,9800),
(13,11000),
(14,12300),
(15,13600),
(16,15000),
(17,16400),
(18,17800),
(19,19300),
(20,20800),
(21,22400),
(22,24000),
(23,25500),
(24,27200),
(25,28900),
(26,30500),
(27,32200),
(28,33900),
(29,36300),
(30,38800),
(31,41600),
(32,44600),
(33,48000),
(34,51400),
(35,55000),
(36,58700),
(37,62400),
(38,66200),
(39,70200),
(40,74300),
(41,78500),
(42,82800),
(43,87100),
(44,91600),
(45,96300),
(46,101000),
(47,105800),
(48,110700),
(49,115700),
(50,120900),
(51,126100),
(52,131500),
(53,137000),
(54,142500),
(55,148200),
(56,154000),
(57,159900),
(58,165800),
(59,172000),
(60,290000),
(61,317000),
(62,349000),
(63,386000),
(64,428000),
(65,475000),
(66,527000),
(67,585000),
(68,648000),
(69,717000),
(70,1523800),
(71,1539600),
(72,1555700),
(73,1571800),
(74,1587900),
(75,1604200),
(76,1620700),
(77,1637400),
(78,1653900),
(79,1670800);
/*!40000 ALTER TABLE `player_xp_for_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo`
--

DROP TABLE IF EXISTS `playercreateinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `zone` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo`
--

LOCK TABLES `playercreateinfo` WRITE;
/*!40000 ALTER TABLE `playercreateinfo` DISABLE KEYS */;
INSERT INTO `playercreateinfo` VALUES 
(1,1,0,12,-8949.95,-132.493,83.5312,0),
(1,2,0,12,-8949.95,-132.493,83.5312,0),
(1,4,0,12,-8949.95,-132.493,83.5312,0),
(1,5,0,12,-8949.95,-132.493,83.5312,0),
(1,8,0,12,-8949.95,-132.493,83.5312,0),
(1,9,0,12,-8949.95,-132.493,83.5312,0),
(2,1,1,14,-618.518,-4251.67,38.718,0),
(2,3,1,14,-618.518,-4251.67,38.718,0),
(2,4,1,14,-618.518,-4251.67,38.718,0),
(2,7,1,14,-618.518,-4251.67,38.718,0),
(2,9,1,14,-618.518,-4251.67,38.718,0),
(3,1,0,1,-6240.32,331.033,382.758,6.17716),
(3,2,0,1,-6240.32,331.033,382.758,6.17716),
(3,3,0,1,-6240.32,331.033,382.758,6.17716),
(3,4,0,1,-6240.32,331.033,382.758,6.17716),
(3,5,0,1,-6240.32,331.033,382.758,6.17716),
(4,1,1,141,10311.3,832.463,1326.41,5.69632),
(4,3,1,141,10311.3,832.463,1326.41,5.69632),
(4,4,1,141,10311.3,832.463,1326.41,5.69632),
(4,5,1,141,10311.3,832.463,1326.41,5.69632),
(4,11,1,141,10311.3,832.463,1326.41,5.69632),
(5,1,0,85,1676.71,1678.31,121.67,2.70526),
(5,4,0,85,1676.71,1678.31,121.67,2.70526),
(5,5,0,85,1676.71,1678.31,121.67,2.70526),
(5,8,0,85,1676.71,1678.31,121.67,2.70526),
(5,9,0,85,1676.71,1678.31,121.67,2.70526),
(6,1,1,215,-2917.58,-257.98,52.9968,0),
(6,3,1,215,-2917.58,-257.98,52.9968,0),
(6,7,1,215,-2917.58,-257.98,52.9968,0),
(6,11,1,215,-2917.58,-257.98,52.9968,0),
(7,1,0,1,-6240.32,331.033,382.758,0),
(7,9,0,1,-6240,331,383,0),
(7,8,0,1,-6240,331,383,0),
(7,4,0,1,-6240,331,383,0),
(8,1,1,14,-618.518,-4251.67,38.718,0),
(8,3,1,14,-618.518,-4251.67,38.718,0),
(8,4,1,14,-618.518,-4251.67,38.718,0),
(8,5,1,14,-618.518,-4251.67,38.718,0),
(8,7,1,14,-618.518,-4251.67,38.718,0),
(8,8,1,14,-618.518,-4251.67,38.718,0),
(10,2,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,3,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,4,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,5,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,8,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,9,530,3431,10349.6,-6357.29,33.4026,5.31605),
(11,1,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,2,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,3,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,5,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,7,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,8,530,3526,-3961.64,-13931.2,100.615,2.08364),
(1,6,609,4298,2355.84,-5664.77,426.028,3.65997),
(2,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(3,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(4,6,609,4298,2356.21,-5662.21,426.026,3.65997),
(5,6,609,4298,2356.21,-5662.21,426.026,3.65997),
(6,6,609,4298,2358.17,-5663.21,426.027,3.65997),
(7,6,609,4298,2355.05,-5661.7,426.026,3.65997),
(8,6,609,4298,2355.05,-5661.7,426.026,3.65997),
(10,6,609,4298,2355.84,-5664.77,426.028,3.65997),
(11,6,609,4298,2358.17,-5663.21,426.027,3.65997);
/*!40000 ALTER TABLE `playercreateinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_action`
--

DROP TABLE IF EXISTS `playercreateinfo_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_action` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `button` smallint(5) unsigned NOT NULL DEFAULT '0',
  `action` int(11) unsigned NOT NULL DEFAULT '0',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`,`button`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_action`
--

LOCK TABLES `playercreateinfo_action` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_action` DISABLE KEYS */;
INSERT INTO `playercreateinfo_action` (`race`,`class`,`button`,`action`,`type`) VALUES
(10,6,2,45477,0),
(10,6,3,45462,0),
(10,6,4,45902,0),
(10,6,5,47541,0),
(10,6,6,50613,0),
(10,8,0,133,0),
(10,8,1,168,0),
(10,8,2,28730,0),
(10,9,0,686,0),
(10,9,1,687,0),
(10,9,2,28730,0),
(11,1,0,6603,0),
(11,1,72,6603,0),
(11,1,73,78,0),
(11,1,74,28880,0),
(11,1,84,6603,0),
(11,1,96,6603,0),
(11,1,108,6603,0),
(11,2,0,6603,0),
(11,2,1,21084,0),
(11,2,2,635,0),
(11,2,3,59542,0),
(11,3,0,6603,0),
(11,3,1,2973,0),
(11,3,2,75,0),
(11,3,3,59543,0),
(11,3,72,6603,0),
(11,3,73,2973,0),
(11,3,74,75,0),
(11,5,0,585,0),
(11,5,1,2050,0),
(11,5,2,59544,0),
(11,6,0,6603,0),
(11,6,1,49576,0),
(11,6,2,45477,0),
(11,6,3,45462,0),
(11,6,4,45902,0),
(11,6,5,47541,0),
(11,6,10,59545,0),
(11,7,0,6603,0),
(11,7,1,403,0),
(11,7,2,331,0),
(11,7,3,59547,0),
(11,8,0,133,0),
(11,8,1,168,0),
(11,8,2,59548,0),
(11,6,11,41751,128);
/*!40000 ALTER TABLE `playercreateinfo_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_item`
--

DROP TABLE IF EXISTS `playercreateinfo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_item` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `itemid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `amount` tinyint(3) NOT NULL DEFAULT '1',
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_item`
--

LOCK TABLES `playercreateinfo_item` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `playercreateinfo_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_spell`
--

DROP TABLE IF EXISTS `playercreateinfo_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_spell` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`race`,`class`,`Spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_spell`
--

LOCK TABLES `playercreateinfo_spell` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_spell` DISABLE KEYS */;
INSERT INTO `playercreateinfo_spell` VALUES (1,1,78,'Heroic Strike'),
(1,1,81,'Dodge'),
(1,1,107,'Block'),
(1,1,196,'One-Handed Axes'),
(1,1,198,'One-Handed Maces'),
(1,1,201,'One-Handed Swords'),
(1,1,203,'Unarmed'),
(1,1,204,'Defense'),
(1,1,522,'SPELLDEFENSE (DND)'),
(1,1,668,'Language Common'),
(1,1,1843,'Disarm'),
(1,1,2382,'Generic'),
(1,1,2457,'Battle Stance'),
(1,1,2479,'Honorless Target'),
(1,1,3050,'Detect'),
(1,1,3365,'Opening'),
(1,1,5301,'Defensive State (DND)'),
(1,1,6233,'Closing'),
(1,1,6246,'Closing'),
(1,1,6247,'Opening'),
(1,1,6477,'Opening'),
(1,1,6478,'Opening'),
(1,1,6603,'Attack'),
(1,1,7266,'Duel'),
(1,1,7267,'Grovel'),
(1,1,7355,'Stuck'),
(1,1,8386,'Attacking'),
(1,1,8737,'Mail'),
(1,1,9077,'Leather'),
(1,1,9078,'Cloth'),
(1,1,9116,'Shield'),
(1,1,9125,'Generic'),
(1,1,20597,'Sword Specialization'),
(1,1,20598,'The Human Spirit'),
(1,1,20599,'Diplomacy'),
(1,1,20864,'Mace Specialization'),
(1,1,21651,'Opening'),
(1,1,21652,'Closing'),
(1,1,22027,'Remove Insignia'),
(1,1,22810,'Opening - No Text'),
(1,1,32215,'Victorious State'),
(1,1,45927,'Summon Friend'),
(1,1,58985,'Perception'),
(1,1,59752,'Every Man for Himself'),
(1,1,61437,'Opening'),
(1,2,81,'Dodge'),
(1,2,107,'Block'),
(1,2,198,'One-Handed Maces'),
(1,2,199,'Two-Handed Maces'),
(1,2,203,'Unarmed'),
(1,2,204,'Defense'),
(1,2,522,'SPELLDEFENSE (DND)'),
(1,2,635,'Holy Light'),
(1,2,668,'Language Common'),
(1,2,1843,'Disarm'),
(1,2,2382,'Generic'),
(1,2,2479,'Honorless Target'),
(1,2,3050,'Detect'),
(1,2,3365,'Opening'),
(1,2,6233,'Closing'),
(1,2,6246,'Closing'),
(1,2,6247,'Opening'),
(1,2,6477,'Opening'),
(1,2,6478,'Opening'),
(1,2,6603,'Attack'),
(1,2,7266,'Duel'),
(1,2,7267,'Grovel'),
(1,2,7355,'Stuck'),
(1,2,8386,'Attacking'),
(1,2,8737,'Mail'),
(1,2,9077,'Leather'),
(1,2,9078,'Cloth'),
(1,2,9116,'Shield'),
(1,2,9125,'Generic'),
(1,2,21084,'Seal of Righteousness'),
(1,2,20597,'Sword Specialization'),
(1,2,20598,'The Human Spirit'),
(1,2,20599,'Diplomacy'),
(1,2,20864,'Mace Specialization'),
(1,2,21651,'Opening'),
(1,2,21652,'Closing'),
(1,2,22027,'Remove Insignia'),
(1,2,22810,'Opening - No Text'),
(1,2,27762,'Libram'),
(1,2,45927,'Summon Friend'),
(1,2,58985,'Perception'),
(1,2,59752,'Every Man for Himself'),
(1,2,61437,'Opening'),
(1,4,81,'Dodge'),
(1,4,203,'Unarmed'),
(1,4,204,'Defense'),
(1,4,522,'SPELLDEFENSE (DND)'),
(1,4,668,'Language Common'),
(1,4,1180,'Daggers'),
(1,4,1752,'Sinister Strike'),
(1,4,1843,'Disarm'),
(1,4,2098,'Eviscerate'),
(1,4,2382,'Generic'),
(1,4,2479,'Honorless Target'),
(1,4,2567,'Thrown'),
(1,4,2764,'Throw'),
(1,4,3050,'Detect'),
(1,4,3365,'Opening'),
(1,4,6233,'Closing'),
(1,4,6246,'Closing'),
(1,4,6247,'Opening'),
(1,4,6477,'Opening'),
(1,4,6478,'Opening'),
(1,4,6603,'Attack'),
(1,4,7266,'Duel'),
(1,4,7267,'Grovel'),
(1,4,7355,'Stuck'),
(1,4,8386,'Attacking'),
(1,4,9077,'Leather'),
(1,4,9078,'Cloth'),
(1,4,9125,'Generic'),
(1,4,16092,'Defensive State (DND)'),
(1,4,20597,'Sword Specialization'),
(1,4,20598,'The Human Spirit'),
(1,4,20599,'Diplomacy'),
(1,4,20864,'Mace Specialization'),
(1,4,21184,'Rogue Passive (DND)'),
(1,4,21651,'Opening'),
(1,4,21652,'Closing'),
(1,4,22027,'Remove Insignia'),
(1,4,22810,'Opening - No Text'),
(1,4,45927,'Summon Friend'),
(1,4,58985,'Perception'),
(1,4,59752,'Every Man for Himself'),
(1,4,61437,'Opening'),
(1,5,81,'Dodge'),
(1,5,198,'One-Handed Maces'),
(1,5,203,'Unarmed'),
(1,5,204,'Defense'),
(1,5,522,'SPELLDEFENSE (DND)'),
(1,5,585,'Smite'),
(1,5,668,'Language Common'),
(1,5,1843,'Disarm'),
(1,5,2050,'Lesser Heal'),
(1,5,2382,'Generic'),
(1,5,2479,'Honorless Target'),
(1,5,3050,'Detect'),
(1,5,3365,'Opening'),
(1,5,5009,'Wands'),
(1,5,5019,'Shoot'),
(1,5,6233,'Closing'),
(1,5,6246,'Closing'),
(1,5,6247,'Opening'),
(1,5,6477,'Opening'),
(1,5,6478,'Opening'),
(1,5,6603,'Attack'),
(1,5,7266,'Duel'),
(1,5,7267,'Grovel'),
(1,5,7355,'Stuck'),
(1,5,8386,'Attacking'),
(1,5,9078,'Cloth'),
(1,5,9125,'Generic'),
(1,5,20597,'Sword Specialization'),
(1,5,20598,'The Human Spirit'),
(1,5,20599,'Diplomacy'),
(1,5,20864,'Mace Specialization'),
(1,5,21651,'Opening'),
(1,5,21652,'Closing'),
(1,5,22027,'Remove Insignia'),
(1,5,22810,'Opening - No Text'),
(1,5,45927,'Summon Friend'),
(1,5,58985,'Perception'),
(1,5,59752,'Every Man for Himself'),
(1,5,61437,'Opening'),
(1,6,81,'Dodge'),
(1,6,196,'One-Handed Axes'),
(1,6,197,'Two-Handed Axes'),
(1,6,200,'Polearms'),
(1,6,201,'One-Handed Swords'),
(1,6,202,'Two-Handed Swords'),
(1,6,203,'Unarmed'),
(1,6,204,'Defense'),
(1,6,522,'SPELLDEFENSE (DND)'),
(1,6,668,'Language Common'),
(1,6,674,'Dual Wield'),
(1,6,750,'Plate Mail'),
(1,6,1843,'Disarm'),
(1,6,2382,'Generic'),
(1,6,2479,'Honorless Target'),
(1,6,3050,'Detect'),
(1,6,3127,'Parry'),
(1,6,3275,'Linen Bandage'),
(1,6,3276,'Heavy Linen Bandage'),
(1,6,3277,'Wool Bandage'),
(1,6,3278,'Heavy Wool Bandage'),
(1,6,3365,'Opening'),
(1,6,6233,'Closing'),
(1,6,6246,'Closing'),
(1,6,6247,'Opening'),
(1,6,6477,'Opening'),
(1,6,6478,'Opening'),
(1,6,6603,'Attack'),
(1,6,7266,'Duel'),
(1,6,7267,'Grovel'),
(1,6,7355,'Stuck'),
(1,6,7928,'Silk Bandage'),
(1,6,7929,'Heavy Silk Bandage'),
(1,6,7934,'Anti-Venom'),
(1,6,8386,'Attacking'),
(1,6,8737,'Mail'),
(1,6,9077,'Leather'),
(1,6,9078,'Cloth'),
(1,6,9125,'Generic'),
(1,6,10840,'Mageweave Bandage'),
(1,6,10841,'Heavy Mageweave Bandage'),
(1,6,10846,'First Aid'),
(1,6,18629,'Runecloth Bandage'),
(1,6,18630,'Heavy Runecloth Bandage'),
(1,6,20597,'Sword Specialization'),
(1,6,20598,'The Human Spirit'),
(1,6,20599,'Diplomacy'),
(1,6,20864,'Mace Specialization'),
(1,6,21651,'Opening'),
(1,6,21652,'Closing'),
(1,6,22027,'Remove Insignia'),
(1,6,22810,'Opening - No Text'),
(1,6,33391,'Journeyman Riding'),
(1,6,45462,'Plague Strike'),
(1,6,45477,'Icy Touch'),
(1,6,45902,'Blood Strike'),
(1,6,45903,'Offensive State (DND)'),
(1,6,45927,'Summon Friend'),
(1,6,47541,'Death Coil'),
(1,6,48266,'Blood Presence'),
(1,6,49410,'Forceful Deflection'),
(1,6,49576,'Death Grip'),
(1,6,52665,'Sigil'),
(1,6,58985,'Perception'),
(1,6,59752,'Every Man for Himself'),
(1,6,59879,'Blood Plague'),
(1,6,59921,'Frost Fever'),
(1,6,61437,'Opening'),
(1,6,61455,'Runic Focus'),
(1,8,81,'Dodge'),
(1,8,133,'Fireball'),
(1,8,168,'Frost Armor'),
(1,8,203,'Unarmed'),
(1,8,204,'Defense'),
(1,8,227,'Staves'),
(1,8,522,'SPELLDEFENSE (DND)'),
(1,8,668,'Language Common'),
(1,8,1843,'Disarm'),
(1,8,2382,'Generic'),
(1,8,2479,'Honorless Target'),
(1,8,3050,'Detect'),
(1,8,3365,'Opening'),
(1,8,5009,'Wands'),
(1,8,5019,'Shoot'),
(1,8,6233,'Closing'),
(1,8,6246,'Closing'),
(1,8,6247,'Opening'),
(1,8,6477,'Opening'),
(1,8,6478,'Opening'),
(1,8,6603,'Attack'),
(1,8,7266,'Duel'),
(1,8,7267,'Grovel'),
(1,8,7355,'Stuck'),
(1,8,8386,'Attacking'),
(1,8,9078,'Cloth'),
(1,8,9125,'Generic'),
(1,8,20597,'Sword Specialization'),
(1,8,20598,'The Human Spirit'),
(1,8,20599,'Diplomacy'),
(1,8,20864,'Mace Specialization'),
(1,8,21651,'Opening'),
(1,8,21652,'Closing'),
(1,8,22027,'Remove Insignia'),
(1,8,22810,'Opening - No Text'),
(1,8,45927,'Summon Friend'),
(1,8,58985,'Perception'),
(1,8,59752,'Every Man for Himself'),
(1,8,61437,'Opening'),
(1,9,81,'Dodge'),
(1,9,203,'Unarmed'),
(1,9,204,'Defense'),
(1,9,522,'SPELLDEFENSE (DND)'),
(1,9,668,'Language Common'),
(1,9,686,'Shadow Bolt'),
(1,9,687,'Demon Skin'),
(1,9,1180,'Daggers'),
(1,9,1843,'Disarm'),
(1,9,2382,'Generic'),
(1,9,2479,'Honorless Target'),
(1,9,3050,'Detect'),
(1,9,3365,'Opening'),
(1,9,5009,'Wands'),
(1,9,5019,'Shoot'),
(1,9,6233,'Closing'),
(1,9,6246,'Closing'),
(1,9,6247,'Opening'),
(1,9,6477,'Opening'),
(1,9,6478,'Opening'),
(1,9,6603,'Attack'),
(1,9,7266,'Duel'),
(1,9,7267,'Grovel'),
(1,9,7355,'Stuck'),
(1,9,8386,'Attacking'),
(1,9,9078,'Cloth'),
(1,9,9125,'Generic'),
(1,9,20597,'Sword Specialization'),
(1,9,20598,'The Human Spirit'),
(1,9,20599,'Diplomacy'),
(1,9,20864,'Mace Specialization'),
(1,9,21651,'Opening'),
(1,9,21652,'Closing'),
(1,9,22027,'Remove Insignia'),
(1,9,22810,'Opening - No Text'),
(1,9,45927,'Summon Friend'),
(5,9,58284,'Chaos Bolt Passive'),
(1,9,58985,'Perception'),
(1,9,59752,'Every Man for Himself'),
(1,9,61437,'Opening'),
(2,1,78,'Heroic Strike'),
(2,1,81,'Dodge'),
(2,1,107,'Block'),
(2,1,196,'One-Handed Axes'),
(2,1,197,'Two-Handed Axes'),
(2,1,201,'One-Handed Swords'),
(2,1,203,'Unarmed'),
(2,1,204,'Defense'),
(2,1,522,'SPELLDEFENSE (DND)'),
(2,1,669,'Language Orcish'),
(2,1,1843,'Disarm'),
(2,1,2382,'Generic'),
(2,1,2457,'Battle Stance'),
(2,1,2479,'Honorless Target'),
(2,1,3050,'Detect'),
(2,1,3365,'Opening'),
(2,1,5301,'Defensive State (DND)'),
(2,1,6233,'Closing'),
(2,1,6246,'Closing'),
(2,1,6247,'Opening'),
(2,1,6477,'Opening'),
(2,1,6478,'Opening'),
(2,1,6603,'Attack'),
(2,1,7266,'Duel'),
(2,1,7267,'Grovel'),
(2,1,7355,'Stuck'),
(2,1,8386,'Attacking'),
(2,1,8737,'Mail'),
(2,1,9077,'Leather'),
(2,1,9078,'Cloth'),
(2,1,9116,'Shield'),
(2,1,9125,'Generic'),
(2,1,20572,'Blood Fury'),
(2,1,20573,'Hardiness'),
(2,1,20574,'Axe Specialization'),
(2,1,21563,'Command'),
(2,1,21651,'Opening'),
(2,1,21652,'Closing'),
(2,1,22027,'Remove Insignia'),
(2,1,22810,'Opening - No Text'),
(2,1,32215,'Victorious State'),
(2,1,45927,'Summon Friend'),
(2,1,61437,'Opening'),
(2,3,75,'Auto Shot'),
(2,3,81,'Dodge'),
(2,3,196,'One-Handed Axes'),
(2,3,203,'Unarmed'),
(2,3,204,'Defense'),
(2,3,264,'Bows'),
(2,3,522,'SPELLDEFENSE (DND)'),
(2,3,669,'Language Orcish'),
(2,3,1843,'Disarm'),
(2,3,2382,'Generic'),
(2,3,2479,'Honorless Target'),
(2,3,2973,'Raptor Strike'),
(2,3,3050,'Detect'),
(2,3,3365,'Opening'),
(2,3,6233,'Closing'),
(2,3,6246,'Closing'),
(2,3,6247,'Opening'),
(2,3,6477,'Opening'),
(2,3,6478,'Opening'),
(2,3,6603,'Attack'),
(2,3,7266,'Duel'),
(2,3,7267,'Grovel'),
(2,3,7355,'Stuck'),
(2,3,8386,'Attacking'),
(2,3,9077,'Leather'),
(2,3,9078,'Cloth'),
(2,3,9125,'Generic'),
(2,3,13358,'Defensive State (DND)'),
(2,3,20572,'Blood Fury'),
(2,3,20573,'Hardiness'),
(2,3,20574,'Axe Specialization'),
(2,3,20576,'Command'),
(2,3,21651,'Opening'),
(2,3,21652,'Closing'),
(2,3,22027,'Remove Insignia'),
(2,3,22810,'Opening - No Text'),
(2,3,24949,'Defensive State 2 (DND)'),
(2,3,34082,'Advantaged State (DND)'),
(2,3,45927,'Summon Friend'),
(2,3,61437,'Opening'),
(2,4,81,'Dodge'),
(2,4,203,'Unarmed'),
(2,4,204,'Defense'),
(2,4,522,'SPELLDEFENSE (DND)'),
(2,4,669,'Language Orcish'),
(2,4,1180,'Daggers'),
(2,4,1752,'Sinister Strike'),
(2,4,1843,'Disarm'),
(2,4,2098,'Eviscerate'),
(2,4,2382,'Generic'),
(2,4,2479,'Honorless Target'),
(2,4,2567,'Thrown'),
(2,4,2764,'Throw'),
(2,4,3050,'Detect'),
(2,4,3365,'Opening'),
(2,4,6233,'Closing'),
(2,4,6246,'Closing'),
(2,4,6247,'Opening'),
(2,4,6477,'Opening'),
(2,4,6478,'Opening'),
(2,4,6603,'Attack'),
(2,4,7266,'Duel'),
(2,4,7267,'Grovel'),
(2,4,7355,'Stuck'),
(2,4,8386,'Attacking'),
(2,4,9077,'Leather'),
(2,4,9078,'Cloth'),
(2,4,9125,'Generic'),
(2,4,16092,'Defensive State (DND)'),
(2,4,20572,'Blood Fury'),
(2,4,20573,'Hardiness'),
(2,4,20574,'Axe Specialization'),
(2,4,21184,'Rogue Passive (DND)'),
(2,4,21563,'Command'),
(2,4,21651,'Opening'),
(2,4,21652,'Closing'),
(2,4,22027,'Remove Insignia'),
(2,4,22810,'Opening - No Text'),
(2,4,45927,'Summon Friend'),
(2,4,61437,'Opening'),
(2,6,81,'Dodge'),
(2,6,196,'One-Handed Axes'),
(2,6,197,'Two-Handed Axes'),
(2,6,200,'Polearms'),
(2,6,201,'One-Handed Swords'),
(2,6,202,'Two-Handed Swords'),
(2,6,203,'Unarmed'),
(2,6,204,'Defense'),
(2,6,522,'SPELLDEFENSE (DND)'),
(2,6,669,'Language Orcish'),
(2,6,674,'Dual Wield'),
(2,6,750,'Plate Mail'),
(2,6,1843,'Disarm'),
(2,6,2382,'Generic'),
(2,6,2479,'Honorless Target'),
(2,6,3050,'Detect'),
(2,6,3127,'Parry'),
(2,6,3275,'Linen Bandage'),
(2,6,3276,'Heavy Linen Bandage'),
(2,6,3277,'Wool Bandage'),
(2,6,3278,'Heavy Wool Bandage'),
(2,6,3365,'Opening'),
(2,6,6233,'Closing'),
(2,6,6246,'Closing'),
(2,6,6247,'Opening'),
(2,6,6477,'Opening'),
(2,6,6478,'Opening'),
(2,6,6603,'Attack'),
(2,6,7266,'Duel'),
(2,6,7267,'Grovel'),
(2,6,7355,'Stuck'),
(2,6,7928,'Silk Bandage'),
(2,6,7929,'Heavy Silk Bandage'),
(2,6,7934,'Anti-Venom'),
(2,6,8386,'Attacking'),
(2,6,8737,'Mail'),
(2,6,9077,'Leather'),
(2,6,9078,'Cloth'),
(2,6,9125,'Generic'),
(2,6,10840,'Mageweave Bandage'),
(2,6,10841,'Heavy Mageweave Bandage'),
(2,6,10846,'First Aid'),
(2,6,18629,'Runecloth Bandage'),
(2,6,18630,'Heavy Runecloth Bandage'),
(2,6,20572,'Blood Fury'),
(2,6,20573,'Hardiness'),
(2,6,20574,'Axe Specialization'),
(2,6,21651,'Opening'),
(2,6,21652,'Closing'),
(2,6,22027,'Remove Insignia'),
(2,6,22810,'Opening - No Text'),
(2,6,33391,'Journeyman Riding'),
(2,6,45462,'Plague Strike'),
(2,6,45477,'Icy Touch'),
(2,6,45902,'Blood Strike'),
(2,6,45903,'Offensive State (DND)'),
(2,6,45927,'Summon Friend'),
(2,6,47541,'Death Coil'),
(2,6,48266,'Blood Presence'),
(2,6,49410,'Forceful Deflection'),
(2,6,49576,'Death Grip'),
(2,6,52665,'Sigil'),
(2,6,54562,'Command'),
(2,6,59879,'Blood Plague'),
(2,6,59921,'Frost Fever'),
(2,6,61437,'Opening'),
(2,6,61455,'Runic Focus'),
(2,7,81,'Dodge'),
(2,7,107,'Block'),
(2,7,198,'One-Handed Maces'),
(2,7,203,'Unarmed'),
(2,7,204,'Defense'),
(2,7,227,'Staves'),
(2,7,331,'Healing Wave'),
(2,7,403,'Lightning Bolt'),
(2,7,522,'SPELLDEFENSE (DND)'),
(2,7,669,'Language Orcish'),
(2,7,1843,'Disarm'),
(2,7,2382,'Generic'),
(2,7,2479,'Honorless Target'),
(2,7,3050,'Detect'),
(2,7,3365,'Opening'),
(2,7,6233,'Closing'),
(2,7,6246,'Closing'),
(2,7,6247,'Opening'),
(2,7,6477,'Opening'),
(2,7,6478,'Opening'),
(2,7,6603,'Attack'),
(2,7,7266,'Duel'),
(2,7,7267,'Grovel'),
(2,7,7355,'Stuck'),
(2,7,8386,'Attacking'),
(2,7,9077,'Leather'),
(2,7,9078,'Cloth'),
(2,7,9116,'Shield'),
(2,7,9125,'Generic'),
(2,7,20573,'Hardiness'),
(2,7,20574,'Axe Specialization'),
(2,7,21563,'Command'),
(2,7,21651,'Opening'),
(2,7,21652,'Closing'),
(2,7,22027,'Remove Insignia'),
(2,7,22810,'Opening - No Text'),
(2,7,27763,'Totem'),
(2,7,33697,'Blood Fury'),
(2,7,45927,'Summon Friend'),
(2,7,61437,'Opening'),
(2,9,81,'Dodge'),
(2,9,203,'Unarmed'),
(2,9,204,'Defense'),
(2,9,522,'SPELLDEFENSE (DND)'),
(2,9,669,'Language Orcish'),
(2,9,686,'Shadow Bolt'),
(2,9,687,'Demon Skin'),
(2,9,1180,'Daggers'),
(2,9,1843,'Disarm'),
(2,9,2382,'Generic'),
(2,9,2479,'Honorless Target'),
(2,9,3050,'Detect'),
(2,9,3365,'Opening'),
(2,9,5009,'Wands'),
(2,9,5019,'Shoot'),
(2,9,6233,'Closing'),
(2,9,6246,'Closing'),
(2,9,6247,'Opening'),
(2,9,6477,'Opening'),
(2,9,6478,'Opening'),
(2,9,6603,'Attack'),
(2,9,7266,'Duel'),
(2,9,7267,'Grovel'),
(2,9,7355,'Stuck'),
(2,9,8386,'Attacking'),
(2,9,9078,'Cloth'),
(2,9,9125,'Generic'),
(2,9,20573,'Hardiness'),
(2,9,20574,'Axe Specialization'),
(2,9,20575,'Command'),
(2,9,21651,'Opening'),
(2,9,21652,'Closing'),
(2,9,22027,'Remove Insignia'),
(2,9,22810,'Opening - No Text'),
(2,9,33702,'Blood Fury'),
(2,9,45927,'Summon Friend'),
(2,9,58284,'Chaos Bolt Passive'),
(2,9,61437,'Opening'),
(3,1,78,'Heroic Strike'),
(3,1,81,'Dodge'),
(3,1,107,'Block'),
(3,1,196,'One-Handed Axes'),
(3,1,197,'Two-Handed Axes'),
(3,1,198,'One-Handed Maces'),
(3,1,203,'Unarmed'),
(3,1,204,'Defense'),
(3,1,522,'SPELLDEFENSE (DND)'),
(3,1,668,'Language Common'),
(3,1,672,'Language Dwarven'),
(3,1,1843,'Disarm'),
(3,1,2382,'Generic'),
(3,1,2457,'Battle Stance'),
(3,1,2479,'Honorless Target'),
(3,1,2481,'Find Treasure'),
(3,1,3050,'Detect'),
(3,1,3365,'Opening'),
(3,1,5301,'Defensive State (DND)'),
(3,1,6233,'Closing'),
(3,1,6246,'Closing'),
(3,1,6247,'Opening'),
(3,1,6477,'Opening'),
(3,1,6478,'Opening'),
(3,1,6603,'Attack'),
(3,1,7266,'Duel'),
(3,1,7267,'Grovel'),
(3,1,7355,'Stuck'),
(3,1,8386,'Attacking'),
(3,1,8737,'Mail'),
(3,1,9077,'Leather'),
(3,1,9078,'Cloth'),
(3,1,9116,'Shield'),
(3,1,9125,'Generic'),
(3,1,20594,'Stoneform'),
(3,1,20595,'Gun Specialization'),
(3,1,20596,'Frost Resistance'),
(3,1,21651,'Opening'),
(3,1,21652,'Closing'),
(3,1,22027,'Remove Insignia'),
(3,1,22810,'Opening - No Text'),
(3,1,32215,'Victorious State'),
(3,1,45927,'Summon Friend'),
(3,1,59224,'Mace Specialization'),
(3,1,61437,'Opening'),
(3,2,81,'Dodge'),
(3,2,107,'Block'),
(3,2,198,'One-Handed Maces'),
(3,2,199,'Two-Handed Maces'),
(3,2,203,'Unarmed'),
(3,2,204,'Defense'),
(3,2,522,'SPELLDEFENSE (DND)'),
(3,2,635,'Holy Light'),
(3,2,668,'Language Common'),
(3,2,672,'Language Dwarven'),
(3,2,1843,'Disarm'),
(3,2,2382,'Generic'),
(3,2,2479,'Honorless Target'),
(3,2,2481,'Find Treasure'),
(3,2,3050,'Detect'),
(3,2,3365,'Opening'),
(3,2,6233,'Closing'),
(3,2,6246,'Closing'),
(3,2,6247,'Opening'),
(3,2,6477,'Opening'),
(3,2,6478,'Opening'),
(3,2,6603,'Attack'),
(3,2,7266,'Duel'),
(3,2,7267,'Grovel'),
(3,2,7355,'Stuck'),
(3,2,8386,'Attacking'),
(3,2,8737,'Mail'),
(3,2,9077,'Leather'),
(3,2,9078,'Cloth'),
(3,2,9116,'Shield'),
(3,2,9125,'Generic'),
(3,2,21084,'Seal of Righteousness'),
(3,2,20594,'Stoneform'),
(3,2,20595,'Gun Specialization'),
(3,2,20596,'Frost Resistance'),
(3,2,21651,'Opening'),
(3,2,21652,'Closing'),
(3,2,22027,'Remove Insignia'),
(3,2,22810,'Opening - No Text'),
(3,2,27762,'Libram'),
(3,2,45927,'Summon Friend'),
(3,2,59224,'Mace Specialization'),
(3,2,61437,'Opening'),
(3,3,75,'Auto Shot'),
(3,3,81,'Dodge'),
(3,3,196,'One-Handed Axes'),
(3,3,203,'Unarmed'),
(3,3,204,'Defense'),
(3,3,266,'Guns'),
(3,3,522,'SPELLDEFENSE (DND)'),
(3,3,668,'Language Common'),
(3,3,672,'Language Dwarven'),
(3,3,1843,'Disarm'),
(3,3,2382,'Generic'),
(3,3,2479,'Honorless Target'),
(3,3,2481,'Find Treasure'),
(3,3,2973,'Raptor Strike'),
(3,3,3050,'Detect'),
(3,3,3365,'Opening'),
(3,3,6233,'Closing'),
(3,3,6246,'Closing'),
(3,3,6247,'Opening'),
(3,3,6477,'Opening'),
(3,3,6478,'Opening'),
(3,3,6603,'Attack'),
(3,3,7266,'Duel'),
(3,3,7267,'Grovel'),
(3,3,7355,'Stuck'),
(3,3,8386,'Attacking'),
(3,3,9077,'Leather'),
(3,3,9078,'Cloth'),
(3,3,9125,'Generic'),
(3,3,13358,'Defensive State (DND)'),
(3,3,20594,'Stoneform'),
(3,3,20595,'Gun Specialization'),
(3,3,20596,'Frost Resistance'),
(3,3,21651,'Opening'),
(3,3,21652,'Closing'),
(3,3,22027,'Remove Insignia'),
(3,3,22810,'Opening - No Text'),
(3,3,24949,'Defensive State 2 (DND)'),
(3,3,34082,'Advantaged State (DND)'),
(3,3,45927,'Summon Friend'),
(3,3,59224,'Mace Specialization'),
(3,3,61437,'Opening'),
(3,4,81,'Dodge'),
(3,4,203,'Unarmed'),
(3,4,204,'Defense'),
(3,4,522,'SPELLDEFENSE (DND)'),
(3,4,668,'Language Common'),
(3,4,672,'Language Dwarven'),
(3,4,1180,'Daggers'),
(3,4,1752,'Sinister Strike'),
(3,4,1843,'Disarm'),
(3,4,2098,'Eviscerate'),
(3,4,2382,'Generic'),
(3,4,2479,'Honorless Target'),
(3,4,2481,'Find Treasure'),
(3,4,2567,'Thrown'),
(3,4,2764,'Throw'),
(3,4,3050,'Detect'),
(3,4,3365,'Opening'),
(3,4,6233,'Closing'),
(3,4,6246,'Closing'),
(3,4,6247,'Opening'),
(3,4,6477,'Opening'),
(3,4,6478,'Opening'),
(3,4,6603,'Attack'),
(3,4,7266,'Duel'),
(3,4,7267,'Grovel'),
(3,4,7355,'Stuck'),
(3,4,8386,'Attacking'),
(3,4,9077,'Leather'),
(3,4,9078,'Cloth'),
(3,4,9125,'Generic'),
(3,4,16092,'Defensive State (DND)'),
(3,4,20594,'Stoneform'),
(3,4,20595,'Gun Specialization'),
(3,4,20596,'Frost Resistance'),
(3,4,21184,'Rogue Passive (DND)'),
(3,4,21651,'Opening'),
(3,4,21652,'Closing'),
(3,4,22027,'Remove Insignia'),
(3,4,22810,'Opening - No Text'),
(3,4,45927,'Summon Friend'),
(3,4,59224,'Mace Specialization'),
(3,4,61437,'Opening'),
(3,5,81,'Dodge'),
(3,5,198,'One-Handed Maces'),
(3,5,203,'Unarmed'),
(3,5,204,'Defense'),
(3,5,522,'SPELLDEFENSE (DND)'),
(3,5,585,'Smite'),
(3,5,668,'Language Common'),
(3,5,672,'Language Dwarven'),
(3,5,1843,'Disarm'),
(3,5,2050,'Lesser Heal'),
(3,5,2382,'Generic'),
(3,5,2479,'Honorless Target'),
(3,5,2481,'Find Treasure'),
(3,5,3050,'Detect'),
(3,5,3365,'Opening'),
(3,5,5009,'Wands'),
(3,5,5019,'Shoot'),
(3,5,6233,'Closing'),
(3,5,6246,'Closing'),
(3,5,6247,'Opening'),
(3,5,6477,'Opening'),
(3,5,6478,'Opening'),
(3,5,6603,'Attack'),
(3,5,7266,'Duel'),
(3,5,7267,'Grovel'),
(3,5,7355,'Stuck'),
(3,5,8386,'Attacking'),
(3,5,9078,'Cloth'),
(3,5,9125,'Generic'),
(3,5,20594,'Stoneform'),
(3,5,20595,'Gun Specialization'),
(3,5,20596,'Frost Resistance'),
(3,5,21651,'Opening'),
(3,5,21652,'Closing'),
(3,5,22027,'Remove Insignia'),
(3,5,22810,'Opening - No Text'),
(3,5,45927,'Summon Friend'),
(3,5,59224,'Mace Specialization'),
(3,5,61437,'Opening'),
(3,6,81,'Dodge'),
(3,6,196,'One-Handed Axes'),
(3,6,197,'Two-Handed Axes'),
(3,6,200,'Polearms'),
(3,6,201,'One-Handed Swords'),
(3,6,202,'Two-Handed Swords'),
(3,6,203,'Unarmed'),
(3,6,204,'Defense'),
(3,6,522,'SPELLDEFENSE (DND)'),
(3,6,668,'Language Common'),
(3,6,672,'Language Dwarven'),
(3,6,674,'Dual Wield'),
(3,6,750,'Plate Mail'),
(3,6,1843,'Disarm'),
(3,6,2382,'Generic'),
(3,6,2479,'Honorless Target'),
(3,6,2481,'Find Treasure'),
(3,6,3050,'Detect'),
(3,6,3127,'Parry'),
(3,6,3275,'Linen Bandage'),
(3,6,3276,'Heavy Linen Bandage'),
(3,6,3277,'Wool Bandage'),
(3,6,3278,'Heavy Wool Bandage'),
(3,6,3365,'Opening'),
(3,6,6233,'Closing'),
(3,6,6246,'Closing'),
(3,6,6247,'Opening'),
(3,6,6477,'Opening'),
(3,6,6478,'Opening'),
(3,6,6603,'Attack'),
(3,6,7266,'Duel'),
(3,6,7267,'Grovel'),
(3,6,7355,'Stuck'),
(3,6,7928,'Silk Bandage'),
(3,6,7929,'Heavy Silk Bandage'),
(3,6,7934,'Anti-Venom'),
(3,6,8386,'Attacking'),
(3,6,8737,'Mail'),
(3,6,9077,'Leather'),
(3,6,9078,'Cloth'),
(3,6,9125,'Generic'),
(3,6,10840,'Mageweave Bandage'),
(3,6,10841,'Heavy Mageweave Bandage'),
(3,6,10846,'First Aid'),
(3,6,18629,'Runecloth Bandage'),
(3,6,18630,'Heavy Runecloth Bandage'),
(3,6,20594,'Stoneform'),
(3,6,20595,'Gun Specialization'),
(3,6,20596,'Frost Resistance'),
(3,6,21651,'Opening'),
(3,6,21652,'Closing'),
(3,6,22027,'Remove Insignia'),
(3,6,22810,'Opening - No Text'),
(3,6,33391,'Journeyman Riding'),
(3,6,45462,'Plague Strike'),
(3,6,45477,'Icy Touch'),
(3,6,45902,'Blood Strike'),
(3,6,45903,'Offensive State (DND)'),
(3,6,45927,'Summon Friend'),
(3,6,47541,'Death Coil'),
(3,6,48266,'Blood Presence'),
(3,6,49410,'Forceful Deflection'),
(3,6,49576,'Death Grip'),
(3,6,52665,'Sigil'),
(3,6,59224,'Mace Specialization'),
(3,6,59879,'Blood Plague'),
(3,6,59921,'Frost Fever'),
(3,6,61437,'Opening'),
(3,6,61455,'Runic Focus'),
(4,1,78,'Heroic Strike'),
(4,1,81,'Dodge'),
(4,1,107,'Block'),
(4,1,198,'One-Handed Maces'),
(4,1,201,'One-Handed Swords'),
(4,1,203,'Unarmed'),
(4,1,204,'Defense'),
(4,1,522,'SPELLDEFENSE (DND)'),
(4,1,668,'Language Common'),
(4,1,671,'Language Darnassian'),
(4,1,1180,'Daggers'),
(4,1,1843,'Disarm'),
(4,1,2382,'Generic'),
(4,1,2457,'Battle Stance'),
(4,1,2479,'Honorless Target'),
(4,1,3050,'Detect'),
(4,1,3365,'Opening'),
(4,1,5301,'Defensive State (DND)'),
(4,1,6233,'Closing'),
(4,1,6246,'Closing'),
(4,1,6247,'Opening'),
(4,1,6477,'Opening'),
(4,1,6478,'Opening'),
(4,1,6603,'Attack'),
(4,1,7266,'Duel'),
(4,1,7267,'Grovel'),
(4,1,7355,'Stuck'),
(4,1,8386,'Attacking'),
(4,1,8737,'Mail'),
(4,1,9077,'Leather'),
(4,1,9078,'Cloth'),
(4,1,9116,'Shield'),
(4,1,9125,'Generic'),
(4,1,20582,'Quickness'),
(4,1,20583,'Nature Resistance'),
(4,1,20585,'Wisp Spirit'),
(4,1,21651,'Opening'),
(4,1,21652,'Closing'),
(4,1,22027,'Remove Insignia'),
(4,1,22810,'Opening - No Text'),
(4,1,32215,'Victorious State'),
(4,1,45927,'Summon Friend'),
(4,1,58984,'Shadowmelt'),
(4,1,61437,'Opening'),
(4,3,75,'Auto Shot'),
(4,3,81,'Dodge'),
(4,3,203,'Unarmed'),
(4,3,204,'Defense'),
(4,3,264,'Bows'),
(4,3,522,'SPELLDEFENSE (DND)'),
(4,3,668,'Language Common'),
(4,3,671,'Language Darnassian'),
(4,3,1180,'Daggers'),
(4,3,1843,'Disarm'),
(4,3,2382,'Generic'),
(4,3,2479,'Honorless Target'),
(4,3,2973,'Raptor Strike'),
(4,3,3050,'Detect'),
(4,3,3365,'Opening'),
(4,3,6233,'Closing'),
(4,3,6246,'Closing'),
(4,3,6247,'Opening'),
(4,3,6477,'Opening'),
(4,3,6478,'Opening'),
(4,3,6603,'Attack'),
(4,3,7266,'Duel'),
(4,3,7267,'Grovel'),
(4,3,7355,'Stuck'),
(4,3,8386,'Attacking'),
(4,3,9077,'Leather'),
(4,3,9078,'Cloth'),
(4,3,9125,'Generic'),
(4,3,13358,'Defensive State (DND)'),
(4,3,20582,'Quickness'),
(4,3,20583,'Nature Resistance'),
(4,3,20585,'Wisp Spirit'),
(4,3,21651,'Opening'),
(4,3,21652,'Closing'),
(4,3,22027,'Remove Insignia'),
(4,3,22810,'Opening - No Text'),
(4,3,24949,'Defensive State 2 (DND)'),
(4,3,34082,'Advantaged State (DND)'),
(4,3,45927,'Summon Friend'),
(4,3,58984,'Shadowmelt'),
(4,3,61437,'Opening'),
(4,4,81,'Dodge'),
(4,4,203,'Unarmed'),
(4,4,204,'Defense'),
(4,4,522,'SPELLDEFENSE (DND)'),
(4,4,668,'Language Common'),
(4,4,671,'Language Darnassian'),
(4,4,1180,'Daggers'),
(4,4,1752,'Sinister Strike'),
(4,4,1843,'Disarm'),
(4,4,2098,'Eviscerate'),
(4,4,2382,'Generic'),
(4,4,2479,'Honorless Target'),
(4,4,2567,'Thrown'),
(4,4,2764,'Throw'),
(4,4,3050,'Detect'),
(4,4,3365,'Opening'),
(4,4,6233,'Closing'),
(4,4,6246,'Closing'),
(4,4,6247,'Opening'),
(4,4,6477,'Opening'),
(4,4,6478,'Opening'),
(4,4,6603,'Attack'),
(4,4,7266,'Duel'),
(4,4,7267,'Grovel'),
(4,4,7355,'Stuck'),
(4,4,8386,'Attacking'),
(4,4,9077,'Leather'),
(4,4,9078,'Cloth'),
(4,4,9125,'Generic'),
(4,4,16092,'Defensive State (DND)'),
(4,4,20582,'Quickness'),
(4,4,20583,'Nature Resistance'),
(4,4,20585,'Wisp Spirit'),
(4,4,21184,'Rogue Passive (DND)'),
(4,4,21651,'Opening'),
(4,4,21652,'Closing'),
(4,4,22027,'Remove Insignia'),
(4,4,22810,'Opening - No Text'),
(4,4,45927,'Summon Friend'),
(4,4,58984,'Shadowmelt'),
(4,4,61437,'Opening'),
(4,5,81,'Dodge'),
(4,5,198,'One-Handed Maces'),
(4,5,203,'Unarmed'),
(4,5,204,'Defense'),
(4,5,522,'SPELLDEFENSE (DND)'),
(4,5,585,'Smite'),
(4,5,668,'Language Common'),
(4,5,671,'Language Darnassian'),
(4,5,1843,'Disarm'),
(4,5,2050,'Lesser Heal'),
(4,5,2382,'Generic'),
(4,5,2479,'Honorless Target'),
(4,5,3050,'Detect'),
(4,5,3365,'Opening'),
(4,5,5009,'Wands'),
(4,5,5019,'Shoot'),
(4,5,6233,'Closing'),
(4,5,6246,'Closing'),
(4,5,6247,'Opening'),
(4,5,6477,'Opening'),
(4,5,6478,'Opening'),
(4,5,6603,'Attack'),
(4,5,7266,'Duel'),
(4,5,7267,'Grovel'),
(4,5,7355,'Stuck'),
(4,5,8386,'Attacking'),
(4,5,9078,'Cloth'),
(4,5,9125,'Generic'),
(4,5,20582,'Quickness'),
(4,5,20583,'Nature Resistance'),
(4,5,20585,'Wisp Spirit'),
(4,5,21651,'Opening'),
(4,5,21652,'Closing'),
(4,5,22027,'Remove Insignia'),
(4,5,22810,'Opening - No Text'),
(4,5,45927,'Summon Friend'),
(4,5,58984,'Shadowmelt'),
(4,5,61437,'Opening'),
(4,6,81,'Dodge'),
(4,6,196,'One-Handed Axes'),
(4,6,197,'Two-Handed Axes'),
(4,6,200,'Polearms'),
(4,6,201,'One-Handed Swords'),
(4,6,202,'Two-Handed Swords'),
(4,6,203,'Unarmed'),
(4,6,204,'Defense'),
(4,6,522,'SPELLDEFENSE (DND)'),
(4,6,668,'Language Common'),
(4,6,671,'Language Darnassian'),
(4,6,674,'Dual Wield'),
(4,6,750,'Plate Mail'),
(4,6,1843,'Disarm'),
(4,6,2382,'Generic'),
(4,6,2479,'Honorless Target'),
(4,6,3050,'Detect'),
(4,6,3127,'Parry'),
(4,6,3275,'Linen Bandage'),
(4,6,3276,'Heavy Linen Bandage'),
(4,6,3277,'Wool Bandage'),
(4,6,3278,'Heavy Wool Bandage'),
(4,6,3365,'Opening'),
(4,6,6233,'Closing'),
(4,6,6246,'Closing'),
(4,6,6247,'Opening'),
(4,6,6477,'Opening'),
(4,6,6478,'Opening'),
(4,6,6603,'Attack'),
(4,6,7266,'Duel'),
(4,6,7267,'Grovel'),
(4,6,7355,'Stuck'),
(4,6,7928,'Silk Bandage'),
(4,6,7929,'Heavy Silk Bandage'),
(4,6,7934,'Anti-Venom'),
(4,6,8386,'Attacking'),
(4,6,8737,'Mail'),
(4,6,9077,'Leather'),
(4,6,9078,'Cloth'),
(4,6,9125,'Generic'),
(4,6,10840,'Mageweave Bandage'),
(4,6,10841,'Heavy Mageweave Bandage'),
(4,6,10846,'First Aid'),
(4,6,18629,'Runecloth Bandage'),
(4,6,18630,'Heavy Runecloth Bandage'),
(4,6,20582,'Quickness'),
(4,6,20583,'Nature Resistance'),
(4,6,20585,'Wisp Spirit'),
(4,6,21651,'Opening'),
(4,6,21652,'Closing'),
(4,6,22027,'Remove Insignia'),
(4,6,22810,'Opening - No Text'),
(4,6,33391,'Journeyman Riding'),
(4,6,45462,'Plague Strike'),
(4,6,45477,'Icy Touch'),
(4,6,45902,'Blood Strike'),
(4,6,45903,'Offensive State (DND)'),
(4,6,45927,'Summon Friend'),
(4,6,47541,'Death Coil'),
(4,6,48266,'Blood Presence'),
(4,6,49410,'Forceful Deflection'),
(4,6,49576,'Death Grip'),
(4,6,52665,'Sigil'),
(4,6,58984,'Shadowmeld'),
(4,6,59879,'Blood Plague'),
(4,6,59921,'Frost Fever'),
(4,6,61437,'Opening'),
(4,6,61455,'Runic Focus'),
(4,11,81,'Dodge'),
(4,11,203,'Unarmed'),
(4,11,204,'Defense'),
(4,11,227,'Staves'),
(4,11,522,'SPELLDEFENSE (DND)'),
(4,11,668,'Language Common'),
(4,11,671,'Language Darnassian'),
(4,11,1180,'Daggers'),
(4,11,1843,'Disarm'),
(4,11,2382,'Generic'),
(4,11,2479,'Honorless Target'),
(4,11,3050,'Detect'),
(4,11,3365,'Opening'),
(4,11,5176,'Wrath'),
(4,11,5185,'Healing Touch'),
(4,11,6233,'Closing'),
(4,11,6246,'Closing'),
(4,11,6247,'Opening'),
(4,11,6477,'Opening'),
(4,11,6478,'Opening'),
(4,11,6603,'Attack'),
(4,11,7266,'Duel'),
(4,11,7267,'Grovel'),
(4,11,7355,'Stuck'),
(4,11,8386,'Attacking'),
(4,11,9077,'Leather'),
(4,11,9078,'Cloth'),
(4,11,9125,'Generic'),
(4,11,20582,'Quickness'),
(4,11,20583,'Nature Resistance'),
(4,11,20585,'Wisp Spirit'),
(4,11,21651,'Opening'),
(4,11,21652,'Closing'),
(4,11,22027,'Remove Insignia'),
(4,11,22810,'Opening - No Text'),
(4,11,27764,'Fetish'),
(4,11,45927,'Summon Friend'),
(4,11,58984,'Shadowmelt'),
(4,11,61437,'Opening'),
(5,1,78,'Heroic Strike'),
(5,1,81,'Dodge'),
(5,1,107,'Block'),
(5,1,201,'One-Handed Swords'),
(5,1,202,'Two-Handed Swords'),
(5,1,203,'Unarmed'),
(5,1,204,'Defense'),
(5,1,522,'SPELLDEFENSE (DND)'),
(5,1,669,'Language Orcish'),
(5,1,1180,'Daggers'),
(5,1,1843,'Disarm'),
(5,1,2382,'Generic'),
(5,1,2457,'Battle Stance'),
(5,1,2479,'Honorless Target'),
(5,1,3050,'Detect'),
(5,1,3365,'Opening'),
(5,1,5227,'Underwater Breathing'),
(5,1,5301,'Defensive State (DND)'),
(5,1,6233,'Closing'),
(5,1,6246,'Closing'),
(5,1,6247,'Opening'),
(5,1,6477,'Opening'),
(5,1,6478,'Opening'),
(5,1,6603,'Attack'),
(5,1,7266,'Duel'),
(5,1,7267,'Grovel'),
(5,1,7355,'Stuck'),
(5,1,7744,'Will of the Forsaken'),
(5,1,8386,'Attacking'),
(5,1,8737,'Mail'),
(5,1,9077,'Leather'),
(5,1,9078,'Cloth'),
(5,1,9116,'Shield'),
(5,1,9125,'Generic'),
(5,1,17737,'Language Gutterspeak'),
(5,1,20577,'Cannibalize'),
(5,1,20579,'Shadow Resistance'),
(5,1,21651,'Opening'),
(5,1,21652,'Closing'),
(5,1,22027,'Remove Insignia'),
(5,1,22810,'Opening - No Text'),
(5,1,32215,'Victorious State'),
(5,1,45927,'Summon Friend'),
(5,1,61437,'Opening'),
(5,4,81,'Dodge'),
(5,4,203,'Unarmed'),
(5,4,204,'Defense'),
(5,4,522,'SPELLDEFENSE (DND)'),
(5,4,669,'Language Orcish'),
(5,4,1180,'Daggers'),
(5,4,1752,'Sinister Strike'),
(5,4,1843,'Disarm'),
(5,4,2098,'Eviscerate'),
(5,4,2382,'Generic'),
(5,4,2479,'Honorless Target'),
(5,4,2567,'Thrown'),
(5,4,2764,'Throw'),
(5,4,3050,'Detect'),
(5,4,3365,'Opening'),
(5,4,5227,'Underwater Breathing'),
(5,4,6233,'Closing'),
(5,4,6246,'Closing'),
(5,4,6247,'Opening'),
(5,4,6477,'Opening'),
(5,4,6478,'Opening'),
(5,4,6603,'Attack'),
(5,4,7266,'Duel'),
(5,4,7267,'Grovel'),
(5,4,7355,'Stuck'),
(5,4,7744,'Will of the Forsaken'),
(5,4,8386,'Attacking'),
(5,4,9077,'Leather'),
(5,4,9078,'Cloth'),
(5,4,9125,'Generic'),
(5,4,16092,'Defensive State (DND)'),
(5,4,17737,'Language Gutterspeak'),
(5,4,20577,'Cannibalize'),
(5,4,20579,'Shadow Resistance'),
(5,4,21184,'Rogue Passive (DND)'),
(5,4,21651,'Opening'),
(5,4,21652,'Closing'),
(5,4,22027,'Remove Insignia'),
(5,4,22810,'Opening - No Text'),
(5,4,45927,'Summon Friend'),
(5,4,61437,'Opening'),
(5,5,81,'Dodge'),
(5,5,198,'One-Handed Maces'),
(5,5,203,'Unarmed'),
(5,5,204,'Defense'),
(5,5,522,'SPELLDEFENSE (DND)'),
(5,5,585,'Smite'),
(5,5,669,'Language Orcish'),
(5,5,1843,'Disarm'),
(5,5,2050,'Lesser Heal'),
(5,5,2382,'Generic'),
(5,5,2479,'Honorless Target'),
(5,5,3050,'Detect'),
(5,5,3365,'Opening'),
(5,5,5009,'Wands'),
(5,5,5019,'Shoot'),
(5,5,5227,'Underwater Breathing'),
(5,5,6233,'Closing'),
(5,5,6246,'Closing'),
(5,5,6247,'Opening'),
(5,5,6477,'Opening'),
(5,5,6478,'Opening'),
(5,5,6603,'Attack'),
(5,5,7266,'Duel'),
(5,5,7267,'Grovel'),
(5,5,7355,'Stuck'),
(5,5,7744,'Will of the Forsaken'),
(5,5,8386,'Attacking'),
(5,5,9078,'Cloth'),
(5,5,9125,'Generic'),
(5,5,17737,'Language Gutterspeak'),
(5,5,20577,'Cannibalize'),
(5,5,20579,'Shadow Resistance'),
(5,5,21651,'Opening'),
(5,5,21652,'Closing'),
(5,5,22027,'Remove Insignia'),
(5,5,22810,'Opening - No Text'),
(5,5,45927,'Summon Friend'),
(5,5,61437,'Opening'),
(5,6,81,'Dodge'),
(5,6,196,'One-Handed Axes'),
(5,6,197,'Two-Handed Axes'),
(5,6,200,'Polearms'),
(5,6,201,'One-Handed Swords'),
(5,6,202,'Two-Handed Swords'),
(5,6,203,'Unarmed'),
(5,6,204,'Defense'),
(5,6,522,'SPELLDEFENSE (DND)'),
(5,6,669,'Language Orcish'),
(5,6,674,'Dual Wield'),
(5,6,750,'Plate Mail'),
(5,6,1843,'Disarm'),
(5,6,2382,'Generic'),
(5,6,2479,'Honorless Target'),
(5,6,3050,'Detect'),
(5,6,3127,'Parry'),
(5,6,3275,'Linen Bandage'),
(5,6,3276,'Heavy Linen Bandage'),
(5,6,3277,'Wool Bandage'),
(5,6,3278,'Heavy Wool Bandage'),
(5,6,3365,'Opening'),
(5,6,5227,'Underwater Breathing'),
(5,6,6233,'Closing'),
(5,6,6246,'Closing'),
(5,6,6247,'Opening'),
(5,6,6477,'Opening'),
(5,6,6478,'Opening'),
(5,6,6603,'Attack'),
(5,6,7266,'Duel'),
(5,6,7267,'Grovel'),
(5,6,7355,'Stuck'),
(5,6,7744,'Will of the Forsaken'),
(5,6,7928,'Silk Bandage'),
(5,6,7929,'Heavy Silk Bandage'),
(5,6,7934,'Anti-Venom'),
(5,6,8386,'Attacking'),
(5,6,8737,'Mail'),
(5,6,9077,'Leather'),
(5,6,9078,'Cloth'),
(5,6,9125,'Generic'),
(5,6,10840,'Mageweave Bandage'),
(5,6,10841,'Heavy Mageweave Bandage'),
(5,6,10846,'First Aid'),
(5,6,17737,'Language Gutterspeak'),
(5,6,18629,'Runecloth Bandage'),
(5,6,18630,'Heavy Runecloth Bandage'),
(5,6,20577,'Cannibalize'),
(5,6,20579,'Shadow Resistance'),
(5,6,21651,'Opening'),
(5,6,21652,'Closing'),
(5,6,22027,'Remove Insignia'),
(5,6,22810,'Opening - No Text'),
(5,6,33391,'Journeyman Riding'),
(5,6,45462,'Plague Strike'),
(5,6,45477,'Icy Touch'),
(5,6,45902,'Blood Strike'),
(5,6,45903,'Offensive State (DND)'),
(5,6,45927,'Summon Friend'),
(5,6,47541,'Death Coil'),
(5,6,48266,'Blood Presence'),
(5,6,49410,'Forceful Deflection'),
(5,6,49576,'Death Grip'),
(5,6,52665,'Sigil'),
(5,6,59879,'Blood Plague'),
(5,6,59921,'Frost Fever'),
(5,6,61437,'Opening'),
(5,6,61455,'Runic Focus'),
(5,8,81,'Dodge'),
(5,8,133,'Fireball'),
(5,8,168,'Frost Armor'),
(5,8,203,'Unarmed'),
(5,8,204,'Defense'),
(5,8,227,'Staves'),
(5,8,522,'SPELLDEFENSE (DND)'),
(5,8,669,'Language Orcish'),
(5,8,1843,'Disarm'),
(5,8,2382,'Generic'),
(5,8,2479,'Honorless Target'),
(5,8,3050,'Detect'),
(5,8,3365,'Opening'),
(5,8,5009,'Wands'),
(5,8,5019,'Shoot'),
(5,8,5227,'Underwater Breathing'),
(5,8,6233,'Closing'),
(5,8,6246,'Closing'),
(5,8,6247,'Opening'),
(5,8,6477,'Opening'),
(5,8,6478,'Opening'),
(5,8,6603,'Attack'),
(5,8,7266,'Duel'),
(5,8,7267,'Grovel'),
(5,8,7355,'Stuck'),
(5,8,7744,'Will of the Forsaken'),
(5,8,8386,'Attacking'),
(5,8,9078,'Cloth'),
(5,8,9125,'Generic'),
(5,8,17737,'Language Gutterspeak'),
(5,8,20577,'Cannibalize'),
(5,8,20579,'Shadow Resistance'),
(5,8,21651,'Opening'),
(5,8,21652,'Closing'),
(5,8,22027,'Remove Insignia'),
(5,8,22810,'Opening - No Text'),
(5,8,45927,'Summon Friend'),
(5,8,61437,'Opening'),
(5,9,81,'Dodge'),
(5,9,203,'Unarmed'),
(5,9,204,'Defense'),
(5,9,522,'SPELLDEFENSE (DND)'),
(5,9,669,'Language Orcish'),
(5,9,686,'Shadow Bolt'),
(5,9,687,'Demon Skin'),
(5,9,1180,'Daggers'),
(5,9,1843,'Disarm'),
(5,9,2382,'Generic'),
(5,9,2479,'Honorless Target'),
(5,9,3050,'Detect'),
(5,9,3365,'Opening'),
(5,9,5009,'Wands'),
(5,9,5019,'Shoot'),
(5,9,5227,'Underwater Breathing'),
(5,9,6233,'Closing'),
(5,9,6246,'Closing'),
(5,9,6247,'Opening'),
(5,9,6477,'Opening'),
(5,9,6478,'Opening'),
(5,9,6603,'Attack'),
(5,9,7266,'Duel'),
(5,9,7267,'Grovel'),
(5,9,7355,'Stuck'),
(5,9,7744,'Will of the Forsaken'),
(5,9,8386,'Attacking'),
(5,9,9078,'Cloth'),
(5,9,9125,'Generic'),
(5,9,17737,'Language Gutterspeak'),
(5,9,20577,'Cannibalize'),
(5,9,20579,'Shadow Resistance'),
(5,9,21651,'Opening'),
(5,9,21652,'Closing'),
(5,9,22027,'Remove Insignia'),
(5,9,22810,'Opening - No Text'),
(5,9,45927,'Summon Friend'),
(1,9,58284,'Chaos Bolt Passive'),
(5,9,61437,'Opening'),
(6,1,78,'Heroic Strike'),
(6,1,81,'Dodge'),
(6,1,107,'Block'),
(6,1,196,'One-Handed Axes'),
(6,1,198,'One-Handed Maces'),
(6,1,199,'Two-Handed Maces'),
(6,1,203,'Unarmed'),
(6,1,204,'Defense'),
(6,1,522,'SPELLDEFENSE (DND)'),
(6,1,669,'Language Orcish'),
(6,1,670,'Language Taurahe'),
(6,1,1843,'Disarm'),
(6,1,2382,'Generic'),
(6,1,2457,'Battle Stance'),
(6,1,2479,'Honorless Target'),
(6,1,3050,'Detect'),
(6,1,3365,'Opening'),
(6,1,5301,'Defensive State (DND)'),
(6,1,6233,'Closing'),
(6,1,6246,'Closing'),
(6,1,6247,'Opening'),
(6,1,6477,'Opening'),
(6,1,6478,'Opening'),
(6,1,6603,'Attack'),
(6,1,7266,'Duel'),
(6,1,7267,'Grovel'),
(6,1,7355,'Stuck'),
(6,1,8386,'Attacking'),
(6,1,8737,'Mail'),
(6,1,9077,'Leather'),
(6,1,9078,'Cloth'),
(6,1,9116,'Shield'),
(6,1,9125,'Generic'),
(6,1,20549,'War Stomp'),
(6,1,20550,'Endurance'),
(6,1,20551,'Nature Resistance'),
(6,1,20552,'Cultivation'),
(6,1,21651,'Opening'),
(6,1,21652,'Closing'),
(6,1,22027,'Remove Insignia'),
(6,1,22810,'Opening - No Text'),
(6,1,32215,'Victorious State'),
(6,1,45927,'Summon Friend'),
(6,1,61437,'Opening'),
(6,3,75,'Auto Shot'),
(6,3,81,'Dodge'),
(6,3,196,'One-Handed Axes'),
(6,3,203,'Unarmed'),
(6,3,204,'Defense'),
(6,3,266,'Guns'),
(6,3,522,'SPELLDEFENSE (DND)'),
(6,3,669,'Language Orcish'),
(6,3,670,'Language Taurahe'),
(6,3,1843,'Disarm'),
(6,3,2382,'Generic'),
(6,3,2479,'Honorless Target'),
(6,3,2973,'Raptor Strike'),
(6,3,3050,'Detect'),
(6,3,3365,'Opening'),
(6,3,6233,'Closing'),
(6,3,6246,'Closing'),
(6,3,6247,'Opening'),
(6,3,6477,'Opening'),
(6,3,6478,'Opening'),
(6,3,6603,'Attack'),
(6,3,7266,'Duel'),
(6,3,7267,'Grovel'),
(6,3,7355,'Stuck'),
(6,3,8386,'Attacking'),
(6,3,9077,'Leather'),
(6,3,9078,'Cloth'),
(6,3,9125,'Generic'),
(6,3,13358,'Defensive State (DND)'),
(6,3,20549,'War Stomp'),
(6,3,20550,'Endurance'),
(6,3,20551,'Nature Resistance'),
(6,3,20552,'Cultivation'),
(6,3,21651,'Opening'),
(6,3,21652,'Closing'),
(6,3,22027,'Remove Insignia'),
(6,3,22810,'Opening - No Text'),
(6,3,24949,'Defensive State 2 (DND)'),
(6,3,34082,'Advantaged State (DND)'),
(6,3,45927,'Summon Friend'),
(6,3,61437,'Opening'),
(6,6,81,'Dodge'),
(6,6,196,'One-Handed Axes'),
(6,6,197,'Two-Handed Axes'),
(6,6,200,'Polearms'),
(6,6,201,'One-Handed Swords'),
(6,6,202,'Two-Handed Swords'),
(6,6,203,'Unarmed'),
(6,6,204,'Defense'),
(6,6,522,'SPELLDEFENSE (DND)'),
(6,6,669,'Language Orcish'),
(6,6,670,'Language Taurahe'),
(6,6,674,'Dual Wield'),
(6,6,750,'Plate Mail'),
(6,6,1843,'Disarm'),
(6,6,2382,'Generic'),
(6,6,2479,'Honorless Target'),
(6,6,3050,'Detect'),
(6,6,3127,'Parry'),
(6,6,3275,'Linen Bandage'),
(6,6,3276,'Heavy Linen Bandage'),
(6,6,3277,'Wool Bandage'),
(6,6,3278,'Heavy Wool Bandage'),
(6,6,3365,'Opening'),
(6,6,6233,'Closing'),
(6,6,6246,'Closing'),
(6,6,6247,'Opening'),
(6,6,6477,'Opening'),
(6,6,6478,'Opening'),
(6,6,6603,'Attack'),
(6,6,7266,'Duel'),
(6,6,7267,'Grovel'),
(6,6,7355,'Stuck'),
(6,6,7928,'Silk Bandage'),
(6,6,7929,'Heavy Silk Bandage'),
(6,6,7934,'Anti-Venom'),
(6,6,8386,'Attacking'),
(6,6,8737,'Mail'),
(6,6,9077,'Leather'),
(6,6,9078,'Cloth'),
(6,6,9125,'Generic'),
(6,6,10840,'Mageweave Bandage'),
(6,6,10841,'Heavy Mageweave Bandage'),
(6,6,10846,'First Aid'),
(6,6,18629,'Runecloth Bandage'),
(6,6,18630,'Heavy Runecloth Bandage'),
(6,6,20549,'War Stomp'),
(6,6,20550,'Endurance'),
(6,6,20551,'Nature Resistance'),
(6,6,20552,'Cultivation'),
(6,6,21651,'Opening'),
(6,6,21652,'Closing'),
(6,6,22027,'Remove Insignia'),
(6,6,22810,'Opening - No Text'),
(6,6,33391,'Journeyman Riding'),
(6,6,45462,'Plague Strike'),
(6,6,45477,'Icy Touch'),
(6,6,45902,'Blood Strike'),
(6,6,45903,'Offensive State (DND)'),
(6,6,45927,'Summon Friend'),
(6,6,47541,'Death Coil'),
(6,6,48266,'Blood Presence'),
(6,6,49410,'Forceful Deflection'),
(6,6,49576,'Death Grip'),
(6,6,52665,'Sigil'),
(6,6,59879,'Blood Plague'),
(6,6,59921,'Frost Fever'),
(6,6,61437,'Opening'),
(6,6,61455,'Runic Focus'),
(6,7,81,'Dodge'),
(6,7,107,'Block'),
(6,7,198,'One-Handed Maces'),
(6,7,203,'Unarmed'),
(6,7,204,'Defense'),
(6,7,227,'Staves'),
(6,7,331,'Healing Wave'),
(6,7,403,'Lightning Bolt'),
(6,7,522,'SPELLDEFENSE (DND)'),
(6,7,669,'Language Orcish'),
(6,7,670,'Language Taurahe'),
(6,7,1843,'Disarm'),
(6,7,2382,'Generic'),
(6,7,2479,'Honorless Target'),
(6,7,3050,'Detect'),
(6,7,3365,'Opening'),
(6,7,6233,'Closing'),
(6,7,6246,'Closing'),
(6,7,6247,'Opening'),
(6,7,6477,'Opening'),
(6,7,6478,'Opening'),
(6,7,6603,'Attack'),
(6,7,7266,'Duel'),
(6,7,7267,'Grovel'),
(6,7,7355,'Stuck'),
(6,7,8386,'Attacking'),
(6,7,9077,'Leather'),
(6,7,9078,'Cloth'),
(6,7,9116,'Shield'),
(6,7,9125,'Generic'),
(6,7,20549,'War Stomp'),
(6,7,20550,'Endurance'),
(6,7,20551,'Nature Resistance'),
(6,7,20552,'Cultivation'),
(6,7,21651,'Opening'),
(6,7,21652,'Closing'),
(6,7,22027,'Remove Insignia'),
(6,7,22810,'Opening - No Text'),
(6,7,27763,'Totem'),
(6,7,45927,'Summon Friend'),
(6,7,61437,'Opening'),
(6,11,81,'Dodge'),
(6,11,198,'One-Handed Maces'),
(6,11,203,'Unarmed'),
(6,11,204,'Defense'),
(6,11,227,'Staves'),
(6,11,522,'SPELLDEFENSE (DND)'),
(6,11,669,'Language Orcish'),
(6,11,670,'Language Taurahe'),
(6,11,1843,'Disarm'),
(6,11,2382,'Generic'),
(6,11,2479,'Honorless Target'),
(6,11,3050,'Detect'),
(6,11,3365,'Opening'),
(6,11,5176,'Wrath'),
(6,11,5185,'Healing Touch'),
(6,11,6233,'Closing'),
(6,11,6246,'Closing'),
(6,11,6247,'Opening'),
(6,11,6477,'Opening'),
(6,11,6478,'Opening'),
(6,11,6603,'Attack'),
(6,11,7266,'Duel'),
(6,11,7267,'Grovel'),
(6,11,7355,'Stuck'),
(6,11,8386,'Attacking'),
(6,11,9077,'Leather'),
(6,11,9078,'Cloth'),
(6,11,9125,'Generic'),
(6,11,20549,'War Stomp'),
(6,11,20550,'Endurance'),
(6,11,20551,'Nature Resistance'),
(6,11,20552,'Cultivation'),
(6,11,21651,'Opening'),
(6,11,21652,'Closing'),
(6,11,22027,'Remove Insignia'),
(6,11,22810,'Opening - No Text'),
(6,11,27764,'Fetish'),
(6,11,45927,'Summon Friend'),
(6,11,61437,'Opening'),
(7,1,78,'Heroic Strike'),
(7,1,81,'Dodge'),
(7,1,107,'Block'),
(7,1,198,'One-Handed Maces'),
(7,1,201,'One-Handed Swords'),
(7,1,203,'Unarmed'),
(7,1,204,'Defense'),
(7,1,522,'SPELLDEFENSE (DND)'),
(7,1,668,'Language Common'),
(7,1,1180,'Daggers'),
(7,1,1843,'Disarm'),
(7,1,2382,'Generic'),
(7,1,2457,'Battle Stance'),
(7,1,2479,'Honorless Target'),
(7,1,3050,'Detect'),
(7,1,3365,'Opening'),
(7,1,5301,'Defensive State (DND)'),
(7,1,6233,'Closing'),
(7,1,6246,'Closing'),
(7,1,6247,'Opening'),
(7,1,6477,'Opening'),
(7,1,6478,'Opening'),
(7,1,6603,'Attack'),
(7,1,7266,'Duel'),
(7,1,7267,'Grovel'),
(7,1,7340,'Language Gnomish'),
(7,1,7355,'Stuck'),
(7,1,8386,'Attacking'),
(7,1,8737,'Mail'),
(7,1,9077,'Leather'),
(7,1,9078,'Cloth'),
(7,1,9116,'Shield'),
(7,1,9125,'Generic'),
(7,1,20589,'Escape Artist'),
(7,1,20591,'Expansive Mind'),
(7,1,20592,'Arcane Resistance'),
(7,1,20593,'Engineering Specialization'),
(7,1,21651,'Opening'),
(7,1,21652,'Closing'),
(7,1,22027,'Remove Insignia'),
(7,1,22810,'Opening - No Text'),
(7,1,32215,'Victorious State'),
(7,1,45927,'Summon Friend'),
(7,1,61437,'Opening'),
(7,4,81,'Dodge'),
(7,4,203,'Unarmed'),
(7,4,204,'Defense'),
(7,4,522,'SPELLDEFENSE (DND)'),
(7,4,668,'Language Common'),
(7,4,1180,'Daggers'),
(7,4,1752,'Sinister Strike'),
(7,4,1843,'Disarm'),
(7,4,2098,'Eviscerate'),
(7,4,2382,'Generic'),
(7,4,2479,'Honorless Target'),
(7,4,2567,'Thrown'),
(7,4,2764,'Throw'),
(7,4,3050,'Detect'),
(7,4,3365,'Opening'),
(7,4,6233,'Closing'),
(7,4,6246,'Closing'),
(7,4,6247,'Opening'),
(7,4,6477,'Opening'),
(7,4,6478,'Opening'),
(7,4,6603,'Attack'),
(7,4,7266,'Duel'),
(7,4,7267,'Grovel'),
(7,4,7340,'Language Gnomish'),
(7,4,7355,'Stuck'),
(7,4,8386,'Attacking'),
(7,4,9077,'Leather'),
(7,4,9078,'Cloth'),
(7,4,9125,'Generic'),
(7,4,16092,'Defensive State (DND)'),
(7,4,20589,'Escape Artist'),
(7,4,20591,'Expansive Mind'),
(7,4,20592,'Arcane Resistance'),
(7,4,20593,'Engineering Specialization'),
(7,4,21184,'Rogue Passive (DND)'),
(7,4,21651,'Opening'),
(7,4,21652,'Closing'),
(7,4,22027,'Remove Insignia'),
(7,4,22810,'Opening - No Text'),
(7,4,45927,'Summon Friend'),
(7,4,61437,'Opening'),
(7,6,81,'Dodge'),
(7,6,196,'One-Handed Axes'),
(7,6,197,'Two-Handed Axes'),
(7,6,200,'Polearms'),
(7,6,201,'One-Handed Swords'),
(7,6,202,'Two-Handed Swords'),
(7,6,203,'Unarmed'),
(7,6,204,'Defense'),
(7,6,522,'SPELLDEFENSE (DND)'),
(7,6,668,'Language Common'),
(7,6,674,'Dual Wield'),
(7,6,750,'Plate Mail'),
(7,6,1843,'Disarm'),
(7,6,2382,'Generic'),
(7,6,2479,'Honorless Target'),
(7,6,3050,'Detect'),
(7,6,3127,'Parry'),
(7,6,3275,'Linen Bandage'),
(7,6,3276,'Heavy Linen Bandage'),
(7,6,3277,'Wool Bandage'),
(7,6,3278,'Heavy Wool Bandage'),
(7,6,3365,'Opening'),
(7,6,6233,'Closing'),
(7,6,6246,'Closing'),
(7,6,6247,'Opening'),
(7,6,6477,'Opening'),
(7,6,6478,'Opening'),
(7,6,6603,'Attack'),
(7,6,7266,'Duel'),
(7,6,7267,'Grovel'),
(7,6,7340,'Language Gnomish'),
(7,6,7355,'Stuck'),
(7,6,7928,'Silk Bandage'),
(7,6,7929,'Heavy Silk Bandage'),
(7,6,7934,'Anti-Venom'),
(7,6,8386,'Attacking'),
(7,6,8737,'Mail'),
(7,6,9077,'Leather'),
(7,6,9078,'Cloth'),
(7,6,9125,'Generic'),
(7,6,10840,'Mageweave Bandage'),
(7,6,10841,'Heavy Mageweave Bandage'),
(7,6,10846,'First Aid'),
(7,6,18629,'Runecloth Bandage'),
(7,6,18630,'Heavy Runecloth Bandage'),
(7,6,20589,'Escape Artist'),
(7,6,20591,'Expansive Mind'),
(7,6,20592,'Arcane Resistance'),
(7,6,20593,'Engineering Specialization'),
(7,6,21651,'Opening'),
(7,6,21652,'Closing'),
(7,6,22027,'Remove Insignia'),
(7,6,22810,'Opening - No Text'),
(7,6,33391,'Journeyman Riding'),
(7,6,45462,'Plague Strike'),
(7,6,45477,'Icy Touch'),
(7,6,45902,'Blood Strike'),
(7,6,45903,'Offensive State (DND)'),
(7,6,45927,'Summon Friend'),
(7,6,47541,'Death Coil'),
(7,6,48266,'Blood Presence'),
(7,6,49410,'Forceful Deflection'),
(7,6,49576,'Death Grip'),
(7,6,52665,'Sigil'),
(7,6,59879,'Blood Plague'),
(7,6,59921,'Frost Fever'),
(7,6,61437,'Opening'),
(7,6,61455,'Runic Focus'),
(7,8,81,'Dodge'),
(7,8,133,'Fireball'),
(7,8,168,'Frost Armor'),
(7,8,203,'Unarmed'),
(7,8,204,'Defense'),
(7,8,227,'Staves'),
(7,8,522,'SPELLDEFENSE (DND)'),
(7,8,668,'Language Common'),
(7,8,1843,'Disarm'),
(7,8,2382,'Generic'),
(7,8,2479,'Honorless Target'),
(7,8,3050,'Detect'),
(7,8,3365,'Opening'),
(7,8,5009,'Wands'),
(7,8,5019,'Shoot'),
(7,8,6233,'Closing'),
(7,8,6246,'Closing'),
(7,8,6247,'Opening'),
(7,8,6477,'Opening'),
(7,8,6478,'Opening'),
(7,8,6603,'Attack'),
(7,8,7266,'Duel'),
(7,8,7267,'Grovel'),
(7,8,7340,'Language Gnomish'),
(7,8,7355,'Stuck'),
(7,8,8386,'Attacking'),
(7,8,9078,'Cloth'),
(7,8,9125,'Generic'),
(7,8,20589,'Escape Artist'),
(7,8,20591,'Expansive Mind'),
(7,8,20592,'Arcane Resistance'),
(7,8,20593,'Engineering Specialization'),
(7,8,21651,'Opening'),
(7,8,21652,'Closing'),
(7,8,22027,'Remove Insignia'),
(7,8,22810,'Opening - No Text'),
(7,8,45927,'Summon Friend'),
(7,8,61437,'Opening'),
(7,9,81,'Dodge'),
(7,9,203,'Unarmed'),
(7,9,204,'Defense'),
(7,9,522,'SPELLDEFENSE (DND)'),
(7,9,668,'Language Common'),
(7,9,686,'Shadow Bolt'),
(7,9,687,'Demon Skin'),
(7,9,1180,'Daggers'),
(7,9,1843,'Disarm'),
(7,9,2382,'Generic'),
(7,9,2479,'Honorless Target'),
(7,9,3050,'Detect'),
(7,9,3365,'Opening'),
(7,9,5009,'Wands'),
(7,9,5019,'Shoot'),
(7,9,6233,'Closing'),
(7,9,6246,'Closing'),
(7,9,6247,'Opening'),
(7,9,6477,'Opening'),
(7,9,6478,'Opening'),
(7,9,6603,'Attack'),
(7,9,7266,'Duel'),
(7,9,7267,'Grovel'),
(7,9,7340,'Language Gnomish'),
(7,9,7355,'Stuck'),
(7,9,8386,'Attacking'),
(7,9,9078,'Cloth'),
(7,9,9125,'Generic'),
(7,9,20589,'Escape Artist'),
(7,9,20591,'Expansive Mind'),
(7,9,20592,'Arcane Resistance'),
(7,9,20593,'Engineering Specialization'),
(7,9,21651,'Opening'),
(7,9,21652,'Closing'),
(7,9,22027,'Remove Insignia'),
(7,9,22810,'Opening - No Text'),
(7,9,45927,'Summon Friend'),
(7,9,61437,'Opening'),
(8,1,78,'Heroic Strike'),
(8,1,81,'Dodge'),
(8,1,107,'Block'),
(8,1,196,'One-Handed Axes'),
(8,1,203,'Unarmed'),
(8,1,204,'Defense'),
(8,1,522,'SPELLDEFENSE (DND)'),
(8,1,669,'Language Orcish'),
(8,1,1180,'Daggers'),
(8,1,1843,'Disarm'),
(8,1,2382,'Generic'),
(8,1,2457,'Battle Stance'),
(8,1,2479,'Honorless Target'),
(8,1,2567,'Thrown'),
(8,1,2764,'Throw'),
(8,1,3050,'Detect'),
(8,1,3365,'Opening'),
(8,1,5301,'Defensive State (DND)'),
(8,1,6233,'Closing'),
(8,1,6246,'Closing'),
(8,1,6247,'Opening'),
(8,1,6477,'Opening'),
(8,1,6478,'Opening'),
(8,1,6603,'Attack'),
(8,1,7266,'Duel'),
(8,1,7267,'Grovel'),
(8,1,7341,'Language Troll'),
(8,1,7355,'Stuck'),
(8,1,8386,'Attacking'),
(8,1,8737,'Mail'),
(8,1,9077,'Leather'),
(8,1,9078,'Cloth'),
(8,1,9116,'Shield'),
(8,1,9125,'Generic'),
(8,1,20555,'Regeneration'),
(8,1,20557,'Beast Slaying'),
(8,1,20558,'Throwing Specialization'),
(8,1,21651,'Opening'),
(8,1,21652,'Closing'),
(8,1,22027,'Remove Insignia'),
(8,1,22810,'Opening - No Text'),
(8,1,26290,'Bow Specialization'),
(8,1,26297,'Berserking'),
(8,1,32215,'Victorious State'),
(8,1,45927,'Summon Friend'),
(8,1,58943,'Da Voodoo Shuffle'),
(8,1,61437,'Opening'),
(8,3,75,'Auto Shot'),
(8,3,81,'Dodge'),
(8,3,196,'One-Handed Axes'),
(8,3,203,'Unarmed'),
(8,3,204,'Defense'),
(8,3,264,'Bows'),
(8,3,522,'SPELLDEFENSE (DND)'),
(8,3,669,'Language Orcish'),
(8,3,1843,'Disarm'),
(8,3,2382,'Generic'),
(8,3,2479,'Honorless Target'),
(8,3,2973,'Raptor Strike'),
(8,3,3050,'Detect'),
(8,3,3365,'Opening'),
(8,3,6233,'Closing'),
(8,3,6246,'Closing'),
(8,3,6247,'Opening'),
(8,3,6477,'Opening'),
(8,3,6478,'Opening'),
(8,3,6603,'Attack'),
(8,3,7266,'Duel'),
(8,3,7267,'Grovel'),
(8,3,7341,'Language Troll'),
(8,3,7355,'Stuck'),
(8,3,8386,'Attacking'),
(8,3,9077,'Leather'),
(8,3,9078,'Cloth'),
(8,3,9125,'Generic'),
(8,3,13358,'Defensive State (DND)'),
(8,3,26297,'Berserking'),
(8,3,20555,'Regeneration'),
(8,3,20557,'Beast Slaying'),
(8,3,20558,'Throwing Specialization'),
(8,3,21651,'Opening'),
(8,3,21652,'Closing'),
(8,3,22027,'Remove Insignia'),
(8,3,22810,'Opening - No Text'),
(8,3,24949,'Defensive State 2 (DND)'),
(8,3,26290,'Bow Specialization'),
(8,3,34082,'Advantaged State (DND)'),
(8,3,45927,'Summon Friend'),
(8,3,58943,'Da Voodoo Shuffle'),
(8,3,61437,'Opening'),
(8,4,81,'Dodge'),
(8,4,203,'Unarmed'),
(8,4,204,'Defense'),
(8,4,522,'SPELLDEFENSE (DND)'),
(8,4,669,'Language Orcish'),
(8,4,1180,'Daggers'),
(8,4,1752,'Sinister Strike'),
(8,4,1843,'Disarm'),
(8,4,2098,'Eviscerate'),
(8,4,2382,'Generic'),
(8,4,2479,'Honorless Target'),
(8,4,2567,'Thrown'),
(8,4,2764,'Throw'),
(8,4,3050,'Detect'),
(8,4,3365,'Opening'),
(8,4,6233,'Closing'),
(8,4,6246,'Closing'),
(8,4,6247,'Opening'),
(8,4,6477,'Opening'),
(8,4,6478,'Opening'),
(8,4,6603,'Attack'),
(8,4,7266,'Duel'),
(8,4,7267,'Grovel'),
(8,4,7341,'Language Troll'),
(8,4,7355,'Stuck'),
(8,4,8386,'Attacking'),
(8,4,9077,'Leather'),
(8,4,9078,'Cloth'),
(8,4,9125,'Generic'),
(8,4,16092,'Defensive State (DND)'),
(8,4,20555,'Regeneration'),
(8,4,20557,'Beast Slaying'),
(8,4,20558,'Throwing Specialization'),
(8,4,21184,'Rogue Passive (DND)'),
(8,4,21651,'Opening'),
(8,4,21652,'Closing'),
(8,4,22027,'Remove Insignia'),
(8,4,22810,'Opening - No Text'),
(8,4,26290,'Bow Specialization'),
(8,4,26297,'Berserking'),
(8,4,45927,'Summon Friend'),
(8,4,58943,'Da Voodoo Shuffle'),
(8,4,61437,'Opening'),
(8,5,81,'Dodge'),
(8,5,198,'One-Handed Maces'),
(8,5,203,'Unarmed'),
(8,5,204,'Defense'),
(8,5,522,'SPELLDEFENSE (DND)'),
(8,5,585,'Smite'),
(8,5,669,'Language Orcish'),
(8,5,1843,'Disarm'),
(8,5,2050,'Lesser Heal'),
(8,5,2382,'Generic'),
(8,5,2479,'Honorless Target'),
(8,5,3050,'Detect'),
(8,5,3365,'Opening'),
(8,5,5009,'Wands'),
(8,5,5019,'Shoot'),
(8,5,6233,'Closing'),
(8,5,6246,'Closing'),
(8,5,6247,'Opening'),
(8,5,6477,'Opening'),
(8,5,6478,'Opening'),
(8,5,6603,'Attack'),
(8,5,7266,'Duel'),
(8,5,7267,'Grovel'),
(8,5,7341,'Language Troll'),
(8,5,7355,'Stuck'),
(8,5,8386,'Attacking'),
(8,5,9078,'Cloth'),
(8,5,9125,'Generic'),
(8,5,26297,'Berserking'),
(8,5,20555,'Regeneration'),
(8,5,20557,'Beast Slaying'),
(8,5,20558,'Throwing Specialization'),
(8,5,21651,'Opening'),
(8,5,21652,'Closing'),
(8,5,22027,'Remove Insignia'),
(8,5,22810,'Opening - No Text'),
(8,5,26290,'Bow Specialization'),
(8,5,45927,'Summon Friend'),
(8,5,58943,'Da Voodoo Shuffle'),
(8,5,61437,'Opening'),
(8,6,81,'Dodge'),
(8,6,196,'One-Handed Axes'),
(8,6,197,'Two-Handed Axes'),
(8,6,200,'Polearms'),
(8,6,201,'One-Handed Swords'),
(8,6,202,'Two-Handed Swords'),
(8,6,203,'Unarmed'),
(8,6,204,'Defense'),
(8,6,522,'SPELLDEFENSE (DND)'),
(8,6,669,'Language Orcish'),
(8,6,674,'Dual Wield'),
(8,6,750,'Plate Mail'),
(8,6,1843,'Disarm'),
(8,6,2382,'Generic'),
(8,6,2479,'Honorless Target'),
(8,6,3050,'Detect'),
(8,6,3127,'Parry'),
(8,6,3275,'Linen Bandage'),
(8,6,3276,'Heavy Linen Bandage'),
(8,6,3277,'Wool Bandage'),
(8,6,3278,'Heavy Wool Bandage'),
(8,6,3365,'Opening'),
(8,6,6233,'Closing'),
(8,6,6246,'Closing'),
(8,6,6247,'Opening'),
(8,6,6477,'Opening'),
(8,6,6478,'Opening'),
(8,6,6603,'Attack'),
(8,6,7266,'Duel'),
(8,6,7267,'Grovel'),
(8,6,7341,'Language Troll'),
(8,6,7355,'Stuck'),
(8,6,7928,'Silk Bandage'),
(8,6,7929,'Heavy Silk Bandage'),
(8,6,7934,'Anti-Venom'),
(8,6,8386,'Attacking'),
(8,6,8737,'Mail'),
(8,6,9077,'Leather'),
(8,6,9078,'Cloth'),
(8,6,9125,'Generic'),
(8,6,10840,'Mageweave Bandage'),
(8,6,10841,'Heavy Mageweave Bandage'),
(8,6,10846,'First Aid'),
(8,6,18629,'Runecloth Bandage'),
(8,6,18630,'Heavy Runecloth Bandage'),
(8,6,20555,'Regeneration'),
(8,6,20557,'Beast Slaying'),
(8,6,20558,'Throwing Specialization'),
(8,6,21651,'Opening'),
(8,6,21652,'Closing'),
(8,6,22027,'Remove Insignia'),
(8,6,22810,'Opening - No Text'),
(8,6,26290,'Bow Specialization'),
(8,6,33391,'Journeyman Riding'),
(8,6,45462,'Plague Strike'),
(8,6,45477,'Icy Touch'),
(8,6,45902,'Blood Strike'),
(8,6,45903,'Offensive State (DND)'),
(8,6,45927,'Summon Friend'),
(8,6,47541,'Death Coil'),
(8,6,48266,'Blood Presence'),
(8,6,49410,'Forceful Deflection'),
(8,6,49576,'Death Grip'),
(8,6,26297,'Berserking'),
(8,6,52665,'Sigil'),
(8,6,58943,'Da Voodoo Shuffle'),
(8,6,59879,'Blood Plague'),
(8,6,59921,'Frost Fever'),
(8,6,61437,'Opening'),
(8,6,61455,'Runic Focus'),
(8,7,81,'Dodge'),
(8,7,107,'Block'),
(8,7,198,'One-Handed Maces'),
(8,7,203,'Unarmed'),
(8,7,204,'Defense'),
(8,7,227,'Staves'),
(8,7,331,'Healing Wave'),
(8,7,403,'Lightning Bolt'),
(8,7,522,'SPELLDEFENSE (DND)'),
(8,7,669,'Language Orcish'),
(8,7,1843,'Disarm'),
(8,7,2382,'Generic'),
(8,7,2479,'Honorless Target'),
(8,7,3050,'Detect'),
(8,7,3365,'Opening'),
(8,7,6233,'Closing'),
(8,7,6246,'Closing'),
(8,7,6247,'Opening'),
(8,7,6477,'Opening'),
(8,7,6478,'Opening'),
(8,7,6603,'Attack'),
(8,7,7266,'Duel'),
(8,7,7267,'Grovel'),
(8,7,7341,'Language Troll'),
(8,7,7355,'Stuck'),
(8,7,8386,'Attacking'),
(8,7,9077,'Leather'),
(8,7,9078,'Cloth'),
(8,7,9116,'Shield'),
(8,7,9125,'Generic'),
(8,7,26297,'Berserking'),
(8,7,20555,'Regeneration'),
(8,7,20557,'Beast Slaying'),
(8,7,20558,'Throwing Specialization'),
(8,7,21651,'Opening'),
(8,7,21652,'Closing'),
(8,7,22027,'Remove Insignia'),
(8,7,22810,'Opening - No Text'),
(8,7,26290,'Bow Specialization'),
(8,7,27763,'Totem'),
(8,7,45927,'Summon Friend'),
(8,7,58943,'Da Voodoo Shuffle'),
(8,7,61437,'Opening'),
(8,8,81,'Dodge'),
(8,8,133,'Fireball'),
(8,8,168,'Frost Armor'),
(8,8,203,'Unarmed'),
(8,8,204,'Defense'),
(8,8,227,'Staves'),
(8,8,522,'SPELLDEFENSE (DND)'),
(8,8,669,'Language Orcish'),
(8,8,1843,'Disarm'),
(8,8,2382,'Generic'),
(8,8,2479,'Honorless Target'),
(8,8,3050,'Detect'),
(8,8,3365,'Opening'),
(8,8,5009,'Wands'),
(8,8,5019,'Shoot'),
(8,8,6233,'Closing'),
(8,8,6246,'Closing'),
(8,8,6247,'Opening'),
(8,8,6477,'Opening'),
(8,8,6478,'Opening'),
(8,8,6603,'Attack'),
(8,8,7266,'Duel'),
(8,8,7267,'Grovel'),
(8,8,7341,'Language Troll'),
(8,8,7355,'Stuck'),
(8,8,8386,'Attacking'),
(8,8,9078,'Cloth'),
(8,8,9125,'Generic'),
(8,8,26297,'Berserking'),
(8,8,20555,'Regeneration'),
(8,8,20557,'Beast Slaying'),
(8,8,20558,'Throwing Specialization'),
(8,8,21651,'Opening'),
(8,8,21652,'Closing'),
(8,8,22027,'Remove Insignia'),
(8,8,22810,'Opening - No Text'),
(8,8,26290,'Bow Specialization'),
(8,8,45927,'Summon Friend'),
(8,8,58943,'Da Voodoo Shuffle'),
(8,8,61437,'Opening'),
(10,2,81,'Dodge'),
(10,2,107,'Block'),
(10,2,201,'One-Handed Swords'),
(10,2,202,'Two-Handed Swords'),
(10,2,203,'Unarmed'),
(10,2,204,'Defense'),
(10,2,522,'SPELLDEFENSE (DND)'),
(10,2,635,'Holy Light'),
(10,2,669,'Language Orcish'),
(10,2,813,'Language Thalassian'),
(10,2,822,'Magic Resistance'),
(10,2,2382,'Generic'),
(10,2,2479,'Honorless Target'),
(10,2,3050,'Detect'),
(10,2,3365,'Opening'),
(10,2,6233,'Closing'),
(10,2,6246,'Closing'),
(10,2,6247,'Opening'),
(10,2,6477,'Opening'),
(10,2,6478,'Opening'),
(10,2,6603,'Attack'),
(10,2,7266,'Duel'),
(10,2,7267,'Grovel'),
(10,2,7355,'Stuck'),
(10,2,8386,'Attacking'),
(10,2,8737,'Mail'),
(10,2,9077,'Leather'),
(10,2,9078,'Cloth'),
(10,2,9116,'Shield'),
(10,2,9125,'Generic'),
(10,2,21084,'Seal of Righteousness'),
(10,2,21651,'Opening'),
(10,2,21652,'Closing'),
(10,2,22027,'Remove Insignia'),
(10,2,22810,'Opening - No Text'),
(10,2,27762,'Libram'),
(10,2,28730,'Arcane Torrent'),
(10,2,28877,'Arcane Affinity'),
(10,3,75,'Auto Shot'),
(10,3,81,'Dodge'),
(10,3,203,'Unarmed'),
(10,3,204,'Defense'),
(10,3,264,'Bows'),
(10,3,522,'SPELLDEFENSE (DND)'),
(10,3,669,'Language Orcish'),
(10,3,813,'Language Thalassian'),
(10,3,822,'Magic Resistance'),
(10,3,1180,'Daggers'),
(10,3,2382,'Generic'),
(10,3,2479,'Honorless Target'),
(10,3,2973,'Raptor Strike'),
(10,3,3050,'Detect'),
(10,3,3365,'Opening'),
(10,3,6233,'Closing'),
(10,3,6246,'Closing'),
(10,3,6247,'Opening'),
(10,3,6477,'Opening'),
(10,3,6478,'Opening'),
(10,3,6603,'Attack'),
(10,3,7266,'Duel'),
(10,3,7267,'Grovel'),
(10,3,7355,'Stuck'),
(10,3,8386,'Attacking'),
(10,3,9077,'Leather'),
(10,3,9078,'Cloth'),
(10,3,9125,'Generic'),
(10,3,13358,'Defensive State (DND)'),
(10,3,21651,'Opening'),
(10,3,21652,'Closing'),
(10,3,22027,'Remove Insignia'),
(10,3,22810,'Opening - No Text'),
(10,3,24949,'Defensive State 2 (DND)'),
(10,3,28730,'Arcane Torrent'),
(10,3,28877,'Arcane Affinity'),
(10,3,34082,'Advantaged State (DND)'),
(10,4,81,'Dodge'),
(10,4,203,'Unarmed'),
(10,4,204,'Defense'),
(10,4,522,'SPELLDEFENSE (DND)'),
(10,4,669,'Language Orcish'),
(10,4,813,'Language Thalassian'),
(10,4,822,'Magic Resistance'),
(10,4,1180,'Daggers'),
(10,4,1752,'Sinister Strike'),
(10,4,2098,'Eviscerate'),
(10,4,2382,'Generic'),
(10,4,2479,'Honorless Target'),
(10,4,2567,'Thrown'),
(10,4,2764,'Throw'),
(10,4,3050,'Detect'),
(10,4,3365,'Opening'),
(10,4,6233,'Closing'),
(10,4,6246,'Closing'),
(10,4,6247,'Opening'),
(10,4,6477,'Opening'),
(10,4,6478,'Opening'),
(10,4,6603,'Attack'),
(10,4,7266,'Duel'),
(10,4,7267,'Grovel'),
(10,4,7355,'Stuck'),
(10,4,8386,'Attacking'),
(10,4,9077,'Leather'),
(10,4,9078,'Cloth'),
(10,4,9125,'Generic'),
(10,4,16092,'Defensive State (DND)'),
(10,4,21184,'Rogue Passive (DND)'),
(10,4,21651,'Opening'),
(10,4,21652,'Closing'),
(10,4,22027,'Remove Insignia'),
(10,4,22810,'Opening - No Text'),
(10,4,25046,'Arcane Torrent'),
(10,4,28877,'Arcane Affinity'),
(10,5,81,'Dodge'),
(10,5,198,'One-Handed Maces'),
(10,5,203,'Unarmed'),
(10,5,204,'Defense'),
(10,5,522,'SPELLDEFENSE (DND)'),
(10,5,585,'Smite'),
(10,5,669,'Language Orcish'),
(10,5,813,'Language Thalassian'),
(10,5,822,'Magic Resistance'),
(10,5,2050,'Lesser Heal'),
(10,5,2382,'Generic'),
(10,5,2479,'Honorless Target'),
(10,5,3050,'Detect'),
(10,5,3365,'Opening'),
(10,5,5009,'Wands'),
(10,5,5019,'Shoot'),
(10,5,6233,'Closing'),
(10,5,6246,'Closing'),
(10,5,6247,'Opening'),
(10,5,6477,'Opening'),
(10,5,6478,'Opening'),
(10,5,6603,'Attack'),
(10,5,7266,'Duel'),
(10,5,7267,'Grovel'),
(10,5,7355,'Stuck'),
(10,5,8386,'Attacking'),
(10,5,9078,'Cloth'),
(10,5,9125,'Generic'),
(10,5,21651,'Opening'),
(10,5,21652,'Closing'),
(10,5,22027,'Remove Insignia'),
(10,5,22810,'Opening - No Text'),
(10,5,28730,'Arcane Torrent'),
(10,5,28877,'Arcane Affinity'),
(10,6,81,'Dodge'),
(10,6,196,'One-Handed Axes'),
(10,6,197,'Two-Handed Axes'),
(10,6,200,'Polearms'),
(10,6,201,'One-Handed Swords'),
(10,6,202,'Two-Handed Swords'),
(10,6,203,'Unarmed'),
(10,6,204,'Defense'),
(10,6,522,'SPELLDEFENSE (DND)'),
(10,6,669,'Language Orcish'),
(10,6,674,'Dual Wield'),
(10,6,750,'Plate Mail'),
(10,6,813,'Language Thalassian'),
(10,6,822,'Magic Resistance'),
(10,6,1843,'Disarm'),
(10,6,2382,'Generic'),
(10,6,2479,'Honorless Target'),
(10,6,3050,'Detect'),
(10,6,3127,'Parry'),
(10,6,3275,'Linen Bandage'),
(10,6,3276,'Heavy Linen Bandage'),
(10,6,3277,'Wool Bandage'),
(10,6,3278,'Heavy Wool Bandage'),
(10,6,3365,'Opening'),
(10,6,6233,'Closing'),
(10,6,6246,'Closing'),
(10,6,6247,'Opening'),
(10,6,6477,'Opening'),
(10,6,6478,'Opening'),
(10,6,6603,'Attack'),
(10,6,7266,'Duel'),
(10,6,7267,'Grovel'),
(10,6,7355,'Stuck'),
(10,6,7928,'Silk Bandage'),
(10,6,7929,'Heavy Silk Bandage'),
(10,6,7934,'Anti-Venom'),
(10,6,8386,'Attacking'),
(10,6,8737,'Mail'),
(10,6,9077,'Leather'),
(10,6,9078,'Cloth'),
(10,6,9125,'Generic'),
(10,6,10840,'Mageweave Bandage'),
(10,6,10841,'Heavy Mageweave Bandage'),
(10,6,10846,'First Aid'),
(10,6,18629,'Runecloth Bandage'),
(10,6,18630,'Heavy Runecloth Bandage'),
(10,6,21651,'Opening'),
(10,6,21652,'Closing'),
(10,6,22027,'Remove Insignia'),
(10,6,22810,'Opening - No Text'),
(10,6,28877,'Arcane Affinity'),
(10,6,33391,'Journeyman Riding'),
(10,6,45462,'Plague Strike'),
(10,6,45477,'Icy Touch'),
(10,6,45902,'Blood Strike'),
(10,6,45903,'Offensive State (DND)'),
(10,6,45927,'Summon Friend'),
(10,6,47541,'Death Coil'),
(10,6,48266,'Blood Presence'),
(10,6,49410,'Forceful Deflection'),
(10,6,49576,'Death Grip'),
(10,6,50613,'Arcane Torrent'),
(10,6,52665,'Sigil'),
(10,6,59879,'Blood Plague'),
(10,6,59921,'Frost Fever'),
(10,6,61437,'Opening'),
(10,6,61455,'Runic Focus'),
(10,8,81,'Dodge'),
(10,8,133,'Fireball'),
(10,8,168,'Frost Armor'),
(10,8,203,'Unarmed'),
(10,8,204,'Defense'),
(10,8,227,'Staves'),
(10,8,522,'SPELLDEFENSE (DND)'),
(10,8,669,'Language Orcish'),
(10,8,813,'Language Thalassian'),
(10,8,822,'Magic Resistance'),
(10,8,2382,'Generic'),
(10,8,2479,'Honorless Target'),
(10,8,3050,'Detect'),
(10,8,3365,'Opening'),
(10,8,5009,'Wands'),
(10,8,5019,'Shoot'),
(10,8,6233,'Closing'),
(10,8,6246,'Closing'),
(10,8,6247,'Opening'),
(10,8,6477,'Opening'),
(10,8,6478,'Opening'),
(10,8,6603,'Attack'),
(10,8,7266,'Duel'),
(10,8,7267,'Grovel'),
(10,8,7355,'Stuck'),
(10,8,8386,'Attacking'),
(10,8,9078,'Cloth'),
(10,8,9125,'Generic'),
(10,8,21651,'Opening'),
(10,8,21652,'Closing'),
(10,8,22027,'Remove Insignia'),
(10,8,22810,'Opening - No Text'),
(10,8,28730,'Arcane Torrent'),
(10,8,28877,'Arcane Affinity'),
(10,9,81,'Dodge'),
(10,9,203,'Unarmed'),
(10,9,204,'Defense'),
(10,9,522,'SPELLDEFENSE (DND)'),
(10,9,669,'Language Orcish'),
(10,9,686,'Shadow Bolt'),
(10,9,687,'Demon Skin'),
(10,9,813,'Language Thalassian'),
(10,9,822,'Magic Resistance'),
(10,9,1180,'Daggers'),
(10,9,2382,'Generic'),
(10,9,2479,'Honorless Target'),
(10,9,3050,'Detect'),
(10,9,3365,'Opening'),
(10,9,5009,'Wands'),
(10,9,5019,'Shoot'),
(10,9,6233,'Closing'),
(10,9,6246,'Closing'),
(10,9,6247,'Opening'),
(10,9,6477,'Opening'),
(10,9,6478,'Opening'),
(10,9,6603,'Attack'),
(10,9,7266,'Duel'),
(10,9,7267,'Grovel'),
(10,9,7355,'Stuck'),
(10,9,8386,'Attacking'),
(10,9,9078,'Cloth'),
(10,9,9125,'Generic'),
(10,9,21651,'Opening'),
(10,9,21652,'Closing'),
(10,9,22027,'Remove Insignia'),
(10,9,22810,'Opening - No Text'),
(10,9,28730,'Arcane Torrent'),
(10,9,28877,'Arcane Affinity'),
(11,1,78,'Heroic Strike'),
(11,1,81,'Dodge'),
(11,1,107,'Block'),
(11,1,198,'One-Handed Maces'),
(11,1,201,'One-Handed Swords'),
(11,1,203,'Unarmed'),
(11,1,204,'Defense'),
(11,1,522,'SPELLDEFENSE (DND)'),
(11,1,668,'Language Common'),
(11,1,1843,'Disarm'),
(11,1,2382,'Generic'),
(11,1,2457,'Battle Stance'),
(11,1,2479,'Honorless Target'),
(11,1,3050,'Detect'),
(11,1,3365,'Opening'),
(11,1,5301,'Defensive State (DND)'),
(11,1,6233,'Closing'),
(11,1,6246,'Closing'),
(11,1,6247,'Opening'),
(11,1,6477,'Opening'),
(11,1,6478,'Opening'),
(11,1,6562,'Heroic Presence'),
(11,1,6603,'Attack'),
(11,1,7266,'Duel'),
(11,1,7267,'Grovel'),
(11,1,7355,'Stuck'),
(11,1,8386,'Attacking'),
(11,1,8737,'Mail'),
(11,1,9077,'Leather'),
(11,1,9078,'Cloth'),
(11,1,9116,'Shield'),
(11,1,9125,'Generic'),
(11,1,21651,'Opening'),
(11,1,21652,'Closing'),
(11,1,22027,'Remove Insignia'),
(11,1,22810,'Opening - No Text'),
(11,1,28875,'Gemcutting'),
(11,1,28880,'Gift of the Naaru'),
(11,1,29932,'Language Draenei'),
(11,1,32215,'Victorious State'),
(11,1,45927,'Summon Friend'),
(11,1,59221,'Shadow Resistance'),
(11,1,61437,'Opening'),
(11,2,81,'Dodge'),
(11,2,107,'Block'),
(11,2,198,'One-Handed Maces'),
(11,2,199,'Two-Handed Maces'),
(11,2,203,'Unarmed'),
(11,2,204,'Defense'),
(11,2,522,'SPELLDEFENSE (DND)'),
(11,2,635,'Holy Light'),
(11,2,668,'Language Common'),
(11,2,1843,'Disarm'),
(11,2,2382,'Generic'),
(11,2,2479,'Honorless Target'),
(11,2,3050,'Detect'),
(11,2,3365,'Opening'),
(11,2,6233,'Closing'),
(11,2,6246,'Closing'),
(11,2,6247,'Opening'),
(11,2,6477,'Opening'),
(11,2,6478,'Opening'),
(11,2,6562,'Heroic Presence'),
(11,2,6603,'Attack'),
(11,2,7266,'Duel'),
(11,2,7267,'Grovel'),
(11,2,7355,'Stuck'),
(11,2,8386,'Attacking'),
(11,2,8737,'Mail'),
(11,2,9077,'Leather'),
(11,2,9078,'Cloth'),
(11,2,9116,'Shield'),
(11,2,9125,'Generic'),
(11,2,21084,'Seal of Righteousness'),
(11,2,21651,'Opening'),
(11,2,21652,'Closing'),
(11,2,22027,'Remove Insignia'),
(11,2,22810,'Opening - No Text'),
(11,2,27762,'Libram'),
(11,2,28875,'Gemcutting'),
(11,2,29932,'Language Draenei'),
(11,2,45927,'Summon Friend'),
(11,2,59221,'Shadow Resistance'),
(11,2,59542,'Gift of the Naaru'),
(11,2,61437,'Opening'),
(11,3,75,'Auto Shot'),
(11,3,81,'Dodge'),
(11,3,201,'One-Handed Swords'),
(11,3,203,'Unarmed'),
(11,3,204,'Defense'),
(11,3,522,'SPELLDEFENSE (DND)'),
(11,3,668,'Language Common'),
(11,3,1843,'Disarm'),
(11,3,2382,'Generic'),
(11,3,2479,'Honorless Target'),
(11,3,2973,'Raptor Strike'),
(11,3,3050,'Detect'),
(11,3,3365,'Opening'),
(11,3,5011,'Crossbows'),
(11,3,6233,'Closing'),
(11,3,6246,'Closing'),
(11,3,6247,'Opening'),
(11,3,6477,'Opening'),
(11,3,6478,'Opening'),
(11,3,6562,'Heroic Presence'),
(11,3,6603,'Attack'),
(11,3,7266,'Duel'),
(11,3,7267,'Grovel'),
(11,3,7355,'Stuck'),
(11,3,8386,'Attacking'),
(11,3,9077,'Leather'),
(11,3,9078,'Cloth'),
(11,3,9125,'Generic'),
(11,3,13358,'Defensive State (DND)'),
(11,3,21651,'Opening'),
(11,3,21652,'Closing'),
(11,3,22027,'Remove Insignia'),
(11,3,22810,'Opening - No Text'),
(11,3,24949,'Defensive State 2 (DND)'),
(11,3,28875,'Gemcutting'),
(11,3,29932,'Language Draenei'),
(11,3,34082,'Advantaged State (DND)'),
(11,3,45927,'Summon Friend'),
(11,3,59221,'Shadow Resistance'),
(11,3,59543,'Gift of the Naaru'),
(11,3,61437,'Opening'),
(11,5,81,'Dodge'),
(11,5,198,'One-Handed Maces'),
(11,5,203,'Unarmed'),
(11,5,204,'Defense'),
(11,5,522,'SPELLDEFENSE (DND)'),
(11,5,585,'Smite'),
(11,5,668,'Language Common'),
(11,5,1843,'Disarm'),
(11,5,2050,'Lesser Heal'),
(11,5,2382,'Generic'),
(11,5,2479,'Honorless Target'),
(11,5,3050,'Detect'),
(11,5,3365,'Opening'),
(11,5,5009,'Wands'),
(11,5,5019,'Shoot'),
(11,5,6233,'Closing'),
(11,5,6246,'Closing'),
(11,5,6247,'Opening'),
(11,5,6477,'Opening'),
(11,5,6478,'Opening'),
(11,5,6603,'Attack'),
(11,5,7266,'Duel'),
(11,5,7267,'Grovel'),
(11,5,7355,'Stuck'),
(11,5,8386,'Attacking'),
(11,5,9078,'Cloth'),
(11,5,9125,'Generic'),
(11,5,21651,'Opening'),
(11,5,21652,'Closing'),
(11,5,22027,'Remove Insignia'),
(11,5,22810,'Opening - No Text'),
(11,5,28875,'Gemcutting'),
(11,5,28878,'Inspiring Presence'),
(11,5,29932,'Language Draenei'),
(11,5,45927,'Summon Friend'),
(11,5,59221,'Shadow Resistance'),
(11,5,59544,'Gift of the Naaru'),
(11,5,61437,'Opening'),
(11,6,81,'Dodge'),
(11,6,196,'One-Handed Axes'),
(11,6,197,'Two-Handed Axes'),
(11,6,200,'Polearms'),
(11,6,201,'One-Handed Swords'),
(11,6,202,'Two-Handed Swords'),
(11,6,203,'Unarmed'),
(11,6,204,'Defense'),
(11,6,522,'SPELLDEFENSE (DND)'),
(11,6,668,'Language Common'),
(11,6,674,'Dual Wield'),
(11,6,750,'Plate Mail'),
(11,6,1843,'Disarm'),
(11,6,2382,'Generic'),
(11,6,2479,'Honorless Target'),
(11,6,3050,'Detect'),
(11,6,3127,'Parry'),
(11,6,3275,'Linen Bandage'),
(11,6,3276,'Heavy Linen Bandage'),
(11,6,3277,'Wool Bandage'),
(11,6,3278,'Heavy Wool Bandage'),
(11,6,3365,'Opening'),
(11,6,6233,'Closing'),
(11,6,6246,'Closing'),
(11,6,6247,'Opening'),
(11,6,6477,'Opening'),
(11,6,6478,'Opening'),
(11,6,6562,'Heroic Presence'),
(11,6,6603,'Attack'),
(11,6,7266,'Duel'),
(11,6,7267,'Grovel'),
(11,6,7355,'Stuck'),
(11,6,7928,'Silk Bandage'),
(11,6,7929,'Heavy Silk Bandage'),
(11,6,7934,'Anti-Venom'),
(11,6,8386,'Attacking'),
(11,6,8737,'Mail'),
(11,6,9077,'Leather'),
(11,6,9078,'Cloth'),
(11,6,9125,'Generic'),
(11,6,10840,'Mageweave Bandage'),
(11,6,10841,'Heavy Mageweave Bandage'),
(11,6,10846,'First Aid'),
(11,6,18629,'Runecloth Bandage'),
(11,6,18630,'Heavy Runecloth Bandage'),
(11,6,21651,'Opening'),
(11,6,21652,'Closing'),
(11,6,22027,'Remove Insignia'),
(11,6,22810,'Opening - No Text'),
(11,6,28875,'Gemcutting'),
(11,6,29932,'Language Draenei'),
(11,6,33391,'Journeyman Riding'),
(11,6,45462,'Plague Strike'),
(11,6,45477,'Icy Touch'),
(11,6,45902,'Blood Strike'),
(11,6,45903,'Offensive State (DND)'),
(11,6,45927,'Summon Friend'),
(11,6,47541,'Death Coil'),
(11,6,48266,'Blood Presence'),
(11,6,49410,'Forceful Deflection'),
(11,6,49576,'Death Grip'),
(11,6,52665,'Sigil'),
(11,6,59221,'Shadow Resistance'),
(11,6,59539,'Shadow Resistance'),
(11,6,59545,'Gift of the Naaru'),
(11,6,59879,'Blood Plague'),
(11,6,59921,'Frost Fever'),
(11,6,61437,'Opening'),
(11,6,61455,'Runic Focus'),
(11,7,81,'Dodge'),
(11,7,107,'Block'),
(11,7,198,'One-Handed Maces'),
(11,7,203,'Unarmed'),
(11,7,204,'Defense'),
(11,7,227,'Staves'),
(11,7,331,'Healing Wave'),
(11,7,403,'Lightning Bolt'),
(11,7,522,'SPELLDEFENSE (DND)'),
(11,7,668,'Language Common'),
(11,7,1843,'Disarm'),
(11,7,2382,'Generic'),
(11,7,2479,'Honorless Target'),
(11,7,3050,'Detect'),
(11,7,3365,'Opening'),
(11,7,6233,'Closing'),
(11,7,6246,'Closing'),
(11,7,6247,'Opening'),
(11,7,6477,'Opening'),
(11,7,6478,'Opening'),
(11,7,6603,'Attack'),
(11,7,7266,'Duel'),
(11,7,7267,'Grovel'),
(11,7,7355,'Stuck'),
(11,7,8386,'Attacking'),
(11,7,9077,'Leather'),
(11,7,9078,'Cloth'),
(11,7,9116,'Shield'),
(11,7,9125,'Generic'),
(11,7,21651,'Opening'),
(11,7,21652,'Closing'),
(11,7,22027,'Remove Insignia'),
(11,7,22810,'Opening - No Text'),
(11,7,27763,'Totem'),
(11,7,28875,'Gemcutting'),
(11,7,28878,'Inspiring Presence'),
(11,7,29932,'Language Draenei'),
(11,7,45927,'Summon Friend'),
(11,7,59221,'Shadow Resistance'),
(11,7,59547,'Gift of the Naaru'),
(11,7,61437,'Opening'),
(11,8,81,'Dodge'),
(11,8,133,'Fireball'),
(11,8,168,'Frost Armor'),
(11,8,203,'Unarmed'),
(11,8,204,'Defense'),
(11,8,227,'Staves'),
(11,8,522,'SPELLDEFENSE (DND)'),
(11,8,668,'Language Common'),
(11,8,1843,'Disarm'),
(11,8,2382,'Generic'),
(11,8,2479,'Honorless Target'),
(11,8,3050,'Detect'),
(11,8,3365,'Opening'),
(11,8,5009,'Wands'),
(11,8,5019,'Shoot'),
(11,8,6233,'Closing'),
(11,8,6246,'Closing'),
(11,8,6247,'Opening'),
(11,8,6477,'Opening'),
(11,8,6478,'Opening'),
(11,8,6603,'Attack'),
(11,8,7266,'Duel'),
(11,8,7267,'Grovel'),
(11,8,7355,'Stuck'),
(11,8,8386,'Attacking'),
(11,8,9078,'Cloth'),
(11,8,9125,'Generic'),
(11,8,21651,'Opening'),
(11,8,21652,'Closing'),
(11,8,22027,'Remove Insignia'),
(11,8,22810,'Opening - No Text'),
(11,8,28875,'Gemcutting'),
(11,8,28878,'Inspiring Presence'),
(11,8,29932,'Language Draenei'),
(11,8,45927,'Summon Friend'),
(11,8,59221,'Shadow Resistance'),
(11,8,59548,'Gift of the Naaru'),
(11,8,61437,'Opening'),
(7,9,58284,'Chaos Bolt Passive'),
(10,9,58284,'Chaos Bolt Passive'),
(11,2,60091,'Judgement Anti-Parry/Dodge Passive'),
(10,2,60091,'Judgement Anti-Parry/Dodge Passive'),
(3,2,60091,'Judgement Anti-Parry/Dodge Passive'),
(1,2,60091,'Judgement Anti-Parry/Dodge Passive'),
(0,6,56816,'Rune Strike'),
(1,1,202,'Two-Handed Swords'),
(4,1,202,'Two-Handed Swords'),
(7,1,202,'Two-Handed Swords'),
(8,1,202,'Two-Handed Swords'),
(11,1,202,'Two-Handed Swords'),
(2,3,197,'Two-Handed Axes'),
(3,3,197,'Two-Handed Axes'),
(4,3,197,'Two-Handed Axes'),
(6,3,197,'Two-Handed Axes'),
(8,3,197,'Two-Handed Axes'),
(10,3,197,'Two-Handed Axes'),
(11,3,197,'Two-Handed Axes'),
(1,4,674,'Dual Wield'),
(2,4,674,'Dual Wield'),
(3,4,674,'Dual Wield'),
(4,4,674,'Dual Wield'),
(5,4,674,'Dual Wield'),
(7,4,674,'Dual Wield'),
(8,4,674,'Dual Wield'),
(10,4,674,'Dual Wield'),
(1,5,227,'Staves'),
(3,5,227,'Staves'),
(4,5,227,'Staves'),
(5,5,227,'Staves'),
(8,5,227,'Staves'),
(10,5,227,'Staves'),
(11,5,227,'Staves'),
(1,9,227,'Staves'),
(2,9,227,'Staves'),
(5,9,227,'Staves'),
(7,9,227,'Staves'),
(10,9,227,'Staves'),
(0,7,75461,'Flame Shock Passive'),
(0,9,75445,'Demonic Immolate');
/*!40000 ALTER TABLE `playercreateinfo_spell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_spell_custom`
--

DROP TABLE IF EXISTS `playercreateinfo_spell_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo_spell_custom` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Note` varchar(255) DEFAULT NULL,
  `Active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`race`,`class`,`Spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_spell_custom`
--

LOCK TABLES `playercreateinfo_spell_custom` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_spell_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `playercreateinfo_spell_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points_of_interest`
--

DROP TABLE IF EXISTS `points_of_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points_of_interest` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `icon` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `flags` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `icon_name` text NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `points_of_interest`
--

LOCK TABLES `points_of_interest` WRITE;
/*!40000 ALTER TABLE `points_of_interest` DISABLE KEYS */;
/*!40000 ALTER TABLE `points_of_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool_creature`
--

DROP TABLE IF EXISTS `pool_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_creature` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_guid` (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_creature`
--

LOCK TABLES `pool_creature` WRITE;
/*!40000 ALTER TABLE `pool_creature` DISABLE KEYS */;
/*!40000 ALTER TABLE `pool_creature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool_gameobject`
--

DROP TABLE IF EXISTS `pool_gameobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_gameobject` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_guid` (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_gameobject`
--

LOCK TABLES `pool_gameobject` WRITE;
/*!40000 ALTER TABLE `pool_gameobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `pool_gameobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool_pool`
--

DROP TABLE IF EXISTS `pool_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_pool` (
  `pool_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mother_pool` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `chance` float NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pool_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_pool`
--

LOCK TABLES `pool_pool` WRITE;
/*!40000 ALTER TABLE `pool_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `pool_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool_quest`
--

DROP TABLE IF EXISTS `pool_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_quest` (
  `entry` int(10) unsigned NOT NULL DEFAULT '0',
  `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry`),
  KEY `idx_guid` (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_quest`
--

LOCK TABLES `pool_quest` WRITE;
/*!40000 ALTER TABLE `pool_quest` DISABLE KEYS */;
/*!40000 ALTER TABLE `pool_quest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool_template`
--

DROP TABLE IF EXISTS `pool_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Pool entry',
  `max_limit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Max number of objects (0) is no limit',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_template`
--

LOCK TABLES `pool_template` WRITE;
/*!40000 ALTER TABLE `pool_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `pool_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prospecting_loot_template`
--

DROP TABLE IF EXISTS `prospecting_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prospecting_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prospecting_loot_template`
--

LOCK TABLES `prospecting_loot_template` WRITE;
/*!40000 ALTER TABLE `prospecting_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `prospecting_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quest_end_scripts`
--

DROP TABLE IF EXISTS `quest_end_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_end_scripts` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_end_scripts`
--

LOCK TABLES `quest_end_scripts` WRITE;
/*!40000 ALTER TABLE `quest_end_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `quest_end_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quest_poi`
--

DROP TABLE IF EXISTS `quest_poi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_poi` (
  `questId` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `objIndex` int(10) NOT NULL DEFAULT '0',
  `mapid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `WorldMapAreaId` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `FloorId` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `unk3` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `unk4` int(10) UNSIGNED NOT NULL DEFAULT '0',
  KEY `questId` (`questId`,`id`),
  KEY `id` (`id`,`questId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_poi`
--

LOCK TABLES `quest_poi` WRITE;
/*!40000 ALTER TABLE `quest_poi` DISABLE KEYS */;
/*!40000 ALTER TABLE `quest_poi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quest_poi_points`
--

DROP TABLE IF EXISTS `quest_poi_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_poi_points` (
  `questId` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `idx` int(10) unsigned NOT NULL DEFAULT '0',
  `x` int(10) NOT NULL DEFAULT '0',
  `y` int(10) NOT NULL DEFAULT '0',
  KEY `questId_id` (`questId`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_poi_points`
--

LOCK TABLES `quest_poi_points` WRITE;
/*!40000 ALTER TABLE `quest_poi_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `quest_poi_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quest_start_scripts`
--

DROP TABLE IF EXISTS `quest_start_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_start_scripts` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_start_scripts`
--

LOCK TABLES `quest_start_scripts` WRITE;
/*!40000 ALTER TABLE `quest_start_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `quest_start_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quest_template`
--

DROP TABLE IF EXISTS `quest_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Method` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `ZoneOrSort` smallint(6) NOT NULL DEFAULT '0',
  `SkillOrClassMask` mediumint(8) NOT NULL DEFAULT '0',
  `MinLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `QuestLevel` smallint(3) NOT NULL DEFAULT '1',
  `Type` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredRaces` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkillValue` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RepObjectiveFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RepObjectiveValue` mediumint(9) NOT NULL DEFAULT '0',
  `RepObjectiveFaction2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RepObjectiveValue2` mediumint(9) NOT NULL DEFAULT '0',
  `RequiredMinRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredMinRepValue` mediumint(9) NOT NULL DEFAULT '0',
  `RequiredMaxRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredMaxRepValue` mediumint(9) NOT NULL DEFAULT '0',
  `SuggestedPlayers` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LimitTime` int(10) unsigned NOT NULL DEFAULT '0',
  `QuestFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `SpecialFlags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CharTitleId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PlayersSlain` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BonusTalents` tinyint(3) unsigned NULL DEFAULT '0',
  `RewardArenaPoints` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PrevQuestId` mediumint(9) NOT NULL DEFAULT '0',
  `NextQuestId` mediumint(9) NOT NULL DEFAULT '0',
  `ExclusiveGroup` mediumint(9) NOT NULL DEFAULT '0',
  `NextQuestInChain` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewXPId` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `SrcItemId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `SrcItemCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SrcSpell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Title` text DEFAULT NULL,
  `Details` text DEFAULT NULL,
  `Objectives` text DEFAULT NULL,
  `OfferRewardText` text DEFAULT NULL,
  `RequestItemsText` text DEFAULT NULL,
  `EndText` text DEFAULT NULL,
  `CompletedText` text DEFAULT NULL,
  `ObjectiveText1` text DEFAULT NULL,
  `ObjectiveText2` text DEFAULT NULL,
  `ObjectiveText3` text DEFAULT NULL,
  `ObjectiveText4` text DEFAULT NULL,
  `ReqItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemId6` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqItemCount6` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSourceCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId1` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId2` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId3` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOId4` mediumint(9) NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqCreatureOrGOCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ReqSpellCast4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemId6` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewChoiceItemCount6` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemId1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemId2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemId3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemId4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewItemCount1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemCount2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemCount3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewItemCount4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RewRepFaction1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction2` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction3` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction4` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepFaction5` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewRepValueId1` mediumint(6) NOT NULL DEFAULT '0',
  `RewRepValueId2` mediumint(6) NOT NULL DEFAULT '0',
  `RewRepValueId3` mediumint(6) NOT NULL DEFAULT '0',
  `RewRepValueId4` mediumint(6) NOT NULL DEFAULT '0',
  `RewRepValueId5` mediumint(6) NOT NULL DEFAULT '0',
  `RewRepValue1` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue2` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue3` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue4` mediumint(9) NOT NULL DEFAULT '0',
  `RewRepValue5` mediumint(9) NOT NULL DEFAULT '0',
  `RewHonorAddition` int(10) signed NOT NULL DEFAULT '0',
  `RewHonorMultiplier` float NOT NULL DEFAULT '1',
  `unk0` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `RewOrReqMoney` int(11) NOT NULL DEFAULT '0',
  `RewMoneyMaxLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `RewSpell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewSpellCast` int(11) signed NOT NULL DEFAULT '0',
  `RewMailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RewMailDelaySecs` int(11) unsigned NOT NULL DEFAULT '0',
  `PointMapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PointX` float NOT NULL DEFAULT '0',
  `PointY` float NOT NULL DEFAULT '0',
  `PointOpt` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmote4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay1` int(11) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay2` int(11) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay3` int(11) unsigned NOT NULL DEFAULT '0',
  `DetailsEmoteDelay4` int(11) unsigned NOT NULL DEFAULT '0',
  `IncompleteEmote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CompleteEmote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmote4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay1` int(11) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay2` int(11) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay3` int(11) unsigned NOT NULL DEFAULT '0',
  `OfferRewardEmoteDelay4` int(11) unsigned NOT NULL DEFAULT '0',
  `StartScript` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `CompleteScript` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `WDBVerified` smallint(5) signed DEFAULT '1',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Quest System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_template`
--

LOCK TABLES `quest_template` WRITE;
/*!40000 ALTER TABLE `quest_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `quest_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference_loot_template`
--

DROP TABLE IF EXISTS `reference_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference_loot_template`
--

LOCK TABLES `reference_loot_template` WRITE;
/*!40000 ALTER TABLE `reference_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reputation_reward_rate`
--

DROP TABLE IF EXISTS `reputation_reward_rate`;
CREATE TABLE `reputation_reward_rate` (
  `faction` mediumint(8) unsigned NOT NULL default '0',
  `quest_rate` float NOT NULL default '1',
  `creature_rate` float NOT NULL default '1',
  `spell_rate` float NOT NULL default '1',
  PRIMARY KEY  (`faction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reputation_reward_rate`
--

LOCK TABLES `reputation_reward_rate` WRITE;
/*!40000 ALTER TABLE `reputation_reward_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `reputation_reward_rate` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `reputation_spillover_template`
--

DROP TABLE IF EXISTS `reputation_spillover_template`;
CREATE TABLE `reputation_spillover_template` (
  `faction` smallint(6) unsigned NOT NULL default '0' COMMENT 'faction entry',
  `faction1` smallint(6) unsigned NOT NULL default '0' COMMENT 'faction to give spillover for',
  `rate_1` float NOT NULL default '0' COMMENT 'the given rep points * rate',
  `rank_1` tinyint(3) unsigned NOT NULL default '0' COMMENT 'max rank, above this will not give any spillover',
  `faction2` smallint(6) unsigned NOT NULL default '0',
  `rate_2` float NOT NULL default '0',
  `rank_2` tinyint(3) unsigned NOT NULL default '0',
  `faction3` smallint(6) unsigned NOT NULL default '0',
  `rate_3` float NOT NULL default '0',
  `rank_3` tinyint(3) unsigned NOT NULL default '0',
  `faction4` smallint(6) unsigned NOT NULL default '0',
  `rate_4` float NOT NULL default '0',
  `rank_4` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`faction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Reputation spillover reputation gain';

--
-- Dumping data for table `reputation_spillover_template`
--

LOCK TABLES `reputation_spillover_template` WRITE;
/*!40000 ALTER TABLE `reputation_spillover_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `reputation_spillover_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserved_name`
--

DROP TABLE IF EXISTS `reserved_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserved_name` (
  `name` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player Reserved Names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserved_name`
--

LOCK TABLES `reserved_name` WRITE;
/*!40000 ALTER TABLE `reserved_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserved_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `script_texts`
--

DROP TABLE IF EXISTS `script_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_texts` (
  `npc_entry` mediumint(8) NOT NULL DEFAULT '0' COMMENT 'creature_template entry',
  `entry` mediumint(8) NOT NULL,
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`npc_entry`,`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Script Texts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `script_texts`
--

LOCK TABLES `script_texts` WRITE;
/*!40000 ALTER TABLE `script_texts` DISABLE KEYS */;
/*!40000 ALTER TABLE `script_texts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `script_waypoint`
--

DROP TABLE IF EXISTS `script_waypoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_waypoint` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'creature_template entry',
  `pointid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `location_x` float NOT NULL DEFAULT '0',
  `location_y` float NOT NULL DEFAULT '0',
  `location_z` float NOT NULL DEFAULT '0',
  `waittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'waittime in millisecs',
  `point_comment` text,
  PRIMARY KEY (`entry`,`pointid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Script Creature waypoints';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `script_waypoint`
--

LOCK TABLES `script_waypoint` WRITE;
/*!40000 ALTER TABLE `script_waypoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `script_waypoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season_linked_event`
--

DROP TABLE IF EXISTS `season_linked_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `season_linked_event` (
 `season` int(3) UNSIGNED NOT NULL default '0',
 `event` int(8) UNSIGNED NOT NULL default '0',
 PRIMARY KEY (`season`),
 UNIQUE (`season`,`event`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season_linked_event`
--

LOCK TABLES `season_linked_event` WRITE;
/*!40000 ALTER TABLE `season_linked_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `season_linked_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_discovery_template`
--

DROP TABLE IF EXISTS `skill_discovery_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_discovery_template` (
  `spellId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'SpellId of the discoverable spell',
  `reqSpell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'spell requirement',
  `reqSkillValue` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'skill points requirement',
  `chance` float NOT NULL DEFAULT '0' COMMENT 'chance to discover',
  PRIMARY KEY (`spellId`,`reqSpell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Skill Discovery System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_discovery_template`
--

LOCK TABLES `skill_discovery_template` WRITE;
/*!40000 ALTER TABLE `skill_discovery_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `skill_discovery_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_extra_item_template`
--

DROP TABLE IF EXISTS `skill_extra_item_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_extra_item_template` (
  `spellId` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'SpellId of the item creation spell',
  `requiredSpecialization` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Specialization spell id',
  `additionalCreateChance` float NOT NULL DEFAULT '0' COMMENT 'chance to create add',
  `additionalMaxNum` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'max num of adds',
  PRIMARY KEY (`spellId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Skill Specialization System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_extra_item_template`
--

LOCK TABLES `skill_extra_item_template` WRITE;
/*!40000 ALTER TABLE `skill_extra_item_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `skill_extra_item_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_fishing_base_level`
--

DROP TABLE IF EXISTS `skill_fishing_base_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill_fishing_base_level` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Area identifier',
  `skill` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Base skill level requirement',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Fishing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_fishing_base_level`
--

LOCK TABLES `skill_fishing_base_level` WRITE;
/*!40000 ALTER TABLE `skill_fishing_base_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `skill_fishing_base_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skinning_loot_template`
--

DROP TABLE IF EXISTS `skinning_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skinning_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skinning_loot_template`
--

LOCK TABLES `skinning_loot_template` WRITE;
/*!40000 ALTER TABLE `skinning_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `skinning_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_area`
--

DROP TABLE IF EXISTS `spell_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_area` (
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `area` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_start` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quest_start_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `quest_end` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `aura_spell` mediumint(8) NOT NULL DEFAULT '0',
  `racemask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `autocast` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell`,`area`,`quest_start`,`quest_start_active`,`aura_spell`,`racemask`,`gender`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_area`
--

LOCK TABLES `spell_area` WRITE;
/*!40000 ALTER TABLE `spell_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `spell_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_bonus_data`
--

DROP TABLE IF EXISTS `spell_bonus_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_bonus_data` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `direct_bonus` float NOT NULL DEFAULT '0',
  `dot_bonus` float NOT NULL DEFAULT '0',
  `ap_bonus` float NOT NULL DEFAULT '0',
  `ap_dot_bonus` float NOT NULL DEFAULT '0',
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_bonus_data`
--

LOCK TABLES `spell_bonus_data` WRITE;
/*!40000 ALTER TABLE `spell_bonus_data` DISABLE KEYS */;
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(49941, -1, -1, 0.04, -1, 'Death Knight - Blood Boil'),
(48721, 0, -1, 0.04, -1, 'Death Knight - Blood Boil'),
(55078, 0, 0, -1, 0.06325, 'Death Knight - Blood Plague'),
(50444, -1, -1, 0.105, -1, 'Death Knight - Corpse Explosion Triggered'),
(52212, 0, -1, 0.0475, -1, 'Death Knight - Death and Decay'),
(47632, -1, -1, 0.15, -1, 'Death Knight - Death Coil'),
(47633, -1, -1, 0.15, -1, 'Death Knight - Death Coil Heal'),
(55095, -1, 0, -1, 0.06325, 'Death Knight - Frost Fever'),
(58621, -1, -1, 0.08, -1, 'Death Knight - Glyph of Chains of Ice'),
(49184, -1, -1, 0.1, -1, 'Death Knight - Howling Blast'),
(45477, 0, -1, 0.1, -1, 'Death Knight - Icy Touch'),
(56903, 0, 0, 0, 0, 'Death Knight - Lichflame'),
(51460, 0, -1, -1, -1, 'Death Knight - Necrosis'),
(50842, -1, -1, 0.04, -1, 'Death Knight - Pestilence'),
(50401, 0, 0, 0, 0, 'Death Knight - Razor Frost'),
(47476, -1, -1, 0.06, -1, 'Death Knight - Strangulate'),
(50536, -1, 0, -1, -1, 'Death Knight - Unholy Blight (Rank 1)'),
(339, -1, 0.1, -1, -1, 'Druid - Entangling Roots'),
(60089, -1, -1, 0.15, -1, 'Druid - Faerie Fire (feral)'),
(5185, 1.611, -1, -1, -1, 'Druid - Healing Touch'),
(42231, 0.12898, -1, -1, -1, 'Druid - Hurricane Triggered'),
(5570, -1, 0.2, -1, -1, 'Druid - Insect Swarm'),
(33745,0,0,0,0.01,'Druid - Lacerate Rank 1($AP*0.05/number of ticks)'),
(48567,0,0,0,0.01,'Druid - Lacerate Rank 2($AP*0.05/number of ticks)'),
(48568,0,0,0,0.01,'Druid - Lacerate Rank 3($AP*0.05/number of ticks)'),
(33778, 0.589714, 0, 0, 0, 'Druid - Lifebloom final heal'),
(33763, 0, 0.09518, 0, 0, 'Druid - Lifebloom HoT(rank 1)'),
(48450, 0, 0.09518, 0, 0, 'Druid - Lifebloom HoT(rank 2)'),
(48451, 0, 0.09518, 0, 0, 'Druid - Lifebloom HoT(rank 3)'),
(48628, -1, -1, -1, 0.15, 'Druid - Lock Jaw'),
(8921, 0.1515, 0.13, -1, -1, 'Druid - Moonfire'),
(50464, 0.67305, -1, -1, -1, 'Druid - Nourish'),
(1822, -1, -1, 0.01, 0.06, 'Druid - Rake ($AP*0.18 / number of ticks)'),
(8936, 0.539, 0.188, -1, -1, 'Druid - Regrowth'),
(774, -1, 0.37604, -1, -1, 'Druid - Rejuvenation'),
(50294, 0.0119, -1, -1, -1, 'Druid - Starfall AOE rank 1'),
(53188, 0.0119, -1, -1, -1, 'Druid - Starfall AOE rank 2'),
(53189, 0.0119, -1, -1, -1, 'Druid - Starfall AOE rank 3'),
(53190, 0.0119, -1, -1, -1, 'Druid - Starfall AOE rank 4'),
(50288, 0.0458, -1, -1, -1, 'Druid - Starfall rank 1'),
(53191, 0.0458, -1, -1, -1, 'Druid - Starfall rank 2'),
(53194, 0.0458, -1, -1, -1, 'Druid - Starfall rank 3'),
(53195, 0.0458, -1, -1, -1, 'Druid - Starfall rank 4'),
(2912, 1, -1, -1, -1, 'Druid - Starfire'),
(18562, 0, 0, 0, 0, 'Druid - Swiftmend'),
(779, -1, -1, 0.063, -1, 'Druid - Swipe (Bear)'),
(44203, 0.538, -1, -1, -1, 'Druid - Tranquility Triggered'),
(61391, 0.193, -1, -1, -1, 'Druid - Typhoon'),
(48438, -1, 0.11505, -1, -1, 'Druid - Wild Growth'),
(5176, 0.5714, -1, -1, -1, 'Druid - Wrath'),
(3044, -1, -1, 0.15, -1, 'Hunter - Arcane Shot'),
(3674, -1, -1, -1, 0.02, 'Hunter - Black Arrow($RAP*0.1 / number of ticks)'),
(19306, -1, -1, 0.2, -1, 'Hunter - Counterattack'),
(13812, -1, -1, 0.1, -1, 'Hunter - Explosive Trap Effect'),
(13797, -1, -1, -1, 0.02, 'Hunter - Immolation Trap($RAP*0.1 / number of ticks)'),
(1495, -1, -1, 0.2, -1, 'Hunter - Mongoose Bite'),
(1978, -1, -1, -1, 0.04, 'Hunter - Serpent Sting($RAP*0.2 / number of ticks)'),
(56641, -1, -1, 0.1, -1, 'Hunter - Steady Shot'),
(42243, -1, -1, 0.07, -1, 'Hunter - Volley'),
(53352, -1, -1, 0.14, -1, 'Hunter - Explosive Shot (triggered)'),
(55039, 0, 0, 0, 0, 'Item - Gnomish Lightning Generator'),
(40293, 0, 0, 0, 0, 'Item - Siphon Essence'),
(44425, 0.7143, -1, -1, -1, 'Mage - Arcane Barrage'),
(30451, 0.7143, -1, -1, -1, 'Mage - Arcane Blast'),
(1449, 0.2128, -1, -1, -1, 'Mage - Arcane Explosion'),
(7268, 0.2857, -1, -1, -1, 'Mage - Arcane Missiles Triggered Spell Rank 1'),
(7269, 0.2857, -1, -1, -1, 'Mage - Arcane Missiles Triggered Spell Rank 2'),
(11113, 0.1936, -1, -1, -1, 'Mage - Blast Wave'),
(42208, 0.1437, -1, -1, -1, 'Mage - Blizzard Triggered Spell'),
(120, 0.214, -1, -1, -1, 'Mage - Cone of Cold'),
(31661, 0.1936, -1, -1, -1, 'Mage - Dragons Breath'),
(133, 1, -1, -1, -1, 'Mage - Fire Ball'),
(2136, 0.4286, -1, -1, -1, 'Mage - Fire Blast'),
(543, 0.1, -1, -1, -1, 'Mage - Fire Ward'),
(2120, 0.2357, 0.122, -1, -1, 'Mage - Flamestrike'),
(116, 0.8143, -1, -1, -1, 'Mage - Frost Bolt'),
(122, 0.193, -1, -1, -1, 'Mage - Frost Nova'),
(6143, 0.1, -1, -1, -1, 'Mage - Frost Ward'),
(44614, 0.8571, -1, -1, -1, 'Mage - Frostfire Bolt'),
(11426, 0.8053, -1, -1, -1, 'Mage - Ice Barrier'),
(30455, 0.1429, -1, -1, -1, 'Mage - Ice Lance'),
(12654, 0, 0, 0, 0, 'Mage - Ignite'),
(44457, 0.4, 0.2, -1, -1, 'Mage - Living Bomb'),
(1463, 0.8053, -1, -1, -1, 'Mage - Mana Shield'),
(34913, 0, 0, 0, 0, 'Mage - Molten Armor Triggered Rank 1'),
(11366, 1.15, 0.05, -1, -1, 'Mage - Pyroblast'),
(2948, 0.4286, -1, -1, -1, 'Mage - Scorch'),
(59638, 0.3, -1, 0, -1, 'Mage - Mirror Image Frostbolt'),
(59637, 0.15, -1, 0, -1, 'Mage - Mirror Image Fire Blast'),
(31935, 0.07, -1, 0.07, -1, 'Paladin - Avenger Shield'),
(53742, -1, 0.0176, -1, 0.03, 'Paladin - Blood Corruption'),
(26573, -1, 0.04, -1, 0.04, 'Paladin - Consecration'),
(879, 0.15, -1, 0.15, -1, 'Paladin - Exorcism'),
(19750, 1, -1, -1, -1, 'Paladin - Flash of Light'),
(53595, 0, 0, 0, 0, 'Paladin - Hammer of the Righteous'),
(24275, 0.15, -1, 0.15, -1, 'Paladin - Hammer of Wrath'),
(62124, 0.085, -1, -1, -1, 'Paladin - Hand of Reckoning'),
(635, 1.66, -1, -1, -1, 'Paladin - Holy Light'),
(20925, 0.09, -1, 0.056, -1, 'Paladin - Holy Shield'),
(25914, 0.81, -1, -1, -1, 'Paladin - Holy Shock Triggered Heal Rank 1'),
(25912, 0.4286, -1, -1, -1, 'Paladin - Holy Shock Triggered Hurt Rank 1'),
(31803, -1, 0.0176, -1, 0.03, 'Paladin - Holy Vengeance'),
(2812, 0.07, -1, 0.07, -1, 'Paladin - Holy Wrath'),
(31898, 0.25, -1, 0.16, -1, 'Paladin - Judgement of Blood Enemy'),
(32220, 0.0833, -1, 0.0533, -1, 'Paladin - Judgement of Blood Self'),
(20467, 0.25, -1, 0.16, -1, 'Paladin - Judgement of Command'),
(53733, 0.22, -1, 0.14, -1, 'Paladin - Judgement of Corruption'),
(20187, 0.32, 0, 0.2, 0, 'Paladin - Judgement of Righteousness'),
(53726, 0.25, -1, 0.16, -1, 'Paladin - Judgement of the Martyr Enemy'),
(53725, 0.0833, -1, 0.0533, -1, 'Paladin - Judgement of the Martyr Self'),
(31804, 0.22, 0, 0.14, 0, 'Paladin - Judgement of Vengeance'),
(54158, 0.25, 0, 0.16, 0, 'Paladin - Judgement (Seal of Light, Seal of Wisdom, Seal of Justice)'),
(58597, 0.75, -1, -1, -1, 'Paladin - Sacred Shield'),
(53601, 0.75, -1, -1, -1, 'Paladin - Sacred Shield'),
(31893, 0, 0, 0, 0, 'Paladin - Seal of Blood Proc Enemy'),
(32221, 0, 0, 0, 0, 'Paladin - Seal of Blood Proc Self'),
(20424, 0, 0, 0, 0, 'Paladin - Seal of Command Proc'),
(20167, 0.15, -1, 0.15, -1, 'Paladin - Seal of Light Proc'),
(25742, 0.07, -1, 0.039, -1, 'Paladin - Seal of Righteousness Dummy Proc'),
(53719, 0, 0, 0, 0, 'Paladin - Seal of the Martyr Proc Enemy'),
(53718, 0, 0, 0, 0, 'Paladin - Seal of the Martyr Proc Self'),
(20267, 0, 0, 0, 0, 'Paladin - Judgement of Light Proc'),
(25997, 0, 0, 0, 0, 'Paladin - Eye for an Eye'),
(50256, -1, -1, 0.08, -1, 'Pet Skills - Bear (Swipe)'),
(32546, 0.8068, -1, -1, -1, 'Priest - Binding Heal'),
(27813, 0, 0, 0, 0, 'Priest - Blessed Recovery Rank 1'),
(34861, 0.402, -1, -1, -1, 'Priest - Circle of Healing'),
(19236, 0.8068, -1, -1, -1, 'Priest - Desperate Prayer'),
(2944, -1, 0.1849, -1, -1, 'Priest - Devouring Plague'),
(63544, 0, -1, -1, -1, 'Priest - Empowered Renew'),
(2061, 0.8068, -1, -1, -1, 'Priest - Flash Heal'),
(2060, 1.6135, -1, -1, -1, 'Priest - Greater Heal'),
(14914, 0.5711, 0.024, -1, -1, 'Priest - Holy Fire'),
(15237, 0.1606, -1, -1, -1, 'Priest - Holy Nova Damage'),
(23455, 0.3035, -1, -1, -1, 'Priest - Holy Nova Heal Rank 1'),
(8129, 0, 0, 0, 0, 'Priest - Mana Burn'),
(8092, 0.428, -1, -1, -1, 'Priest - Mind Blast'),
(58381, 0.257, -1, -1, -1, 'Priest - Mind Flay'),
(49821, 0.2861, -1, -1, -1, 'Priest - Mind Sear Trigger Rank 1'),
(47750, 0.5362, -1, -1, -1, 'Priest - Penance Heal (Rank 1)'),
(52983, 0.5362, -1, -1, -1, 'Priest - Penance Heal (Rank 2)'),
(52954, 0.5362, -1, -1, -1, 'Priest - Penance Heal (Rank 3)'),
(58985, 0.5362, -1, -1, -1, 'Priest - Penance Heal (Rank 4)'),
(47666, 0.229, -1, -1, -1, 'Priest - Penance Hurt (Rank 1)'),
(52998, 0.229, -1, -1, -1, 'Priest - Penance Hurt (Rank 2)'),
(52999, 0.229, -1, -1, -1, 'Priest - Penance Hurt (Rank 3)'),
(53000, 0.229, -1, -1, -1, 'Priest - Penance Hurt (Rank 4)'),
(17, 0.8068, -1, -1, -1, 'Priest - Power Word: Shield'),
(596, 0.8068, -1, -1, -1, 'Priest - Prayer of Healing'),
(33110, 0.8068, 0, 0, 0, 'Priest - Prayer of Mending Heal Proc'),
(33619, 0, 0, 0, 0, 'Priest - Reflective Shield'),
(139, -1, 0.376, -1, -1, 'Priest - Renew'),
(32379, 0.4296, -1, -1, -1, 'Priest - Shadow Word: Death'),
(589, -1, 0.1829, -1, -1, 'Priest - Shadow Word: Pain'),
(34433, 0.65, -1, -1, -1, 'Priest - Shadowfiend'),
(585, 0.714, -1, -1, -1, 'Priest - Smite'),
(34914, -1, 0.4, -1, -1, 'Priest - Vampiric Touch'),
(7001, -1, 0.3333, -1, -1, 'Priest - Lightwell Renew Rank 1'),
(63675, 0, 0, 0, 0, 'Priest - Improved Devouring Plague'),
(56131, 0, 0, 0, 0, 'Priest - Glyph of Dispel Magic'),
(56160, 0, 0, 0, 0, 'Priest - Glyph of Power Word: Shield'),
(2818, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 1($AP*0.12 / number of ticks)'),
(2819, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 2($AP*0.12 / number of ticks)'),
(11353, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 3($AP*0.12 / number of ticks)'),
(11354, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 4($AP*0.12 / number of ticks)'),
(25349, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 5($AP*0.12 / number of ticks)'),
(26968, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 6($AP*0.12 / number of ticks)'),
(27187, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 7($AP*0.12 / number of ticks)'),
(57969, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 8($AP*0.12 / number of ticks)'),
(57970, -1, -1, -1, 0.03, 'Rogue - Deadly Poison Rank 9($AP*0.12 / number of ticks)'),
(703, -1, -1, -1, 0.07, 'Rogue - Garrote'),
(1776, -1, -1, 0.21, -1, 'Rogue - Gouge'),
(8680, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 1'),
(8685, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 2'),
(8689, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 3'),
(11335, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 4'),
(11336, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 5'),
(11337, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 6'),
(26890, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 7'),
(57964, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 8'),
(57965, -1, -1, 0.1, -1, 'Rogue - Instant Poison Rank 9'),
(13218, -1, -1, 0.04, -1, 'Rogue - Wound Poison Rank 1'),
(13222, -1, -1, 0.04, -1, 'Rogue - Wound Poison Rank 2'),
(13223, -1, -1, 0.04, -1, 'Rogue - Wound Poison Rank 3'),
(13224, -1, -1, 0.04, -1, 'Rogue - Wound Poison Rank 4'),
(27189, -1, -1, 0.04, -1, 'Rogue - Wound Poison Rank 5'),
(57974, -1, -1, 0.04, -1, 'Rogue - Wound Poison Rank 6'),
(57975, -1, -1, 0.04, -1, 'Rogue - Wound Poison Rank 7'),
(1064, 1.34, -1, -1, -1, 'Shaman - Chain Heal'),
(421, 0.57, -1, -1, -1, 'Shaman - Chain Lightning'),
(974, 0.4762, -1, -1, -1, 'Shaman - Earth Shield'),
(379, 0, 0, 0, 0, 'Shaman - Earth Shield Triggered'),
(8042, 0.3858, -1, -1, -1, 'Shaman - Earth Shock'),
(8050, 0.2142, 0.1, -1, -1, 'Shaman - Flame Shock'),
(10444, 0, 0, 0, 0, 'Shaman - Flametongue Trigger'),
(8026, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 1'),
(58788, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 10'),
(8028, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 2'),
(8029, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 3'),
(10445, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 4'),
(16343, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 5'),
(16344, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 6'),
(25488, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 7'),
(58786, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 8'),
(58787, 0.1, -1, -1, -1, 'Shaman - Flametongue Weapon Proc Rank 9'),
(8056, 0.3858, -1, -1, -1, 'Shaman - Frost Shock'),
(8034, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 1'),
(8037, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 2'),
(10458, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 3'),
(16352, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 4'),
(16353, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 5'),
(25501, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 6'),
(58797, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 7'),
(58798, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 8'),
(58799, 0.1, -1, -1, -1, 'Shaman - Frostbrand Attack Rank 9'),
(2645, 0, 0, 0, 0, 'Shaman - Glyph of Ghost Wolf'),
(52042, 0.0445, 0.0445, -1, -1, 'Shaman - Healing Stream Totem Triggered Heal'),
(331, 1.6106, -1, -1, -1, 'Shaman - Healing Wave'),
(51505, 0.5714, -1, -1, -1, 'Shaman - Lava Burst'),
(8004, 0.8082, -1, -1, -1, 'Shaman - Lesser Healing Wave'),
(403, 0.7143, -1, -1, -1, 'Shaman - Lightning Bolt'),
(26364, 0.33, -1, -1, -1, 'Shaman - Lightning Shield Proc Rank 1'),
(45284, 0.357, -1, -1, -1, 'Shaman - LO Lightning Bolt'),
(45297, 0.285, -1, -1, -1, 'Shaman - LO Chain Lightning'),
(8188, 0.1, -1, -1, -1, 'Shaman - Magma Totam Passive Rank 1'),
(10582, 0.1, -1, -1, -1, 'Shaman - Magma Totam Passive Rank 2'),
(10583, 0.1, -1, -1, -1, 'Shaman - Magma Totam Passive Rank 3'),
(10584, 0.1, -1, -1, -1, 'Shaman - Magma Totam Passive Rank 4'),
(25551, 0.1, -1, -1, -1, 'Shaman - Magma Totam Passive Rank 5'),
(58733, 0.1, -1, -1, -1, 'Shaman - Magma Totam Passive Rank 6'),
(58736, 0.1, -1, -1, -1, 'Shaman - Magma Totam Passive Rank 7'),
(61295, 0.4, 0.18, -1, -1, 'Shaman - Riptide'),
(3606, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 1'),
(58702, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 10'),
(6350, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 2'),
(6351, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 3'),
(6352, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 4'),
(10435, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 5'),
(10436, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 6'),
(25530, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 7'),
(58700, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 8'),
(58701, 0.1667, -1, -1, -1, 'Shaman - Searing Totem Attack Rank 9'),
(52752, 0, 0, 0, 0, 'Shaman - Ancestral Awakening'),
(70809, 0, 0, 0, 0, 'Shaman - Item - T10 Restoration 4P Bonus'),
(55533, 0, 0, 0, 0, 'Shaman - Glyph of Healing Wave'),
(50796, 0.7139, -1, -1, -1, 'Warlock - Chaos Bolt'),
(17962, 0, 0, 0, 0, 'Warlock - Conflagrate'),
(172, -1, 0.2, -1, -1, 'Warlock - Corruption'),
(980, -1, 0.1, -1, -1, 'Warlock - Curse of Agony'),
(603, -1, 2, -1, -1, 'Warlock - Curse of Doom'),
(18220, 0.96, -1, -1, -1, 'Warlock - Dark Pact Rank 1'),
(6789, 0.214, -1, -1, -1, 'Warlock - Death Coil'),
(689, -1, 0.143, -1, -1, 'Warlock - Drain Life'),
(5138, 0, 0, 0, 0, 'Warlock - Drain Mana'),
(1120, -1, 0.429, -1, -1, 'Warlock - Drain Soul'),
(28176, 0, 0, 0, 0, 'Warlock - Fel Armor'),
(18790, 0, 0, 0, 0, 'Warlock - Fel Stamina'),
(54181, 0, -1, -1, -1, 'Warlock - Fel Synergy'),
(48181, 0.4793, -1, -1, -1, 'Warlock - Haunt'),
(755, -1, 0.4485, -1, -1, 'Warlock - Health Funnel'),
(1949, -1, 0.0949, -1, -1, 'Warlock - Hellfire'),
(5857, 0.145, -1, -1, -1, 'Warlock - Hellfire Effect on Enemy Rank 1'),
(348, 0.2, 0.2, -1, -1, 'Warlock - Immolate'),
(29722, 0.7139, -1, -1, -1, 'Warlock - Incinerate'),
(42223, 0.286, -1, -1, -1, 'Warlock - Rain of Fire Triggered Rank 1'),
(5676, 0.4293, -1, -1, -1, 'Warlock - Searing Pain'),
(27243, 0.2129, 0.25, -1, -1, 'Warlock - Seed of Corruption'),
(686, 0.8569, -1, -1, -1, 'Warlock - Shadow Bolt'),
(6229, 0.3, -1, -1, -1, 'Warlock - Shadow Ward'),
(17877, 0.4293, -1, -1, -1, 'Warlock - Shadowburn'),
(47960, 0.1064, 0.0667, -1, -1, 'Warlock - Shadowflame Rank 1'),
(61291, 0.1064, 0.0667, -1, -1, 'Warlock - Shadowflame Rank 2'),
(30283, 0.1932, -1, -1, -1, 'Warlock - Shadowfury'),
(63106, 0, 0, 0, 0, 'Warlock - Siphon Life Triggered'),
(6353, 1.15, -1, -1, -1, 'Warlock - Soul Fire'),
(30294, 0, 0, 0, 0, 'Warlock - Soul Leech'),
(30108, -1, 0.2, -1, -1, 'Warlock - Unstable Affliction'),
(31117, 1.8, -1, -1, -1, 'Warlock - Unstable Affliction Dispell'),
(57755, -1, -1, 0.5, -1, 'Warrior - Heroic Throw'),
(20253, -1, -1, 0.12, -1, 'Warrior - Intercept'),
(61491, -1, -1, 0.12, -1, 'Warrior - Intercept'),
(6572, -1, -1, 0.207, -1, 'Warrior - Revenge'),
(64382, -1, -1, 0.5, -1, 'Warrior - Shattering Throw'),
(6343, -1, -1, 0.12, -1, 'Warrior - Thunder Clap'),
(54757, 0, -1, -1, -1, 'Hand-Mounted Pyro Rocket - Pyro Rocket'),
(45055, 0, -1, -1, -1, 'Timbal''s Focusing Crystal - Shadow Bolt'),
(60203, 0, -1, -1, -1, 'Darkmoon Card: Death'),
(60488, 0, -1, -1, -1, 'Extract of Necromatic Power'),
(45429, 0, -1, -1, -1, 'Shattered Sun Pendant of Acumen - Arcane Bolt'),
(56161, 0, 0, 0, 0, 'Priest - Glyph of Prayer of Healing');
/*!40000 ALTER TABLE `spell_bonus_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_dbc`
--

DROP TABLE IF EXISTS `spell_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_dbc` (
  `Id` int(10) unsigned NOT NULL,
  `Dispel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Mechanic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Attributes` int(10) unsigned NOT NULL DEFAULT '0',
  `AttributesEx` int(10) unsigned NOT NULL DEFAULT '0',
  `AttributesEx2` int(10) unsigned NOT NULL DEFAULT '0',
  `AttributesEx3` int(10) unsigned NOT NULL DEFAULT '0',
  `AttributesEx4` int(10) unsigned NOT NULL DEFAULT '0',
  `AttributesEx5` int(10) unsigned NOT NULL DEFAULT '0',
  `Stances` int(10) unsigned NOT NULL DEFAULT '0',
  `StancesNot` int(10) unsigned NOT NULL DEFAULT '0',
  `Targets` int(10) unsigned NOT NULL DEFAULT '0',
  `CastingTimeIndex` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `AuraInterruptFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `ProcFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `ProcChance` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProcCharges` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BaseLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SpellLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DurationIndex` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RangeIndex` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `StackAmount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EquippedItemClass` int(11) NOT NULL DEFAULT '-1',
  `EquippedItemSubClassMask` int(11) NOT NULL DEFAULT '0',
  `EquippedItemInventoryTypeMask` int(11) NOT NULL DEFAULT '0',
  `Effect1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Effect2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Effect3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectDieSides1` int(11) NOT NULL DEFAULT '0',
  `EffectDieSides2` int(11) NOT NULL DEFAULT '0',
  `EffectDieSides3` int(11) NOT NULL DEFAULT '0',
  `EffectRealPointsPerLevel1` float NOT NULL DEFAULT '0',
  `EffectRealPointsPerLevel2` float NOT NULL DEFAULT '0',
  `EffectRealPointsPerLevel3` float NOT NULL DEFAULT '0',
  `EffectBasePoints1` int(11) NOT NULL DEFAULT '0',
  `EffectBasePoints2` int(11) NOT NULL DEFAULT '0',
  `EffectBasePoints3` int(11) NOT NULL DEFAULT '0',
  `EffectMechanic1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectMechanic2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectMechanic3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectImplicitTargetA1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectImplicitTargetA2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectImplicitTargetA3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectImplicitTargetB1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectImplicitTargetB2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectImplicitTargetB3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectRadiusIndex1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectRadiusIndex2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectRadiusIndex3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EffectApplyAuraName1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EffectApplyAuraName2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EffectApplyAuraName3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EffectAmplitude1` int(11) NOT NULL DEFAULT '0',
  `EffectAmplitude2` int(11) NOT NULL DEFAULT '0',
  `EffectAmplitude3` int(11) NOT NULL DEFAULT '0',
  `EffectMultipleValue1` float NOT NULL DEFAULT '0',
  `EffectMultipleValue2` float NOT NULL DEFAULT '0',
  `EffectMultipleValue3` float NOT NULL DEFAULT '0',
  `EffectMiscValue1` int(11) NOT NULL DEFAULT '0',
  `EffectMiscValue2` int(11) NOT NULL DEFAULT '0',
  `EffectMiscValue3` int(11) NOT NULL DEFAULT '0',
  `EffectMiscValueB1` int(11) NOT NULL DEFAULT '0',
  `EffectMiscValueB2` int(11) NOT NULL DEFAULT '0',
  `EffectMiscValueB3` int(11) NOT NULL DEFAULT '0',
  `EffectTriggerSpell1` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectTriggerSpell2` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectTriggerSpell3` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskA1` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskA2` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskA3` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskB1` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskB2` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskB3` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskC1` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskC2` int(10) unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskC3` int(10) unsigned NOT NULL DEFAULT '0',
  `MaxTargetLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyName` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyFlags1` int(10) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyFlags2` int(10) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyFlags3` int(10) unsigned NOT NULL DEFAULT '0',
  `MaxAffectedTargets` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DmgClass` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PreventionType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DmgMultiplier1` float NOT NULL DEFAULT '0',
  `DmgMultiplier2` float NOT NULL DEFAULT '0',
  `DmgMultiplier3` float NOT NULL DEFAULT '0',
  `AreaGroupId` int(11) NOT NULL DEFAULT '0',
  `SchoolMask` int(10) unsigned NOT NULL DEFAULT '0',
  `Comment` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Custom spell.dbc entries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_dbc`
--

LOCK TABLES `spell_dbc` WRITE;
/*!40000 ALTER TABLE `spell_dbc` DISABLE KEYS */;
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(62388,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Demonic Circle: Teleport(48020) - casterAuraSpell'),
(65142,  3, 22, 0, 0, 0, 128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 13, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 'Crypt Fever - SPELL_AURA_LINKED'),
(34145,  0, 0, 0, 0, 0, 67108864, 0, 0, 0, 0, 0, 1, 0, 0, 101, 0, 0, 80, 80, 0, 1, 0, -1, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 29886, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 'Ritual of Souls Rank 1 - Trigger Create Soulwell (29886)'),
(58888,  0, 0, 0, 0, 0, 67108864, 0, 0, 0, 0, 0, 1, 0, 0, 101, 0, 0, 68, 68, 0, 1, 0, -1, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58889, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 'Ritual of Souls Rank 2 - Trigger Create Soulwell (58889)'),
(61988,  0, 0, 671089024, 268436480, 4, 269484032, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 25, 13, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Divine Shield Exclude Aura - 61988'),
(200000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 'Drain Soul increased damage - serverside spell'),
(42876,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 9275 reward serverside spell'),
(44987,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11521 reward serverside spell'),
(48803,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 12214 reward serverside spell'),
(68496,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item_template serverside spell'),
(72958,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item_template serverside spell'),
(32780,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 10040 reward serverside spell'),
(45453,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11587 reward serverside spell'),
(25347,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item_template serverside spell'),
(45315,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11566 reward serverside spell'),
(43236,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11288 reward serverside spell'),
(43459,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11332 reward serverside spell'),
(43499,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11250 reward serverside spell'),
(44275,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11432 reward serverside spell'),
(64689,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 13854 and 13862 reward serverside spell'),
(50574,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 12597 reward serverside spell'),
(71356,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2108 spellid0 serverside spell'),
(71803,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2108 spellid1 serverside spell'),
(72111,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2136 spellid0 serverside spell'),
(72125,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2136 spellid1 serverside spell'),
(70816,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2146 spellid0 serverside spell'),
(72233,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2146 spellid1 serverside spell'),
(72234,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2146 spellid2 serverside spell'),
(72235,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Spelldifficulty_dbc id:2146 spellid3 serverside spell'),
(58428,  0, 0, 671089024, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, 0, 0, 18, 1, 0, -1, 0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 'Overkill - aura remove spell'),
(56817,  0, 0, 384, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 16, 101, 1, 0, 67, 67, 1, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rune strike proc'),
(24899,  0, 0, 400, 1024, 0, 0, 2097152, 0, 144, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 137, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Heart of the Wild Bear Effect'),
(24900,  0, 0, 400, 1024, 0, 0, 2097152, 0, 1, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 166, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Heart of the Wild Cat Effect'),
(43503,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11261 reward serverside spell'),
(39613,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 10967 reward serverside spell'),
(34448,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 77, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Serverside spell orb of translocation (gobjid=180911)'),
(34452,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 77, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Serverside spell orb of translocation (gobjid=180912)'),
(39616,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 10966 reward serverside spell'),
(11202,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item 3776 spellid_1 serverside spell'),
(25359,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Item 21293 spellid_2 serverside spell'),
(40145,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11000 RewSpellCast serverside spell'),
(45767,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11670 RewSpellCast serverside spell'),
(71098,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 24451 RewSpellCast serverside spell'),
(70878,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Creature 40160 creature_addon serverside spell'),
(38406,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 10721 RewSpellCast serverside spell'),
(44805,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Aura used in creature_addon - serverside spell');
/*!40000 ALTER TABLE `spell_dbc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_group`
--

DROP TABLE IF EXISTS `spell_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_group` (
  `id` int(11) unsigned NOT NULL DEFAULT 0,
  `spell_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `spell_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_group`
--

LOCK TABLES `spell_group` WRITE;
/*!40000 ALTER TABLE `spell_group` DISABLE KEYS */;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
 -- SPELL_GROUP_ELIXIR_BATTLE
(1, 2367),
(1, 2374),
(1, 3160),
(1, 3164),
(1, 7844),
(1, 8212),
(1, 10667),
(1, 10669),
(1, 11328),
(1, 11334),
(1, 11390),
(1, 11405),
(1, 11406),
(1, 11474),
(1, 16322),
(1, 16323),
(1, 16329),
(1, 17038),
(1, 17537),
(1, 17538),
(1, 17539),
(1, 17624),
(1, 17626),
(1, 17627),
(1, 17628),
(1, 17629),
(1, 21920),
(1, 26276),
(1, 28486),
(1, 28488),
(1, 28490),
(1, 28491),
(1, 28493),
(1, 28497),
(1, 28501),
(1, 28503),
(1, 28518),
(1, 28519),
(1, 28520),
(1, 28521),
(1, 28540),
(1, 33720),
(1, 33721),
(1, 33726),
(1, 38954),
(1, 40567),
(1, 40568),
(1, 40572),
(1, 40573),
(1, 40575),
(1, 40576),
(1, 41608),
(1, 41609),
(1, 41610),
(1, 41611),
(1, 42735),
(1, 45373),
(1, 46837),
(1, 46839),
(1, 53746),
(1, 53748),
(1, 53749),
(1, 53752),
(1, 53755),
(1, 53758),
(1, 53760),
(1, 54212),
(1, 54452),
(1, 54494),
(1, 60340),
(1, 60341),
(1, 60344),
(1, 60345),
(1, 60346),
(1, 62380),
(1, 67016),
(1, 67017),
(1, 67018),
 -- SPELL_GROUP_ELIXIR_GUARDIAN
(2, 673),
(2, 2378),
(2, 2380),
(2, 3166),
(2, 3219),
(2, 3220),
(2, 3222),
(2, 3223),
(2, 3593),
(2, 10668),
(2, 10692),
(2, 10693),
(2, 11319),
(2, 11348),
(2, 11349),
(2, 11364),
(2, 11371),
(2, 11396),
(2, 15231),
(2, 15233),
(2, 16321),
(2, 16325),
(2, 16326),
(2, 16327),
(2, 17535),
(2, 17624),
(2, 17626),
(2, 17627),
(2, 17628),
(2, 17629),
(2, 24361),
(2, 24363),
(2, 24382),
(2, 24383),
(2, 24417),
(2, 27652),
(2, 27653),
(2, 28502),
(2, 28509),
(2, 28514),
(2, 28518),
(2, 28519),
(2, 28520),
(2, 28521),
(2, 28540),
(2, 29348),
(2, 39625),
(2, 39626),
(2, 39627),
(2, 39628),
(2, 40567),
(2, 40568),
(2, 40572),
(2, 40573),
(2, 40575),
(2, 40576),
(2, 41608),
(2, 41609),
(2, 41610),
(2, 41611),
(2, 42735),
(2, 46837),
(2, 46839),
(2, 53747),
(2, 53751),
(2, 53752),
(2, 53755),
(2, 53758),
(2, 53760),
(2, 53763),
(2, 53764),
(2, 54212),
(2, 60343),
(2, 60347),
(2, 62380),
(2, 67016),
(2, 67017),
(2, 67018),
 -- SPELL_GROUP_ELIXIR_UNSTABLE
(3, 40567),
(3, 40568),
(3, 40572),
(3, 40573),
(3, 40575),
(3, 40576),
 -- SPELL_GROUP_ELIXIR_SHATTRATH
(4, 41608),
(4, 41609),
(4, 41610),
(4, 41611),
(4, 46837),
(4, 46839),
 -- Well Fed
(1001, 19705),
(1001, 19706),
(1001, 19708),
(1001, 19709),
(1001, 19710),
(1001, 19711),
(1001, 24799),
(1001, 24870),
(1001, 25694),
(1001, 25941),
(1001, 33254),
(1001, 33256),
(1001, 33257),
(1001, 33259),
(1001, 33261),
(1001, 33263),
(1001, 33265),
(1001, 33268),
(1001, 33272),
(1001, 35272),
(1001, 40323),
(1001, 42293),
(1001, 43764),
(1001, 43771),
(1001, 44097),
(1001, 44098),
(1001, 44099),
(1001, 44100),
(1001, 44101),
(1001, 44102),
(1001, 44104),
(1001, 44105),
(1001, 44106),
(1001, 45245),
(1001, 45619),
(1001, 46682),
(1001, 46687),
(1001, 46899),
(1001, 53284),
(1001, 57079),
(1001, 57097),
(1001, 57100),
(1001, 57102),
(1001, 57107),
(1001, 57111),
(1001, 57139),
(1001, 57286),
(1001, 57288),
(1001, 57291),
(1001, 57294),
(1001, 57325),
(1001, 57327),
(1001, 57329),
(1001, 57332),
(1001, 57334),
(1001, 57356),
(1001, 57358),
(1001, 57360),
(1001, 57363),
(1001, 57365),
(1001, 57367),
(1001, 57371),
(1001, 57373),
(1001, 57399),
(1001, 58468),
(1001, 58479),
(1001, 59230),
(1001, 59690),
(1001, 59699),
(1001, 62349),
(1001, 64057),
(1001, 65247),
(1001, 65365),
(1001, 65410),
(1001, 65412),
(1001, 65414),
(1001, 65415),
(1001, 65416),
(1001, 66623),
(1001, 66624),
(1001, 69559),
(1001, 18125),
(1001, 18141),
(1001, 23697),
 -- Blessing of Might
(1002, 19740),
(1002, 25782),
(1002, 56520),
-- Battle Shout
(1003, 6673),
-- Blessing of Might, Battle Shout
(1004, -1002),
(1004, -1003),
-- Blessing of Wisdom
(1005, 19742),
(1005, 25894),
(1005, 56521),
-- Blessing of Kings
(1006, 20217),
(1006, 25898),
(1006, 43223),
(1006, 56525),
(1006, 58054),
-- Blessing of Sanctuary
(1007, 20911),
(1007, 25899),
-- Blessing of Protection
(1008, 41450),
(1008, 23415),
-- Blessing of Light
(1009, 32770),
-- Blessings
(1010, -1002),
(1010, -1005),
(1010, -1006),
(1010, -1007),
(1010, -1008),
(1010, -1009),
-- Commanding shout, Battle Shout
(1011,-1083),
(1011, -1003),
-- Armor Debuff (Major)
(1012,55749), -- Acid Spit
(1013,8647), -- Exposed Armor
(1014,7386), -- sunder Armor
-- Armor Debuff (Minor)
(1016,770), -- Faerie Fire
(1016,16857), -- Faerie Fire
(1017,56626), -- Sting
(1018,16231), -- Curse of Recklessness
-- Melee Haste Buff
(1020,55610), -- Improved Icy Talons
(1021,8515), -- windfury totem
-- Melee Critical Strike Chance Buff
(1023,17007), -- Leader of the Pack
(1024,29801), -- Rampage
-- Attack Power Buff (Multiplier)
(1026,53137), -- Abomination's Might
(1027,19506), -- Trueshot Aura
(1028,30802), -- Unleashed Rage
-- Bleed Damage Increase Debuff
(1030,33878), -- Mangle (Bear)
(1031,33876), -- Mangle (Cat)
(1032,46856), -- Trauma
-- Spell Critical Strike Chance Buff
(1034,24907), -- moonkng aura
(1035,51466), -- elemental oath
-- Spell Critical Strike Chance Debuff
(1037,11095), -- improved scorch
(1038,11180), -- Winter's Chill
-- Increased Spell Damage Taken Debuff
(1040,51099), -- Ebon Plaguebringer
(1041,48506), -- Earth and Moon
(1042,1490), -- Curse of the Elements
-- Increased Spell Power Buff
(1044,54646), -- Focus Magic
(1045,52109), -- Flametongue Totem
(1046,57658), -- Totem of Wrath
(1046,57660), -- Totem of Wrath
(1046,57662), -- Totem of Wrath
(1046,57663), -- Totem of Wrath
(1046,30708), -- Totem of Wrath
(1047,53646), -- Demonic Pact
-- Increased Spell Hit Chance Taken Debuff
(1049,33600), --  Improved Faerie Fire
(1050,33191), -- Misery
-- Percentage Haste Increase (All Types)
(1052,48384), -- Improved Moonkin Form
(1053,53379), -- Swift Retribution
-- Percentage Damage Increase
(1055,34455), -- Ferocious Inspiration
(1056,31869), -- Sanctified Retribution
-- Critical Strike Chance Taken Debuff (All types)
(1058,20335), -- Heart of the Crusader
-- totem of wrath  1046 CHECK IT!
-- Melee Attack Speed Slow Debuff
(1060,45477), -- Icy Touch
(1061,48483), -- Infected Wounds
(1062,53695), -- Judgements of the Just
(1063,6343), -- Thunder Clap
-- Melee Hit Chance Reduction Debuff
(1066,5570), -- Insect Swarm
(1067,3043), -- Scorpid Sting
-- Healing Debuff
(1070,13218), -- Wound Posion
(1071,19434), -- Aimed Shot
(1072,12294), -- Mortal Strike
(1073,46910), -- Furious Attacks
-- Attack Power Debuff
(1076,99), -- Demoralizing Roar
(1077,702), -- Curse of Weakness
(1078,1160), -- Demoralizing Shout
-- Agility and Strength Buff
(1080,8076), -- Strength of Earth
(1081,57330), -- Horn of Winter
-- Health Buff
(1083,469), -- Commanding Shout
(1084,6307), -- Blood Pact
-- Intellect Buff
(1086,1459), -- Arcane Intellect
(1104,23028), -- Arcane Brilliance
(1087,54424), -- Fel Intelligence
-- Spirit Buff
-- fel intelegencegoes here
(1105,14752), -- Divine Spirit
(1106,27681), -- Prayer of Spirit
-- Damage Reduction Percentage Buff
(1091,47930), -- Grace
(1092,20911), -- Blessing of Sanctuary
-- Percentage Increase Healing Received Buff
(1094,34123), -- tree of life aura
(1095,20138), -- Improved Devotion Aura
-- Armor Increase Percentage Buff
(1097,14892), -- Inspiration
(1098,16176), -- Ancestral Healing
-- Cast Speed Slow
(1100,1714), -- Curse of Tongues
(1101,31589), -- Slow
(1102,5760), -- Mind-numbing Poison
-- Armor Debuff (Major)
(1015,-1012),
(1015,-1013),
(1015,-1014),
-- Armor Debuff (Minor)
(1019,-1016),
(1019,-1017),
(1019,-1018),
-- Melee Haste Buff
(1022,-1020),
(1022,-1021),
-- Melee Critical Strike Chance Buff
(1025,-1023),
(1025,-1024),
-- Attack Power Buff (Multiplier)
(1029,-1026),
(1029,-1027),
(1029,-1028),
-- Bleed Damage Increase Debuff
(1033,-1030),
(1033,-1031),
(1033,-1032),
-- Spell Critical Strike Chance Buff
(1036,-1034),
(1036,-1035),
-- Spell Critical Strike Chance Debuff
(1039,-1037),
(1039,-1038),
-- Increased Spell Damage Taken Debuff
(1043,-1040),
(1043,-1041),
(1043,-1042),
-- Increased Spell Power Buff
(1048,-1044),
(1048,-1045),
(1048,-1046),
(1048,-1047),
-- Increased Spell Hit Chance Taken Debuff
(1051,-1049),
(1051,-1050),
-- Percentage Haste Increase (All Types)
(1054,-1052),
(1054,-1053),
-- Percentage Damage Increase
(1057,-1055),
(1057,-1056),
-- Critical Strike Chance Taken Debuff (All types)
(1059,-1058),
(1059,-1046),
-- Melee Attack Speed Slow Debuff
(1064,-1060),
(1064,-1061),
(1064,-1062),
(1064,-1063),
-- Melee Hit Chance Reduction Debuff
(1068,-1066),
(1068,-1067),
-- Healing Debuff
(1074,-1070),
(1074,-1071),
(1074,-1072),
(1074,-1073),
-- Attack Power Debuff
(1079,-1076),
(1079,-1077),
(1079,-1078),
-- Agility and Strength Buff
(1082,-1080),
(1082,-1081),
-- Health Buff
(1085,-1083),
(1085,-1084),
-- Intellect Buff
(1088,-1086),
(1088,-1104),
(1088,-1087),
-- Spirit Buff
(1090,-1087),
(1090,-1105),
(1090,-1106),
-- Damage Reduction Percentage Buff
(1093,-1091),
(1093,-1092),
-- Percentage Increase Healing Received Buff
(1096,-1094),
(1096,-1095),
-- Armor Increase Percentage Buff
(1099,-1097),
(1099,-1098),
-- Cast Speed Slow
(1103,-1100),
(1103,-1101),
(1103,-1102),
-- mage freezing spells
(1107, 122), -- Frost Nova
(1107, 33395), -- Freeze
(1107, 55080), -- Shattered Barrier
-- Mark/Gift of the Wild
(1108, 1126),
(1108, 21849),
-- Power Word/Prayer of Fortitude
(1109, 1243),
(1109, 21562),
-- Prayer of/Shadow Protection
(1110, 976),
(1110, 27683),
(1006, 72586), -- Blessing of Forgotten Kings (Drums)
(1108, 72588), -- Gift of the Wild (Drums)
(1109, 72590), -- Fortitude (Scroll)
-- Immolate / Unstable Affliction
(1112, 348),
(1112, 30108),
-- Amplify Magic / Dampen Magic
(1113, 1008),
(1113, 604);

/*!40000 ALTER TABLE `spell_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_enchant_proc_data`
--

DROP TABLE IF EXISTS `spell_enchant_proc_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_enchant_proc_data` (
  `entry` int(10) unsigned NOT NULL,
  `customChance` int(10) unsigned NOT NULL DEFAULT '0',
  `PPMChance` float unsigned NOT NULL DEFAULT '0',
  `procEx` float unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Spell enchant proc data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_enchant_proc_data`
--

LOCK TABLES `spell_enchant_proc_data` WRITE;
/*!40000 ALTER TABLE `spell_enchant_proc_data` DISABLE KEYS */;
INSERT INTO spell_enchant_proc_data (`entry`,`customChance`,`PPMChance`,`procEx`) VALUES
 -- Frostbrand Weapon
(2, 0, 8.8,0),
(12, 0, 8.8,0),
(524, 0, 8.8,0),
(1667, 0, 8.8,0),
(1668, 0, 8.8,0),
(2635, 0, 8.8,0),
(3782, 0, 8.8,0),
(3783, 0, 8.8,0),
(3784, 0, 8.8,0),
 -- Wound Poison
(703, 0, 21.43,0),
(704, 0, 21.43,0),
(705, 0, 21.43,0),
(706, 0, 21.43,0),
(2644, 0, 21.43,0),
(3772, 0, 21.43,0),
(3773, 0, 21.43,0),
 -- Instant Poison
(323, 0, 8.53,0),
(324, 0, 8.53,0),
(325, 0, 8.53,0),
(623, 0, 8.53,0),
(624, 0, 8.53,0),
(625, 0, 8.53,0),
(2641, 0, 8.53,0),
(3768, 0, 8.53,0),
(3769, 0, 8.53,0),
 -- Fiery Weapon
(803, 0, 6.0,0),
 -- Demonslaying
(912, 0, 6.0,0),
 -- Icy Weapon
(1894, 0, 3.0,0),
 -- Lifestealing
(1898, 0, 6.0,0),
 -- Unholy Weapon
(1899, 0, 1.0,0),
 -- Crusader
(1900, 0, 1.0,0),
 -- Mongoose
(2673, 0, 1.0,0),
 -- Battlemaster
(2675, 0, 1.0,0),
 -- Executioner
(3225, 0, 1.0,0),
 -- Icebreaker Weapon
(3239, 0, 3.0,0),
 -- Lifeward
(3241, 0, 3.0,0),
 -- Giantslaying
(3251, 0, 3.0,0),
 -- Deathfrost
(3273, 0, 3.0,0),
 -- Rune of the Fallen Crusader
(3368, 0, 1.0,0),
 -- Rune of Cinderglacier
(3369, 0, 1.0,0),
 -- Berserking
(3789, 0, 1.0,0),
 -- Blade Ward
(3869, 0, 1.0,0);
/*!40000 ALTER TABLE `spell_enchant_proc_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_learn_spell`
--

DROP TABLE IF EXISTS `spell_learn_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_learn_spell` (
  `entry` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SpellID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`entry`,`SpellID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_learn_spell`
--

LOCK TABLES `spell_learn_spell` WRITE;
/*!40000 ALTER TABLE `spell_learn_spell` DISABLE KEYS */;
INSERT INTO `spell_learn_spell` VALUES
(53428,53341,1),
(53428,53343,1),
(17002,24867,0),
(24866,24864,0),
(33872,47179,0),
(33873,47180,0),
(33943,34090,1),
(58984,21009,1);
/*!40000 ALTER TABLE `spell_learn_spell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_linked_spell`
--

-- --------
-- LINKED
-- --------
-- spell1 / spell2 / type
-- + + 0 caster casts 2 when casts 1
-- + - 0 caster removes aura 2 when casts 1
-- + + 1 target casts 2 on self (originalCaster = caster) when 1 casted by caster hits target
-- + - 1 target removes aura 2 when hit by 1
-- + + 2 when aura 1 is applied, aura 2 is also applied; when 1 is removed, 2 is also removed
-- + - 2 when aura 1 is applied, target is immune to spell 2, until 1 is removed
-- - + 0 target casts 2 on self (originalCaster = caster) when aura 1 casted by caster is removed
-- - - 0 aura 2 is removed when aura 1 is removed

DROP TABLE IF EXISTS `spell_linked_spell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_linked_spell` (
  `spell_trigger` mediumint(8) NOT NULL,
  `spell_effect` mediumint(8) NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  UNIQUE KEY `trigger_effect_type` (`spell_trigger`,`spell_effect`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_linked_spell`
--

LOCK TABLES `spell_linked_spell` WRITE;
/*!40000 ALTER TABLE `spell_linked_spell` DISABLE KEYS */;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
-- class
( 16857, 60089, 0, 'Faerie Fire (Feral)'),
( 31224, -1543, 2, 'Cloak of Shadows - Flare'),
( 15237, 23455, 0, 'Holy Nova (rank1)'),
( 15430, 23458, 0, 'Holy Nova (rank2)'),
( 15431, 23459, 0, 'Holy Nova (rank3)'),
( 27799, 27803, 0, 'Holy Nova (rank4)'),
( 27800, 27804, 0, 'Holy Nova (rank5)'),
( 27801, 27805, 0, 'Holy Nova (rank6)'),
( 25331, 25329, 0, 'Holy Nova (rank7)'),
( 48077, 48075, 0, 'Holy Nova (rank8)'),
( 48078, 48076, 0, 'Holy Nova (rank9)'),
(-19386, 24131, 0, 'Wyvern Sting'),
(-24132, 24134, 0, 'Wyvern Sting'),
(-24133, 24135, 0, 'Wyvern Sting'),
(-27068, 27069, 0, 'Wyvern Sting'),
(-49011, 49009, 0, 'Wyvern Sting'),
(-49012, 49010, 0, 'Wyvern Sting'),
( 47585, 60069, 2, 'Dispersion (transform/regen)'),
( 47585, 63230, 2, 'Dispersion (immunity)'),
( 61847, 61848, 2, 'Aspect of the dragonhawk'),
( 61846, 61848, 2, 'Aspect of the dragonhawk'),
( 47988, 54501, 2, 'Consume Shadows - Rank 9'),
( 47987, 54501, 2, 'Consume Shadows - Rank 8'),
( 27272, 54501, 2, 'Consume Shadows - Rank 7'),
( 17854, 54501, 2, 'Consume Shadows - Rank 6'),
( 17853, 54501, 2, 'Consume Shadows - Rank 5'),
( 17852, 54501, 2, 'Consume Shadows - Rank 4'),
( 17851, 54501, 2, 'Consume Shadows - Rank 3'),
( 17850, 54501, 2, 'Consume Shadows - Rank 2'),
( 17767, 54501, 2, 'Consume Shadows - Rank 1'),
(-5143, -36032, 0, 'Arcane Missiles Rank 1'),
(-5144, -36032, 0, 'Arcane Missiles Rank 2'),
(-5145, -36032, 0, 'Arcane Missiles Rank 3'),
(-8416, -36032, 0, 'Arcane Missiles Rank 4'),
(-8417, -36032, 0, 'Arcane Missiles Rank 5'),
(-10211,-36032, 0, 'Arcane Missiles Rank 6'),
(-10212,-36032, 0, 'Arcane Missiles Rank 7'),
(-25345,-36032, 0, 'Arcane Missiles Rank 8'),
(-27075,-36032, 0, 'Arcane Missiles Rank 9'),
(-38699,-36032, 0, 'Arcane Missiles Rank 10'),
(-38704,-36032, 0, 'Arcane Missiles Rank 11'),
(-42843,-36032, 0, 'Arcane Missiles Rank 12'),
(-42846,-36032, 0, 'Arcane Missiles Rank 13'),
( 53563, 53651, 2, 'Beacon of Light'),
(   781, 56446, 0, 'Disengage'),
( 57635, 57636, 0, 'Disengage'),
( 60932, 60934, 0, 'Disengage'),
( 61507, 61508, 0, 'Disengage'),
( 49576, 49560, 0, 'Death Grip'),
( 47897, 47960, 1, 'Shadowflame Rank 1'),
( 61290, 61291, 1, 'Shadowflame Rank 2'),
( 51723, 52874, 0, 'Fan Of Knives'),
( 32386, 60448, 2, 'Shadow Embrace Rank1'),
( 32388, 60465, 2, 'Shadow Embrace Rank2'),
( 32389, 60466, 2, 'Shadow Embrace Rank3'),
( 32390, 60467, 2, 'Shadow Embrace Rank4'),
( 32391, 60468, 2, 'Shadow Embrace Rank5'),
( 33206, 44416, 2, 'Pain Suppression (threat)'),
( 52610, 62071, 0, 'Savage Roar'),
(-52610,-62071, 0, 'Savage Roar'),
( 51209, 55095, 1, 'Hungering cold - frost fever'),
( 50334, 58923, 2, 'Berserk - modify target number aura'),
(-5229, -51185, 0, 'King of the Jungle - remove with enrage'),
( 48384, 50170, 2, 'Improved Moonkin Form'),
( 48395, 50171, 2, 'Improved Moonkin Form'),
( 48396, 50172, 2, 'Improved Moonkin Form'),
( 20594, 65116, 0, 'Stoneform'),
( 49039, 50397, 2, 'Lichborne - shapeshift'),
( 64382, 64380, 0, 'Shattering Throw'),
(-59907,     7, 0, 'Lightwell Charges - Suicide'),
( 19263, 67801, 2, 'Deterrence'),
( 45524, 55095, 0, 'Chains of Ice - Frost Fever'),
( 20066,-61840, 0, 'Repentance'),
( 66235, 66233, 0, 'Ardent Defender Visuals'),
( 58875, 58876, 0, 'Spirit Walk'),
-- Quest
( 40214, 40216, 2, 'Dragonmaw Illusion'),
( 40214, 42016, 2, 'Dragonmaw Illusion'),
( 66744, 66747, 0, 'Totem of the earthen ring'),
( 53099, 53098, 0, 'Trigger teleport to acherus (for quest 12757)'),
-- Creature
( 36574, 36650, 0, 'Apply Phase Slip Vulnerability'),
-- instance
(-30410, 44032, 0, 'Manticron Cube Mind Exhaustion'),
(-33711, 33686, 0, 'Murmur''s Shockwave (Normal)'),
(-38794, 33686, 0, 'Murmur''s Shockwave (Heroic)'),
( 33686, 31705, 0, 'Murmur''s Shockwave Jump'),
-- Zul'aman
( 44008, 45265, 1, 'Static Disruption Visual'),
( 43648, 44007, 1, 'Storm Eye Safe Zone'),
( 44007,-43657, 2, 'Storm Eye Safe Zone Immune'),
( 43658, 43653, 0, 'Electrical Arc Visual'),
( 43658, 43654, 0, 'Electrical Arc Visual'),
( 43658, 43655, 0, 'Electrical Arc Visual'),
( 43658, 43656, 0, 'Electrical Arc Visual'),
( 43658, 43659, 0, 'Electrical Arc Visual'),
-- black temple
-- (39992, 39835, 1, 'Needle Spine'),
( 39835, 39968, 1, 'Needle Spine'),
(-41376, 41377, 0, 'Spite'),
( 41126, 41131, 1, 'Flame Crash'),
(-41914, 41915, 0, 'Summon Parasitic Shadowfiend'),
(-41917, 41915, 0, 'Summon Parasitic Shadowfiend'),
( 39908, 40017, 1, 'Eye Blast'),
( 40604, 40616, 1, 'Fel Rage Aura'),
( 40616, 41625, 1, 'Fel Rage Aura'),
( 41292, 42017, 2, 'Aura of Suffering'),
-- sunwell
( 44869, 44866, 1, 'Spectral Blast Portal'),
-- (44869, 46648, 1, 'Spectral Blast Visual'), cause severe lag seems should be casted by go
( 44869, 46019, 1, 'Spectral Blast Teleport'),
( 46019, 46021, 1, 'Spectral Realm Aura'),
-- (46021, 44852, 1, 'Spectral Realm Aura'), 44852 makes boss friendly to you
(-46021, 46020, 0, 'Teleport: Normal Realm'),
( 46020, 44867, 1, 'Spectral Exhaustion'),
( 44867,-46019, 2, 'Spectral Exhaustion - Teleport: Spectral Realm'),
( 45661, 45665, 1, 'Encapsulate'),
( 45347,-45348, 1, 'Remove Flame Touched'),
( 45348,-45347, 1, 'Remove Dark Touched'),
( 45248, 45347, 1, 'Apply Dark Touched'),
( 45329, 45347, 1, 'Apply Dark Touched'),
( 45256, 45347, 1, 'Apply Dark Touched'),
( 45270, 45347, 1, 'Apply Dark Touched'),
( 45342, 45348, 1, 'Apply Flame Touched'),
( 46771, 45348, 1, 'Apply Flame Touched'),
( 45271, 45347, 1, 'Apply Dark Touched'),
( 45246, 45348, 1, 'Apply Flame Touched'),
( 44869,-45018, 1, 'Remove Arcane Buffet'),
( 46019,-45018, 1, 'Remove Arcane Buffet'),
( 46242, 46247, 0, 'Black Hole Visual (Birth)'),
( 46228, 46235, 0, 'Black Hole Visual (Grown)'),
( 46228,-46247, 0, 'Black Hole Visual (Grown)'),
( 46262, 46265, 0, 'Void Zone Visual'),
-- naxx
(-28169, 28206, 0, 'Mutating Injection - Mutagen Explosion'),
( 28732,-28798, 1, 'Widow''s Embrace - Frenzy'),
( 54097,-54100, 1, 'Widow''s Embrace - Frenzy (H)'),
(-28169, 28240, 0, 'Mutating Injection - Poison Cloud'),
-- Archavon
( 58666, 58672, 1, 'Impale (Archavon)'),
( 60882, 58672, 1, 'Impale (Archavon)'),
-- Violet Hold
(-54361, 54343, 0, 'Void Shift (Normal) - Void Shifted'),
(-59743, 54343, 0, 'Void Shift (Heroic) - Void Shifted'),
-- Gundrak
( 54850, 54851, 1, 'Emerge - Emerge Summon'),
-- Trial of the Champion
( 66680, 66547, 0, 'Confess - Confess'),
( 66889,-66865, 0, 'Remove Vengeance'),
-- Trial of the Crusader
( 66870,-66823, 1, 'Remove Paralytic Toxin when hit by Burning Bite'),
( 67621,-67618, 1, 'Remove Paralytic Toxin when hit by Burning Bite'),
( 67622,-67619, 1, 'Remove Paralytic Toxin when hit by Burning Bite'),
( 67623,-67620, 1, 'Remove Paralytic Toxin when hit by Burning Bite'),
(-66683, 68667, 0, 'Icehowl - Surge of Adrenaline'),
(-67661, 68667, 0, 'Icehowl - Surge of Adrenaline'),
-- Warsong Gulch
( 54861,-23335, 0, 'Drop Flag on Nitro Boost WSG'),
( 54861,-23333, 0, 'Drop Flag on Nitro Boost WSG'),
( 55004,-23335, 0, 'Drop Flag on Nitro Boost WSG'),
( 55004,-23333, 0, 'Drop Flag on Nitro Boost WSG'),
-- Eye of Storm
( 54861,-34976, 0, 'Drop Flag on Nitro Boost EOS'),
( 55004,-34976, 0, 'Drop Flag on Nitro Boost EOS'),
-- Strand of the Ancients
( 52415, 52418, 0, 'Carrying Seaforium - Add'),
( 52410,-52418, 0, 'Carrying Seaforium - Remove'),
-- Item
( 69381, 72588, 1, 'Drums of the Wild'),
( 69378, 72586, 1, 'Drums of the Forgotten Kings'),
( 69377, 72590, 1, 'Runescroll of Fortitude'),
( 50141, 50001, 0, 'Blood Oath to Blood Oath Aura'),
( 61263, 61267, 0, 'Intravenous Healing Effect'),
( 61263, 61268, 0, 'Intravenous Mana Regeneration Effect'),
-- PvP Trinket / Every Man for Himself / Will of the Forsaken
(7744, 72757, 0, 'Will of the Forsaken Cooldown Trigger (WOTF)'),
(42292, 72752, 0, 'Will of the Forsaken Cooldown Trigger'),
(59752, 72752, 0, 'Will of the Forsaken Cooldown Trigger');
/*!40000 ALTER TABLE `spell_linked_spell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_loot_template`
--

DROP TABLE IF EXISTS `spell_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_loot_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `item` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ChanceOrQuestChance` float NOT NULL DEFAULT '100',
  `lootmode` smallint(5) unsigned NOT NULL DEFAULT '1',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mincountOrRef` mediumint(9) NOT NULL DEFAULT '1',
  `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `lootcondition` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `condition_value1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `condition_value2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_loot_template`
--

LOCK TABLES `spell_loot_template` WRITE;
/*!40000 ALTER TABLE `spell_loot_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `spell_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_pet_auras`
--

DROP TABLE IF EXISTS `spell_pet_auras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_pet_auras` (
  `spell` mediumint(8) unsigned NOT NULL COMMENT 'dummy spell id',
  `effectId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pet` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'pet id; 0 = all',
  `aura` mediumint(8) unsigned NOT NULL COMMENT 'pet aura id',
  PRIMARY KEY (`spell`,`effectId`,`pet`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_pet_auras`
--

LOCK TABLES `spell_pet_auras` WRITE;
/*!40000 ALTER TABLE `spell_pet_auras` DISABLE KEYS */;
INSERT INTO `spell_pet_auras` VALUES (19028,0,0,25228),
(19578,0,0,19579),
(20895,0,0,24529),
(28757,0,0,28758),
(35029,0,0,35060),
(35030,0,0,35061),
(35691,0,0,35696),
(35692,0,0,35696),
(35693,0,0,35696),
(56314,0,0,57447),
(56314,1,0,57485),
(56315,0,0,57452),
(56315,1,0,57484),
(56316,0,0,57453),
(56316,1,0,57483),
(56317,0,0,57457),
(56317,1,0,57482),
(56318,0,0,57458),
(56318,1,0,57475),
(23785,0,416,23759),
(23822,0,416,23826),
(23823,0,416,23827),
(23824,0,416,23828),
(23825,0,416,23829),
(23785,0,417,23762),
(23822,0,417,23837),
(23823,0,417,23838),
(23824,0,417,23839),
(23825,0,417,23840),
(23785,0,1860,23760),
(23822,0,1860,23841),
(23823,0,1860,23842),
(23824,0,1860,23843),
(23825,0,1860,23844),
(23785,0,1863,23761),
(23822,0,1863,23833),
(23823,0,1863,23834),
(23824,0,1863,23835),
(23825,0,1863,23836),
(23785,0,17252,35702),
(23822,0,17252,35703),
(23823,0,17252,35704),
(23824,0,17252,35705),
(23825,0,17252,35706);
/*!40000 ALTER TABLE `spell_pet_auras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_proc_event`
--

DROP TABLE IF EXISTS `spell_proc_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_proc_event` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `SchoolMask` tinyint(4) NOT NULL DEFAULT '0',
  `SpellFamilyName` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask0` int(10) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask1` int(10) unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask2` int(10) unsigned NOT NULL DEFAULT '0',
  `procFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `procEx` int(10) unsigned NOT NULL DEFAULT '0',
  `ppmRate` float NOT NULL DEFAULT '0',
  `CustomChance` float NOT NULL DEFAULT '0',
  `Cooldown` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_proc_event`
--

LOCK TABLES `spell_proc_event` WRITE;
/*!40000 ALTER TABLE `spell_proc_event` DISABLE KEYS */;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(   324, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 1)
(   325, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 2)
(   905, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 3)
(   945, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 4)
(   974, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000222A8, 0x00000000,   0,   0,   3), -- Earth Shield (Rank 1)
(  1463, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 1)
(  3232, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Gouge Stun Test
(  5952, 0x00,   8, 0x00000001, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Throwing Specialization (Rank 1)
(  6346, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000100,   0,   0,   0), -- Fear Ward
(  7383, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000100,   0,   0,   0), -- Water Bubble
(  7434, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Fate Rune of Unsurpassed Vigor
(  8134, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 5)
(  8178, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Grounding Totem Effect (Rank 1)
(  8494, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 2)
(  8495, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 3)
(  9452, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Vindication (Rank 1)
(  9782, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Mithril Shield Spike
(  9784, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Iron Shield Spike
(  9799, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Eye for an Eye (Rank 1)
( 10191, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 4)
( 10192, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 5)
( 10193, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 6)
( 10431, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 6)
( 10432, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 7)
( 11095, 0x00,   3, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Scorch (Rank 1)
( 11119, 0x04,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ignite (Rank 1)
( 11120, 0x04,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ignite (Rank 2)
( 11129, 0x04,   3, 0x08c00017, 0x00031048, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Combustion
( 11180, 0x10,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Winter's Chill (Rank 1)
( 11185, 0x00,   3, 0x00000080, 0x00000000, 0x00000000, 0x00050000, 0x00000000,   0,   0,   0), -- Improved Blizzard (Rank 1)
( 11255, 0x00,   3, 0x00004000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Counterspell (Rank 1)
( 12169, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Shield Block
( 12281, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Sword Specialization (Rank 1)
( 12289, 0x00,   4, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Hamstring (Rank 1)
( 12298, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Shield Specialization (Rank 1)
( 12311, 0x00,   4, 0x00000800, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Gag Order (Rank 1)
( 12319, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 1)
( 12322, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Unbridled Wrath (Rank 1)
( 12487, 0x00,   3, 0x00000080, 0x00000000, 0x00000000, 0x00050000, 0x00000000,   0,   0,   0), -- Improved Blizzard (Rank 2)
( 12488, 0x00,   3, 0x00000080, 0x00000000, 0x00000000, 0x00050000, 0x00000000,   0,   0,   0), -- Improved Blizzard (Rank 3)
( 12598, 0x00,   3, 0x00004000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Counterspell (Rank 2)
( 12668, 0x00,   4, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Hamstring (Rank 2)
( 12724, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Shield Specialization (Rank 2)
( 12725, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Shield Specialization (Rank 3)
( 12726, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Shield Specialization (Rank 4)
( 12727, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Shield Specialization (Rank 5)
( 12797, 0x00,   4, 0x00000400, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Revenge (Rank 1)
( 12799, 0x00,   4, 0x00000400, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Revenge (Rank 2)
( 12812, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Sword Specialization (Rank 2)
( 12813, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Sword Specialization (Rank 3)
( 12814, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Sword Specialization (Rank 4)
( 12815, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Sword Specialization (Rank 5)
( 12834, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Deep Wounds (Rank 1)
( 12846, 0x04,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ignite (Rank 3)
( 12847, 0x04,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ignite (Rank 4)
( 12848, 0x04,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ignite (Rank 5)
( 12849, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Deep Wounds (Rank 2)
( 12867, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Deep Wounds (Rank 3)
( 12872, 0x00,   3, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Scorch (Rank 2)
( 12873, 0x00,   3, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Scorch (Rank 3)
( 12958, 0x00,   4, 0x00000800, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Gag Order (Rank 2)
( 12966, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 1)
( 12967, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 2)
( 12968, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 3)
( 12969, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 4)
( 12970, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 5)
( 12971, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 2)
( 12972, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 3)
( 12973, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 4)
( 12974, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 5)
( 12999, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   6,   0,   0), -- Unbridled Wrath (Rank 2)
( 13000, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   9,   0,   0), -- Unbridled Wrath (Rank 3)
( 13001, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  12,   0,   0), -- Unbridled Wrath (Rank 4)
( 13002, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  15,   0,   0), -- Unbridled Wrath (Rank 5)
( 13163, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000010,   0,   0,   0), -- Aspect of the Monkey
( 13754, 0x00,   8, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Kick (Rank 1)
( 13867, 0x00,   8, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Kick (Rank 2)
( 13983, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000018,   0,   0,   0), -- Setup (Rank 1)
( 14070, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000018,   0,   0,   0), -- Setup (Rank 2)
( 14071, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000018,   0,   0,   0), -- Setup (Rank 3)
( 14156, 0x00,   8, 0x003E0000, 0x80000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Ruthlessness (Rank 1)
( 14160, 0x00,   8, 0x003E0000, 0x80000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Ruthlessness (Rank 2)
( 14161, 0x00,   8, 0x003E0000, 0x80000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Ruthlessness (Rank 3)
( 14186, 0x00,   8, 0x40800508, 0x00000006, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Seal Fate (Rank 1)
( 14190, 0x00,   8, 0x40800508, 0x00000006, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Seal Fate (Rank 2)
( 14193, 0x00,   8, 0x40800508, 0x00000006, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Seal Fate (Rank 3)
( 14194, 0x00,   8, 0x40800508, 0x00000006, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Seal Fate (Rank 4)
( 14195, 0x00,   8, 0x40800508, 0x00000006, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Seal Fate (Rank 5)
( 14531, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Martyrdom (Rank 1)
( 14774, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Martyrdom (Rank 2)
( 14892, 0x00,   6, 0x10001E00, 0x00010004, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Inspiration (Rank 1)
( 15088, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry
( 15128, 0x04,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Mark of Flames
( 15277, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   6,   0,   0), -- Seal of Reckoning
( 15286, 0x20,   6, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vampiric Embrace
( 15337, 0x00,   6, 0x00002000, 0x00000002, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Improved Spirit Tap (Rank 1)
( 15338, 0x00,   6, 0x00002000, 0x00000002, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Improved Spirit Tap (Rank 2)
( 15346, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   6,   0,   0), -- Seal of Reckoning
( 15362, 0x00,   6, 0x10001E00, 0x00010004, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Inspiration (Rank 2)
( 15363, 0x00,   6, 0x10001E00, 0x00010004, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Inspiration (Rank 3)
( 15600, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   1,   0,   0), -- Hand of Justice
( 16086, 0x04,  11, 0x00000000, 0x00040000, 0x00000000, 0x00030000, 0x00000000,   0,   0,   0), -- Improved Fire Nova Totem (Rank 1)
( 16544, 0x04,  11, 0x00000000, 0x00040000, 0x00000000, 0x00030000, 0x00000000,   0,   0,   0), -- Improved Fire Nova Totem (Rank 2)
( 16176, 0x00,  11, 0x000001C0, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ancestral Healing (Rank 1)
( 16180, 0x00,  11, 0x000001C0, 0x00000000, 0x00000010, 0x00000000, 0x00000002,   0, 100,   0), -- Improved Water Shield (Rank 1)
( 16196, 0x00,  11, 0x000001C0, 0x00000000, 0x00000010, 0x00000000, 0x00000002,   0, 100,   0), -- Improved Water Shield (Rank 2)
( 16198, 0x00,  11, 0x000001C0, 0x00000000, 0x00000010, 0x00000000, 0x00000002,   0, 100,   0), -- Improved Water Shield (Rank 3)
( 16235, 0x00,  11, 0x000001C0, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ancestral Healing (Rank 2)
( 16240, 0x00,  11, 0x000001C0, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Ancestral Healing (Rank 3)
( 16256, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 1)
( 16257, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 1)
( 16277, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 2)
( 16278, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 3)
( 16279, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 4)
( 16280, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Flurry (Rank 5)
( 16281, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 2)
( 16282, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 3)
( 16283, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 4)
( 16284, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Flurry (Rank 5)
( 16487, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blood Craze (Rank 1)
( 16489, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blood Craze (Rank 2)
( 16492, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blood Craze (Rank 3)
( 16550, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Bonespike (Rank 1)
( 16620, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Proc Self Invulnerability
( 16624, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Thorium Shield Spike
( 16850, 0x00,   7, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Celestial Focus (Rank 1)
( 16864, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   2,   0,   0), -- Omen of Clarity
( 16880, 0x48,   7, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Nature's Grace
( 16923, 0x00,   7, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Celestial Focus (Rank 2)
( 16924, 0x00,   7, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Celestial Focus (Rank 3)
( 16952, 0x00,   7, 0x00039000, 0x00000400, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blood Frenzy (Rank 1)
( 16954, 0x00,   7, 0x00039000, 0x00000400, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blood Frenzy (Rank 2)
( 16958, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Primal Fury (Rank 1)
( 16961, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Primal Fury (Rank 2)
( 17106, 0x00,   7, 0x00080000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Intensity (Rank 1)
( 17107, 0x00,   7, 0x00080000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Intensity (Rank 2)
( 17108, 0x00,   7, 0x00080000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Intensity (Rank 3)
( 17364, 0x08,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Stormstrike
( 17495, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Crest of Retribution
( 17619, 0x00,  13, 0x00000000, 0x00000000, 0x00000000, 0x00008000, 0x00000000,   0,   0,   0), -- Alchemist's Stone
( 17793, 0x00,   5, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Shadow Bolt (Rank 1)
( 17796, 0x00,   5, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Shadow Bolt (Rank 2)
( 17801, 0x00,   5, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Shadow Bolt (Rank 3)
( 17802, 0x00,   5, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Shadow Bolt (Rank 4)
( 17803, 0x00,   5, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Shadow Bolt (Rank 5)
( 18094, 0x00,   5, 0x0000000A, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Nightfall (Rank 1)
( 18095, 0x00,   5, 0x0000000A, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Nightfall (Rank 2)
( 18820, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Insight
( 19184, 0x00,   9, 0x00000010, 0x00002000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Entrapment (Rank 1)
( 19387, 0x00,   9, 0x00000010, 0x00002000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Entrapment (Rank 2)
( 19388, 0x00,   9, 0x00000010, 0x00002000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Entrapment (Rank 3)
( 19572, 0x00,   9, 0x00800000, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Improved Mend Pet (Rank 1)
( 19573, 0x00,   9, 0x00800000, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Improved Mend Pet (Rank 2)
( 20049, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Vengeance (Rank 1)
( 20056, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Vengeance (Rank 2)
( 20057, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Vengeance (Rank 3)
( 20128, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Redoubt
( 20131, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Redoubt
( 20132, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Redoubt
( 20164, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   5,   0,   0), -- Seal of Justice
( 20165, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  20,   0,   0), -- Seal of Light
( 20166, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  12,   0,   0), -- Seal of Wisdom
( 20177, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000043,   0,   0,   0), -- Reckoning (Rank 1)
( 20179, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000043,   0,   0,   0), -- Reckoning (Rank 2)
( 20180, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000043,   0,   0,   0), -- Reckoning (Rank 4)
( 20181, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000043,   0,   0,   0), -- Reckoning (Rank 3)
( 20182, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000043,   0,   0,   0), -- Reckoning (Rank 5)
( 20185, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  15,   0,   0), -- Judgement of Light
( 20186, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  15,   0,   0), -- Judgement of Wisdom
( 20210, 0x00,  10, 0xC0000000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Illumination (Rank 1)
( 20212, 0x00,  10, 0xC0000000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Illumination (Rank 2)
( 20213, 0x00,  10, 0xC0000000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Illumination (Rank 3)
( 20214, 0x00,  10, 0xC0000000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Illumination (Rank 4)
( 20215, 0x00,  10, 0xC0000000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Illumination (Rank 5)
( 20234, 0x00,  10, 0x00008000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Lay on Hands (Rank 1)
( 20235, 0x00,  10, 0x00008000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Lay on Hands (Rank 2)
( 20375, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   1), -- Seal of Command
( 20500, 0x00,   4, 0x10000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Berserker Rage (Rank 1)
( 20501, 0x00,   4, 0x10000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Berserker Rage (Rank 2)
( 20705, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Power Shield 500
( 20911, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Blessing of Sanctuary
( 20925, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield (Rank 1)
( 20927, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield (Rank 2)
( 20928, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield (Rank 3)
( 21084, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Seal of Righteousness
( 21185, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Spinal Reaper
( 21882, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Judgement Smite
( 21890, 0x00,   4, 0x2A764EEF, 0x0000036C, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Warrior's Wrath
( 22007, 0x00,   3, 0x00200021, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Netherwind Focus
( 22618, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Force Reactive Disk
( 22648, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Call of Eskhandar
( 23547, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000020,   0,   0,   0), -- Parry
( 23548, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Parry
( 23551, 0x00,  11, 0x000000C0, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Lightning Shield
( 23552, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield
( 23572, 0x00,  11, 0x000000C0, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Mana Surge
( 23578, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   2,   0,   0), -- Expose Weakness
( 23581, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   2,   0,   0), -- Bloodfang
( 23686, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   2,   0,   0), -- Lightning Strike
( 23688, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Aura of the Blue Dragon
( 23689, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   4,   0,   0), -- Heroism
( 23695, 0x00,   4, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Hamstring (Rank 3)
( 23721, 0x00,   9, 0x00000800, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Arcane Infused
( 23920, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000800,   0,   0,   0), -- Spell Reflection
( 24353, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Primal Instinct
( 24389, 0x00,   3, 0x00C00017, 0x00000040, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Chaos Fire
( 24398, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 7)
( 24658, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00014110, 0x00000000,   0,   0,   0), -- Unstable Power
( 24905, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,  15,   0,   0), -- Moonkin Form (Passive) (Passive)
( 24932, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   6), -- Leader of the Pack
( 25050, 0x04,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Mark of Flames
( 25469, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 8)
( 25472, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 9)
( 25669, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   1,   0,   0), -- Decapitate
( 25899, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Greater Blessing of Sanctuary
( 25988, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Eye for an Eye (Rank 2)
( 26016, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   2,   0,   0), -- Vindication (Rank 2)
( 26107, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000064,   0,   0,   0), -- Symbols of Unending Life Finisher Bonus
( 26119, 0x00,  10, 0x90100003, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Stormcaller Spelldamage Bonus
( 26128, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000008,   0,   0,   0), -- Enigma Resist Bonus
( 26135, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Battlegear of Eternal Justice
( 26480, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Badge of the Swarmguard
( 26605, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Bloodcrown
( 27131, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 7)
( 27179, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield (Rank 4)
( 27419, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Warrior's Resolve
( 27498, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Crusader's Wrath
( 27521, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,  15), -- Mana Restore
( 27656, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Flame Lash
( 27774, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- The Furious Storm
( 27787, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Rogue Armor Energize
( 27811, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blessed Recovery (Rank 1)
( 27815, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blessed Recovery (Rank 2)
( 27816, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blessed Recovery (Rank 3)
( 28592, 0x10,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Winter's Chill (Rank 2)
( 28593, 0x10,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Winter's Chill (Rank 3)
( 28716, 0x00,   7, 0x00000010, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Rejuvenation
( 28719, 0x00,   7, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Healing Touch
( 28744, 0x00,   7, 0x00000040, 0x00000000, 0x00000000, 0x00044000, 0x00000000,   0,   0,   0), -- Regrowth
( 28752, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Adrenaline Rush
( 28789, 0x00,  10, 0xC0000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Holy Power
( 28802, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Epiphany
( 28809, 0x00,   6, 0x00001000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Greater Heal
( 28812, 0x00,   8, 0x02000006, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Head Rush
( 28816, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Invigorate
( 28823, 0x00,  11, 0x000000C0, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Totemic Power
( 28847, 0x00,   7, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Healing Touch Refund
( 28849, 0x00,  11, 0x00000080, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Lesser Healing Wave
( 29074, 0x14,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Master of Elements (Rank 1)
( 29075, 0x14,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Master of Elements (Rank 2)
( 29076, 0x14,   3, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Master of Elements (Rank 3)
( 29150, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Electric Discharge
( 29179, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Elemental Devastation (Rank 2)
( 29180, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Elemental Devastation (Rank 3)
( 29385, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   7,   0,   0), -- Seal of Command
( 29441, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000008,   0,   0,   1), -- Magic Absorption (Rank 1)
( 29444, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000008,   0,   0,   1), -- Magic Absorption (Rank 2)
( 29455, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Felsteel Shield Spike
( 29501, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Frost Arrow
( 29593, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Improved Defensive Stance (Rank 1)
( 29594, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Improved Defensive Stance (Rank 2)
( 29624, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Searing Arrow
( 29625, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Flaming Cannonball
( 29626, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Shadow Bolt
( 29632, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Shadow Shot
( 29633, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Fire Blast
( 29634, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Quill Shot
( 29635, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Flaming Shell
( 29636, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Venom Shot
( 29637, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Keeper's Sting
( 29834, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Second Wind (Rank 1)
( 29838, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Second Wind (Rank 2)
( 29977, 0x00,   3, 0x00C00017, 0x00000040, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Combustion
( 30003, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000800,   0,   0,   0), -- Sheen of Zanza
( 30160, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Elemental Devastation (Rank 1)
( 30293, 0x00,   5, 0x00000381, 0x008200C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Soul Leech (Rank 1)
( 30295, 0x00,   5, 0x00000381, 0x008200C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Soul Leech (Rank 2)
( 30296, 0x00,   5, 0x00000381, 0x008200C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Soul Leech (Rank 3)
( 30299, 0x7E,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Nether Protection (Rank 1)
( 30301, 0x7E,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Nether Protection (Rank 2)
( 30302, 0x7E,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Nether Protection (Rank 3)
( 30675, 0x00,  11, 0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Lightning Overload (Rank 1)
( 30678, 0x00,  11, 0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Lightning Overload (Rank 2)
( 30679, 0x00,  11, 0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Lightning Overload (Rank 3)
( 30701, 0x1C,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Elemental Absorption (Rank 1)
( 30705, 0x1C,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Elemental Absorption (Rank 5)
( 30823, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 10.,   0,   0), -- Shamanistic Rage
( 30881, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Nature's Guardian (Rank 1)
( 30883, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Nature's Guardian (Rank 2)
( 30884, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Nature's Guardian (Rank 3)
( 30885, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Nature's Guardian (Rank 4)
( 30886, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Nature's Guardian (Rank 5)
( 30937, 0x20,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Mark of Shadow
( 31124, 0x00,   8, 0x01000006, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Blade Twisting (Rank 1)
( 31126, 0x00,   8, 0x01000006, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Blade Twisting (Rank 2)
( 31244, 0x00,   8, 0x003E0000, 0x00000009, 0x00000000, 0x00000000, 0x00000004,   0,   0,   0), -- Quick Recovery (Rank 1)
( 31245, 0x00,   8, 0x003E0000, 0x00000009, 0x00000000, 0x00000000, 0x00000004,   0,   0,   0), -- Quick Recovery (Rank 2)
( 31394, 0x20,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Mark of Shadow
( 31569, 0x00,   3, 0x00010000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Blink (Rank 1)
( 31570, 0x00,   3, 0x00010000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Blink (Rank 2)
( 31571, 0x00,   3, 0x00000000, 0x00000022, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Arcane Potency (Rank 1)
( 31572, 0x00,   3, 0x00000000, 0x00000022, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Arcane Potency (Rank 2)
( 31656, 0x04,   3, 0x8000000,  0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Empowered Fire (Rank 1)
( 31657, 0x04,   3, 0x8000000,  0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Empowered Fire (Rank 2)
( 31658, 0x04,   3, 0x8000000,  0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Empowered Fire (Rank 3)
( 31794, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Focused Mind
( 31801, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Seal of Vengeance
( 31833, 0x00,  10, 0x80000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Light's Grace (Rank 1)
( 31835, 0x00,  10, 0x80000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Light's Grace (Rank 2)
( 31836, 0x00,  10, 0x80000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Light's Grace (Rank 3)
( 31871, 0x00,  10, 0x00000010, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Divine Purpose (Rank 1)
( 31872, 0x00,  10, 0x00000010, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Divine Purpose (Rank 2)
( 53530,    1,  10, 0x00000000, 0x00000000,     0x0004,     0x0400,     0x0001,   0, 100,   0), -- Divine Guardian
( 31876, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Wise (Rank 1)
( 31877, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Wise (Rank 2)
( 31878, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Wise (Rank 3)
( 31904, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield
( 32385, 0x00,   5, 0x00000001, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shadow Embrace (Rank 1)
( 32387, 0x00,   5, 0x00000001, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shadow Embrace (Rank 2)
( 32392, 0x00,   5, 0x00000001, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shadow Embrace (Rank 3)
( 32393, 0x00,   5, 0x00000001, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shadow Embrace (Rank 4)
( 32394, 0x00,   5, 0x00000001, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shadow Embrace (Rank 5)
( 32409, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shadow Word: Death
( 32587, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Shield Block
( 32593, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000222A8, 0x00000000,   0,   0,   3), -- Earth Shield (Rank 2)
( 32594, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000222A8, 0x00000000,   0,   0,   3), -- Earth Shield (Rank 3)
( 32642, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Spore Cloud
( 32734, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Earth Shield
( 32748, 0x00,   8, 0x00000000, 0x00000001, 0x00000000, 0x00000140, 0x00000000,   0,   0,   0), -- Deadly Throw Interrupt (Rank 5)
( 32776, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Redoubt
( 32777, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield
( 32837, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,  45), -- Spell Focus Trigger
( 32844, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   2,   0,   0), -- Lesser Heroism
( 32885, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Infuriate
( 33076, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000A22A8, 0x00000000,   0,   0,   0), -- Prayer of Mending (Rank 1)
( 33089, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Vigilance of the Colossus
( 33127, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   7,   0,   0), -- Seal of Command
( 33142, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blessed Resilience (Rank 1)
( 33145, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blessed Resilience (Rank 2)
( 33146, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Blessed Resilience (Rank 3)
( 33150, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Surge of Light (Rank 1)
( 33151, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Surge of Light (Rank 1)
( 33154, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Surge of Light (Rank 2)
( 33191, 0x00,   6, 0x00808000, 0x00000400, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Misery (Rank 1)
( 33192, 0x00,   6, 0x00808000, 0x00000400, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Misery (Rank 2)
( 33193, 0x00,   6, 0x00808000, 0x00000400, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Misery (Rank 3)
( 33297, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Spell Haste Trinket
( 33299, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Coilfang Slave Pens Lvl 70 Boss3a Caster Trinket
( 33510, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   5,   0,   0), -- Health Restore
( 33648, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Reflection of Torment
( 33719, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000800,   0,   0,   0), -- Perfect Spell Reflection
( 33736, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 8)
( 33746, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Essence Infused Mushroom
( 33757, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0, 100,   3), -- Windfury Weapon (Passive) (Rank 1)
( 33759, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Power Infused Mushroom
( 33881, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Natural Perfection (Rank 1)
( 33882, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Natural Perfection (Rank 2)
( 33883, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Natural Perfection (Rank 3)
( 33953, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00044000, 0x00000000,   0,   0,  45), -- Essence of Life
( 34074, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000003,   0,   0,   0), -- Aspect of the Viper
( 34080, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000008,   0,   0,   0), -- Riposte Stance
( 34138, 0x00,  11, 0x00000080, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Totem of the Third Wind
( 34139, 0x00,  10, 0x40000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Libram of Justice
( 34258, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Justice
( 34262, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Mercy
( 34320, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Call of the Nexus
( 34355, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Poison Shield
( 34497, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Thrill of the Hunt (Rank 1)
( 34498, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Thrill of the Hunt (Rank 2)
( 34499, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Thrill of the Hunt (Rank 3)
( 34500, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Expose Weakness (Rank 1)
( 34502, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Expose Weakness (Rank 2)
( 34503, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Expose Weakness (Rank 3)
( 34584, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Love Struck
( 34586, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 1.5,   0,   0), -- Romulo's Poison
( 34598, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Karazhan Caster Robe
( 34749, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000008,   0,   0,   0), -- Recurring Power
( 34753, 0x00,   6, 0x00001800, 0x00000004, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Holy Concentration (Rank 1)
( 34774, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 1.5,   0,  20), -- Magtheridon Melee Trinket
( 34783, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000800,   0,   0,   0), -- Spell Reflection
( 34827, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield
( 34859, 0x00,   6, 0x00001800, 0x00000004, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Holy Concentration (Rank 2)
( 34860, 0x00,   6, 0x00001800, 0x00000004, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Holy Concentration (Rank 3)
( 34914, 0x00,   6, 0x00002000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vampiric Touch (Rank 1)
( 34916, 0x00,   6, 0x00002000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vampiric Touch (Rank 2)
( 34917, 0x00,   6, 0x00002000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vampiric Touch (Rank 3)
( 34935, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   8), -- Backlash (Rank 1)
( 34938, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   8), -- Backlash (Rank 2)
( 34939, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   8), -- Backlash (Rank 3)
( 34950, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Go for the Throat (Rank 1)
( 34954, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Go for the Throat (Rank 2)
( 35077, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Band of the Eternal Defender
( 35080, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   1,   0,  60), -- Band of the Eternal Champion
( 35083, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Band of the Eternal Sage
( 35086, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Band of the Eternal Restorer
( 35121, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Nether Power
( 35541, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00800000, 0x00000000,   0,   0,   0), -- Combat Potency (Rank 1)
( 35550, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00800000, 0x00000000,   0,   0,   0), -- Combat Potency (Rank 2)
( 35551, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00800000, 0x00000000,   0,   0,   0), -- Combat Potency (Rank 3)
( 35552, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00800000, 0x00000000,   0,   0,   0), -- Combat Potency (Rank 4)
( 35553, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00800000, 0x00000000,   0,   0,   0), -- Combat Potency (Rank 5)
( 36032, 0x00,   3, 0x00001000, 0x00008000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Arcane Blast
( 36096, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000800,   0,   0,   0), -- Spell Reflection
( 36111, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- World Breaker
( 36541, 0x04,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Curse of Burning Shadows
( 37165, 0x00,   8, 0x00200400, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Haste
( 37168, 0x00,   8, 0x003E0000, 0x00000009, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Finisher Combo
( 37170, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   1,   0,   0), -- Free Finisher Chance
( 37173, 0x00,   8, 0x2CBC0598, 0x00000106, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Armor Penetration
( 37189, 0x00,  10, 0xC0000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  60), -- Recuced Holy Light Cast Time
( 37193, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Infused Shield
( 37195, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgement Group Heal
( 37197, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,  45), -- Spell Damage
( 37213, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Mana Cost Reduction
( 37214, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Energized
( 37227, 0x00,  11, 0x000001C0, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  60), -- Improved Healing Wave
( 37237, 0x00,  11, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Lightning Bolt Discount
( 37247, 0x08,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,  45), -- Regain Mana
( 37377, 0x20,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Shadowflame
( 37379, 0x20,   5, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Flameshadow
( 37384, 0x00,   5, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Corruption and Immolate
( 37443, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Crit Bonus Damage
( 37514, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000020,   0,   0,   0), -- Blade Turning
( 37516, 0x00,   4, 0x00000400, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Revenge Bonus
( 37519, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000030,   0,   0,   0), -- Rage Bonus
( 37523, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Reinforced Shield
( 37528, 0x00,   4, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Overpower Bonus
( 37536, 0x00,   4, 0x00010000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Battle Shout
( 37568, 0x00,   6, 0x00000800, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Greater Heal Discount
( 37594, 0x00,   6, 0x00001000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Greater Heal Refund
( 37600, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Offensive Discount
( 37601, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Relentlessness
( 37603, 0x00,   6, 0x00008000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shadow Word Pain Damage
( 37655, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Bonus Mana Regen
( 37657, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   3), -- Lightning Capacitor
( 38026, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000100,   0,   0,   0), -- Viscous Shield
( 38031, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Shield Block
( 38290, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 1.6,   0,   0), -- Santos' Blessing
( 38299, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  15), -- HoTs on Heals
( 38326, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Crit Threat Reduction Melee
( 38327, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Crit Threat Reduction Spell
( 38334, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Proc Mana Regen
( 38347, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Crit Proc Spell Damage
( 38350, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Crit Proc Heal
( 38394, 0x00,   5, 0x00000006, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Dot Heals
( 38857, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Spell Ground
( 39027, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Poison Shield
( 39372, 0x30,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Frozen Shadoweave
( 39437, 0x04,   5, 0x00001364, 0x000000C0, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Shadowflame Hellfire and RoF
( 39442, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000001,   0,   0,   0), -- Aura of Wrath
( 39443, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Aura of Wrath
( 39530, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Focus
( 39958, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0.7,   0,  40), -- Skyfire Swiftness
( 40407, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   6,   0,   0), -- Illidan Tank Shield
( 40438, 0x00,   6, 0x00008040, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Priest Tier 6 Trinket
( 40442, 0x00,   7, 0x00000014, 0x00000440, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Druid Tier 6 Trinket
( 40444, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Black Temple Tank Trinket
( 40458, 0x00,   4, 0x02000000, 0x00000601, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Warrior Tier 6 Trinket
( 40463, 0x00,  11, 0x00000081, 0x00000010, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shaman Tier 6 Trinket
( 40470, 0x00,  10, 0xC0800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Paladin Tier 6 Trinket
( 40475, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Black Temple Melee Trinket
( 40478, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Warlock Tier 6 Trinket
( 40482, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Mage Tier 6 Trinket
( 40485, 0x00,   9, 0x00000000, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Hunter Tier 6 Trinket
( 40899, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Felfire Proc
( 41034, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Spell Absorption
( 41260, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Aviana's Purpose
( 41262, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Aviana's Will
( 41381, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000100,   0,   0,   0), -- Shell of Life
( 41393, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000020,   0,   0,   0), -- Riposte
( 41434, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   2,   0,  45), -- The Twin Blades of Azzinoth
( 41469, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   7,   0,   0), -- Seal of Command
( 41635, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000A22A8, 0x00000000,   0,   0,   0), -- Prayer of Mending (Rank 1)
( 41989, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0.5,   0,   0), -- Fists of Fury
( 42083, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Fury of the Crashing Waves
( 42135, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  90), -- Lesser Rune of Warding
( 42136, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  90), -- Greater Rune of Warding
( 42368, 0x00,  10, 0x40000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Merciless Libram of Justice
( 42370, 0x00,  11, 0x00000080, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Merciless Totem of the Third WInd
( 42770, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Second Wind (Rank 2)
( 43019, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 8)
( 43020, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000400,   0,   0,   0), -- Mana Shield (Rank 9)
( 43338, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Shamanistic Focus
( 43443, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000800,   0,   0,   0), -- Spell Reflection
( 43726, 0x00,  10, 0x40000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vengeful Libram of Justice
( 43728, 0x00,  11, 0x00000080, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vengeful Totem of Third WInd
( 43737, 0x00,   7, 0x00000000, 0x00000440, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Primal Instinct
( 43739, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Lunar Grace
( 43741, 0x00,  10, 0x80000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Light's Grace
( 43745, 0x00,  10, 0x00000000, 0x00000200, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Crusader's Command
( 43748, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Elemental Strength
( 43750, 0x00,  11, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Energized
( 43819, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Lucidity
( 44404, 0x00,   3, 0x20000021, 0x00009000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Missile Barrage (Rank 1)
( 44442, 0x00,   3, 0x00800000, 0x00000040, 0x00000000, 0x00000000, 0x00010000,   0,   0,   1), -- Firestarter (Rank 1)
( 44443, 0x00,   3, 0x00800000, 0x00000040, 0x00000000, 0x00000000, 0x00010000,   0,   0,   1), -- Firestarter (Rank 2)
( 44445, 0x00,   3, 0x00000013, 0x00001000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Hot Streak (Rank 1)
( 44446, 0x00,   3, 0x00000013, 0x00001000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Hot Streak (Rank 2)
( 44448, 0x00,   3, 0x00000013, 0x00001000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Hot Streak (Rank 3)
( 44449, 0x00,   3, 0x20E21277, 0x00019048, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Burnout (Rank 1)
( 44469, 0x00,   3, 0x20E21277, 0x00019048, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Burnout (Rank 2)
( 44470, 0x00,   3, 0x20E21277, 0x00019048, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Burnout (Rank 3)
( 44471, 0x00,   3, 0x20E21277, 0x00019048, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Burnout (Rank 4)
( 44472, 0x00,   3, 0x20E21277, 0x00019048, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Burnout (Rank 5)
( 44543, 0x00,   3, 0x00100220, 0x00001000, 0x00000000, 0x00010000, 0x00000000,   0,   7,   0), -- Fingers of Frost (Rank 1)
( 44545, 0x00,   3, 0x00100220, 0x00001000, 0x00000000, 0x00010000, 0x00000000,   0,  15,   0), -- Fingers of Frost (Rank 2)
( 44546, 0x00,   3, 0x00100220, 0x00001000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Brain Freeze (Rank 1)
( 44548, 0x00,   3, 0x00100220, 0x00001000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Brain Freeze (Rank 2)
( 44549, 0x00,   3, 0x00100220, 0x00001000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Brain Freeze (Rank 3)
( 44557, 0x00,   3, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Enduring Winter (Rank 1)
( 44560, 0x00,   3, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Enduring Winter (Rank 2)
( 44561, 0x00,   3, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Enduring Winter (Rank 3)
( 44835, 0x00,   7, 0x00000000, 0x00000080, 0x00000000, 0x00000010, 0x00000000,   0,   0,   0), -- Maim Interrupt
( 45054, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  15), -- Augment Pain
( 45057, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Evasive Maneuvers
( 45234, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Focused Will (Rank 1)
( 45243, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Focused Will (Rank 2)
( 45244, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Focused Will (Rank 3)
( 45354, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Item - Sunwell Dungeon Melee Trinket
( 45469, 0x00,  15, 0x00000010, 0x00000000, 0x00000000, 0x00000010, 0x00000000,   0,   0,   0), -- Death Strike
( 45481, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Sunwell Exalted Caster Neck
( 45482, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Sunwell Exalted Melee Neck
( 45483, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Sunwell Exalted Tank Neck
( 45484, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,  45), -- Sunwell Exalted Healer Neck
( 46025, 0x20,   6, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Blackout (Rank 5)
( 46092, 0x00,  10, 0x40000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Brutal Libram of Justice
( 46098, 0x00,  11, 0x00000080, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Brutal Totem of Third WInd
( 46569, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Sunwell Exalted Caster Neck
( 46662, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  20), -- Deathfrost
( 46832, 0x00,   7, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Moonkin Starfire Bonus
( 46854, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Trauma (Rank 1)
( 46855, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Trauma (Rank 2)
( 46867, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Wrecking Crew (Rank 1)
( 46910, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 5.5,   0,   0), -- Furious Attacks (Rank 1)
( 46911, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 7.5,   0,   0), -- Furious Attacks (Rank 2)
( 46913, 0x00,   4, 0x00000040, 0x00000404, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Bloodsurge (Rank 1)
( 46914, 0x00,   4, 0x00000040, 0x00000404, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Bloodsurge (Rank 2)
( 46915, 0x00,   4, 0x00000040, 0x00000404, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Bloodsurge (Rank 3)
( 46916, 0x00,   4, 0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Slam!
( 46951, 0x00,   4, 0x00000400, 0x00000040, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sword and Board (Rank 1)
( 46952, 0x00,   0, 0x00000400, 0x00000040, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sword and Board (Rank 2)
( 46953, 0x00,   0, 0x00000400, 0x00000040, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sword and Board (Rank 3)
( 47195, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Eradication (Rank 1)
( 47196, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Eradication (Rank 2)
( 47197, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Eradication (Rank 3)
( 47201, 0x00,   5, 0x00004009, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Everlasting Affliction (1)
( 47202, 0x00,   5, 0x00004009, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Everlasting Affliction (2)
( 47203, 0x00,   5, 0x00004009, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Everlasting Affliction (3)
( 47204, 0x00,   5, 0x00004009, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Everlasting Affliction (4)
( 47205, 0x00,   5, 0x00004009, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Everlasting Affliction (5)
( 47245, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000001,   0,   0,   0), -- Molten Core (Rank 1)
( 47246, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000001,   0,   0,   0), -- Molten Core (Rank 2)
( 47247, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000001,   0,   0,   0), -- Molten Core (Rank 3)
( 47258, 0x00,   5, 0x00000000, 0x00800000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Backdraft (Rank 1)
( 47259, 0x00,   5, 0x00000000, 0x00800000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Backdraft (Rank 2)
( 47260, 0x00,   5, 0x00000000, 0x00800000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Backdraft (Rank 3)
( 47263, 0x20,   5, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  20), -- Torture (Rank 1)
( 47264, 0x20,   5, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  20), -- Torture (Rank 2)
( 47265, 0x20,   5, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  20), -- Torture (Rank 3)
( 47509, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Divine Aegis (Rank 1)
( 47511, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Divine Aegis (Rank 2)
( 47515, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Divine Aegis (Rank 3)
( 47516, 0x00,   6, 0x00001800, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Grace (Rank 1)
( 47517, 0x00,   6, 0x00001800, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Grace (Rank 2)
( 47569, 0x00,   6, 0x00004000, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Improved Shadowform (Rank 1)
( 47570, 0x00,   6, 0x00004000, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Improved Shadowform (Rank 2)
( 47580, 0x00,   6, 0x00000000, 0x00000000, 0x00000040, 0x00000000, 0x00010000,   0,   0,   0), -- Pain and Suffering (Rank 1)
( 47581, 0x00,   6, 0x00000000, 0x00000000, 0x00000040, 0x00000000, 0x00010000,   0,   0,   0), -- Pain and Suffering (Rank 2)
( 47582, 0x00,   6, 0x00000000, 0x00000000, 0x00000040, 0x00000000, 0x00010000,   0,   0,   0), -- Pain and Suffering (Rank 3)
( 48110, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000A22A8, 0x00000000,   0,   0,   0), -- Prayer of Mending (Rank 2)
( 48111, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000A22A8, 0x00000000,   0,   0,   0), -- Prayer of Mending (Rank 3)
( 48112, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000A22A8, 0x00000000,   0,   0,   0), -- Prayer of Mending (Rank 2)
( 48113, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000A22A8, 0x00000000,   0,   0,   0), -- Prayer of Mending (Rank 3)
( 48159, 0x00,   6, 0x00002000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vampiric Touch (Rank 4)
( 48160, 0x00,   6, 0x00002000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Vampiric Touch (Rank 5)
( 48483, 0x00,   7, 0x00008800, 0x00000440, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Infected Wounds (Rank 1)
( 48484, 0x00,   7, 0x00008800, 0x00000440, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Infected Wounds (Rank 2)
( 48485, 0x00,   7, 0x00008800, 0x00000440, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Infected Wounds (Rank 3)
( 48492, 0x00,   7, 0x00080000, 0x00000000, 0x00000800, 0x00000400, 0x00000000,   0,   0,   0), -- King of the Jungle (Rank1)
( 48494, 0x00,   7, 0x00080000, 0x00000000, 0x00000800, 0x00000400, 0x00000000,   0,   0,   0), -- King of the Jungle (Rank2)
( 48495, 0x00,   7, 0x00080000, 0x00000000, 0x00000800, 0x00000400, 0x00000000,   0,   0,   0), -- King of the Jungle (Rank3)
( 48496, 0x00,   7, 0x00000060, 0x02000002, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Living Seed (Rank 1)
( 48499, 0x00,   7, 0x00000060, 0x02000002, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Living Seed (Rank 2)
( 48500, 0x00,   7, 0x00000060, 0x02000002, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Living Seed (Rank 3)
( 48506, 0x00,   7, 0x00000005, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Earth and Moon (Rank 1)
( 48510, 0x00,   7, 0x00000005, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Earth and Moon (Rank 2)
( 48511, 0x00,   7, 0x00000005, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Earth and Moon (Rank 3)
( 48516, 0x00,   7, 0x00000005, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  30), -- Eclipse (Rank 1)
( 48521, 0x00,   7, 0x00000005, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  30), -- Eclipse (Rank 2)
( 48525, 0x00,   7, 0x00000005, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  30), -- Eclipse (Rank 3)
( 48833, 0x00,   7, 0x00000000, 0x00000440, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Primal Instinct
( 48835, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Justice
( 48837, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Elemental Tenacity
( 48951, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield (Rank 5)
( 48952, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Holy Shield (Rank 6)
( 48988, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Bloody Vengeance (Rank 1)
( 49018, 0x00,  15, 0x01400000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sudden Doom (Rank 1)
( 49194, 0x00,  15, 0x00002000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Unholy Blight
( 49027, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   3,  20), -- Bloodworms (Rank 1)
( 49542, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   6,  20), -- Bloodworms (Rank 2) 
( 49543, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   9,  20), -- Bloodworms (Rank 3)
( 49208, 0x00,  15, 0x00400000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Reaping (Rank 1)
( 49219, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Blood-Caked Blade (Rank 1)
( 49222, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000222A8, 0x00000000,   0,   0,   3), -- Bone Shield
( 49280, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 10)
( 49281, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Lightning Shield (Rank 11)
( 49283, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000222A8, 0x00000000,   0,   0,   3), -- Earth Shield (Rank 4)
( 49284, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000222A8, 0x00000000,   0,   0,   3), -- Earth Shield (Rank 5)
( 49503, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Bloody Vengeance (Rank 2)
( 49504, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Bloody Vengeance (Rank 3)
( 49529, 0x00,  15, 0x01400000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sudden Doom (Rank 2)
( 49530, 0x00,  15, 0x01400000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sudden Doom (Rank 3)
( 49622, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Bonus Mana Regen
( 49627, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Blood-Caked Blade (Rank 2)
( 49628, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Blood-Caked Blade (Rank 3)
( 50781, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   6), -- Fate Rune of Primal Energy
( 50880, 0x00,  15, 0x00000000, 0x04000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Icy Talons
( 50884, 0x00,  15, 0x00000000, 0x04000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Icy Talons
( 50885, 0x00,  15, 0x00000000, 0x04000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Icy Talons
( 50886, 0x00,  15, 0x00000000, 0x04000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Icy Talons
( 50887, 0x00,  15, 0x00000000, 0x04000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Icy Talons
( 51123, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Killing Machine (Rank 1)
( 51127, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Killing Machine (Rank 2)
( 51128, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Killing Machine (Rank 3)
( 51129, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Killing Machine (Rank 4)
( 51130, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Killing Machine (Rank 5)
( 51346, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Venture Company Beatdown!
( 51349, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Venture Company Beatdown
( 51352, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Venture Company Beatdown!
( 51359, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Venture Company Beatdown
( 51414, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Venomous Breath Aura
( 51459, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Necrosis (Rank 1)
( 51462, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Necrosis (Rank 2)
( 51463, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Necrosis (Rank 3)
( 51464, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Necrosis (Rank 4)
( 51465, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000,   0,   0,   0), -- Necrosis (Rank 5)
( 51474, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Astral Shift (Rank 1)
( 51478, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Astral Shift (Rank 2)
( 51479, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Astral Shift (Rank 3)
( 51483, 0x01,  11, 0x20000000, 0x00000000, 0x00000000, 0x00004000, 0x00000001,   0,   0,   0), -- Storm, Earth and Fire
( 51485, 0x01,  11, 0x20000000, 0x00000000, 0x00000000, 0x00004000, 0x00000001,   0,   0,   0), -- Storm, Earth and Fire
( 51486, 0x01,  11, 0x20000000, 0x00000000, 0x00000000, 0x00004000, 0x00000001,   0,   0,   0), -- Storm, Earth and Fire
( 51521, 0x00,  11, 0x00000000, 0x01000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Stormstrike
( 51522, 0x00,  11, 0x00000000, 0x01000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Stormstrike
( 51523, 0x00,  11, 0x00000000, 0x00000001, 0x00000000, 0x00010000, 0x00000000,   0,  50,   0), -- Earthen Power (Rank 1)
( 51524, 0x00,  11, 0x00000000, 0x00000001, 0x00000000, 0x00010000, 0x00000000,   0,  50,   0), -- Earthen Power (Rank 2)
( 51528, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 2.5,   0,   0), -- Maelstrom Weapon (Rank 1)
( 51529, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   5,   0,   0), -- Maelstrom Weapon (Rank 2)
( 51530, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 7.5,   0,   0), -- Maelstrom Weapon (Rank 3)
( 51531, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  10,   0,   0), -- Maelstrom Weapon (Rank 4)
( 51532, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 12.,   0,   0), -- Maelstrom Weapon (Rank 5)
( 51556, 0x00,  11, 0x000000C0, 0x00000000, 0x00000010, 0x00000000, 0x00000002,   0,   0,   0), -- Ancestral Awakening (Rank 1)
( 51557, 0x00,  11, 0x000000C0, 0x00000000, 0x00000010, 0x00000000, 0x00000002,   0,   0,   0), -- Ancestral Awakening (Rank 2)
( 51558, 0x00,  11, 0x000000C0, 0x00000000, 0x00000010, 0x00000000, 0x00000002,   0,   0,   0), -- Ancestral Awakening (Rank 3)
( 51562, 0x00,  11, 0x00000100, 0x00000000, 0x00000010, 0x00000000, 0x00000000,   0,   0,   0), -- Tidal Waves (Rank 1)
( 51563, 0x00,  11, 0x00000100, 0x00000000, 0x00000010, 0x00000000, 0x00000000,   0,   0,   0), -- Tidal Waves (Rank 2)
( 51564, 0x00,  11, 0x00000100, 0x00000000, 0x00000010, 0x00000000, 0x00000000,   0,   0,   0), -- Tidal Waves (Rank 3)
( 51565, 0x00,  11, 0x00000100, 0x00000000, 0x00000010, 0x00000000, 0x00000000,   0,   0,   0), -- Tidal Waves (Rank 4)
( 51566, 0x00,  11, 0x00000100, 0x00000000, 0x00000010, 0x00000000, 0x00000000,   0,   0,   0), -- Tidal Waves (Rank 5)
( 51625, 0x00,   8, 0x1000A000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Deadly Brew (Rank 1)
( 51626, 0x00,   8, 0x1000A000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Deadly Brew (Rank 2)
( 51627, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Turn the Tables (Rank 1)
( 51628, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Turn the Tables (Rank 2)
( 51629, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000070,   0,   0,   0), -- Turn the Tables (Rank 3)
( 51634, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Focused Attacks (Rank 1)
( 51635, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Focused Attacks (Rank 2)
( 51636, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Focused Attacks (Rank 3)
( 51664, 0x00,   8, 0x00020000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Cut to the Chase (Rank 1)
( 51665, 0x00,   8, 0x00020000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Cut to the Chase (Rank 2)
( 51667, 0x00,   8, 0x00020000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Cut to the Chase (Rank 3)
( 51668, 0x00,   8, 0x00020000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Cut to the Chase (Rank 4)
( 51669, 0x00,   8, 0x00020000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Cut to the Chase (Rank 5)
( 51672, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000010,   0,   0,   1), -- Unfair Advantage (Rank 1)
( 51674, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000010,   0,   0,   1), -- Unfair Advantage (Rank 2)
( 51679, 0x00,   8, 0x00000001, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Throwing Specialization (Rank 2)
( 51692, 0x00,   8, 0x00000204, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Waylay (Rank 1)
( 51696, 0x00,   8, 0x00000204, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Waylay (Rank 2)
( 51698, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Honor Among Thieves (Rank 1)
( 51700, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Honor Among Thieves (Rank 2)
( 51701, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   1), -- Honor Among Thieves (Rank 3)
( 51915, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x01000000, 0x00000000,   0, 100, 600), -- Undying Resolve
( 51940, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  20,   0), -- Earthliving Weapon (Passive) (Rank 1)
( 51989, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  20,   0), -- Earthliving Weapon (Passive) (Rank 2)
( 52004, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  20,   0), -- Earthliving Weapon (Passive) (Rank 3)
( 52005, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  20,   0), -- Earthliving Weapon (Passive) (Rank 4)
( 52007, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  20,   0), -- Earthliving Weapon (Passive) (Rank 5)
( 52008, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  20,   0), -- Earthliving Weapon (Passive) (Rank 6)
( 52020, 0x00,   7, 0x00008000, 0x00100000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Snap and Snarl
( 52127, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 1)
( 52129, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 2)
( 52131, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 3)
( 52134, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 4)
( 52136, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 5)
( 52138, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 6)
( 52420, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Deflection
( 52423, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000020,   0,   0,   0), -- Retaliation
( 52795, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Borrowed Time (Rank 1)
( 52797, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Borrowed Time (Rank 2)
( 52798, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Borrowed Time (Rank 3)
( 52799, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Borrowed Time (Rank 4)
( 52800, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Borrowed Time (Rank 5)
( 52898, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Spell Damping
( 53215, 0x00,   9, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Wild Quiver (Rank 1)
( 53216, 0x00,   9, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Wild Quiver (Rank 2)
( 53217, 0x00,   9, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Wild Quiver (Rank 3)
( 53221, 0x00,   9, 0x00000000, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Steady Shot (Rank 1)
( 53222, 0x00,   9, 0x00000000, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Steady Shot (Rank 2)
( 53224, 0x00,   9, 0x00000000, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Improved Steady Shot (Rank 3)
( 53228, 0x00,   9, 0x00000020, 0x01000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Rapid Recuperation (Rank 1)
( 53232, 0x00,   9, 0x00000020, 0x01000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Rapid Recuperation (Rank 2)
( 53256, 0x00,   9, 0x00000800, 0x00800001, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Cobra Strikes (Rank 1)
( 53259, 0x00,   9, 0x00000800, 0x00800001, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Cobra Strikes (Rank 2)
( 53260, 0x00,   9, 0x00000800, 0x00800001, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Cobra Strikes (Rank 3)
( 53290, 0x00,   9, 0x00000800, 0x00000001, 0x00000200, 0x00000000, 0x00000002,   0,   0,   0), -- Hunting Party (Rank 1)
( 53291, 0x00,   9, 0x00000800, 0x00000001, 0x00000200, 0x00000000, 0x00000002,   0,   0,   0), -- Hunting Party (Rank 2)
( 53292, 0x00,   9, 0x00000800, 0x00000001, 0x00000200, 0x00000000, 0x00000002,   0,   0,   0), -- Hunting Party (Rank 3)
( 53375, 0x00,  10, 0x00000000, 0x00002000, 0x00000000, 0x00000400, 0x00000000,   0,   0,   6), -- Sanctified Wrath (Rank 1)
( 53376, 0x00,  10, 0x00000000, 0x00002000, 0x00000000, 0x00000400, 0x00000000,   0,   0,   6), -- Sanctified Wrath (Rank 2)
( 53380, 0x00,  10, 0x00800000, 0x00020000, 0x00000000, 0x00000000, 0x00040002,   0,   0,   0), -- Righteous Vengeance (Rank 1)
( 53381, 0x00,  10, 0x00800000, 0x00020000, 0x00000000, 0x00000000, 0x00040002,   0,   0,   0), -- Righteous Vengeance (Rank 2)
( 53382, 0x00,  10, 0x00800000, 0x00020000, 0x00000000, 0x00000000, 0x00040002,   0,   0,   0), -- Righteous Vengeance (Rank 3)
( 53397, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Invigoration (Rank 1)
( 53486, 0x00,  10, 0x00800000, 0x00028000, 0x00000000, 0x00000000, 0x00040002,   0,   0,   0), -- The Art of War (Rank 1)
( 53488, 0x00,  10, 0x00800000, 0x00028000, 0x00000000, 0x00000000, 0x00040002,   0,   0,   0), -- The Art of War (Rank 2)
( 53501, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Sheath of Light (Rank 1)
( 53502, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Sheath of Light (Rank 2)
( 53503, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Sheath of Light (Rank 3)
( 53551, 0x00,  10, 0x00001000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sacred Cleansing (Rank 1)
( 53552, 0x00,  10, 0x00001000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sacred Cleansing (Rank 2)
( 53553, 0x00,  10, 0x00001000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sacred Cleansing (Rank 3)
( 53569, 0x00,  10, 0x40200000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Infusion of Light (Rank 1)
( 53576, 0x00,  10, 0x40200000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Infusion of Light (Rank 2)
( 53646, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Demonic Pact (Rank 1)
( 53671, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Pure (Rank 1)
( 53672, 0x00,  10, 0x00200000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Infusion of Light
( 53673, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Pure (Rank 2)
( 53709, 0x02,  10, 0x00004000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shield of the templar
( 53710, 0x02,  10, 0x00004000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shield of the templar
( 53711, 0x02,  10, 0x00004000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Shield of the templar
( 54149, 0x00,  10, 0x00200000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Infusion of Light (Rank 2)
( 54151, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Pure (Rank 3)
( 54154, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Pure (Rank 4)
( 54155, 0x00,  10, 0x00800000, 0x00000000, 0x00000000, 0x00000000, 0x00040000,   0,   0,   0), -- Judgements of the Pure (Rank 5)
( 54278, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Empowered Imp
( 54486, 0x00,   0, 0x20000021, 0x00009000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Missile Barrage (Rank 2)
( 54488, 0x00,   0, 0x20000021, 0x00009000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Missile Barrage (Rank 3)
( 54489, 0x00,   0, 0x20000021, 0x00009000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Missile Barrage (Rank 4)
( 54490, 0x00,   0, 0x20000021, 0x00009000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Missile Barrage (Rank 5)
( 54695, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Item - Death Knight's Anguish Base
( 54707, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Sonic Awareness (DND)
( 54738, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Star of Light
( 54747, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Burning Determination (Rank 1)
( 54749, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Burning Determination (Rank 2)
( 54754, 0x00,   7, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Rejuvenation
( 54808, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Sonic Shield
( 54838, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Purified Spirit
( 54841, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   3), -- Thunder Capacitor
( 54936, 0x00,  10, 0x40000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Flash of Light
( 54937, 0x00,  10, 0x80000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Holy Light
( 54939, 0x00,  10, 0x00008000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Divinity
( 55198, 0x00,  11, 0x000001C0, 0x00000000, 0x00000000, 0x00004000, 0x00000002,   0,   0,   0), -- Tidal Force
( 55380, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Skyflare Swiftness
( 55381, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,  15), -- Mana Restore
( 55440, 0x00,  11, 0x00000040, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Healing Wave
( 55610, 0x00,  15, 0x00000000, 0x04000000, 0x00000000, 0x00001000, 0x00000000,   0,   0,   0), -- Improved Icy Talons
( 55640, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Lightweave Embroidery
( 55677, 0x00,   6, 0x00000000, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Dispel Magic
( 55680, 0x00,   6, 0x00000200, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Prayer of Healing
( 55689, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Glyph of Shadow
( 55747, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Argent Fury
( 55768, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Darkglow Embroidery
( 55776, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Swordguard Embroidery
( 56218, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Corruption
( 56249, 0x00,   5, 0x00000000, 0x00000000, 0x00000400, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Felhunter
( 56355, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000040,   0,   0,   0), -- Titanium Shield Spike
( 56364, 0x00,   3, 0x00000000, 0x01000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Remove Curse
( 56372, 0x00,   3, 0x00000000, 0x00000080, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Glyph of Ice Block
( 56374, 0x00,   3, 0x00000000, 0x00004000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Glyph of Icy Veins
( 56451, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Earth Shield
( 56611, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Wrecking Crew (Rank 2)
( 56612, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Wrecking Crew (Rank 3)
( 56613, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Wrecking Crew (Rank 4)
( 56614, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Wrecking Crew (Rank 5)
( 56816, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000030,   0,   0,   0), -- Rune Strike
( 56821, 0x00,   8, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Glyph of Sinister Strike
( 56834, 0x00,  15, 0x00400000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Reaping (Rank 2)
( 56835, 0x00,  15, 0x00400000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Reaping (Rank 3)
( 57345, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Darkmoon Card: Greatness
( 57352, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00051154, 0x00000000,   0,   0,  45), -- Darkmoon Card: Death
( 57870, 0x00,   9, 0x00800000, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Glyph of Mend Pet
( 57878, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000010,   0,   0,   0), -- Natural Reaction (Rank 1)
( 57880, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000010,   0,   0,   0), -- Natural Reaction (Rank 2)
( 57881, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000010,   0,   0,   0), -- Natural Reaction (Rank 3)
( 57907, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Increased Spirit
( 57960, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Water Shield (Rank 9)
( 58357, 0x00,   4, 0x00000040, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Glyph of Heroic Strike
( 58364, 0x00,   4, 0x00000400, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Revenge
( 58372, 0x00,   4, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Hamstring
( 58386, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000020,   0,   0,   0), -- Glyph of Overpower
( 58442, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  15), -- Airy Pale Ale
( 58444, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   5), -- Worg Tooth Oatmeal Stout
( 58626, 0x00,  15, 0x02000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Death Grip
( 58642, 0x00,  15, 0x00000000, 0x08000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Scourge Strike
( 58644, 0x00,  15, 0x00000000, 0x00000004, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Frost Strike
( 58647, 0x00,  15, 0x00000000, 0x00000004, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Frost Strike
( 58676, 0x00,  15, 0x00000000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Vampiric Blood
( 58677, 0x00,  15, 0x00002000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Death's Embrace
( 58872, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000043,   0,   0,   0), -- Damage Shield (Rank 1)
( 58874, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000043,   0,   0,   0), -- Damage Shield (Rank 2)
( 58901, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Tears of Anguish
( 59088, 0x00,   4, 0x00000000, 0x00000002, 0x00000000, 0x00000400, 0x00000000,   0,   0,   0), -- Improved Spell Reflection (Rank 1)
( 59089, 0x00,   4, 0x00000000, 0x00000002, 0x00000000, 0x00000400, 0x00000000,   0,   0,   0), -- Improved Spell Reflection (Rank 2)
( 59176, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Spell Damping
( 59327, 0x00,  15, 0x08000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Rune Tap
( 59345, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Chagrin
( 59630, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Black Magic
( 59725, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000800,   0,   0,   0), -- Spell Reflection
( 60061, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Flow of Time
( 60063, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Now is the Time!
( 60132, 0x00,  15, 0x00000000, 0x08020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Oblit/Scourge Strike Runic Power Up
( 60170, 0x00,   5, 0x00000006, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Corruption Triggers Crit
( 60172, 0x00,   5, 0x00040000, 0x00000000, 0x00000000, 0x00000000, 0x00010000,   0,   0,   0), -- Life Tap Bonus Spirit
( 60176, 0x00,   4, 0x00000020, 0x00000010, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Bleed Cost Reduction
( 60221, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Essence of Gossamer
( 60301, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Meteorite Whetstone
( 60306, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Vestige of Haldor
( 60317, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Signet of Edward the Odd
( 60436, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Grim Toll
( 60442, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Bandit's Insignia
( 60473, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Forge Ember
( 60482, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Pendulum of Telluric Currents
( 60487, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  15), -- Extract of Necromatic Power
( 60490, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Embrace of the Spider
( 60493, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Dying Curse
( 60519, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Spark of Life
( 60529, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Forethought Talisman
( 60537, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Soul of the Dead
( 60564, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Savage Gladiator's Totem of Survival
( 60571, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Hateful Gladiator's Totem of Survival
( 60572, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Deadly Gladiator's Totem of Survival
( 60573, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- LK Arena 4 Gladiator's Totem of Survival
( 60574, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- LK Arena 5 Gladiator's Totem of Survival
( 60575, 0x00,  11, 0x90100000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- LK Arena 6 Gladiator's Totem of Survival
( 60617, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000020,   0,   0,   0), -- Parry
( 60710, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Savage Gladiator's Idol of Steadfastness
( 60717, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0, 100,   0), -- Hateful Gladiator's Idol of Steadfastness
( 60719, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Deadly Gladiator's Idol of Steadfastness
( 60722, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- LK Arena 4 Gladiator's Idol of Steadfastness
( 60724, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- LK Arena 5 Gladiator's Idol of Steadfastness
( 60726, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- LK Arena 6 Gladiator's Idol of Steadfastness
( 60770, 0x00,  11, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Totem of the Elemental Plane
( 60818, 0x00,  10, 0x00000000, 0x00000200, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Libram of Reciprocation
( 60826, 0x00,  15, 0x01400000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Sigil of Haunted Dreams
( 61188, 0x00,   5, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Chaotic Mind
( 61324, 0x00,  10, 0x00000000, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Justice
( 61345, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Nature's Grace
( 61346, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Nature's Grace
( 61356, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  90), -- Invigorating Earthsiege Diamond Passive
( 61618, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Tentacles
( 61848, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000010,   0,   0,   0), -- Aspect of the Dragonhawk
( 62147, 0x00,  15, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Icy Touch Defense Increase
( 62459, 0x00,  15, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Chains of Ice Frost Rune Refresh (Rank 3)
( 63108, 0x00,   5, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Siphon Life
( 63158, 0x00,   5, 0x00000001, 0x000000C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Decimation
( 63156, 0x00,   5, 0x00000001, 0x000000C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Decimation
( 64343, 0x00,   3, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Impact
( 64976, 0x00,   4, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Juggernaut
( 64914, 0x00,   8, 0x00010000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Rogue T8 2P Bonus
( 64938, 0x00,   4, 0x00200040, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Item - Warrior T8 Melee 2P Bonus
( 64952, 0x00,   7, 0x00000000, 0x00000440, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Druid T8 Feral Relic
( 64964, 0x00,  15, 0x00000000, 0x20000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Death Knight T8 Tank Relic
( 65002, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Bonus Mana Regen
( 65005, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Alacrity of the Elements
( 64999, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   5,   0,   0), -- Meteoric Inspiration
( 65007, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   5,   0,   0), -- Eye of the Broodmother
( 65013, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Pyrite Infusion
( 65020, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Mjolnir Runestone
( 65025, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Dark Matter
( 46949, 0x00,   4, 0x00000000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Safeguard
( 46945, 0x00,   4, 0x00000000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Safeguard
( 64415, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Val'anyr Hammer of Ancient Kings - Equip Effect
( 60066, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Rage of the Unraveller
( 62115, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Strength of the Titans
( 62114, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Flow of Knowledge
( 62600, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Savage Defense
( 63245, 0x00,   5, 0x00000100, 0x00800000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Pyroclasm
( 18096, 0x00,   5, 0x00000100, 0x00800000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Pyroclasm
( 18073, 0x00,   5, 0x00000100, 0x00800000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Pyroclasm
( 63280, 0x00,  11, 0x20000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Totem of Wrath
( 63310, 0x00,   5, 0x00000000, 0x00010000, 0x00000000, 0x00010000, 0x00000000,   0,   0,   0), -- Glyph of Shadowflame
( 63335, 0x00,  15, 0x00000000, 0x00000002, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Howling Blast
( 63730, 0x00,   6, 0x00000800, 0x00000004, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Serendipity
( 63733, 0x00,   6, 0x00000800, 0x00000004, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Serendipity
( 63737, 0x00,   6, 0x00000800, 0x00000004, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Serendipity
( 64127, 0x00,   6, 0x00000001, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Body and Soul
( 64129, 0x00,   6, 0x00000001, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Body and Soul
( 64568, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   3), -- Blood Reserve
( 64571, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Blood Draining
( 64440, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000020,   0,   0,  20), -- Blade Warding
( 64714, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Flame of the Heavens
( 64738, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Show of Faith
( 64742, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Pandora's Plea
( 64752, 0x00,   7, 0x00800000, 0x10000100, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Druid T8 Feral 2P Bonus
( 64786, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  15), -- Comet's Trail
( 64792, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Blood of the Old God
( 64824, 0x00,   7, 0x00200000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Druid T8 Balance 4P Bonus
( 64928, 0x00,  11, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Item - Shaman T8 Elemental
( 64860, 0x00,   9, 0x00000000, 0x00000001, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Hunter T8 4P Bonus
( 64867, 0x00,   3, 0x20000021, 0x00001000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Mage T8 2P Bonus
( 64882, 0x00,  10, 0x00000000, 0x00100000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T8 Protection 4P Bonus
( 64890, 0x00,  10, 0x00000000, 0x00010000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Item - Paladin T8 Holy 2P Bonus
( 64908, 0x00,   6, 0x00000000, 0x00000000, 0x00000040, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Priest T8 Shadow 4P Bonus
( 64912, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Priest T8 Healer 4P Bonus
( 57470, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Renewed Hope
( 57472, 0x00,   6, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Renewed Hope
( 35100, 0x00,   9, 0x00001000, 0x00000000, 0x00000001, 0x00000000, 0x00000000,   0,   0,   0), -- Concussive Barrage
( 35102, 0x00,   9, 0x00001000, 0x00000000, 0x00000001, 0x00000000, 0x00000000,   0,   0,   0), -- Concussive Barrage
( 18119, 0x00,   5, 0x00000000, 0x00800000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Aftermath
( 18120, 0x00,   5, 0x00000000, 0x00800000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Aftermath
( 13165, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 14318, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 14319, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 14320, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 14321, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 14322, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 25296, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 27044, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Hawk
( 61846, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Dragonhawk
( 61847, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Aspect of the Dragonhawk
( 53178, 0x00,   9, 0x00000000, 0x10000000, 0x00000000, 0x00010000, 0x00000000,   0, 100,   0), -- Guard Dog (Rank 1)
( 53179, 0x00,   9, 0x00000000, 0x10000000, 0x00000000, 0x00010000, 0x00000000,   0, 100,   0), -- Guard Dog (Rank 2)
( 62764, 0x00,   9, 0x00000000, 0x10000000, 0x00000000, 0x00010000, 0x00000000,   0, 100,   0), -- Silverback (Rank 1)
( 62765, 0x00,   9, 0x00000000, 0x10000000, 0x00000000, 0x00010000, 0x00000000,   0, 100,   0), -- Silverback (Rank 2)
( 49223, 0x00,  15, 0x00000011, 0x08020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Dirge
( 49599, 0x00,  15, 0x00000011, 0x08020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Dirge
( 49188, 0x00,  15, 0x00000000, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Rime
( 56822, 0x00,  15, 0x00000000, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Rime
( 59057, 0x00,  15, 0x00000000, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Rime
( 55666, 0x00,  15, 0x00000001, 0x08000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Desecration
( 55667, 0x00,  15, 0x00000001, 0x08000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Desecration
( 58616, 0x00,  15, 0x01000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Heart Strike
( 16164, 0x00,  11, 0x901000C3, 0x00001000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Elemental Focus
( 49149, 0x00,  15, 0x00000006, 0x00020002, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Chill of the Grave
( 50115, 0x00,  15, 0x00000006, 0x00020002, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Chill of the Grave
( 49217, 0x00,  15, 0x00000000, 0x00000000, 0x00000002, 0x00000000, 0x00000000,   0,   0,   1), -- Wandering Plague
( 49654, 0x00,  15, 0x00000000, 0x00000000, 0x00000002, 0x00000000, 0x00000000,   0,   0,   1), -- Wandering Plague
( 49655, 0x00,  15, 0x00000000, 0x00000000, 0x00000002, 0x00000000, 0x00000000,   0,   0,   1), -- Wandering Plague
( 58620, 0x00,  15, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Chains of Ice
( 56342, 0x00,   9, 0x00000018, 0x08000000, 0x00024000, 0x00000000, 0x00000000,   0,   0,  22), -- Lock and Load
( 56343, 0x00,   9, 0x00000018, 0x08000000, 0x00024000, 0x00000000, 0x00000000,   0,   0,  22), -- Lock and Load
( 56344, 0x00,   9, 0x00000018, 0x08000000, 0x00024000, 0x00000000, 0x00000000,   0,   0,  22), -- Lock and Load
( 48539, 0x00,   7, 0x00000010, 0x04000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Revitalize
( 48544, 0x00,   7, 0x00000010, 0x04000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Revitalize
( 48545, 0x00,   7, 0x00000010, 0x04000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Revitalize
( 53234, 0x00,   9, 0x00020000, 0x00000001, 0x00000001, 0x00000000, 0x00000002,   0,   0,   0), -- Piercing Shots (Rank 1)
( 53237, 0x00,   9, 0x00020000, 0x00000001, 0x00000001, 0x00000000, 0x00000002,   0,   0,   0), -- Piercing Shots (Rank 2)
( 53238, 0x00,   9, 0x00020000, 0x00000001, 0x00000001, 0x00000000, 0x00000002,   0,   0,   0), -- Piercing Shots (Rank 3)
( 56636, 0x00,   4, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Taste for Blood (Rank 1)
( 56637, 0x00,   4, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Taste for Blood (Rank 2)
( 56638, 0x00,   4, 0x00000020, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   6), -- Taste for Blood (Rank 3)
( 50421, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Scent of Blood
( 53386, 0x30,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Rune of Cinderglacier
( 56375, 0x00,   3, 0x01000000, 0x00000000, 0x00000000, 0x00010000, 0x00000000,   0,   0,   0), -- Glyphs of Polymorph
( 54639, 0x00,  15, 0x00400000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Blood of the north
( 54638, 0x00,  15, 0x00400000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Blood of the north
( 54637, 0x00,  15, 0x00400000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Blood of the north
( 49467, 0x00,  15, 0x00000010, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Death Rune Mastery
( 50033, 0x00,  15, 0x00000010, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Death Rune Mastery
( 50034, 0x00,  15, 0x00000010, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Death Rune Mastery
( 63373, 0x00,  11, 0x80000000, 0x00000000, 0x00000000, 0x00010000, 0x00000000,   0,   0,   0), -- Frozen Power (Rank 1)
( 63374, 0x00,  11, 0x80000000, 0x00000000, 0x00000000, 0x00010000, 0x00000000,   0,   0,   0), -- Frozen Power (Rank 2)
( 54821, 0x00,   7, 0x00001000, 0x00000000, 0x00000000, 0x00000010, 0x00000000,   0,   0,   0), -- Glyph of Rake
( 54815, 0x00,   7, 0x00008000, 0x00000000, 0x00000000, 0x00000010, 0x00000000,   0,   0,   0), -- Glyph of Shred
( 54845, 0x00,   7, 0x00000004, 0x00000000, 0x00000000, 0x00010000, 0x00000000,   0,   0,   0), -- Glyph of Starfire
( 56800, 0x00,   8, 0x00800004, 0x00000000, 0x00000000, 0x00000010, 0x00000000,   0,   0,   0), -- Glyph of Backstab
( 54832, 0x00,   7, 0x00000000, 0x00001000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Glyph of Innervate
( 67353, 0x00,   7, 0x00008000, 0x00100500, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- uncommented
( 57989, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x00000000,   0,   0,   0), -- uncommented
( 65661, 0x00,  15, 0x00400010, 0x20020004, 0x00000000, 0x00000010, 0x00000000,   0, 100,   0), -- Threat of Thassarian (Rank 1)
( 66191, 0x00,  15, 0x00400010, 0x20020004, 0x00000000, 0x00000010, 0x00000000,   0, 100,   0), -- Threat of Thassarian (Rank 2)
( 66192, 0x00,  15, 0x00400010, 0x20020004, 0x00000000, 0x00000010, 0x00000000,   0, 100,   0), -- Threat of Thassarian (Rank 3)
( 53601, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x000A02A8, 0x00000000,   0,   0,   6), -- Sacred Shield (Rank 1)
( 58375, 0x00,   4, 0x00000000, 0x00000200, 0x00000000, 0x00000010, 0x00000000,   0,   0,   0), -- Glyph of Blocking
( 58387, 0x00,   4, 0x00004000, 0x00000040, 0x00000000, 0x00000010, 0x00000000,   0,   0,   0), -- Glyph of Sunder Armor
( 54925, 0x02,  10, 0x00000000, 0x00000208, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Glyph of Seal of Command
( 63320, 0x00,   5, 0x80040000, 0x00000000, 0x00008000, 0x00000400, 0x00000000,   0,   0,   0), -- Glyph of Life Tap
( 64955, 0x00,  10, 0x00000000, 0x00000040, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T8 Protection Relic
( 67356, 0x08,   7, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Druid T9 Restoration Relic (Rejuvenation)
( 67361, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Druid T9 Balance Relic (Moonfire)
( 67363, 0x00,  10, 0x00000000, 0x80000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Item - Paladin T9 Holy Relic (Judgement)
( 67365, 0x00,  10, 0x00000000, 0x00000800, 0x00000000, 0x00040000, 0x00000000,   0,   0,   6), -- Item - Paladin T9 Retribution Relic (Seal of Vengeance)
( 67379, 0x00,  10, 0x00000000, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T9 Protection Relic (Hammer of The Righteous)
( 67381, 0x00,  15, 0x00000000, 0x20000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Item - Death Knight T9 Tank Relic (Rune Strike)
( 67384, 0x00,  15, 0x00000010, 0x08020000, 0x00000000, 0x00000000, 0x00000000,   0,  80,  10), -- Item - Death Knight T9 Melee Relic (Rune Strike)
( 67386, 0x00,  11, 0x00000001, 0x00000000, 0x00000000, 0x00010000, 0x00000000,   0,   0,   6), -- Item - Shaman T9 Elemental Relic (Lightning Bolt)
( 67389, 0x00,  11, 0x00000100, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   8), -- Item - Shaman T9 Restoration Relic (Chain Heal)
( 67392, 0x00,  11, 0x00000000, 0x00000000, 0x00000004, 0x00000010, 0x00000000,   0,   0,   0), -- Item - Shaman T9 Enhancement Relic (Lava Lash)
( 67653, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00400028, 0x00000000,   0,   0,  45), -- Item - Coliseum Tank Trinket 5men
( 67667, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,  45), -- Item - Coliseum Healer Trinket 5men
( 67670, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0x00000000,   0,   0,  45), -- Item - Coliseum Caster Trinket 5men
( 67672, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00800154, 0x00000000,   0,   0,  45), -- Item - Coliseum Melee Trinket 5men
( 67758, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   2), -- Item - Coliseum 25 Heroic Caster Trinket
( 67771, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00851154, 0x00000003,   0,  35,  45), -- Item - Coliseum Melee Trinket 10men
( 67702, 0x01,   0, 0x00000000, 0x00000000, 0x00000000, 0x00851154, 0x00000003,   0,  35,  45), -- Item - Coliseum Melee Trinket 25men
( 70652, 0x00,  15, 0x00000008, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Death Knight T10 Tank 4P Bonus
( 70656, 0x00,  15, 0x00000000, 0x00000000, 0x00000000, 0x00014000, 0x00000000,   0,   0,   0), -- Item - Death Knight T10 Melee 4P Bonus
( 70727, 0x00,   9, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Item - Hunter T10 2P Bonus
( 70730, 0x00,   9, 0x00004000, 0x00001000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Hunter T10 4P Bonus
( 70748, 0x00,   3, 0x00000000, 0x00200000, 0x00000000, 0x00000400, 0x00000000,   0,   0,   0), -- Item - Mage T10 4P Bonus
( 70756, 0x00,  10, 0x00200000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Holy 4P Bonus
( 70761, 0x00,  10, 0x00000000, 0x80004000, 0x00000001, 0x00000400, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Protection 4P Bonus
( 70803, 0x00,   8, 0x003E0000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Rogue T10 4P Bonus
( 70805, 0x00,   8, 0x00000000, 0x00020000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Item - Rogue T10 2P Bonus
( 70807, 0x00,  11, 0x00000000, 0x00000000, 0x00000010, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Shaman T10 Restoration 2P Bonus
( 70830, 0x00,  11, 0x00000000, 0x00020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Shaman T10 Enhancement 2P Bonus
( 70841, 0x00,   5, 0x00000004, 0x00000100, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Warlock T10 4P Bonus
( 70854, 0x00,   4, 0x00000000, 0x00000010, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Warrior T10 Melee 2P Bonus
( 71176, 0x00,   7, 0x00200002, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Druid T10 Balance Relic (Moonfire and Insect Swarm)
( 71178, 0x00,   7, 0x00000010, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Druid T10 Restoration Relic (Rejuvenation)
( 71186, 0x00,  10, 0x00000000, 0x00008000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Retribution Relic (Crusader Strike)
( 71191, 0x00,  10, 0x00000000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Holy Relic (Holy Shock)
( 71194, 0x00,  10, 0x00000000, 0x00100000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Protection Relic (Shield of Righteousness)
( 71214, 0x00,  11, 0x00001400, 0x00000010, 0x00000000, 0x00000010, 0x00000000,   0,   0,   6), -- Item - Shaman T10 Enhancement Relic (Stormstrike)
( 71217, 0x00,  11, 0x00000000, 0x00000000, 0x00000010, 0x00004000, 0x00000000,   0,   0,   0), -- Item - Shaman T10 Restoration Relic (Riptide)
( 71226, 0x00,  15, 0x00000010, 0x08020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Death Knight T10 DPS Relic (Obliterate, Scourge Strike, Death Strike)
( 71228, 0x00,  15, 0x00000000, 0x20000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Death Knight T10 Tank Relic (Runestrike)
( 71402, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Whispering Fanged Skull
( 71519, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0, 105), -- Item - Deathbringer's Will Trinket Normal
( 71540, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Whispering Fanged Skull (Heroic)
( 71562, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0, 105), -- Item - Deathbringer's Will Trinket Heroic
( 71602, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Dislodged Foreign Object
( 71606, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0, 100), -- Phylactery of the Nameless Lich
( 71611, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Althor's Abacus
( 71634, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Corpse Tongue Coin
( 71637, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0, 100), -- Phylactery of the Nameless Lich (Heroic)
( 71640, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  30), -- Corpse Tongue Coin (Heroic)
( 71642, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Althor's Abacus (Heroic)
( 71645, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Dislodged Foreign Object (Heroic)
( 72417, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Item - Icecrown Reputation Ring Caster Trigger
( 72413, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Item - Icecrown Reputation Ring Melee
( 72419, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  60), -- Item - Icecrown Reputation Ring Healer Trigger
( 71404, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,  45), -- Item - Icecrown Dungeon Melee Trinket
( 71564, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000002,   0,   0,   0), -- Nevermelting Ice Crystal
 (71545, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  50,   0), -- Tiny Abomination in a Jar (Heroic)
( 71406, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,  50,   0), -- Tiny Abomination in a Jar
( 75474, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Charred Twilight Scale (Heroic)
( 75465, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Charred Twilight Scale
( 75457, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45), -- Sharpened Twilight Scale (Heroic)
( 75455, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  45); -- Sharpened Twilight Scale
/*!40000 ALTER TABLE `spell_proc_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_required`
--

DROP TABLE IF EXISTS `spell_required`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_required` (
  `spell_id` mediumint(9) NOT NULL DEFAULT '0',
  `req_spell` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell_id`, `req_spell`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Spell Additinal Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_required`
--

LOCK TABLES `spell_required` WRITE;
/*!40000 ALTER TABLE `spell_required` DISABLE KEYS */;
/*!40000 ALTER TABLE `spell_required` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_script_target`
--

DROP TABLE IF EXISTS `spell_script_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_script_target` (
  `entry` mediumint(8) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `targetEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `entry_type_target` (`entry`,`type`,`targetEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_script_target`
--

LOCK TABLES `spell_script_target` WRITE;
/*!40000 ALTER TABLE `spell_script_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `spell_script_target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_scripts`
--

DROP TABLE IF EXISTS `spell_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_scripts` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `effIndex` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_scripts`
--

LOCK TABLES `spell_scripts` WRITE;
/*!40000 ALTER TABLE `spell_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `spell_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_group_stack_rules`
--

DROP TABLE IF EXISTS `spell_group_stack_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
DROP TABLE IF EXISTS `spell_group_stack_rules`;
CREATE TABLE `spell_group_stack_rules` (
  `group_id` INT(11) UNSIGNED NOT NULL DEFAULT 0,
  `stack_rule` TINYINT(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_group_stack_rules`
--

LOCK TABLES `spell_group_stack_rules` WRITE;
/*!40000 ALTER TABLE `spell_group_stack_rules` DISABLE KEYS */;
INSERT INTO spell_group_stack_rules (`group_id`, `stack_rule`) VALUES
(1, 1),
(2, 1),
(1001, 1),
(1002, 1),
(1003, 1),
(1004, 1),
(1005, 1),
(1006, 1),
(1007, 1),
(1008, 1),
(1009, 1),
(1010, 2),
(1011, 2),
(1015,1),
(1016,1),
(1019,1),
(1022,1),
(1025,1),
(1029,1),
(1033,1),
(1036,1),
(1043,1),
(1048,1),
(1051,1),
(1054,1),
(1057,1),
(1059,1),
(1064,1),
(1068,1),
(1074,1),
(1079,1),
(1082,1),
(1085,1),
(1088,1),
(1090,1),
(1093,1),
(1096,1),
(1099,1),
(1103,1),
(1046,1),
(1107,1),
(1108,1),
(1109,1),
(1110,1),
(1112,2),
(1113,1);

/*!40000 ALTER TABLE `spell_group_stack_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_ranks`
--

DROP TABLE IF EXISTS `spell_ranks`;
CREATE TABLE `spell_ranks` (
  `first_spell_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `spell_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `rank` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY  (`first_spell_id`, `rank`),
  UNIQUE (`spell_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Spell Rank Data';

--
-- Dumping data for table `spell_ranks`
--

LOCK TABLES `spell_ranks` WRITE;
/*!40000 ALTER TABLE `spell_ranks` DISABLE KEYS */;
INSERT INTO spell_ranks (`first_spell_id`, `spell_id`, `rank`) VALUES
 -- Abomination's Might
(53137, 53137, 1),
(53137, 53138, 2),
 -- Absolution
(33167, 33167, 1),
(33167, 33171, 2),
(33167, 33172, 3),
 -- Acclimation
(49200, 49200, 1),
(49200, 50151, 2),
(49200, 50152, 3),
 -- Acid Spit
(55749, 55749, 1),
(55749, 55750, 2),
(55749, 55751, 3),
(55749, 55752, 4),
(55749, 55753, 5),
(55749, 55754, 6),
 -- Aftermath
(18119, 18119, 1),
(18119, 18120, 2),
 -- Aggression
(18427, 18427, 1),
(18427, 18428, 2),
(18427, 18429, 3),
(18427, 61330, 4),
(18427, 61331, 5),
 -- Agility
(8115, 8115, 1),
(8115, 8116, 2),
(8115, 8117, 3),
(8115, 12174, 4),
(8115, 33077, 5),
(8115, 43194, 6),
(8115, 58450, 7),
(8115, 58451, 8),
 -- Aimed Shot
(19434, 19434, 1),
(19434, 20900, 2),
(19434, 20901, 3),
(19434, 20902, 4),
(19434, 20903, 5),
(19434, 20904, 6),
(19434, 27065, 7),
(19434, 49049, 8),
(19434, 49050, 9),
 -- Alchemy
(2259, 2259, 1),
(2259, 3101, 2),
(2259, 3464, 3),
(2259, 11611, 4),
(2259, 28596, 5),
(2259, 51304, 6),
 -- Ambush
(8676, 8676, 1),
(8676, 8724, 2),
(8676, 8725, 3),
(8676, 11267, 4),
(8676, 11268, 5),
(8676, 11269, 6),
(8676, 27441, 7),
(8676, 48689, 8),
(8676, 48690, 9),
(8676, 48691, 10),
 -- Amplify Magic
(1267, 1267, 1),
(1267, 8456, 2),
(1267, 10171, 3),
(1267, 10172, 4),
(1267, 27397, 5),
(1267, 33947, 6),
 -- Amplify Magic
(1008, 1008, 1),
(1008, 8455, 2),
(1008, 10169, 3),
(1008, 10170, 4),
(1008, 27130, 5),
(1008, 33946, 6),
(1008, 43017, 7),
 -- Ancestral Awakening
(51556, 51556, 1),
(51556, 51557, 2),
(51556, 51558, 3),
 -- Ancestral Fortitude
(16177, 16177, 1),
(16177, 16236, 2),
(16177, 16237, 3),
 -- Ancestral Healing
(16176, 16176, 1),
(16176, 16235, 2),
(16176, 16240, 3),
 -- Ancestral Knowledge
(17485, 17485, 1),
(17485, 17486, 2),
(17485, 17487, 3),
(17485, 17488, 4),
(17485, 17489, 5),
 -- Ancestral Spirit
(2008, 2008, 1),
(2008, 20609, 2),
(2008, 20610, 3),
(2008, 20776, 4),
(2008, 20777, 5),
(2008, 25590, 6),
(2008, 49277, 7),
 -- Anguish
(33704, 33704, 1),
(33704, 33705, 2),
(33704, 33706, 3),
 -- Anguish
(33698, 33698, 1),
(33698, 33699, 2),
(33698, 33700, 3),
(33698, 47993, 4),
 -- Animal Handler
(34453, 34453, 1),
(34453, 34454, 2),
 -- Annihilation
(51468, 51468, 1),
(51468, 51472, 2),
(51468, 51473, 3),
 -- Anticipation
(12297, 12297, 1),
(12297, 12750, 2),
(12297, 12751, 3),
(12297, 12752, 4),
(12297, 12753, 5),
 -- Anticipation
(20096, 20096, 1),
(20096, 20097, 2),
(20096, 20098, 3),
(20096, 20099, 4),
(20096, 20100, 5),
 -- Anticipation
(16254, 16254, 1),
(16254, 16271, 2),
(16254, 16272, 3),
 -- Anticipation
(55129, 55129, 1),
(55129, 55130, 2),
(55129, 55131, 3),
(55129, 55132, 4),
(55129, 55133, 5),
 -- Arcane Barrage
(44425, 44425, 1),
(44425, 44780, 2),
(44425, 44781, 3),
 -- Arcane Blast
(30451, 30451, 1),
(30451, 42894, 2),
(30451, 42896, 3),
(30451, 42897, 4),
 -- Arcane Brilliance
(23028, 23028, 1),
(23028, 27127, 2),
(23028, 43002, 3),
 -- Arcane Concentration
(11213, 11213, 1),
(11213, 12574, 2),
(11213, 12575, 3),
(11213, 12576, 4),
(11213, 12577, 5),
 -- Arcane Empowerment
(31579, 31579, 1),
(31579, 31582, 2),
(31579, 31583, 3),
 -- Arcane Explosion
(1449, 1449, 1),
(1449, 8437, 2),
(1449, 8438, 3),
(1449, 8439, 4),
(1449, 10201, 5),
(1449, 10202, 6),
(1449, 27080, 7),
(1449, 27082, 8),
(1449, 42920, 9),
(1449, 42921, 10),
 -- Arcane Flows
(44378, 44378, 1),
(44378, 44379, 2),
 -- Arcane Focus
(11222, 11222, 1),
(11222, 12839, 2),
(11222, 12840, 3),
 -- Arcane Fortitude
(28574, 28574, 1),
(28574, 54658, 2),
(28574, 54659, 3),
 -- Arcane Instability
(15058, 15058, 1),
(15058, 15059, 2),
(15058, 15060, 3),
 -- Arcane Intellect
(1459, 1459, 1),
(1459, 1460, 2),
(1459, 1461, 3),
(1459, 10156, 4),
(1459, 10157, 5),
(1459, 27126, 6),
(1459, 42995, 7),
 -- Arcane Mastery
(16734, 16734, 1),
(16734, 16735, 2),
(16734, 16736, 3),
(16734, 16737, 4),
(16734, 16738, 5),
 -- Arcane Meditation
(18462, 18462, 1),
(18462, 18463, 2),
(18462, 18464, 3),
 -- Arcane Mind
(11232, 11232, 1),
(11232, 12500, 2),
(11232, 12501, 3),
(11232, 12502, 4),
(11232, 12503, 5),
 -- Arcane Potency
(31571, 31571, 1),
(31571, 31572, 2),
 -- Arcane Shielding
(11252, 11252, 1),
(11252, 12605, 2),
 -- Arcane Shot
(3044, 3044, 1),
(3044, 14281, 2),
(3044, 14282, 3),
(3044, 14283, 4),
(3044, 14284, 5),
(3044, 14285, 6),
(3044, 14286, 7),
(3044, 14287, 8),
(3044, 27019, 9),
(3044, 49044, 10),
(3044, 49045, 11),
 -- Arcane Stability
(11237, 11237, 1),
(11237, 12463, 2),
(11237, 12464, 3),
(11237, 16769, 4),
(11237, 16770, 5),
 -- Arcane Subtlety
(11210, 11210, 1),
(11210, 12592, 2),
 -- Arctic Reach
(16757, 16757, 1),
(16757, 16758, 2),
 -- Arctic Winds
(31674, 31674, 1),
(31674, 31675, 2),
(31674, 31676, 3),
(31674, 31677, 4),
(31674, 31678, 5),
 -- Ardent Defender
(31850, 31850, 1),
(31850, 31851, 2),
(31850, 31852, 3),
 -- Armor
(8091, 8091, 1),
(8091, 8094, 2),
(8091, 8095, 3),
(8091, 12175, 4),
(8091, 33079, 5),
(8091, 43196, 6),
(8091, 58452, 7),
(8091, 58453, 8),
 -- Armored to the Teeth
(61216, 61216, 1),
(61216, 61221, 2),
(61216, 61222, 3),
 -- Aspect of the Dragonhawk
(61846, 61846, 1),
(61846, 61847, 2),
 -- Aspect of the Hawk
(13165, 13165, 1),
(13165, 14318, 2),
(13165, 14319, 3),
(13165, 14320, 4),
(13165, 14321, 5),
(13165, 14322, 6),
(13165, 25296, 7),
(13165, 27044, 8),
 -- Aspect of the Wild
(20043, 20043, 1),
(20043, 20190, 2),
(20043, 27045, 3),
(20043, 49071, 4),
 -- Aspiration
(47507, 47507, 1),
(47507, 47508, 2),
 -- Astral Shift
(51474, 51474, 1),
(51474, 51478, 2),
(51474, 51479, 3),
 -- Avenger's Shield
(31935, 31935, 1),
(31935, 32699, 2),
(31935, 32700, 3),
(31935, 48826, 4),
(31935, 48827, 5),
 -- Backdraft
(47258, 47258, 1),
(47258, 47259, 2),
(47258, 47260, 3),
 -- Backlash
(34935, 34935, 1),
(34935, 34938, 2),
(34935, 34939, 3),
 -- Backstab
(53, 53, 1),
(53, 2589, 2),
(53, 2590, 3),
(53, 2591, 4),
(53, 8721, 5),
(53, 11279, 6),
(53, 11280, 7),
(53, 11281, 8),
(53, 25300, 9),
(53, 26863, 10),
(53, 48656, 11),
(53, 48657, 12),
 -- Bad Attitude
(50433, 50433, 1),
(50433, 52395, 2),
(50433, 52396, 3),
(50433, 52397, 4),
(50433, 52398, 5),
(50433, 52399, 6),
 -- Balance of Power
(33592, 33592, 1),
(33592, 33596, 2),
 -- Bane
(17788, 17788, 1),
(17788, 17789, 2),
(17788, 17790, 3),
(17788, 17791, 4),
(17788, 17792, 5),
 -- Banish
(710, 710, 1),
(710, 18647, 2),
 -- Barrage
(19461, 19461, 1),
(19461, 19462, 2),
(19461, 24691, 3),
 -- Bash
(5211, 5211, 1),
(5211, 6798, 2),
(5211, 8983, 3),
 -- Battle Shout
(6673, 6673, 1),
(6673, 5242, 2),
(6673, 6192, 3),
(6673, 11549, 4),
(6673, 11550, 5),
(6673, 11551, 6),
(6673, 25289, 7),
(6673, 2048, 8),
(6673, 47436, 9),
 -- Benediction
(20101, 20101, 1),
(20101, 20102, 2),
(20101, 20103, 3),
(20101, 20104, 4),
(20101, 20105, 5),
 -- Bestial Discipline
(19590, 19590, 1),
(19590, 19592, 2),
 -- Bestial Fury
(19603, 19603, 1),
(19603, 19605, 2),
(19603, 19606, 3),
(19603, 19607, 4),
(19603, 19608, 5),
 -- Binding Heal
(32546, 32546, 1),
(32546, 48119, 2),
(32546, 48120, 3),
 -- Bite
(17254, 17254, 1),
(17254, 17262, 2),
(17254, 17263, 3),
(17254, 17264, 4),
(17254, 17265, 5),
(17254, 17266, 6),
(17254, 17267, 7),
(17254, 17268, 8),
(17254, 27348, 9),
 -- Bite
(17253, 17253, 1),
(17253, 17255, 2),
(17253, 17256, 3),
(17253, 17257, 4),
(17253, 17258, 5),
(17253, 17259, 6),
(17253, 17260, 7),
(17253, 17261, 8),
(17253, 27050, 9),
(17253, 52473, 10),
(17253, 52474, 11),
 -- Black Arrow
(3674, 3674, 1),
(3674, 63668, 2),
(3674, 63669, 3),
(3674, 63670, 4),
(3674, 63671, 5),
(3674, 63672, 6),
 -- Black Ice
(49140, 49140, 1),
(49140, 49661, 2),
(49140, 49662, 3),
(49140, 49663, 4),
(49140, 49664, 5),
 -- Blacksmithing
(2018, 2018, 1),
(2018, 3100, 2),
(2018, 3538, 3),
(2018, 9785, 4),
(2018, 29844, 5),
(2018, 51300, 6),
 -- Blade Barrier
(51789, 51789, 1),
(51789, 64855, 2),
(51789, 64856, 3),
(51789, 64858, 4),
(51789, 64859, 5),
 -- Blade Barrier
(49182, 49182, 1),
(49182, 49500, 2),
(49182, 49501, 3),
(49182, 55225, 4),
(49182, 55226, 5),
 -- Blade Twisting
(31124, 31124, 1),
(31124, 31126, 2),
 -- Bladed Armor
(48978, 48978, 1),
(48978, 49390, 2),
(48978, 49391, 3),
(48978, 49392, 4),
(48978, 49393, 5),
 -- Blast Wave
(11113, 11113, 1),
(11113, 13018, 2),
(11113, 13019, 3),
(11113, 13020, 4),
(11113, 13021, 5),
(11113, 27133, 6),
(11113, 33933, 7),
(11113, 42944, 8),
(11113, 42945, 9),
 -- Blazing Speed
(31641, 31641, 1),
(31641, 31642, 2),
 -- Blessed Hands
(53660, 53660, 1),
(53660, 53661, 2),
 -- Blessed Life
(31828, 31828, 1),
(31828, 31829, 2),
(31828, 31830, 3),
 -- Blessing of Might
(19740, 19740, 1),
(19740, 19834, 2),
(19740, 19835, 3),
(19740, 19836, 4),
(19740, 19837, 5),
(19740, 19838, 6),
(19740, 25291, 7),
(19740, 27140, 8),
(19740, 48931, 9),
(19740, 48932, 10),
 -- Blessing of the Eternals
(51554, 51554, 1),
(51554, 51555, 2),
 -- Blessing of Wisdom
(19742, 19742, 1),
(19742, 19850, 2),
(19742, 19852, 3),
(19742, 19853, 4),
(19742, 19854, 5),
(19742, 25290, 6),
(19742, 27142, 7),
(19742, 48935, 8),
(19742, 48936, 9),
 -- Blood Boil
(48721, 48721, 1),
(48721, 49939, 2),
(48721, 49940, 3),
(48721, 49941, 4),
 -- Blood Craze
(16487, 16487, 1),
(16487, 16489, 2),
(16487, 16492, 3),
 -- Blood Frenzy
(30069, 30069, 1),
(30069, 30070, 2),
 -- Blood Frenzy
(29836, 29836, 1),
(29836, 29859, 2),
 -- Blood Frenzy
(16952, 16952, 1),
(16952, 16954, 2),
 -- Blood of Icewater
(50122, 50122, 1),
(50122, 50123, 2),
(50122, 50124, 3),
(50122, 50125, 4),
(50122, 50126, 5),
 -- Blood of the North
(54639, 54639, 1),
(54639, 54638, 2),
(54639, 54637, 3),
 -- Blood of the Rhino
(53481, 53481, 1),
(53481, 53482, 2),
 -- Blood Pact
(6307, 6307, 1),
(6307, 7804, 2),
(6307, 7805, 3),
(6307, 11766, 4),
(6307, 11767, 5),
(6307, 27268, 6),
(6307, 47982, 7),
 -- Blood Spatter
(51632, 51632, 1),
(51632, 51633, 2),
 -- Blood-Caked Blade
(49219, 49219, 1),
(49219, 49627, 2),
(49219, 49628, 3),
 -- Bloodsurge
(46913, 46913, 1),
(46913, 46914, 2),
(46913, 46915, 3),
 -- Bloodthirsty
(53186, 53186, 1),
(53186, 53187, 2),
 -- Bloodworms
(49027, 49027, 1),
(49027, 49542, 2),
(49027, 49543, 3),
 -- Bloody Strikes
(48977, 48977, 1),
(48977, 49394, 2),
(48977, 49395, 3),
 -- Bloody Vengeance
(48988, 48988, 1),
(48988, 49503, 2),
(48988, 49504, 3),
 -- Body and Soul
(64127, 64127, 1),
(64127, 64129, 2),
 -- Booming Echoes
(63370, 63370, 1),
(63370, 63372, 2),
 -- Booming Voice
(12321, 12321, 1),
(12321, 12835, 2),
 -- Borrowed Time
(52795, 52795, 1),
(52795, 52797, 2),
(52795, 52798, 3),
(52795, 52799, 4),
(52795, 52800, 5),
 -- Brain Freeze
(44546, 44546, 1),
(44546, 44548, 2),
(44546, 44549, 3),
 -- Brambles
(16836, 16836, 1),
(16836, 16839, 2),
(16836, 16840, 3),
 -- Brutal Impact
(16940, 16940, 1),
(16940, 16941, 2),
 -- Burning Determination
(54747, 54747, 1),
(54747, 54749, 2),
 -- Burning Soul
(11083, 11083, 1),
(11083, 12351, 2),
 -- Burnout
(44449, 44449, 1),
(44449, 44469, 2),
(44449, 44470, 3),
(44449, 44471, 4),
(44449, 44472, 5),
 -- Butchery
(48979, 48979, 1),
(48979, 49483, 2),
 -- Call of Flame
(16038, 16038, 1),
(16038, 16160, 2),
(16038, 16161, 3),
 -- Camouflage
(13975, 13975, 1),
(13975, 14062, 2),
(13975, 14063, 3),
 -- Careful Aim
(34482, 34482, 1),
(34482, 34483, 2),
(34482, 34484, 3),
 -- Cataclysm
(17778, 17778, 1),
(17778, 17779, 2),
(17778, 17780, 3),
 -- Catlike Reflexes
(34462, 34462, 1),
(34462, 34464, 2),
(34462, 34465, 3),
 -- Celestial Focus
(16850, 16850, 1),
(16850, 16923, 2),
(16850, 16924, 3),
 -- Chain Heal
(1064, 1064, 1),
(1064, 10622, 2),
(1064, 10623, 3),
(1064, 25422, 4),
(1064, 25423, 5),
(1064, 55458, 6),
(1064, 55459, 7),
 -- Chains of Ice
(113, 113, 1),
(113, 512, 2),
 -- Chaos Bolt
(50796, 50796, 1),
(50796, 59170, 2),
(50796, 59171, 3),
(50796, 59172, 4),
 -- Charge
(100, 100, 1),
(100, 6178, 2),
(100, 11578, 3),
 -- Charge Rage Bonus Effect
(12695, 12695, 1),
(12695, 12696, 2),
 -- Cheat Death
(31228, 31228, 1),
(31228, 31229, 2),
(31228, 31230, 3),
 -- Chilblains
(50040, 50040, 1),
(50040, 50041, 2),
(50040, 50043, 3),
 -- Chill of the Grave
(49149, 49149, 1),
(49149, 50115, 2),
 -- Chilled
(12484, 12484, 1),
(12484, 12485, 2),
(12484, 12486, 3),
 -- Chilled to the Bone
(44566, 44566, 1),
(44566, 44567, 2),
(44566, 44568, 3),
(44566, 44570, 4),
(44566, 44571, 5),
 -- Circle of Healing
(34861, 34861, 1),
(34861, 34863, 2),
(34861, 34864, 3),
(34861, 34865, 4),
(34861, 34866, 5),
(34861, 48088, 6),
(34861, 48089, 7),
 -- Claw
(1082, 1082, 1),
(1082, 3029, 2),
(1082, 5201, 3),
(1082, 9849, 4),
(1082, 9850, 5),
(1082, 27000, 6),
(1082, 48569, 7),
(1082, 48570, 8),
 -- Claw
(16827, 16827, 1),
(16827, 16828, 2),
(16827, 16829, 3),
(16827, 16830, 4),
(16827, 16831, 5),
(16827, 16832, 6),
(16827, 3010, 7),
(16827, 3009, 8),
(16827, 27049, 9),
(16827, 52471, 10),
(16827, 52472, 11),
 -- Cleave
(30214, 30214, 1),
(30214, 30222, 2),
(30214, 30224, 3),
 -- Cleave
(845, 845, 1),
(845, 7369, 2),
(845, 11608, 3),
(845, 11609, 4),
(845, 20569, 5),
(845, 25231, 6),
(845, 47519, 7),
(845, 47520, 8),
 -- Cleave
(30213, 30213, 1),
(30213, 30219, 2),
(30213, 30223, 3),
(30213, 47994, 4),
 -- Cleave Armor
(5508, 5508, 1),
(5508, 5480, 2),
 -- Close Quarters Combat
(13706, 13706, 1),
(13706, 13804, 2),
(13706, 13805, 3),
(13706, 13806, 4),
(13706, 13807, 5),
 -- Cobra Reflexes
(61682, 61682, 1),
(61682, 61683, 2),
 -- Cobra Strikes
(53256, 53256, 1),
(53256, 53259, 2),
(53256, 53260, 3),
 -- Cold as Ice
(55091, 55091, 1),
(55091, 55092, 2),
 -- Combat Endurance
(17427, 17427, 1),
(17427, 17428, 2),
(17427, 17429, 3),
 -- Combat Experience
(34475, 34475, 1),
(34475, 34476, 2),
 -- Combat Expertise
(31858, 31858, 1),
(31858, 31859, 2),
(31858, 31860, 3),
 -- Combat Potency
(35542, 35542, 1),
(35542, 35545, 2),
(35542, 35546, 3),
(35542, 35547, 4),
(35542, 35548, 5),
 -- Combat Potency
(35541, 35541, 1),
(35541, 35550, 2),
(35541, 35551, 3),
(35541, 35552, 4),
(35541, 35553, 5),
 -- Commanding Presence
(12318, 12318, 1),
(12318, 12857, 2),
(12318, 12858, 3),
(12318, 12860, 4),
(12318, 12861, 5),
 -- Commanding Shout
(469, 469, 1),
(469, 47439, 2),
(469, 47440, 3),
 -- Concussion
(16035, 16035, 1),
(16035, 16105, 2),
(16035, 16106, 3),
(16035, 16107, 4),
(16035, 16108, 5),
 -- Concussive Barrage
(35100, 35100, 1),
(35100, 35102, 2),
 -- Cone of Cold
(120, 120, 1),
(120, 8492, 2),
(120, 10159, 3),
(120, 10160, 4),
(120, 10161, 5),
(120, 27087, 6),
(120, 42930, 7),
(120, 42931, 8),
 -- Conjure Food
(587, 587, 1),
(587, 597, 2),
(587, 990, 3),
(587, 6129, 4),
(587, 10144, 5),
(587, 10145, 6),
(587, 28612, 7),
(587, 33717, 8),
 -- Conjure Mana Gem
(759, 759, 1),
(759, 3552, 2),
(759, 10053, 3),
(759, 10054, 4),
(759, 27101, 5),
(759, 42985, 6),
 -- Conjure Refreshment
(42955, 42955, 1),
(42955, 42956, 2),
 -- Conjure Water
(5504, 5504, 1),
(5504, 5505, 2),
(5504, 5506, 3),
(5504, 6127, 4),
(5504, 10138, 5),
(5504, 10139, 6),
(5504, 10140, 7),
(5504, 37420, 8),
(5504, 27090, 9),
 -- Consecration
(26573, 26573, 1),
(26573, 20116, 2),
(26573, 20922, 3),
(26573, 20923, 4),
(26573, 20924, 5),
(26573, 27173, 6),
(26573, 48818, 7),
(26573, 48819, 8),
 -- Consume Shadows
(17767, 17767, 1),
(17767, 17850, 2),
(17767, 17851, 3),
(17767, 17852, 4),
(17767, 17853, 5),
(17767, 17854, 6),
(17767, 27272, 7),
(17767, 47987, 8),
(17767, 47988, 9),
 -- Contagion
(30060, 30060, 1),
(30060, 30061, 2),
(30060, 30062, 3),
(30060, 30063, 4),
(30060, 30064, 5),
 -- Convection
(16039, 16039, 1),
(16039, 16109, 2),
(16039, 16110, 3),
(16039, 16111, 4),
(16039, 16112, 5),
 -- Conviction
(20117, 20117, 1),
(20117, 20118, 2),
(20117, 20119, 3),
(20117, 20120, 4),
(20117, 20121, 5),
 -- Cooking
(2550, 2550, 1),
(2550, 3102, 2),
(2550, 3413, 3),
(2550, 18260, 4),
(2550, 33359, 5),
(2550, 51296, 6),
 -- Cornered
(52234, 52234, 1),
(52234, 53497, 2),
 -- Corpse Explosion
(49158, 49158, 1),
(49158, 51325, 2),
(49158, 51326, 3),
(49158, 51327, 4),
(49158, 51328, 5),
 -- Corruption
(172, 172, 1),
(172, 6222, 2),
(172, 6223, 3),
(172, 7648, 4),
(172, 11671, 5),
(172, 11672, 6),
(172, 25311, 7),
(172, 27216, 8),
(172, 47812, 9),
(172, 47813, 10),
 -- Counterattack
(19306, 19306, 1),
(19306, 20909, 2),
(19306, 20910, 3),
(19306, 27067, 4),
(19306, 48998, 5),
(19306, 48999, 6),
 -- Cower
(8998, 8998, 1),
(8998, 9000, 2),
(8998, 9892, 3),
(8998, 31709, 4),
(8998, 27004, 5),
(8998, 48575, 6),
 -- Create Firestone
(6366, 6366, 1),
(6366, 17951, 2),
(6366, 17952, 3),
(6366, 17953, 4),
(6366, 27250, 5),
(6366, 60219, 6),
(6366, 60220, 7),
 -- Create Healthstone
(6201, 6201, 1),
(6201, 6202, 2),
(6201, 5699, 3),
(6201, 11729, 4),
(6201, 11730, 5),
(6201, 27230, 6),
(6201, 47871, 7),
(6201, 47878, 8),
 -- Create Soulstone
(693, 693, 1),
(693, 20752, 2),
(693, 20755, 3),
(693, 20756, 4),
(693, 20757, 5),
(693, 27238, 6),
(693, 47884, 7),
 -- Create Spellstone
(2362, 2362, 1),
(2362, 17727, 2),
(2362, 17728, 3),
(2362, 28172, 4),
(2362, 47886, 5),
(2362, 47888, 6),
 -- Critical Block
(47294, 47294, 1),
(47294, 47295, 2),
(47294, 47296, 3),
 -- Critical Mass
(11115, 11115, 1),
(11115, 11367, 2),
(11115, 11368, 3),
 -- Cruelty
(12320, 12320, 1),
(12320, 12852, 2),
(12320, 12853, 3),
(12320, 12855, 4),
(12320, 12856, 5),
 -- Crusade
(31866, 31866, 1),
(31866, 31867, 2),
(31866, 31868, 3),
 -- Crypt Fever
(49032, 49032, 1),
(49032, 49631, 2),
(49032, 49632, 3),
 -- Culling the Herd
(61680, 61680, 1),
(61680, 61681, 2),
(61680, 52858, 3),
 -- Curse of Agony
(980, 980, 1),
(980, 1014, 2),
(980, 6217, 3),
(980, 11711, 4),
(980, 11712, 5),
(980, 11713, 6),
(980, 27218, 7),
(980, 47863, 8),
(980, 47864, 9),
 -- Curse of Doom
(603, 603, 1),
(603, 30910, 2),
(603, 47867, 3),
 -- Curse of the Elements
(1490, 1490, 1),
(1490, 11721, 2),
(1490, 11722, 3),
(1490, 27228, 4),
(1490, 47865, 5),
 -- Curse of Tongues
(1714, 1714, 1),
(1714, 11719, 2),
 -- Curse of Weakness
(702, 702, 1),
(702, 1108, 2),
(702, 6205, 3),
(702, 7646, 4),
(702, 11707, 5),
(702, 11708, 6),
(702, 27224, 7),
(702, 30909, 8),
(702, 50511, 9),
 -- Cut to the Chase
(51664, 51664, 1),
(51664, 51665, 2),
(51664, 51667, 3),
(51664, 51668, 4),
(51664, 51669, 5),
 -- Damage Shield
(58872, 58872, 1),
(58872, 58874, 2),
 -- Dampen Magic
(1266, 1266, 1),
(1266, 8452, 2),
(1266, 8453, 3),
(1266, 10175, 4),
(1266, 10176, 5),
 -- Dampen Magic
(604, 604, 1),
(604, 8450, 2),
(604, 8451, 3),
(604, 10173, 4),
(604, 10174, 5),
(604, 33944, 6),
(604, 43015, 7),
 -- Dark Conviction
(48987, 48987, 1),
(48987, 49477, 2),
(48987, 49478, 3),
(48987, 49479, 4),
(48987, 49480, 5),
 -- Dark Pact
(18220, 18220, 1),
(18220, 18937, 2),
(18220, 18938, 3),
(18220, 27265, 4),
(18220, 59092, 5),
 -- Darkness
(15259, 15259, 1),
(15259, 15307, 2),
(15259, 15308, 3),
(15259, 15309, 4),
(15259, 15310, 5),
 -- Dash
(1850, 1850, 1),
(1850, 9821, 2),
(1850, 33357, 3),
 -- Deadened Nerves
(31380, 31380, 1),
(31380, 31382, 2),
(31380, 31383, 3),
 -- Deadliness
(30902, 30902, 1),
(30902, 30903, 2),
(30902, 30904, 3),
(30902, 30905, 4),
(30902, 30906, 5),
 -- Deadly Brew
(51625, 51625, 1),
(51625, 51626, 2),
 -- Deadly Throw
(26679, 26679, 1),
(26679, 48673, 2),
(26679, 48674, 3),
 -- Death and Decay
(43265, 43265, 1),
(43265, 49936, 2),
(43265, 49937, 3),
(43265, 49938, 4),
 -- Death Coil
(6789, 6789, 1),
(6789, 17925, 2),
(6789, 17926, 3),
(6789, 27223, 4),
(6789, 47859, 5),
(6789, 47860, 6),
 -- Death Coil
(62900, 62900, 1),
(62900, 62901, 2),
(62900, 62902, 3),
(62900, 62903, 4),
(62900, 62904, 5),
 -- Death Strike
(49998, 49998, 1),
(49998, 49999, 2),
(49998, 45463, 3),
(49998, 49923, 4),
(49998, 49924, 5),
 -- Death's Embrace
(47198, 47198, 1),
(47198, 47199, 2),
(47198, 47200, 3),
 -- Decimation
(63156, 63156, 1),
(63156, 63158, 2),
 -- Deep Wounds
(12162, 12162, 1),
(12162, 12850, 2),
(12162, 12868, 3),
 -- Deep Wounds
(12834, 12834, 1),
(12834, 12849, 2),
(12834, 12867, 3),
 -- Defensive Tactics
(29559, 29559, 1),
(29559, 29588, 2),
(29559, 29589, 3),
 -- Defiance
(12303, 12303, 1),
(12303, 12788, 2),
(12303, 12789, 3),
 -- Deflection
(16462, 16462, 1),
(16462, 16463, 2),
(16462, 16464, 3),
(16462, 16465, 4),
(16462, 16466, 5),
 -- Deflection
(13713, 13713, 1),
(13713, 13853, 2),
(13713, 13854, 3),
 -- Deflection
(19295, 19295, 1),
(19295, 19297, 2),
(19295, 19298, 3),
 -- Deflection
(20060, 20060, 1),
(20060, 20061, 2),
(20060, 20062, 3),
(20060, 20063, 4),
(20060, 20064, 5),
 -- Demon Armor
(706, 706, 1),
(706, 1086, 2),
(706, 11733, 3),
(706, 11734, 4),
(706, 11735, 5),
(706, 27260, 6),
(706, 47793, 7),
(706, 47889, 8),
 -- Demon Skin
(687, 687, 1),
(687, 696, 2),
 -- Demonic Aegis
(30143, 30143, 1),
(30143, 30144, 2),
(30143, 30145, 3),
 -- Demonic Brutality
(18705, 18705, 1),
(18705, 18706, 2),
(18705, 18707, 3),
 -- Demonic Embrace
(18697, 18697, 1),
(18697, 18698, 2),
(18697, 18699, 3),
 -- Demonic Knowledge
(35691, 35691, 1),
(35691, 35692, 2),
(35691, 35693, 3),
 -- Demonic Pact
(47236, 47236, 1),
(47236, 47237, 2),
(47236, 47238, 3),
(47236, 47239, 4),
(47236, 47240, 5),
 -- Demonic Power
(18126, 18126, 1),
(18126, 18127, 2),
 -- Demonic Resilience
(30319, 30319, 1),
(30319, 30320, 2),
(30319, 30321, 3),
 -- Demonic Tactics
(30242, 30242, 1),
(30242, 30245, 2),
(30242, 30246, 3),
(30242, 30247, 4),
(30242, 30248, 5),
 -- Demoralizing Roar
(99, 99, 1),
(99, 1735, 2),
(99, 9490, 3),
(99, 9747, 4),
(99, 9898, 5),
(99, 26998, 6),
(99, 48559, 7),
(99, 48560, 8),
 -- Demoralizing Screech
(24424, 24424, 1),
(24424, 24580, 2),
(24424, 24581, 3),
(24424, 24582, 4),
(24424, 27349, 5),
 -- Demoralizing Screech
(24423, 24423, 1),
(24423, 24577, 2),
(24423, 24578, 3),
(24423, 24579, 4),
(24423, 27051, 5),
(24423, 55487, 6),
 -- Demoralizing Shout
(1160, 1160, 1),
(1160, 6190, 2),
(1160, 11554, 3),
(1160, 11555, 4),
(1160, 11556, 5),
(1160, 25202, 6),
(1160, 25203, 7),
(1160, 47437, 8),
 -- Desecration
(55666, 55666, 1),
(55666, 55667, 2),
 -- Desperate Prayer
(19236, 19236, 1),
(19236, 19238, 2),
(19236, 19240, 3),
(19236, 19241, 4),
(19236, 19242, 5),
(19236, 19243, 6),
(19236, 25437, 7),
(19236, 48172, 8),
(19236, 48173, 9),
 -- Destructive Reach
(17917, 17917, 1),
(17917, 17918, 2),
 -- Destructive Soul
(30251, 30251, 1),
(30251, 30256, 2),
 -- Devastate
(20243, 20243, 1),
(20243, 30016, 2),
(20243, 30022, 3),
(20243, 47497, 4),
(20243, 47498, 5),
 -- Devotion Aura
(465, 465, 1),
(465, 10290, 2),
(465, 643, 3),
(465, 10291, 4),
(465, 1032, 5),
(465, 10292, 6),
(465, 10293, 7),
(465, 27149, 8),
(465, 48941, 9),
(465, 48942, 10),
 -- Devour Magic
(19505, 19505, 1),
(19505, 19731, 2),
(19505, 19734, 3),
(19505, 19736, 4),
(19505, 27276, 5),
(19505, 27277, 6),
(19505, 48011, 7),
 -- Devouring Plague
(2944, 2944, 1),
(2944, 19276, 2),
(2944, 19277, 3),
(2944, 19278, 4),
(2944, 19279, 5),
(2944, 19280, 6),
(2944, 25467, 7),
(2944, 48299, 8),
(2944, 48300, 9),
 -- Dirge
(49223, 49223, 1),
(49223, 49599, 2),
 -- Dirty Deeds
(14082, 14082, 1),
(14082, 14083, 2),
 -- Dirty Tricks
(14076, 14076, 1),
(14076, 14094, 2),
 -- Dispel Magic
(527, 527, 1),
(527, 988, 2),
 -- Displacement
(34478, 34478, 1),
(34478, 34479, 2),
(34478, 34481, 3),
 -- Dive
(23146, 23146, 1),
(23146, 23149, 2),
(23146, 23150, 3),
 -- Divine Aegis
(47509, 47509, 1),
(47509, 47511, 2),
(47509, 47515, 3),
 -- Divine Fury
(18530, 18530, 1),
(18530, 18531, 2),
(18530, 18533, 3),
(18530, 18534, 4),
(18530, 18535, 5),
 -- Divine Guardian
(53527, 53527, 1),
(53527, 53530, 2),
 -- Divine Intellect
(20257, 20257, 1),
(20257, 20258, 2),
(20257, 20259, 3),
(20257, 20260, 4),
(20257, 20261, 5),
 -- Divine Providence
(47562, 47562, 1),
(47562, 47564, 2),
(47562, 47565, 3),
(47562, 47566, 4),
(47562, 47567, 5),
 -- Divine Purpose
(31871, 31871, 1),
(31871, 31872, 2),
 -- Divine Spirit
(14752, 14752, 1),
(14752, 14818, 2),
(14752, 14819, 3),
(14752, 27841, 4),
(14752, 25312, 5),
(14752, 48073, 6),
 -- Divine Strength
(20262, 20262, 1),
(20262, 20263, 2),
(20262, 20264, 3),
(20262, 20265, 4),
(20262, 20266, 5),
 -- Divinity
(63646, 63646, 1),
(63646, 63647, 2),
(63646, 63648, 3),
(63646, 63649, 4),
(63646, 63650, 5),
 -- Dragon's Breath
(31661, 31661, 1),
(31661, 33041, 2),
(31661, 33042, 3),
(31661, 33043, 4),
(31661, 42949, 5),
(31661, 42950, 6),
 -- Drain Life
(689, 689, 1),
(689, 699, 2),
(689, 709, 3),
(689, 7651, 4),
(689, 11699, 5),
(689, 11700, 6),
(689, 27219, 7),
(689, 27220, 8),
(689, 47857, 9),
 -- Drain Soul
(1120, 1120, 1),
(1120, 8288, 2),
(1120, 8289, 3),
(1120, 11675, 4),
(1120, 27217, 5),
(1120, 47855, 6),
 -- Dreamstate
(33597, 33597, 1),
(33597, 33599, 2),
(33597, 33956, 3),
 -- Dual Wield Specialization
(13715, 13715, 1),
(13715, 13848, 2),
(13715, 13849, 3),
(13715, 13851, 4),
(13715, 13852, 5),
 -- Dual Wield Specialization
(23584, 23584, 1),
(23584, 23585, 2),
(23584, 23586, 3),
(23584, 23587, 4),
(23584, 23588, 5),
 -- Dual Wield Specialization
(30816, 30816, 1),
(30816, 30818, 2),
(30816, 30819, 3),
 -- Earth and Moon
(48506, 48506, 1),
(48506, 48510, 2),
(48506, 48511, 3),
 -- Earth Shield
(974, 974, 1),
(974, 32593, 2),
(974, 32594, 3),
(974, 49283, 4),
(974, 49284, 5),
 -- Earth Shock
(8042, 8042, 1),
(8042, 8044, 2),
(8042, 8045, 3),
(8042, 8046, 4),
(8042, 10412, 5),
(8042, 10413, 6),
(8042, 10414, 7),
(8042, 25454, 8),
(8042, 49230, 9),
(8042, 49231, 10),
 -- Earthen Power
(51523, 51523, 1),
(51523, 51524, 2),
 -- Earthliving
(51945, 51945, 1),
(51945, 51990, 2),
(51945, 51997, 3),
(51945, 51998, 4),
(51945, 51999, 5),
(51945, 52000, 6),
 -- Earthliving Weapon
(51730, 51730, 1),
(51730, 51988, 2),
(51730, 51991, 3),
(51730, 51992, 4),
(51730, 51993, 5),
(51730, 51994, 6),
 -- Earthliving Weapon (Passive)
(51940, 51940, 1),
(51940, 51989, 2),
(51940, 52004, 3),
(51940, 52005, 4),
(51940, 52007, 5),
(51940, 52008, 6),
 -- Earth's Grasp
(16043, 16043, 1),
(16043, 16130, 2),
 -- Ebon Plaguebringer
(51099, 51099, 1),
(51099, 51160, 2),
(51099, 51161, 3),
 -- Eclipse
(48516, 48516, 1),
(48516, 48521, 2),
(48516, 48525, 3),
 -- Efficiency
(19416, 19416, 1),
(19416, 19417, 2),
(19416, 19418, 3),
(19416, 19419, 4),
(19416, 19420, 5),
 -- Elemental Absorption
(30701, 30701, 1),
(30701, 30702, 2),
(30701, 30703, 3),
(30701, 30704, 4),
(30701, 30705, 5),
 -- Elemental Oath
(51466, 51466, 1),
(51466, 51470, 2),
 -- Elemental Precision
(30672, 30672, 1),
(30672, 30673, 2),
(30672, 30674, 3),
 -- Elemental Reach
(28999, 28999, 1),
(28999, 29000, 2),
 -- Elemental Shields
(30669, 30669, 1),
(30669, 30670, 2),
(30669, 30671, 3),
 -- Elemental Warding
(28996, 28996, 1),
(28996, 28997, 2),
(28996, 28998, 3),
 -- Elemental Weapons
(16266, 16266, 1),
(16266, 29079, 2),
(16266, 29080, 3),
 -- Elusiveness
(13981, 13981, 1),
(13981, 14066, 2),
 -- Emberstorm
(17954, 17954, 1),
(17954, 17955, 2),
(17954, 17956, 3),
(17954, 17957, 4),
(17954, 17958, 5),
 -- Empowered Corruption
(32381, 32381, 1),
(32381, 32382, 2),
(32381, 32383, 3),
 -- Empowered Fire
(31656, 31656, 1),
(31656, 31657, 2),
(31656, 31658, 3),
 -- Empowered Frostbolt
(31682, 31682, 1),
(31682, 31683, 2),
 -- Empowered Healing
(33158, 33158, 1),
(33158, 33159, 2),
(33158, 33160, 3),
(33158, 33161, 4),
(33158, 33162, 5),
 -- Empowered Imp
(47220, 47220, 1),
(47220, 47221, 2),
(47220, 47223, 3),
 -- Empowered Rejuvenation
(33886, 33886, 1),
(33886, 33887, 2),
(33886, 33888, 3),
(33886, 33889, 4),
(33886, 33890, 5),
 -- Empowered Renew
(63534, 63534, 1),
(63534, 63542, 2),
(63534, 63543, 3),
 -- Empowered Touch
(33879, 33879, 1),
(33879, 33880, 2),
 -- Enchanting
(7411, 7411, 1),
(7411, 7412, 2),
(7411, 7413, 3),
(7411, 13920, 4),
(7411, 28029, 5),
(7411, 51313, 6),
 -- Endless Winter
(49137, 49137, 1),
(49137, 49657, 2),
 -- Endurance
(13742, 13742, 1),
(13742, 13872, 2),
 -- Endurance Training
(19583, 19583, 1),
(19583, 19584, 2),
(19583, 19585, 3),
(19583, 19586, 4),
(19583, 19587, 5),
 -- Enduring Winter
(44557, 44557, 1),
(44557, 44560, 2),
(44557, 44561, 3),
 -- Engineering
(4036, 4036, 1),
(4036, 4037, 2),
(4036, 4038, 3),
(4036, 12656, 4),
(4036, 30350, 5),
(4036, 51306, 6),
 -- Enhancing Totems
(16259, 16259, 1),
(16259, 16295, 2),
(16259, 52456, 3),
 -- Enlightened Judgements
(53556, 53556, 1),
(53556, 53557, 2),
 -- Enlightenment
(34908, 34908, 1),
(34908, 34909, 2),
(34908, 34910, 3),
 -- Enrage
(12317, 12317, 1),
(12317, 13045, 2),
(12317, 13046, 3),
(12317, 13047, 4),
(12317, 13048, 5),
 -- Enslave Demon
(1098, 1098, 1),
(1098, 11725, 2),
(1098, 11726, 3),
(1098, 61191, 4),
 -- Entangling Roots
(339, 339, 1),
(339, 1062, 2),
(339, 5195, 3),
(339, 5196, 4),
(339, 9852, 5),
(339, 9853, 6),
(339, 26989, 7),
(339, 53308, 8),
 -- Entrapment
(19184, 19184, 1),
(19184, 19387, 2),
(19184, 19388, 3),
 -- Enveloping Shadows
(31211, 31211, 1),
(31211, 31212, 2),
(31211, 31213, 3),
 -- Envenom
(32645, 32645, 1),
(32645, 32684, 2),
(32645, 57992, 3),
(32645, 57993, 4),
 -- Epidemic
(49036, 49036, 1),
(49036, 49562, 2),
 -- Eradication
(47195, 47195, 1),
(47195, 47196, 2),
(47195, 47197, 3),
 -- Evasion
(5277, 5277, 1),
(5277, 26669, 2),
 -- Everlasting Affliction
(47201, 47201, 1),
(47201, 47202, 2),
(47201, 47203, 3),
(47201, 47204, 4),
(47201, 47205, 5),
 -- Eviscerate
(2098, 2098, 1),
(2098, 6760, 2),
(2098, 6761, 3),
(2098, 6762, 4),
(2098, 8623, 5),
(2098, 8624, 6),
(2098, 11299, 7),
(2098, 11300, 8),
(2098, 31016, 9),
(2098, 26865, 10),
(2098, 48667, 11),
(2098, 48668, 12),
 -- Execute
(5308, 5308, 1),
(5308, 20658, 2),
(5308, 20660, 3),
(5308, 20661, 4),
(5308, 20662, 5),
(5308, 25234, 6),
(5308, 25236, 7),
(5308, 47470, 8),
(5308, 47471, 9),
 -- Exorcism
(879, 879, 1),
(879, 5614, 2),
(879, 5615, 3),
(879, 10312, 4),
(879, 10313, 5),
(879, 10314, 6),
(879, 27138, 7),
(879, 48800, 8),
(879, 48801, 9),
 -- Explosive Shot
(53301, 53301, 1),
(53301, 60051, 2),
(53301, 60052, 3),
(53301, 60053, 4),
 -- Explosive Trap
(13813, 13813, 1),
(13813, 14316, 2),
(13813, 14317, 3),
(13813, 27025, 4),
(13813, 49066, 5),
(13813, 49067, 6),
 -- Explosive Trap Effect
(13812, 13812, 1),
(13812, 14314, 2),
(13812, 14315, 3),
(13812, 27026, 4),
(13812, 49064, 5),
(13812, 49065, 6),
 -- Expose Weakness
(34500, 34500, 1),
(34500, 34502, 2),
(34500, 34503, 3),
 -- Eye of the Storm
(29062, 29062, 1),
(29062, 29064, 2),
(29062, 29065, 3),
 -- Faerie Fire
(13424, 13424, 1),
(13424, 13752, 2),
 -- Fanaticism
(31879, 31879, 1),
(31879, 31880, 2),
(31879, 31881, 3),
 -- Fear
(5782, 5782, 1),
(5782, 6213, 2),
(5782, 6215, 3),
 -- Feeding Frenzy
(60096, 60096, 1),
(60096, 60097, 2),
 -- Feeding Frenzy
(53511, 53511, 1),
(53511, 53512, 2),
 -- Feint
(1966, 1966, 1),
(1966, 6768, 2),
(1966, 8637, 3),
(1966, 11303, 4),
(1966, 25302, 5),
(1966, 27448, 6),
(1966, 48658, 7),
(1966, 48659, 8),
 -- Fel Armor
(28176, 28176, 1),
(28176, 28189, 2),
(28176, 47892, 3),
(28176, 47893, 4),
 -- Fel Concentration
(17783, 17783, 1),
(17783, 17784, 2),
(17783, 17785, 3),
 -- Fel Intelligence
(54424, 54424, 1),
(54424, 57564, 2),
(54424, 57565, 3),
(54424, 57566, 4),
(54424, 57567, 5),
 -- Fel Synergy
(47230, 47230, 1),
(47230, 47231, 2),
 -- Fel Vitality
(18731, 18731, 1),
(18731, 18743, 2),
(18731, 18744, 3),
 -- Feral Aggression
(16858, 16858, 1),
(16858, 16859, 2),
(16858, 16860, 3),
(16858, 16861, 4),
(16858, 16862, 5),
 -- Feral Instinct
(16947, 16947, 1),
(16947, 16948, 2),
(16947, 16949, 3),
 -- Ferocious Bite
(22568, 22568, 1),
(22568, 22827, 2),
(22568, 22828, 3),
(22568, 22829, 4),
(22568, 31018, 5),
(22568, 24248, 6),
(22568, 48576, 7),
(22568, 48577, 8),
 -- Ferocious Dead
(49038, 49038, 1),
(49038, 49595, 2),
(49038, 49596, 3),
 -- Ferocious Inspiration
(34455, 34455, 1),
(34455, 34459, 2),
(34455, 34460, 3),
 -- Ferocity
(19598, 19598, 1),
(19598, 19599, 2),
(19598, 19600, 3),
(19598, 19601, 4),
(19598, 19602, 5),
 -- Ferocity
(16934, 16934, 1),
(16934, 16935, 2),
(16934, 16936, 3),
(16934, 16937, 4),
(16934, 16938, 5),
 -- Filthy Tricks
(58414, 58414, 1),
(58414, 58415, 2),
 -- Find Weakness
(31234, 31234, 1),
(31234, 31235, 2),
(31234, 31236, 3),
 -- Fingers of Frost
(44543, 44543, 1),
(44543, 44545, 2),
 -- Fire and Brimstone
(47266, 47266, 1),
(47266, 47267, 2),
(47266, 47268, 3),
(47266, 47269, 4),
(47266, 47270, 5),
 -- Fire Blast
(2141, 2141, 1),
(2141, 2142, 2),
(2141, 2143, 3),
(2141, 8414, 4),
(2141, 8415, 5),
(2141, 10198, 6),
(2141, 10200, 7),
(2141, 27378, 8),
(2141, 27379, 9),
 -- Fire Blast
(2136, 2136, 1),
(2136, 2137, 2),
(2136, 2138, 3),
(2136, 8412, 4),
(2136, 8413, 5),
(2136, 10197, 6),
(2136, 10199, 7),
(2136, 27078, 8),
(2136, 27079, 9),
(2136, 42872, 10),
(2136, 42873, 11),
 -- Fire Breath
(34889, 34889, 1),
(34889, 35323, 2),
(34889, 55482, 3),
(34889, 55483, 4),
(34889, 55484, 5),
(34889, 55485, 6),
 -- Fire Power
(11124, 11124, 1),
(11124, 12378, 2),
(11124, 12398, 3),
(11124, 12399, 4),
(11124, 12400, 5),
 -- Fire Resistance Aura
(19891, 19891, 1),
(19891, 19899, 2),
(19891, 19900, 3),
(19891, 27153, 4),
(19891, 48947, 5),
 -- Fire Resistance Totem
(8184, 8184, 1),
(8184, 10537, 2),
(8184, 10538, 3),
(8184, 25563, 4),
(8184, 58737, 5),
(8184, 58739, 6),
 -- Fire Shield
(2947, 2947, 1),
(2947, 8316, 2),
(2947, 8317, 3),
(2947, 11770, 4),
(2947, 11771, 5),
(2947, 27269, 6),
(2947, 47983, 7),
 -- Fire Shot
(3011, 3011, 1),
(3011, 6979, 2),
(3011, 6980, 3),
 -- Fire Ward
(1035, 1035, 1),
(1035, 8459, 2),
(1035, 8460, 3),
(1035, 10224, 4),
(1035, 10226, 5),
(1035, 27395, 6),
 -- Fire Ward
(543, 543, 1),
(543, 8457, 2),
(543, 8458, 3),
(543, 10223, 4),
(543, 10225, 5),
(543, 27128, 6),
(543, 43010, 7),
 -- Fireball
(133, 133, 1),
(133, 143, 2),
(133, 145, 3),
(133, 3140, 4),
(133, 8400, 5),
(133, 8401, 6),
(133, 8402, 7),
(133, 10148, 8),
(133, 10149, 9),
(133, 10150, 10),
(133, 10151, 11),
(133, 25306, 12),
(133, 27070, 13),
(133, 38692, 14),
(133, 42832, 15),
(133, 42833, 16),
 -- Firebolt
(3110, 3110, 1),
(3110, 7799, 2),
(3110, 7800, 3),
(3110, 7801, 4),
(3110, 7802, 5),
(3110, 11762, 6),
(3110, 11763, 7),
(3110, 27267, 8),
(3110, 47964, 9),
 -- Firestarter
(44442, 44442, 1),
(44442, 44443, 2),
 -- First Aid
(3273, 3273, 1),
(3273, 3274, 2),
(3273, 7924, 3),
(3273, 10846, 4),
(3273, 27028, 5),
(3273, 45542, 6),
 -- Flame Shock
(8050, 8050, 1),
(8050, 8052, 2),
(8050, 8053, 3),
(8050, 10447, 4),
(8050, 10448, 5),
(8050, 29228, 6),
(8050, 25457, 7),
(8050, 49232, 8),
(8050, 49233, 9),
 -- Flame Throwing
(11100, 11100, 1),
(11100, 12353, 2),
 -- Flamestrike
(2120, 2120, 1),
(2120, 2121, 2),
(2120, 8422, 3),
(2120, 8423, 4),
(2120, 10215, 5),
(2120, 10216, 6),
(2120, 27086, 7),
(2120, 42925, 8),
(2120, 42926, 9),
 -- Flametongue Totem
(52109, 52109, 1),
(52109, 52110, 2),
(52109, 52111, 3),
(52109, 52112, 4),
(52109, 52113, 5),
(52109, 58651, 6),
(52109, 58654, 7),
(52109, 58655, 8),
 -- Flametongue Totem
(8227, 8227, 1),
(8227, 8249, 2),
(8227, 10526, 3),
(8227, 16387, 4),
(8227, 25557, 5),
(8227, 58649, 6),
(8227, 58652, 7),
(8227, 58656, 8),
 -- Flametongue Weapon
(8024, 8024, 1),
(8024, 8027, 2),
(8024, 8030, 3),
(8024, 16339, 4),
(8024, 16341, 5),
(8024, 16342, 6),
(8024, 25489, 7),
(8024, 58785, 8),
(8024, 58789, 9),
(8024, 58790, 10),
 -- Flametongue Weapon (Passive)
(10400, 10400, 1),
(10400, 15567, 2),
(10400, 15568, 3),
(10400, 15569, 4),
(10400, 16311, 5),
(10400, 16312, 6),
(10400, 16313, 7),
(10400, 58784, 8),
(10400, 58791, 9),
(10400, 58792, 10),
 -- Flametongue Weapon Proc
(8026, 8026, 1),
(8026, 8028, 2),
(8026, 8029, 3),
(8026, 10445, 4),
(8026, 16343, 5),
(8026, 16344, 6),
(8026, 25488, 7),
(8026, 58786, 8),
(8026, 58787, 9),
(8026, 58788, 10),
 -- Flash Heal
(2061, 2061, 1),
(2061, 9472, 2),
(2061, 9473, 3),
(2061, 9474, 4),
(2061, 10915, 5),
(2061, 10916, 6),
(2061, 10917, 7),
(2061, 25233, 8),
(2061, 25235, 9),
(2061, 48070, 10),
(2061, 48071, 11),
 -- Flash of Light
(19750, 19750, 1),
(19750, 19939, 2),
(19750, 19940, 3),
(19750, 19941, 4),
(19750, 19942, 5),
(19750, 19943, 6),
(19750, 27137, 7),
(19750, 48784, 8),
(19750, 48785, 9),
 -- Fleet Footed
(31208, 31208, 1),
(31208, 31209, 2),
 -- Flurry
(16257, 16257, 1),
(16257, 16277, 2),
(16257, 16278, 3),
(16257, 16279, 4),
(16257, 16280, 5),
 -- Flurry
(16256, 16256, 1),
(16256, 16281, 2),
(16256, 16282, 3),
(16256, 16283, 4),
(16256, 16284, 5),
 -- Focused Aim
(53620, 53620, 1),
(53620, 53621, 2),
(53620, 53622, 3),
 -- Focused Attacks
(51634, 51634, 1),
(51634, 51635, 2),
(51634, 51636, 3),
 -- Focused Casting
(14743, 14743, 1),
(14743, 27828, 2),
 -- Focused Fire
(35060, 35060, 1),
(35060, 35061, 2),
 -- Focused Fire
(35029, 35029, 1),
(35029, 35030, 2),
 -- Focused Mind
(33213, 33213, 1),
(33213, 33214, 2),
(33213, 33215, 3),
 -- Focused Mind
(30864, 30864, 1),
(30864, 30865, 2),
(30864, 30866, 3),
 -- Focused Power
(33186, 33186, 1),
(33186, 33190, 2),
 -- Focused Rage
(29787, 29787, 1),
(29787, 29790, 2),
(29787, 29792, 3),
 -- Freezing Trap
(1499, 1499, 1),
(1499, 14310, 2),
(1499, 14311, 3),
 -- Freezing Trap Effect
(3355, 3355, 1),
(3355, 14308, 2),
(3355, 14309, 3),
 -- Frenzy
(19621, 19621, 1),
(19621, 19622, 2),
(19621, 19623, 3),
(19621, 19624, 4),
(19621, 19625, 5),
 -- Frigid Dreadplate
(49186, 49186, 1),
(49186, 51108, 2),
(49186, 51109, 3),
 -- Frost Armor
(168, 168, 1),
(168, 7300, 2),
(168, 7301, 3),
 -- Frost Channeling
(11160, 11160, 1),
(11160, 12518, 2),
(11160, 12519, 3),
 -- Frost Nova
(122, 122, 1),
(122, 865, 2),
(122, 6131, 3),
(122, 10230, 4),
(122, 27088, 5),
(122, 42917, 6),
 -- Frost Resistance Aura
(19888, 19888, 1),
(19888, 19897, 2),
(19888, 19898, 3),
(19888, 27152, 4),
(19888, 48945, 5),
 -- Frost Resistance Totem
(8181, 8181, 1),
(8181, 10478, 2),
(8181, 10479, 3),
(8181, 25560, 4),
(8181, 58741, 5),
(8181, 58745, 6),
 -- Frost Shock
(8056, 8056, 1),
(8056, 8058, 2),
(8056, 10472, 3),
(8056, 10473, 4),
(8056, 25464, 5),
(8056, 49235, 6),
(8056, 49236, 7),
 -- Frost Ward
(6144, 6144, 1),
(6144, 8463, 2),
(6144, 8464, 3),
(6144, 10178, 4),
(6144, 27396, 5),
(6144, 32797, 6),
 -- Frost Ward
(6143, 6143, 1),
(6143, 8461, 2),
(6143, 8462, 3),
(6143, 10177, 4),
(6143, 28609, 5),
(6143, 32796, 6),
(6143, 43012, 7),
 -- Frost Warding
(11189, 11189, 1),
(11189, 28332, 2),
 -- Frostbite
(11071, 11071, 1),
(11071, 12496, 2),
(11071, 12497, 3),
 -- Frostbolt
(116, 116, 1),
(116, 205, 2),
(116, 837, 3),
(116, 7322, 4),
(116, 8406, 5),
(116, 8407, 6),
(116, 8408, 7),
(116, 10179, 8),
(116, 10180, 9),
(116, 10181, 10),
(116, 25304, 11),
(116, 27071, 12),
(116, 27072, 13),
(116, 38697, 14),
(116, 42841, 15),
(116, 42842, 16),
 -- Frostbrand Weapon
(8033, 8033, 1),
(8033, 8038, 2),
(8033, 10456, 3),
(8033, 16355, 4),
(8033, 16356, 5),
(8033, 25500, 6),
(8033, 58794, 7),
(8033, 58795, 8),
(8033, 58796, 9),
 -- Frostfire Bolt
(44614, 44614, 1),
(44614, 47610, 2),
 -- Froststorm Breath
(54644, 54644, 1),
(54644, 55488, 2),
(54644, 55489, 3),
(54644, 55490, 4),
(54644, 55491, 5),
(54644, 55492, 6),
 -- Frozen Core
(31667, 31667, 1),
(31667, 31668, 2),
(31667, 31669, 3),
 -- Frozen Power
(63373, 63373, 1),
(63373, 63374, 2),
 -- Furious Attacks
(46910, 46910, 1),
(46910, 46911, 2),
 -- Furious Howl
(24604, 24604, 1),
(24604, 64491, 2),
(24604, 64492, 3),
(24604, 64493, 4),
(24604, 64494, 5),
(24604, 64495, 6),
 -- Furor
(17056, 17056, 1),
(17056, 17058, 2),
(17056, 17059, 3),
(17056, 17060, 4),
(17056, 17061, 5),
 -- Gag Order
(12311, 12311, 1),
(12311, 12958, 2),
 -- Gale Winds
(48488, 48488, 1),
(48488, 48514, 2),
 -- Garrote
(703, 703, 1),
(703, 8631, 2),
(703, 8632, 3),
(703, 8633, 4),
(703, 11289, 5),
(703, 11290, 6),
(703, 26839, 7),
(703, 26884, 8),
(703, 48675, 9),
(703, 48676, 10),
 -- Genesis
(57810, 57810, 1),
(57810, 57811, 2),
(57810, 57812, 3),
(57810, 57813, 4),
(57810, 57814, 5),
 -- Gift of Nature
(17104, 17104, 1),
(17104, 24943, 2),
(17104, 24944, 3),
(17104, 24945, 4),
(17104, 24946, 5),
 -- Gift of the Earthmother
(51179, 51179, 1),
(51179, 51180, 2),
(51179, 51181, 3),
(51179, 51182, 4),
(51179, 51183, 5),
 -- Gift of the Wild
(21849, 21849, 1),
(21849, 21850, 2),
(21849, 26991, 3),
(21849, 48470, 4),
 -- Glacier Rot
(49471, 49471, 1),
(49471, 49790, 2),
(49471, 49791, 3),
 -- Go for the Throat
(34952, 34952, 1),
(34952, 34953, 2),
 -- Go for the Throat
(34950, 34950, 1),
(34950, 34954, 2),
 -- Gore
(35299, 35299, 1),
(35299, 35300, 2),
(35299, 35302, 3),
(35299, 35303, 4),
(35299, 35304, 5),
(35299, 35305, 6),
(35299, 35306, 7),
(35299, 35307, 8),
(35299, 35308, 9),
 -- Gore
(35290, 35290, 1),
(35290, 35291, 2),
(35290, 35292, 3),
(35290, 35293, 4),
(35290, 35294, 5),
(35290, 35295, 6),
 -- Grace
(47516, 47516, 1),
(47516, 47517, 2),
 -- Grace of the Mantis
(53450, 53450, 1),
(53450, 53451, 2),
 -- Great Resistance
(53427, 53427, 1),
(53427, 53429, 2),
(53427, 53430, 3),
 -- Great Stamina
(4195, 4195, 1),
(4195, 4196, 2),
(4195, 4197, 3),
(4195, 4198, 4),
(4195, 4199, 5),
(4195, 4200, 6),
(4195, 4201, 7),
(4195, 4202, 8),
(4195, 5048, 9),
(4195, 5049, 10),
(4195, 27364, 11),
 -- Great Stamina
(61686, 61686, 1),
(61686, 61687, 2),
(61686, 61688, 3),
 -- Greater Blessing of Might
(25782, 25782, 1),
(25782, 25916, 2),
(25782, 27141, 3),
(25782, 48933, 4),
(25782, 48934, 5),
 -- Greater Blessing of Wisdom
(25894, 25894, 1),
(25894, 25918, 2),
(25894, 27143, 3),
(25894, 48937, 4),
(25894, 48938, 5),
 -- Greater Heal
(2060, 2060, 1),
(2060, 10963, 2),
(2060, 10964, 3),
(2060, 10965, 4),
(2060, 25314, 5),
(2060, 25210, 6),
(2060, 25213, 7),
(2060, 48062, 8),
(2060, 48063, 9),
 -- Grim Reach
(18218, 18218, 1),
(18218, 18219, 2),
 -- Growl
(1853, 1853, 1),
(1853, 14922, 2),
(1853, 14923, 3),
(1853, 14924, 4),
(1853, 14925, 5),
(1853, 14926, 6),
(1853, 14927, 7),
(1853, 27344, 8),
 -- Growl
(2649, 2649, 1),
(2649, 14916, 2),
(2649, 14917, 3),
(2649, 14918, 4),
(2649, 14919, 5),
(2649, 14920, 6),
(2649, 14921, 7),
(2649, 27047, 8),
(2649, 61676, 9),
 -- Guard Dog
(53178, 53178, 1),
(53178, 53179, 2),
 -- Guarded by the Light
(53583, 53583, 1),
(53583, 53585, 2),
 -- Guardian Totems
(16258, 16258, 1),
(16258, 16293, 2),
 -- Guardian's Favor
(20174, 20174, 1),
(20174, 20175, 2),
 -- Guile of Gorefiend
(50187, 50187, 1),
(50187, 50190, 2),
(50187, 50191, 3),
 -- Hack and Slash
(13960, 13960, 1),
(13960, 13961, 2),
(13960, 13962, 3),
(13960, 13963, 4),
(13960, 13964, 5),
 -- Hammer of Justice
(853, 853, 1),
(853, 5588, 2),
(853, 5589, 3),
(853, 10308, 4),
 -- Hammer of Wrath
(24275, 24275, 1),
(24275, 24274, 2),
(24275, 24239, 3),
(24275, 27180, 4),
(24275, 48805, 5),
(24275, 48806, 6),
 -- Hand of Protection
(1022, 1022, 1),
(1022, 5599, 2),
(1022, 10278, 3),
 -- Haunt
(48181, 48181, 1),
(48181, 59161, 2),
(48181, 59163, 3),
(48181, 59164, 4),
 -- Hawk Eye
(19498, 19498, 1),
(19498, 19499, 2),
(19498, 19500, 3),
 -- Heal
(2054, 2054, 1),
(2054, 2055, 2),
(2054, 6063, 3),
(2054, 6064, 4),
 -- Healing Focus
(14913, 14913, 1),
(14913, 15012, 2),
 -- Healing Focus
(16181, 16181, 1),
(16181, 16230, 2),
(16181, 16232, 3),
 -- Healing Grace
(29187, 29187, 1),
(29187, 29189, 2),
(29187, 29191, 3),
 -- Healing Light
(20237, 20237, 1),
(20237, 20238, 2),
(20237, 20239, 3),
 -- Healing Prayers
(14911, 14911, 1),
(14911, 15018, 2),
 -- Healing Stream Totem
(5394, 5394, 1),
(5394, 6375, 2),
(5394, 6377, 3),
(5394, 10462, 4),
(5394, 10463, 5),
(5394, 25567, 6),
(5394, 58755, 7),
(5394, 58756, 8),
(5394, 58757, 9),
 -- Healing Touch
(5185, 5185, 1),
(5185, 5186, 2),
(5185, 5187, 3),
(5185, 5188, 4),
(5185, 5189, 5),
(5185, 6778, 6),
(5185, 8903, 7),
(5185, 9758, 8),
(5185, 9888, 9),
(5185, 9889, 10),
(5185, 25297, 11),
(5185, 26978, 12),
(5185, 26979, 13),
(5185, 48377, 14),
(5185, 48378, 15),
 -- Healing Wave
(331, 331, 1),
(331, 332, 2),
(331, 547, 3),
(331, 913, 4),
(331, 939, 5),
(331, 959, 6),
(331, 8005, 7),
(331, 10395, 8),
(331, 10396, 9),
(331, 25357, 10),
(331, 25391, 11),
(331, 25396, 12),
(331, 49272, 13),
(331, 49273, 14),
 -- Healing Way
(29206, 29206, 1),
(29206, 29205, 2),
(29206, 29202, 3),
 -- Health Funnel
(755, 755, 1),
(755, 3698, 2),
(755, 3699, 3),
(755, 3700, 4),
(755, 11693, 5),
(755, 11694, 6),
(755, 11695, 7),
(755, 27259, 8),
(755, 47856, 9),
 -- Heart of the Crusader
(21183, 21183, 1),
(21183, 54498, 2),
(21183, 54499, 3),
 -- Heart of the Crusader
(20335, 20335, 1),
(20335, 20336, 2),
(20335, 20337, 3),
 -- Heart of the Wild
(17003, 17003, 1),
(17003, 17004, 2),
(17003, 17005, 3),
(17003, 17006, 4),
(17003, 24894, 5),
 -- Heart Strike
(55050, 55050, 1),
(55050, 55258, 2),
(55050, 55259, 3),
(55050, 55260, 4),
(55050, 55261, 5),
(55050, 55262, 6),
 -- Heightened Senses
(30894, 30894, 1),
(30894, 30895, 2),
 -- Hellfire
(1949, 1949, 1),
(1949, 11683, 2),
(1949, 11684, 3),
(1949, 27213, 4),
(1949, 47823, 5),
 -- Hellfire Effect
(5857, 5857, 1),
(5857, 11681, 2),
(5857, 11682, 3),
(5857, 27214, 4),
(5857, 47822, 5),
 -- Hemorrhage
(16511, 16511, 1),
(16511, 17347, 2),
(16511, 17348, 3),
(16511, 26864, 4),
(16511, 48660, 5),
 -- Herb Gathering
(2366, 2366, 1),
(2366, 2368, 2),
(2366, 3570, 3),
(2366, 11993, 4),
(2366, 28695, 5),
(2366, 50300, 6),
 -- Heroic Strike
(78, 78, 1),
(78, 284, 2),
(78, 285, 3),
(78, 1608, 4),
(78, 11564, 5),
(78, 11565, 6),
(78, 11566, 7),
(78, 11567, 8),
(78, 25286, 9),
(78, 29707, 10),
(78, 30324, 11),
(78, 47449, 12),
(78, 47450, 13),
 -- Hibernate
(2637, 2637, 1),
(2637, 18657, 2),
(2637, 18658, 3),
 -- Holy Concentration
(34753, 34753, 1),
(34753, 34859, 2),
(34753, 34860, 3),
 -- Holy Fire
(14914, 14914, 1),
(14914, 15262, 2),
(14914, 15263, 3),
(14914, 15264, 4),
(14914, 15265, 5),
(14914, 15266, 6),
(14914, 15267, 7),
(14914, 15261, 8),
(14914, 25384, 9),
(14914, 48134, 10),
(14914, 48135, 11),
 -- Holy Guidance
(31837, 31837, 1),
(31837, 31838, 2),
(31837, 31839, 3),
(31837, 31840, 4),
(31837, 31841, 5),
 -- Holy Light
(635, 635, 1),
(635, 639, 2),
(635, 647, 3),
(635, 1026, 4),
(635, 1042, 5),
(635, 3472, 6),
(635, 10328, 7),
(635, 10329, 8),
(635, 25292, 9),
(635, 27135, 10),
(635, 27136, 11),
(635, 48781, 12),
(635, 48782, 13),
 -- Holy Power
(5923, 5923, 1),
(5923, 5924, 2),
(5923, 5925, 3),
(5923, 5926, 4),
(5923, 25829, 5),
 -- Holy Reach
(27789, 27789, 1),
(27789, 27790, 2),
 -- Holy Shield
(20925, 20925, 1),
(20925, 20927, 2),
(20925, 20928, 3),
(20925, 27179, 4),
(20925, 48951, 5),
(20925, 48952, 6),
 -- Holy Specialization
(14889, 14889, 1),
(14889, 15008, 2),
(14889, 15009, 3),
(14889, 15010, 4),
(14889, 15011, 5),
 -- Holy Wrath
(2812, 2812, 1),
(2812, 10318, 2),
(2812, 27139, 3),
(2812, 48816, 4),
(2812, 48817, 5),
 -- Honor Among Thieves
(51698, 51698, 1),
(51698, 51700, 2),
(51698, 51701, 3),
 -- Horn of Winter
(57330, 57330, 1),
(57330, 57623, 2),
 -- Hot Streak
(44445, 44445, 1),
(44445, 44446, 2),
(44445, 44448, 3),
 -- Howl of Terror
(5484, 5484, 1),
(5484, 17928, 2),
 -- Howling Blast
(49184, 49184, 1),
(49184, 51409, 2),
(49184, 51410, 3),
(49184, 51411, 4),
 -- Hunter vs. Wild
(56339, 56339, 1),
(56339, 56340, 2),
(56339, 56341, 3),
 -- Hunter's Mark
(1130, 1130, 1),
(1130, 14323, 2),
(1130, 14324, 3),
(1130, 14325, 4),
(1130, 53338, 5),
 -- Hunting Party
(53290, 53290, 1),
(53290, 53291, 2),
(53290, 53292, 3),
 -- Ice Armor
(1214, 1214, 1),
(1214, 1228, 2),
(1214, 10221, 3),
(1214, 10222, 4),
(1214, 27391, 5),
 -- Ice Armor
(7302, 7302, 1),
(7302, 7320, 2),
(7302, 10219, 3),
(7302, 10220, 4),
(7302, 27124, 5),
(7302, 43008, 6),
 -- Ice Barrier
(11426, 11426, 1),
(11426, 13031, 2),
(11426, 13032, 3),
(11426, 13033, 4),
(11426, 27134, 5),
(11426, 33405, 6),
(11426, 43038, 7),
(11426, 43039, 8),
 -- Ice Floes
(31670, 31670, 1),
(31670, 31672, 2),
(31670, 55094, 3),
 -- Ice Lance
(30455, 30455, 1),
(30455, 42913, 2),
(30455, 42914, 3),
 -- Ice Shards
(11207, 11207, 1),
(11207, 12672, 2),
(11207, 15047, 3),
 -- Icy Reach
(55061, 55061, 1),
(55061, 55062, 2),
 -- Icy Talons
(50880, 50880, 1),
(50880, 50884, 2),
(50880, 50885, 3),
(50880, 50886, 4),
(50880, 50887, 5),
 -- Ignite
(11119, 11119, 1),
(11119, 11120, 2),
(11119, 12846, 3),
(11119, 12847, 4),
(11119, 12848, 5),
 -- Illumination
(20210, 20210, 1),
(20210, 20212, 2),
(20210, 20213, 3),
(20210, 20214, 4),
(20210, 20215, 5),
 -- Immolate
(348, 348, 1),
(348, 707, 2),
(348, 1094, 3),
(348, 2941, 4),
(348, 11665, 5),
(348, 11667, 6),
(348, 11668, 7),
(348, 25309, 8),
(348, 27215, 9),
(348, 47810, 10),
(348, 47811, 11),
 -- Impale
(16493, 16493, 1),
(16493, 16494, 2),
 -- Improved Ambush
(14079, 14079, 1),
(14079, 14080, 2),
 -- Improved Arcane Shot
(19454, 19454, 1),
(19454, 19455, 2),
(19454, 19456, 3),
 -- Improved Aspect of the Hawk
(19552, 19552, 1),
(19552, 19553, 2),
(19552, 19554, 3),
(19552, 19555, 4),
(19552, 19556, 5),
 -- Improved Aspect of the Monkey
(19549, 19549, 1),
(19549, 19550, 2),
(19549, 19551, 3),
 -- Improved Barkskin
(63410, 63410, 1),
(63410, 63411, 2),
 -- Improved Barrage
(35104, 35104, 1),
(35104, 35110, 2),
(35104, 35111, 3),
 -- Improved Berserker Rage
(20500, 20500, 1),
(20500, 20501, 2),
 -- Improved Berserker Stance
(29759, 29759, 1),
(29759, 29760, 2),
(29759, 29761, 3),
(29759, 29762, 4),
(29759, 29763, 5),
 -- Improved Blessing of Might
(20042, 20042, 1),
(20042, 20045, 2),
 -- Improved Blessing of Salvation
(20194, 20194, 1),
(20194, 20195, 2),
 -- Improved Blessing of Wisdom
(20244, 20244, 1),
(20244, 20245, 2),
 -- Improved Blink
(31569, 31569, 1),
(31569, 31570, 2),
 -- Improved Blizzard
(11185, 11185, 1),
(11185, 12487, 2),
(11185, 12488, 3),
 -- Improved Blood Presence
(50365, 50365, 1),
(50365, 50371, 2),
 -- Improved Bloodrage
(12301, 12301, 1),
(12301, 12818, 2),
 -- Improved Chain Heal
(30872, 30872, 1),
(30872, 30873, 2),
 -- Improved Challenging Shout
(12327, 12327, 1),
(12327, 12886, 2),
 -- Improved Charge
(12285, 12285, 1),
(12285, 12697, 2),
 -- Improved Cleave
(12329, 12329, 1),
(12329, 12950, 2),
(12329, 20496, 3),
 -- Improved Concentration Aura
(20254, 20254, 1),
(20254, 20255, 2),
(20254, 20256, 3),
 -- Improved Concussive Shot
(19407, 19407, 1),
(19407, 19412, 2),
 -- Improved Cone of Cold
(11190, 11190, 1),
(11190, 12489, 2),
(11190, 12490, 3),
 -- Improved Corpse Explosion
(49601, 49601, 1),
(49601, 49602, 2),
 -- Improved Corruption
(17810, 17810, 1),
(17810, 17811, 2),
(17810, 17812, 3),
(17810, 17813, 4),
(17810, 17814, 5),
 -- Improved Counterspell
(11255, 11255, 1),
(11255, 12598, 2),
 -- Improved Cower
(53180, 53180, 1),
(53180, 53181, 2),
 -- Improved Curse of Agony
(18827, 18827, 1),
(18827, 18829, 2),
 -- Improved Curse of Weakness
(18179, 18179, 1),
(18179, 18180, 2),
 -- Improved Death Coil
(30049, 30049, 1),
(30049, 30051, 2),
(30049, 30052, 3),
 -- Improved Defensive Stance
(29593, 29593, 1),
(29593, 29594, 2),
 -- Improved Demonic Tactics
(54347, 54347, 1),
(54347, 54348, 2),
(54347, 54349, 3),
 -- Improved Demoralizing Shout
(12324, 12324, 1),
(12324, 12876, 2),
(12324, 12877, 3),
(12324, 12878, 4),
(12324, 12879, 5),
 -- Improved Devotion Aura
(20138, 20138, 1),
(20138, 20139, 2),
(20138, 20140, 3),
 -- Improved Devouring Plague
(63625, 63625, 1),
(63625, 63626, 2),
(63625, 63627, 3),
 -- Improved Disarm
(12313, 12313, 1),
(12313, 12804, 2),
 -- Improved Disciplines
(12312, 12312, 1),
(12312, 12803, 2),
 -- Improved Drain Soul
(18213, 18213, 1),
(18213, 18372, 2),
 -- Improved Earth Shield
(51560, 51560, 1),
(51560, 51561, 2),
 -- Improved Eviscerate
(14162, 14162, 1),
(14162, 14163, 2),
(14162, 14164, 3),
 -- Improved Execute
(20502, 20502, 1),
(20502, 20503, 2),
 -- Improved Expose Armor
(14168, 14168, 1),
(14168, 14169, 2),
 -- Improved Eyes of the Beast
(19557, 19557, 1),
(19557, 19558, 2),
 -- Improved Faerie Fire
(33600, 33600, 1),
(33600, 33601, 2),
(33600, 33602, 3),
 -- Improved Fear
(53754, 53754, 1),
(53754, 53759, 2),
 -- Improved Felhunter
(54037, 54037, 1),
(54037, 54038, 2),
 -- Improved Fire Blast
(11078, 11078, 1),
(11078, 11080, 2),
 -- Improved Fire Nova
(16086, 16086, 1),
(16086, 16544, 2),
 -- Improved Fireball
(11069, 11069, 1),
(11069, 12338, 2),
(11069, 12339, 3),
(11069, 12340, 4),
(11069, 12341, 5),
 -- Improved Flash of Light
(20249, 20249, 1),
(20249, 20250, 2),
(20249, 20251, 3),
 -- Improved Frost Presence
(50384, 50384, 1),
(50384, 50385, 2),
 -- Improved Frostbolt
(11070, 11070, 1),
(11070, 12473, 2),
(11070, 16763, 3),
(11070, 16765, 4),
(11070, 16766, 5),
 -- Improved Ghost Wolf
(16262, 16262, 1),
(16262, 16287, 2),
 -- Improved Gouge
(13741, 13741, 1),
(13741, 13793, 2),
(13741, 13792, 3),
 -- Improved Hammer of Justice
(20487, 20487, 1),
(20487, 20488, 2),
 -- Improved Hamstring
(12289, 12289, 1),
(12289, 12668, 2),
(12289, 23695, 3),
 -- Improved Healing
(14912, 14912, 1),
(14912, 15013, 2),
(14912, 15014, 3),
 -- Improved Healing Wave
(16182, 16182, 1),
(16182, 16226, 2),
(16182, 16227, 3),
(16182, 16228, 4),
(16182, 16229, 5),
 -- Improved Health Funnel
(18703, 18703, 1),
(18703, 18704, 2),
 -- Improved Healthstone
(18692, 18692, 1),
(18692, 18693, 2),
 -- Improved Heroic Strike
(12282, 12282, 1),
(12282, 12663, 2),
(12282, 12664, 3),
 -- Improved Howl of Terror
(30054, 30054, 1),
(30054, 30057, 2),
 -- Improved Hunter's Mark
(19421, 19421, 1),
(19421, 19422, 2),
(19421, 19423, 3),
 -- Improved Icy Touch
(49175, 49175, 1),
(49175, 50031, 2),
(49175, 51456, 3),
 -- Improved Immolate
(17815, 17815, 1),
(17815, 17833, 2),
(17815, 17834, 3),
 -- Improved Imp
(18694, 18694, 1),
(18694, 18695, 2),
(18694, 18696, 3),
 -- Improved Inner Fire
(14747, 14747, 1),
(14747, 14770, 2),
(14747, 14771, 3),
 -- Improved Inner Rage
(12325, 12325, 1),
(12325, 12863, 2),
(12325, 12864, 3),
(12325, 12865, 4),
(12325, 12866, 5),
 -- Improved Insect Swarm
(57849, 57849, 1),
(57849, 57850, 2),
(57849, 57851, 3),
 -- Improved Intercept
(29888, 29888, 1),
(29888, 29889, 2),
 -- Improved Intimidating Shout
(19870, 19870, 1),
(19870, 19871, 2),
 -- Improved Judgements
(25956, 25956, 1),
(25956, 25957, 2),
 -- Improved Kick
(13754, 13754, 1),
(13754, 13867, 2),
 -- Improved Kidney Shot
(14174, 14174, 1),
(14174, 14175, 2),
(14174, 14176, 3),
 -- Improved Lay on Hands
(20234, 20234, 1),
(20234, 20235, 2),
 -- Improved Leader of the Pack
(34297, 34297, 1),
(34297, 34300, 2),
 -- Improved Life Tap
(18182, 18182, 1),
(18182, 18183, 2),
 -- Improved Mana Burn
(14750, 14750, 1),
(14750, 14772, 2),
 -- Improved Mangle
(48532, 48532, 1),
(48532, 48489, 2),
(48532, 48491, 3),
 -- Improved Mark of the Wild
(17050, 17050, 1),
(17050, 17051, 2),
 -- Improved Mind Blast
(15273, 15273, 1),
(15273, 15312, 2),
(15273, 15313, 3),
(15273, 15314, 4),
(15273, 15316, 5),
 -- Improved Moonfire
(16821, 16821, 1),
(16821, 16822, 2),
 -- Improved Moonkin Form
(50170, 50170, 1),
(50170, 50171, 2),
(50170, 50172, 3),
 -- Improved Moonkin Form
(48384, 48384, 1),
(48384, 48395, 2),
(48384, 48396, 3),
 -- Improved Mortal Strike
(35446, 35446, 1),
(35446, 35448, 2),
(35446, 35449, 3),
 -- Improved Overpower
(12290, 12290, 1),
(12290, 12963, 2),
 -- Improved Poisons
(14113, 14113, 1),
(14113, 14114, 2),
(14113, 14115, 3),
(14113, 14116, 4),
(14113, 14117, 5),
 -- Improved Power Word: Fortitude
(14749, 14749, 1),
(14749, 14767, 2),
 -- Improved Power Word: Shield
(14748, 14748, 1),
(14748, 14768, 2),
(14748, 14769, 3),
 -- Improved Psychic Scream
(15392, 15392, 1),
(15392, 15448, 2),
 -- Improved Reincarnation
(16184, 16184, 1),
(16184, 16209, 2),
 -- Improved Rejuvenation
(17111, 17111, 1),
(17111, 17112, 2),
(17111, 17113, 3),
 -- Improved Rend
(12286, 12286, 1),
(12286, 12658, 2),
 -- Improved Renew
(14908, 14908, 1),
(14908, 15020, 2),
(14908, 17191, 3),
 -- Improved Revenge
(12797, 12797, 1),
(12797, 12799, 2),
 -- Improved Revive Pet
(24443, 24443, 1),
(24443, 19575, 2),
 -- Improved Righteous Fury
(20468, 20468, 1),
(20468, 20469, 2),
(20468, 20470, 3),
 -- Improved Rune Tap
(48985, 48985, 1),
(48985, 49488, 2),
(48985, 49489, 3),
 -- Improved Scorch
(11095, 11095, 1),
(11095, 12872, 2),
(11095, 12873, 3),
 -- Improved Scorpid Sting
(19491, 19491, 1),
(19491, 19493, 2),
(19491, 19494, 3),
 -- Improved Searing Pain
(17927, 17927, 1),
(17927, 17929, 2),
(17927, 17930, 3),
 -- Improved Shadow Bolt
(17793, 17793, 1),
(17793, 17796, 2),
(17793, 17801, 3),
(17793, 17802, 4),
(17793, 17803, 5),
 -- Improved Shadow Word: Pain
(15275, 15275, 1),
(15275, 15317, 2),
 -- Improved Shadowform
(47569, 47569, 1),
(47569, 47570, 2),
 -- Improved Shields
(16261, 16261, 1),
(16261, 16290, 2),
(16261, 51881, 3),
 -- Improved Sinister Strike
(13732, 13732, 1),
(13732, 13863, 2),
 -- Improved Slam
(12862, 12862, 1),
(12862, 12330, 2),
 -- Improved Slice and Dice
(14165, 14165, 1),
(14165, 14166, 2),
 -- Improved Soul Leech
(54117, 54117, 1),
(54117, 54118, 2),
 -- Improved Spell Reflection
(59088, 59088, 1),
(59088, 59089, 2),
 -- Improved Spirit Tap
(49694, 49694, 1),
(49694, 59000, 2),
 -- Improved Spirit Tap
(15337, 15337, 1),
(15337, 15338, 2),
 -- Improved Sprint
(13743, 13743, 1),
(13743, 13875, 2),
 -- Improved Steady Shot
(53221, 53221, 1),
(53221, 53222, 2),
(53221, 53224, 3),
 -- Improved Stings
(19464, 19464, 1),
(19464, 19465, 2),
(19464, 19466, 3),
 -- Improved Stormstrike
(51521, 51521, 1),
(51521, 51522, 2),
 -- Improved Succubus
(18754, 18754, 1),
(18754, 18755, 2),
(18754, 18756, 3),
 -- Improved Thunder Clap
(12287, 12287, 1),
(12287, 12665, 2),
(12287, 12666, 3),
 -- Improved Tracking
(52783, 52783, 1),
(52783, 52785, 2),
(52783, 52786, 3),
(52783, 52787, 4),
(52783, 52788, 5),
 -- Improved Tranquility
(17123, 17123, 1),
(17123, 17124, 2),
 -- Improved Tree of Life
(48535, 48535, 1),
(48535, 48536, 2),
(48535, 48537, 3),
 -- Improved Unholy Presence
(50391, 50391, 1),
(50391, 50392, 2),
 -- Improved Vampiric Embrace
(27839, 27839, 1),
(27839, 27840, 2),
 -- Improved Water Shield
(16180, 16180, 1),
(16180, 16196, 2),
(16180, 16198, 3),
 -- Improved Whirlwind
(29721, 29721, 1),
(29721, 29776, 2),
 -- Improved Windfury Totem
(29192, 29192, 1),
(29192, 29193, 2),
 -- Impurity
(49220, 49220, 1),
(49220, 49633, 2),
(49220, 49635, 3),
(49220, 49636, 4),
(49220, 49638, 5),
 -- Incanter's Absorption
(44394, 44394, 1),
(44394, 44395, 2),
(44394, 44396, 3),
 -- Incinerate
(29722, 29722, 1),
(29722, 32231, 2),
(29722, 47837, 3),
(29722, 47838, 4),
 -- Incineration
(18459, 18459, 1),
(18459, 18460, 2),
(18459, 54734, 3),
 -- Incite
(50685, 50685, 1),
(50685, 50686, 2),
(50685, 50687, 3),
 -- Infected Wounds
(48483, 48483, 1),
(48483, 48484, 2),
(48483, 48485, 3),
 -- Infectious Poisons
(51630, 51630, 1),
(51630, 51631, 2),
 -- Inner Fire
(588, 588, 1),
(588, 7128, 2),
(588, 602, 3),
(588, 1006, 4),
(588, 10951, 5),
(588, 10952, 6),
(588, 25431, 7),
(588, 48040, 8),
(588, 48168, 9),
 -- Inscription
(45357, 45357, 1),
(45357, 45358, 2),
(45357, 45359, 3),
(45357, 45360, 4),
(45357, 45361, 5),
(45357, 45363, 6),
 -- Insect Swarm
(5570, 5570, 1),
(5570, 24974, 2),
(5570, 24975, 3),
(5570, 24976, 4),
(5570, 24977, 5),
(5570, 27013, 6),
(5570, 48468, 7),
 -- Inspiration
(14893, 14893, 1),
(14893, 15357, 2),
(14893, 15359, 3),
 -- Inspiration
(14892, 14892, 1),
(14892, 15362, 2),
(14892, 15363, 3),
 -- Intensify Rage
(46908, 46908, 1),
(46908, 46909, 2),
(46908, 56924, 3),
 -- Intensity
(17080, 17080, 1),
(17080, 35358, 2),
(17080, 35359, 3),
 -- Intensity
(17106, 17106, 1),
(17106, 17107, 2),
(17106, 17108, 3),
 -- Intensity
(18135, 18135, 1),
(18135, 18136, 2),
 -- Invigoration
(53252, 53252, 1),
(53252, 53253, 2),
 -- Iron Will
(12300, 12300, 1),
(12300, 12959, 2),
(12300, 12960, 3),
 -- Jewelcrafting
(25229, 25229, 1),
(25229, 25230, 2),
(25229, 28894, 3),
(25229, 28895, 4),
(25229, 28897, 5),
(25229, 51311, 6),
 -- Judgements of the Just
(53695, 53695, 1),
(53695, 53696, 2),
 -- Judgements of the Wise
(31876, 31876, 1),
(31876, 31877, 2),
(31876, 31878, 3),
 -- Khadgar's Unlocking
(491, 491, 1),
(491, 857, 2),
(491, 10165, 3),
(491, 10166, 4),
 -- Kidney Shot
(408, 408, 1),
(408, 8643, 2),
 -- Kill Shot
(53351, 53351, 1),
(53351, 61005, 2),
(53351, 61006, 3),
 -- Killer Instinct
(19370, 19370, 1),
(19370, 19371, 2),
(19370, 19373, 3),
 -- Killing Machine
(51123, 51123, 1),
(51123, 51127, 2),
(51123, 51128, 3),
(51123, 51129, 4),
(51123, 51130, 5),
 -- Kindling Soul
(47426, 47426, 1),
(47426, 47427, 2),
 -- Kindling Soul
(47261, 47261, 1),
(47261, 47262, 2),
 -- Kindred Spirits
(56314, 56314, 1),
(56314, 56315, 2),
(56314, 56316, 3),
(56314, 56317, 4),
(56314, 56318, 5),
 -- King of the Jungle
(48492, 48492, 1),
(48492, 48494, 2),
(48492, 48495, 3),
 -- Lacerate
(33745, 33745, 1),
(33745, 48567, 2),
(33745, 48568, 3),
 -- Lash of Pain
(7814, 7814, 1),
(7814, 7815, 2),
(7814, 7816, 3),
(7814, 11778, 4),
(7814, 11779, 5),
(7814, 11780, 6),
(7814, 27274, 7),
(7814, 47991, 8),
(7814, 47992, 9),
 -- Lava Breath
(58604, 58604, 1),
(58604, 58607, 2),
(58604, 58608, 3),
(58604, 58609, 4),
(58604, 58610, 5),
(58604, 58611, 6),
 -- Lava Burst
(51505, 51505, 1),
(51505, 60043, 2),
 -- Lava Flows
(51480, 51480, 1),
(51480, 51481, 2),
(51480, 51482, 3),
 -- Lay on Hands
(633, 633, 1),
(633, 2800, 2),
(633, 10310, 3),
(633, 27154, 4),
(633, 48788, 5),
 -- Leatherworking
(2108, 2108, 1),
(2108, 3104, 2),
(2108, 3811, 3),
(2108, 10662, 4),
(2108, 32549, 5),
(2108, 51302, 6),
 -- Lesser Heal
(2050, 2050, 1),
(2050, 2052, 2),
(2050, 2053, 3),
 -- Lesser Healing Wave
(8004, 8004, 1),
(8004, 8008, 2),
(8004, 8010, 3),
(8004, 10466, 4),
(8004, 10467, 5),
(8004, 10468, 6),
(8004, 25420, 7),
(8004, 49275, 8),
(8004, 49276, 9),
 -- Lethal Shots
(19426, 19426, 1),
(19426, 19427, 2),
(19426, 19429, 3),
(19426, 19430, 4),
(19426, 19431, 5),
 -- Lethality
(14128, 14128, 1),
(14128, 14132, 2),
(14128, 14135, 3),
(14128, 14136, 4),
(14128, 14137, 5),
 -- Life Tap
(1454, 1454, 1),
(1454, 1455, 2),
(1454, 1456, 3),
(1454, 11687, 4),
(1454, 11688, 5),
(1454, 11689, 6),
(1454, 27222, 7),
(1454, 57946, 8),
 -- Lifeblood
(55428, 55428, 1),
(55428, 55480, 2),
(55428, 55500, 3),
(55428, 55501, 4),
(55428, 55502, 5),
(55428, 55503, 6),
 -- Lifebloom
(33763, 33763, 1),
(33763, 48450, 2),
(33763, 48451, 3),
 -- Lightning Breath
(24845, 24845, 1),
(24845, 25013, 2),
(24845, 25014, 3),
(24845, 25015, 4),
(24845, 25016, 5),
(24845, 25017, 6),
 -- Lightning Breath
(24844, 24844, 1),
(24844, 25008, 2),
(24844, 25009, 3),
(24844, 25010, 4),
(24844, 25011, 5),
(24844, 25012, 6),
 -- Lightning Mastery
(16578, 16578, 1),
(16578, 16579, 2),
(16578, 16580, 3),
(16578, 16581, 4),
(16578, 16582, 5),
 -- Lightning Overload
(30675, 30675, 1),
(30675, 30678, 2),
(30675, 30679, 3),
 -- Lightning Reflexes
(13712, 13712, 1),
(13712, 13788, 2),
(13712, 13789, 3),
 -- Lightning Reflexes
(19168, 19168, 1),
(19168, 19180, 2),
(19168, 19181, 3),
(19168, 24296, 4),
(19168, 24297, 5),
 -- Light's Grace
(31833, 31833, 1),
(31833, 31835, 2),
(31833, 31836, 3),
 -- Lightwell
(724, 724, 1),
(724, 27870, 2),
(724, 27871, 3),
(724, 28275, 4),
(724, 48086, 5),
(724, 48087, 6),
 -- Lightwell Renew
(7001, 7001, 1),
(7001, 27873, 2),
(7001, 27874, 3),
(7001, 28276, 4),
(7001, 48084, 5),
(7001, 48085, 6),
 -- Lionhearted
(53409, 53409, 1),
(53409, 53411, 2),
 -- Living Seed
(48496, 48496, 1),
(48496, 48499, 2),
(48496, 48500, 3),
 -- Living Spirit
(34151, 34151, 1),
(34151, 34152, 2),
(34151, 34153, 3),
 -- Lock and Load
(56342, 56342, 1),
(56342, 56343, 2),
(56342, 56344, 3),
 -- Lockpicking
(1809, 1809, 1),
(1809, 1810, 2),
(1809, 6460, 3),
 -- Longevity
(53262, 53262, 1),
(53262, 53263, 2),
(53262, 53264, 3),
 -- Lunar Guidance
(33589, 33589, 1),
(33589, 33590, 2),
(33589, 33591, 3),
 -- Mace Specialization
(13709, 13709, 1),
(13709, 13800, 2),
(13709, 13801, 3),
(13709, 13802, 4),
(13709, 13803, 5),
 -- Maelstrom Weapon
(51528, 51528, 1),
(51528, 51529, 2),
(51528, 51530, 3),
(51528, 51531, 4),
(51528, 51532, 5),
 -- Mage Armor
(6121, 6121, 1),
(6121, 22784, 2),
(6121, 22785, 3),
(6121, 27392, 4),
 -- Mage Armor
(6117, 6117, 1),
(6117, 22782, 2),
(6117, 22783, 3),
(6117, 27125, 4),
(6117, 43023, 5),
(6117, 43024, 6),
 -- Magic Absorption
(29441, 29441, 1),
(29441, 29444, 2),
 -- Magic Attunement
(11247, 11247, 1),
(11247, 12606, 2),
 -- Magic Suppression
(49224, 49224, 1),
(49224, 49610, 2),
(49224, 49611, 3),
 -- Magma Totem
(8187, 8187, 1),
(8187, 10579, 2),
(8187, 10580, 3),
(8187, 10581, 4),
(8187, 25550, 5),
(8187, 58732, 6),
(8187, 58735, 7),
 -- Magma Totem
(8190, 8190, 1),
(8190, 10585, 2),
(8190, 10586, 3),
(8190, 10587, 4),
(8190, 25552, 5),
(8190, 58731, 6),
(8190, 58734, 7),
 -- Magma Totem Passive
(8188, 8188, 1),
(8188, 10582, 2),
(8188, 10583, 3),
(8188, 10584, 4),
(8188, 25551, 5),
(8188, 58733, 6),
(8188, 58736, 7),
 -- Maim
(22570, 22570, 1),
(22570, 49802, 2),
 -- Malediction
(32477, 32477, 1),
(32477, 32483, 2),
(32477, 32484, 3),
 -- Malice
(14138, 14138, 1),
(14138, 14139, 2),
(14138, 14140, 3),
(14138, 14141, 4),
(14138, 14142, 5),
 -- Mana Shield
(1481, 1481, 1),
(1481, 8496, 2),
(1481, 8497, 3),
(1481, 10194, 4),
(1481, 10195, 5),
(1481, 10196, 6),
(1481, 27398, 7),
 -- Mana Shield
(1463, 1463, 1),
(1463, 8494, 2),
(1463, 8495, 3),
(1463, 10191, 4),
(1463, 10192, 5),
(1463, 10193, 6),
(1463, 27131, 7),
(1463, 43019, 8),
(1463, 43020, 9),
 -- Mana Spring
(5677, 5677, 1),
(5677, 10491, 2),
(5677, 10493, 3),
(5677, 10494, 4),
(5677, 25569, 5),
(5677, 58775, 6),
(5677, 58776, 7),
(5677, 58777, 8),
 -- Mana Spring Totem
(5675, 5675, 1),
(5675, 10495, 2),
(5675, 10496, 3),
(5675, 10497, 4),
(5675, 25570, 5),
(5675, 58771, 6),
(5675, 58773, 7),
(5675, 58774, 8),
 -- Mangle (Bear)
(33878, 33878, 1),
(33878, 33986, 2),
(33878, 33987, 3),
(33878, 48563, 4),
(33878, 48564, 5),
 -- Mangle (Cat)
(33876, 33876, 1),
(33876, 33982, 2),
(33876, 33983, 3),
(33876, 48565, 4),
(33876, 48566, 5),
 -- Mark of the Wild
(1126, 1126, 1),
(1126, 5232, 2),
(1126, 6756, 3),
(1126, 5234, 4),
(1126, 8907, 5),
(1126, 9884, 6),
(1126, 9885, 7),
(1126, 26990, 8),
(1126, 48469, 9),
 -- Marked for Death
(53241, 53241, 1),
(53241, 53243, 2),
(53241, 53244, 3),
(53241, 53245, 4),
(53241, 53246, 5),
 -- Martyrdom
(14531, 14531, 1),
(14531, 14774, 2),
 -- Master Conjuror
(18767, 18767, 1),
(18767, 18768, 2),
 -- Master Healer
(14904, 14904, 1),
(14904, 15024, 2),
(14904, 15025, 3),
(14904, 15026, 4),
(14904, 15027, 5),
 -- Master Marksman
(34485, 34485, 1),
(34485, 34486, 2),
(34485, 34487, 3),
(34485, 34488, 4),
(34485, 34489, 5),
 -- Master of Anatomy
(53125, 53125, 1),
(53125, 53662, 2),
(53125, 53663, 3),
(53125, 53664, 4),
(53125, 53665, 5),
(53125, 53666, 6),
 -- Master of Deception
(13958, 13958, 1),
(13958, 13970, 2),
(13958, 13971, 3),
 -- Master of Elements
(29074, 29074, 1),
(29074, 29075, 2),
(29074, 29076, 3),
 -- Master of Subtlety
(31221, 31221, 1),
(31221, 31222, 2),
(31221, 31223, 3),
 -- Master Poisoner
(31226, 31226, 1),
(31226, 31227, 2),
(31226, 58410, 3),
 -- Master Summoner
(18709, 18709, 1),
(18709, 18710, 2),
 -- Maul
(6807, 6807, 1),
(6807, 6808, 2),
(6807, 6809, 3),
(6807, 8972, 4),
(6807, 9745, 5),
(6807, 9880, 6),
(6807, 9881, 7),
(6807, 26996, 8),
(6807, 48479, 9),
(6807, 48480, 10),
 -- Meditation
(14521, 14521, 1),
(14521, 14776, 2),
(14521, 14777, 3),
 -- Melee Specialization
(19381, 19381, 1),
(19381, 19382, 2),
(19381, 19383, 3),
(19381, 19384, 4),
(19381, 19385, 5),
 -- Melted Mind
(58378, 58378, 1),
(58378, 58379, 2),
 -- Mend Pet
(136, 136, 1),
(136, 3111, 2),
(136, 3661, 3),
(136, 3662, 4),
(136, 13542, 5),
(136, 13543, 6),
(136, 13544, 7),
(136, 27046, 8),
(136, 48989, 9),
(136, 48990, 10),
 -- Mental Agility
(14520, 14520, 1),
(14520, 14780, 2),
(14520, 14781, 3),
 -- Mental Dexterity
(51883, 51883, 1),
(51883, 51884, 2),
(51883, 51885, 3),
 -- Mental Quickness
(30812, 30812, 1),
(30812, 30813, 2),
(30812, 30814, 3),
 -- Mental Strength
(18551, 18551, 1),
(18551, 18552, 2),
(18551, 18553, 3),
(18551, 18554, 4),
(18551, 18555, 5),
 -- Merciless Combat
(49024, 49024, 1),
(49024, 49538, 2),
 -- Might of Mograine
(49023, 49023, 1),
(49023, 49533, 2),
(49023, 49534, 3),
 -- Mind Blast
(8092, 8092, 1),
(8092, 8102, 2),
(8092, 8103, 3),
(8092, 8104, 4),
(8092, 8105, 5),
(8092, 8106, 6),
(8092, 10945, 7),
(8092, 10946, 8),
(8092, 10947, 9),
(8092, 25372, 10),
(8092, 25375, 11),
(8092, 48126, 12),
(8092, 48127, 13),
 -- Mind Flay
(15407, 15407, 1),
(15407, 17311, 2),
(15407, 17312, 3),
(15407, 17313, 4),
(15407, 17314, 5),
(15407, 18807, 6),
(15407, 25387, 7),
(15407, 48155, 8),
(15407, 48156, 9),
 -- Mind Mastery
(31584, 31584, 1),
(31584, 31585, 2),
(31584, 31586, 3),
(31584, 31587, 4),
(31584, 31588, 5),
 -- Mind Melt
(14910, 14910, 1),
(14910, 33371, 2),
 -- Mind Vision
(2096, 2096, 1),
(2096, 10909, 2),
 -- Mining
(2575, 2575, 1),
(2575, 2576, 2),
(2575, 3564, 3),
(2575, 10248, 4),
(2575, 29354, 5),
(2575, 50310, 6),
 -- Missile Barrage
(44404, 44404, 1),
(44404, 54486, 2),
(44404, 54488, 3),
(44404, 54489, 4),
(44404, 54490, 5),
 -- Molten Core
(47245, 47245, 1),
(47245, 47246, 2),
(47245, 47247, 3),
 -- Molten Fury
(31679, 31679, 1),
(31679, 31680, 2),
 -- Molten Shields
(11094, 11094, 1),
(11094, 13043, 2),
 -- Mongoose Bite
(1495, 1495, 1),
(1495, 14269, 2),
(1495, 14270, 3),
(1495, 14271, 4),
(1495, 36916, 5),
(1495, 53339, 6),
 -- Monstrous Bite
(54680, 54680, 1),
(54680, 55495, 2),
(54680, 55496, 3),
(54680, 55497, 4),
(54680, 55498, 5),
(54680, 55499, 6),
 -- Moonfire
(8921, 8921, 1),
(8921, 8924, 2),
(8921, 8925, 3),
(8921, 8926, 4),
(8921, 8927, 5),
(8921, 8928, 6),
(8921, 8929, 7),
(8921, 9833, 8),
(8921, 9834, 9),
(8921, 9835, 10),
(8921, 26987, 11),
(8921, 26988, 12),
(8921, 48462, 13),
(8921, 48463, 14),
 -- Moonfury
(16896, 16896, 1),
(16896, 16897, 2),
(16896, 16899, 3),
 -- Moonglow
(16845, 16845, 1),
(16845, 16846, 2),
(16845, 16847, 3),
 -- Morbidity
(48963, 48963, 1),
(48963, 49564, 2),
(48963, 49565, 3),
 -- Mortal Shots
(19485, 19485, 1),
(19485, 19487, 2),
(19485, 19488, 3),
(19485, 19489, 4),
(19485, 19490, 5),
 -- Mortal Strike
(12294, 12294, 1),
(12294, 21551, 2),
(12294, 21552, 3),
(12294, 21553, 4),
(12294, 25248, 5),
(12294, 30330, 6),
(12294, 47485, 7),
(12294, 47486, 8),
 -- Multi-Shot
(2643, 2643, 1),
(2643, 14288, 2),
(2643, 14289, 3),
(2643, 14290, 4),
(2643, 25294, 5),
(2643, 27021, 6),
(2643, 49047, 7),
(2643, 49048, 8),
 -- Murder
(14158, 14158, 1),
(14158, 14159, 2),
 -- Mutilate
(1329, 1329, 1),
(1329, 34411, 2),
(1329, 34412, 3),
(1329, 34413, 4),
(1329, 48663, 5),
(1329, 48666, 6),
 -- Natural Armor
(24547, 24547, 1),
(24547, 24556, 2),
(24547, 24557, 3),
(24547, 24558, 4),
(24547, 24559, 5),
(24547, 24560, 6),
(24547, 24561, 7),
(24547, 24562, 8),
(24547, 24631, 9),
(24547, 24632, 10),
(24547, 27362, 11),
 -- Natural Armor
(61689, 61689, 1),
(61689, 61690, 2),
 -- Natural Perfection
(45281, 45281, 1),
(45281, 45282, 2),
(45281, 45283, 3),
 -- Natural Perfection
(33881, 33881, 1),
(33881, 33882, 2),
(33881, 33883, 3),
 -- Natural Reaction
(57878, 57878, 1),
(57878, 57880, 2),
(57878, 57881, 3),
 -- Natural Shapeshifter
(16833, 16833, 1),
(16833, 16834, 2),
(16833, 16835, 3),
 -- Naturalist
(17069, 17069, 1),
(17069, 17070, 2),
(17069, 17071, 3),
(17069, 17072, 4),
(17069, 17073, 5),
 -- Nature Resistance Totem
(10595, 10595, 1),
(10595, 10600, 2),
(10595, 10601, 3),
(10595, 25574, 4),
(10595, 58746, 5),
(10595, 58749, 6),
 -- Nature's Blessing
(30867, 30867, 1),
(30867, 30868, 2),
(30867, 30869, 3),
 -- Nature's Bounty
(17074, 17074, 1),
(17074, 17075, 2),
(17074, 17076, 3),
(17074, 17077, 4),
(17074, 17078, 5),
 -- Nature's Focus
(17063, 17063, 1),
(17063, 17065, 2),
(17063, 17066, 3),
 -- Nature's Grasp
(16689, 16689, 1),
(16689, 16810, 2),
(16689, 16811, 3),
(16689, 16812, 4),
(16689, 16813, 5),
(16689, 17329, 6),
(16689, 27009, 7),
(16689, 53312, 8),
 -- Nature's Guardian
(30881, 30881, 1),
(30881, 30883, 2),
(30881, 30884, 3),
(30881, 30885, 4),
(30881, 30886, 5),
 -- Nature's Reach
(16819, 16819, 1),
(16819, 16820, 2),
 -- Necrosis
(51459, 51459, 1),
(51459, 51462, 2),
(51459, 51463, 3),
(51459, 51464, 4),
(51459, 51465, 5),
 -- Nemesis
(63117, 63117, 1),
(63117, 63121, 2),
(63117, 63123, 3),
 -- Nerves of Cold Steel
(49226, 49226, 1),
(49226, 50137, 2),
(49226, 50138, 3),
 -- Nerves of Steel
(31130, 31130, 1),
(31130, 31131, 2),
 -- Nether Protection
(30299, 30299, 1),
(30299, 30301, 2),
(30299, 30302, 3),
 -- Nether Shock
(50479, 50479, 1),
(50479, 53584, 2),
(50479, 53586, 3),
(50479, 53587, 4),
(50479, 53588, 5),
(50479, 53589, 6),
 -- Netherwind Presence
(44400, 44400, 1),
(44400, 44402, 2),
(44400, 44403, 3),
 -- Night of the Dead
(55620, 55620, 1),
(55620, 55623, 2),
 -- Nightfall
(18094, 18094, 1),
(18094, 18095, 2),
 -- Noxious Stings
(53295, 53295, 1),
(53295, 53296, 2),
(53295, 53297, 3),
 -- Nurturing Instinct
(47179, 47179, 1),
(47179, 47180, 2),
 -- Nurturing Instinct
(33872, 33872, 1),
(33872, 33873, 2),
 -- One-Handed Weapon Specialization
(16538, 16538, 1),
(16538, 16539, 2),
(16538, 16540, 3),
(16538, 16541, 4),
(16538, 16542, 5),
 -- One-Handed Weapon Specialization
(20196, 20196, 1),
(20196, 20197, 2),
(20196, 20198, 3),
 -- Opportunity
(14057, 14057, 1),
(14057, 14072, 2),
 -- Outbreak
(49013, 49013, 1),
(49013, 55236, 2),
(49013, 55237, 3),
 -- Owlkin Frenzy
(48389, 48389, 1),
(48389, 48392, 2),
(48389, 48393, 3),
 -- Owl's Focus
(53514, 53514, 1),
(53514, 53516, 2),
 -- Pain and Suffering
(47580, 47580, 1),
(47580, 47581, 2),
(47580, 47582, 3),
 -- Pathfinding
(19559, 19559, 1),
(19559, 19560, 2),
 -- Permafrost
(11175, 11175, 1),
(11175, 12569, 2),
(11175, 12571, 3),
 -- Pet Aggression
(6311, 6311, 1),
(6311, 6314, 2),
(6311, 6315, 3),
(6311, 6316, 4),
(6311, 6317, 5),
 -- Pet Barding
(53175, 53175, 1),
(53175, 53176, 2),
 -- Pet Hardiness
(6280, 6280, 1),
(6280, 6281, 2),
(6280, 6282, 3),
(6280, 6283, 4),
(6280, 6286, 5),
 -- Pet Recovery
(6328, 6328, 1),
(6328, 6331, 2),
(6328, 6332, 3),
(6328, 6333, 4),
(6328, 6334, 5),
 -- Pet Resistance
(6443, 6443, 1),
(6443, 6444, 2),
(6443, 6445, 3),
(6443, 6446, 4),
(6443, 6447, 5),
 -- Piercing Ice
(11151, 11151, 1),
(11151, 12952, 2),
(11151, 12953, 3),
 -- Piercing Shots
(53234, 53234, 1),
(53234, 53237, 2),
(53234, 53238, 3),
 -- Pin
(50245, 50245, 1),
(50245, 53544, 2),
(50245, 53545, 3),
(50245, 53546, 4),
(50245, 53547, 5),
(50245, 53548, 6),
 -- Playing with Fire
(31638, 31638, 1),
(31638, 31639, 2),
(31638, 31640, 3),
 -- Point of No Escape
(53298, 53298, 1),
(53298, 53299, 2),
 -- Poison Spit
(35388, 35388, 1),
(35388, 35390, 2),
(35388, 35391, 3),
 -- Poison Spit
(35387, 35387, 1),
(35387, 35389, 2),
(35387, 35392, 3),
(35387, 55555, 4),
(35387, 55556, 5),
(35387, 55557, 6),
 -- Poleaxe Specialization
(12700, 12700, 1),
(12700, 12781, 2),
(12700, 12783, 3),
(12700, 12784, 4),
(12700, 12785, 5),
 -- Polymorph
(118, 118, 1),
(118, 12824, 2),
(118, 12825, 3),
(118, 12826, 4),
 -- Pounce
(9005, 9005, 1),
(9005, 9823, 2),
(9005, 9827, 3),
(9005, 27006, 4),
(9005, 49803, 5),
 -- Pounce Bleed
(9007, 9007, 1),
(9007, 9824, 2),
(9007, 9826, 3),
(9007, 27007, 4),
(9007, 49804, 5),
 -- Power Word: Fortitude
(1243, 1243, 1),
(1243, 1244, 2),
(1243, 1245, 3),
(1243, 2791, 4),
(1243, 10937, 5),
(1243, 10938, 6),
(1243, 25389, 7),
(1243, 48161, 8),
 -- Power Word: Shield
(17, 17, 1),
(17, 592, 2),
(17, 600, 3),
(17, 3747, 4),
(17, 6065, 5),
(17, 6066, 6),
(17, 10898, 7),
(17, 10899, 8),
(17, 10900, 9),
(17, 10901, 10),
(17, 25217, 11),
(17, 25218, 12),
(17, 48065, 13),
(17, 48066, 14),
 -- Prayer of Fortitude
(21562, 21562, 1),
(21562, 21564, 2),
(21562, 25392, 3),
(21562, 48162, 4),
 -- Prayer of Healing
(596, 596, 1),
(596, 996, 2),
(596, 10960, 3),
(596, 10961, 4),
(596, 25316, 5),
(596, 25308, 6),
(596, 48072, 7),
 -- Prayer of Mending
(41635, 41635, 1),
(41635, 48110, 2),
(41635, 48111, 3),
 -- Prayer of Mending
(33076, 33076, 1),
(33076, 48112, 2),
(33076, 48113, 3),
 -- Prayer of Shadow Protection
(27683, 27683, 1),
(27683, 39374, 2),
(27683, 48170, 3),
 -- Prayer of Spirit
(27681, 27681, 1),
(27681, 32999, 2),
(27681, 48074, 3),
 -- Precision
(29438, 29438, 1),
(29438, 29439, 2),
(29438, 29440, 3),
 -- Precision
(13705, 13705, 1),
(13705, 13832, 2),
(13705, 13843, 3),
(13705, 13844, 4),
(13705, 13845, 5),
 -- Precision
(29590, 29590, 1),
(29590, 29591, 2),
(29590, 29592, 3),
 -- Predatory Instincts
(33859, 33859, 1),
(33859, 33866, 2),
(33859, 33867, 3),
 -- Predatory Strikes
(16972, 16972, 1),
(16972, 16974, 2),
(16972, 16975, 3),
 -- Prey on the Weak
(51685, 51685, 1),
(51685, 51686, 2),
(51685, 51687, 3),
(51685, 51688, 4),
(51685, 51689, 5),
 -- Primal Precision
(48409, 48409, 1),
(48409, 48410, 2),
 -- Primal Tenacity
(33851, 33851, 1),
(33851, 33852, 2),
(33851, 33957, 3),
 -- Prismatic Cloak
(31574, 31574, 1),
(31574, 31575, 2),
(31574, 54354, 3),
 -- Protector of the Pack
(57873, 57873, 1),
(57873, 57876, 2),
(57873, 57877, 3),
 -- Prowl
(24450, 24450, 1),
(24450, 24452, 2),
(24450, 24453, 3),
 -- Psychic Scream
(8122, 8122, 1),
(8122, 8124, 2),
(8122, 10888, 3),
(8122, 10890, 4),
 -- Pummel
(13491, 13491, 1),
(13491, 6554, 2),
(13491, 6555, 3),
 -- Puncture
(12308, 12308, 1),
(12308, 12810, 2),
(12308, 12811, 3),
 -- Puncturing Wounds
(13733, 13733, 1),
(13733, 13865, 2),
(13733, 13866, 3),
 -- Pure of Heart
(31822, 31822, 1),
(31822, 31823, 2),
 -- Purge
(370, 370, 1),
(370, 8012, 2),
 -- Purification
(16178, 16178, 1),
(16178, 16210, 2),
(16178, 16211, 3),
(16178, 16212, 4),
(16178, 16213, 5),
 -- Purifying Power
(31825, 31825, 1),
(31825, 31826, 2),
 -- Pursuit of Justice
(26022, 26022, 1),
(26022, 26023, 2),
 -- Pyroblast
(11366, 11366, 1),
(11366, 12505, 2),
(11366, 12522, 3),
(11366, 12523, 4),
(11366, 12524, 5),
(11366, 12525, 6),
(11366, 12526, 7),
(11366, 18809, 8),
(11366, 27132, 9),
(11366, 33938, 10),
(11366, 42890, 11),
(11366, 42891, 12),
 -- Pyroclasm
(18096, 18096, 1),
(18096, 18073, 2),
(18096, 63245, 3),
 -- Pyromaniac
(34293, 34293, 1),
(34293, 34295, 2),
(34293, 34296, 3),
 -- Quick Recovery
(31244, 31244, 1),
(31244, 31245, 2),
 -- Rage of Rivendare
(50117, 50117, 1),
(50117, 50118, 2),
(50117, 50119, 3),
(50117, 50120, 4),
(50117, 50121, 5),
 -- Rake
(1822, 1822, 1),
(1822, 1823, 2),
(1822, 1824, 3),
(1822, 9904, 4),
(1822, 27003, 5),
(1822, 48573, 6),
(1822, 48574, 7),
 -- Rake
(59881, 59881, 1),
(59881, 59882, 2),
(59881, 59883, 3),
(59881, 59884, 4),
(59881, 59885, 5),
(59881, 59886, 6),
 -- Ranged Weapon Specialization
(19507, 19507, 1),
(19507, 19508, 2),
(19507, 19509, 3),
 -- Rapid Recuperation
(53228, 53228, 1),
(53228, 53232, 2),
 -- Raptor Strike
(2973, 2973, 1),
(2973, 14260, 2),
(2973, 14261, 3),
(2973, 14262, 4),
(2973, 14263, 5),
(2973, 14264, 6),
(2973, 14265, 7),
(2973, 14266, 8),
(2973, 27014, 9),
(2973, 48995, 10),
(2973, 48996, 11),
 -- Rapture
(47535, 47535, 1),
(47535, 47536, 2),
(47535, 47537, 3),
 -- Ravage
(6785, 6785, 1),
(6785, 6787, 2),
(6785, 9866, 3),
(6785, 9867, 4),
(6785, 27005, 5),
(6785, 48578, 6),
(6785, 48579, 7),
 -- Ravage
(50518, 50518, 1),
(50518, 53558, 2),
(50518, 53559, 3),
(50518, 53560, 4),
(50518, 53561, 5),
(50518, 53562, 6),
 -- Ravenous Dead
(48965, 48965, 1),
(48965, 49571, 2),
(48965, 49572, 3),
 -- Reaping
(49208, 49208, 1),
(49208, 56834, 2),
(49208, 56835, 3),
 -- Rebirth
(20484, 20484, 1),
(20484, 20739, 2),
(20484, 20742, 3),
(20484, 20747, 4),
(20484, 20748, 5),
(20484, 26994, 6),
(20484, 48477, 7),
 -- Reckoning
(20177, 20177, 1),
(20177, 20179, 2),
(20177, 20181, 3),
(20177, 20180, 4),
(20177, 20182, 5),
 -- Redemption
(7328, 7328, 1),
(7328, 10322, 2),
(7328, 10324, 3),
(7328, 20772, 4),
(7328, 20773, 5),
(7328, 48949, 6),
(7328, 48950, 7),
 -- Redoubt
(20127, 20127, 1),
(20127, 20130, 2),
(20127, 20135, 3),
 -- Reflective Shield
(33201, 33201, 1),
(33201, 33202, 2),
 -- Regeneration
(30799, 30799, 1),
(30799, 30800, 2),
(30799, 30801, 3),
 -- Regrowth
(8936, 8936, 1),
(8936, 8938, 2),
(8936, 8939, 3),
(8936, 8940, 4),
(8936, 8941, 5),
(8936, 9750, 6),
(8936, 9856, 7),
(8936, 9857, 8),
(8936, 9858, 9),
(8936, 26980, 10),
(8936, 48442, 11),
(8936, 48443, 12),
 -- Rejuvenation
(774, 774, 1),
(774, 1058, 2),
(774, 1430, 3),
(774, 2090, 4),
(774, 2091, 5),
(774, 3627, 6),
(774, 8910, 7),
(774, 9839, 8),
(774, 9840, 9),
(774, 9841, 10),
(774, 25299, 11),
(774, 26981, 12),
(774, 26982, 13),
(774, 48440, 14),
(774, 48441, 15),
 -- Relentless Strikes
(14179, 14179, 1),
(14179, 58422, 2),
(14179, 58423, 3),
(14179, 58424, 4),
(14179, 58425, 5),
 -- Remorseless
(14143, 14143, 1),
(14143, 14149, 2),
 -- Remorseless Attacks
(14144, 14144, 1),
(14144, 14148, 2),
 -- Rend
(772, 772, 1),
(772, 6546, 2),
(772, 6547, 3),
(772, 6548, 4),
(772, 11572, 5),
(772, 11573, 6),
(772, 11574, 7),
(772, 25208, 8),
(772, 46845, 9),
(772, 47465, 10),
 -- Rend and Tear
(48432, 48432, 1),
(48432, 48433, 2),
(48432, 48434, 3),
(48432, 51268, 4),
(48432, 51269, 5),
 -- Renew
(139, 139, 1),
(139, 6074, 2),
(139, 6075, 3),
(139, 6076, 4),
(139, 6077, 5),
(139, 6078, 6),
(139, 10927, 7),
(139, 10928, 8),
(139, 10929, 9),
(139, 25315, 10),
(139, 25221, 11),
(139, 25222, 12),
(139, 48067, 13),
(139, 48068, 14),
 -- Renewed Hope
(57470, 57470, 1),
(57470, 57472, 2),
 -- Replenish Mana
(5405, 5405, 1),
(5405, 10052, 2),
(5405, 10057, 3),
(5405, 10058, 4),
(5405, 27103, 5),
(5405, 42987, 6),
(5405, 42988, 7),
 -- Resourcefulness
(34491, 34491, 1),
(34491, 34492, 2),
(34491, 34493, 3),
 -- Restorative Totems
(16187, 16187, 1),
(16187, 16205, 2),
(16187, 16206, 3),
 -- Resurrection
(2006, 2006, 1),
(2006, 2010, 2),
(2006, 10880, 3),
(2006, 10881, 4),
(2006, 20770, 5),
(2006, 25435, 6),
(2006, 48171, 7),
 -- Retribution Aura
(7294, 7294, 1),
(7294, 10298, 2),
(7294, 10299, 3),
(7294, 10300, 4),
(7294, 10301, 5),
(7294, 27150, 6),
(7294, 54043, 7),
 -- Revenge
(6572, 6572, 1),
(6572, 6574, 2),
(6572, 7379, 3),
(6572, 11600, 4),
(6572, 11601, 5),
(6572, 25288, 6),
(6572, 25269, 7),
(6572, 30357, 8),
(6572, 57823, 9),
 -- Reverberation
(16040, 16040, 1),
(16040, 16113, 2),
(16040, 16114, 3),
(16040, 16115, 4),
(16040, 16116, 5),
 -- Revitalize
(48539, 48539, 1),
(48539, 48544, 2),
(48539, 48545, 3),
 -- Revive
(50769, 50769, 1),
(50769, 50768, 2),
(50769, 50767, 3),
(50769, 50766, 4),
(50769, 50765, 5),
(50769, 50764, 6),
(50769, 50763, 7),
 -- Righteous Vengeance
(53380, 53380, 1),
(53380, 53381, 2),
(53380, 53382, 3),
 -- Rime
(49188, 49188, 1),
(49188, 56822, 2),
(49188, 59057, 3),
 -- Rip
(1079, 1079, 1),
(1079, 9492, 2),
(1079, 9493, 3),
(1079, 9752, 4),
(1079, 9894, 5),
(1079, 9896, 6),
(1079, 27008, 7),
(1079, 49799, 8),
(1079, 49800, 9),
 -- Riptide
(61295, 61295, 1),
(61295, 61299, 2),
(61295, 61300, 3),
(61295, 61301, 4),
 -- Ritual of Refreshment
(43987, 43987, 1),
(43987, 58659, 2),
 -- Ritual of Souls
(29893, 29893, 1),
(29893, 58887, 2),
 -- Rockbiter Weapon
(8017, 8017, 1),
(8017, 8018, 2),
(8017, 8019, 3),
(8017, 10399, 4),
 -- Ruin
(17959, 17959, 1),
(17959, 59738, 2),
(17959, 59739, 3),
(17959, 59740, 4),
(17959, 59741, 5),
 -- Runic Power Mastery
(49455, 49455, 1),
(49455, 50147, 2),
 -- Rupture
(1943, 1943, 1),
(1943, 8639, 2),
(1943, 8640, 3),
(1943, 11273, 4),
(1943, 11274, 5),
(1943, 11275, 6),
(1943, 26867, 7),
(1943, 48671, 8),
(1943, 48672, 9),
 -- Ruthlessness
(14156, 14156, 1),
(14156, 14160, 2),
(14156, 14161, 3),
 -- Sacred Cleansing
(53551, 53551, 1),
(53551, 53552, 2),
(53551, 53553, 3),
 -- Sacred Duty
(31848, 31848, 1),
(31848, 31849, 2),
 -- Sacrifice
(7812, 7812, 1),
(7812, 19438, 2),
(7812, 19440, 3),
(7812, 19441, 4),
(7812, 19442, 5),
(7812, 19443, 6),
(7812, 27273, 7),
(7812, 47985, 8),
(7812, 47986, 9),
 -- Sanctified Light
(20359, 20359, 1),
(20359, 20360, 2),
(20359, 20361, 3),
 -- Sanctified Wrath
(53375, 53375, 1),
(53375, 53376, 2),
 -- Sanctity of Battle
(32043, 32043, 1),
(32043, 35396, 2),
(32043, 35397, 3),
 -- Sap
(6770, 6770, 1),
(6770, 2070, 2),
(6770, 11297, 3),
(6770, 51724, 4),
 -- Savage Combat
(58684, 58684, 1),
(58684, 58683, 2),
 -- Savage Combat
(51682, 51682, 1),
(51682, 58413, 2),
 -- Savage Fury
(16998, 16998, 1),
(16998, 16999, 2),
 -- Savage Strikes
(19159, 19159, 1),
(19159, 19160, 2),
 -- Scare Beast
(1513, 1513, 1),
(1513, 14326, 2),
(1513, 14327, 3),
 -- Scent of Blood
(49004, 49004, 1),
(49004, 49508, 2),
(49004, 49509, 3),
 -- Scorch
(1811, 1811, 1),
(1811, 8447, 2),
(1811, 8448, 3),
(1811, 8449, 4),
(1811, 10208, 5),
(1811, 10209, 6),
(1811, 10210, 7),
(1811, 27375, 8),
(1811, 27376, 9),
 -- Scorch
(2948, 2948, 1),
(2948, 8444, 2),
(2948, 8445, 3),
(2948, 8446, 4),
(2948, 10205, 5),
(2948, 10206, 6),
(2948, 10207, 7),
(2948, 27073, 8),
(2948, 27074, 9),
(2948, 42858, 10),
(2948, 42859, 11),
 -- Scorpid Poison
(24641, 24641, 1),
(24641, 24584, 2),
(24641, 24588, 3),
(24641, 24589, 4),
(24641, 27361, 5),
 -- Scorpid Poison
(24640, 24640, 1),
(24640, 24583, 2),
(24640, 24586, 3),
(24640, 24587, 4),
(24640, 27060, 5),
(24640, 55728, 6),
 -- Scourge Strike
(55090, 55090, 1),
(55090, 55265, 2),
(55090, 55270, 3),
(55090, 55271, 4),
 -- Seal Fate
(14186, 14186, 1),
(14186, 14190, 2),
(14186, 14193, 3),
(14186, 14194, 4),
(14186, 14195, 5),
 -- Seals of the Pure
(20224, 20224, 1),
(20224, 20225, 2),
(20224, 20330, 3),
(20224, 20331, 4),
(20224, 20332, 5),
 -- Searing Light
(14909, 14909, 1),
(14909, 15017, 2),
 -- Searing Pain
(5676, 5676, 1),
(5676, 17919, 2),
(5676, 17920, 3),
(5676, 17921, 4),
(5676, 17922, 5),
(5676, 17923, 6),
(5676, 27210, 7),
(5676, 30459, 8),
(5676, 47814, 9),
(5676, 47815, 10),
 -- Searing Totem
(2075, 2075, 1),
(2075, 38116, 2),
 -- Searing Totem
(3599, 3599, 1),
(3599, 6363, 2),
(3599, 6364, 3),
(3599, 6365, 4),
(3599, 10437, 5),
(3599, 10438, 6),
(3599, 25533, 7),
(3599, 58699, 8),
(3599, 58703, 9),
(3599, 58704, 10),
 -- Seed of Corruption
(43991, 43991, 1),
(43991, 47831, 2),
(43991, 47832, 3),
 -- Serendipity
(63730, 63730, 1),
(63730, 63733, 2),
(63730, 63737, 3),
 -- Serenity Dust
(50318, 50318, 1),
(50318, 52012, 2),
(50318, 52013, 3),
(50318, 52014, 4),
(50318, 52015, 5),
(50318, 52016, 6),
 -- Serious Wound
(5597, 5597, 1),
(5597, 5598, 2),
 -- Serpent Sting
(1978, 1978, 1),
(1978, 13549, 2),
(1978, 13550, 3),
(1978, 13551, 4),
(1978, 13552, 5),
(1978, 13553, 6),
(1978, 13554, 7),
(1978, 13555, 8),
(1978, 25295, 9),
(1978, 27016, 10),
(1978, 49000, 11),
(1978, 49001, 12),
 -- Serpent's Swiftness
(34466, 34466, 1),
(34466, 34467, 2),
(34466, 34468, 3),
(34466, 34469, 4),
(34466, 34470, 5),
 -- Serrated Blades
(14171, 14171, 1),
(14171, 14172, 2),
(14171, 14173, 3),
 -- Setup
(13983, 13983, 1),
(13983, 14070, 2),
(13983, 14071, 3),
 -- Shackle Undead
(9484, 9484, 1),
(9484, 9485, 2),
(9484, 10955, 3),
 -- Shadow Affinity
(15318, 15318, 1),
(15318, 15272, 2),
(15318, 15320, 3),
 -- Shadow and Flame
(30288, 30288, 1),
(30288, 30289, 2),
(30288, 30290, 3),
(30288, 30291, 4),
(30288, 30292, 5),
 -- Shadow Bite
(54049, 54049, 1),
(54049, 54050, 2),
(54049, 54051, 3),
(54049, 54052, 4),
(54049, 54053, 5),
 -- Shadow Bolt
(686, 686, 1),
(686, 695, 2),
(686, 705, 3),
(686, 1088, 4),
(686, 1106, 5),
(686, 7641, 6),
(686, 11659, 7),
(686, 11660, 8),
(686, 11661, 9),
(686, 25307, 10),
(686, 27209, 11),
(686, 47808, 12),
(686, 47809, 13),
 -- Shadow Embrace
(32385, 32385, 1),
(32385, 32387, 2),
(32385, 32392, 3),
(32385, 32393, 4),
(32385, 32394, 5),
 -- Shadow Focus
(15260, 15260, 1),
(15260, 15327, 2),
(15260, 15328, 3),
 -- Shadow Mastery
(18271, 18271, 1),
(18271, 18272, 2),
(18271, 18273, 3),
(18271, 18274, 4),
(18271, 18275, 5),
 -- Shadow Power
(33221, 33221, 1),
(33221, 33222, 2),
(33221, 33223, 3),
(33221, 33224, 4),
(33221, 33225, 5),
 -- Shadow Protection
(976, 976, 1),
(976, 10957, 2),
(976, 10958, 3),
(976, 25433, 4),
(976, 48169, 5),
 -- Shadow Reach
(17322, 17322, 1),
(17322, 17323, 2),
 -- Shadow Resistance Aura
(19876, 19876, 1),
(19876, 19895, 2),
(19876, 19896, 3),
(19876, 27151, 4),
(19876, 48943, 5),
 -- Shadow Ward
(6229, 6229, 1),
(6229, 11739, 2),
(6229, 11740, 3),
(6229, 28610, 4),
(6229, 47890, 5),
(6229, 47891, 6),
 -- Shadow Weaving
(15257, 15257, 1),
(15257, 15331, 2),
(15257, 15332, 3),
 -- Shadow Word: Death
(32379, 32379, 1),
(32379, 32996, 2),
(32379, 48157, 3),
(32379, 48158, 4),
 -- Shadow Word: Pain
(589, 589, 1),
(589, 594, 2),
(589, 970, 3),
(589, 992, 4),
(589, 2767, 5),
(589, 10892, 6),
(589, 10893, 7),
(589, 10894, 8),
(589, 25367, 9),
(589, 25368, 10),
(589, 48124, 11),
(589, 48125, 12),
 -- Shadowburn
(17877, 17877, 1),
(17877, 18867, 2),
(17877, 18868, 3),
(17877, 18869, 4),
(17877, 18870, 5),
(17877, 18871, 6),
(17877, 27263, 7),
(17877, 30546, 8),
(17877, 47826, 9),
(17877, 47827, 10),
 -- Shadowflame
(47897, 47897, 1),
(47897, 61290, 2),
 -- Shadowfury
(30283, 30283, 1),
(30283, 30413, 2),
(30283, 30414, 3),
(30283, 47846, 4),
(30283, 47847, 5),
 -- Shamanism
(62097, 62097, 1),
(62097, 62098, 2),
(62097, 62099, 3),
(62097, 62100, 4),
(62097, 62101, 5),
 -- Shark Attack
(62759, 62759, 1),
(62759, 62760, 2),
 -- Sharpened Claws
(16942, 16942, 1),
(16942, 16943, 2),
(16942, 16944, 3),
 -- Shatter
(11170, 11170, 1),
(11170, 12982, 2),
(11170, 12983, 3),
 -- Shattered Barrier
(44745, 44745, 1),
(44745, 54787, 2),
 -- Sheath of Light
(53501, 53501, 1),
(53501, 53502, 2),
(53501, 53503, 3),
 -- Shield Mastery
(29598, 29598, 1),
(29598, 29599, 2),
 -- Shield of Righteousness
(53600, 53600, 1),
(53600, 61411, 2),
 -- Shield of the Templar
(53709, 53709, 1),
(53709, 53710, 2),
(53709, 53711, 3),
 -- Shield Slam
(23922, 23922, 1),
(23922, 23923, 2),
(23922, 23924, 3),
(23922, 23925, 4),
(23922, 25258, 5),
(23922, 30356, 6),
(23922, 47487, 7),
(23922, 47488, 8),
 -- Shield Specialization
(12298, 12298, 1),
(12298, 12724, 2),
(12298, 12725, 3),
(12298, 12726, 4),
(12298, 12727, 5),
 -- Shield Specialization
(16253, 16253, 1),
(16253, 16298, 2),
 -- Shock
(2607, 2607, 1),
(2607, 2606, 2),
(2607, 2608, 3),
(2607, 2609, 4),
(2607, 2610, 5),
 -- Shred
(5221, 5221, 1),
(5221, 6800, 2),
(5221, 8992, 3),
(5221, 9829, 4),
(5221, 9830, 5),
(5221, 27001, 6),
(5221, 27002, 7),
(5221, 48571, 8),
(5221, 48572, 9),
 -- Shredding Attacks
(16966, 16966, 1),
(16966, 16968, 2),
 -- Silenced - Improved Counterspell
(18469, 18469, 1),
(18469, 55021, 2),
 -- Silent Hunter
(34472, 34472, 1),
(34472, 34473, 2),
(34472, 34474, 3),
 -- Silent Resolve
(14523, 14523, 1),
(14523, 14784, 2),
(14523, 14785, 3),
 -- Silverback
(62764, 62764, 1),
(62764, 62765, 2),
 -- Sinister Calling
(31216, 31216, 1),
(31216, 31217, 2),
(31216, 31218, 3),
(31216, 31219, 4),
(31216, 31220, 5),
 -- Sinister Strike
(1752, 1752, 1),
(1752, 1757, 2),
(1752, 1758, 3),
(1752, 1759, 4),
(1752, 1760, 5),
(1752, 8621, 6),
(1752, 11293, 7),
(1752, 11294, 8),
(1752, 26861, 9),
(1752, 26862, 10),
(1752, 48637, 11),
(1752, 48638, 12),
 -- Skinning
(8613, 8613, 1),
(8613, 8617, 2),
(8613, 8618, 3),
(8613, 10768, 4),
(8613, 32678, 5),
(8613, 50305, 6),
 -- Slam
(1464, 1464, 1),
(1464, 8820, 2),
(1464, 11604, 3),
(1464, 11605, 4),
(1464, 25241, 5),
(1464, 25242, 6),
(1464, 47474, 7),
(1464, 47475, 8),
 -- Slaughter from the Shadows
(51708, 51708, 1),
(51708, 51709, 2),
(51708, 51710, 3),
(51708, 51711, 4),
(51708, 51712, 5),
 -- Sleep
(700, 700, 1),
(700, 1090, 2),
 -- Sleight of Hand
(30892, 30892, 1),
(30892, 30893, 2),
 -- Slice and Dice
(5171, 5171, 1),
(5171, 6774, 2),
 -- Slow
(246, 246, 1),
(246, 6146, 2),
 -- Smack
(49966, 49966, 1),
(49966, 49967, 2),
(49966, 49968, 3),
(49966, 49969, 4),
(49966, 49970, 5),
(49966, 49971, 6),
(49966, 49972, 7),
(49966, 49973, 8),
(49966, 49974, 9),
(49966, 52475, 10),
(49966, 52476, 11),
 -- Smite
(585, 585, 1),
(585, 591, 2),
(585, 598, 3),
(585, 984, 4),
(585, 1004, 5),
(585, 6060, 6),
(585, 10933, 7),
(585, 10934, 8),
(585, 25363, 9),
(585, 25364, 10),
(585, 48122, 11),
(585, 48123, 12),
 -- Snatch
(50541, 50541, 1),
(50541, 53537, 2),
(50541, 53538, 3),
(50541, 53540, 4),
(50541, 53542, 5),
(50541, 53543, 6),
 -- Sniper Training
(53302, 53302, 1),
(53302, 53303, 2),
(53302, 53304, 3),
 -- Sonic Blast
(50519, 50519, 1),
(50519, 53564, 2),
(50519, 53565, 3),
(50519, 53566, 4),
(50519, 53567, 5),
(50519, 53568, 6),
 -- Soothe Animal
(2908, 2908, 1),
(2908, 8955, 2),
(2908, 9901, 3),
(2908, 26995, 4),
 -- Soothing Kiss
(6360, 6360, 1),
(6360, 7813, 2),
(6360, 11784, 3),
(6360, 11785, 4),
(6360, 27275, 5),
 -- Soul Fire
(6353, 6353, 1),
(6353, 17924, 2),
(6353, 27211, 3),
(6353, 30545, 4),
(6353, 47824, 5),
(6353, 47825, 6),
 -- Soul Leech
(30293, 30293, 1),
(30293, 30295, 2),
(30293, 30296, 3),
 -- Soul Siphon
(17804, 17804, 1),
(17804, 17805, 2),
 -- Spark of Nature
(48435, 48435, 1),
(48435, 48436, 2),
(48435, 48437, 3),
 -- Spell Deflection
(49145, 49145, 1),
(49145, 49495, 2),
(49145, 49497, 3),
 -- Spell Impact
(11242, 11242, 1),
(11242, 12467, 2),
(11242, 12469, 3),
 -- Spell Lock
(19244, 19244, 1),
(19244, 19647, 2),
 -- Spell Power
(35578, 35578, 1),
(35578, 35581, 2),
 -- Spell Warding
(27900, 27900, 1),
(27900, 27901, 2),
(27900, 27902, 3),
(27900, 27903, 4),
(27900, 27904, 5),
 -- Spider's Bite
(53203, 53203, 1),
(53203, 53204, 2),
(53203, 53205, 3),
 -- Spiked Collar
(53182, 53182, 1),
(53182, 53183, 2),
(53182, 53184, 3),
 -- Spirit
(8112, 8112, 1),
(8112, 8113, 2),
(8112, 8114, 3),
(8112, 12177, 4),
(8112, 33080, 5),
(8112, 43197, 6),
(8112, 48103, 7),
(8112, 48104, 8),
 -- Spirit Strike
(61193, 61193, 1),
(61193, 61194, 2),
(61193, 61195, 3),
(61193, 61196, 4),
(61193, 61197, 5),
(61193, 61198, 6),
 -- Spirit Tap
(15270, 15270, 1),
(15270, 15335, 2),
(15270, 15336, 3),
 -- Spiritual Attunement
(31785, 31785, 1),
(31785, 33776, 2),
 -- Spiritual Focus
(20205, 20205, 1),
(20205, 20206, 2),
(20205, 20207, 3),
(20205, 20209, 4),
(20205, 20208, 5),
 -- Spiritual Guidance
(14901, 14901, 1),
(14901, 15028, 2),
(14901, 15029, 3),
(14901, 15030, 4),
(14901, 15031, 5),
 -- Spiritual Healing
(14898, 14898, 1),
(14898, 15349, 2),
(14898, 15354, 3),
(14898, 15355, 4),
(14898, 15356, 5),
 -- Spore Cloud
(50274, 50274, 1),
(50274, 53593, 2),
(50274, 53594, 3),
(50274, 53596, 4),
(50274, 53597, 5),
(50274, 53598, 6),
 -- Sprint
(2983, 2983, 1),
(2983, 8696, 2),
(2983, 11305, 3),
 -- Stampede
(57386, 57386, 1),
(57386, 57389, 2),
(57386, 57390, 3),
(57386, 57391, 4),
(57386, 57392, 5),
(57386, 57393, 6),
 -- Starfall
(48505, 48505, 1),
(48505, 53199, 2),
(48505, 53200, 3),
(48505, 53201, 4),
 -- Starfire
(2912, 2912, 1),
(2912, 8949, 2),
(2912, 8950, 3),
(2912, 8951, 4),
(2912, 9875, 5),
(2912, 9876, 6),
(2912, 25298, 7),
(2912, 26986, 8),
(2912, 48464, 9),
(2912, 48465, 10),
 -- Starlight Wrath
(16814, 16814, 1),
(16814, 16815, 2),
(16814, 16816, 3),
(16814, 16817, 4),
(16814, 16818, 5),
 -- Static Shock
(51525, 51525, 1),
(51525, 51526, 2),
(51525, 51527, 3),
 -- Steady Shot
(56641, 56641, 1),
(56641, 34120, 2),
(56641, 49051, 3),
(56641, 49052, 4),
 -- Sting
(56626, 56626, 1),
(56626, 56627, 2),
(56626, 56628, 3),
(56626, 56629, 4),
(56626, 56630, 5),
(56626, 56631, 6),
 -- Stoicism
(31844, 31844, 1),
(31844, 31845, 2),
(31844, 53519, 3),
 -- Stoneclaw Totem
(5730, 5730, 1),
(5730, 6390, 2),
(5730, 6391, 3),
(5730, 6392, 4),
(5730, 10427, 5),
(5730, 10428, 6),
(5730, 25525, 7),
(5730, 58580, 8),
(5730, 58581, 9),
(5730, 58582, 10),
 -- Stoneclaw Totem Passive
(5728, 5728, 1),
(5728, 6397, 2),
(5728, 6398, 3),
(5728, 6399, 4),
(5728, 10425, 5),
(5728, 10426, 6),
(5728, 25513, 7),
(5728, 58583, 8),
(5728, 58584, 9),
(5728, 58585, 10),
 -- Stoneskin Totem
(8073, 8073, 1),
(8073, 38115, 2),
 -- Stoneskin Totem
(8071, 8071, 1),
(8071, 8154, 2),
(8071, 8155, 3),
(8071, 10406, 4),
(8071, 10407, 5),
(8071, 10408, 6),
(8071, 25508, 7),
(8071, 25509, 8),
(8071, 58751, 9),
(8071, 58753, 10),
 -- Storm, Earth and Fire
(51483, 51483, 1),
(51483, 51485, 2),
(51483, 51486, 3),
 -- Strength
(8118, 8118, 1),
(8118, 8119, 2),
(8118, 8120, 3),
(8118, 12179, 4),
(8118, 33082, 5),
(8118, 43199, 6),
(8118, 58448, 7),
(8118, 58449, 8),
 -- Strength of Arms
(46865, 46865, 1),
(46865, 46866, 2),
 -- Strength of Earth Totem
(8075, 8075, 1),
(8075, 8160, 2),
(8075, 8161, 3),
(8075, 10442, 4),
(8075, 25361, 5),
(8075, 25528, 6),
(8075, 57622, 7),
(8075, 58643, 8),
 -- Student of the Mind
(44397, 44397, 1),
(44397, 44398, 2),
(44397, 44399, 3),
 -- Stunning Blast
(5648, 5648, 1),
(5648, 5649, 2),
 -- Stunning Blow
(5726, 5726, 1),
(5726, 5727, 2),
 -- Subtlety
(17118, 17118, 1),
(17118, 17119, 2),
(17118, 17120, 3),
 -- Subversion
(48997, 48997, 1),
(48997, 49490, 2),
(48997, 49491, 3),
 -- Sudden Death
(29723, 29723, 1),
(29723, 29725, 2),
(29723, 29724, 3),
 -- Sudden Doom
(49018, 49018, 1),
(49018, 49529, 2),
(49018, 49530, 3),
 -- Suffering
(17735, 17735, 1),
(17735, 17750, 2),
(17735, 17751, 3),
(17735, 17752, 4),
(17735, 27271, 5),
(17735, 33701, 6),
(17735, 47989, 7),
(17735, 47990, 8),
 -- Suppression
(18174, 18174, 1),
(18174, 18175, 2),
(18174, 18176, 3),
 -- Surefooted
(19290, 19290, 1),
(19290, 19294, 2),
(19290, 24283, 3),
 -- Survival Instincts
(34494, 34494, 1),
(34494, 34496, 2),
 -- Survival of the Fittest
(33853, 33853, 1),
(33853, 33855, 2),
(33853, 33856, 3),
 -- Survival Tactics
(19286, 19286, 1),
(19286, 19287, 2),
 -- Survivalist
(19255, 19255, 1),
(19255, 19256, 2),
(19255, 19257, 3),
(19255, 19258, 4),
(19255, 19259, 5),
 -- Swift Retribution
(53379, 53379, 1),
(53379, 53484, 2),
(53379, 53648, 3),
 -- Swipe
(50256, 50256, 1),
(50256, 53526, 2),
(50256, 53528, 3),
(50256, 53529, 4),
(50256, 53532, 5),
(50256, 53533, 6),
 -- Swipe (Bear)
(779, 779, 1),
(779, 780, 2),
(779, 769, 3),
(779, 9754, 4),
(779, 9908, 5),
(779, 26997, 6),
(779, 48561, 7),
(779, 48562, 8),
 -- Sword and Board
(46951, 46951, 1),
(46951, 46952, 2),
(46951, 46953, 3),
 -- Sword Specialization
(12281, 12281, 1),
(12281, 12812, 2),
(12281, 12813, 3),
(12281, 12814, 4),
(12281, 12815, 5),
 -- T.N.T.
(56333, 56333, 1),
(56333, 56336, 2),
(56333, 56337, 3),
 -- Tactical Mastery
(12295, 12295, 1),
(12295, 12676, 2),
(12295, 12677, 3),
 -- Tailoring
(3908, 3908, 1),
(3908, 3909, 2),
(3908, 3910, 3),
(3908, 12180, 4),
(3908, 26790, 5),
(3908, 51309, 6),
 -- Taste for Blood
(56636, 56636, 1),
(56636, 56637, 2),
(56636, 56638, 3),
 -- Tendon Rip
(50271, 50271, 1),
(50271, 53571, 2),
(50271, 53572, 3),
(50271, 53573, 4),
(50271, 53574, 5),
(50271, 53575, 6),
 -- Test of Faith
(47558, 47558, 1),
(47558, 47559, 2),
(47558, 47560, 3),
 -- Thick Hide
(19609, 19609, 1),
(19609, 19610, 2),
(19609, 19612, 3),
 -- Thick Hide
(16929, 16929, 1),
(16929, 16930, 2),
(16929, 16931, 3),
 -- Thorns
(467, 467, 1),
(467, 782, 2),
(467, 1075, 3),
(467, 8914, 4),
(467, 9756, 5),
(467, 9910, 6),
(467, 26992, 7),
(467, 53307, 8),
 -- Threat of Thassarian
(65661, 65661, 1),
(65661, 66191, 2),
(65661, 66192, 3),
 -- Thrill of the Hunt
(34497, 34497, 1),
(34497, 34498, 2),
(34497, 34499, 3),
 -- Throwing Specialization
(5952, 5952, 1),
(5952, 51679, 2),
 -- Thunder Clap
(6343, 6343, 1),
(6343, 8198, 2),
(6343, 8204, 3),
(6343, 8205, 4),
(6343, 11580, 5),
(6343, 11581, 6),
(6343, 25264, 7),
(6343, 47501, 8),
(6343, 47502, 9),
 -- Thundering Strikes
(16255, 16255, 1),
(16255, 16302, 2),
(16255, 16303, 3),
(16255, 16304, 4),
(16255, 16305, 5),
 -- Thunderstorm
(51490, 51490, 1),
(51490, 59156, 2),
(51490, 59158, 3),
(51490, 59159, 4),
 -- Tidal Focus
(16179, 16179, 1),
(16179, 16214, 2),
(16179, 16215, 3),
(16179, 16216, 4),
(16179, 16217, 5),
 -- Tidal Mastery
(16194, 16194, 1),
(16194, 16218, 2),
(16194, 16219, 3),
(16194, 16220, 4),
(16194, 16221, 5),
 -- Tidal Waves
(51562, 51562, 1),
(51562, 51563, 2),
(51562, 51564, 3),
(51562, 51565, 4),
(51562, 51566, 5),
 -- Tiger's Fury
(5217, 5217, 1),
(5217, 6793, 2),
(5217, 9845, 3),
(5217, 9846, 4),
(5217, 50212, 5),
(5217, 50213, 6),
 -- Torment
(3716, 3716, 1),
(3716, 7809, 2),
(3716, 7810, 3),
(3716, 7811, 4),
(3716, 11774, 5),
(3716, 11775, 6),
(3716, 27270, 7),
(3716, 47984, 8),
 -- Torment the Weak
(29447, 29447, 1),
(29447, 55339, 2),
(29447, 55340, 3),
 -- Torture
(47263, 47263, 1),
(47263, 47264, 2),
(47263, 47265, 3),
 -- Totem of Wrath
(30706, 30706, 1),
(30706, 57720, 2),
(30706, 57721, 3),
(30706, 57722, 4),
 -- Totemic Focus
(16173, 16173, 1),
(16173, 16222, 2),
(16173, 16223, 3),
(16173, 16224, 4),
(16173, 16225, 5),
 -- Touched by the Light
(53590, 53590, 1),
(53590, 53591, 2),
(53590, 53592, 3),
 -- Toughness
(53120, 53120, 1),
(53120, 53121, 2),
(53120, 53122, 3),
(53120, 53123, 4),
(53120, 53124, 5),
(53120, 53040, 6),
 -- Toughness
(12299, 12299, 1),
(12299, 12761, 2),
(12299, 12762, 3),
(12299, 12763, 4),
(12299, 12764, 5),
 -- Toughness
(20143, 20143, 1),
(20143, 20144, 2),
(20143, 20145, 3),
(20143, 20146, 4),
(20143, 20147, 5),
 -- Toughness
(16252, 16252, 1),
(16252, 16306, 2),
(16252, 16307, 3),
(16252, 16308, 4),
(16252, 16309, 5),
 -- Toughness
(49042, 49042, 1),
(49042, 49786, 2),
(49042, 49787, 3),
(49042, 49788, 4),
(49042, 49789, 5),
 -- Tranquil Spirit
(24968, 24968, 1),
(24968, 24969, 2),
(24968, 24970, 3),
(24968, 24971, 4),
(24968, 24972, 5),
 -- Trap Mastery
(19376, 19376, 1),
(19376, 63457, 2),
(19376, 63458, 3),
 -- Tundra Stalker
(49202, 49202, 1),
(49202, 50127, 2),
(49202, 50128, 3),
(49202, 50129, 4),
(49202, 50130, 5),
 -- Turn the Tables
(51627, 51627, 1),
(51627, 51628, 2),
(51627, 51629, 3),
 -- Twin Disciplines
(47586, 47586, 1),
(47586, 47587, 2),
(47586, 47588, 3),
(47586, 52802, 4),
(47586, 52803, 5),
 -- Twisted Faith
(47573, 47573, 1),
(47573, 47577, 2),
(47573, 47578, 3),
(47573, 51166, 4),
(47573, 51167, 5),
 -- Two-Handed Weapon Specialization
(12163, 12163, 1),
(12163, 12711, 2),
(12163, 12712, 3),
 -- Two-Handed Weapon Specialization
(20111, 20111, 1),
(20111, 20112, 2),
(20111, 20113, 3),
 -- Two-Handed Weapon Specialization
(55107, 55107, 1),
(55107, 55108, 2),
 -- Unbreakable Will
(14522, 14522, 1),
(14522, 14788, 2),
(14522, 14789, 3),
(14522, 14790, 4),
(14522, 14791, 5),
 -- Unending Fury
(56927, 56927, 1),
(56927, 56929, 2),
(56927, 56930, 3),
(56927, 56931, 4),
(56927, 56932, 5),
 -- Unholy Command
(49588, 49588, 1),
(49588, 49589, 2),
 -- Unholy Power
(18769, 18769, 1),
(18769, 18770, 2),
(18769, 18771, 3),
(18769, 18772, 4),
(18769, 18773, 5),
 -- Unleashed Fury
(19616, 19616, 1),
(19616, 19617, 2),
(19616, 19618, 3),
(19616, 19619, 4),
(19616, 19620, 5),
 -- Unrelenting Assault
(46859, 46859, 1),
(46859, 46860, 2),
 -- Unrelenting Storm
(30664, 30664, 1),
(30664, 30665, 2),
(30664, 30666, 3),
 -- Unstable Affliction
(30108, 30108, 1),
(30108, 30404, 2),
(30108, 30405, 3),
(30108, 47841, 4),
(30108, 47843, 5),
 -- Unyielding Faith
(9453, 9453, 1),
(9453, 25836, 2),
 -- Vampiric Touch
(34914, 34914, 1),
(34914, 34916, 2),
(34914, 34917, 3),
(34914, 48159, 4),
(34914, 48160, 5),
 -- Vanish
(1856, 1856, 1),
(1856, 1857, 2),
(1856, 26889, 3),
 -- Veiled Shadows
(15274, 15274, 1),
(15274, 15311, 2),
 -- Vendetta
(49015, 49015, 1),
(49015, 50154, 2),
(49015, 55136, 3),
 -- Vengeance
(20049, 20049, 1),
(20049, 20056, 2),
(20049, 20057, 3),
 -- Vengeance
(16909, 16909, 1),
(16909, 16910, 2),
(16909, 16911, 3),
(16909, 16912, 4),
(16909, 16913, 5),
 -- Venom Web Spray
(54706, 54706, 1),
(54706, 55505, 2),
(54706, 55506, 3),
(54706, 55507, 4),
(54706, 55508, 5),
(54706, 55509, 6),
 -- Veteran of the Third War
(49006, 49006, 1),
(49006, 49526, 2),
(49006, 50029, 3),
 -- Vicious Strikes
(51745, 51745, 1),
(51745, 51746, 2),
 -- Vile Poisons
(16513, 16513, 1),
(16513, 16514, 2),
(16513, 16515, 3),
 -- Virulence
(48962, 48962, 1),
(48962, 49567, 2),
(48962, 49568, 3),
 -- Vitality
(31122, 31122, 1),
(31122, 31123, 2),
(31122, 61329, 3),
 -- Vitality
(29140, 29140, 1),
(29140, 29143, 2),
(29140, 29144, 3),
 -- Wand Specialization
(14524, 14524, 1),
(14524, 14525, 2),
(14524, 14526, 3),
(14524, 14527, 4),
(14524, 14528, 5),
 -- Wandering Plague
(49217, 49217, 1),
(49217, 49654, 2),
(49217, 49655, 3),
 -- Water Shield
(52127, 52127, 1),
(52127, 52129, 2),
(52127, 52131, 3),
(52127, 52134, 4),
(52127, 52136, 5),
(52127, 52138, 6),
(52127, 24398, 7),
(52127, 33736, 8),
(52127, 57960, 9),
 -- Waylay
(51692, 51692, 1),
(51692, 51696, 2),
 -- Weapon Expertise
(30919, 30919, 1),
(30919, 30920, 2),
 -- Weapon Mastery
(20504, 20504, 1),
(20504, 20505, 2),
 -- Weapon Mastery
(29082, 29082, 1),
(29082, 29084, 2),
(29082, 29086, 3),
 -- Wild Growth
(48438, 48438, 1),
(48438, 53248, 2),
(48438, 53249, 3),
(48438, 53251, 4),
 -- Wild Hunt
(62758, 62758, 1),
(62758, 62762, 2),
 -- Wild Quiver
(53215, 53215, 1),
(53215, 53216, 2),
(53215, 53217, 3),
 -- Windfury Weapon
(8232, 8232, 1),
(8232, 8235, 2),
(8232, 10486, 3),
(8232, 16362, 4),
(8232, 25505, 5),
(8232, 58801, 6),
(8232, 58803, 7),
(8232, 58804, 8),
 -- Winter's Chill
(11180, 11180, 1),
(11180, 28592, 2),
(11180, 28593, 3),
 -- World in Flames
(11108, 11108, 1),
(11108, 12349, 2),
(11108, 12350, 3),
 -- Wrath
(5176, 5176, 1),
(5176, 5177, 2),
(5176, 5178, 3),
(5176, 5179, 4),
(5176, 5180, 5),
(5176, 6780, 6),
(5176, 8905, 7),
(5176, 9912, 8),
(5176, 26984, 9),
(5176, 26985, 10),
(5176, 48459, 11),
(5176, 48461, 12),
 -- Wrath of Cenarius
(33603, 33603, 1),
(33603, 33604, 2),
(33603, 33605, 3),
(33603, 33606, 4),
(33603, 33607, 5),
 -- Wrecking Crew
(46867, 46867, 1),
(46867, 56611, 2),
(46867, 56612, 3),
(46867, 56613, 4),
(46867, 56614, 5),
 -- Arcane Brilliance
(23030, 23030, 1),
(23030, 27394, 2),
 -- Arcane Explosion
(1467, 1467, 1),
(1467, 8440, 2),
(1467, 8441, 3),
(1467, 8442, 4),
(1467, 10203, 5),
(1467, 10204, 6),
(1467, 27380, 7),
(1467, 27381, 8),
 -- Arcane Intellect
(1472, 1472, 1),
(1472, 1473, 2),
(1472, 1474, 3),
(1472, 1475, 4),
(1472, 10158, 5),
(1472, 27393, 6),
(1472, 42999, 7),
 -- Arcane Missiles
(5143, 5143, 1),
(5143, 5144, 2),
(5143, 5145, 3),
(5143, 8416, 4),
(5143, 8417, 5),
(5143, 10211, 6),
(5143, 10212, 7),
(5143, 25345, 8),
(5143, 27075, 9),
(5143, 38699, 10),
(5143, 38704, 11),
(5143, 42843, 12),
(5143, 42846, 13),
 -- Blessed Recovery
(27811, 27811, 1),
(27811, 27815, 2),
(27811, 27816, 3),
 -- Blessed Recovery
(27813, 27813, 1),
(27813, 27817, 2),
(27813, 27818, 3),
 -- Blessed Resilience
(33142, 33142, 1),
(33142, 33145, 2),
(33142, 33146, 3),
 -- Blizzard
(1196, 1196, 1),
(1196, 6142, 2),
(1196, 8428, 3),
(1196, 10188, 4),
(1196, 10189, 5),
(1196, 10190, 6),
(1196, 27384, 7),
 -- Blizzard
(42208, 42208, 1),
(42208, 42209, 2),
(42208, 42210, 3),
(42208, 42211, 4),
(42208, 42212, 5),
(42208, 42213, 6),
(42208, 42198, 7),
(42208, 42937, 8),
(42208, 42938, 9),
 -- Blizzard
(10, 10, 1),
(10, 6141, 2),
(10, 8427, 3),
(10, 10185, 4),
(10, 10186, 5),
(10, 10187, 6),
(10, 27085, 7),
(10, 42939, 8),
(10, 42940, 9),
 -- Chain Lightning
(421, 421, 1),
(421, 930, 2),
(421, 2860, 3),
(421, 10605, 4),
(421, 25439, 5),
(421, 25442, 6),
(421, 49270, 7),
(421, 49271, 8),
 -- Chain Lightning
(45297, 45297, 1),
(45297, 45298, 2),
(45297, 45299, 3),
(45297, 45300, 4),
(45297, 45301, 5),
(45297, 45302, 6),
(45297, 49268, 7),
(45297, 49269, 8),
 -- Charge
(7370, 7370, 1),
(7370, 26184, 2),
(7370, 26185, 3),
(7370, 26186, 4),
(7370, 26202, 5),
(7370, 28343, 6),
 -- Consume Shadows
(17776, 17776, 1),
(17776, 17855, 2),
(17776, 17856, 3),
(17776, 17857, 4),
(17776, 17859, 5),
(17776, 17860, 6),
 -- Consume Shadows
(20387, 20387, 1),
(20387, 20388, 2),
(20387, 20389, 3),
(20387, 20390, 4),
(20387, 20391, 5),
(20387, 20392, 6),
(20387, 27491, 7),
(20387, 48003, 8),
(20387, 48004, 9),
 -- Cower
(1747, 1747, 1),
(1747, 1748, 2),
(1747, 1749, 3),
(1747, 1750, 4),
(1747, 1751, 5),
(1747, 16698, 6),
(1747, 27346, 7),
 -- Echoes of Lordaeron
(6966, 6966, 1),
(6966, 30880, 2),
(6966, 30683, 3),
(6966, 30682, 4),
(6966, 29520, 5),
 -- Echoes of Lordaeron
(6964, 6964, 1),
(6964, 11413, 2),
(6964, 11414, 3),
(6964, 11415, 4),
(6964, 1386, 5),
 -- Eye for an Eye
(9799, 9799, 1),
(9799, 25988, 2),
 -- Fire Nova
(1535, 1535, 1),
(1535, 8498, 2),
(1535, 8499, 3),
(1535, 11314, 4),
(1535, 11315, 5),
(1535, 25546, 6),
(1535, 25547, 7),
(1535, 61649, 8),
(1535, 61657, 9),
 -- Fire Nova
(8349, 8349, 1),
(8349, 8502, 2),
(8349, 8503, 3),
(8349, 11306, 4),
(8349, 11307, 5),
(8349, 25535, 6),
(8349, 25537, 7),
(8349, 61650, 8),
(8349, 61654, 9),
 -- Fire Protection
(7230, 7230, 1),
(7230, 7231, 2),
(7230, 7232, 3),
(7230, 7233, 4),
(7230, 7234, 5),
 -- Fire Resistance
(24440, 24440, 1),
(24440, 24441, 2),
(24440, 24463, 3),
(24440, 24464, 4),
(24440, 27351, 5),
 -- Fire Resistance
(8185, 8185, 1),
(8185, 10534, 2),
(8185, 10535, 3),
(8185, 25562, 4),
(8185, 58738, 5),
(8185, 58740, 6),
 -- Fire Shield
(2949, 2949, 1),
(2949, 8318, 2),
(2949, 8319, 3),
(2949, 11772, 4),
(2949, 11773, 5),
(2949, 27486, 6),
 -- Fire Shield
(20322, 20322, 1),
(20322, 20323, 2),
(20322, 20324, 3),
(20322, 20326, 4),
(20322, 20327, 5),
(20322, 27489, 6),
(20322, 47998, 7),
 -- Flameblade
(7829, 7829, 1),
(7829, 7874, 2),
(7829, 7875, 3),
 -- Flameblade
(7806, 7806, 1),
(7806, 7807, 2),
(7806, 7808, 3),
 -- Flurry
(12319, 12319, 1),
(12319, 12971, 2),
(12319, 12972, 3),
(12319, 12973, 4),
(12319, 12974, 5),
 -- Flurry
(12966, 12966, 1),
(12966, 12967, 2),
(12966, 12968, 3),
(12966, 12969, 4),
(12966, 12970, 5),
 -- Focused Will
(45234, 45234, 1),
(45234, 45243, 2),
(45234, 45244, 3),
 -- Focused Will
(45237, 45237, 1),
(45237, 45241, 2),
(45237, 45242, 3),
 -- Frost Nova
(1194, 1194, 1),
(1194, 1225, 2),
(1194, 6132, 3),
(1194, 10231, 4),
(1194, 27387, 5),
 -- Frost Protection
(7240, 7240, 1),
(7240, 7236, 2),
(7240, 7238, 3),
(7240, 7237, 4),
(7240, 7239, 5),
 -- Frost Resistance
(24475, 24475, 1),
(24475, 24476, 2),
(24475, 24477, 3),
(24475, 24478, 4),
(24475, 27352, 5),
 -- Frost Resistance
(8182, 8182, 1),
(8182, 10476, 2),
(8182, 10477, 3),
(8182, 25559, 4),
(8182, 58742, 5),
(8182, 58744, 6),
 -- Frostbrand Attack
(8034, 8034, 1),
(8034, 8037, 2),
(8034, 10458, 3),
(8034, 16352, 4),
(8034, 16353, 5),
(8034, 25501, 6),
(8034, 58797, 7),
(8034, 58798, 8),
(8034, 58799, 9),
 -- Healing Stream
(5672, 5672, 1),
(5672, 6371, 2),
(5672, 6372, 3),
(5672, 10460, 4),
(5672, 10461, 5),
(5672, 25566, 6),
(5672, 58763, 7),
(5672, 58764, 8),
(5672, 58765, 9),
 -- Holy Nova
(15237, 15237, 1),
(15237, 15430, 2),
(15237, 15431, 3),
(15237, 27799, 4),
(15237, 27800, 5),
(15237, 27801, 6),
(15237, 25331, 7),
(15237, 48077, 8),
(15237, 48078, 9),
 -- Holy Nova
(23455, 23455, 1),
(23455, 23458, 2),
(23455, 23459, 3),
(23455, 27803, 4),
(23455, 27804, 5),
(23455, 27805, 6),
(23455, 25329, 7),
(23455, 48075, 8),
(23455, 48076, 9),
 -- Holy Protection
(7245, 7245, 1),
(7245, 7246, 2),
(7245, 7247, 3),
(7245, 7248, 4),
(7245, 7249, 5),
(7245, 17545, 6),
 -- Holy Shock
(20473, 20473, 1),
(20473, 20929, 2),
(20473, 20930, 3),
(20473, 27174, 4),
(20473, 33072, 5),
(20473, 48824, 6),
(20473, 48825, 7),
 -- Holy Shock
(25912, 25912, 1),
(25912, 25911, 2),
(25912, 25902, 3),
(25912, 27176, 4),
(25912, 33073, 5),
(25912, 48822, 6),
(25912, 48823, 7),
 -- Holy Shock
(25914, 25914, 1),
(25914, 25913, 2),
(25914, 25903, 3),
(25914, 27175, 4),
(25914, 33074, 5),
(25914, 48820, 6),
(25914, 48821, 7),
 -- Hurricane
(16914, 16914, 1),
(16914, 17401, 2),
(16914, 17402, 3),
(16914, 27012, 4),
(16914, 48467, 5),
 -- Hurricane
(42231, 42231, 1),
(42231, 42232, 2),
(42231, 42233, 3),
(42231, 42230, 4),
(42231, 48466, 5),
 -- Immolation Trap
(13795, 13795, 1),
(13795, 14302, 2),
(13795, 14303, 3),
(13795, 14304, 4),
(13795, 14305, 5),
(13795, 27023, 6),
(13795, 49055, 7),
(13795, 49056, 8),
 -- Impact
(11103, 11103, 1),
(11103, 12357, 2),
(11103, 12358, 3),
 -- Improved Mend Pet
(19572, 19572, 1),
(19572, 19573, 2),
 -- Infusion of Light
(53569, 53569, 1),
(53569, 53576, 2),
 -- Initiative
(13976, 13976, 1),
(13976, 13979, 2),
(13976, 13980, 3),
 -- Intercept
(30154, 30154, 1),
(30154, 30199, 2),
(30154, 30200, 3),
 -- Intercept
(30153, 30153, 1),
(30153, 30195, 2),
(30153, 30197, 3),
(30153, 47995, 4),
 -- Intercept
(30151, 30151, 1),
(30151, 30194, 2),
(30151, 30198, 3),
(30151, 47996, 4),
 -- Lash of Pain
(7876, 7876, 1),
(7876, 7877, 2),
(7876, 7878, 3),
(7876, 11781, 4),
(7876, 11782, 5),
(7876, 11783, 6),
 -- Lay on Hands
(20233, 20233, 1),
(20233, 20236, 2),
 -- Lay on Hands
(17233, 17233, 1),
(17233, 9257, 2),
 -- Lightning Bolt
(403, 403, 1),
(403, 529, 2),
(403, 548, 3),
(403, 915, 4),
(403, 943, 5),
(403, 6041, 6),
(403, 10391, 7),
(403, 10392, 8),
(403, 15207, 9),
(403, 15208, 10),
(403, 25448, 11),
(403, 25449, 12),
(403, 49237, 13),
(403, 49238, 14),
 -- Lightning Bolt
(45284, 45284, 1),
(45284, 45286, 2),
(45284, 45287, 3),
(45284, 45288, 4),
(45284, 45289, 5),
(45284, 45290, 6),
(45284, 45291, 7),
(45284, 45292, 8),
(45284, 45293, 9),
(45284, 45294, 10),
(45284, 45295, 11),
(45284, 45296, 12),
(45284, 49239, 13),
(45284, 49240, 14),
 -- Lightning Shield
(324, 324, 1),
(324, 325, 2),
(324, 905, 3),
(324, 945, 4),
(324, 8134, 5),
(324, 10431, 6),
(324, 10432, 7),
(324, 25469, 8),
(324, 25472, 9),
(324, 49280, 10),
(324, 49281, 11),
 -- Lightning Shield
(26364, 26364, 1),
(26364, 26365, 2),
(26364, 26366, 3),
(26364, 26367, 4),
(26364, 26369, 5),
(26364, 26370, 6),
(26364, 26363, 7),
(26364, 26371, 8),
(26364, 26372, 9),
(26364, 49278, 10),
(26364, 49279, 11),
 -- Living Bomb
(44457, 44457, 1),
(44457, 55359, 2),
(44457, 55360, 3),
 -- Living Bomb
(44461, 44461, 1),
(44461, 55361, 2),
(44461, 55362, 3),
 -- Mind Sear
(48045, 48045, 1),
(48045, 53023, 2),
 -- Mind Sear
(49821, 49821, 1),
(49821, 53022, 2),
 -- Molten Armor
(34913, 34913, 1),
(34913, 43043, 2),
(34913, 43044, 3),
 -- Molten Armor
(30482, 30482, 1),
(30482, 43045, 2),
(30482, 43046, 3),
 -- Nature Protection
(7250, 7250, 1),
(7250, 7251, 2),
(7250, 7252, 3),
(7250, 7253, 4),
(7250, 7254, 5),
 -- Nature Resistance
(24494, 24494, 1),
(24494, 24511, 2),
(24494, 24512, 3),
(24494, 24513, 4),
(24494, 27354, 5),
 -- Nature Resistance
(10596, 10596, 1),
(10596, 10598, 2),
(10596, 10599, 3),
(10596, 25573, 4),
(10596, 58748, 5),
(10596, 58750, 6),
 -- On a Pale Horse
(49146, 49146, 1),
(49146, 51267, 2),
 -- Penance
(47540, 47540, 1),
(47540, 53005, 2),
(47540, 53006, 3),
(47540, 53007, 4),
 -- Penance
(47750, 47750, 1),
(47750, 52983, 2),
(47750, 52984, 3),
(47750, 52985, 4),
 -- Penance
(47666, 47666, 1),
(47666, 52998, 2),
(47666, 52999, 3),
(47666, 53000, 4),
 -- Plague Strike
(59133, 59133, 1),
(59133, 66988, 2),
(59133, 66989, 3),
(59133, 66990, 4),
(59133, 66991, 5),
(59133, 66992, 6),
 -- Prowl
(24451, 24451, 1),
(24451, 24454, 2),
(24451, 24455, 3),
 -- Rain of Fire
(42223, 42223, 1),
(42223, 42224, 2),
(42223, 42225, 3),
(42223, 42226, 4),
(42223, 42218, 5),
(42223, 47817, 6),
(42223, 47818, 7),
 -- Rain of Fire
(5740, 5740, 1),
(5740, 6219, 2),
(5740, 11677, 3),
(5740, 11678, 4),
(5740, 27212, 5),
(5740, 47819, 6),
(5740, 47820, 7),
 -- Sacrifice
(7885, 7885, 1),
(7885, 19439, 2),
(7885, 19444, 3),
(7885, 19445, 4),
(7885, 19446, 5),
(7885, 19447, 6),
 -- Sacrifice
(20381, 20381, 1),
(20381, 20382, 2),
(20381, 20383, 3),
(20381, 20384, 4),
(20381, 20385, 5),
(20381, 20386, 6),
(20381, 27492, 7),
(20381, 48001, 8),
(20381, 48002, 9),
 -- Safeguard
(46945, 46945, 1),
(46945, 46949, 2),
 -- Safeguard
(46946, 46946, 1),
(46946, 46947, 2),
 -- Seed of Corruption
(27285, 27285, 1),
(27285, 47833, 2),
(27285, 47834, 3),
 -- Seed of Corruption
(27243, 27243, 1),
(27243, 47835, 2),
(27243, 47836, 3),
 -- Shadow Protection
(7235, 7235, 1),
(7235, 7241, 2),
(7235, 7242, 3),
(7235, 7243, 4),
(7235, 7244, 5),
 -- Shadow Resistance
(24490, 24490, 1),
(24490, 24514, 2),
(24490, 24515, 3),
(24490, 24516, 4),
(24490, 27353, 5),
 -- Soothing Kiss
(6362, 6362, 1),
(6362, 7879, 2),
(6362, 11786, 3),
(6362, 11787, 4),
 -- Soothing Kiss
(20403, 20403, 1),
(20403, 20404, 2),
(20403, 20405, 3),
(20403, 20406, 4),
(20403, 27494, 5),
 -- Spell Lock
(19648, 19648, 1),
(19648, 19650, 2),
 -- Spell Lock
(20433, 20433, 1),
(20433, 20434, 2),
 -- Starfall
(50286, 50286, 1),
(50286, 53196, 2),
(50286, 53197, 3),
(50286, 53198, 4),
 -- Starfall
(50294, 50294, 1),
(50294, 53188, 2),
(50294, 53189, 3),
(50294, 53190, 4),
 -- Starfall
(50288, 50288, 1),
(50288, 53191, 2),
(50288, 53194, 3),
(50288, 53195, 4),
 -- Suffering
(17736, 17736, 1),
(17736, 17753, 2),
(17736, 17754, 3),
(17736, 17755, 4),
 -- Suffering
(20393, 20393, 1),
(20393, 20394, 2),
(20393, 20395, 3),
(20393, 20396, 4),
(20393, 27500, 5),
(20393, 33703, 6),
(20393, 48005, 7),
(20393, 48006, 8),
 -- Surge of Light
(33150, 33150, 1),
(33150, 33154, 2),
 -- Tainted Blood
(19661, 19661, 1),
(19661, 19662, 2),
(19661, 19663, 3),
(19661, 19664, 4),
 -- Tainted Blood
(20429, 20429, 1),
(20429, 20430, 2),
(20429, 20431, 3),
(20429, 20432, 4),
(20429, 27497, 5),
 -- The Art of War
(53486, 53486, 1),
(53486, 53488, 2),
 -- Thick Skin
(5364, 5364, 1),
(5364, 5368, 2),
(5364, 5369, 3),
(5364, 5370, 4),
 -- Thick Skin
(5363, 5363, 1),
(5363, 5365, 2),
(5363, 5366, 3),
(5363, 5367, 4),
 -- Torment
(7881, 7881, 1),
(7881, 7882, 2),
(7881, 7883, 3),
(7881, 7884, 4),
(7881, 11776, 5),
(7881, 11777, 6),
 -- Tough Shell
(4112, 4112, 1),
(4112, 4113, 2),
(4112, 4115, 3),
(4112, 4114, 4),
 -- Tough Shell
(4107, 4107, 1),
(4107, 4108, 2),
(4107, 4109, 3),
(4107, 4111, 4),
 -- Tranquility
(740, 740, 1),
(740, 8918, 2),
(740, 9862, 3),
(740, 9863, 4),
(740, 26983, 5),
(740, 48446, 6),
(740, 48447, 7),
 -- Tranquility
(44203, 44203, 1),
(44203, 44205, 2),
(44203, 44206, 3),
(44203, 44207, 4),
(44203, 44208, 5),
(44203, 48444, 6),
(44203, 48445, 7),
 -- Typhoon
(61391, 61391, 1),
(61391, 61390, 2),
(61391, 61388, 3),
(61391, 61387, 4),
(61391, 53227, 5),
 -- Typhoon
(50516, 50516, 1),
(50516, 53223, 2),
(50516, 53225, 3),
(50516, 53226, 4),
(50516, 61384, 5),
 -- Unfair Advantage
(51675, 51675, 1),
(51675, 51677, 2),
 -- Unfair Advantage
(51672, 51672, 1),
(51672, 51674, 2),
 -- Unleashed Rage
(30802, 30802, 1),
(30802, 30808, 2),
(30802, 30809, 3),
 -- Vindication
(9452, 9452, 1),
(9452, 26016, 2),
 -- Vindication
(67, 67, 1),
(67, 26017, 2),
 -- Volley
(42243, 42243, 1),
(42243, 42244, 2),
(42243, 42245, 3),
(42243, 42234, 4),
(42243, 58432, 5),
(42243, 58433, 6),
 -- Volley
(1510, 1510, 1),
(1510, 14294, 2),
(1510, 14295, 3),
(1510, 27022, 4),
(1510, 58431, 5),
(1510, 58434, 6),
 -- Will of the Necropolis
(52284, 52284, 1),
(52284, 52285, 2),
(52284, 52286, 3),
 -- Will of the Necropolis
(49189, 49189, 1),
(49189, 50149, 2),
(49189, 50150, 3),
 -- Wyvern Sting
(19386, 19386, 1),
(19386, 24132, 2),
(19386, 24133, 3),
(19386, 27068, 4),
(19386, 49011, 5),
(19386, 49012, 6),
 -- First Aid
(746, 746, 1),
(746, 1159, 2),
(746, 3267, 3),
(746, 3268, 4),
(746, 7926, 5),
(746, 7927, 6),
(746, 10838, 7),
(746, 10839, 8),
(746, 18608, 9),
(746, 18610, 10),
(746, 27030, 11),
(746, 27031, 12),
(746, 45543, 13),
(746, 51827, 14),
(746, 45544, 15),
(746, 51803, 16),
 -- Frost Strike
(49143, 49143, 1),
(49143, 51416, 2),
(49143, 51417, 3),
(49143, 51418, 4),
(49143, 51419, 5),
(49143, 55268, 6),
 -- Intercept
(20253, 20253, 1),
(20253, 20614, 2),
(20253, 20615, 3),
(20253, 25273, 4),
(20253, 25274, 5),
 -- Misery
(33191, 33191, 1),
(33191, 33192, 2),
(33191, 33193, 3),
 -- Misery
(33196, 33196, 1),
(33196, 33197, 2),
(33196, 33198, 3),
 -- Obliterate
(49020, 49020, 1),
(49020, 51423, 2),
(49020, 51424, 3),
(49020, 51425, 4),
 -- Penance
(47758, 47758, 1),
(47758, 53001, 2),
(47758, 53002, 3),
(47758, 53003, 4),
 -- Penance
(47757, 47757, 1),
(47757, 52986, 2),
(47757, 52987, 3),
(47757, 52988, 4),
 -- Savage Rend
(50498, 50498, 1),
(50498, 53578, 2),
(50498, 53579, 3),
(50498, 53580, 4),
(50498, 53581, 5),
(50498, 53582, 6),
 -- Spirit Bond
(19578, 19578, 1),
(19578, 20895, 2),
 -- Spirit Bond
(19579, 19579, 1),
(19579, 24529, 2),
 -- Stoneskin
(8072, 8072, 1),
(8072, 8156, 2),
(8072, 8157, 3),
(8072, 10403, 4),
(8072, 10404, 5),
(8072, 10405, 6),
(8072, 25506, 7),
(8072, 25507, 8),
(8072, 58752, 9),
(8072, 58754, 10),
 -- Attack
(3606, 3606, 1),
(3606, 6350, 2),
(3606, 6351, 3),
(3606, 6352, 4),
(3606, 10435, 5),
(3606, 10436, 6),
(3606, 25530, 7),
(3606, 58700, 8),
(3606, 58701, 9),
(3606, 58702, 10),
 -- Blood Strike
(45902, 45902, 1),
(45902, 49926, 2),
(45902, 49927, 3),
(45902, 49928, 4),
(45902, 49929, 5),
(45902, 49930, 6),
 -- Elemental Devastation
(30160, 30160, 1),
(30160, 29179, 2),
(30160, 29180, 3),
 -- Elemental Devastation
(30165, 30165, 1),
(30165, 29177, 2),
(30165, 29178, 3),
 -- Fishing
(7620, 7620, 1),
(7620, 7731, 2),
(7620, 7732, 3),
(7620, 18248, 4),
(7620, 33095, 5),
(7620, 51294, 6),
 -- Icy Touch
(45477, 45477, 1),
(45477, 49896, 2),
(45477, 49903, 3),
(45477, 49904, 4),
(45477, 49909, 5),
 -- Judgements of the Pure
(53671, 53671, 1),
(53671, 53673, 2),
(53671, 54151, 3),
(53671, 54154, 4),
(53671, 54155, 5),
 -- Judgements of the Pure
(53655, 53655, 1),
(53655, 53656, 2),
(53655, 53657, 3),
(53655, 54152, 4),
(53655, 54153, 5),
 -- Master Tactician
(34506, 34506, 1),
(34506, 34507, 2),
(34506, 34508, 3),
(34506, 34838, 4),
(34506, 34839, 5),
 -- Master Tactician
(34833, 34833, 1),
(34833, 34834, 2),
(34833, 34835, 3),
(34833, 34836, 4),
(34833, 34837, 5),
 -- Plague Strike
(45462, 45462, 1),
(45462, 49917, 2),
(45462, 49918, 3),
(45462, 49919, 4),
(45462, 49920, 5),
(45462, 49921, 6),
 -- Rapid Killing
(34948, 34948, 1),
(34948, 34949, 2),
 -- Rapid Killing
(35098, 35098, 1),
(35098, 35099, 2),
 -- Second Wind
(29841, 29841, 1),
(29841, 29842, 2),
 -- Second Wind
(29834, 29834, 1),
(29834, 29838, 2),
 -- Strength of Earth
(8076, 8076, 1),
(8076, 8162, 2),
(8076, 8163, 3),
(8076, 10441, 4),
(8076, 25362, 5),
(8076, 25527, 6),
(8076, 57621, 7),
(8076, 58646, 8),
 -- Trauma
(46854, 46854, 1),
(46854, 46855, 2),
 -- Trauma
(46856, 46856, 1),
(46856, 46857, 2),
 -- Unbridled Wrath
(12322, 12322, 1),
(12322, 12999, 2),
(12322, 13000, 3),
(12322, 13001, 4),
(12322, 13002, 5),
 -- Vanish
(11327, 11327, 1),
(11327, 11329, 2),
(11327, 26888, 3),
 -- Blood Gorged
(50096, 50096, 1),
(50096, 50108, 2),
(50096, 50109, 3),
(50096, 50110, 4),
(50096, 50111, 5),
 -- Blood Gorged
(61274, 61274, 1),
(61274, 61275, 2),
(61274, 61276, 3),
(61274, 61277, 4),
(61274, 61278, 5),
 -- Blood Gorged
(61154, 61154, 1),
(61154, 61155, 2),
(61154, 61156, 3),
(61154, 61157, 4),
(61154, 61158, 5),
 -- Cone of Cold
(1241, 1241, 1),
(1241, 8493, 2),
(1241, 10162, 3),
(1241, 10163, 4),
(1241, 10164, 5),
(1241, 27386, 6),
 -- Flamestrike
(2124, 2124, 1),
(2124, 2125, 2),
(2124, 8425, 3),
(2124, 8426, 4),
(2124, 10217, 5),
(2124, 10218, 6),
(2124, 27385, 7),
 -- Anesthetic Poison
(26688, 26688, 1),
(26688, 57981, 2),
 -- Anesthetic Poison
(26785, 26785, 1),
(26785, 57982, 2),
 -- Apprentice Riding
(33388, 33388, 1),
(33388, 33391, 2),
(33388, 34090, 3),
(33388, 34091, 4),
 -- Primal Fury
(16958, 16958, 1),
(16958, 16961, 2),
 -- Primal Fury
(37116, 37116, 1),
(37116, 37117, 2),
 -- Nature Resist
(4548, 4548, 1),
(4548, 24502, 2),
(4548, 24503, 3),
(4548, 24504, 4),
(4548, 27055, 5),
 -- Instant Poison
(8680, 8680, 1),
(8680, 8685, 2),
(8680, 8689, 3),
(8680, 11335, 4),
(8680, 11336, 5),
(8680, 11337, 6),
(8680, 26890, 7),
(8680, 57964, 8),
(8680, 57965, 9),
 -- Instant Poison
(8679, 8679, 1),
(8679, 8686, 2),
(8679, 8688, 3),
(8679, 11338, 4),
(8679, 11339, 5),
(8679, 11340, 6),
(8679, 26891, 7),
(8679, 57967, 8),
(8679, 57968, 9),
 -- Claw
(2980, 2980, 1),
(2980, 2981, 2),
(2980, 2982, 3),
(2980, 3667, 4),
(2980, 2975, 5),
(2980, 2976, 6),
(2980, 2977, 7),
(2980, 3666, 8),
(2980, 27347, 9),
 -- Mace Specialization
(12284, 12284, 1),
(12284, 12701, 2),
(12284, 12702, 3),
(12284, 12703, 4),
(12284, 12704, 5),
 -- Deadly Toxin
(11539, 11539, 1),
(11539, 11471, 2),
(11539, 11470, 3),
(11539, 11469, 4),
 -- Deadly Poison
(2818, 2818, 1),
(2818, 2819, 2),
(2818, 11353, 3),
(2818, 11354, 4),
(2818, 25349, 5),
(2818, 26968, 6),
(2818, 27187, 7),
(2818, 57969, 8),
(2818, 57970, 9),
 -- Deadly Poison
(2823, 2823, 1),
(2823, 2824, 2),
(2823, 11355, 3),
(2823, 11356, 4),
(2823, 25351, 5),
(2823, 26967, 6),
(2823, 27186, 7),
(2823, 57972, 8),
(2823, 57973, 9),
 -- On a Pale Horse
(51983, 51983, 1),
(51983, 51986, 2),
 -- On a Pale Horse
(51969, 51969, 1),
(51969, 51970, 2),
 -- Wound Poison
(13218, 13218, 1),
(13218, 13222, 2),
(13218, 13223, 3),
(13218, 13224, 4),
(13218, 27189, 5),
(13218, 57974, 6),
(13218, 57975, 7),
 -- Wound Poison
(13219, 13219, 1),
(13219, 13225, 2),
(13219, 13226, 3),
(13219, 13227, 4),
(13219, 27188, 5),
(13219, 57977, 6),
(13219, 57978, 7),
 -- Thunderstomp
(26094, 26094, 1),
(26094, 26189, 2),
(26094, 26190, 3),
(26094, 27366, 4),
 -- Obliterate
(66198, 66198, 1),
(66198, 66972, 2),
(66198, 66973, 3),
(66198, 66974, 4),
 -- Frost Strike
(66196, 66196, 1),
(66196, 66958, 2),
(66196, 66959, 3),
(66196, 66960, 4),
(66196, 66961, 5),
(66196, 66962, 6),
 -- Death Strike
(66188, 66188, 1),
(66188, 66950, 2),
(66188, 66951, 3),
(66188, 66952, 4),
(66188, 66953, 5),
 -- Fiery Payback
(44440, 44440, 1),
(44440, 44441, 2),
 -- Fiery Payback
(64353, 64353, 1),
(64353, 64357, 2),
 -- Improved Flash Heal
(63504, 63504, 1),
(63504, 63505, 2),
(63504, 63506, 3),
 -- Elemental Fury
(16089, 16089, 1),
(16089, 60184, 2),
(16089, 60185, 3),
(16089, 60187, 4),
(16089, 60188, 5),
 -- Feral Swiftness
(17002, 17002, 1),
(17002, 24866, 2),
 -- Master Shapeshifter
(48411, 48411, 1),
(48411, 48412, 2),
 -- Nature's Majesty
(35363, 35363, 1),
(35363, 35364, 2),
 -- Nature's Grace
(16880, 16880, 1),
(16880, 61345, 2),
(16880, 61346, 3),
 -- Molten Skin
(63349, 63349, 1),
(63349, 63350, 2),
(63349, 63351, 3),
 -- Master Demonologist
(23785, 23785, 1),
(23785, 23822, 2),
(23785, 23823, 3),
(23785, 23824, 4),
(23785, 23825, 5),
 -- Death Rune Mastery
(49467, 49467, 1),
(49467, 50033, 2),
(49467, 50034, 3),
 -- Improved Death Strike
(62905, 62905, 1),
(62905, 62908, 2),
 -- Desolation
(66799, 66799, 1),
(66799, 66814, 2),
(66799, 66815, 3),
(66799, 66816, 4),
(66799, 66817, 5),
 -- Mobility
(53483, 53483, 1),
(53483, 53485, 2),
 -- Mobility
(53554, 53554, 1),
(53554, 53555, 2),
 -- Arcane Missiles
(7268, 7268, 1),
(7268, 7269, 2),
(7268, 7270, 3),
(7268, 8419, 4),
(7268, 8418, 5),
(7268, 10273, 6),
(7268, 10274, 7),
(7268, 25346, 8),
(7268, 27076, 9),
(7268, 38700, 10),
(7268, 38703, 11),
(7268, 42844, 12),
(7268, 42845, 13),
 -- Entangling Roots
(19975, 19975, 1),
(19975, 19974, 2),
(19975, 19973, 3),
(19975, 19972, 4),
(19975, 19971, 5),
(19975, 19970, 6),
(19975, 27010, 7),
(19975, 53313, 8),
 -- Death Coil
(47541, 47541, 1),
(47541, 49892, 2),
(47541, 49893, 3),
(47541, 49894, 4),
(47541, 49895, 5),
 -- Intellect
(8096, 8096, 1),
(8096, 8097, 2),
(8096, 8098, 3),
(8096, 12176, 4),
(8096, 33078, 5),
(8096, 43195, 6),
(8096, 48099, 7),
(8096, 48100, 8),
 -- Stamina
(8099, 8099, 1),
(8099, 8100, 2),
(8099, 8101, 3),
(8099, 12178, 4),
(8099, 33081, 5),
(8099, 48101, 6),
(8099, 48102, 7),
(8099, 43198, 8),
 -- Mutilate
(5374, 5374, 1),
(5374, 34414, 2),
(5374, 34416, 3),
(5374, 34419, 4),
(5374, 48662, 5),
(5374, 48665, 6),
 -- Mutilate
(27576, 27576, 1),
(27576, 34415, 2),
(27576, 34417, 3),
(27576, 34418, 4),
(27576, 48661, 5),
(27576, 48664, 6),
 -- Immolation trap
(13797, 13797, 1),
(13797, 14298, 2),
(13797, 14299, 3),
(13797, 14300, 4),
(13797, 14301, 5),
(13797, 27024, 6),
(13797, 49053, 7),
(13797, 49054, 8),
 -- Sniper Training
(64418, 64418, 1),
(64418, 64419, 2),
(64418, 64420, 3),
 -- Blood Strike
(66215, 66215, 1),
(66215, 66975, 2),
(66215, 66976, 3),
(66215, 66977, 4),
(66215, 66978, 5),
(66215, 66979, 6),
 -- Stoneclaw Totem Effect
(5729, 5729, 1),
(5729, 6393, 2),
(5729, 6394, 3),
(5729, 6395, 4),
(5729, 10423, 5),
(5729, 10424, 6),
(5729, 25512, 7),
(5729, 58586, 8),
(5729, 58587, 9),
(5729, 58588, 10);
/*!40000 ALTER TABLE `spell_ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `spell_target_position`
--

DROP TABLE IF EXISTS `spell_target_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_target_position` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `target_map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `target_position_x` float NOT NULL DEFAULT '0',
  `target_position_y` float NOT NULL DEFAULT '0',
  `target_position_z` float NOT NULL DEFAULT '0',
  `target_orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Spell System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_target_position`
--

LOCK TABLES `spell_target_position` WRITE;
/*!40000 ALTER TABLE `spell_target_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `spell_target_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_threat`
--

DROP TABLE IF EXISTS `spell_threat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_threat` (
  `entry` mediumint(8) unsigned NOT NULL,
  `Threat` smallint(6) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_threat`
--

LOCK TABLES `spell_threat` WRITE;
/*!40000 ALTER TABLE `spell_threat` DISABLE KEYS */;
INSERT INTO `spell_threat` VALUES
(78,20),
(284,39),
(285,59),
(770,108),
(1608,78),
(1672,180),
(1715,61),
(6572,155),
(6574,195),
(6809,89),
(7372,101),
(7373,141),
(7379,235),
(7386,100),
(7405,140),
(8380,180),
(8972,118),
(9745,148),
(9880,178),
(9881,207),
(11556,43),
(11564,98),
(11565,118),
(11566,137),
(11567,145),
(11596,220),
(11597,261),
(11600,275),
(11601,315),
(11775,395),
(14921,415),
(17735,200),
(17750,300),
(17751,450),
(17752,600),
(20736,100),
(23922,160),
(23923,190),
(23924,220),
(23925,250),
(24394,580),
(24583,5),
(25286,175),
(25288,355),
(25289,60),
(20243,101),
(30016,101),
(30022,101),
(29707,196),
(30324,220),
(26996,176),
(25258,286),
(30356,323),
(25269,400),
(30357,483),
(29704,230),
(25225,300),
(20569,100),
(25231,130),
(33745,285),
(16857,108),
(6343,17),
(8198,40),
(8204,64),
(8205,96),
(11580,143),
(11581,180),
(25264,215),
(33878,129),
(33986,180),
(33987,232),
(20925,20),
(20927,30),
(20928,40),
(27179,54),
(2139,300),
(6673,1),
(5242,12),
(6192,22),
(11549,32),
(11550,42),
(11551,52),
(2048,69),
(47436,78),
(47519,175),
(47520,225),
(469,68),
(47439,77),
(47440,80),
(25202,49),
(25203,56),
(47437,63),
(47497,101),
(47498,101),
(47449,233),
(47450,259),
(57823,530),
(12797,25),
(12799,25),
(72,36),
(47487,546),
(47488,770),
(47467,345),
(47501,457),
(47502,555);
/*!40000 ALTER TABLE `spell_threat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_difficulty_dbc`
--

DROP TABLE IF EXISTS `spelldifficulty_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spelldifficulty_dbc` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `spellid0` int(11) unsigned NOT NULL DEFAULT '0',
  `spellid1` int(11) unsigned NOT NULL DEFAULT '0',
  `spellid2` int(11) unsigned NOT NULL DEFAULT '0',
  `spellid3` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_difficulty_dbc`
--

LOCK TABLES `spelldifficulty_dbc` WRITE;
/*!40000 ALTER TABLE `spelldifficulty_dbc` DISABLE KEYS */;
INSERT INTO `spelldifficulty_dbc` VALUES 
(3000, 47772, 56935, 0, 0), -- Magus Telestra - Ice Nova
(3001, 47773, 56934, 0, 0), -- Magus Telestra - Fire Bomb
(3002, 44189, 46164, 0, 0), -- SPELL_FIREBALL_NORMAL / SPELL_FIREBALL_HEROIC
(3003, 44190, 46163, 0, 0), -- SPELL_FLAMESTRIKE1_NORMAL / SPELL_FLAMESTRIKE1_HEROIC
(3004, 44174, 46192, 0, 0), -- SPELL_RENEW_NORMAL / SPELL_RENEW_HEROIC
(3005, 14032, 15654, 0, 0), -- SPELL_SW_PAIN_NORMAL / SPELL_SW_PAIN_HEROIC
(3006, 44318, 46380, 0, 0), -- SPELL_CHAIN_LIGHTNING / SPELL_H_CHAIN_LIGHTNING
(3007, 44319, 46381, 0, 0), -- SPELL_ARCANE_SHOCK / SPELL_H_ARCANE_SHOCK
(3008, 52771, 58830, 0, 0), -- SPELL_WOUNDING_STRIKE / H_SPELL_WOUNDING_STRIKE
(3009, 52720, 58852, 0, 0), -- SPELL_CARRION_SWARM / H_SPELL_CARRION_SWARM
(3010, 52722, 58850, 0, 0), -- SPELL_MIND_BLAST / H_SPELL_MIND_BLAST
(3011, 52721, 58849, 0, 0), -- SPELL_SLEEP / H_SPELL_SLEEP
(3012, 52666, 58824, 0, 0), -- SPELL_DISEASE_EXPULSION / H_SPELL_DISEASE_EXPULSION
(3013, 52696, 58823, 0, 0), -- SPELL_CONSTRICTING_CHAINS / H_SPELL_CONSTRICTING_CHAINS
(3014, 57725, 58827, 0, 0), -- SPELL_SHADOW_BOLT / H_SPELL_SHADOW_BOLT
(3015, 52445, 58822, 0, 0), -- SPELL_EXORCISM_N / SPELL_EXORCISM_H
(3016, 31473, 39049, 0, 0), -- SPELL_SAND_BREATH / H_SPELL_SAND_BREATH
(3017, 31457, 38538, 0, 0), -- SPELL_ARCANE_BLAST / H_SPELL_ARCANE_BLAST
(3018, 31472, 38539, 0, 0), -- SPELL_ARCANE_DISCHARGE / H_SPELL_ARCANE_DISCHARGE
(3019, 31475, 38593, 0, 0), -- SPELL_WING_BUFFET / H_SPELL_WING_BUFFET
(3020, 56130, 59467, 0, 0), -- SPELL_BROOD_PLAGUE / H_SPELL_BROOD_PLAGUE
(3021, 57941, 59974, 0, 0), -- SPELL_MIND_FLAY / H_SPELL_MIND_FLAY
(3022, 57942, 59975, 0, 0), -- SPELL_SHADOW_BOLT_VOLLEY / H_SPELL_SHADOW_BOLT_VOLLEY
(3023, 57949, 59978, 0, 0), -- SPELL_SHIVER / H_SPELL_SHIVER
(3024, 56855, 60030, 0, 0), -- SPELL_CYCLONE_STRIKE / SPELL_CYCLONE_STRIKE_H
(3025, 55959, 59513, 0, 0), -- SPELL_EMBRACE_OF_THE_VAMPYR / H_SPELL_EMBRACE_OF_THE_VAMPYR
(3026, 55926, 59508, 0, 0), -- SPELL_FLAME_SPHERE_PERIODIC / H_SPELL_FLAME_SPHERE_PERIODIC
(3027, 53472, 59433, 0, 0), -- SPELL_POUND / H_SPELL_POUND
(3028, 53400, 59419, 0, 0), -- SPELL_ACID_CLOUD / H_SPELL_ACID_CLOUD
(3029, 53030, 59417, 0, 0), -- SPELL_LEECH_POISON / H_SPELL_LEECH_POISON
(3030, 57731, 59421, 0, 0), -- SPELL_WEB_GRAB / H_SPELL_WEB_GRAB
(3031, 52586, 59367, 0, 0), -- SPELL_MIND_FLAY / H_SPELL_MIND_FLAY
(3032, 52592, 59368, 0, 0), -- SPELL_CURSE_OF_FATIGUE / H_SPELL_CURSE_OF_FATIGUE
(3033, 52592, 59368, 0, 0), -- SPELL_CURSE_OF_FATIGUE / H_SPELL_CURSE_OF_FATIGUE
(3034, 59363, 52446, 0, 0), -- SPELL_ACID_SPLASH / H_SPELL_ACID_SPLASH
(3035, 52534, 59357, 0, 0), -- SPELL_SHADOW_BOLT / H_SPELL_SHADOW_BOLT
(3036, 52535, 59358, 0, 0), -- SPELL_SHADOW_NOVA / H_SPELL_SHADOW_NOVA
(3037, 52469, 59364, 0, 0), -- SPELL_INFECTED_BITE / H_SPELL_INFECTED_BITE
(3038, 52469, 59364, 0, 0), -- SPELL_INFECTED_BITE / H_SPELL_INFECTED_BITE
(3039, 52524, 59365, 0, 0), -- SPELL_BLINDING_WEBS / H_SPELL_BLINDING_WEBS
(3040, 52469, 59364, 0, 0), -- SPELL_INFECTED_BITE / H_SPELL_INFECTED_BITE
(3041, 52493, 59366, 0, 0), -- SPELL_POSION_SPRAY / H_SPELL_POSION_SPRAY
(3042, 66538, 67676, 0, 0), -- SPELL_HOLY_FIRE / SPELL_HOLY_FIRE_H
(3043, 66536, 67674, 0, 0), -- SPELL_SMITE / SPELL_SMITE_H
(3044, 66537, 67675, 0, 0), -- SPELL_RENEW / SPELL_RENEW_H
(3045, 66537, 67675, 0, 0), -- SPELL_RENEW / SPELL_RENEW_H
(3046, 66620, 67679, 0, 0), -- SPELL_OLD_WOUNDS / SPELL_OLD_WOUNDS_H
(3047, 66552, 67677, 0, 0), -- SPELL_WAKING_NIGHTMARE / SPELL_WAKING_NIGHTMARE_H
(3048, 66619, 67678, 0, 0), -- SPELL_SHADOWS_PAST / SPELL_SHADOWS_PAST_H
(3049, 67881, 67718, 0, 0), -- SPELL_ICY_TOUCH / SPELL_ICY_TOUCH_H
(3050, 67881, 67718, 0, 0), -- SPELL_ICY_TOUCH / SPELL_ICY_TOUCH_H
(3051, 67883, 67725, 0, 0), -- SPELL_OBLITERATE / SPELL_OBLITERATE_H
(3052, 67875, 67808, 0, 0), -- SPELL_DEATH_BITE / SPELL_DEATH_BITE_H
(3053, 67749, 67880, 0, 0), -- SPELL_LEAP / SPELL_LEAP_H
(3054, 68783, 68784, 0, 0), -- SPELL_MORTAL_STRIKE / SPELL_MORTAL_STRIKE_H
(3055, 66042, 68310, 0, 0), -- SPELL_FIREBALL / SPELL_FIREBALL_H
(3056, 66042, 68310, 0, 0), -- SPELL_FIREBALL / SPELL_FIREBALL_H
(3057, 66043, 68311, 0, 0), -- SPELL_POLYMORPH / SPELL_POLYMORPH_H
(3058, 66044, 68312, 0, 0), -- SPELL_BLAST_WAVE / SPELL_BLAST_WAVE_H
(3059, 67529, 68319, 0, 0), -- SPELL_CHAIN_LIGHTNING / SPELL_CHAIN_LIGHTNING_H
(3060, 67528, 68318, 0, 0), -- SPELL_HEALING_WAVE / SPELL_HEALING_WAVE_H
(3061, 67528, 68318, 0, 0), -- SPELL_HEALING_WAVE / SPELL_HEALING_WAVE_H
(3062, 65868, 67988, 0, 0), -- SPELL_SHOOT / SPELL_SHOOT_H
(3063, 67709, 68317, 0, 0), -- SPELL_EVISCERATE / SPELL_EVISCERATE_H
(3064, 48849, 59422, 0, 0), -- SPELL_FEARSOME_ROAR / H_SPELL_FEARSOME_ROAR
(3065, 49527, 59972, 0, 0), -- SPELL_CURSE_OF_LIFE / H_SPELL_CURSE_OF_LIFE
(3066, 49528, 59973, 0, 0), -- SPELL_SHADOW_VOLLEY / H_SPELL_SHADOW_VOLLEY
(3067, 49518, 59971, 0, 0), -- SPELL_RAIN_OF_FIRE / H_SPELL_RAIN_OF_FIRE
(3068, 49537, 59963, 0, 0), -- SPELL_LIGHTNING_BREATH / H_SPELL_LIGHTNING_BREATH
(3069, 49544, 59965, 0, 0), -- SPELL_EYE_BEAM / H_SPELL_EYE_BEAM
(3070, 49548, 59969, 0, 0), -- SPELL_POISON_CLOUD / H_SPELL_POISON_CLOUD
(3071, 59803, 49381, 0, 0), -- SPELL_CONSUME / H_SPELL_CONSUME
(3072, 49555, 59807, 0, 0), -- SPELL_CORPSE_EXPLODE / H_SPELL_CORPSE_EXPLODE
(3073, 68793, 69050, 0, 0), -- SPELL_MAGIC_S_BANE / H_SPELL_MAGIC_S_BANE
(3074, 68858, 69047, 0, 0), -- SPELL_CONSUME_SOUL / H_SPELL_CONSUME_SOUL
(3075, 68982, 70322, 0, 0), -- SPELL_PHANTOM_BLAST / H_SPELL_PHANTOM_BLAST
(3076, 68895, 70212, 0, 0), -- SPELL_SPITE / H_SPELL_SPITE
(3077, 69148, 70210, 0, 0), -- SPELL_WAIL_OF_SOULS / H_SPELL_WAIL_OF_SOULS
(3078, 69060, 70209, 0, 0), -- SPELL_FROST_NOVA / H_SPELL_FROST_NOVA
(3079, 69080, 70206, 0, 0), -- SPELL_BONE_VOLLEY / H_SPELL_BONE_VOLLEY
(3080, 69069, 70207, 0, 0), -- SPELL_SHIELD_OF_BONES / H_SPELL_SHIELD_OF_BONES
(3081, 69068, 70208, 0, 0), -- SPELL_SHADOW_BOLT / H_SPELL_SHADOW_BOLT
(3082, 69068, 70208, 0, 0), -- SPELL_SHADOW_BOLT / H_SPELL_SHADOW_BOLT
(3083, 69066, 70213, 0, 0), -- SPELL_DRAIN_LIFE / H_SPELL_DRAIN_LIFE
(3084, 69564, 70205, 0, 0), -- SPELL_SHADOW_MEND / H_SPELL_SHADOW_MEND
(3085, 69088, 70211, 0, 0), -- SPELL_SOUL_STRIKE / H_SPELL_SOUL_STRIKE
(3086, 68774, 70334, 0, 0), -- SPELL_FORGE_BLADE / H_SPELL_FORGE_BLADE
(3087, 68785, 70335, 0, 0), -- SPELL_FORGE_MACE / H_SPELL_FORGE_MACE
(3088, 70381, 72930, 0, 0), -- SPELL_DEEP_FREEZE / H_SPELL_DEEP_FREEZE
(3089, 68778, 70333, 0, 0), -- SPELL_CHILLING_WAVE / H_SPELL_CHILLING_WAVE
(3090, 68989, 70434, 0, 0), -- SPELL_POISON_NOVA / H_SPELL_POISON_NOVA
(3091, 69024, 70436, 0, 0), -- SPELL_TOXIC_WASTE / H_SPELL_TOXIC_WASTE
(3092, 69155, 69627, 0, 0), -- SPELL_FORCEFUL_SMASH / H_SPELL_FORCEFUL_SMASH
(3093, 69167, 69629, 0, 0), -- SPELL_DARK_MIGHT / H_SPELL_DARK_MIGHT
(3094, 69233, 69646, 0, 0), -- SPELL_ICY_BLAST / H_SPELL_ICY_BLAST
(3095, 69238, 69628, 0, 0), -- SPELL_ICY_BLAST_2 / H_SPELL_ICY_BLAST_2
(3096, 55626, 58993, 0, 0), -- SPELL_MOJO_WAVE / H_SPELL_MOJO_WAVE
(3097, 55627, 58994, 0, 0), -- SPELL_MOJO_PUDDLE / H_SPELL_MOJO_PUDDLE
(3098, 55250, 59824, 0, 0), -- SPELL_WHIRLING_SLASH / H_SPELL_WHIRLING_SLASH
(3099, 55276, 59826, 0, 0), -- SPELL_PUNCTURE / H_SPELL_PUNCTURE
(3100, 55285, 59828, 0, 0), -- SPELL_ENRAGE / H_SPELL_ENRAGE
(3101, 55292, 59829, 0, 0), -- SPELL_STOMP / H_SPELL_STOMP
(3102, 54956, 59827, 0, 0), -- SPELL_IMPALING_CHARGE / H_SPELL_IMPALING_CHARGE
(3103, 55102, 59444, 0, 0), -- SPELL_DETERMINED_GORE / H_SPELL_DETERMINED_GORE
(3104, 55081, 59842, 0, 0), -- SPELL_POISON_NOVA / H_SPELL_POISON_NOVA
(3105, 48287, 59840, 0, 0), -- SPELL_POWERFULL_BITE / H_SPELL_POWERFULL_BITE
(3106, 54970, 59839, 0, 0), -- SPELL_VENOM_BOLT / H_SPELL_VENOM_BOLT
(3107, 54987, 58996, 0, 0), -- SPELL_VENOMOUS_BITE / H_SPELL_VENOMOUS_BITE
(3108, 47751, 57062, 0, 0), -- SPELL_SPARK / H_SPELL_SPARK
(3109, 48096, 57091, 0, 0), -- SPELL_CRYSTALFIRE_BREATH / H_SPELL_CRYSTALFIRE_BREATH
(3110, 48016, 57066, 0, 0), -- SPELL_TRAMPLE / H_SPELL_TRAMPLE
(3111, 47944, 57067, 0, 0), -- SPELL_CRYSTALL_SPIKE_DAMAGE / H_SPELL_CRYSTALL_SPIKE_DAMAGE
(3112, 50774, 59370, 0, 0), -- SPELL_THUNDERING_STOMP / SPELL_THUNDERING_STOMP_H
(3113, 52774, 59160, 0, 0), -- SPELL_RENEW_STEEL_N / SPELL_RENEW_STEEL_H
(3114, 52658, 59795, 0, 0), -- SPELL_STATIC_OVERLOAD / H_SPELL_STATIC_OVERLOAD
(3115, 52780, 59800, 0, 0), -- SPELL_BALL_LIGHTNING / H_SPELL_BALL_LIGHTNING
(3116, 52961, 59836, 0, 0), -- SPELL_PULSING_SHOCKWAVE_N / SPELL_PULSING_SHOCKWAVE_H
(3117, 52960, 59835, 0, 0), -- SPELL_LIGHTNING_NOVA_N / SPELL_LIGHTNING_NOVA_H
(3118, 52237, 59529, 0, 0), -- SPELL_SHATTERING_STOMP_N / SPELL_SHATTERING_STOMP_H
(3119, 52433, 59530, 0, 0), -- SPELL_IMMOLATION_STRIKE_N / SPELL_IMMOLATION_STRIKE_H
(3120, 50843, 59742, 0, 0), -- SPELL_BOULDER_TOSS / H_SPELL_BOULDER_TOSS
(3121, 48131, 59744, 0, 0), -- SPELL_STOMP / H_SPELL_STOMP
(3122, 50810, 61546, 0, 0), -- SPELL_SHATTER / H_SPELL_SHATTER
(3123, 50752, 59772, 0, 0), -- SPELL_STORM_OF_GRIEF_N / SPELL_STORM_OF_GRIEF_H
(3124, 50760, 59726, 0, 0), -- SPELL_SHOCK_OF_SORROW_N / SPELL_SHOCK_OF_SORROW_H
(3125, 50761, 59727, 0, 0), -- SPELL_PILLAR_OF_WOE_N / SPELL_PILLAR_OF_WOE_H
(3126, 50761, 59727, 0, 0), -- SPELL_PILLAR_OF_WOE_N / SPELL_PILLAR_OF_WOE_H
(3127, 50830, 59844, 0, 0), -- SPELL_CHAIN_LIGHTING / H_SPELL_CHAIN_LIGHTING
(3128, 50831, 59845, 0, 0), -- SPELL_LIGHTING_SHIELD / H_SPELL_LIGHTING_SHIELD
(3129, 50834, 59846, 0, 0), -- SPELL_STATIC_CHARGE / H_SPELL_STATIC_CHARGE
(3130, 51849, 59861, 0, 0), -- SPELL_LIGHTING_RING / H_SPELL_LIGHTING_RING
(3131, 42730, 59735, 0, 0), -- SPELL_WOE_STRIKE / H_SPELL_WOE_STRIKE
(3132, 42669, 59706, 0, 0), -- SPELL_SMASH / H_SPELL_SMASH
(3133, 42705, 59707, 0, 0), -- SPELL_ENRAGE / H_SPELL_ENRAGE
(3134, 42729, 59734, 0, 0), -- SPELL_DREADFUL_ROAR / H_SPELL_DREADFUL_ROAR
(3135, 42708, 59708, 0, 0), -- SPELL_STAGGERING_ROAR / H_SPELL_STAGGERING_ROAR
(3136, 42750, 59719, 0, 0), -- SPELL_SHADOW_AXE_DAMAGE / H_SPELL_SHADOW_AXE_DAMAGE
(3137, 43649, 59575, 0, 0), -- SPELL_SHADOW_BOLT / H_SPELL_SHADOW_BOLT
(3138, 48261, 59268, 0, 0), -- SPELL_IMPALE / H_SPELL_IMPALE
(3139, 48256, 59267, 0, 0), -- SPELL_WITHERING_ROAR / H_SPELL_WITHERING_ROAR
(3140, 48140, 59273, 0, 0), -- SPELL_CHAIN_LIGHTING / H_SPELL_CHAIN_LIGHTING
(3141, 48137, 59265, 0, 0), -- SPELL_MORTAL_WOUND / H_SPELL_MORTAL_WOUND
(3142, 48130, 59264, 0, 0), -- SPELL_GORE / H_SPELL_GORE
(3143, 48105, 59263, 0, 0), -- SPELL_GRIEVOUS_WOUND / H_SPELL_GRIEVOUS_WOUND
(3144, 48133, 59271, 0, 0), -- SPELL_POISON_BREATH / H_SPELL_POISON_BREATH
(3145, 48133, 59271, 0, 0), -- SPELL_POISON_BREATH / H_SPELL_POISON_BREATH
(3146, 50234, 59330, 0, 0), -- SPELL_CRUSH / H_SPELL_CRUSH
(3147, 50225, 59331, 0, 0), -- SPELL_POISONED_SPEAR / H_SPELL_POISONED_SPEAR
(3148, 15667, 59409, 0, 0), -- SPELL_SINSTER_STRIKE / H_SPELL_SINSTER_STRIKE
(3149, 48294, 59301, 0, 0), -- SPELL_BANE / H_SPELL_BANE
(3150, 48291, 59300, 0, 0), -- SPELL_FETID_ROT / H_SPELL_FETID_ROT
(3151, 48423, 59304, 0, 0), -- SPELL_SPIRIT_STRIKE / H_SPELL_SPIRIT_STRIKE
(3152, 48529, 59305, 0, 0), -- SPELL_SPIRIT_BURST / H_SPELL_SPIRIT_BURST
(3153, 58693, 59369, 0, 0), -- SPELL_BLIZZARD / H_SPELL_BLIZZARD
(3154, 58690, 59283, 0, 0), -- SPELL_TAIL_SWEEP / H_SPELL_TAIL_SWEEP
(3155, 58688, 59281, 0, 0), -- SPELL_UNCONTROLLABLE_ENERGY / H_SPELL_UNCONTROLLABLE_ENERGY
(3156, 54479, 59471, 0, 0), -- SPELL_EARTH_SHIELD / H_SPELL_EARTH_SHIELD
(3157, 54479, 59471, 0, 0), -- SPELL_EARTH_SHIELD / H_SPELL_EARTH_SHIELD
(3158, 54481, 59473, 0, 0), -- SPELL_CHAIN_HEAL / H_SPELL_CHAIN_HEAL
(3159, 54312, 59522, 0, 0), -- SPELL_FRENZY / SPELL_FRENZY_H
(3160, 54237, 59520, 0, 0), -- SPELL_WATER_BLAST / SPELL_WATER_BLAST_H
(3161, 54241, 59521, 0, 0), -- SPELL_WATER_BOLT_VOLLEY / SPELL_WATER_BOLT_VOLLEY_H
(3162, 54235, 59468, 0, 0), -- SPELL_FIREBOLT / H_SPELL_FIREBOLT
(3163, 54282, 59469, 0, 0), -- SPELL_FLAME_BREATH / H_SPELL_FLAME_BREATH
(3164, 54249, 59594, 0, 0), -- SPELL_LAVA_BURN / H_SPELL_LAVA_BURN
(3165, 54202, 59483, 0, 0), -- SPELL_ARCANE_BARRAGE_VOLLEY / SPELL_ARCANE_BARRAGE_VOLLEY_H
(3166, 54226, 59485, 0, 0), -- SPELL_ARCANE_BUFFET / SPELL_ARCANE_BUFFET_H
(3167, 54160, 59474, 0, 0), -- SPELL_ARCANE_POWER / H_SPELL_ARCANE_POWER
(3168, 54361, 59743, 0, 0), -- SPELL_VOID_SHIFT / H_SPELL_VOID_SHIFT
(3169, 54524, 59745, 0, 0), -- SPELL_SHROUD_OF_DARKNESS / H_SPELL_SHROUD_OF_DARKNESS
(3170, 54342, 59747, 0, 0), -- SPELL_ZURAMAT_ADD_2 / H_SPELL_ZURAMAT_ADD_2
(3171, 32325, 38760, 0, 0), -- SPELL_VOID_BLAST / H_SPELL_VOID_BLAST
(3172, 32358, 38759, 0, 0), -- SPELL_DARK_SHELL / H_SPELL_DARK_SHELL
(3173, 38197, 40425, 0, 0), -- SPELL_ARCANE_EXPLOSION / H_SPELL_ARCANE_EXPLOSION
(3174, 35059, 40424, 0, 0), -- SPELL_ARCANE_VOLLEY / H_SPELL_ARCANE_VOLLEY
(3175, 38245, 43309, 0, 0), -- SPELL_POLYMORPH / H_SPELL_POLYMORPH
(3176, 33617, 39363, 0, 0), -- SPELL_RAIN_OF_FIRE / H_SPELL_RAIN_OF_FIRE
(3177, 34449, 37924, 0, 0), -- SPELL_WATER_BOLT_VOLLEY / H_SPELL_WATER_BOLT_VOLLEY
(3178, 31532, 37936, 0, 0), -- SPELL_REPAIR / H_SPELL_REPAIR
(3179, 33132, 37371, 0, 0), -- SPELL_FIRE_NOVA / H_SPELL_FIRE_NOVA
(3180, 28599, 40070, 0, 0), -- SPELL_SHADOW_BOLT_VOLLEY / H_SPELL_SHADOW_BOLT_VOLLEY
(3181, 49381, 59805, 0, 0), -- SPELL_CONSUME_AURA / H_SPELL_CONSUME_AURA
(3182, 30695, 37566, 0, 0), -- SPELL_TREACHEROUS_AURA / H_SPELL_BANE_OF_TREACHERY
(3183, 30686, 39297, 0, 0), -- SPELL_SHADOW_BOLT / H_SPELL_SHADOW_BOLT
(3184, 30641, 36814, 0, 0), -- SPELL_MORTAL_WOUND / H_SPELL_MORTAL_WOUND
(3185, 30495, 35953, 0, 0), -- SPELL_SHADOW_CLEAVE / H_SPELL_SHADOW_SLAM
(3186, 30598, 36056, 0, 0), -- SPELL_BURNING_MAUL / H_SPELL_BURNING_MAUL
(3187, 36924, 39017, 0, 0), -- SPELL_MIND_REND / H_SPELL_MIND_REND
(3188, 36924, 39017, 0, 0), -- SPELL_MIND_REND / H_SPELL_MIND_REND
(3189, 37162, 39019, 0, 0), -- SPELL_DOMINATION / H_SPELL_DOMINATION
(3190, 37162, 39019, 0, 0), -- SPELL_DOMINATION / H_SPELL_DOMINATION
(3191, 35322, 39193, 0, 0), -- SPELL_SHADOW_POWER / H_SPELL_SHADOW_POWER
(3192, 35327, 39194, 0, 0), -- SPELL_JACKHAMMER / H_SPELL_JACKHAMMER
(3193, 35275, 39084, 0, 0), -- SPELL_SUMMON_RAGIN_FLAMES / H_SPELL_SUMMON_RAGIN_FLAMES
(3194, 35268, 39346, 0, 0); -- SPELL_INFERNO / H_SPELL_INFERNO
/*!40000 ALTER TABLE `spelldifficulty_dbc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spell_script_names`
--

DROP TABLE IF EXISTS `spell_script_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spell_script_names` (
  `spell_id` mediumint(8) NOT NULL,
  `ScriptName` char(64) NOT NULL,
  UNIQUE (`spell_id`, `ScriptName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_script_names`
--

LOCK TABLES `spell_script_names` WRITE;
/*!40000 ALTER TABLE `spell_script_names` DISABLE KEYS */;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
-- generic
(  6962, 'spell_gen_pet_summoned'),
( 24750, 'spell_gen_trick'),
( 24751, 'spell_gen_trick_or_treat'),
( 29266, 'spell_creature_permanent_feign_death'),
( 41337, 'spell_gen_aura_of_anger'),
( 45472, 'spell_gen_parachute'),
( 46394, 'spell_gen_burn_brutallus'),
( 57685, 'spell_creature_permanent_feign_death'),
( 58601, 'spell_gen_remove_flight_auras'),
( 66118, 'spell_gen_leeching_swarm'),
( 58951, 'spell_creature_permanent_feign_death'),
( 70592, 'spell_creature_permanent_feign_death'),
( 70628, 'spell_creature_permanent_feign_death'),
( 74490, 'spell_creature_permanent_feign_death'),
( 72752, 'spell_pvp_trinket_wotf_shared_cd'),
( 72757, 'spell_pvp_trinket_wotf_shared_cd'),
-- instances
( 69057, 'spell_marrowgar_bone_spike_graveyard'),
( 69140, 'spell_marrowgar_coldflame'),
( 72705, 'spell_marrowgar_coldflame'),
( 69147, 'spell_marrowgar_coldflame_trigger'),
( 69075, 'spell_marrowgar_bone_storm'),
( 70834, 'spell_marrowgar_bone_storm'),
( 70835, 'spell_marrowgar_bone_storm'),
( 70836, 'spell_marrowgar_bone_storm'),
( 70842, 'spell_deathwhisper_mana_barrier'),
( 70903, 'spell_cultist_dark_martyrdrom'),
( 71236, 'spell_cultist_dark_martyrdrom'),
( 72202, 'spell_deathbringer_blood_link'),
( 72178, 'spell_deathbringer_blood_link_aura'),
( 72371, 'spell_deathbringer_blood_power'),
( 72409, 'spell_deathbringer_rune_of_blood'),
( 72447, 'spell_deathbringer_rune_of_blood'),
( 72448, 'spell_deathbringer_rune_of_blood'),
( 72449, 'spell_deathbringer_rune_of_blood'),
( 72380, 'spell_deathbringer_blood_nova'),
( 72438, 'spell_deathbringer_blood_nova'),
( 72439, 'spell_deathbringer_blood_nova'),
( 72440, 'spell_deathbringer_blood_nova'),
( 71123, 'spell_stinky_precious_decimate'),
( 73032, 'spell_festergut_pungent_blight'),
( 73031, 'spell_festergut_pungent_blight'),
( 71219, 'spell_festergut_pungent_blight'),
( 69195, 'spell_festergut_pungent_blight'),
( 72219, 'spell_festergut_gastric_bloat'),
( 72551, 'spell_festergut_gastric_bloat'),
( 72552, 'spell_festergut_gastric_bloat'),
( 72553, 'spell_festergut_gastric_bloat'),
( 69290, 'spell_festergut_blighted_spores'),
( 71222, 'spell_festergut_blighted_spores'),
( 73033, 'spell_festergut_blighted_spores'),
( 73034, 'spell_festergut_blighted_spores'),
-- quest
(  8913, 'spell_q55_sacred_cleansing'),
( 17271, 'spell_q5206_test_fetid_skull'),
( 19512, 'spell_q6124_6129_apply_salve'),
( 34665, 'spell_q10255_administer_antidote'),
( 44936, 'spell_q11515_fel_siphon_dummy'),
( 45449, 'spell_q11587_arcane_prisoner_rescue'),
( 46023, 'spell_q11730_ultrasonic_screwdriver'),
( 49587, 'spell_q12459_seeds_of_natures_wrath'),
( 51840, 'spell_q12634_despawn_fruit_tosser'),
( 52308, 'spell_q12683_take_sputum_sample'),
( 55804, 'spell_q12937_relief_for_the_fallen'),
-- item
( 23074, 'spell_item_arcanite_dragonling'),
(  8063, 'spell_item_deviate_fish'),
( 67019, 'spell_item_flask_of_the_north'),
( 23133, 'spell_item_gnomish_battle_chicken'),
( 13280, 'spell_item_gnomish_death_ray'),
( 33060, 'spell_item_make_a_wish'),
( 23076, 'spell_item_mechanical_dragonling'),
( 40802, 'spell_item_mingos_fortune_generator'),
( 23075, 'spell_item_mithril_mechanical_dragonling'),
( 13120, 'spell_item_net_o_matic'),
( 16589, 'spell_item_noggenfogger_elixir'),
(  8213, 'spell_item_savory_deviate_delight'),
( 14537, 'spell_item_six_demon_bag'),
( 59640, 'spell_item_underbelly_elixir'),
-- warrior
( 12975, 'spell_warr_last_stand'),
-- paladin
( 20425, 'spell_pal_judgement_of_command'),
( 63521, 'spell_pal_guarded_by_the_light'),
(-20473, 'spell_pal_holy_shock'),
( 20911, 'spell_pal_blessing_of_sanctuary'),
( 25899, 'spell_pal_blessing_of_sanctuary')
( 37877, 'spell_pal_blessing_of_faith'),
-- hunter
( 53209, 'spell_hun_chimera_shot'),
( 53412, 'spell_hun_invigoration'),
( 53271, 'spell_hun_masters_call'),
( 53478, 'spell_hun_last_stand_pet'),
( 23989, 'spell_hun_readiness'),
( 37506, 'spell_hun_scatter_shot'),
(-53302, 'spell_hun_sniper_training'),
( 55709, 'spell_hun_pet_heart_of_the_phoenix'),
( 54044, 'spell_hun_pet_carrion_feeder'),
-- rogue
(  5938, 'spell_rog_shiv'),
( 14185, 'spell_rog_preparation'),
(-51685, 'spell_rog_prey_on_the_weak'),
-- priest
( 47948, 'spell_pri_pain_and_suffering_proc'),
(-47540, 'spell_pri_penance'),
-- death knight
(-49158, 'spell_dk_corpse_explosion'),
( 50524, 'spell_dk_runic_power_feed'),
(-55090, 'spell_dk_scourge_strike'),
-- shaman
( 39610, 'spell_sha_mana_tide_totem'),
( -1535, 'spell_sha_fire_nova'),
-- mage
( 11958, 'spell_mage_cold_snap'),
( 31687, 'spell_mage_summon_water_elemental'),
( 32826, 'spell_mage_polymorph_visual'),
-- warlock
( -6201, 'spell_warl_create_healthstone'),
( 47193, 'spell_warl_demonic_empowerment'),
( 47422, 'spell_warl_everlasting_affliction'),
-- druid
( 54846, 'spell_dru_glyph_of_starfire'),
-- example
( 66244, 'spell_ex_66244'), 
( 5581,  'spell_ex_5581');
/*!40000 ALTER TABLE `spell_script_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transports`
--

DROP TABLE IF EXISTS `transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transports` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` text,
  `period` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`),
  UNIQUE INDEX `idx_entry` (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Transports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transports`
--

LOCK TABLES `transports` WRITE;
/*!40000 ALTER TABLE `transports` DISABLE KEYS */;
/*!40000 ALTER TABLE `transports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trinity_string`
--

DROP TABLE IF EXISTS `trinity_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trinity_string` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trinity_string`
--

LOCK TABLES `trinity_string` WRITE;
/*!40000 ALTER TABLE `trinity_string` DISABLE KEYS */;
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES
(1, 'You should select a character or a creature.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'You should select a creature.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, '[SERVER] %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, '|cffff0000[Event Message]: %s|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'There is no help for that command', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'There is no such command', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'There is no such subcommand', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'Command %s have subcommands:%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'Commands available to you:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'Incorrect syntax.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'Your account level is: %i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'Active connections: %u (max: %u) Queued connections: %u (max: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'Server uptime: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'Player saved.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'All players saved.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'There are the following active GMs on this server:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'There are no GMs currently logged in on this server.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'Cannot do that while flying.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'Cannot do that in Battlegrounds.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'Target is flying you can''t do that.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, '%s is flying command failed.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'You are not mounted so you can''t dismount.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 'Cannot do that while fighting.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'You used it recently.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 'Password not changed (unknown error)!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 'The password was changed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 'The old password is wrong', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'Your account is now locked.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'Your account is now unlocked.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, ', rank ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, ' [known]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, ' [learn]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, ' [passive]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, ' [talent]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(35, ' [active]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, ' [complete]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(37, ' (offline)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(38, 'on', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 'off', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(40, 'You are: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 'visible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 'invisible', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 'done', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 'You', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, ' <unknown> ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, '<error>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, '<non-existing character>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 'UNKNOWN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 'You must be at least level %u to enter.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 'You must be at least level %u and have item %s to enter.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 'Hello! Ready for some training?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 'Invaid item count (%u) for item %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 'Mail can''t have more %u item stacks', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 'The new passwords do not match', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 'Your password can''t be longer than 16 characters (client limit), password not changed!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 'Current Message of the day: \r\n%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 'Using World DB: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 'Using script library: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 'Using creature EventAI: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 'Online players: %u (max: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 'Up to %u expansion allowed now.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, 'One on more parameters have incorrect values', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(100, 'Global notify: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 'Map: %u (%s) Zone: %u (%s) Area: %u (%s) Phase: %u\nX: %f Y: %f Z: %f Orientation: %f\ngrid[%u,%u]cell[%u,%u] InstanceID: %u\n ZoneX: %f ZoneY: %f\nGroundZ: %f FloorZ: %f Have height data (Map: %u VMap: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(102, '%s is already being teleported.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(103, 'You can summon a player to your instance only if he is in your party with you as leader.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(104, 'You cannot go to the player''s instance because you are in a party now.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(105, 'You can go to the player''s instance while not being in his party only if your GM mode is on.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(106, 'You can not go to player %s from instance to instance.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(107, 'You can not summon player %s from instance to instance.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(108, 'You are summoning %s%s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(109, 'You are being summoned by %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(110, 'You are teleporting %s%s to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(111, 'You are being teleported by %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(112, 'Player (%s) does not exist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(113, 'Appearing at %s''s location.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(114, '%s is appearing to your location.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(115, 'Incorrect values.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(116, 'No character selected.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(117, '%s is not in a group.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 'You changed HP of %s to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(119, '%s changed your HP to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(120, 'You changed MANA of %s to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(121, '%s changed your MANA to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(122, 'You changed ENERGY of %s to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(123, '%s changed your ENERGY to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(124, 'Current energy: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(125, 'You changed rage of %s to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(126, '%s changed your rage to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(127, 'You changed level of %s to %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(128, 'GUID %i, faction is %i, flags is %i, npcflag is %i, DY flag is %i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(129, 'Wrong faction: %u (not found in factiontemplate.dbc).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(130, 'You changed GUID=%i ''s Faction to %i, flags to %i, npcflag to %i, dyflag to %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(131, 'You changed the spellflatid=%i, val= %i, mark =%i to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(132, '%s changed your spellflatid=%i, val= %i, mark =%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(133, '%s has access to all taxi nodes now (until logout).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(134, '%s has no more access to all taxi nodes now (only visited accessible).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(135, '%s has given you access to all taxi nodes (until logout).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(136, '%s has removed access to all taxi nodes (only visited still accessible).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(137, 'You set all speeds to %2.2f from normal of %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(138, '%s set all your speeds to %2.2f from normal.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(139, 'You set the speed to %2.2f from normal of %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(140, '%s set your speed to %2.2f from normal.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(141, 'You set the swim speed to %2.2f from normal of %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(142, '%s set your swim speed to %2.2f from normal.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(143, 'You set the backwards run speed to %2.2f from normal of %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(144, '%s set your backwards run speed to %2.2f from normal.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(145, 'You set the fly speed to %2.2f from normal of %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(146, '%s set your fly speed to %2.2f from normal.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(147, 'You set the size %2.2f of %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(148, '%s set your size to %2.2f.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(149, 'There is no such mount.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(150, 'You give a mount to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(151, '%s gave you a mount.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(152, 'USER1: %i, ADD: %i, DIF: %i\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(153, 'You take all copper of %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(154, '%s took you all of your copper.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(155, 'You take %i copper from %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(156, '%s took %i copper from you.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(157, 'You give %i copper to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(158, '%s gave you %i copper.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(159, 'You hear sound %u.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(160, 'USER2: %i, ADD: %i, RESULT: %i\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(161, 'Removed bit %i in field %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(162, 'Set bit %i in field %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(163, 'Teleport location table is empty!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(164, 'Teleport location not found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(165, 'Requires search parameter.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(166, 'There are no teleport locations matching your request.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(168, 'Locations found are:\n%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(169, 'Mail sent to %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(170, 'You try to hear sound %u but it doesn''t exist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(171, 'You can''t teleport self to self!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(172, 'server console command', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(173, 'You changed runic power of %s to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(174, '%s changed your runic power to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(175, 'Liquid level: %f, ground: %f, type: %d, status: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(200, 'No selection.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(201, 'Object GUID is: lowpart %u highpart %X', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(202, 'The name was too long by %i characters.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(203, 'Error, name can only contain characters A-Z and a-z.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(204, 'The subname was too long by %i characters.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(205, 'Not yet implemented', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(206, 'Item ''%i'' ''%s'' added to list with maxcount ''%i'' and incrtime ''%i'' and extendedcost ''%i''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(207, 'Item ''%i'' not found in database.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(208, 'Item ''%i'' ''%s'' deleted from vendor list', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(209, 'Item ''%i'' not found in vendor list.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(210, 'Item ''%u'' (with extended cost %u) already in vendor list.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(211, 'Spells of %s reset.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(212, 'Spells of %s will reset at next login.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(213, 'Talents of %s reset.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(214, 'Talents of %s will reset at next login.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(215, 'Your spells have been reset.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(216, 'Your talents have been reset.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(217, 'Unknown case ''%s'' for .resetall command. Type full correct case name.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(218, 'Spells will reset for all players at login. Strongly recommend re-login!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(219, 'Talents will reset for all players at login. Strongly recommend re-login!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(220, 'Creature (GUID: %u) No waypoint found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(221, 'Creature (GUID: %u) Last waypoint not found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(222, 'Creature (GUID: %u) No waypoint found - used ''wpguid''. Now trying to find it by its position...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(223, 'Creature (GUID: %u) No waypoints found - This is a MaNGOS db problem (single float).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(224, 'Selected creature is ignored - provided GUID is used', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(225, 'Creature (GUID: %u) not found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(226, 'You must select a visual waypoint.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(227, 'No visual waypoints found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(228, 'Could not create visual waypoint with creatureID: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(229, 'All visual waypoints removed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(230, 'Could not create waypoint-creature with ID: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(231, 'No GUID provided.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(232, 'No waypoint number provided.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(233, 'Argument required for ''%s''.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(234, 'Waypoint %i added to GUID: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(235, 'Waypoint %d added.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(236, 'Waypoint changed.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(237, 'Waypoint %s modified.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(238, 'WP export successfull.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(239, 'No waypoints found inside the database.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(240, 'File imported.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(241, 'Waypoint removed.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(242, 'Warning: Could not delete WP from the world with ID: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(243, 'This happens if the waypoint is too far away from your char.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(244, 'The WP is deleted from the database, but not from the world here.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(245, 'They will disappear after a server restart.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(246, 'Waypoint %d: Info for creature: %s, GUID: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(247, 'Waittime: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(248, 'Model %d: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(249, 'Emote: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(250, 'Spell: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(251, 'Text%d (ID: %i): %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(252, 'AIScript: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(253, 'Forced rename for player %s will be requested at next login.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(254, 'Forced rename for player %s (GUID #%u) will be requested at next login.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(255, 'Waypoint-Creature (GUID: %u) Not found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(256, 'Could not find NPC...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(257, 'Creature movement type set to ''%s'', waypoints removed (if any).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(258, 'Creature movement type set to ''%s'', waypoints were not removed.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(259, 'Incorrect value, use on or off', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(260, 'Value saved.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(261, 'Value saved, you may need to rejoin or clean your client cache.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(262, 'Areatrigger ID %u not found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(263, 'Target map or coordinates is invalid (X: %f Y: %f MapId: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(264, 'Zone coordinates is invalid (X: %f Y: %f AreaId: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(265, 'Zone %u (%s) is part of instanceable map %u (%s)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(266, 'Nothing found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(267, 'Object not found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(268, 'Creature not found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(269, 'Warning: Mob found more than once - you will be teleported to the first one found in DB.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(270, 'Creature Removed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(271, 'Creature moved.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(272, 'Creature (GUID:%u) must be on the same map as player!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(273, 'Game Object (GUID: %u) not found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(274, 'Game Object (GUID: %u) has references in not found creature %u GO list, can''t be deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(275, 'Game Object (GUID: %u) removed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(276, 'Game Object |cffffffff|Hgameobject:%d|h[%s]|h|r (GUID: %u) turned', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(277, 'Game Object |cffffffff|Hgameobject:%d|h[%s]|h|r (GUID: %u) moved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(278, 'You must select a vendor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(279, 'You must send id for item', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(280, 'Vendor has too many items (max 128)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(281, 'You can''t kick self, logout instead', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(282, 'Player %s kicked.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(284, 'Accepting Whisper: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(285, 'Accepting Whisper: ON', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(286, 'Accepting Whisper: OFF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(287, 'Creature (GUID: %u) not found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(288, 'Tickets count: %i show new tickets: %s\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(289, 'New ticket from %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(290, 'Ticket of %s (Last updated: %s):\n%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(291, 'New ticket show: ON', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(292, 'New ticket show: OFF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(293, 'Ticket %i doesn''t exist', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(294, 'All tickets deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(295, 'Character %s ticket deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(296, 'Ticket deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(297, 'Spawn distance changed to: %f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(298, 'Spawn time changed to: %i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(299, 'The honor of %s was set to %u!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(300, 'Your chat has been disabled for %u minutes. Reason: %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(301, 'You have disabled %s''s chat for %u minutes. Reason: %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(302, 'Player''s chat is already enabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(303, 'Your chat has been enabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(304, 'You have enabled %s''s chat.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(305, 'Faction %s (%u) reputation of %s was set to %5d!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(306, 'The arena points of %s was set to %u!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(307, 'No faction found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(308, 'Faction %i unknown!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(309, 'Invalid parameter %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(310, 'delta must be between 0 and %d (inclusive)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(311, '%d - |cffffffff|Hfaction:%d|h[%s]|h|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(312, ' [visible]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(313, ' [at war]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(314, ' [peace forced]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(315, ' [hidden]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(316, ' [invisible forced]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(317, ' [inactive]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(318, 'Hated', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(319, 'Hostile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(320, 'Unfriendly', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(321, 'Neutral', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(322, 'Friendly', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(323, 'Honored', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(324, 'Revered', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(325, 'Exalted', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(326, 'Faction %s (%u) can''nt have reputation.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(327, ' [no reputation]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(328, 'Characters at account %s (Id: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(329, '  %s (GUID %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(330, 'No players found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331, 'Extended item cost %u not exist', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(332, 'GM mode is ON', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(333, 'GM mode is OFF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(334, 'GM Chat Badge is ON', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(335, 'GM Chat Badge is OFF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(336, 'You repair all %s''s items.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(337, 'All your items repaired by %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(338, 'You set waterwalk mode %s for %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(339, 'Your waterwalk mode %s by %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(340, '%s is now following you.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(341, '%s is not following you.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(342, '%s is now not following you.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(343, 'Creature (Entry: %u) cannot be tamed.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(344, 'You already have pet.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(345, 'Forced customize for player %s will be requested at next login.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(346, 'Forced customize for player %s (GUID #%u) will be requested at next login.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(347, 'TaxiNode ID %u not found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(348,'Game Object (Entry: %u) have invalid data and can''t be spawned',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(349,'%d (idx:%d) - |cffffffff|Htitle:%d|h[%s %s]|h|r %s %s ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(350,'%d (idx:%d) - [%s %s] %s %s ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(351,'No titles found!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(352,'Invalid title id: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(353,'Title %u (%s) added to known titles list for player %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(354,'Title %u (%s) removed from known titles list for player %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(355,'Title %u (%s) set as current seelcted title for player %s.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(356,'Current selected title for player %s reset as not known now.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(400, '|cffff0000[System Message]:|rScripts reloaded', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(401, 'You change security level of account %s to %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(402, '%s changed your security level to %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(403, 'You have low security level for this.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(404, 'Creature movement disabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(405, 'Creature movement enabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(406, 'Weather can''t be changed for this zone.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(407, 'Weather system disabled at server.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(408, '%s is banned for %s. Reason: %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(409, '%s is banned permanently for %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(410, '%s %s not found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(411, '%s unbanned.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(412, 'There was an error removing the ban on %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(413, 'Account not exist: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(414, 'There is no such character.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(415, 'There is no such IP in banlist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(416, 'Account %s has never been banned', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(417, 'Ban history for account %s:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(418, 'Ban Date: %s Bantime: %s Still active: %s  Reason: %s Set by: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(419, 'Inf.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(420, 'Never', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(421, 'Yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(422, 'No', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(423, 'IP: %s\nBan Date: %s\nUnban Date: %s\nRemaining: %s\nReason: %s\nSet by: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(424, 'There is no matching IPban.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(425, 'There is no matching account.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(426, 'There is no banned account owning a character matching this part.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(427, 'The following IPs match your pattern:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(428, 'The following accounts match your query:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(429, 'You learned many spells/skills.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(430, 'You learned all spells for class.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(431, 'You learned all talents for class.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(432, 'You learned all languages.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(433, 'You learned all craft skills and recipes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(434, 'Could not find ''%s''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(435, 'Invalid item id: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(436, 'No items found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(437, 'Invalid gameobject id: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(438, 'Found items %u: %u ( inventory %u mail %u auction %u guild %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(439, 'Found gameobjects %u: %u ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(440, 'Invalid creature id: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(441, 'Found creatures %u: %u ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(442, 'No area found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(443, 'No item sets found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(444, 'No skills found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(445, 'No spells found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(446, 'No quests found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(447, 'No creatures found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(448, 'No gameobjects found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(449, 'Graveyard #%u doesn''t exist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(450, 'Graveyard #%u already linked to zone #%u (current).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(451, 'Graveyard #%u linked to zone #%u (current).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(452, 'Graveyard #%u can''t be linked to subzone or not existed zone #%u (internal error).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(454, 'No faction in Graveyard with id= #%u , fix your DB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(455, 'invalid team, please fix database', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(456, 'any', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(457, 'alliance', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(458, 'horde', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(459, 'Graveyard #%u (faction: %s) is nearest from linked to zone #%u.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(460, 'Zone #%u doesn''t have linked graveyards.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(461, 'Zone #%u doesn''t have linked graveyards for faction: %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(462, 'Teleport location already exists!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(463, 'Teleport location added.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(464, 'Teleport location NOT added: database error.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(465, 'Teleport location deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(466, 'No taxinodes found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(467, 'Target unit has %d auras:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(468, 'id: %d effmask: %d charges: %d stack: %d slot %d duration: %d maxduration: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(469, 'Target unit has %d auras of type %d:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(470, 'id: %d eff: %d amount: %d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(471, 'Quest %u not found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(472, 'Quest %u started from item. For correct work, please, add item to inventory and start quest in normal way: .additem %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(473, 'Quest removed.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(474, ' [rewarded]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(475, ' [complete]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(476, ' [active]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(477, '%s''s Fly Mode %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(478, 'Opcode %u sent to %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(479, 'Character loaded successfully!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(480, 'Failed to load the character!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(481, 'Character dumped successfully!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(482, 'Character dump failed!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(483, 'Spell %u broken and not allowed to cast or learn!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(484, 'Skill %u (%s) for player %s set to %u and current maximum set to %u (without permanent (talent) bonuses).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(485, 'Player %s must have skill %u (%s) before using this command.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(486, 'Invalid skill id (%u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(487, 'You learned default GM spells/skills.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(488, 'You already know that spell.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(489, 'Target(%s) already know that spell.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(490, '%s doesn''t know that spell.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(491, 'You already forgot that spell.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(492, 'All spell cooldowns removed for %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(493, 'Spell %u cooldown removed for %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(494, 'Command : Additem, itemId = %i, amount = %i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(495, 'Command : Additemset, itemsetId = %i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(496, 'Removed itemID = %i, amount = %i from %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(497, 'Cannot create item ''%i'' (amount: %i)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(498, 'You need to provide a guild name!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(499, 'Player not found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(500, 'Player already has a guild!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(501, 'Guild not created! (already exists?)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(502, 'No items from itemset ''%u'' found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(503, 'The distance is: (3D) %f (2D) %f (Exact 3D) %f (Exact 2D) %f yards.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(504, 'Item ''%i'' ''%s'' Item Slot %i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(505, 'Item ''%i'' doesn''t exist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(506, 'Item ''%i'' ''%s'' Added to Slot %i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(507, 'Item save failed!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(508, '%d - owner: %s (guid: %u account: %u ) %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(509, '%d - sender: %s (guid: %u account: %u ) receiver: %s (guid: %u account: %u ) %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(510, '%d - owner: %s (guid: %u account: %u ) %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(511, 'Wrong link type!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(512, '%d - |cffffffff|Hitem:%d:0:0:0:0:0:0:0:0|h[%s]|h|r ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(513, '%d - |cffffffff|Hquest:%d:%d|h[%s]|h|r %s',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(514, '%d - |cffffffff|Hcreature_entry:%d|h[%s]|h|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(515, '%d - |cffffffff|Hcreature:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(516, '%d - |cffffffff|Hgameobject_entry:%d|h[%s]|h|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(517, '%d - |cffffffff|Hgameobject:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(518, '%d - |cffffffff|Hitemset:%d|h[%s %s]|h|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(519, '|cffffffff|Htele:%s|h[%s]|h|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(520, '%d - |cffffffff|Hspell:%d|h[%s]|h|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(521, '%d - |cffffffff|Hskill:%d|h[%s %s]|h|r %s %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(522, 'Game Object (Entry: %u) not found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(523, '>> Game Object %s (GUID: %u) at %f %f %f. Orientation %f.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(524, 'Selected object:\n|cffffffff|Hgameobject:%d|h[%s]|h|r GUID: %u ID: %u\nX: %f Y: %f Z: %f MapId: %u\nOrientation: %f\nPhasemask %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(525, '>> Add Game Object ''%i'' (%s) (GUID: %i) added at ''%f %f %f''.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(526, '%s (lowguid: %u) movement generators stack:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(527, '   Idle', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(528, '   Random', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(529, '   Waypoint', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(530, '   Animal random', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(531, '   Confused', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(532, '   Targeted to player %s (lowguid %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(533, '   Targeted to creature %s (lowguid %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(534, '   Targeted to <NULL>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(535, '   Home movement to (X:%f Y:%f Z:%f)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(536, '   Home movement used for player?!?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(537, '   Taxi flight', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(538, '   Unknown movement generator (%u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(539, 'Player selected NPC\nGUID: %u.\nFaction: %u.\nnpcFlags: %u.\nEntry: %u.\nDisplayID: %u (Native: %u).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(540, 'Level: %u.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(541, 'Health (base): %u. (max): %u. (current): %u.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(542, 'Field Flags: %u.\nDynamic Flags: %u.\nFaction Template: %u.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(543, 'Loot: %u Pickpocket: %u Skinning: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(544, 'Position: %f %f %f.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(545, '*** Is a vendor!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(546, '*** Is a trainer!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(547, 'InstanceID: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(548, 'Player%s %s (guid: %u) Account: %s (id: %u) Email: %s GMLevel: %u Last IP: %s Last login: %s Latency: %ums', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(549, 'Race: %s Class: %s Played time: %s Level: %u Money: %ug%us%uc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(550, 'Command .pinfo doesn''t support ''rep'' option for offline players.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(551, '%s has explored all zones now.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(552, '%s has no more explored zones.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(553, '%s has explored all zones for you.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(554, '%s has hidden all zones from you.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(555, 'Hover enabled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(556, 'Hover disabled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(557, '%s level up you to (%i)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(558, '%s level down you to (%i)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(559, '%s reset your level progress.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(560, 'The area has been set as explored.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(561, 'The area has been set as not explored.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(562, 'GUID=%i ''s updateIndex: %i, value:  %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(563, 'You change GUID=%i ''s UpdateIndex: %i value to %i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(564, 'The value index %u is too big to %u(count: %u).', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(565, 'Set %u uint32 Value:[OPCODE]:%u [VALUE]:%u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(566, 'You Set %u Field:%u to uint32 Value: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(567, 'Set %u float Value:[OPCODE]:%u [VALUE]:%f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(568, 'You Set %u Field:%i to float Value: %f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(569, 'Get %u uint32 Value:[OPCODE]:%u [VALUE]:%u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(570, 'The uint32 value of %u in %u is: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(571, 'Get %u float Value:[OPCODE]:%u [VALUE]:%f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(572, 'The float of %u value in %u is: %f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(573, '.Set32Bit:[OPCODE]:%u [VALUE]:%u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(574, 'You set Bit of Field:%u to Value: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(575, '.Mod32Value:[OPCODE]:%u [VALUE]:%i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(576, 'You modified the value of Field:%u to Value: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(577, 'You are now invisible.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(578, 'You are now visible.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(579, 'Selected player or creature not have victim.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(580, 'Player %s learned all default spells for race/class and completed quests rewarded spells.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(581, 'Found near gameobjects (distance %f): %u ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(582, 'SpawnTime: Full:%s Remain:%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(583, '%d - |cffffffff|Hgameevent:%d|h[%s]|h|r%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(584, 'No event found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(585, 'Event not exist!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(586, 'Event %u: %s%s\nStart: %s End: %s Occurence: %s Length: %s\nNext state change: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(587, 'Event %u already active!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(588, 'Event %u not active!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(589, '   Point movement to (X:%f Y:%f Z:%f)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(590, '   Fear movement', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(591, '   Distract movement', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592, 'You have learned all spells in craft: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(593, 'Currently Banned Accounts:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(594, '|    Account    |   BanDate    |   UnbanDate  |  Banned By    |   Ban Reason  |', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(595, 'Currently Banned IPs:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(596, '|      IP       |   BanDate    |   UnbanDate  |  Banned By    |   Ban Reason  |', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(597, 'Current gamemasters:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(598, '|    Account    |  GM  |', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(599, 'No gamemasters.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(600, 'The Alliance wins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(601, 'The Horde wins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(602, 'The battle for Warsong Gulch begins in 1 minute.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(603, 'The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(604, 'Let the battle for Warsong Gulch begin!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(605, '$n captured the Horde flag!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(606, '$n captured the Alliance flag!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(607, 'The Horde flag was dropped by $n!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(608, 'The Alliance Flag was dropped by $n!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(609, 'The Alliance Flag was returned to its base by $n!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(610, 'The Horde flag was returned to its base by $n!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(611, 'The Horde flag was picked up by $n!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(612, 'The Alliance Flag was picked up by $n!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(613, 'The flags are now placed at their bases.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(614, 'The Alliance flag is now placed at its base.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(615, 'The Horde flag is now placed at its base.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(636, 'The Battle for Eye of the Storm begins in 1 minute.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(637, 'The Battle for Eye of the Storm begins in 30 seconds.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(638, 'The Battle for Eye of the Storm has begun!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(650, 'Alliance', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(651, 'Horde', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(652, 'stables', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(653, 'blacksmith', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(654, 'farm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(655, 'lumber mill', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(656, 'mine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(657, 'The %s has taken the %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(658, '$n has defended the %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(659, '$n has assaulted the %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(660, '$n claims the %s! If left unchallenged, the %s will control it in 1 minute!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(661, 'The Battle for Arathi Basin begins in 1 minute.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(662, 'The Battle for Arathi Basin begins in 30 seconds. Prepare yourselves!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(663, 'The Battle for Arathi Basin has begun!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(664, 'The Alliance has gathered $1776W resources, and is near victory!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(665, 'The Horde has gathered $1777W resources, and is near victory!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(666, 'After your recent battle in %s our best attempts to award you a Mark of Honor failed. Enclosed you will find the Mark of Honor we were not able to deliver to you at the time. Thanks for fighting in %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(667, 'The Alliance has taken control of the Mage Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(668, 'The Horde has taken control of the Mage Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(669, 'The Alliance has taken control of the Draenei Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(670, 'The Horde has taken control of the Draenei Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(671, 'The Alliance has taken control of the Blood Elf Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(672, 'The Horde has taken control of the Blood Elf Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(673, 'The Alliance has taken control of the Fel Reaver Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(674, 'The Horde has taken control of the Fel Reaver Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(675, 'The Alliance has lost control of the Mage Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(676, 'The Horde has lost control of the Mage Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(677, 'The Alliance has lost control of the Draenei Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(678, 'The Horde has lost control of the Draenei Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(679, 'The Alliance has lost control of the Blood Elf Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(680, 'The Horde has lost control of the Blood Elf Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(681, 'The Alliance has lost control of the Fel Reaver Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(682, 'The Horde has lost control of the Fel Reaver Ruins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(683, '%s has taken the flag!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(684, 'The Alliance have captured the flag!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(685, 'The Horde have captured the flag!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(686, 'The flag has been dropped.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(687, 'The flag has been reset.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(700, 'You must be level %u to form an arena team', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(701, 'One minute until the Arena battle begins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(702, 'Thirty seconds until the Arena battle begins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(703, 'Fifteen seconds until the Arena battle begins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(704, 'The Arena battle has begun!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(705, 'You must wait %s before speaking again.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(706, 'This item(s) have problems with equipping/storing in inventory.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(707, '%s wishes to not be disturbed and cannot receive whisper messages: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(708, '%s is Away from Keyboard: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(709, 'Do not Disturb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(710, 'Away from Keyboard', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(711, 'Queue status for %s (Lvl: %u to %u)\nQueued alliances: %u (Need at least %u more)\nQueued hordes: %u (Need at least %u more)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(712, '|cffff0000[BG Queue Announcer]:|r %s -- [%u-%u] A: %u/%u, H: %u/%u|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(713, 'You must be level %u to join an arena team!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(715, 'You don''t meet Battleground level requirements', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(717, '|cffff0000[BG Queue Announcer]:|r %s -- [%u-%u] Started!|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(718, '|cffff0000[Arena Queue Announcer]:|r %s -- Joined : %ux%u : %u|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(719, '|cffff0000[Arena Queue Announcer]:|r %s -- Exited : %ux%u : %u|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(720, 'Your group is too large for this battleground. Please regroup to join.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(721, 'Your group is too large for this arena. Please regroup to join.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(722, 'Your group has members not in your arena team. Please regroup to join.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(723, 'Your group does not have enough players to join this match.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(724, 'The Gold Team wins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(725, 'The Green Team wins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(726, 'There aren''t enough players in this battleground. It will end soon unless some more players join to balance the fight.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(727, 'Your group has an offline member. Please remove him before joining.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(728, 'Your group has players from the opposing faction. You can''t join the battleground as a group.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(729, 'Your group has players from different battleground brakets. You can''t join as group.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(730, 'Someone in your party is already in this battleground queue. (S)he must leave it before joining as group.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(731, 'Someone in your party is Deserter. You can''t join as group.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(732, 'Someone in your party is already in three battleground queues. You cannot join as group.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(733, 'You cannot teleport to a battleground or arena map.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(734, 'You cannot summon players to a battleground or arena map.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(735, 'You must be in GM mode to teleport to a player in a battleground.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(736, 'You cannot teleport to a battleground from another battleground. Please leave the current battleground first.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(737, 'Arenas are set to 1v1 for debugging. So, don''t join as group.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(738, 'Arenas are set to normal playercount.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(739, 'Battlegrounds are set to 1v0 for debugging.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(740, 'Battlegrounds are set to normal playercount.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(741, 'Flushing Arena points based on team ratings, this may take a few minutes. Please stand by...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(742, 'Distributing arena points to players...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(743, 'Finished setting arena points for online players.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(744, 'Modifying played count, arena points etc. for loaded arena teams, sending updated stats to online players...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(745, 'Modification done.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(746, 'Done flushing Arena points.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(747, 'This Battleground have been disabled. You can''t join the queue.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(748, 'Arenas have been disabled. You can''t join the queue.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(750, 'Not enough players. This game will close in %u mins.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(751, 'Not enough players. This game will close in %u seconds.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(753, 'The battle for Warsong Gulch begins in 2 minutes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(754, 'The battle for Arathi Basin begins in 2 minutes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(755, 'The battle for Eye of the Storm begins in 2 minutes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(785, 'Arena testing turned %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(786, '|cffff0000[Automatic]:|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(787, '|cffffff00[|c1f40af20Announce by|r |cffff0000%s|cffffff00]:|r %s|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(800, 'Invalid name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(801, 'You do not have enough gold', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(802, 'You do not have enough free slots', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(803, 'Your partner does not have enough free bag slots', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(804, 'You do not have permission to perform that function', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(805, 'Unknown language', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(806, 'You don''t know that language', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(807, 'Please provide character name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(808, 'Player %s not found or offline', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(809, 'Account for character %s not found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(810, '|Hplayer:$N|h[$N]|h has earned the achievement $a!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(811, 'Guild Master', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(812, 'Officer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(813, 'Veteran', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(814, 'Member', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(815, 'Initiate', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(816, 'Warning: You''ve entered a no-fly zone and are about to be dismounted!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(817, 'Entry %u not found in creature_template table.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(818, 'Entry %u not found in sCreatureStorage. Possible new line in creature_template, but you can not add new creatures without restarting. Only modifing is allowed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(1000, 'Exiting daemon...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1001, 'Account deleted: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1002, 'Account %s NOT deleted (probably sql file format was updated)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1003, 'Account %s NOT deleted (unknown error)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1004, 'Account created: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1005, 'Account name can''t be longer than 16 characters (client limit), account not created!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1006, 'Account with this name already exist!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1007, 'Account %s NOT created (probably sql file format was updated)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1008, 'Account %s NOT created (unknown error)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1009, 'Player %s (Guid: %u) Account %s (Id: %u) deleted.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1010, '[         Account][   Character][             IP][GMLev][Expansion][Map][Zone]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1011, '|<Error>        | %20s |<Error>          |<Er>| <Error>   |', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1012, '==============================================================================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1013, '-[%16s][%12s][%15s][%5d][%9d][%3d][%4d]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1014, 'No online players.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1015, '============================== Characters Online =============================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1016, '| GUID       | Name                 | Account                      | Delete Date         |', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1017, '| %10u | %20s | %15s (%10u) | %19s |', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1018, '==========================================================================================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1019, 'No characters found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1020, 'Restoring the following characters:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1021, 'Deleting the following characters:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1022, 'ERROR: You can only assign a new name if you have only selected a single character!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1023, 'Character ''%s'' (GUID: %u Account %u) can''t be restored: account not exist!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1024, 'Character ''%s'' (GUID: %u Account %u) can''t be restored: account character list full!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1025, 'Character ''%s'' (GUID: %u Account %u) can''t be restored: new name already used!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1026, 'GUID: %u Name: %s Account: %s (%u) Date: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1100, 'Account %s (Id: %u) have up to %u expansion allowed now.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1101, 'Message of the day changed to:\r\n%s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1102, 'Message sent to %s: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1103, '%d - %s %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1104, '%d - %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1105, '%d - %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1106, '%d - %s %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1107, '%d - %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1108, '%d - %s %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1109, '%d - %s %s %s %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1110, '%d - %s X:%f Y:%f Z:%f MapId:%d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1111, '%d - %s X:%f Y:%f Z:%f MapId:%d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1112, 'Failed to open file: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1113, 'Account %s (%u) have max amount allowed characters (client limit)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1114, 'Dump file have broken data!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1115, 'Invalid character name!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1116, 'Invalid character guid!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1117, 'Character guid %u in use!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1118, '%d - guild: %s (guid: %u) %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1119, 'You must use male or female as gender.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1120, 'You change gender of %s to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1121, 'Your gender changed to %s by %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1122, '(%u/%u +perm %u +temp %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1123, 'Not pet found', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1124, 'Wrong pet type', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1125, 'Your pet learned all talents', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1126, 'Your pet talents have been reset.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1127, 'Talents of %s''s pet reset.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1128, '%d - |cffffffff|Htaxinode:%u|h[%s %s]|h|r (Map:%u X:%f Y:%f Z:%f)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1129, '%d - %s %s (Map:%u X:%f Y:%f Z:%f)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1130, 'Can''t dump deleted characters, aborting.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1131, 'The following characters match your query:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1132, 'Currently Banned Characters:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1133, '|   Character   |   BanDate    |   UnbanDate  |  Banned By    |   Ban Reason  |', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1200, 'You try to view cinemitic %u but it doesn''t exist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1201, 'You try to view movie %u but it doesn''t exist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1300, 'Alliance', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1301, 'Horde', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1302, '%s was destroyed by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1303, 'The %s is under attack! If left unchecked, the %s will destroy it!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1304, 'The %s was taken by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1305, 'The %s was taken by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1306, 'The %s was taken by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1307, 'The %s is under attack! If left unchecked, the %s will capture it!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1308, 'The %s has taken the %s! Its supplies will now be used for reinforcements!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1309, 'Irondeep Mine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1310, 'Coldtooth Mine', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1311, 'Stormpike Aid Station', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1312, 'Dun Baldar South Bunker', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1313, 'Dun Baldar North Bunker', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1314, 'Stormpike Graveyard', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1315, 'Icewing Bunker', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1316, 'Stonehearth Graveyard', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1317, 'Stonehearth Bunker', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1318, 'Snowfall Graveyard', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1319, 'Iceblood Tower', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1320, 'Iceblood Graveyard', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1321, 'Tower Point', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1322, 'Frostwolf Graveyard', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1323, 'East Frostwolf Tower', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1324, 'West Frostwolf Tower', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1325, 'Frostwolf Relief Hut', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1326, 'The Battle for Alterac Valley begins in 1 minute.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1327, 'The Battle for Alterac Valley begins in 30 seconds. Prepare yourselves!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1328, 'The Battle for Alterac Valley has begun!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1329, 'The Alliance Team is running out of reinforcements!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1330, 'The Horde Team is running out of reinforcements!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1331, 'The Frostwolf General is Dead!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1332, 'The Stormpike General is Dead!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1333, 'The Battle for Alterac Valley begins in 2 minutes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2000, '|cff00ff00New ticket from|r|cffff00ff %s.|r |cff00ff00Ticket entry:|r|cffff00ff %d.|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2001, '|cff00ff00Character|r|cffff00ff %s |r|cff00ff00edited his/her ticket:|r|cffff00ff %d.|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2002, '|cff00ff00Character|r|cffff00ff %s |r|cff00ff00abandoned ticket entry:|r|cffff00ff %d.|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2003, '|cff00ff00Closed by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2004, '|cff00ff00Deleted by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2005, 'Ticket not found.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2006, 'Please close ticket before deleting it permanently.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2007, 'Ticket %d is already assigned.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2008, '%u Tickets succesfully reloaded from the database.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2009, 'Showing list of open tickets.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2010, 'Showing list of open tickets whose creator is online.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2011, 'Showing list of closed tickets.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2012, 'Invalid name specified. Name should be that of an online Gamemaster.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2013, 'This ticket is already assigned to yourself. To unassign use .ticket unassign %d and then reassign.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2014, 'Ticket %d is not assigned, you cannot unassign it.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2015, 'You cannot unassign tickets from staffmembers with a higher security level than yourself.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2016, 'Cannot close ticket %d, it is assigned to another GM.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2017, '|cffaaffaaTicket|r:|cffaaccff %d.|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2018, '|cff00ff00Created by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2019, '|cff00ff00Last change|r:|cff00ccff %s ago|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2020, '|cff00ff00Assigned to|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021, '|cff00ff00Unassigned by|r:|cff00ccff %s|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022, '|cff00ff00Ticket Message|r: [%s]|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2023, '|cff00ff00GM Comment|r: [%s]|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2024, '|cff00ccff%s|r |cff00ff00Added comment|r: [%s]|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2025, '|cff00ff00Created|r:|cff00ccff %s ago|r ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5000, 'You froze player %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5001, 'It might be amusing but no... you cant freeze yourself!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5002, 'Invalid input check the name of target.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5003, 'You unfroze player %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5004, 'There are no frozen players.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5005, 'Following players are frozen on the server:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5006, '- %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5007, 'You must be in a raid group to enter this instance.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5008, 'This instance is closed.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5009, 'Sound %u Played to server', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5010, 'linkGUID: %u, Entry: %u (%s)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5011, 'You can''t teleport self to self!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5012, 'No maps found!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5013, '[Continent]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5014, '[Instance]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5015, '[Battleground]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5016, '[Arena]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5017, '[Raid reset time: %s]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5018, '[Heroic reset time: %s]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5019, '[Mountable]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5020, 'Phasemask: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5021, 'Armor: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5022, 'Channel password not changed due to channel being marked public. GM Powers required.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5023, 'Channel: %s publicity set to: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5024, 'Entry: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5025, 'Type: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5026, 'DisplayID: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5027, 'Name: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5028, 'Lootid: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5029, 'Result limit reached (max results: %d)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6604, 'You cannot say, yell or emote until you become level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6605, 'You cannot whisper until you become level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6606, 'You cannot write to channels until you become level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6607, 'You cannot use auction until you become level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6608, 'You cannot write tickets until you become level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6609, 'You cannot trade until you become level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6610, 'You cannot trade with characters lower than level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6611, 'You cannot send mail until you become level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6612, 'You cannot send mail to characters lower than level %d.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6613, '|cfff00000[GM Announcement]: %s|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6614, 'Notification to GM''s - ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6615, '|cffffff00[|c1f40af20GM Announce by|r |cffff0000%s|cffffff00]:|r %s|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6616, 'Silence is ON for %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7523, 'WORLD: Denying connections.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7524, 'WORLD: Accepting connections.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10001, 'The Horde has taken The Overlook!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10002, 'The Alliance has taken The Overlook!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10003, 'The Horde has taken The Stadium!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10004, 'The Alliance has taken The Stadium!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10005, 'The Horde has taken Broken Hill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10006, 'The Alliance has taken Broken Hill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10007, 'The Horde lost The Overlook!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10008, 'The Alliance lost The Overlook!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10009, 'The Horde lost The Stadium!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10010, 'The Alliance lost The Stadium!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10011, 'The Horde lost Broken Hill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10012, 'The Alliance lost Broken Hill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10013, 'The Horde has taken the West Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10014, 'The Alliance has taken the West Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10015, 'The Horde has taken the East Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10016, 'The Alliance has taken the East Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10017, 'The Horde has captured the Twin Spire Graveyard!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10018, 'The Alliance has captured the Twin Spire Graveyard!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10019, 'The Horde lost the West Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10020, 'The Alliance lost the West Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10021, 'The Horde lost the East Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10022, 'The Alliance lost the East Beacon!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10023, 'The Horde lost the Twin Spire Graveyard!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10024, 'The Alliance lost the Twin Spire Graveyard!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10025, 'The Horde has captured Halaa!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10026, 'The Alliance has captured Halaa!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10027, 'The Horde lost Halaa!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10028, 'The Alliance lost Halaa!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10029, 'The Horde has taken a Spirit Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10030, 'The Alliance has taken a Spirit Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10031, 'The Horde lost a Spirit Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10032, 'The Alliance lost a Spirit Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10033, 'The Horde has taken the Northpass Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10034, 'The Alliance has taken the Northpass Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10035, 'The Horde has taken the Eastwall Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10036, 'The Alliance has taken the Eastwall Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10037, 'The Horde has taken the Crown Guard Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10038, 'The Alliance has taken the Crown Guard Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10039, 'The Horde has taken the Plaguewood Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10040, 'The Alliance has taken the Plaguewood Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10041, 'The Horde lost the Northpass Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10042, 'The Alliance lost the Northpass Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10043, 'The Horde lost the Eastwall Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10044, 'The Alliance lost the Eastwall Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10045, 'The Horde lost the Crown Guard Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10046, 'The Alliance lost the Crown Guard Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10047, 'The Horde lost the Plaguewood Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10048, 'The Alliance lost the Plaguewood Tower!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10049, 'The Horde has collected 200 silithyst!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10050, 'The Alliance has collected 200 silithyst!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10051, 'Take me to Northpass Tower.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10052, 'Take me to Eastwall Tower.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10053, 'Take me to Crown Guard Tower.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10054, 'Give me the flag, I''ll take it to the central beacon for the glory of the Alliance!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10055, 'Give me the flag, I''ll take it to the central beacon for the glory of the Horde!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10056,'The battle for Strand of the Ancients begins in 2 minutes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10057,'The battle for Strand of the Ancients begins in 1 minute.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10058,'The battle for Strand of the Ancients begins in 30 seconds. Prepare yourselves!.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10059,'Let the battle for Strand of the Ancients begin!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10060,'The %s is under attack!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10061,'The %s was destroyed!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10062,'Round 1 -  finished!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10063,'The Alliance captured the titan portal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10064,'The Horde captured the titan portal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10065,'Round 2 of the Battle for the Strand of the Ancients begins in 1 minute.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10066,'Round 2 begins in 30 seconds. Prepare yourselves!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10067,'The chamber has been breached! The titan relic is vulnerable!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10068,'The Alliance captured the South Graveyard!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10069,'The Alliance captured the West Graveyard!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10070,'The Alliance captured the East Graveyard!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10071,'The Horde captured the South Graveyard!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10072,'The Horde captured the West Graveyard!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10073,'The Horde captured the East Graveyard!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(11000, '|cffffff00[|c00077766Autobroadcast|cffffff00]: |cFFF222FF%s|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11001, 'You have not chosen -1 or the current realmID that you are on.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `trinity_string` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_accessory`
--

DROP TABLE IF EXISTS `vehicle_accessory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_accessory` (
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0,
  `accessory_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0,
  `seat_id` TINYINT(1) SIGNED NOT NULL DEFAULT 0,
  `minion` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`entry`, `seat_id`)
)
COLLATE=utf8_general_ci
ENGINE=MyISAM
ROW_FORMAT=FIXED
AVG_ROW_LENGTH=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_accessory`
--

LOCK TABLES `vehicle_accessory` WRITE;
/*!40000 ALTER TABLE `vehicle_accessory` DISABLE KEYS */;
INSERT INTO `vehicle_accessory` VALUES
(36678,38309,0,1, 'Professor Putricide - trigger'),
(36678,38308,1,1, 'Professor Putricide - trigger');
/*!40000 ALTER TABLE `vehicle_accessory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_scaling_info`
--

DROP TABLE IF EXISTS `vehicle_scaling_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_scaling_info` (
  `entry` mediumint(8) unsigned NOT NULL default '0',
  `baseItemLevel` float NOT NULL default '0',
  `scalingFactor` float NOT NULL default '0',
  PRIMARY KEY  (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_scaling_info`
--

LOCK TABLES `vehicle_scaling_info` WRITE;
/*!40000 ALTER TABLE `vehicle_scaling_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_scaling_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `core_version` varchar(120) DEFAULT NULL COMMENT 'Core revision dumped at startup.',
  `core_revision` bigint(20) unsigned DEFAULT NULL,
  `db_version` varchar(120) DEFAULT NULL COMMENT 'Version of world DB.',
  `script_version` varchar(120) DEFAULT NULL COMMENT 'Version of scripts DB.',
  `cache_id` int(10) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Version Notes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waypoint_data`
--

DROP TABLE IF EXISTS `waypoint_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waypoint_data` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature GUID',
  `point` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `move_flag` tinyint(1) NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  `action_chance` smallint(3) NOT NULL DEFAULT '100',
  `wpguid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waypoint_data`
--

LOCK TABLES `waypoint_data` WRITE;
/*!40000 ALTER TABLE `waypoint_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `waypoint_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waypoint_scripts`
--

DROP TABLE IF EXISTS `waypoint_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waypoint_scripts` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `delay` int(11) unsigned NOT NULL DEFAULT '0',
  `command` int(11) unsigned NOT NULL DEFAULT '0',
  `datalong` int(11) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(11) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `guid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waypoint_scripts`
--

LOCK TABLES `waypoint_scripts` WRITE;
/*!40000 ALTER TABLE `waypoint_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `waypoint_scripts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-12-18 17:18:11
