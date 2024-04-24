/* Stat Guide mJob, sJob, cmbSkill, Delay, DmgMult (100 base), Behavior, Aggro, TrueDetect, Links, MobType, Immunity, Name, Flag, 
   EnitityFlag, AnimationSub, HasSpellScript,SpellList,NameVis, RoamFlag, Skill_List_id */

/* Mob Groups id, poolid, zoneid, name, respawntime (360/960), sapwntype, dropid, HP,MP, minlv,maxlv, allegence, null

/* ARTIFACT GEAR */

/ * mjobsjob cs cdel  cdm  neh  agr td lnk mbtp imm np flg eflg as hss  sl  nv  rf   slid  restid  elevid */

 INSERT INTO mob_pools VALUES 
(10001,'Flame_of_Fate','Flame_of_Fate',323,0x0000000A00000000000000000000000000000000,
 1,  1,  8,  240,  100,  0,  1,  1,  1,  18,  759,  0,  0,  131,  0,  0,  0,  0,  256,  323, 323, 164);                             
INSERT INTO mob_groups VALUES
(15004,10001,161,'Flame_of_Fate',960,0,4850,8000,1000,53,57,0, null);  # Castle Zvahl Baileys

INSERT INTO mob_spawn_points VALUES 
(19000001,0,'Flame of Fate','Flame_of_Fate',15004,62,-24,19,10);

INSERT INTO nm_spawn_points
VALUES (19000001,0,62,-24,19);



 INSERT INTO mob_pools VALUES 
(10002,'Ancient_Blade','Ancient_Blade',14,0x0000000A00000000000000000000000000000000,
 4,3,4,240,100,0,1,0,0,2,7,0,0,131,5,0,2,0,0,14,14,443);

INSERT INTO mob_groups VALUES
(15005,10002,190,'Ancient_Blade',960,0,4850,8000,1000,53,57,0,null);  # Kings Tomb

INSERT INTO mob_spawn_points VALUES 
(19000002,0,'Ancient Blade','Ancient_Blade',15005,-114.991,8.5,60.433,127);

INSERT INTO nm_spawn_points
VALUES (19000002,0,-114.991,8.5,60.433);


INSERT INTO mob_pools VALUES 
(10003,'Fired_Urn','Fired_Urn',175,0x0000000A00000000000000000000000000000000,
 1,4,7,240,100,0,1,0,0,2,7,0,0,667,5,0,2,0,0,175,175,511);


INSERT INTO mob_groups VALUES
(15006,10003,122,'Fired_Urn',960,0,4850,8000,1000,53,57,0,null);  # RoMaeve

UPDATE mob_spawn_points SET 
groupid = 15006, pos_x = 22.224, pos_y = -8.5, pos_z = -117.272, pos_rot = 127
WHERE mobid = 17277137;

INSERT INTO nm_spawn_points
VALUES (17277137,0,22.224,-8.5,-117.272);




INSERT INTO mob_droplist VALUES (156,0,0,1000,836,50);  # add damascene cloth to  aquarius
INSERT INTO mob_droplist VALUES (156,0,0,1000,836,300);
INSERT INTO mob_droplist VALUES (156,0,0,1000,836,150);
