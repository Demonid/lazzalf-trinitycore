-- ##########################################################
-- Algalon
-- ##########################################################
/*
-- Delete Obsolete Door
DELETE FROM gameobject WHERE id = 194911;
*/

-- For Achievement He Feeds on your Tears
DELETE FROM achievement_criteria_data WHERE `type` = 18 AND criteria_id IN
(10568,10570);

INSERT INTO achievement_criteria_data (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10568,18,0,0,''),
(10570,18,0,0,'');

DELETE FROM disables WHERE sourceType = 4 AND entry IN 
(10568,10570);

-- spawn algalon
DELETE FROM `creature` WHERE `id`=32871;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('302616','32871','603','3','1','0','0','1632.36','-310.093','417.321','1.8445','604800','0','0','34862500','0','0','0','0','0','0');

-- set to friendly by default
UPDATE `creature_template` SET `faction_A`=35, `faction_H`=35, `flags_extra`=1 WHERE `entry` IN (32871,33070);

UPDATE `creature_template` SET `ScriptName`='npc_black_hole' WHERE `entry`=32953;
UPDATE `creature_template` SET `ScriptName`='npc_living_constellation' WHERE `entry`=33052;

-- spawn 'Celestial Planetarium Access'
DELETE FROM `gameobject` WHERE `id`= 194628;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES (400002, 194628, 603, 3, 1, 1649.49, -174.711, 427.257, 1.5708, 0, 0, 0, 0, 180, 0, 1);

UPDATE `gameobject_template` SET `data0`=0, `ScriptName`='go_planetarium_access' WHERE `entry`=194628;

DELETE FROM `spell_linked_spell` WHERE `spell_effect` IN (62169,-64412);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(64417,62169,2, 'Phase Punch - Trigger Black Hole Dot'),
(62168,62169,2, 'Black Hole - Trigger Black Hole Dot'),
(64417,-64412,1, 'Phase Punch - Remove Phase Punch');

UPDATE `gameobject` SET `phaseMask`=17 WHERE `id` IN (194910,194715,194148);

UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14, `unit_flags`=6, `InhabitType`=7, `AIName`='SmartAI', `flags_extra`=130 WHERE `entry`=33104;
UPDATE `creature_template` SET `unit_flags`=512, `flags_extra`=130 WHERE `entry`=33105;
UPDATE `creature_template` SET `minlevel`=83, `maxlevel`=83 WHERE `entry` IN (33104,33070);

DELETE FROM `smart_scripts` WHERE `entryorguid`=33104;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(33104,0,0,0,1,0,100,3,4000,4000,0,0,11,62304,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Algalon Asteroid - Cast Cosmic Smash 10N'),
(33104,0,1,0,1,0,100,5,4000,4000,0,0,11,64597,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Algalon Asteroid - Cast Cosmic Smash 25N');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (62304,64597,64996);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,62304,18,1,33105),
(13,64597,18,1,33105),
(13,64996,18,1,34246);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (62301,64598,62293,62295,62311,64596,64597,64445,62168,64417);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(62301, 'spell_cosmic_smash'),
(64598, 'spell_cosmic_smash'),
(62293, 'spell_cosmic_smash_summon_trigger'),
(62295, 'spell_cosmic_smash_summon_target'),
(62311, 'spell_cosmic_smash_dmg'),
(64596, 'spell_cosmic_smash_dmg'),
(64597, 'spell_cosmic_smash_missile_target'),
(64445, 'spell_remove_player_from_phase'),
(62168, 'spell_algalon_phased'),
(64417, 'spell_algalon_phased');

-- Dark Matter
SET @GUID := 302685;

DELETE FROM `creature` WHERE `id`=33089;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID,'33089','603','3','16','0','0','1607.99','-289.992','417.321','5.89086','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+1,'33089','603','3','16','0','0','1620.23','-280.533','417.321','5.6097','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+2,'33089','603','3','16','0','0','1638.33','-278.895','417.321','4.49364','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+3,'33089','603','3','16','0','0','1654.22','-288.583','417.321','4.0656','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+4,'33089','603','3','16','0','0','1661.51','-309.099','417.321','4.28944','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+5,'33089','603','3','16','0','0','1653.98','-327.001','417.321','3.5598','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+6,'33089','603','3','16','0','0','1640.12','-336.194','417.321','1.68663','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+7,'33089','603','3','16','0','0','1621.68','-333.91','417.321','2.40134','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+8,'33089','603','3','16','0','0','1605.45','-320.182','417.321','0.444129','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+9,'33089','603','3','16','0','0','1602.23','-303.377','417.321','6.13041','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+10,'33089','603','3','16','0','0','1617.7','-309.616','417.321','0.204581','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+11,'33089','603','3','16','0','0','1623.68','-295.429','417.321','5.30967','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+12,'33089','603','3','16','0','0','1641.17','-296.46','417.321','4.12137','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+13,'33089','603','3','16','0','0','1644.9','-313.288','417.321','2.7587','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+14,'33089','603','3','16','0','0','1630.54','-319.732','417.321','1.53034','10','10','0','37800','0','0','1','0','0','0'),
(@GUID+15,'33089','603','3','16','0','0','1633.07','-306.294','417.321','1.53505','10','10','0','37800','0','0','1','0','0','0');

UPDATE `creature_template` SET `dmg_multiplier`=4 WHERE `entry`=33089;
UPDATE `creature_template` SET `dmg_multiplier`=7 WHERE `entry`=34221;
UPDATE `creature_template` SET `dmg_multiplier`=12 WHERE `entry`=34097;
UPDATE `creature_template` SET `dmg_multiplier`=20 WHERE `entry`=34222;