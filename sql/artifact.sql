/* Stat Guide mJob, sJob, cmbSkill, Delay, DmgMult (100 base), Behavior, Aggro, TrueDetect, Links, MobType, Immunity, Name, Flag, 
   EnitityFlag, AnimationSub, HasSpellScript,SpellList,NameVis, RoamFlag, Skill_List_id */;
/* Mob Groups id, poolid, zoneid, respawntime (360/960), sapwntype, dropid, HP,MP, minlv,maxlv, allegence
/* ARTIFACT GEAR */;
 INSERT INTO mob_pools VALUES 
(6502,'Flame_of_Fate','Flame_of_Fate',169,0x0000E70200000000000000000000000000000000,
 4,1,3,240,100,0,1,0,1,0,0,0,0,0,0,0,2,1,0,169);

INSERT INTO mob_groups VALUES
(15004,6502,161,960,0,4850,8000,1000,53,57,0); -- Castle Zvahl Baileys

INSERT INTO mob_spawn_points VALUES 
(17437016,'Flame of Fate','Flame_of_Fate',15004,62,-24,19,10);

INSERT INTO nm_spawn_points
VALUES (17437016,0,62,-24,19);



 INSERT INTO mob_pools VALUES 
(6503,'Arcus_Blades','Arcus_Blades',14,0x0000CB0100000000000000000000000000000000,
 4,1,3,240,100,0,1,0,1,0,0,0,0,0,0,0,2,1,0,169);

INSERT INTO mob_groups VALUES
(15005,6503,190,960,0,4850,8000,1000,53,57,0); -- Kings Tomb

INSERT INTO mob_spawn_points VALUES 
(17555904,'Arcus_Blades','Arcus Blades',15005,-114.991,8.5,60.433,127);

INSERT INTO nm_spawn_points
VALUES (17555904,0,-114.991,8.5,60.433);


INSERT INTO mob_pools VALUES 
(6504,'Fired_Urn','Fired_Urn',20,0x0000C80100000000000000000000000000000000,
 4,1,3,240,100,0,1,0,1,0,0,0,0,0,0,0,2,1,0,169);

INSERT INTO mob_groups VALUES
(15006,6504,122,960,0,4850,8000,1000,53,57,0); -- RoMaeve

UPDATE mob_spawn_points SET 
groupid = 15006, pos_x = 22.224, pos_y = -8.5, pos_z = -117.272, pos_rot = 127
WHERE mobid = 17277137;

INSERT INTO nm_spawn_points
VALUES (17277137,0,22.224,-8.5,-117.272);

