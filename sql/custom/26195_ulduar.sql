-- Kiss and Makeup
DELETE FROM `disables` WHERE `entry` IN (10187,10189) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10187,10189);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
('10187','1','33134','0',''),
('10187','11','0','0','criteria_kiss_and_makeup'),
('10187','12','0','0',''),
('10189','1','33134','0',''),
('10189','11','0','0','criteria_kiss_and_makeup'),
('10189','12','1','0','');
-- Criteria for Algalon
DELETE FROM `disables` WHERE `entry` IN (10565,10566,10567,10568,10569,10570,10678,10698,10780,10781,10782,10783) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10565,10566,10567,10568,10569,10570,10678,10698,10780,10781,10782,10783);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10698,12,1,0,''), -- Realm First
(10567,12,0,0,''), -- Observed 10
(10569,12,1,0,''), -- Observed 25
(10565,12,0,0,''), -- Algalon Kills 10
(10566,12,1,0,''), -- Algalon Kills 25
(10568,12,0,0,''), -- He Feeds On Your Tears 10
(10568,11,0,0,'criteria_feeds_tears'), -- He Feeds On Your Tears 10
(10570,12,1,0,''), -- He Feeds On Your Tears 25
(10570,11,0,0,'criteria_feeds_tears'); -- He Feeds On Your Tears 25
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(4,10678,1,0,0,'Herald of the Titans - needs script'),
(4,10780,1,0,0,'Supermassive 10 - needs script'),
(4,10781,1,0,0,'Supermassive 10 - needs script'),
(4,10782,1,0,0,'Supermassive 25 - needs script'),
(4,10783,1,0,0,'Supermassive 25 - needs script');
