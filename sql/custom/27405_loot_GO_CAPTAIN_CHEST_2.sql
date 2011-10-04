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
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','45624','100','1','0','1','2');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49840','3','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49841','15','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49842','12','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49843','13','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49844','3','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49845','3','1','1','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49846','3','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49847','15','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49848','2','1','0','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49849','2','1','2','1','1');
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values('201710','49851','15','1','0','1','1');
