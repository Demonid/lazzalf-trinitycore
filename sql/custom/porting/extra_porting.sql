/*Table structure for table `porting` */
DROP TABLE IF EXISTS `porting`;
CREATE TABLE `porting` (
  `guid` int(32) unsigned NOT NULL,
  `active` int(8) NOT NULL DEFAULT '0',
  `fase` int(8) NOT NULL DEFAULT '0',
  `level` int(8) NOT NULL DEFAULT '0',
  `gold` int(32) NOT NULL DEFAULT '0',
  `id_equip_1` int(32) NOT NULL DEFAULT '0',
  `id_equip_2` int(32) NOT NULL DEFAULT '0',
  `id_equip_3` int(32) NOT NULL DEFAULT '0',
  `repu_1` int(32) NOT NULL DEFAULT '0',
  `level_repu_1` int(32) NOT NULL DEFAULT '0',
  `repu_2` int(32) NOT NULL DEFAULT '0',
  `level_repu_2` int(32) NOT NULL DEFAULT '0',
  `repu_3` int(32) NOT NULL DEFAULT '0',
  `level_repu_3` int(32) NOT NULL DEFAULT '0',
  `skill_1` int(32) NOT NULL DEFAULT '0',
  `level_skill_1` int(32) NOT NULL DEFAULT '0',
  `skill_2` int(32) NOT NULL DEFAULT '0',
  `level_skill_2` int(32) NOT NULL DEFAULT '0',
  `skill_3` int(32) NOT NULL DEFAULT '0',
  `level_skill_3` int(32) NOT NULL DEFAULT '0',
  `skill_4` int(32) NOT NULL DEFAULT '0',
  `level_skill_4` int(32) NOT NULL DEFAULT '0',
  `skill_5` int(32) NOT NULL DEFAULT '0',
  `level_skill_5` int(32) NOT NULL DEFAULT '0',
  `skill_6` int(32) NOT NULL DEFAULT '0',
  `level_skill_6` int(32) NOT NULL DEFAULT '0',
  `skill_7` int(32) NOT NULL DEFAULT '0',
  `level_skill_7` int(32) NOT NULL DEFAULT '0',
  `skill_8` int(32) NOT NULL DEFAULT '0',
  `level_skill_8` int(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;