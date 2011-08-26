DELETE FROM `disables` WHERE `entry`=10279 AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=10279;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10279,12,1,0,''),
(10279,11,0,0,'criteria_alone_in_the_darkness');
