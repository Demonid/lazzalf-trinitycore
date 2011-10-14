/*
SQLyog Community v9.20 
MySQL - 5.1.49-1ubuntu8.1 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `gameobject_template` (
	`entry` mediumint (8),
	`type` tinyint (3),
	`displayId` mediumint (8),
	`name` varchar (300),
	`IconName` varchar (300),
	`castBarCaption` varchar (300),
	`unk1` varchar (300),
	`faction` smallint (5),
	`flags` int (10),
	`size` float ,
	`questItem1` int (11),
	`questItem2` int (11),
	`questItem3` int (11),
	`questItem4` int (11),
	`questItem5` int (11),
	`questItem6` int (11),
	`data0` int (10),
	`data1` int (11),
	`data2` int (10),
	`data3` int (10),
	`data4` int (10),
	`data5` int (10),
	`data6` int (11),
	`data7` int (10),
	`data8` int (10),
	`data9` int (10),
	`data10` int (10),
	`data11` int (10),
	`data12` int (10),
	`data13` int (10),
	`data14` int (10),
	`data15` int (10),
	`data16` int (10),
	`data17` int (10),
	`data18` int (10),
	`data19` int (10),
	`data20` int (10),
	`data21` int (10),
	`data22` int (10),
	`data23` int (10),
	`AIName` char (192),
	`ScriptName` varchar (192),
	`WDBVerified` smallint (5)
); 
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) values('201710','3','9280','The Captain\'s Chest','','','','0','0','1','0','0','0','0','0','0','57','201710','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) values('202212','3','9281','The Captain\'s Chest','','','','0','0','1','0','0','0','0','0','0','57','202212','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','11723');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) values('202336','3','9280','The Captain\'s Chest','','','','0','0','1','0','0','0','0','0','0','57','202336','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','12340');
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) values('202337','3','9281','The Captain\'s Chest','','','','0','0','1','0','0','0','0','0','0','57','202337','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','12340');
