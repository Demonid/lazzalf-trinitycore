DELETE FROM `disables` WHERE `entry` IN (10077,10079) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10077,10079);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10077,12,0,0,''),
(10077,11,0,0,'criteria_xt002');
(10079,12,1,0,''),
(10079,11,0,0,'criteria_xt002');
