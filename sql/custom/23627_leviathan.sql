-- remove vehicle_accessory, vehicle id leviathan uses seat 2 3 and 7
DELETE FROM `vehicle_accessory` WHERE `entry`=33113 AND `seat_id`=0;
DELETE FROM `vehicle_accessory` WHERE `entry`=33113 AND `seat_id`=1;

INSERT INTO areatrigger_scripts VALUES
(5369,'at_RX_214_repair_o_matic_station'),
(5423,'at_RX_214_repair_o_matic_station');

-- waypoint for mimron inferno
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
(33370, 1, 331.674, -68.6878, 409.804, 0, '0'),
(33370, 2, 274.578, -92.1829, 409.804, 0, '0'),
(33370, 3, 226.433, -66.6652, 409.793, 0, '0'),
(33370, 4, 206.092, -34.7447, 409.801, 0, '0'),
(33370, 5, 240.208, 1.10346, 409.802, 0, '0'),
(33370, 6, 337.199, 11.7051, 409.802, 0, '0');

UPDATE `creature_template` SET `ScriptName` = 'npc_thorims_hammer' WHERE `entry` =33365;
UPDATE `creature_template` SET `MovementType` =2, `ScriptName` = 'npc_mimirons_inferno' WHERE `entry` =33370;
UPDATE `creature_template` SET `ScriptName` = 'npc_hodirs_fury' WHERE `entry` =33312;
UPDATE `creature_template` SET `ScriptName` = 'npc_freyas_ward' WHERE `entry` =33367;
UPDATE `creature_template` SET `ScriptName` = 'npc_lorekeeper' WHERE `entry` =33686;
UPDATE `creature_template` SET `ScriptName` = 'npc_brann_bronzebeard' WHERE `entry` =33579;
UPDATE `creature_template` SET `ScriptName` = 'npc_freya_ward_summon' WHERE `entry` =34275;
UPDATE `creature_template` SET `ScriptName` = 'npc_mechanolift' WHERE `entry` =33214;
UPDATE `gameobject_template` SET `ScriptName` = 'go_ulduar_tower' WHERE `entry` =194375;
UPDATE `gameobject_template` SET `ScriptName` = 'go_ulduar_tower' WHERE `entry` =194371;
UPDATE `gameobject_template` SET `ScriptName` = 'go_ulduar_tower' WHERE `entry` =194370;
UPDATE `gameobject_template` SET `ScriptName` = 'go_ulduar_tower' WHERE `entry` =194377;

DELETE FROM `vehicle_accessory` WHERE `entry`=33114;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_flame_leviathan_defense_cannon' WHERE `entry` = 33139;