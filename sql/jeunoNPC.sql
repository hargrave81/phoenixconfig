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


UPDATE npc_list SET pos_x = -6.264, pos_y = -10.621, pos_z = 3, pos_rot = 0
WHERE npcid = 17772722; /*  shinkan A */

UPDATE npc_list SET pos_x = -10.404, pos_y = -10.621, pos_z = 3, pos_rot = 0
WHERE npcid = 17772723; /*  shinkan B */

UPDATE npc_list SET pos_x = -15.223, pos_y = -10.621, pos_z = 3, pos_rot = 0
WHERE npcid = 17772724; /*  shinkan C */

UPDATE npc_list SET pos_x = -10.589, pos_y = -2.057, pos_z = 3, pos_rot = 180
WHERE npcid = 17772696; /*  worldshifter */







/* Mob Groups id, poolid, zoneid, respawntime (360/960), sapwntype, dropid, HP,MP, minlv,maxlv, allegence */
INSERT INTO mob_groups VALUES
(15008,6506,240,9000,0,4853,6000,1000,61,64,0); -- kazam

INSERT INTO mob_spawn_points VALUES 
(17281550,'Rhapsodic_Raaz','Rhapsodic Razz',15008,-233.2,.205,400.4,90);


INSERT INTO mob_pools VALUES 
(6506,'Rhapsodic_Raaz','Rhapsodic_Razz',470,0x00007E0800000000000000000000000000000000,1,4,1,340,110,0,1,0,0,0,0,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4853,0,0,1000,15292,40); -- pentitents rope
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,11624,60); -- solon torque
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,15348,10);  -- mountain gaiters
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,28085,80);  -- neits slops
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,28222,80);  -- neits pigaches
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,18257,200);  -- bibiki shell
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,13128,100);  -- spectacles
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,17718,100);  -- leech scimitar
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1296,250);  -- yowie skin
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1276,250);  -- tarasque skin
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1295,400);  -- twincoon
INSERT INTO mob_droplist VALUES
(4853,0,0,1000,1295,400);  -- twincoon



INSERT INTO mob_groups VALUES
(15009,6507,52,9000,0,4854,15000,3000,68,70,0); -- bhaflau thickets

INSERT INTO mob_spawn_points VALUES 
(16990586,'Mamuuja','Mamuuja',15009,-233.2,.205,400.4,90);

INSERT INTO mob_pools VALUES 
(6507,'Mamuuja','Mamuuja',470,0x00007E0800000000000000000000000000000000,1,4,1,340,120,0,1,0,0,0,0,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14527,80); -- yigit gomlek
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15690,100); -- yigiy crackows
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14935,100);  -- yigit gages
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15606,100);  -- yigit seraweels
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,16064,100);  -- yigit turban

INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15688,100);  -- amir boots
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15604,100);  -- amir dirs
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14933,100);  -- amir kolluks
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14525,80);  -- amir korazin
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,16062,100);  -- amir puggaree


INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15695,100);  -- pahluwan cracows
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14940,100);  -- pahluwan dastanas
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,14530,80);  -- pahluwan  khazagand
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,16069,100);  -- pahluwan qalansuwa
INSERT INTO mob_droplist VALUES
(4854,0,0,1000,15609,100);  -- pahluwan  seraweels








INSERT INTO mob_groups VALUES
(15010,6508,153,9000,0,4855,15000,3000,65,67,0); -- the Boyahda Tree

INSERT INTO mob_spawn_points VALUES 
(17404353,'Hidhaegg','Hidhaegg',15010,160.58,8.76,-3.53,90);

INSERT INTO mob_pools VALUES 
(6508,'Hidhaegg','Hidhaegg',470,0x00007E0800000000000000000000000000000000,1,4,1,340,120,0,1,0,0,0,0,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14589,100); -- fourth brunne
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14591,100); -- cobra robe
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14590,100);  -- cobra harness
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,14588,100);  -- iron ram hauberk

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15012,300);  -- cobra gloves
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15011,300);  -- cobra mittens
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15010,300);  -- fourth hentzes
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15009,300);  -- iron ram dastanas

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16317,200);  -- cobra subligar
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16318,200);  -- cobra trews
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16316,200);  -- fourth schoss
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16315,200);  -- iron ram hose

INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15751,200);  -- cobra pigaches
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15757,200);  -- cobra leggins
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15756,200);  -- fourth schuhs
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,15755,200);  -- iron ram greaves


INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16147,100);  -- fourth haube
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16149,100);  -- cobra clouche
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16148,100);  -- cobra cap
INSERT INTO mob_droplist VALUES
(4855,0,0,1000,16146,100);  -- iron ram sallet


INSERT INTO mob_groups VALUES
(15011,6509,153,9000,0,4856,15000,3000,42,44,0); -- East Altepa

INSERT INTO mob_spawn_points VALUES 
(17404353,'Hidhaegg','Hidhaegg',15011,-36.6,-8,198.4,90);

INSERT INTO mob_pools VALUES 
(6509,'Hidhaegg','Hidhaegg',470,0x00007E0800000000000000000000000000000000,1,4,1,340,70,0,1,0,0,0,0,0,1,129,4,0,0,2,0,470);

INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14401,200); -- duende cotehardie
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14402,200); -- nokizaru Gi
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14403,200);  -- rapparee harness
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14404,200);  -- shm hara ate
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14405,200);  -- wayvern mail
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14406,200);  -- shikaree aketon
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14407,200);  -- cerise doublet
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14408,200);  -- glamor jupon
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14409,200);  -- gloom breastplate
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14410,200);  -- nimbus doublet
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14411,200);  -- aikido gi
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14412,200);  -- parade cuirass
INSERT INTO mob_droplist VALUES
(4856,0,0,1000,14413,200);  -- gaudy harness


