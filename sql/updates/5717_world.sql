ALTER TABLE `item_template` MODIFY `stackable` int;

ALTER TABLE `creature_template` CHANGE COLUMN `modelid_A` `modelid1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_template` CHANGE COLUMN `modelid_A2` `modelid2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_template` CHANGE COLUMN `modelid_H` `modelid3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_template` CHANGE COLUMN `modelid_H2` `modelid4` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0;
