-- Toc5
-- Normal 3778 H / 4296 A - 11420,12298,12299,12300,12301,12302,12303,12304,12305,12306
-- Heroic 4297 H / 4298 A - 12310,12311,12312,12313,12314,12318,12319,12320,12321,12322
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11420,12298,12299,12300,12301,12302,12303,12304,12305,12306,12310,12311,12312,12313,12314,12318,12319,12320,12321,12322) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
-- Warrior
(11420,11,0,0,'achievement_criteria_warrior_toc5'),
(12302,11,0,0,'achievement_criteria_warrior_toc5'),
(12310,11,0,0,'achievement_criteria_warrior_toc5'),
(12318,11,0,0,'achievement_criteria_warrior_toc5'),
-- Mage
(12300,11,0,0,'achievement_criteria_mage_toc5'),
(12305,11,0,0,'achievement_criteria_mage_toc5'),
(12313,11,0,0,'achievement_criteria_mage_toc5'),
(12321,11,0,0,'achievement_criteria_mage_toc5'),
-- Shaman
(12299,11,0,0,'achievement_criteria_shaman_toc5'),
(12304,11,0,0,'achievement_criteria_shaman_toc5'),
(12312,11,0,0,'achievement_criteria_shaman_toc5'),
(12320,11,0,0,'achievement_criteria_shaman_toc5'),
-- Hunter
(12301,11,0,0,'achievement_criteria_hunter_toc5'),
(12306,11,0,0,'achievement_criteria_hunter_toc5'),
(12314,11,0,0,'achievement_criteria_hunter_toc5'),
(12322,11,0,0,'achievement_criteria_hunter_toc5'),
-- Rogue
(12298,11,0,0,'achievement_criteria_rogue_toc5'),
(12303,11,0,0,'achievement_criteria_rogue_toc5'),
(12311,11,0,0,'achievement_criteria_rogue_toc5'),
(12319,11,0,0,'achievement_criteria_rogue_toc5');

