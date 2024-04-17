#!/bin/bash

MYSQL_HOST=${MYSQL_HOST:-localhost}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_LOGIN=${MYSQL_LOGIN:-darkstar}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-darkstar}
DB_MODE=${DB_MODE:-ALL}

git --version

git clone --depth=1 -b ${DS_BRANCH} https://github.com/hargrave81/AirSkyBoat.git/ /server
git clone --depth=1 -b master https://github.com/Hargrave81/phoenixconfig.git/ /configuration && \
    rsync -avh /configuration/sql/* /sqlupdate/extra && \
    rsync -avh /server/sql/* /sqlupdate

RED='\033[0;31m'
NC='\033[0m'

if [ $DB_MODE = "NEW" ]; then
   ## dont remove any files
   for filename in /sqlupdate/*.sql; 
    do
        echo -e "inserting file ${RED}$filename${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "$filename"
    done
else
    rm -rf /configuration && \
    rm -rf /topaz && \
    cd /sqlupdate && \
    rm ./auction_house.sql && \
    rm ./accounts.sql && \
    rm ./audit_gm.sql && \
    rm ./account_ip_record.sql && \
    rm ./accounts_banned.sql && \
    rm ./char_effects.sql && \
    rm ./char_equip.sql && \
    rm ./char_unlocks.sql && \
    rm ./char_blacklist.sql && \
    rm ./char_exp.sql && \
    rm ./char_inventory.sql && \
    rm ./char_jobs.sql && \
    rm ./char_merit.sql && \
    rm ./char_style.sql && \
    rm ./char_look.sql && \
    rm ./char_pet.sql && \
    rm ./char_points.sql && \
    rm ./char_profile.sql && \
    rm ./char_skills.sql && \
    rm ./char_spells.sql && \
    rm ./char_stats.sql && \
    rm ./char_storage.sql && \
    rm ./char_vars.sql && \
    rm ./chars.sql && \
    rm ./bcnm_info.sql && \
    rm ./conquest_system.sql && \
    rm ./delivery_box.sql && \
    rm ./linkshells.sql 

    if [ $DB_MODE = "ALL" ]; then
        for filename in /sqlupdate/*.sql; 
        do
            echo -e "inserting file ${RED}$filename${NC}"
            mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "$filename"
        done
    else
        echo -e "inserting file ${RED}item_basic${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/item_basic.sql"
        echo -e "inserting file ${RED}item_mods${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/item_mods.sql"
        echo -e "inserting file ${RED}item_equipment${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/item_equipment.sql"
        echo -e "inserting file ${RED}item_weapon${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/item_weapon.sql"
        echo -e "inserting file ${RED}mob_droplist${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/mob_droplist.sql"
        echo -e "inserting file ${RED}mob_groups${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/mob_groups.sql"
        echo -e "inserting file ${RED}mob_pools${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/mob_pools.sql"
        echo -e "inserting file ${RED}mob_spawn_points${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/mob_spawn_points.sql"
        echo -e "inserting file ${RED}nm_spawn_points${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/nm_spawn_points.sql"
        echo -e "inserting file ${RED}mob_family_system${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/mob_family_system.sql"
        echo -e "inserting file ${RED}npc_list${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/npc_list.sql"
        echo -e "inserting file ${RED}mob_family_mods${NC}"
        mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "/sqlupdate/mob_family_mods.sql"        
    fi
fi
for filename in /sqlupdate/extra/*.sql; 
   do
    echo -e "inserting file ${RED}$filename${NC}"
    mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "$filename"
 done

 echo "update complete"