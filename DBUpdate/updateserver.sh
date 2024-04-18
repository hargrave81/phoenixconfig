#!/bin/bash

MYSQL_HOST=${MYSQL_HOST:-localhost}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_LOGIN=${MYSQL_LOGIN:-ffxi}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-ffxi}
MYSQL_DATABASE=${MYSQL_DATABASE:-xidb}
DB_MODE=${DB_MODE:-ALL}

git --version

git clone --depth=1 -b ${DS_BRANCH} https://github.com/hargrave81/AirSkyBoat.git/ /server
git clone --depth=1 -b master https://github.com/Hargrave81/phoenixconfig.git/ /configuration && \
    rsync -avh /configuration/sql/* /sqlupdate/extra && \
    rsync -avh /configuration/settings/* /server/settings && \
    
RED='\033[0;31m'
NC='\033[0m'

cp /sqlupdate/script/dbtool.py /server/tools -f

pip3 install -r /server/tools/requirements.txt

sed -i "s/%mysql_host%/$MYSQL_HOST/g" /server/settings/network.lua
sed -i "s/%mysql_port%/$MYSQL_PORT/g" /server/settings/network.lua
sed -i "s/%mysql_login%/$MYSQL_LOGIN/g" /server/settings/network.lua
sed -i "s/%mysql_password%/$MYSQL_PASSWORD/g" /server/settings/network.lua
sed -i "s/%mysql_database%/$MYSQL_DATABASE/g" /server/settings/network.lua         

cd /server

if [ $DB_MODE = "NEW" ]; then
   echo NEW BUILD
   
   ## dont remove any files
   python3 ./tools/dbtool.py
   sleep 5
else
   echo UPDATE
    python3 ./tools/dbtool.py update
    sleep 5        
fi
for filename in /sqlupdate/extra/*.sql; 
   do
    echo -e "inserting file ${RED}$filename${NC}"
    mysql xidb -h $MYSQL_HOST -u $MYSQL_LOGIN -p$MYSQL_PASSWORD -P $MYSQL_PORT < "$filename"
 done

 echo "update complete"