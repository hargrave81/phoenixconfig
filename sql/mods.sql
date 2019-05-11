-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version	5.6.21-log

/*
use dspdb ;
CREATE TABLE account_ip_record (
  login_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  accid int(10) NOT NULL,
  charid int(10) NOT NULL,
  client_ip tinytext NOT NULL,
  PRIMARY KEY (login_time,accid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/

UPDATE zone_settings set zoneip = '52.147.170.105'
WHERE zoneip = '127.0.0.1'
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
(17049, 30, 15); -- custom maple wand

UPDATE mob_family_system -- ENHANCE  fenrir 
 SET ACC = 5, EVA = 5, HP = 180
 WHERE familyid = 36 and systemid = 5


LOCK TABLES mob_pools WRITE;

INSERT INTO mob_pools VALUES 
 (6500,'Hurkan','Hurkan',460,0x0000140A00000000000000000000000000000000,1,1,7,540,2,0,0,0,1,0,0,0,1,129,0,0,0,1,0,460);

UNLOCK TABLES;