-- The Oculus
-- Achievement: Experienced Drake Rider
DELETE FROM `disables` WHERE `entry` IN (7177,7178,7179) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7177,7178,7179) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7177,11,0,0,'achievement_experienced_drake_rider_amber'),
(7178,11,0,0,'achievement_experienced_drake_rider_emerald'),
(7179,11,0,0,'achievement_experienced_drake_rider_ruby');
-- Loot
DELETE FROM `gameobject_loot_template` WHERE `entry`=24524 AND `item`=52676;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(24524,52676,100,1,0,1,1);
DELETE FROM `item_loot_template` WHERE `entry`=52676;
INSERT INTO `item_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(52676,36933,0,1,1,1,3),
(52676,36918,0,1,1,1,3),
(52676,36921,0,1,1,1,3),
(52676,36930,0,1,1,1,3),
(52676,36924,0,1,1,1,3),
(52676,36927,0,1,1,1,3),
(52676,43953,5,1,0,1,1);

