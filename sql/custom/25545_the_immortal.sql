-- The Undying
DELETE FROM `disables` WHERE `entry` IN (7617,13237,13238,13239,13240) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7617,13237,13238,13239,13240);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7617,12,0,0,''),
(7617,11,0,0,'achievement_immortal'),
(13237,12,0,0,''),
(13237,11,0,0,'achievement_immortal'),
(13238,12,0,0,''),
(13238,11,0,0,'achievement_immortal'),
(13239,12,0,0,''),
(13239,11,0,0,'achievement_immortal'),
(13240,12,0,0,''),
(13240,11,0,0,'achievement_immortal');
-- The Immortal
DELETE FROM `disables` WHERE `entry` IN (7616,13233,13234,13235,13236) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7616,13233,13234,13235,13236);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7616,12,1,0,''),
(7616,11,0,0,'achievement_immortal'),
(13233,12,1,0,''),
(13233,11,0,0,'achievement_immortal'),
(13234,12,1,0,''),
(13234,11,0,0,'achievement_immortal'),
(13235,12,1,0,''),
(13235,11,0,0,'achievement_immortal'),
(13236,12,1,0,''),
(13236,11,0,0,'achievement_immortal');

