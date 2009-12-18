ALTER TABLE `spell_proc_event` CHANGE COLUMN `entry` `entry` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_bonus_data` CHANGE COLUMN `entry` `entry` mediumint(8) unsigned NOT NULL DEFAULT '0';

DELETE FROM `spell_proc_event` WHERE `entry` IN
(44401, 58642, 58676, 61433, 61434);

DELETE FROM `spell_elixir` WHERE `entry` IN (67016,67017,67018);
INSERT INTO `spell_elixir` (`entry`, `mask`) VALUES
(67016,0x3),
(67017,0x3),
(67018,0x3);