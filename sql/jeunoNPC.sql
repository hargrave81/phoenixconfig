/*
--u 17772574  leis
--u 17772570  anoop
--u 17772589  akta
--u 17772578  kayle
--u 17772596  diradour
--u 17772696  world shift
--u 17772722  shinkan A
--u 17772723  shinkan B
--u 17772724  shinkan C
--u 17772771  ajahkeem
--  17772670  moogle


--  17780776  raji
--  17780777  shomera
--  17780928  rakuru-rakc
--  17780772  runga-kopunga
--  17780783  odasel
*/


UPDATE npc_list SET pos_x = -6.264, pos_z = -10.621, pos_y = 3, pos_rot = 0,
 content_tag = null, name_prefix = 32, entityFlags= 27, status = 0, flag = 21
WHERE npcid = 17772722; /*  shinkan A */

UPDATE npc_list SET pos_x = -10.404, pos_z = -10.621, pos_y = 3, pos_rot = 0,
 content_tag = null, name_prefix = 32, entityFlags= 27, status = 0, flag = 21 
WHERE npcid = 17772723; /*  shinkan B */

UPDATE npc_list SET pos_x = -15.223, pos_z = -10.621, pos_y = 3, pos_rot = 0,
 content_tag = null, name_prefix = 32, entityFlags= 27, status = 0, flag = 21
WHERE npcid = 17772724; /*  shinkan C */

UPDATE npc_list SET pos_x = -10.589, pos_z = -2.057, pos_y = 3, pos_rot = 180,
 content_tag = null, name_prefix = 32, entityFlags= 27, status = 0, flag = 21
WHERE npcid = 17772696; /*  worldshifter */




/* Moogles for Promy Dem */
UPDATE NPC_LIST SET pos_x = 180.81, pos_y = 0,pos_z = -49.21, pos_rot = 128 WHERE npcid = 16851287;
UPDATE NPC_LIST SET pos_x = -184.32, pos_y = 0,pos_z = -41.89, pos_rot = 64 WHERE npcid = 16851288;
UPDATE NPC_LIST SET pos_x = -190.12, pos_y = 0,pos_z = 465.67, pos_rot = 64 WHERE npcid = 16851289;
UPDATE NPC_LIST SET pos_x = 268.07, pos_y = 0,pos_z = 432.32, pos_rot = 128 WHERE npcid = 16851290;

UPDATE NPC_LIST SET pos_x = -238.72, pos_y = 58,pos_z = 35.72, pos_rot = 64 WHERE npcid = 16855178;


/* holla */
UPDATE NPC_LIST SET pos_x = 60.85, pos_y = 0,pos_z = 88.06, pos_rot = 64 WHERE npcid = 16843070;
UPDATE NPC_LIST SET pos_x = -128.2, pos_y = 0,pos_z = 17.49, pos_rot = 64 WHERE npcid = 16843071;
UPDATE NPC_LIST SET pos_x = 233.51, pos_y = 0,pos_z = 308.43, pos_rot = 64 WHERE npcid = 16843072;
UPDATE NPC_LIST SET pos_x = 115.32, pos_y = 0,pos_z = -309.42, pos_rot = 64 WHERE npcid = 16843073;

UPDATE NPC_LIST SET pos_x = -238.72, pos_y = 58,pos_z = 35.72, pos_rot = 64 WHERE npcid = 16846971;

/* mea */
UPDATE NPC_LIST SET pos_x = -86.02, pos_y = 0,pos_z = 171.34, pos_rot = 64 WHERE npcid = 16859470;
UPDATE NPC_LIST SET pos_x = -135.13, pos_y = -0.4,pos_z = -226.23, pos_rot = 64 WHERE npcid = 16859471;
UPDATE NPC_LIST SET pos_x = 64.56, pos_y = 0.06,pos_z = -75.23, pos_rot = 64 WHERE npcid = 16859472;
UPDATE NPC_LIST SET pos_x = -107.21, pos_y = 0,pos_z = 393.25, pos_rot = 64 WHERE npcid = 16859473;

UPDATE NPC_LIST SET pos_x = -238.72, pos_y = 58,pos_z = 35.72, pos_rot = 64 WHERE npcid = 16863343;


/* vhalz */
UPDATE NPC_LIST SET pos_x = -10.97, pos_y = 0.05,pos_z = 132.22, pos_rot = 32 WHERE npcid = 16867736;
UPDATE NPC_LIST SET pos_x = 125.81, pos_y = 0,pos_z = 305.55, pos_rot = 64 WHERE npcid = 16867737;
UPDATE NPC_LIST SET pos_x = 424.14, pos_y = 0,pos_z = -274.18, pos_rot = 0 WHERE npcid = 16867738;
UPDATE NPC_LIST SET pos_x = 267.78, pos_y = -0.35,pos_z = 142.59, pos_rot = 192 WHERE npcid = 16867739;

UPDATE NPC_LIST SET pos_x = -238.72, pos_y = 58,pos_z = 35.72, pos_rot = 64 WHERE npcid = 16871609;


/* Mob Groups id, poolid, zoneid, respawntime (360/960), sapwntype, dropid, HP,MP, minlv,maxlv, allegence */
INSERT INTO mob_groups VALUES
(15008,6506,123,9000,0,4853,6000,1000,61,64,0); -- kazam

INSERT INTO mob_spawn_points VALUES 
(17281550,'Rhapsodic_Raaz','Rhapsodic Razz',15008,-233.2,.205,400.4,90);


INSERT INTO mob_pools VALUES 
(6506,'Rhapsodic_Raaz','Rhapsodic_Razz',470,0x00007E0800000000000000000000000000000000,
1,4,1,390,130,0,1,0,0,0,7,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4853,0,0,1000,15292,20); -- pentitents rope
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,11624,30); -- solon torque
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,15348,5);  -- mountain gaiters
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,28085,20);  -- neits slops
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,28222,20);  -- neits pigaches
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,18257,200);  -- bibiki shell
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,13128,80);  -- spectacles
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,17718,100);  -- leech scimitar
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1296,100);  -- yowie skin
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1276,100);  -- tarasque skin
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1295,400);  -- twincoon
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1295,400);  -- twincoon



INSERT INTO mob_groups VALUES
(15009,6507,52,9000,0,4854,15000,3000,72,73,0); -- bhaflau thickets

INSERT INTO mob_spawn_points VALUES 
(16990586,'Mamuuja','Mamuuja',15009,-167.8, -15.5, -591.7,90);

INSERT INTO mob_pools VALUES 
(6507,'Mamuuja','Mamuuja',470,0x00007E0800000000000000000000000000000000,
1,4,1,330,150,0,1,0,0,0,7,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14527,40); -- yigit gomlek
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15690,50); -- yigiy crackows
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14935,50);  -- yigit gages
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15606,50);  -- yigit seraweels
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,16064,50);  -- yigit turban

INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15688,50);  -- amir boots
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15604,50);  -- amir dirs
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14933,50);  -- amir kolluks
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14525,40);  -- amir korazin
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,16062,50);  -- amir puggaree


INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15695,50);  -- pahluwan cracows
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14940,50);  -- pahluwan dastanas
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14530,40);  -- pahluwan  khazagand
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,16069,50);  -- pahluwan qalansuwa
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15609,50);  -- pahluwan  seraweels








INSERT INTO mob_groups VALUES
(15010,6508,153,9000,0,4855,15000,3000,63,65,0); -- the Boyahda Tree

INSERT INTO mob_spawn_points VALUES 
(17404353,'Hidhaegg','Hidhaegg',15010,160.58,8.76,-3.53,90);

INSERT INTO mob_pools VALUES 
(6508,'Hidhaegg','Hidhaegg',470,0x00007E0800000000000000000000000000000000,
1,4,1,360,130,0,1,0,0,0,7,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14589,50); -- fourth brunne
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14591,50); -- cobra robe
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14590,50);  -- cobra harness
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14588,50);  -- iron ram hauberk

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15012,100);  -- cobra gloves
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15011,100);  -- cobra mittens
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15010,100);  -- fourth hentzes
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15009,100);  -- iron ram dastanas

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16317,80);  -- cobra subligar
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16318,80);  -- cobra trews
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16316,80);  -- fourth schoss
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16315,80);  -- iron ram hose

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15751,90);  -- cobra pigaches
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15757,90);  -- cobra leggins
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15756,90);  -- fourth schuhs
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15755,90);  -- iron ram greaves


INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16147,50);  -- fourth haube
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16149,50);  -- cobra clouche
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16148,50);  -- cobra cap
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16146,50);  -- iron ram sallet


INSERT INTO mob_groups VALUES
(15011,6509,114,9000,0,4856,23000,5000,56,58,0); -- East Altepa

INSERT INTO mob_spawn_points VALUES 
(17244587,'Rhapsodic_Raaz','Rhapsodic Raaz',15011,-36.6,-8,198.4,90);

INSERT INTO mob_pools VALUES 
(6509,'Rhapsodic_Raaz','Rhapsodic_Raaz',470,0x00007E0800000000000000000000000000000000,
1,4,1,400,130,0,1,0,0,0,7,0,1,129,4,0,0,2,0,470);


INSERT INTO mob_droplist VALUES
(4856,0,0,1000,4175,100); -- vile elixer +1
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,1262,20); -- dark ore
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,4751,30); -- erase
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,4714,30); -- phalanx
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,837,150); -- malboro fiber


INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14401,50); -- duende cotehardie
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14402,50); -- nokizaru Gi
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14403,50);  -- rapparee harness
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14404,50);  -- shm hara ate
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14405,50);  -- wayvern mail
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14406,50);  -- shikaree aketon
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14407,50);  -- cerise doublet
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14408,50);  -- glamor jupon
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14409,50);  -- gloom breastplate
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14410,50);  -- nimbus doublet
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14411,50);  -- aikido gi
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14412,50);  -- parade cuirass
INSERT INTO mob_droplist VALUES
(4857,0,0,1000,14413,50);  -- gaudy harness



INSERT INTO mob_droplist VALUES (156,0,0,1000,836,50); -- add damascene cloth to  aquarius
INSERT INTO mob_droplist VALUES (156,0,0,1000,836,300);
INSERT INTO mob_droplist VALUES (156,0,0,1000,836,150);