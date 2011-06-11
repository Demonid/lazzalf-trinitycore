-- Ulduar
-- Achievement: Three Car Garage
DELETE FROM `disables` WHERE `entry` IN (10046,10047,10048,10049,10050,10051) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10046,10047,10048,10049,10050,10051) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10046,11,0,0,'achievement_three_car_garage_chopper'),
(10047,11,0,0,'achievement_three_car_garage_siege'),
(10048,11,0,0,'achievement_three_car_garage_demolisher'),
(10049,11,0,0,'achievement_three_car_garage_chopper'),
(10050,11,0,0,'achievement_three_car_garage_siege'),
(10051,11,0,0,'achievement_three_car_garage_demolisher');
-- Achievement: Set Up Us the Bomb
DELETE FROM `disables` WHERE `entry` IN (10543,10544,10545,10546,10547,10548) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10543,10544,10545,10546,10547,10548) AND `type` IN (11,12);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10543','11','0','0','achievement_criteria_proximity_mine'),
('10543','12','0','0',''),
('10544','11','0','0','achievement_criteria_rocket_strike'),
('10544','12','0','0',''),
('10545','11','0','0','achievement_criteria_bomb_bot'),
('10545','12','0','0',''),
('10546','11','0','0','achievement_criteria_proximity_mine'),
('10546','12','1','0',''),
('10547','11','0','0','achievement_criteria_rocket_strike'),
('10547','12','1','0',''),
('10548','11','0','0','achievement_criteria_bomb_bot'),
('10548','12','1','0','');
UPDATE `creature_template` SET `faction_a`=1375, `faction_h`=1375 WHERE `entry`=34047;
-- Achievement: Not-So-Friendly Fire
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10405,10406);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10405','12','1','0',''),
('10406','12','0','0','');

