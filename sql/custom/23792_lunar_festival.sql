-- Script Lunar Festival
UPDATE `creature_template` SET `ScriptName`='boss_omen' WHERE `entry`='15467';
UPDATE `item_template` SET `ScriptName`='item_green_rocket_cluster' WHERE `entry`='21574';
-- Spawn Rocket Cluster
INSERT INTO `gameobject` VALUES ('12439752','180859','1','1','1','7627.31','-2902.84','464.438','4.6476','0','0','0.729636','-0.683835','300','0','1');
INSERT INTO `gameobject` VALUES ('12440308','180859','1','1','1','7621.55','-2936.24','461.938','1.3505','0','0','0.625092','0.780551','300','0','1');
INSERT INTO `gameobject` VALUES ('12440309','180859','1','1','1','7657.52','-2938.87','464.645','2.69824','0','0','0.97553','0.219865','300','0','1');
INSERT INTO `gameobject` VALUES ('12440310','180859','1','1','1','7586.59','-2890.75','463.798','5.46598','0','0','0.397326','-0.917677','300','0','1');
INSERT INTO `game_event_gameobject` VALUES ('12439752','7'),('12440308','7'),('12440309','7'),('12440310','7');
-- Spawn Elder Chogan'gada
INSERT INTO `creature` VALUES ('11738274','30538','571','1','1','0','0','1248.72','-4834.37','217.463','0.349193','300','0','0','12096','8814','0','0','0','0','0');
INSERT INTO `game_event_creature` VALUES ('11738274','7');


