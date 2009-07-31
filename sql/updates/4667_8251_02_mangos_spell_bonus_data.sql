-- ALTER TABLE db_version CHANGE COLUMN required_8251_01_mangos_spell_chain required_8251_02_mangos_spell_bonus_data bit;

DELETE FROM `spell_bonus_data` where entry in (
  49941,48721,
  8037,10458,16352,16353,25501,58797,58798,58799,18937,18938,27265,59092,49941,
  7269,7270,8419,8418,10273,10274,25346,27076,38700,38703,42844,42845,
  42209,42210,42211,42212,42213,42198,42937,42938,
  43043,43044,
  25911,25902,27176,33073,48822,48823,
  25913,25903,27175,33074,48820,48821,
  23458,23459,27803,27804,27805,25329,
  53022,
  8504,8505,11310,11311,25538,25539,61651,61660,
  8028,8029,10445,16343,16344,25488,58786,58787,58788,
  26365,26366,26367,26369,26370,26363,26371,26372,49278,49279,
  10582,10583,10584,25551,58733,58736,
  6350,6351,6352,10435,10436,25530,58700,58701,58702,
  11681,11682,27214,47822,
  42224,42225,42226,42218,47817,47818
);

INSERT INTO `spell_bonus_data` VALUES
('48721', '0', '0', '0.04', 'Death Knight - Blood Boil');
