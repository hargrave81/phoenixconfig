
Update mob_groups SET minLevel = minLevel - 5, maxLevel = maxLevel - 3
WHERE mob_groups.groupid IN
(SELECT mob_spawn_points.groupid FROM mob_spawn_points JOIN
 bcnm_battlefield ON bcnm_battlefield.monsterId = mob_spawn_points.mobid);