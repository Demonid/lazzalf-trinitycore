ALTER TABLE `gm_tickets` ADD COLUMN `map` INT NOT NULL DEFAULT '0' AFTER `createtime`;
ALTER TABLE `gm_tickets` ADD COLUMN `posX` FLOAT NOT NULL DEFAULT '0' AFTER `map`;
ALTER TABLE `gm_tickets` ADD COLUMN `posY` FLOAT NOT NULL DEFAULT '0' AFTER `posX`;
ALTER TABLE `gm_tickets` ADD COLUMN `posZ` FLOAT NOT NULL DEFAULT '0' AFTER `posY`;
