-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version	5.6.21-log

UPDATE zone_settings set zoneip = '35.229.114.226'
WHERE zoneip = '127.0.0.1';
--
-- Updating data of table item_mods
--
UPDATE item_mods SET value = 3 WHERE itemId = 12637 AND modId = 1; -- custom galka start gear mod
UPDATE item_mods SET value = 4 WHERE itemId = 13495 AND modId = 1; -- custom sandorian ring
UPDATE item_mods SET value = 2 WHERE itemId = 13495 AND modId = 8; -- custom sandorian ring
UPDATE item_mods SET value = 2 WHERE itemId = 13495 AND modId = 13; -- custom sandorian ring
UPDATE item_mods SET value = 6 WHERE itemId = 13496 AND modId = 5; -- custom windurstian ring
UPDATE item_mods SET value = 2 WHERE itemId = 13496 AND modId = 11; -- custom windurstian ring
UPDATE item_mods SET value = 2 WHERE itemId = 13496 AND modId = 12; -- custom windurstian ring
UPDATE item_mods SET value = 6 WHERE itemId = 13497 AND modId = 2; -- custom bastokan ring
UPDATE item_mods SET value = 2 WHERE itemId = 13497 AND modId = 9; -- custom bastokan ring
UPDATE item_mods SET value = 2 WHERE itemId = 13497 AND modId = 10; -- custom bastokan ring
UPDATE item_weapon SET DMG = 8, DELAY = 222 WHERE itemId = 20674; -- aern sword
UPDATE item_weapon SET DMG = 4, DELAY = 150 WHERE itemId = 20573; -- aern dagger
UPDATE item_weapon SET DMG = 4, DELAY = 555 WHERE itemId = 20514; -- aphelion knuckles
INSERT INTO item_mods values (20674,25,4); -- acc +4
INSERT INTO item_mods values (20573,25,4); -- acc +4
INSERT INTO item_mods values (20514,25,4); -- acc +4
INSERT INTO item_mods values (20674,73,4); -- store TP +4
INSERT INTO item_mods values (20573,73,4); -- store TP +4
INSERT INTO item_mods values (20514,73,4); -- store TP +4
--
-- Inserting data into table item_mods
--
INSERT INTO item_mods(itemId, modId, value) VALUES
(12631, 25, 5), -- custom hume tunic
(12631, 29, 5), -- custom hume tunic
(12631, 64, 5), -- custom hume tunic
(12631, 165, 5), -- custom hume tunic
(12632, 25, 5), -- custom hume vest
(12632, 29, 5), -- custom hume vest
(12632, 64, 5), -- custom hume vest
(12632, 165, 5), -- custom hume vest
(12633, 48, 10), -- custom elvaan jerkin
(12633, 73, 10), -- custom elvaan jerkin
(12633, 384, 200), -- custom elvaan jerkin
(12634, 48, 10), -- custom elvaan bodice
(12634, 73, 10), -- custom elvaan bodice
(12634, 384, 200), -- custom elvaan bodice
(12635, 30, 10), -- custom taru kaftan
(12635, 65, 10), -- custom taru kaftan
(12635, 71, 10), -- custom taru kaftan
(12636, 24, 7), -- custom mithran separates
(12636, 26, 7), -- custom mithran separates
(12636, 259, 5), -- custom mithran separates
(12636, 897, 3), -- custom mithran separates
(12637, 25, 5), -- custom galkan surcoat
(12637, 27, 1), -- custom galkan surcoat
(12637, 49, 5), -- custom galkan surcoat
(12637, 50, 5), -- custom galkan surcoat
(12637, 51, 5), -- custom galkan surcoat
(12637, 52, 5), -- custom galkan surcoat
(12637, 97, 2), -- custom galkan surcoat
(13216, 170, 2), -- custom gold moogle belt
(13216, 384, 400), -- custom gold moogle belt
(13495, 303, 2), -- custom sandorian ring TH2
(13496, 303, 2), -- custom windurstian ring TH2
(13497, 303, 2), -- custom bastokan ring TH2
(14062, 346, 2), -- custom carbuncle mitts
(15456, 259, 5), -- custom dash sash
(17049, 30, 3), -- custom maple wand
(15198, 64, 6), -- Sprout Beret Combat skill up
(15198, 65, 6), -- Sprout Beret Magic skill up
(15198, 945, 30), -- Increase blue spell learning
(15198, 1, 1); -- Sprout Beret DEF



UPDATE mob_groups SET HP = 10000, minLevel = 56, maxLevel = 56 WHERE groupid = 6163; -- udpdate the G2 NMs
UPDATE mob_groups SET HP = 10000, minLevel = 56, maxLevel = 56 WHERE groupid = 6164;
UPDATE mob_groups SET HP = 10000, minLevel = 56, maxLevel = 56 WHERE groupid = 6165;


UPDATE mob_family_system -- ENHANCE  fenrir 
 SET ACC = 5, EVA = 5, HP = 180
 WHERE familyid = 36 and systemid = 5;

UPDATE mob_family_system -- ENHANCE  Hurkan for skill ups
 SET ACC = 6, fire = .25, wind = .25, ice = .25, earth = .25, lightning = .25, water = .25, light = .25, dark = .25, pierce = 1, agi = 1, def = 4
 WHERE familyid = 460 and systemid = 8;


INSERT INTO mob_pools VALUES 
 (6500,'Hurkan','Hurkan',460,0x0000140A00000000000000000000000000000000,1,4,7,540,5,0,0,0,1,0,0,0,1,129,0,0,0,1,0,460);

/*
--17216127
--17216128
--17216129
--17216130
--17216131
--17216132 */;
INSERT INTO mob_groups VALUES
(15000,6500,107,2500,0,4850,15000,10000,10,14,0); -- south gustaburg


INSERT INTO mob_spawn_points VALUES 
(17216132,'Hurkan','Hurkan',15000,392.23,0.19,-254.11,39);
INSERT INTO nm_spawn_points
VALUES (17216132,0,392.23,0.19,-254.11);


/*
--17199662
--17199663
--17199664 */;
INSERT INTO mob_groups VALUES
(15001,6500,103,2500,0,4850,20000,15000,26,29,0); -- Valkurm Dunes

INSERT INTO mob_spawn_points VALUES 
(17199662,'Hurkan','Hurkan',15001,315.47,0.15,-74.82,39);
INSERT INTO nm_spawn_points
VALUES (17199662,0,315.47,0.15,-74.82);



/* genkei 1 */;
/* Mob Groups id, poolid, zoneid, respawntime (360/960), sapwntype, dropid, HP,MP, minlv,maxlv, allegence */
INSERT INTO mob_groups VALUES
(15007,6505,126,240,0,4851,4000,1000,48,50,0); -- Qufim

UPDATE mob_family_system -- decrease the power of the dragon
 SET ACC = 2, DEF = 0, EVA = 2, MND = 3, fire = 1.5, ice = 1.5, earth = 1.5, lightning = 1.5,
 slash = .75, pierce = .75
 WHERE familyid = 470;

INSERT INTO mob_spawn_points VALUES 
(17293665,'Jester_Malatrix','Jester Malatrix',15007,151.2537,20.2513,-196.434,39);

INSERT INTO nm_spawn_points
VALUES (17293665,0,151.2537,20.2513,-196.434);

INSERT INTO mob_pools VALUES 
(6505,'Jester_Malatrix','Jester_Malatrix',470,0x00007E0800000000000000000000000000000000,1,4,1,340,40,0,1,0,0,0,0,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4851,0,0,1000,1088,400);
INSERT INTO mob_droplist VALUES
(4851,0,0,1000,1089,400);
INSERT INTO mob_droplist VALUES
(4851,0,0,1000,1090,400);


/*
--17293669
--17293668
--17293667
--17293666 */;
INSERT INTO mob_groups VALUES
(15002,6500,126,2500,0,4850,25000,15000,33,38,0); -- Qufim

INSERT INTO mob_spawn_points VALUES 
(17293669,'Hurkan','Hurkan',15002,-242.3832,-19.1947,376.1273,39);

INSERT INTO nm_spawn_points
VALUES (17293669,0,-242.3832,-19.1947,376.1273);


INSERT INTO mob_pools VALUES 
(6501,'Primogenial_Marolith','Primogenial_Marolith',347,0x0000930700000000000000000000000000000000,1,4,11,90,10,0,0,0,0,0,0,0,1,129,4,0,0,1,0,347);

/*
--17195576
--17195575
--17195574
--17195572
--17195571
--17195570 */;
INSERT INTO mob_groups VALUES
(15003,6501,102,2500,0,4850,40000,20000,28,32,0); -- La Theine Plateau

INSERT INTO mob_spawn_points VALUES 
(17195576,'Primogenial_Marolith','Primogenial_Marolith',15003, 428.29,23.69,-203.57,39);

INSERT INTO nm_spawn_points
VALUES (17195576,0,428.29,23.69,-203.57);


INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6149,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6150,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6151,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6152,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6153,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6154,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6155,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6156,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6157,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6158,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6159,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6160,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6161,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6162,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6163,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6164,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6165,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6166,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6167,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6168,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6169,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6170,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6171,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6172,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6173,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6174,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6175,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6176,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6177,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6178,70);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6179,70);