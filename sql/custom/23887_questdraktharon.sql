-- Quest givers/enders
DELETE FROM creature_questrelation WHERE quest IN (12007,12802,12068,12238);
DELETE FROM creature_involvedrelation WHERE quest IN (12007,12802,12068,12238);
-- Sacrifices Must be Made
INSERT INTO creature_questrelation VALUES (26500,12007);
INSERT INTO creature_involvedrelation VALUES (26543,12007);
-- Heart of the Ancients
INSERT INTO creature_questrelation VALUES (26543,12042);
-- My Heart is in Your Hands 
INSERT INTO creature_involvedrelation VALUES (26701,12802);
-- Voices From the Dust  
INSERT INTO creature_questrelation VALUES (26701,12068);
INSERT INTO creature_involvedrelation VALUES (26787,12068);
-- Cleansing Drak'Tharon  
INSERT INTO creature_questrelation VALUES (26787,12238);
INSERT INTO creature_involvedrelation VALUES (28016,12238);
-- NpcFlag
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry IN (26543,26701,26787,28016);
-- Scripts
UPDATE item_template SET scriptname='item_drakuru_elixir' WHERE entry=35797;
UPDATE gameobject_template SET scriptname='go_seer_of_zebhalak' WHERE entry=188458;