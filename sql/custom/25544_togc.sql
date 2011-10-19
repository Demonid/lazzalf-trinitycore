-- Tribute Run ToGC
-- Tribute to Skill 3808 (10) / 3817 (25)
-- 3808: 12344,12345,12346
-- 3817: 12338,12339,12340
-- Tribute to Mad Skill 3809 (10) / 3818 (25)
-- 3809: 12347,12348
-- 3818: 12341,12342
-- Tribute to Insanity 3810 (10) / 3819 (25)
-- 3810: 12349
-- 3819: 12343
-- Tribute to Immortality (25H) 4079 (H) / 4156 (A)
-- 4079: 12358
-- 4156: 12359
DELETE FROM `disables` WHERE `entry` IN (12344,12345,12346,12338,12339,12340,12347,12348,12341,12342,12349,12343,12358,12359) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12344,12345,12346,12338,12339,12340,12347,12348,12341,12342,12349,12343,12358,12359);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(12344,12,2,0,''),
(12344,11,0,0,'criteria_tribute_to_skill'),
(12345,12,2,0,''),
(12345,11,0,0,'criteria_tribute_to_skill'),
(12346,12,2,0,''),
(12346,11,0,0,'criteria_tribute_to_skill'),
(12347,12,2,0,''),
(12347,11,0,0,'criteria_tribute_to_mad_skill'),
(12348,12,2,0,''),
(12348,11,0,0,'criteria_tribute_to_mad_skill'),
(12349,12,2,0,''),
(12349,11,0,0,'criteria_tribute_to_insanity'),
(12338,12,3,0,''),
(12338,11,0,0,'criteria_tribute_to_skill'),
(12339,12,3,0,''),
(12339,11,0,0,'criteria_tribute_to_skill'),
(12340,12,3,0,''),
(12340,11,0,0,'criteria_tribute_to_skill'),
(12341,12,3,0,''),
(12341,11,0,0,'criteria_tribute_to_mad_skill'),
(12342,12,3,0,''),
(12342,11,0,0,'criteria_tribute_to_mad_skill'),
(12343,12,3,0,''),
(12343,11,0,0,'criteria_tribute_to_insanity'),
(12358,12,3,0,''),
(12358,11,0,0,'criteria_tribute_to_immortality_h'),
(12359,12,3,0,''),
(12359,11,0,0,'criteria_tribute_to_immortality_a');
-- Fix for trophy loot
DELETE FROM `reference_loot_template` WHERE `entry`=47242;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(47242,47242,100,1,0,1,1);
-- ToGC 10 - 1/24 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195668 AND `item` in (1,2,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(195668,1,100,1,0,-47242,1),
(195668,2,100,1,0,-47242,1);
-- ToGC 10 - 25/44 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195667 AND `item` in (3,4,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(195667,3,100,1,0,-47242,1),
(195667,4,100,1,0,-47242,1);
-- ToGC 10 - 45/49 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195666 AND `item` in (3,4,5,6,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(195666,3,100,1,0,-47242,1),
(195666,4,100,1,0,-47242,1),
(195666,5,100,1,0,-47242,1),
(195666,6,100,1,0,-47242,1);
-- ToGC 10 - 50 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195665 AND `item` in (5,6,7,8,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(195665,5,100,1,0,-47242,1),
(195665,6,100,1,0,-47242,1),
(195665,7,100,1,0,-47242,1),
(195665,8,100,1,0,-47242,1);
-- ToGC 25 - 1/24 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195672 AND `item` in (2,3,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(195672,2,100,1,0,-47242,1),
(195672,3,100,1,0,-47242,1);
-- ToGC 25 - 25/44 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195671 AND `item` in (4,5,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(195671,4,100,1,0,-47242,1),
(195671,5,100,1,0,-47242,1);
-- ToGC 25 - 45/49 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195670 AND `item` in (4,5,6,7,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(195670,4,100,1,0,-47242,1),
(195670,5,100,1,0,-47242,1),
(195670,6,100,1,0,-47242,1),
(195670,7,100,1,0,-47242,1);
-- ToGC 25 - 50 attempts
DELETE FROM `gameobject_loot_template` WHERE `entry`=195669 AND `item` in (6,7,8,9,47242);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(195669,6,100,1,0,-47242,1),
(195669,7,100,1,0,-47242,1),
(195669,8,100,1,0,-47242,1),
(195669,9,100,1,0,-47242,1);
-- Realm First: Grand Crusader
DELETE FROM `disables` WHERE `entry`=12350 AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=12350;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(12350,12,3,0,''),
(12350,11,0,0,'criteria_tribute_to_insanity');
