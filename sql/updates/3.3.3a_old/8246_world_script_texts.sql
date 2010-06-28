DELETE FROM `script_texts` WHERE `entry` <= -1668000 and `entry` >= -1668999;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
-- INTRO
(37221,-1668001,'The chill of this place... Brr... I can feel my blood freezing.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16631,1,0,0,'Jaina SAY_JAINA_INTRO_1'),
(37221,-1668002,'What is that? Up ahead! Could it be... ? Heroes at my side!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16632,1,0,0,'Jaina SAY_JAINA_INTRO_2'),
(37221,-1668003,'Frostmourne! The blade that destroyed our kingdom...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16633,1,0,0,'Jaina SAY_JAINA_INTRO_3'),
(37221,-1668004,'Stand back! Touch that blade and your soul will be scarred for all eternity! I must attempt to commune with the spirits locked away within Frostmourne. Give me space, back up please!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16634,1,0,0,'Jaina SAY_JAINA_INTRO_4'),
(37225,-1668005,'Jaina! Could it truly be you?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16666,1,0,0,'Uther SAY_UTHER_INTRO_A2_1'),
(37221,-1668006,'Uther! Dear Uther! ... I... I''m so sorry.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16635,0,0,0,'Jaina SAY_JAINA_INTRO_5'),
(37225,-1668007,'Jaina you haven''t much time. The Lich King sees what the sword sees. He will be here shortly!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16667,0,0,0,'Uther SAY_UTHER_INTRO_A2_2'),
(37221,-1668008,'Arthas is here? Maybe I...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16636,0,0,0,'Jaina SAY_JAINA_INTRO_6'),
(37225,-1668009,'No, girl. Arthas is not here. Arthas is merely a presence within the Lich King''s mind. A dwindling presence...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16668,0,0,0,'Uther SAY_UTHER_INTRO_A2_3'),
(37221,-1668010,'But Uther, if there''s any hope of reaching Arthas. I... I must try.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16637,0,0,0,'Jaina SAY_JAINA_INTRO_7'),
(37225,-1668011,'Jaina, listen to me. You must destroy the Lich King. You cannot reason with him. He will kill you and your allies and raise you all as powerful soldiers of the Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16669,0,0,0,'Uther SAY_UTHER_INTRO_A2_4'),
(37221,-1668012,'Tell me how, Uther? How do I destroy my prince? My...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16638,0,0,0,'Jaina SAY_JAINA_INTRO_8'),
(37225,-1668013,'Snap out of it, girl. You must destroy the Lich King at the place where he merged with Ner''zhul - atop the spire, at the Frozen Throne. It is the only way.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16670,0,0,0,'Uther SAY_UTHER_INTRO_A2_5'),
(37221,-1668014,'You''re right, Uther. Forgive me. I... I don''t know what got a hold of me. We will deliver this information to the King and the knights that battle the Scourge within Icecrown Citadel.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16639,0,0,0,'Jaina SAY_JAINA_INTRO_9'),
(37225,-1668015,'There is... something else that you should know about the Lich King. Control over the Scourge must never be lost. Even if you were to strike down the Lich King, another would have to take his place. For without the control of its master, the Scourge would run rampant across the world - destroying all living things.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16671,0,0,0,'Uther SAY_UTHER_INTRO_A2_6'),
(37225,-1668016,'A grand sacrifice by a noble soul...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16672,0,0,0,'Uther SAY_UTHER_INTRO_A2_7'),
(37221,-1668017,'Who could bear such a burden?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16640,0,0,0,'Jaina SAY_JAINA_INTRO_10'),
(37225,-1668018,'I do not know, Jaina. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16673,0,0,0,'Uther SAY_UTHER_INTRO_A2_8'),
(37221,-1668019,'Then maybe there is still hope...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16641,0,0,0,'Jaina SAY_JAINA_INTRO_11'),
(37225,-1668020,'No, Jaina! Aargh! He... He is coming! You... You must...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16674,0,0,0,'Uther SAY_UTHER_INTRO_A2_9'),
(37223,-1668021,'I... I don''t believe it! Frostmourne stands before us, unguarded! Just as the Gnome claimed. Come, heroes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17049,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_1'),
(37223,-1668022,'Standing this close to the blade that ended my life... The pain... It is renewed.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17050,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_2'),
(37223,-1668023,'I dare not touch it. Stand back! Stand back as I attempt to commune with the blade! Perhaps our salvation lies within...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17051,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_3'),
(37225,-1668024,'Careful, girl. I''ve heard talk of that cursed blade saving us before. Look around you and see what has been born of Frostmourne.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16659,0,0,0,'Uther SAY_UTHER_INTRO_H2_1'),
(37223,-1668025,'Uther...Uther the Lightbringer. How...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17052,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_4'),
(37225,-1668026,'You haven''t much time. The Lich King sees what the sword sees. He will be here shortly.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16660,0,0,0,'Uther SAY_UTHER_INTRO_H2_2'),
(37223,-1668027,'The Lich King is here? Then my destiny shall be fulfilled today!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17053,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_5'),
(37225,-1668028,'You cannot defeat the Lich King. Not here. You would be a fool to try. He will kill those who follow you and raise them as powerful servants of the Scourge. But for you, Sylvanas, his reward for you would be worse than the last.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16661,0,0,0,'Uther SAY_UTHER_INTRO_H2_3'),
(37223,-1668029,'There must be a way... ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17054,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_6'),
(37225,-1668030,'Perhaps, but know this: there must always be a Lich King. Even if you were to strike down Arthas, another would have to take his place, for without the control of the Lich King, the Scourge would wash over this world like locusts, destroying all that they touched.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16662,0,0,0,'Uther SAY_UTHER_INTRO_H2_4'),
(37223,-1668031,'Who could bear such a burden?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17055,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_7'),
(37225,-1668032,'I do not know, Banshee Queen. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16663,0,0,0,'Uther SAY_UTHER_INTRO_H2_5'),
(37225,-1668033,'Alas, the only way to defeat the Lich King is to destroy him at the place he was created.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16664,0,0,0,'Uther SAY_UTHER_INTRO_H2_6'),
(37223,-1668034,'The Frozen Throne...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17056,0,0,0,'Sylvanas SAY_SYLVANAS_INTRO_8'),
(37225,-1668035,'I... Aargh... He... He is coming... You... You must...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16665,0,0,0,'Uther SAY_UTHER_INTRO_H2_7'),
(37226,-1668036,'SILENCE, PALADIN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17225,1,0,0,'Lich King SAY_LK_INTRO_1'),
(37226,-1668037,'So you wish to commune with the dead? You shall have your wish.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17226,1,0,0,'Lich King SAY_LK_INTRO_2'),
(37226,-1668038,'Falric. Marwyn. Bring their corpses to my chamber when you are through.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17227,1,0,0,'Lich King SAY_LK_INTRO_3'),
(38112,-1668039,'As you wish, my lord.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16717,1,0,0,'Falric SAY_FALRIC_INTRO_1'),
(38113,-1668040,'As you wish, my lord.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16741,1,0,0,'Marwyn SAY_MARWYN_INTRO_1'),
(38112,-1668041,'Soldiers of Lordaeron, rise to meet your master''s call!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16714,1,0,0,'Falric SAY_FALRIC_INTRO_2'),
(37221,-1668042,'You won''t deny me this Arthas! I must know! I must find out!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16642,1,0,0,'Jaina SAY_JAINA_INTRO_END'),
(37223,-1668043,'You will not escape me that easily, Arthas! I will have my vengeance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17057,1,0,0,'Sylvanas SAY_SYLVANAS_INTRO_END'),
-- Falric
(38112,-1668050,'Men, women and children... None were spared the master''s wrath. Your death will be no different.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16710,1,0,0,'Falric SAY_AGGRO'),
(38112,-1668051,'Sniveling maggot!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16711,1,0,0,'Falric SAY_SLAY_1'),
(38112,-1668052,'The children of Stratholme fought with more ferocity!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16712,1,0,0,'Falric SAY_SLAY_2'),
(38112,-1668053,'Marwyn, finish them...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16713,1,0,0,'Falric SAY_DEATH'),
(38112,-1668054,'Despair... so delicious...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16715,1,0,0,'Falric SAY_IMPENDING_DESPAIR'),
(38112,-1668055,'Fear... so exhilarating...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16716,1,0,0,'Falric SAY_DEFILING_HORROR'),
-- Marwyn
(38113,-1668060,'Death is all that you will find here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16734,1,0,0,'Marwyn SAY_AGGRO'),
(38113,-1668061,'I saw the same look in his eyes when he died. Terenas could hardly believe it. Hahahaha!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16735,1,0,0,'Marwyn SAY_SLAY_1'),
(38113,-1668062,'Choke on your suffering!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16736,1,0,0,'Marwyn SAY_SLAY_2'),
(38113,-1668063,'Yes... Run... Run to meet your destiny... Its bitter, cold embrace, awaits you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16737,1,0,0,'Marwyn SAY_DEATH'),
(38113,-1668064,'Your flesh has decayed before your very eyes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16739,1,0,0,'Marwyn SAY_CORRUPTED_FLESH_1'),
(38113,-1668065,'Waste away into nothingness!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16740,1,0,0,'Marwyn SAY_CORRUPTED_FLESH_2');
