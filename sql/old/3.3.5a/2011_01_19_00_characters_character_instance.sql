ALTER TABLE `character_instance`
CHANGE `guid` `guid` INT(10) UNSIGNED DEFAULT '0' NOT NULL,
CHANGE `instance` `instance` INT(10) UNSIGNED DEFAULT '0' NOT NULL,
CHANGE `permanent` `permanent` TINYINT(3) UNSIGNED DEFAULT '0' NOT NULL;