DROP TABLE IF EXISTS script_waypoint;
CREATE TABLE script_waypoint (
  entry mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'creature_template entry',
  pointid mediumint(8) unsigned NOT NULL DEFAULT '0',
  location_x float NOT NULL DEFAULT '0',
  location_y float NOT NULL DEFAULT '0',
  location_z float NOT NULL DEFAULT '0',
  waittime int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'waittime in millisecs',
  point_comment text,
  PRIMARY KEY (entry, pointid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Script Creature waypoints';

DELETE FROM script_waypoint WHERE entry=16295;
INSERT INTO script_waypoint VALUES
(16295, 0, 7545.070000, -7359.870000, 162.354000, 4000, 'SAY_START'),
(16295, 1, 7550.048340, -7362.237793, 162.235657, 0, ''),
(16295, 2, 7566.976074, -7364.315430, 161.738770, 0, ''),
(16295, 3, 7578.830566, -7361.677734, 161.738770, 0, ''),
(16295, 4, 7590.969238, -7359.053711, 162.257660, 0, ''),
(16295, 5, 7598.354004, -7362.815430, 162.256683, 4000, 'SAY_PROGRESS_1'),
(16295, 6, 7605.861328, -7380.424316, 161.937073, 0, ''),
(16295, 7, 7605.295410, -7387.382813, 157.253998, 0, ''),
(16295, 8, 7606.131836, -7393.893555, 156.941925, 0, ''),
(16295, 9, 7615.207520, -7400.187012, 157.142639, 0, ''),
(16295, 10, 7618.956543, -7402.652832, 158.202042, 0, ''),
(16295, 11, 7636.850586, -7401.756836, 162.144791, 0, 'SAY_PROGRESS_2'),
(16295, 12, 7637.058105, -7404.944824, 162.206970, 4000, ''),
(16295, 13, 7636.910645, -7412.585449, 162.366425, 0, ''),
(16295, 14, 7637.607910, -7425.591797, 162.630661, 0, ''),
(16295, 15, 7637.816895, -7459.057129, 163.302704, 0, ''),
(16295, 16, 7638.859863, -7470.902344, 162.517059, 0, ''),
(16295, 17, 7641.395996, -7488.217285, 157.381287, 0, ''),
(16295, 18, 7634.455566, -7505.451660, 154.682159, 0, 'SAY_PROGRESS_3'),
(16295, 19, 7631.906738, -7516.948730, 153.597382, 0, ''),
(16295, 20, 7622.231445, -7537.037598, 151.587112, 0, ''),
(16295, 21, 7610.921875, -7550.670410, 149.639374, 0, ''),
(16295, 22, 7598.229004, -7562.551758, 145.953888, 0, ''),
(16295, 23, 7588.509277, -7577.755371, 148.294479, 0, ''),
(16295, 24, 7567.339355, -7608.456055, 146.006485, 0, ''),
(16295, 25, 7562.547852, -7617.417969, 148.097504, 0, ''),
(16295, 26, 7561.508789, -7645.064453, 151.245163, 0, ''),
(16295, 27, 7563.337402, -7654.652344, 151.227158, 0, ''),
(16295, 28, 7565.533691, -7658.296387, 151.248886, 0, ''),
(16295, 39, 7571.155762, -7659.118652, 151.244568, 0, ''),
(16295, 30, 7579.119629, -7662.213867, 151.651505, 0, 'quest complete'),
(16295, 31, 7603.768066, -7667.000488, 153.997726, 0, ''),
(16295, 32, 7603.768066, -7667.000488, 153.997726, 4000, 'SAY_END_1'),
(16295, 33, 7603.768066, -7667.000488, 153.997726, 8000, 'SAY_END_2'),
(16295, 34, 7603.768066, -7667.000488, 153.997726, 0, '');
