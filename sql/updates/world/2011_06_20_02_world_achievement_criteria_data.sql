DELETE FROM `disables` WHERE `entry`=7587;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=7587 AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(7587,11,0,0,'achievement_void_dance');
