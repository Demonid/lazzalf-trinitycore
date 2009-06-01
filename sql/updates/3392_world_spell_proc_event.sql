DELETE FROM `spell_proc_event` WHERE `entry` IN 
(27521, 55381, 62459, 60176, 60529, 60717, 62147, 57907, 51528, 51529, 51530, 51531, 51532);
INSERT INTO `spell_proc_event` 
(`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`)
VALUES
-- malestorm weapon
(51528, 0, 0, 0, 0, 0, 0, 0, 2.5, 0, 0),
(51529, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0),
(51530, 0, 0, 0, 0, 0, 0, 0, 7.5, 0, 0),
(51531, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0),
(51532, 0, 0, 0, 0, 0, 0, 0, 12.5, 0, 0),

(27521, 0x00, 0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0.000000, 0.000000, 15),
(55381, 0x00, 0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0.000000, 0.000000, 15),
(62459, 0x00, 15, 0x00000004, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0.000000, 0.000000, 0),
(60176, 0x00, 4, 0x00000020, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0.000000, 0.000000, 0),
(60529, 0x00, 0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0.000000, 0.000000, 45),
(60717, 0x00, 7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0.000000, 100.000000, 0),
(62147, 0x00, 15, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0.000000, 0.000000, 0),
(57907, 0x00, 7, 0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0.000000, 0.000000, 0);