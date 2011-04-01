-- Quest Blade's Edge Mountains: A Curse Upon Both of Your Clans!
DELETE FROM `spell_script_names` WHERE `spell_id`=32580;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (32580,'spell_wicked_strong_fetish');
DELETE FROM `gameobject` WHERE `guid` IN (99967,99968) AND `id`=300104;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES('99967','300104','530','1','1','1589.7','6291.31','3.15962','4.40951','0','0','0.805689','-0.592339','300','0','1'),
('99968','300104','530','1','1','1540.34','6318.43','2.83724','3.79454','0','0','0.947179','-0.320706','300','0','1');
