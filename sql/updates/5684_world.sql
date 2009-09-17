UPDATE `creature_template` SET `ScriptName`='npc_maghar_captive' WHERE `entry`=18210;

INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
   (18210,-1000482,'Look out!',0,0,0,0,'maghar captive SAY_MAG_START'),
   (18210,-1000483,'Don''t let them escape! Kill the strong one first!',0,0,0,0,'maghar captive SAY_MAG_NO_ESCAPE'),
   (18210,-1000484,'More of them coming! Watch out!',0,0,0,0,'maghar captive SAY_MAG_MORE'),
   (18210,-1000485,'Where do you think you''re going? Kill them all!',0,0,0,0,'maghar captive SAY_MAG_MORE_REPLY'),
   (18210,-1000486,'Ride the lightning, filth!',0,0,0,0,'maghar captive SAY_MAG_LIGHTNING'),
   (18210,-1000487,'FROST SHOCK!!!',0,0,0,0,'maghar captive SAY_MAG_SHOCK'),
   (18210,-1000488,'It is best that we split up now, in case they send more after us. Hopefully one of us will make it back to Garrosh. Farewell stranger.',0,0,0,0,'maghar captive SAY_MAG_COMPLETE');
   
DELETE FROM `script_waypoint` WHERE `entry`=18210;
INSERT INTO `script_waypoint` VALUES
   (18210, 0, -1581.410034, 8557.933594, 2.726, 0, ''),
   (18210, 1, -1579.908447, 8553.716797, 2.559, 0, ''),
   (18210, 2, -1577.829102, 8549.880859, 2.001, 0, ''),
   (18210, 3, -1571.161987, 8543.494141, 2.001, 0, ''),
   (18210, 4, -1563.944824, 8530.334961, 1.605, 0, ''),
   (18210, 5, -1554.565552, 8518.413086, 0.364, 0, ''),
   (18210, 6, -1549.239136, 8515.518555, 0.293, 0, ''),
   (18210, 7, -1518.490112, 8516.771484, 0.683, 2000, 'SAY_MAG_MORE'),
   (18210, 8, -1505.038940, 8513.247070, 0.672, 0, ''),
   (18210, 9, -1476.161133, 8496.066406, 2.157, 0, ''),
   (18210, 10, -1464.450684, 8492.601563, 3.529, 0, ''),
   (18210, 11, -1457.568359, 8492.183594, 4.449, 0, ''),
   (18210, 12, -1444.100342, 8499.031250, 6.177, 0, ''),
   (18210, 13, -1426.472168, 8510.116211, 7.686, 0, ''),
   (18210, 14, -1403.685303, 8524.146484, 9.680, 0, ''),
   (18210, 15, -1384.890503, 8542.014648, 11.180, 0, ''),
   (18210, 16, -1382.286133, 8539.869141, 11.139, 7500, 'SAY_MAG_COMPLETE'),
   (18210, 17, -1361.224609, 8521.440430, 11.144, 0, ''),
   (18210, 18, -1324.803589, 8510.688477, 13.050, 0, ''),
   (18210, 19, -1312.075439, 8492.709961, 14.235, 0, '');