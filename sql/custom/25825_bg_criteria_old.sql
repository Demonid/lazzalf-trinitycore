-- Warsong Gulch
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (177,221,416,417,1801,1802,1824);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
('177','0','0','0',''),
('221','0','0','0',''),
('416','0','0','0',''),
('417','0','0','0',''),
('1801','0','0','0',''),
('1802','0','0','0',''),
('1824','0','0','0','');
-- Strand of the Ancients
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` in (4501,4502);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
('4501','0','0','0',''),
('4502','0','0','0','');
-- Eye of the Strom
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (222,223,418,1239,3353,3693);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
('222','0','0','0',''),
('223','0','0','0',''),
('418','0','0','0',''),
('1239','11','0','0','achievement_bg_control_all_nodes'),
('3353','0','0','0',''),
('3693','11','0','0','achievement_bg_control_all_nodes');
-- Arathi Basin
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (123,166,176,308,414,426,427,1234,3372);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
('123','0','0','0',''),
('166','0','0','0',''),
('176','0','0','0',''),
('308','0','0','0',''),
('414','0','0','0',''),
('426','0','0','0',''),
('427','0','0','0',''),
('1234','11','0','0','achievement_bg_control_all_nodes'),
('3372','0','0','0','');
-- Alterac Valley
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (224,225,419,420,421,422,423,424);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
('224','0','0','0',''),
('225','0','0','0',''),
('419','0','0','0',''),
('420','0','0','0',''),
('421','0','0','0',''),
('422','0','0','0',''),
('423','0','0','0',''),
('424','0','0','0','');

