--  Tank Class Passive Threat
DELETE FROM `spell_linked_spell` WHERE `spell_effect` IN (57340);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(21178,57340,2, 'Tank Class Passive Threat - Bear Form (Passive2)'),
(7376,57340,2, 'Tank Class Passive Threat - Defensive Stance Passive'),
(48263,57340,2, 'Tank Class Passive Threat - Frost Presence'),
(25780,57340,2, 'Tank Class Passive Threat - Righteous Fury');
