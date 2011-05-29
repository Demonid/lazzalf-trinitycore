-- Yogg-Saron HM 10
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10410,10388,10409,10412);
DELETE FROM `disables` WHERE `entry` IN (10410,10388,10409,10412) AND `sourceType`=4;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10410','11','0','0','criteria_three_lights_in_the_darkness'),
('10410','12','0','0',''),
('10388','11','0','0','criteria_two_lights_in_the_darkness'),
('10388','12','0','0',''),
('10409','11','0','0','criteria_one_light_in_the_darkness'),
('10409','12','0','0',''),
('10412','11','0','0','criteria_alone_in_the_darkness'),
('10412','12','0','0','');
-- Yogg_saron HM 25
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10414,10415,10416,10417);
DELETE FROM `disables` WHERE `entry` IN (10414,10415,10416,10417) AND `sourceType`=4;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10414','11','0','0','criteria_three_lights_in_the_darkness'),
('10414','12','1','0',''),
('10415','11','0','0','criteria_two_lights_in_the_darkness'),
('10415','12','1','0',''),
('10416','11','0','0','criteria_one_light_in_the_darkness'),
('10416','12','1','0',''),
('10417','11','0','0','criteria_alone_in_the_darkness'),
('10417','12','1','0','');
