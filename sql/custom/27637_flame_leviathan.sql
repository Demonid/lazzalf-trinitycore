REPLACE into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values('33114','0','0','0','0','0','11686','24914','0','0','Flame Leviathan Seat','','vehichleCursor','0','80','80','2','2110','2110','16777216','1','1.14286','1','0','0','0','0','0','1','2000','0','4','33570816','8','0','0','0','0','0','0','0','0','9','1049632','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','341','0','0','','0','3','1','1','1','0','0','0','0','0','0','0','0','1','0','0','0','boss_flame_leviathan_seat','12340');
REPLACE into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values('33139','34111','0','0','0','0','28883','0','0','0','Flame Leviathan Turret','','Gunner','0','80','80','2','1965','1965','0','1.2','1.14286','1','3','0','0','0','0','35','2000','0','4','33570816','8','0','0','0','0','0','0','0','0','9','786540','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','935.979','1','1','0','0','0','0','0','0','0','121','1','0','0','0','boss_flame_leviathan_defense_cannon','12340');

REPLACE into `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) values('33113','33114','2','1','Flame Leviathan','6','30000');
REPLACE into `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) values('33113','33114','3','1','Flame Leviathan','6','30000');
REPLACE into `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) values('33113','33139','7','1','Flame Leviathan','6','30000');

DELETE FROM `disables` WHERE `entry` IN (10056,10057,10058,10059,10060,10061,10218,10219) AND `sourceType`=4;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10056,10057,10058,10059,10060,10061,10218,10219) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10056,11,0,0,'achievement_orbital_bombardment'),
(10057,11,0,0,'achievement_orbital_devastation'),
(10058,11,0,0,'achievement_nuked_from_orbit'),
(10059,11,0,0,'achievement_orbital_bombardment'),
(10060,11,0,0,'achievement_orbital_devastation'),
(10061,11,0,0,'achievement_nuked_from_orbit'),
(10218,11,0,0,'achievement_orbit_uary'),
(10219,11,0,0,'achievement_orbit_uary');

-- Remove redundant areatrigger scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` IN(5369,5423);
-- Add spellscript for trap spell
DELETE FROM `spell_script_names` WHERE `spell_id`=62705;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(62705,'spell_auto_repair');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (62374,62475);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(62374,'spell_pursue'),
(62475,'spell_systems_shutdown');