-- Quest Grizzly Hills: Runes of Compulsion
UPDATE `creature_template` SET `ScriptName`='npc_directional_rune' WHERE `entry`=26785;
UPDATE `creature_template` SET `ScriptName`='npc_iron_rune_weaver' WHERE `entry`=26820; 
UPDATE `creature_template` SET `faction_h`=16, `faction_a`=16 WHERE `entry` IN (26920,26921,26922,26923);
-- Quest Grizzly Hills: Free at Last!
DELETE FROM `spell_script_names` WHERE `spell_id`=47604;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (47604,'spell_gavrock_runebreaker');
