DELETE FROM `creature_text` WHERE `entry` IN (32295,28859);
INSERT INTO `creature_text` (entry,groupid,id,text,type,language,sound,comment) VALUE
(28859,0,0,'My patience has reached its limit, I will be rid of you!',1,0,14517,'Malygos - Aggro (Phase 1)'),
(28859,1,0,'Your stupidity has finally caught up to you',1,0,14519,'Malygos - Killed Player (1) (Phase 1)'),
(28859,1,1,'More artifacts to confiscate...',1,0,14520,'Malygos - Killed Player (2) (Phase 1)'),
(28859,1,2,'<Laughs> How very... naïve...',1,0,14521,'Malygos - Killed Player (3) (Phase 1)'),
(28859,2,0,'I had hoped to end your lives quickly, but you have proven more... resilient then I had anticipated. Nonetheless, your efforts are in vain, it is you reckless, careless mortals who are to blame for this war! I do what I must... And if it means your... extinction... THEN SO BE IT',1,0,14522,'Malygos - End Phase One'),
(28859,3,0,'Few have experienced the pain I will now inflict upon you!',1,0,14523,'Malygos - Aggro (Phase 2)'),
(28859,4,0,'I will teach you IGNORANT children just how little you know of magic...',1,0,14524,'Malygos - Anti-Magic Shell'),
(28859,5,0,'Watch helplessly as your hopes are swept away...',1,0,14525,'Malygos - Magic Blast'),
(28859,6,0,'Your energy will be put to good use!',1,0,14526,'Malygos - Killed Player 1 (Phase 2)'),
(28859,6,1,'I am the spell-weaver! My power is infinite!',1,0,14527,'Malygos - Killed Player 2 (Phase 2)'),
(28859,6,2,'Your spirit will linger here forever!',1,0,14528,'Malygos - Killed Player 3 (Phase 2)'),
(28859,7,0,'ENOUGH! If you intend to reclaim Azeroth''s magic, then you shall have it...',1,0,14529,'Malygos - End Phase 2'),
(28859,8,0,'Now your benefactors make their appearance... But they are too late. The powers contained here are sufficient to destroy the world ten times over! What do you think they will do to you?',1,0,14530,'Intro Phase 3'),
(28859,9,0,'SUBMIT!',1,0,14531,'Malygos - Aggro (Phase 3)'),
(28859,10,0,'The powers at work here exceed anything you could possibly imagine!',1,0,14532,'Malygos - Surge of Power'),
(28859,11,0,'I AM UNSTOPPABLE!',1,0,14533,'Malygos - Buffed by a spark'),
(28859,12,0,'Alexstrasza! Another of your brood falls!',1,0,14534,'Malygos - Killed Player 1 (Phase 3)'),
(28859,12,1,'Little more then gnats!',1,0,14535,'Malygos - Killed Player 2 (Phase 3)'),
(28859,12,2,'Your red allies will share your fate...',1,0,14536,'Malygos - Killed Player 3 (Phase 3)'),
(28859,13,0,'Still standing? Not for long...',1,0,14537,'Malygos - Spell Casting 1(Phase 3)'),
(28859,13,1,'Your cause is lost',1,0,14538,'Malygos - Spell Casting 2 (Phase 3)'),
(28859,13,2,'Your fragile mind will be shattered!',1,0,14539,'Malygos - Spell Casting 3 (Phase 3)'),
(28859,14,0,'Unthinkable! The mortals will destroy... everything... my sister... what have you...',1,0,0,'Malygos - Death'),
(32295,0,0,'I did what I had to, brother. You gave me no alternative.',1,0,0,'Alexstrasza - Yell One'),
(32295,1,0,'And so ends the Nexus War.',1,0,0,'Alexstrasza - Yell Two'),
(32295,2,0,'This resolution pains me deeply, but the destruction, the monumental loss of life had to end. Regardless of Malygos'' recent transgressions, I will mourn his loss. He was once a guardian, a protector. This day, one of the world''s mightiest has fallen.',1,0,0,'Alexstrasza - Yell Three'),
(32295,3,0,'The red dragonflight will take on the burden of mending the devastation wrought on Azeroth. Return home to your people and rest. Tomorrow will bring you new challenges, and you must be ready to face them. Life... goes on.',1,0,0,'Alexstrasza - Yell Four');

-- conditions for spells used by Malygos
DELETE FROM `conditions` WHERE `SourceGroup`=0 AND `SourceEntry` IN (56263,55853,56505,56429,56152) AND `ConditionTypeOrReference`=18;
INSERT INTO `conditions` (SourceTypeOrReferenceId,ConditionTypeOrReference,SourceGroup,SourceEntry,ConditionValue1,ConditionValue2) VALUES 
(13,18,0,55853,1,30090),
(13,18,0,56263,1,30090),
(13,18,0,56505,1,30334),
(13,18,0,56429,1,30334),
(13,18,0,56152,1,28859);

-- vortex trigger
UPDATE `creature_template` SET `modelid1`=11686,`modelid2`=169,`InhabitType`=5,`unit_flags`=0x02000000,`VehicleId`=214,`flags_extra`=130 WHERE `entry`=30090;
UPDATE `creature` SET `modelid`=0 WHERE `id`=30090;


-- Portal (Malygos)
UPDATE `creature_template` SET `InhabitType`=5 WHERE `entry`=30118;
UPDATE `creature_template` SET `speed_walk`=2.4,`speed_run`=0.857142857 WHERE `entry`=30084;

-- Hover Disk
UPDATE `creature_template` SET `VehicleId`=224,`faction_A`=35,`faction_H`=35,`InhabitType`=5 WHERE `entry` IN (30234,30248);

-- Surge of Power
UPDATE `creature_template` SET flags_extra=130 WHERE entry=30334;

-- Wyrmrest Skytalon (Player's Mount)
UPDATE `creature_template` SET `InhabitType`=5 WHERE `entry`=30161;

-- Alexstrasza the Life-Binder
UPDATE `creature_template` SET `InhabitType`=5 WHERE `entry`=32295;

-- static Field
UPDATE `creature_template` SET `flags_extra`=130,`InhabitType`=5 WHERE `entry`=30592;

UPDATE `creature_template` SET `VehicleId`=220,`spell1`=56091,`spell2`=56092,`spell3`=57090,`spell4`=57143,`spell5`=57108,`spell6`=57092,`spell7`=60534 WHERE `entry`=30161;

DELETE FROM `creature_template_addon` WHERE `entry`=30592;
INSERT INTO `creature_template_addon` (entry,auras) VALUES (30592,'57428 0');

-- Spawning Focusing Iris
DELETE FROM `gameobject` WHERE `id`=193958;
INSERT INTO `gameobject` (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES 
(151791,193958,616,1,1,754.2546,1301.71973,266.170319,-1.60570168,0,0,0,0,120,0,1);
-- Spawning chests
DELETE FROM `gameobject` WHERE `id` IN (193967,193905);
INSERT INTO `gameobject` (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,spawntimesecs,animprogress,state) VALUES
(151792,193905,616,1,1,764.56,1284.63,269,1.82,-604800,100,1), 
(151793,193967,616,2,1,764.56,1284.63,269,1.82,-604800,100,1);

-- Hover Disk
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (30248,30234);
INSERT INTO `npc_spellclick_spells` (npc_entry,spell_id,quest_start,quest_end,cast_flags) VALUES 
(30234,61421,0,0,0),
(30248,61421,0,0,0);

DELETE FROM `instance_template` WHERE `map`=616;
INSERT INTO `instance_template` (map,parent,script) VALUES (616,571,'instance_eye_of_eternity');

UPDATE `creature_template` SET `ScriptName`='boss_malygos' WHERE `entry`=28859;
UPDATE `creature_template` SET `ScriptName`='npc_power_spark' WHERE `entry`=30084;
UPDATE `creature_template` SET `ScriptName`='npc_portal_eoe' WHERE `entry`=30118;
UPDATE `creature_template` SET `ScriptName`='npc_hover_disk' WHERE `entry` IN (30234,30248);
UPDATE `creature_template` SET `ScriptName`='npc_arcane_overload' WHERE `entry`= 30282;
UPDATE `creature_template` SET `ScriptName`='npc_wyrmrest_skytalon' WHERE `entry`=30161;
UPDATE `creature_template` SET `ScriptName`='npc_alexstrasza_eoe' WHERE `entry`=32295;
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`= 30245;

DELETE FROM `spell_script_names` WHERE `spell_id`=56105;
INSERT INTO `spell_script_names` VALUES (56105,'spell_malygos_vortex_dummy');
DELETE FROM `spell_script_names` WHERE `spell_id`=55873;
INSERT INTO `spell_script_names` VALUES (55873,'spell_malygos_vortex_visual');

DELETE FROM `instance_template` WHERE `map`=616;
INSERT INTO `instance_template` (map,parent,script) VALUES (616,571,'instance_eye_of_eternity');

-- Scripts for Nexus Lord and Scion of Eternity
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (30249,30245);
DELETE FROM `smart_scripts` WHERE (`entryorguid`=30249 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(30249, 0, 0, 0, 0, 0, 100, 6, 3000, 5000, 4000, 6000, 11, 56397, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Scion of Eternity - Cast Arcane Barrage (Random)'),
(30249, 0, 1, 0, 7, 0, 100, 6, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scion of Eternity - Despawn in EvadeMode');
DELETE FROM `smart_scripts` WHERE (`entryorguid`=30245 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(30245, 0, 0, 0, 0, 0, 100, 6, 7000, 10000, 10000, 15000, 11, 57060, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Lord - Cast Haste (Self)'),
(30245, 0, 1, 0, 0, 0, 100, 6, 5000, 8000, 9000, 12000, 11, 57058, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nexus Lord - Cast Arcane Shock (Random)'),
(30245, 0, 2, 0, 7, 0, 100, 6, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Lord - Despawn in EvadeMode');

-- Hover Disk
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (30234,30248);
INSERT INTO `vehicle_template_accessory` (entry,accessory_entry,seat_id,minion,description) VALUES 
(30234,30245,0,0,'Hover Disk - Nexus Lord'),
(30248,30249,0,0,'Hover Disk - Scion of Eternity');

-- Spell Arcane Barrage
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=56397;
INSERT INTO `spell_linked_spell` (spell_trigger,spell_effect,type,comment) VALUES (56397,63934,1,'Arcane Barrage - Arcane Barrage');

-- SpellScripts (mostly target selection)
DELETE FROM spell_script_names WHERE spell_id IN (56548,56397,63934,57459,61694,60936);
INSERT INTO spell_script_names VALUES
(56548,'spell_malygos_surge_of_power'),
(56397,'spell_malygos_arcane_barrage'),
(63934,'spell_malygos_arcane_barrage'),
(57459,'spell_malygos_arcane_storm'),
(61694,'spell_malygos_arcane_storm'),
(60936,'spell_malygos_surge_of_power_p3');

-- Limit "Denying the Scion" to respective Map-Version
DELETE FROM achievement_criteria_data WHERE criteria_id IN (7573,7574) AND type=12;
INSERT INTO achievement_criteria_data VALUES (7573,12,0,0,''),(7574,12,1,0,'');

-- condition for gift-beam-visual
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=61028;
INSERT INTO conditions VALUES (13,0,61028,0,18,1,32448,0,0,'','Eye of Eternity: Alexstrasza Gift Beam targeting');

-- disable LoS for Eye of Eternity
DELETE FROM disables WHERE sourceType=6 AND entry=616;
INSERT INTO disables VALUES (6,616,0x4,0,0,'Eye of Eternity - Line of Sight');

-- add SmartScript to Static Fields so they despawn in time

UPDATE creature_template SET AIName='SmartAI' WHERE entry=30592;
DELETE FROM smart_scripts WHERE entryOrGuid=30592;
INSERT INTO smart_scripts VALUES (30592,0,0,0,54,0,100,0,0,0,0,0,41,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Static Field - Despawn after 30sec');

-- give energy sparks a visible aura
DELETE FROM creature_template_addon WHERE entry IN (30084,32187);
INSERT INTO creature_template_addon (entry,auras) VALUES (30084,55845),(32187,55845);

-- models for 'Vortex' are inversed (flag as trigger..? (128))
UPDATE creature_template SET modelid2=11686, modelid1=169 WHERE entry=30090;

-- add sound to mute Alexstrasza
UPDATE creature_text SET sound=14406 WHERE entry=32295 AND groupid=0;
UPDATE creature_text SET sound=14407 WHERE entry=32295 AND groupid=1;
UPDATE creature_text SET sound=14408 WHERE entry=32295 AND groupid=2;
UPDATE creature_text SET sound=14409 WHERE entry=32295 AND groupid=3;
-- this one obsolete?
DELETE FROM creature_text WHERE entry=31253;
INSERT INTO creature_text VALUES (31253,0,0,'Champions! My children, blessed with my powers, shall aid you in your fight!',14,0,0,0,0,14405,'Alexstrasza (Proxy) - Spawn Drakes');

-- remove already spawned containers
DELETE FROM `gameobject` WHERE `map` = 616;
DELETE FROM `creature` WHERE `map` = 616;
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132302','31253','616','3','1','27401','0','754.255','1301.72','266.253','1.23918','3600','5','0','3052','0','1','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132303','30334','616','3','1','11686','0','754.294','1301.19','266.254','4.24115','3600','0','0','12600','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132304','30090','616','3','1','0','0','754.733','1301.51','283.379','5.58505','3600','0','0','12600','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132305','30090','616','3','1','0','0','754.521','1301.23','279.524','0.680678','3600','0','0','12600','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132306','30090','616','3','1','0','0','754.356','1301.48','285.733','5.96903','3600','0','0','12600','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132307','30090','616','3','1','0','0','754.192','1301.18','281.851','5.75959','3600','0','0','12600','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132308','30090','616','3','1','0','0','754.688','1301.8','287.295','1.25664','3600','0','0','12600','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132309','30118','616','3','1','14501','0','652.417','1200.52','295.972','0.785398','3600','0','0','17010','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132310','30118','616','3','1','14501','0','847.67','1408.05','295.972','3.97935','3600','0','0','17010','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132311','30118','616','3','1','14501','0','647.675','1403.8','295.972','5.53269','3600','0','0','17010','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132312','30118','616','3','1','14501','0','843.182','1215.42','295.972','2.35619','3600','0','0','17010','0','0','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132313','28859','616','3','1','26752','0','808.535','1213.55','295.972','3.22503','604800','5','0','6972500','212900','1','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132314','32448','616','3','1','27401','0','754.544','1301.71','220.083','3.9968','3600','5','0','3052','0','1','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('132315','22517','616','3','1','16925','0','754.395','1301.27','266.254','1.0821','3600','0','0','4120','0','0','0','0','0');
insert into `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('151793','193967','616','2','1','764.56','1284.63','269','1.82','0','0','0','0','-604800','100','1');
insert into `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('151792','193905','616','1','1','764.56','1284.63','269','1.82','0','0','0','0','-604800','100','1');
insert into `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('151791','193958','616','1','1','754.255','1301.72','266.17','-1.6057','0','0','0','0','120','0','1');
insert into `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('67449','193070','616','3','1','754.346','1300.87','256.249','3.14159','0','0','0','1','180','0','1');
insert into `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values('67450','193908','616','3','1','724.684','1332.92','267.234','-0.802851','0','0','0','1','180','0','1');

replace into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) values('28859','0','0','0','0','0','26752','0','0','0','Malygos','','','0','83','83','2','16','16','0','4','2.85714','1','3','496','674','0','783','35','2000','0','2','320','8','0','0','0','0','0','365','529','98','2','108','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','5','500','50','1','0','44650','0','0','0','0','0','227','1','0','619659099','1','boss_malygos','12340');
