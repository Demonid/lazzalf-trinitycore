+-- >>> SVALA SORROWGRAVE

-- Scourge Hulk, necessary for The Incredible Hulk achievement
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_scourge_hulk' WHERE `entry` = 26555;

-- Ritual Target
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `unit_flags` = '33554944', `flags_extra` = '130' WHERE `entry` IN (27327, 30805);

-- Ritual Sword NPC
DELETE FROM `creature_template` WHERE (`entry`=27325);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES (27325, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Svala Sorrowgrave', 'Sword', '', 0, 80, 80, 2, 21, 21, 0, 0.4, 0.4, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 33554434, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 122, 1, 1886, 0, 0, 'npc_sword_ritual', 12340);


-- Ritual teleports
insert into `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) values('48267','575','296.632','-346.075','90.547','4.60767');
insert into `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) values('48276','575','296.632','-346.075','113.547','4.60767');

UPDATE `creature_template` SET `InhabitType` = 5 WHERE `entry` = 26668;

UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `flags_extra` = 130 WHERE `entry` IN (30771,27273);

-- >> SKADI THE RUTHLESS

UPDATE script_texts SET content_default = 'Skadi the Ruthless is within range of the harpoon launchers!', content_loc6 = '?Skadi el Despiadado esta a tiro para los arpones!', content_loc7 = content_loc6 WHERE entry = -1575007;

UPDATE `gameobject_template` SET `ScriptName` = 'go_skadi_harpoon' WHERE `entry` = 192539;

-- >> KING YMIRON
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` IN (27386, 30756);