update creature_template set ScriptName = 'boss_kologarn' where entry = 32930;

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-62475,62427);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-62475,-62399, 0, 'System Shutdown - Overload Circuit'),
(-62475,-62375, 0, 'System Shutdown - Gathering Speed'),
(-62475, 62472, 0, 'System Shutdown'), #inform, not correct spell
( 62427, 62340, 2, 'Load into Catapult - Passenger Loaded');
