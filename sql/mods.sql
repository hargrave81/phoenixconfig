-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version	5.6.21-log

UPDATE zone_settings set zoneip = '137.116.65.36'
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
(17049, 30, 3); -- custom maple wand

UPDATE mob_family_system -- ENHANCE  fenrir 
 SET ACC = 5, EVA = 5, HP = 180
 WHERE familyid = 36 and systemid = 5;


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
(15000,6500,107,2500,0,4850,15000,10000,6,14,0); -- south gustaburg


INSERT INTO mob_spawn_points VALUES 
(17216132,'Hurkan','Hurkan',15000,392.23,0.19,-254.11,39);
INSERT INTO nm_spawn_points
VALUES (17216132,0,392.23,0.19,-254.11);


/*
--17199662
--17199663
--17199664 */;
INSERT INTO mob_groups VALUES
(15001,6500,103,2500,0,4850,20000,15000,19,26,0); -- Valkurm Dunes

INSERT INTO mob_spawn_points VALUES 
(17199662,'Hurkan','Hurkan',15001,315.47,0.15,-74.82,39);
INSERT INTO nm_spawn_points
VALUES (17199662,0,315.47,0.15,-74.82);

/*
--17293669
--17293668
--17293667
--17293666 */;
INSERT INTO mob_groups VALUES
(15002,6500,126,2500,0,4850,25000,15000,24,30,0); -- Qufim

INSERT INTO mob_spawn_points VALUES 
(17293757,'Hurkan','Hurkan',15002,238.39,-19.48,386.78,39);

INSERT INTO nm_spawn_points
VALUES (17293757,0,238.39,-19.48,386.78);


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
(4850,0,0,1000,6149,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6150,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6151,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6152,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6153,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6154,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6155,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6156,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6157,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6158,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6159,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6160,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6161,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6162,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6163,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6164,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6165,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6166,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6167,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6168,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6169,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6170,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6171,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6172,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6173,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6174,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6175,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6176,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6177,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6178,400);
INSERT INTO mob_droplist VALUES
(4850,0,0,1000,6179,400);