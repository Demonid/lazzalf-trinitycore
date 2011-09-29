-- SAI for Ahune Adds

-- 25755, Ahunite Hailstone
SET @ENTRY := 25755;
SET @SPELL_CHILLING_AURA := 46542;
SET @SPELL_PULVERIZE := 2676;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction_a`=16,`faction_h`=16,`AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,23,0,100,0,@SPELL_CHILLING_AURA,0,2000,2000,11,@SPELL_CHILLING_AURA,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ahunite Hailstone - Chilling Aura'),
(@ENTRY,0,1,0,0,0,100,0,2000,3000,7000,8000,11,@SPELL_PULVERIZE,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ahunite Hailstone - Pulverize');

-- 25756, Ahunite Coldwave
SET @ENTRY := 25756;
SET @SPELL_BITTER_BLAST := 46406;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction_a`=16,`faction_h`=16,`AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,5000,5000,11,@SPELL_BITTER_BLAST,0,0,0,0,0,5,0,0,0,0,0,0,0,'Ahunite Coldwave - Bitter Blast');

-- 25757, Ahunite Frostwind
SET @ENTRY := 25757;
SET @SPELL_LIGHTNING_SHIELD := 12550;
SET @SPELL_WIND_BUFFET := 46568;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction_a`=16,`faction_h`=16,`AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,23,0,100,0,@SPELL_LIGHTNING_SHIELD,0,2000,2000,11,@SPELL_LIGHTNING_SHIELD,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ahunite Frostwind - Lightning Shield'),
(@ENTRY,0,1,0,0,0,100,0,2000,3000,7000,8000,11,@SPELL_WIND_BUFFET,0,0,0,0,0,6,0,0,0,0,0,0,0,'Ahunite Frostwind - Wind Buffet');
