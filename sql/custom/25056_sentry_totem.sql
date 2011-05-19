DELETE FROM `spell_dbc` WHERE `id` IN (6494,6496);
INSERT INTO `spell_dbc` (`Id`,`CastingTimeIndex`,`DurationIndex`,`RangeIndex`,`Effect1`,`EffectBasePoints1`,`EffectImplicitTargetA1`,`EffectImplicitTargetB1`,`EffectApplyAuraName1`,`SpellFamilyName`,`Comment`) VALUES
(6494,1,5,1,6,1,1,27,4,11,'Sentry Totem Helper 1 (SERVERSIDE)'),
(6496,1,5,1,6,1,25,0,1,11,'Sentry Totem Helper 2 (SERVERSIDE)');

UPDATE `creature_template` SET `spell1` = 6494 WHERE `entry` = 3968;

-- in case of using ability Far Sight in one time with Sentry Totem
DELETE FROM `conditions` WHERE `SourceEntry` = 6196;
INSERT INTO `conditions` VALUES
(17,0,6196,0,11,6495,1,0,24,'','Far Sight - Sentry Totem');