-- Fix Stealing X's Flame quests
DELETE FROM `creature_questrelation` WHERE `quest` IN (11933,11935);
UPDATE `quest_template` SET `NextQuestId`=9365,`NextQuestInChain`=9365 WHERE `entry` IN (9324,9325,9326,11935);
UPDATE `quest_template` SET `NextQuestId`=9339,`NextQuestInChain`=9339 WHERE `entry` IN (9330,9331,9332,11933);
