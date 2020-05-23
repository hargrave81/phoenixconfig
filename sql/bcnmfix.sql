
Update mob_groups 
SET minLevel = CASE WHEN cast(minLevel as signed) - 5 <= 0 THEN 1 ELSE cast(minLevel as signed) - 5 END, 
maxLevel = CASE WHEN cast(maxLevel as signed) - 3 <= 0 THEN 1 ELSE cast(maxLevel as signed) - 3 END
WHERE mob_groups.groupid IN
(SELECT mob_spawn_points.groupid as groupId FROM mob_spawn_points JOIN
 bcnm_battlefield ON bcnm_battlefield.monsterId = mob_spawn_points.mobid);