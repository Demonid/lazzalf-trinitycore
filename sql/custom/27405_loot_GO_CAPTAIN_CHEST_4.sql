/*
SQLyog Community v9.20 
MySQL - 5.1.49-1ubuntu8.1 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `gameobject_loot_template` (
	`entry` mediumint (8),
	`item` mediumint (8),
	`ChanceOrQuestChance` float ,
	`lootmode` smallint (5),
	`groupid` tinyint (3),
	`mincountOrRef` mediumint (9),
	`maxcount` tinyint (3)
); 
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','43102','100','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','47241','100','1','0','1','2');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50302','21','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50303','22','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50304','8','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50306','8','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50308','9','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50309','13','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50311','15','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50312','13','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50313','12','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202336','50314','12','1','2','1','1');
