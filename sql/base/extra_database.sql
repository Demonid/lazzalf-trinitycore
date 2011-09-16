/*
SQLyog Community v8.71 
MySQL - 5.1.37-1ubuntu5.5 : Database - extra2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `cheat_log` */

DROP TABLE IF EXISTS `cheat_log`;

CREATE TABLE `cheat_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cheat_type` varchar(45) NOT NULL,
  `guid` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `map` int(10) unsigned NOT NULL,
  `area` int(10) unsigned NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48143 DEFAULT CHARSET=latin1;

/*Table structure for table `item_stats` */

DROP TABLE IF EXISTS `item_stats`;

CREATE TABLE `item_stats` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guid` int(9) unsigned NOT NULL,
  `item` int(6) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `group_guid` int(9) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=82627 DEFAULT CHARSET=latin1;

/*Table structure for table `lotto_extractions` */

DROP TABLE IF EXISTS `lotto_extractions`;

CREATE TABLE `lotto_extractions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `winner` varchar(12) NOT NULL,
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `reward` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

/*Table structure for table `lotto_tickets` */

DROP TABLE IF EXISTS `lotto_tickets`;

CREATE TABLE `lotto_tickets` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(12) NOT NULL,
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mail_external` */

DROP TABLE IF EXISTS `mail_external`;

CREATE TABLE `mail_external` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receiver` int(10) unsigned NOT NULL,
  `subject` varchar(200) DEFAULT 'Support Message',
  `message` varchar(200) DEFAULT '',
  `money` int(10) unsigned NOT NULL DEFAULT '0',
  `item` int(10) unsigned NOT NULL DEFAULT '0',
  `item_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `porting` */

DROP TABLE IF EXISTS `porting`;

CREATE TABLE `porting` (
  `guid` int(32) unsigned NOT NULL,
  `active` int(8) NOT NULL DEFAULT '0',
  `fase` int(8) NOT NULL DEFAULT '0',
  `level` int(8) NOT NULL DEFAULT '0',
  `gold` int(32) NOT NULL DEFAULT '0',
  `id_equip_1` int(32) NOT NULL DEFAULT '0',
  `id_equip_2` int(32) NOT NULL DEFAULT '0',
  `id_equip_3` int(32) NOT NULL DEFAULT '0',
  `repu_1` int(32) NOT NULL DEFAULT '0',
  `level_repu_1` int(32) NOT NULL DEFAULT '0',
  `repu_2` int(32) NOT NULL DEFAULT '0',
  `level_repu_2` int(32) NOT NULL DEFAULT '0',
  `repu_3` int(32) NOT NULL DEFAULT '0',
  `level_repu_3` int(32) NOT NULL DEFAULT '0',
  `skill_1` int(32) NOT NULL DEFAULT '0',
  `level_skill_1` int(32) NOT NULL DEFAULT '0',
  `skill_2` int(32) NOT NULL DEFAULT '0',
  `level_skill_2` int(32) NOT NULL DEFAULT '0',
  `skill_3` int(32) NOT NULL DEFAULT '0',
  `level_skill_3` int(32) NOT NULL DEFAULT '0',
  `skill_4` int(32) NOT NULL DEFAULT '0',
  `level_skill_4` int(32) NOT NULL DEFAULT '0',
  `skill_5` int(32) NOT NULL DEFAULT '0',
  `level_skill_5` int(32) NOT NULL DEFAULT '0',
  `skill_6` int(32) NOT NULL DEFAULT '0',
  `level_skill_6` int(32) NOT NULL DEFAULT '0',
  `skill_7` int(32) NOT NULL DEFAULT '0',
  `level_skill_7` int(32) NOT NULL DEFAULT '0',
  `skill_8` int(32) NOT NULL DEFAULT '0',
  `level_skill_8` int(32) NOT NULL DEFAULT '0',
  `id_items` longtext,
  `ticket_txt` longtext,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
