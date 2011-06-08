DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10321,10322,10323,10324,10325,10326) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10321,11,0,0,'criteria_assasination_of_king_lane'),
(10322,11,0,0,'criteria_forging_demon_soul'),
(10323,11,0,0,'criteria_tortured_champion'),
(10324,11,0,0,'criteria_assasination_of_king_lane'),
(10325,11,0,0,'criteria_forging_demon_soul'),
(10326,11,0,0,'criteria_tortured_champion');
