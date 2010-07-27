-- Onyxia by John
-- Small fixes
UPDATE `instance_template` SET `script`='instance_onyxias_lair' WHERE `map`=249;
UPDATE `script_texts` SET `type`=3 WHERE `entry`=-1249004;
UPDATE `script_texts` SET `content_default`='%s takes in a deep breath...' WHERE `entry`=-1249004;
UPDATE `gameobject_template` SET `faction`=103 WHERE `entry`=176511;

-- Hacks on the TDB: WDB object made since we don't have the real deal to make Ony work and modified Invisible Trigger level to 80!
DELETE FROM `gameobject_template` WHERE `entry`=176510;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(176510,5,11686,'Onyxia Whelp Spawner','','','',14,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',1);
-- Modifying World Invisible Trigger since it was lv 60... (it was making all eruptions miss)
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80 WHERE `entry`=12999;

DELETE FROM `creature_template` WHERE `entry` IN (10184,1018401,12129,1212901,11262,1126201,36561,3656101);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(10184, 1018401, 0, 0, 0, 0, 8570, 0, 0, 0, 'Onyxia', '', '', 0, 83, 83, 2, 103, 103, 0, 1.5, 1.14286, 0.9, 3, 1680, 2056, 0, 862, 17, 1500, 1800, 1, 64, 0, 0, 0, 0, 0, 0, 720, 990, 100, 2, 108, 10184, 0, 10184, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1030857, 1255575, '', 1, 3, 350, 1, 1.15, 0, 18705, 0, 0, 0, 0, 0, 0, 1, 0, 650854235, 1, 'boss_onyxia', 1),
(11262, 1126201, 0, 0, 0, 0, 397, 0, 0, 0, 'Onyxian Whelp', NULL, NULL, 0, 80, 80, 2, 16, 16, 0, 2.07, 1.14286, 1, 0, 363, 450, 0, 188, 7, 1216, 1338, 1, 0, 0, 0, 0, 0, 0, 0, 56.7312, 78.0054, 100, 2, 8, 0, 0, 100001, 0, 171, 95, 0, 0, 0, 20228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', 11403),
(12129, 1212901, 0, 0, 0, 0, 8711, 0, 0, 0, 'Onyxian Warder', '', '', 0, 80, 80, 2, 103, 103, 0, 1, 1.14286, 1, 1, 1070, 1362, 0, 561, 12, 1150, 1265, 1, 64, 0, 0, 0, 0, 0, 0, 220.81, 320.77, 100, 2, 8, 12129, 0, 12129, 0, 250, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5955, 5955, 'EventAI', 1, 3, 70, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 132, 651116511, 0, '', 1),
(36561, 3656101, 0, 0, 0, 0, 12891, 0, 0, 0, 'Onyxian Lair Guard', '', '', 0, 80, 80, 2, 103, 103, 0, 1, 1.14286, 1, 1, 1070, 1362, 0, 561, 12, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 220.81, 320.77, 100, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 132, 0, 0, '', 11403),
(1018401, 0, 0, 0, 0, 0, 8570, 0, 0, 0, 'Onyxia (1)', '', '', 0, 83, 83, 2, 103, 103, 0, 1.5, 1.14286, 0.9, 3, 1680, 2056 , 0, 862, 25, 1500, 1800, 1, 64, 0, 0, 0, 0, 0, 0, 720, 990, 100, 2, 108, 1018401, 0, 10184, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1030857, 1255575, '', 1, 3, 1600, 1, 1.15, 0, 18705, 0, 0, 0, 0, 0, 0, 1, 0, 650854235, 1, '', 1),
(1126201, 0, 0, 0, 0, 0, 397, 0, 0, 0, 'Onyxian Whelp (1)', NULL, NULL, 0, 80, 80, 2, 16, 16, 0, 2.07, 1.14286, 1, 0, 363, 450, 0, 188, 10, 1216, 1338, 1, 0, 0, 0, 0, 0, 0, 0, 56.7312, 78.0054, 100, 2, 8, 0, 0, 100001, 0, 171, 95, 0, 0, 0, 20228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', 1),
(1212901, 0, 0, 0, 0, 0, 8711, 0, 0, 0, 'Onyxian Warder (1)', '', '', 0, 80, 80, 2, 103, 103, 0, 1, 1.14286, 1, 1, 1070, 1362, 0, 561, 15, 1150, 1265, 1, 64, 0, 0, 0, 0, 0, 0, 220.81, 320.77, 100, 2, 8, 1212901, 0, 12129, 0, 250, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5955, 5955, '', 1, 3, 150, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 132, 651116511, 0, '', 1),
(3656101, 0, 0, 0, 0, 0, 12891, 0, 0, 0, 'Onyxian Lair Guard (1)', '', '', 0, 80, 80, 2, 103, 103, 0, 1, 1.14286, 1, 1, 1070, 1362, 0, 561, 15, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 220.81, 320.77, 100, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 50, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 132, 0, 0, '', 1);

DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (12129,36561);
INSERT INTO `creature_ai_scripts` VALUES 
( 1212901, 12129, 0, 0, 100, 7, 1000, 1000, 12000, 12000, 11, 20203, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyxia warder - Cast Fire Nova'),
( 1212902, 12129, 0, 0, 90, 7, 5000, 5000, 20000, 20000, 11, 18958, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyxia warder - Cast Flame Lash'),
( 1212903, 12129, 0, 0, 80, 7, 7000, 7000, 9000, 11000, 11, 15284, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyxia warder - Cast Cleave'),
( 1212904, 12129, 0, 0, 95, 7, 3000, 3000, 35000, 35000, 11, 12097, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyxia warder - Cast Pierce Armor'),
( 3656101, 36561, 0, 0, 100, 7, 15000, 15000, 12000, 12000, 11, 68958, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyxia Lair Guard - Cast Blast Nova'),
( 3656102, 36561, 0, 0, 90, 7, 5000, 5000, 20000, 20000, 11, 68960, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyxia Lair Guard - Cast Ignite Weapon'),
( 3656103, 36561, 0, 0, 80, 7, 7000, 7000, 9000, 11000, 11, 15284, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyxia Lair Guard - Cast Cleave');

-- update achievement criteria data for Onyxia related achievements 
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12558,12559,12564,12565,12566,12567,12568,12569);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
(12558,12,0,0),
(12559,12,1,0),
(12564,18,0,0),
(12565,18,0,0),
(12566,18,0,0),
(12567,18,0,0),
(12568,18,0,0),
(12569,18,0,0);

-- Instance Green Portal
DELETE FROM `gameobject_template` WHERE `entry` IN (200292,200293,200294,200295);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`) VALUES 
(200294, 31, 9041, 'Doodad_InstancePortal_Green_10Man01', '', '', '', 0, 0, 3.75, 0, 0, 0, 0, 0, 0, 249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(200292, 31, 9041, 'Doodad_InstancePortal_Green_10Man01', '', '', '', 0, 0, 3.75, 0, 0, 0, 0, 0, 0, 249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(200293, 31, 9042, 'Doodad_InstancePortal_Green_25Man01', '', '', '', 0, 0, 3.75, 0, 0, 0, 0, 0, 0, 249, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(200295, 31, 9042, 'Doodad_InstancePortal_Green_25Man01', '', '', '', 0, 0, 3.75, 0, 0, 0, 0, 0, 0, 249, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Onyxia by WarHead
-- Orig. Onyxia Spawns (10/25 - incl. working eggs)
-- Only missing things are the instance portals and waypoints (along the way) for the warders

-- Delete old ones...
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `map`=249);
DELETE FROM `npc_gossip` WHERE `npc_guid` IN (SELECT `guid` FROM `creature` WHERE `map`=249);
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `map`=249);
DELETE FROM `creature_respawn` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `map`=249);
DELETE FROM `waypoint_data` WHERE `id` IN (SELECT `guid`*10 FROM `creature` WHERE `map`=249);
DELETE FROM `creature` WHERE `map`=249;

-- 8 creature guids required
SET @GUID := 500000;

-- Spawn new orig. data...
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`currentwaypoint`,`MovementType`) VALUES 
(@GUID,10184,249,3,0,-4.8689,-217.171,-86.7104,3.14159,604800,1,2),
(@GUID+1,12129,249,3,973,-200.143,-212.381,-68.6295,0.855211,604800,1,2),
(@GUID+2,12129,249,3,973,-49.9299,-98.0713,-38.5961,6.24828,604800,1,2),
(@GUID+3,12129,249,3,973,-62.6642,-98.3359,-38.8011,3.10163,604800,1,2),
(@GUID+4,12129,249,3,973,-163.77,-206.52,-66.3153,2.70244,604800,1,2),
(@GUID+5,12129,249,3,973,45.7787,-125.624,-22.7369,5.05424,604800,1,2),
(@GUID+6,12129,249,3,973,-145.549,-147.036,-54.0258,4.18464,604800,1,2),
(@GUID+7,12129,249,3,973,-170.273,-195.673,-66.443,0.568851,604800,1,2);

-- Not important at the moment but a startpoint to let the warder walk along the ways and let Ony be where she must be at the begining. ;)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`) VALUES 
(@GUID*10,1,-4.8689,-217.171,-86.7104),
((@GUID+1)*10,1,-200.143,-212.381,-68.6295),
((@GUID+2)*10,1,-49.9299,-98.0713,-38.5961),
((@GUID+3)*10,1,-62.6642,-98.3359,-38.8011),
((@GUID+4)*10,1,-163.77,-206.52,-66.3153),
((@GUID+5)*10,1,45.7787,-125.624,-22.7369),
((@GUID+6)*10,1,-145.549,-147.036,-54.0258),
((@GUID+7)*10,1,-170.273,-195.673,-66.443);

-- Let Ony lay and sleep on the ground at the beginning...
DELETE FROM `creature_template_addon` WHERE `entry`=10184;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(10184,1,0,3,0,12,NULL);

-- Delete old ones...
DELETE FROM `gameobject` WHERE `id` IN (200292,200293,200294,200295);
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `map`=249);
DELETE FROM `gameobject_respawn` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `map`=249);
DELETE FROM `gameobject` WHERE `map`=249;

-- 249 gameobject guids required
SET @GUID := 1720090;

-- Spawn new orig. data...
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
(@GUID,178013,249,3,2.9536,-198.744,-87.0469,1.48353,0.67559,0.737278,604800,100,1),
(@GUID+1,176912,249,3,-62.8772,-213.235,-85.1575,2.00712,0.84339,0.537301,604800,100,1),
(@GUID+2,177998,249,3,-37.4064,-244.92,-89.0483,3.05433,0.999048,0.0436192,604800,100,1),
(@GUID+3,176839,249,3,-3.72498,-180.009,-85.9318,-0.95993,-0.461748,0.887011,604800,100,1),
(@GUID+4,176852,249,3,-33.7261,-200.163,-10.4158,2.26893,0.906307,0.422619,604800,100,1),
(@GUID+5,176812,249,3,8.23697,-253.584,-86.6082,-2.35619,-0.92388,0.382683,604800,100,1),
(@GUID+6,176831,249,3,24.0513,-193.897,-84.9566,2.53072,0.953716,0.300708,604800,100,1),
(@GUID+7,178024,249,3,27.5426,-247.756,-23.0949,-2.26893,-0.906307,0.422619,604800,100,1),
(@GUID+8,178043,249,3,-72.938,-201.879,-83.6438,-1.0472,-0.5,0.866025,604800,100,1),
(@GUID+9,177999,249,3,-26.0913,-229.619,-88.82,-1.83259,-0.793353,0.608762,604800,100,1),
(@GUID+10,178012,249,3,17.6418,-184.034,-86.1595,-1.309,-0.608761,0.793354,604800,100,1),
(@GUID+11,176853,249,3,21.8353,-202.084,-17.2387,2.53072,0.953716,0.300708,604800,100,1),
(@GUID+12,176838,249,3,8.01259,-175.786,-86.6082,2.35619,0.92388,0.382683,604800,100,1),
(@GUID+13,176913,249,3,-51.6644,-214.436,-86.1782,-2.53072,-0.953716,0.300708,604800,100,1),
(@GUID+14,176813,249,3,7.06976,-243.991,-86.9945,-2.70526,-0.976295,0.216442,604800,100,1),
(@GUID+15,178042,249,3,-78.5539,-210.417,-83.4326,2.87979,0.991445,0.130528,604800,100,1),
(@GUID+16,176830,249,3,-19.6951,-209.639,-88.5545,-0.43633,-0.216438,0.976296,604800,100,1),
(@GUID+17,178025,249,3,13.0761,-225.391,-19.2567,-2.79252,-0.984807,0.173652,604800,100,1),
(@GUID+18,176829,249,3,-19.3983,-219.854,-88.4829,-2.79252,-0.984807,0.173652,604800,100,1),
(@GUID+19,176854,249,3,37.2406,-214.403,-19.6757,2.18166,0.887011,0.461749,604800,100,1),
(@GUID+20,176837,249,3,6.95027,-185.41,-86.9946,2.70526,0.976295,0.216442,604800,100,1),
(@GUID+21,178015,249,3,6.95027,-185.41,-86.9946,2.70526,0.976295,0.216442,604800,100,1),
(@GUID+22,176914,249,3,-45.1242,-220.161,-86.5697,0.698129,0.342019,0.939693,604800,100,1),
(@GUID+23,176814,249,3,-3.98491,-248.954,-85.9318,0.95993,0.461748,0.887011,604800,100,1),
(@GUID+24,178026,249,3,-5.14033,-214.414,-11.1815,3.14159,1,-4.37114e-008,604800,100,1),
(@GUID+25,177996,249,3,-20.9761,-254.701,-87.7823,-2.61799,-0.965925,0.258821,604800,100,1),
(@GUID+26,178041,249,3,-39.1131,-212.133,-87.1607,-1.39626,-0.642788,0.766044,604800,100,1),
(@GUID+27,176855,249,3,-18.973,-232.403,-15.5299,2.44346,0.939692,0.34202,604800,100,1),
(@GUID+28,176836,249,3,-0.404226,-189.264,-87.3524,-1.39626,-0.642787,0.766045,604800,100,1),
(@GUID+29,176915,249,3,-39.1131,-212.133,-87.1607,-1.39626,-0.642788,0.766044,604800,100,1),
(@GUID+30,178014,249,3,-0.404226,-189.264,-87.3524,-1.39626,-0.642787,0.766045,604800,100,1),
(@GUID+31,177997,249,3,3.20326,-230.379,-87.0469,-1.48353,-0.67559,0.737278,604800,100,1),
(@GUID+32,176828,249,3,-9.80653,-212.031,-88.1401,-0.261798,-0.130526,0.991445,604800,100,1),
(@GUID+33,178040,249,3,-45.1242,-220.161,-86.5697,0.698129,0.342019,0.939693,604800,100,1),
(@GUID+34,176815,249,3,-0.638085,-239.839,-87.3523,1.39626,0.642788,0.766044,604800,100,1),
(@GUID+35,178027,249,3,-3.17108,-189.864,-15.1422,2.09439,0.866025,0.500001,604800,100,1),
(@GUID+36,176827,249,3,-1.66729,-217.144,-85.672,0.785397,0.382683,0.92388,604800,100,1),
(@GUID+37,178028,249,3,-29.1501,-173.658,-23.2926,-2.53072,-0.953716,0.300708,604800,100,1),
(@GUID+38,178047,249,3,-55.075,-241.777,-85.3179,1.0472,0.5,0.866025,604800,100,1),
(@GUID+39,176511,249,3,-47.5397,-152.736,-92.5478,-1.51844,-0.688354,0.725374,60,0,1),
(@GUID+40,176511,249,3,-42.0689,-275.035,-91.5219,-0.331611,-0.165047,0.986286,60,0,1),
(@GUID+41,176511,249,3,-30.9589,-271.528,-90.776,-2.77507,-0.983254,0.182238,60,0,1),
(@GUID+42,176511,249,3,-50.4296,-165.573,-92.9916,1.83259,0.793353,0.608762,60,0,1),
(@GUID+43,176511,249,3,-106.747,-213.256,-96.4219,-2.54818,-0.956305,0.292372,60,0,1),
(@GUID+44,176511,249,3,-44.8102,-159.351,-92.5613,-0.087266,-0.0436192,0.999048,60,0,1),
(@GUID+45,176511,249,3,-87.0724,-164.259,-93.194,1.23918,0.580703,0.814116,60,0,1),
(@GUID+46,176511,249,3,-65.2628,-157.384,-93.6179,0.191985,0.0958452,0.995396,60,0,1),
(@GUID+47,176511,249,3,-107.174,-221.764,-95.0417,-1.44862,-0.66262,0.748956,60,0,1),
(@GUID+48,176511,249,3,-106.704,-235.043,-94.3291,-2.89725,-0.992546,0.12187,60,0,1),
(@GUID+49,176511,249,3,-110.463,-210.574,-95.0231,-2.51327,-0.951056,0.309017,60,0,1),
(@GUID+50,176511,249,3,-111.548,-199.276,-92.7356,2.56563,0.958819,0.284016,60,0,1),
(@GUID+51,176511,249,3,-94.0342,-181.739,-93.6615,0.820303,0.398748,0.91706,60,0,1),
(@GUID+52,176511,249,3,-29.779,-158.272,-90.436,-1.01229,-0.484809,0.87462,60,0,1),
(@GUID+53,176511,249,3,-99.1198,-235.404,-93.9986,-2.60054,-0.96363,0.267241,60,0,1),
(@GUID+54,176511,249,3,-50.0996,-276.138,-92.8722,0.104719,0.0523357,0.99863,60,0,1),
(@GUID+55,176511,249,3,-111.415,-246.122,-92.7656,1.50098,0.681998,0.731354,60,0,1),
(@GUID+56,176511,249,3,-44.0785,-267.144,-92.2422,1.15192,0.544639,0.838671,60,0,1),
(@GUID+57,176511,249,3,-106.513,-179.027,-93.3376,-0.645772,-0.317305,0.948324,60,0,1),
(@GUID+58,176511,249,3,-74.5684,-166.841,-94.4562,2.9496,0.995396,0.0958512,60,0,1),
(@GUID+59,176511,249,3,-39.5905,-153.217,-91.394,2.05949,0.857167,0.515038,60,0,1),
(@GUID+60,176511,249,3,-35.4725,-267.161,-91.1384,1.55334,0.700909,0.713251,60,0,1),
(@GUID+61,176511,249,3,-103.341,-249.645,-93.7727,1.72787,0.760406,0.649449,60,0,1),
(@GUID+62,176511,249,3,-45.7833,-165.022,-91.9364,-0.767944,-0.374606,0.927184,60,0,1),
(@GUID+63,176511,249,3,-43.3735,-165.818,-91.6861,-0.104719,-0.0523357,0.99863,60,0,1),
(@GUID+64,176511,249,3,-87.5961,-249.819,-93.9075,-1.25664,-0.587785,0.809017,60,0,1),
(@GUID+65,176511,249,3,-80.2411,-267.274,-93.4431,-1.97222,-0.833885,0.551938,60,0,1),
(@GUID+66,177994,249,3,-15.3872,-232.509,-89.0988,-1.0472,-0.499999,0.866026,604800,100,1),
(@GUID+67,176511,249,3,-111.575,-243.442,-92.8365,-1.32645,-0.615661,0.788011,60,0,1),
(@GUID+68,176511,249,3,-59.5468,-274.641,-93.5779,-2.80998,-0.986285,0.16505,60,0,1),
(@GUID+69,176511,249,3,-98.2849,-191.193,-93.9694,-0.942477,-0.45399,0.891007,60,0,1),
(@GUID+70,176511,249,3,-111.047,-201.01,-92.6798,1.5708,0.707107,0.707107,60,0,1),
(@GUID+71,176511,249,3,-95.201,-182.384,-93.6637,-1.02974,-0.492423,0.870356,60,0,1),
(@GUID+72,176511,249,3,-50.3012,-263.668,-92.9696,-2.37364,-0.927183,0.374608,60,0,1),
(@GUID+73,176511,249,3,-93.1516,-180.838,-93.7367,0.680677,0.333806,0.942642,60,0,1),
(@GUID+74,176511,249,3,-37.4862,-169.345,-90.3578,1.15192,0.544639,0.838671,60,0,1),
(@GUID+75,176511,249,3,-103.507,-254.765,-92.4439,3.01941,0.998135,0.0610517,60,0,1),
(@GUID+76,176511,249,3,-64.9187,-264.948,-94.5168,2.53072,0.953716,0.300708,60,0,1),
(@GUID+77,176511,249,3,-67.8154,-260.002,-94.4454,-0.750491,-0.366501,0.930418,60,0,1),
(@GUID+78,176511,249,3,-86.5817,-162.188,-92.9143,1.37881,0.636078,0.771625,60,0,1),
(@GUID+79,176511,249,3,-68.2031,-161.518,-93.9692,-2.19911,-0.891006,0.453991,60,0,1),
(@GUID+80,176511,249,3,-85.6779,-161.272,-92.7821,1.309,0.608761,0.793354,60,0,1),
(@GUID+81,176511,249,3,-53.4205,-157.888,-94.0279,-2.426,-0.936671,0.35021,60,0,1),
(@GUID+82,176511,249,3,-113.473,-181.242,-92.5385,2.14675,0.878817,0.47716,60,0,1),
(@GUID+83,176511,249,3,-103.471,-199.919,-93.8398,-1.0821,-0.515038,0.857168,60,0,1),
(@GUID+84,176511,249,3,-114.866,-197.405,-92.714,-3.10665,-0.999847,0.0174693,60,0,1),
(@GUID+85,176511,249,3,-107.68,-206.48,-94.6221,-0.855211,-0.414693,0.909961,60,0,1),
(@GUID+86,176511,249,3,-52.4708,-263.242,-93.5507,0.90757,0.438371,0.898794,60,0,1),
(@GUID+87,176511,249,3,-111.68,-241.218,-92.8957,1.46608,0.66913,0.743145,60,0,1),
(@GUID+88,176511,249,3,-44.6409,-262.822,-91.7046,0.366518,0.182235,0.983255,60,0,1),
(@GUID+89,176511,249,3,-85.7268,-166.618,-93.7028,-2.05949,-0.857167,0.515038,60,0,1),
(@GUID+90,176511,249,3,-86.038,-247.12,-93.7162,-2.63544,-0.968147,0.250381,60,0,1),
(@GUID+91,176511,249,3,-111.482,-182.822,-92.7533,-2.05949,-0.857167,0.515038,60,0,1),
(@GUID+92,176511,249,3,-91.717,-267.4,-92.7929,2.91469,0.993571,0.113208,60,0,1),
(@GUID+93,176511,249,3,-110.212,-220.17,-94.5324,1.79769,0.782608,0.622515,60,0,1),
(@GUID+94,176511,249,3,-51.2772,-165.257,-93.2615,2.35619,0.92388,0.382683,60,0,1),
(@GUID+95,176511,249,3,-35.6781,-274.806,-91.542,2.05949,0.857167,0.515038,60,0,1),
(@GUID+96,178009,249,3,24.0513,-193.897,-84.9566,2.53072,0.953716,0.300708,604800,100,1),
(@GUID+97,176848,249,3,-5.14033,-214.414,-11.1815,3.14159,1,-4.37114e-008,604800,100,1),
(@GUID+98,176511,249,3,-95.9989,-256.291,-92.8816,1.01229,0.484809,0.87462,60,0,1),
(@GUID+99,176511,249,3,-53.8375,-150.039,-92.7003,-2.72271,-0.978148,0.207912,60,0,1),
(@GUID+100,176511,249,3,-40.6709,-271.109,-91.7795,-1.309,-0.608761,0.793354,60,0,1),
(@GUID+101,176511,249,3,-98.7962,-246.976,-93.9981,0.855211,0.414693,0.909961,60,0,1),
(@GUID+102,176511,249,3,-45.6929,-276.807,-92.1201,-2.96704,-0.996194,0.0871651,60,0,1),
(@GUID+103,176511,249,3,-37.8847,-153.093,-91.4679,-3.07177,-0.999391,0.0349062,60,0,1),
(@GUID+104,176511,249,3,-115.037,-181.69,-92.3133,-3.12412,-0.999962,0.00873467,60,0,1),
(@GUID+105,176511,249,3,-29.4053,-162.407,-89.9302,-1.01229,-0.484809,0.87462,60,0,1),
(@GUID+106,176511,249,3,-88.6535,-248.14,-93.9176,1.65806,0.737277,0.675591,60,0,1),
(@GUID+107,176511,249,3,-63.397,-270.089,-93.9065,-1.88495,-0.809016,0.587786,60,0,1),
(@GUID+108,176511,249,3,-54.0655,-265.427,-93.939,1.43117,0.656058,0.75471,60,0,1),
(@GUID+109,176511,249,3,-113.011,-239.265,-92.5883,-1.55334,-0.700909,0.713251,60,0,1),
(@GUID+110,176511,249,3,-104.51,-218.292,-95.9924,0.95993,0.461748,0.887011,60,0,1),
(@GUID+111,176916,249,3,-78.5539,-210.417,-83.4326,2.87979,0.991445,0.130528,604800,100,1),
(@GUID+112,176511,249,3,-74.6337,-262.796,-94.4129,-1.90241,-0.814116,0.580703,60,0,1),
(@GUID+113,176511,249,3,-51.989,-149.852,-92.4877,-2.18166,-0.887011,0.461749,60,0,1),
(@GUID+114,176511,249,3,-70.196,-171.583,-94.1259,0.95993,0.461748,0.887011,60,0,1),
(@GUID+115,176511,249,3,-113.549,-198.287,-92.5772,-2.60054,-0.96363,0.267241,60,0,1),
(@GUID+116,176511,249,3,-79.7331,-165.826,-94.2637,0.872664,0.422618,0.906308,60,0,1),
(@GUID+117,176511,249,3,-95.5697,-189.903,-93.5909,-0.610864,-0.300705,0.953717,60,0,1),
(@GUID+118,176511,249,3,-66.8605,-262.532,-94.4959,0.925024,0.446198,0.894935,60,0,1),
(@GUID+119,176511,249,3,-90.6963,-181.785,-93.9151,0.209439,0.104528,0.994522,60,0,1),
(@GUID+120,176511,249,3,-49.5906,-150.509,-92.4396,0.925024,0.446198,0.894935,60,0,1),
(@GUID+121,176511,249,3,-96.2669,-191.546,-93.7112,1.46608,0.66913,0.743145,60,0,1),
(@GUID+122,176511,249,3,-99.0315,-232.903,-93.8821,0.575957,0.284015,0.95882,60,0,1),
(@GUID+123,176511,249,3,-103.253,-185.857,-94.1001,-1.01229,-0.484809,0.87462,60,0,1),
(@GUID+124,176511,249,3,-109.672,-176.396,-92.3824,-3.05433,-0.999048,0.0436192,60,0,1),
(@GUID+125,176511,249,3,-37.4504,-159.241,-91.3623,-0.139624,-0.0697556,0.997564,60,0,1),
(@GUID+126,176511,249,3,-98.9627,-192.996,-93.9977,-1.90241,-0.814116,0.580703,60,0,1),
(@GUID+127,176511,249,3,-54.8459,-262.636,-93.696,-0.139624,-0.0697556,0.997564,60,0,1),
(@GUID+128,176511,249,3,-114.179,-189.911,-92.3961,-0.575957,-0.284015,0.95882,60,0,1),
(@GUID+129,176511,249,3,-47.6633,-165.894,-91.9484,0.506145,0.25038,0.968148,60,0,1),
(@GUID+130,176511,249,3,-59.2068,-166.133,-94.0845,0.715585,0.350207,0.936672,60,0,1),
(@GUID+131,176511,249,3,-83.4607,-171.184,-94.2168,-1.8675,-0.803857,0.594823,60,0,1),
(@GUID+132,176511,249,3,-99.4653,-231.539,-93.7484,-0.680679,-0.333807,0.942641,60,0,1),
(@GUID+133,176511,249,3,-106.513,-181.398,-93.8598,2.86234,0.990268,0.139175,60,0,1),
(@GUID+134,176511,249,3,-109.3,-192.893,-93.648,1.62316,0.725374,0.688355,60,0,1),
(@GUID+135,176511,249,3,-54.7384,-158.798,-94.216,1.23918,0.580703,0.814116,60,0,1),
(@GUID+136,176511,249,3,-108.456,-243.108,-93.6305,-1.309,-0.608761,0.793354,60,0,1),
(@GUID+137,176511,249,3,-101.612,-178.335,-93.7528,2.53072,0.953716,0.300708,60,0,1),
(@GUID+138,176511,249,3,-106.301,-253.522,-92.4453,0.715585,0.350207,0.936672,60,0,1),
(@GUID+139,176511,249,3,-50.1314,-157.125,-93.4149,2.9845,0.996917,0.0784665,60,0,1),
(@GUID+140,176511,249,3,-45.7571,-151.807,-92.0807,-0.453785,-0.224951,0.97437,60,0,1),
(@GUID+141,176835,249,3,2.9536,-198.744,-87.0469,1.48353,0.67559,0.737278,604800,100,1),
(@GUID+142,176511,249,3,-67.1603,-160.194,-93.5402,0.331611,0.165047,0.986286,60,0,1),
(@GUID+143,176511,249,3,-88.0213,-181.019,-93.8623,0.890117,0.430511,0.902586,60,0,1),
(@GUID+144,176511,249,3,-90.3045,-268.137,-92.6464,-0.802851,-0.390731,0.920505,60,0,1),
(@GUID+145,176511,249,3,-59.6926,-155.839,-93.7256,-3.08918,-0.999657,0.0262017,60,0,1),
(@GUID+146,176511,249,3,-86.2324,-253.441,-93.8641,-2.77507,-0.983254,0.182238,60,0,1),
(@GUID+147,176511,249,3,-87.8552,-269.151,-92.4986,0.226892,0.113203,0.993572,60,0,1),
(@GUID+148,176511,249,3,-107.777,-253.579,-92.3206,-2.35619,-0.923879,0.382686,60,0,1),
(@GUID+149,176511,249,3,-106.774,-227.096,-94.1074,-0.0698117,-0.0348988,0.999391,60,0,1),
(@GUID+150,176511,249,3,-61.4536,-273.77,-93.5671,-1.02974,-0.492423,0.870356,60,0,1),
(@GUID+151,176511,249,3,-87.3717,-262.375,-93.468,1.309,0.608761,0.793354,60,0,1),
(@GUID+152,176511,249,3,-71.0221,-162.055,-93.7708,-0.855211,-0.414693,0.909961,60,0,1),
(@GUID+153,176511,249,3,-92.7397,-173.777,-93.7896,-3.01941,-0.998135,0.0610517,60,0,1),
(@GUID+154,176511,249,3,-94.0791,-166.547,-93.3145,-2.9496,-0.995396,0.0958512,60,0,1),
(@GUID+155,176511,249,3,-104.578,-211.165,-96.1757,-3.00195,-0.997563,0.0697661,60,0,1),
(@GUID+156,176511,249,3,-38.6821,-274.131,-91.449,-1.18682,-0.559193,0.829038,60,0,1),
(@GUID+157,176511,249,3,-112.989,-208.054,-93.2037,-0.314158,-0.156434,0.987688,60,0,1),
(@GUID+158,176511,249,3,-112.76,-232.204,-92.7439,1.20428,0.566406,0.824126,60,0,1),
(@GUID+159,176511,249,3,-91.3062,-179.959,-93.8679,-0.0523589,-0.0261765,0.999657,60,0,1),
(@GUID+160,176511,249,3,-100.31,-179.594,-94.0001,-0.0698117,-0.0348988,0.999391,60,0,1),
(@GUID+161,176511,249,3,-45.5103,-274.021,-92.4277,-0.610864,-0.300705,0.953717,60,0,1),
(@GUID+162,176511,249,3,-104.113,-179.037,-93.7109,0.785397,0.382683,0.92388,60,0,1),
(@GUID+163,176826,249,3,-37.3837,-184.484,-89.0483,-3.05433,-0.999048,0.0436192,604800,100,1),
(@GUID+164,178029,249,3,16.0041,-177.041,-21.1756,-2.70526,-0.976295,0.216442,604800,100,1),
(@GUID+165,178046,249,3,-48.0902,-234.856,-86.2826,0.610865,0.300706,0.953717,604800,100,1),
(@GUID+166,176849,249,3,-3.17108,-189.864,-15.1422,2.09439,0.866025,0.500001,604800,100,1),
(@GUID+167,177995,249,3,-12.8884,-245.332,-87.9905,-0.0872641,-0.0436182,0.999048,604800,100,1),
(@GUID+168,176917,249,3,-72.938,-201.879,-83.6438,-1.0472,-0.5,0.866025,604800,100,1),
(@GUID+169,178008,249,3,-19.6951,-209.639,-88.5545,-0.43633,-0.216438,0.976296,604800,100,1),
(@GUID+170,176834,249,3,17.6418,-184.034,-86.1595,-1.309,-0.608761,0.793354,604800,100,1),
(@GUID+171,176809,249,3,16.8415,-225.106,-86.2168,2.61799,0.965925,0.258821,604800,100,1),
(@GUID+172,176825,249,3,13.1918,-214.436,-86.484,0.872664,0.422618,0.906308,604800,100,1),
(@GUID+173,178045,249,3,-54.6915,-229.819,-85.889,-1.5708,-0.707107,0.707107,604800,100,1),
(@GUID+174,178030,249,3,-33.7261,-200.163,-10.4158,2.26893,0.906307,0.422619,604800,100,1),
(@GUID+175,176810,249,3,-28.1006,-190.667,-89.6964,-0.0872641,-0.0436182,0.999048,604800,100,1),
(@GUID+176,176833,249,3,17.0001,-204.313,-86.2168,-2.61799,-0.965925,0.258821,604800,100,1),
(@GUID+177,177992,249,3,-3.98491,-248.954,-85.9318,0.95993,0.461748,0.887011,604800,100,1),
(@GUID+178,178011,249,3,17.0001,-204.313,-86.2168,-2.61799,-0.965925,0.258821,604800,100,1),
(@GUID+179,176850,249,3,-29.1501,-173.658,-23.2926,-2.53072,-0.953716,0.300708,604800,100,1),
(@GUID+180,176918,249,3,-75.138,-224.652,-83.4944,0.436332,0.216439,0.976296,604800,100,1),
(@GUID+181,178031,249,3,21.8353,-202.084,-17.2387,2.53072,0.953716,0.300708,604800,100,1),
(@GUID+182,178044,249,3,-75.138,-224.652,-83.4944,0.436332,0.216439,0.976296,604800,100,1),
(@GUID+183,176824,249,3,31.1672,-218.99,-83.8272,-1.74533,-0.766044,0.642789,604800,100,1),
(@GUID+184,176811,249,3,-26.3963,-199.616,-88.82,1.83259,0.793353,0.608762,604800,100,1),
(@GUID+185,176851,249,3,16.0041,-177.041,-21.1756,-2.70526,-0.976295,0.216442,604800,100,1),
(@GUID+186,177993,249,3,-0.638085,-239.839,-87.3523,1.39626,0.642788,0.766044,604800,100,1),
(@GUID+187,176919,249,3,-54.6915,-229.819,-85.889,-1.5708,-0.707107,0.707107,604800,100,1),
(@GUID+188,176832,249,3,14.2998,-195.44,-86.0326,0.436332,0.216439,0.976296,604800,100,1),
(@GUID+189,178010,249,3,14.2998,-195.44,-86.0326,0.436332,0.216439,0.976296,604800,100,1),
(@GUID+190,176822,249,3,-28.124,-238.209,-89.6964,0.0872641,0.0436182,0.999048,604800,100,1),
(@GUID+191,178017,249,3,-3.72498,-180.009,-85.9318,-0.95993,-0.461748,0.887011,604800,100,1),
(@GUID+192,178034,249,3,-47.9515,-193.888,-86.0046,-0.610865,-0.300706,0.953717,604800,100,1),
(@GUID+193,177991,249,3,7.06976,-243.991,-86.9945,-2.70526,-0.976295,0.216442,604800,100,1),
(@GUID+194,176846,249,3,27.5426,-247.756,-23.0949,-2.26893,-0.906307,0.422619,604800,100,1),
(@GUID+195,176515,249,3,17.3921,-245.044,-86.1595,1.309,0.608761,0.793354,604800,100,1),
(@GUID+196,178004,249,3,-37.3837,-184.484,-89.0483,-3.05433,-0.999048,0.0436192,604800,100,1),
(@GUID+197,176921,249,3,-55.075,-241.777,-85.3179,1.0472,0.5,0.866025,604800,100,1),
(@GUID+198,178035,249,3,-54.9718,-199.119,-85.4988,1.5708,0.707107,0.707107,604800,100,1),
(@GUID+199,176823,249,3,29.1885,-206.772,-84.5641,0.785399,0.382684,0.923879,604800,100,1),
(@GUID+200,178016,249,3,8.01259,-175.786,-86.6082,2.35619,0.92388,0.382683,604800,100,1),
(@GUID+201,178005,249,3,-1.66729,-217.144,-85.672,0.785397,0.382683,0.92388,604800,100,1),
(@GUID+202,176847,249,3,13.0761,-225.391,-19.2567,-2.79252,-0.984807,0.173652,604800,100,1),
(@GUID+203,176514,249,3,14.4175,-233.453,-86.0326,-0.436332,-0.216439,0.976296,604800,100,1),
(@GUID+204,177990,249,3,8.23697,-253.584,-86.6082,-2.35619,-0.92388,0.382683,604800,100,1),
(@GUID+205,176920,249,3,-48.0902,-234.856,-86.2826,0.610865,0.300706,0.953717,604800,100,1),
(@GUID+206,178032,249,3,37.2406,-214.403,-19.6757,2.18166,0.887011,0.461749,604800,100,1),
(@GUID+207,178019,249,3,-21.129,-174.709,-87.7823,2.61799,0.965925,0.258821,604800,100,1),
(@GUID+208,176820,249,3,-37.4064,-244.92,-89.0483,3.05433,0.999048,0.0436192,604800,100,1),
(@GUID+209,176513,249,3,24.2333,-235.508,-84.9566,-2.53072,-0.953716,0.300708,604800,100,1),
(@GUID+210,177989,249,3,17.3921,-245.044,-86.1595,1.309,0.608761,0.793354,604800,100,1),
(@GUID+211,178006,249,3,-9.80653,-212.031,-88.1401,-0.261798,-0.130526,0.991445,604800,100,1),
(@GUID+212,176844,249,3,-43.8754,-238.325,-14.7946,2.70526,0.976295,0.216442,604800,100,1),
(@GUID+213,178033,249,3,-18.973,-232.403,-15.5299,2.44346,0.939692,0.34202,604800,100,1),
(@GUID+214,176821,249,3,-26.0913,-229.619,-88.82,-1.83259,-0.793353,0.608762,604800,100,1),
(@GUID+215,178018,249,3,-12.9119,-183.545,-87.9905,0.087266,0.0436192,0.999048,604800,100,1),
(@GUID+216,178007,249,3,-19.3983,-219.854,-88.4829,-2.79252,-0.984807,0.173652,604800,100,1),
(@GUID+217,176845,249,3,-2.48133,-249.761,-17.7952,2.61799,0.965925,0.258821,604800,100,1),
(@GUID+218,177988,249,3,14.4175,-233.453,-86.0326,-0.436332,-0.216439,0.976296,604800,100,1),
(@GUID+219,176922,249,3,-63.8632,-232.924,-85.1124,-1.91986,-0.819152,0.573577,604800,100,1),
(@GUID+220,178048,249,3,-63.8632,-232.924,-85.1124,-1.91986,-0.819152,0.573577,604800,100,1),
(@GUID+221,176842,249,3,-15.6717,-196.472,-89.0988,1.0472,0.5,0.866025,604800,100,1),
(@GUID+222,177987,249,3,24.2333,-235.508,-84.9566,-2.53072,-0.953716,0.300708,604800,100,1),
(@GUID+223,178000,249,3,-28.124,-238.209,-89.6964,0.0872641,0.0436182,0.999048,604800,100,1),
(@GUID+224,176910,249,3,-64.1589,-196.123,-85.1125,1.91986,0.819151,0.573578,604800,100,1),
(@GUID+225,178038,249,3,-62.8772,-213.235,-85.1575,2.00712,0.84339,0.537301,604800,100,1),
(@GUID+226,178021,249,3,-51.6297,-214.403,-7.16564,-2.70526,-0.976295,0.216442,604800,100,1),
(@GUID+227,176818,249,3,-20.9761,-254.701,-87.7823,-2.61799,-0.965925,0.258821,604800,100,1),
(@GUID+228,176843,249,3,-51.6297,-214.403,-7.16564,-2.70526,-0.976295,0.216442,604800,100,1),
(@GUID+229,176911,249,3,-54.7977,-187.003,-85.6277,-1.0472,-0.5,0.866025,604800,100,1),
(@GUID+230,177986,249,3,-26.3963,-199.616,-88.82,1.83259,0.793353,0.608762,604800,100,1),
(@GUID+231,178001,249,3,29.1885,-206.772,-84.5641,0.785399,0.382684,0.923879,604800,100,1),
(@GUID+232,178039,249,3,-51.6644,-214.436,-86.1782,-2.53072,-0.953716,0.300708,604800,100,1),
(@GUID+233,176819,249,3,3.20326,-230.379,-87.0469,-1.48353,-0.67559,0.737278,604800,100,1),
(@GUID+234,178020,249,3,-15.6717,-196.472,-89.0988,1.0472,0.5,0.866025,604800,100,1),
(@GUID+235,176908,249,3,-47.9515,-193.888,-86.0046,-0.610865,-0.300706,0.953717,604800,100,1),
(@GUID+236,176840,249,3,-12.9119,-183.545,-87.9905,0.087266,0.0436192,0.999048,604800,100,1),
(@GUID+237,177985,249,3,-28.1006,-190.667,-89.6964,-0.0872641,-0.0436182,0.999048,604800,100,1),
(@GUID+238,178002,249,3,31.1672,-218.99,-83.8272,-1.74533,-0.766044,0.642789,604800,100,1),
(@GUID+239,178023,249,3,-2.48133,-249.761,-17.7952,2.61799,0.965925,0.258821,604800,100,1),
(@GUID+240,178036,249,3,-64.1589,-196.123,-85.1125,1.91986,0.819151,0.573578,604800,100,1),
(@GUID+241,176816,249,3,-15.3872,-232.509,-89.0988,-1.0472,-0.499999,0.866026,604800,100,1),
(@GUID+242,178003,249,3,13.1918,-214.436,-86.484,0.872664,0.422618,0.906308,604800,100,1),
(@GUID+243,176909,249,3,-54.9718,-199.119,-85.4988,1.5708,0.707107,0.707107,604800,100,1),
(@GUID+244,176841,249,3,-21.129,-174.709,-87.7823,2.61799,0.965925,0.258821,604800,100,1),
(@GUID+245,177984,249,3,16.8415,-225.106,-86.2168,2.61799,0.965925,0.258821,604800,100,1),
(@GUID+246,178022,249,3,-43.8754,-238.325,-14.7946,2.70526,0.976295,0.216442,604800,100,1),
(@GUID+247,178037,249,3,-54.7977,-187.003,-85.6277,-1.0472,-0.5,0.866025,604800,100,1),
(@GUID+248,176817,249,3,-12.8884,-245.332,-87.9905,-0.0872641,-0.0436182,0.999048,604800,100,1),
-- Instance portals by John
(@GUID+249, 200292,249,1,31.2081,-49.8496,-4.6301,4.65461,0.727236,-0.686387,25,0,1),
(@GUID+250, 200293,249,1,31.2081,-49.8496,-4.6301,4.65461,0.727236,-0.686387,25,0,1),
(@GUID+251, 200294,1,1,-4751.97,-3754.08,48.5708,0.317681,0.158174,0.987411,25,0,1),
(@GUID+252, 200295,1,1,-4751.97,-3754.08,48.5708,0.317681,0.158174,0.987411,25,0,1);