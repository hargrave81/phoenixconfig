UPDATE zone_settings set zoneip = '76.226.176.47'
WHERE zoneip = '127.0.0.1';
--
 # Updating data of table item_mods
--
UPDATE item_mods SET value = 3 WHERE itemId = 12637 AND modId = 1;  # custom galka start gear mod DEF+3
UPDATE item_mods SET value = 4 WHERE itemId = 13495 AND modId = 1;  # custom sandorian ring       DEF+4
UPDATE item_mods SET value = 2 WHERE itemId = 13495 AND modId = 8;  # custom sandorian ring       STR+2
UPDATE item_mods SET value = 2 WHERE itemId = 13495 AND modId = 13;  # custom sandorian ring      MND+2
UPDATE item_mods SET value = 6 WHERE itemId = 13496 AND modId = 5;  # custom windurstian ring     MP+6
UPDATE item_mods SET value = 2 WHERE itemId = 13496 AND modId = 11;  # custom windurstian ring    AGI+2
UPDATE item_mods SET value = 2 WHERE itemId = 13496 AND modId = 12;  # custom windurstian ring    INT+2
UPDATE item_mods SET value = 6 WHERE itemId = 13497 AND modId = 2;  # custom bastokan ring        HP+6
UPDATE item_mods SET value = 2 WHERE itemId = 13497 AND modId = 9;  # custom bastokan ring        DEX+2
UPDATE item_mods SET value = 2 WHERE itemId = 13497 AND modId = 10;  # custom bastokan ring       VIT+2
UPDATE item_weapon SET DMG = 8, DELAY = 222 WHERE itemId = 20674;  # aern sword
UPDATE item_weapon SET DMG = 4, DELAY = 150 WHERE itemId = 20573;  # aern dagger
UPDATE item_weapon SET DMG = 4, DELAY = 555 WHERE itemId = 20514;  # aphelion knuckles
INSERT INTO item_mods values (20674,25,4);  # acc +4
INSERT INTO item_mods values (20573,25,4);  # acc +4
INSERT INTO item_mods values (20514,25,4);  # acc +4
INSERT INTO item_mods values (20674,73,4);  # store TP +4
INSERT INTO item_mods values (20573,73,4);  # store TP +4
INSERT INTO item_mods values (20514,73,4);  # store TP +4

 # update dual wield for dancer
UPDATE traits SET content_tag = NULL WHERE traitid = 18 and job = 19;

--
 # Inserting data into table item_mods
--
INSERT INTO item_mods(itemId, modId, value) VALUES
(12631, 25, 5),  # custom hume tunic ACC+5
(12631, 29, 5),  # custom hume tunic MDEF+5
(12631, 64, 5),  # custom hume tunic CBT Skillup +5
(12631, 165, 2)  # custom hume tunic CritHit+2 [hidden]

INSERT INTO item_mods(itemId, modId, value) VALUES
(12632, 25, 5),  # custom hume vest ACC+5
(12632, 29, 5),  # custom hume vest MDEF+5
(12632, 64, 5),  # custom hume vest Cbt Skillup +5
(12632, 165, 2)  # custom hume vest CritHit+2 [hidden]

INSERT INTO item_mods(itemId, modId, value) VALUES
(12633, 48, 10),  # custom elvaan jerkin WeaponSkillACC +10
(12633, 73, 10),  # custom elvaan jerkin StoreTP +10
(12633, 384, 200)  # custom elvaan jerkin Haste +2%

INSERT INTO item_mods(itemId, modId, value) VALUES
(12634, 48, 10),  # custom elvaan bodice WeaponSKillAcc +10
(12634, 73, 10),  # custom elvaan bodice StoreTP +10
(12634, 384, 200)  # custom elvaan bodice Haste +2%

INSERT INTO item_mods(itemId, modId, value) VALUES
(12635, 30, 5),  # custom taru kaftan MagAcc +5
(12635, 65, 5),  # custom taru kaftan MagSkillUp +5
(12635, 71, 3)  # custom taru kaftan MPHeal +3

INSERT INTO item_mods(itemId, modId, value) VALUES
(12636, 24, 4),  # custom mithran separates RangedATK +4
(12636, 26, 4),  # custom mithran separates RangedAcc +4
(12636, 259, 5),  # custom mithran separates DualWield +5
(12636, 897, 3)  # custom mithran separates GilFinder+3 [Hidden]

INSERT INTO item_mods(itemId, modId, value) VALUES
(12637, 25, 5),  # custom galkan surcoat Acc+5
(12637, 27, 1),  # custom galkan surcoat Enmity+1
(12637, 49, 100),  # custom galkan surcoat SlashDmg -1%
(12637, 50, 100),  # custom galkan surcoat PerceDmg -1%
(12637, 51, 100),  # custom galkan surcoat ImpactDmg -1%
(12637, 52, 100),  # custom galkan surcoat H2HDmg -1%
(12637, 97, 2)  # custom galkan surcoat Boost .2% [Hidden]

INSERT INTO item_mods(itemId, modId, value) VALUES
(13216, 170, 2),  # custom gold moogle belt Fast Cast 2%
(13216, 384, 100)  # custom gold moogle belt Haste 1%

INSERT INTO item_mods(itemId, modId, value) VALUES
(13495, 303, 2),  # custom sandorian ring TH2
(13496, 303, 2),  # custom windurstian ring TH2
(13497, 303, 2)  # custom bastokan ring TH2

INSERT INTO item_mods(itemId, modId, value) VALUES
(14062, 346, 2),  # custom carbuncle mitts -2 MP/Tick
(15456, 259, 5),  # custom dash sash -5 Dual Weild Delay
(17049, 30, 3)  # custom maple wand MACC +3%

INSERT INTO item_mods(itemId, modId, value) VALUES
(15198, 945, 30),  # Sprout Beret Increase blue spell learning
(15198, 1, 1);  # Sprout Beret DEF 1





UPDATE mob_groups SET HP = 15000, minLevel = 56, maxLevel = 56 WHERE name = 'Boreal_Hound' and zoneid = 112;  # udpdate the G2 NMs
UPDATE mob_groups SET HP = 5000, minLevel = 56, maxLevel = 56 WHERE name = 'Boreal_Coeurl' and zoneid = 112;
UPDATE mob_groups SET HP = 10000, minLevel = 56, maxLevel = 56 WHERE name = 'Boreal_Tiger' and zoneid = 112;

 #                                ID       KeyItem                HQCrystal                                                                            ResultName
 #                                       DeSynth             Crystal                                                                               HQ2Qty
 #                                           Wd  Gld Lt  Alc           Ing1  Ing2  Ing3  Ing4  Ing5  Ing6  Ing7  Ing8  Result                  Qty   HQ3Qty
 #                                             Sm  Cl  Bn  Cook                                                               HQ1   HQ2   HQ3    HQ1Qty
INSERT INTO synth_recipes VALUES (100001,0,0,0,0,0,0,0,0,0,0,4102,4244,17545,17547,17549,17551,17553,17555,17557,17559,18632,18632,18633,18633,1,1,1,1,'Iridal Staff',null);  # Iridal Staff
INSERT INTO synth_recipes VALUES (100002,0,0,0,0,0,0,0,0,0,0,4102,4244,17546,17548,17550,17552,17554,17556,17558,17560,18633,18633,18633,18633,1,1,1,1,'Chatoyant Staff',null);  # Chatoyant Staff

UPDATE mob_family_system  # ENHANCE  fenrir 
 SET ACC = 5, EVA = 5, HP = 110
 WHERE familyid = 36 and ecosystemID = 5;

UPDATE mob_family_system  # ENHANCE  Hurkan for skill ups
 SET ACC = 6, element = .25, agi = 1, def = 4
 WHERE familyid = 460 and ecosystemID = 8;


INSERT INTO mob_pools VALUES 
 (10004,'Hurkan','Hurkan',460,0x0000140A00000000000000000000000000000000,
   1,1,7,350,5,0,0,0,0,0,0,0,1,129,0,0,0,1,0,460,460,318);
   


INSERT INTO mob_groups VALUES
(15007,10004,107,'Hurkan',2500,0,4850,15000,10000,10,14,0,null);  # south gustaburg

INSERT INTO mob_spawn_points VALUES 
(19000004,0,'Hurkan','Hurkan',15007,392.23,0.19,-254.11,39);
INSERT INTO nm_spawn_points
VALUES (19000004,0,392.23,0.19,-254.11);



INSERT INTO mob_groups VALUES
(15008,10004,103,'Hurkan',2500,0,4850,20000,15000,26,29,0,null);  # Valkurm Dunes

INSERT INTO mob_spawn_points VALUES 
(19000005,0,'Hurkan','Hurkan',15008,315.47,0.15,-74.82,39);
INSERT INTO nm_spawn_points
VALUES (19000005,0,315.47,0.15,-74.82);


INSERT INTO mob_groups VALUES
(15010,10004,102,'Hurkan',2500,0,4850,18000,12000,17,21,0,null);  # La Theine Plateau

INSERT INTO mob_spawn_points VALUES 
(19000007,0,'Hurkan','Hurkan',15003, 428.29,23.69,-203.57,39);

INSERT INTO nm_spawn_points
VALUES (19000007,0,428.29,23.69,-203.57);




INSERT INTO mob_groups VALUES
(15009,10004,126,'Hurkan',2500,0,4850,25000,20000,33,38,0,null);  # Qufim

INSERT INTO mob_spawn_points VALUES 
(19000006,0,'Hurkan','Hurkan',15009,-242.3832,-19.1947,376.1273,39);

INSERT INTO nm_spawn_points
VALUES (19000006,0,-242.3832,-19.1947,376.1273);






 # items from skill up monsters
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


/* genkei 1 */;
/* Mob Groups id, poolid, zoneid, respawntime (360/960), sapwntype, dropid, HP,MP, minlv,maxlv, allegence */


INSERT INTO mob_pools VALUES 
(10005,'Jester_Malatrix','Jester_Malatrix',470,0x00007E0800000000000000000000000000000000,
1,4,5,240,50,0,1,0,0,2,0,32,7,133,0,0,0,0,0,110,110,420);


INSERT INTO mob_groups VALUES
(15010,10005,126,'Jester_Malatrix',240,0,8051,4000,1000,48,50,0,null);  # Qufim

INSERT INTO mob_spawn_points VALUES 
(19000008,0,'Jester Malatrix','Jester_Malatrix',15010,151.2537,20.2513,-196.434,39);

INSERT INTO nm_spawn_points
VALUES (19000008,0,151.2537,20.2513,-196.434);

 # renkei  1 items

INSERT INTO mob_droplist VALUES
(8051,0,0,1000,1088,400);
INSERT INTO mob_droplist VALUES
(8051,0,0,1000,1089,400);
INSERT INTO mob_droplist VALUES
(8051,0,0,1000,1090,400);





UPDATE mob_family_system  # decrease the power of the dragon
 SET ACC = 2, DEF = 0, EVA = 2, MND = 3
 WHERE familyid = 470;

