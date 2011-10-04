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
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','45624','100','1','0','2','2');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49839','3','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49840','3','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49841','15','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49842','12','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49843','13','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49844','3','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49845','3','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49846','3','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49847','15','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49848','18','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49849','17','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('202212','49851','15','1','2','1','1');
