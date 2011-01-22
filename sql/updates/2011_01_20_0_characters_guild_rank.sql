ALTER TABLE `guild_rank`
ROW_FORMAT=DEFAULT,
CHANGE `guildid` `guildid` INT(10) UNSIGNED DEFAULT '0' NOT NULL,
CHANGE `rid` `rid` TINYINT(3) UNSIGNED NOT NULL,
CHANGE `rname` `rname` VARCHAR(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' NOT NULL,
CHANGE `rights` `rights` MEDIUMINT(8) UNSIGNED DEFAULT '0' NOT NULL,
CHANGE `BankMoneyPerDay` `BankMoneyPerDay` INT(10) UNSIGNED DEFAULT '0' NOT NULL;