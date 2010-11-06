DROP TABLE IF EXISTS `character_queststatus_daily`;
DROP TABLE IF EXISTS `character_queststatus_timed`;
CREATE TABLE `character_queststatus_timed` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest entry',
  `daily` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Bool whether it is daily (if not it\'s a weekly)',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest complete time',
  PRIMARY KEY (`guid`,`quest`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Timed Quest System';

INSERT `worldstates`(`entry`,`comment`) VALUE
(90101,'LAST_TIME_DAILY'),
(90102,'LAST_TIME_WEEKLY');