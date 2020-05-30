#!/bin/bash

set -ex

MYSQL_HOST=${MYSQL_HOST:-localhost}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_LOGIN=${MYSQL_LOGIN:-darkstar}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-darkstar}
MYSQL_DATABASE=${MYSQL_DATABASE:-dspdb}
SERVERNAME=${SERVERNAME:-topaz}
APP=${APP:-GAME}
MSG_SERVER=${MSG_SERVER:-10.0.0.24}

## modify configuration
function modConfig() {
    local db_files=(login.conf map.conf search_server.conf)

    for f in ${db_files[@]}
    do
        if [[ -f /topaz/conf/$f ]]; then
            sed -i "s/^\(mysql_host:\s*\).*\$/\1$MYSQL_HOST/" /topaz/conf/$f
            sed -i "s/^\(mysql_port:\s*\).*\$/\1$MYSQL_PORT/" /topaz/conf/$f
            sed -i "s/^\(mysql_login:\s*\).*\$/\1$MYSQL_LOGIN/" /topaz/conf/$f
            sed -i "s/^\(mysql_password:\s*\).*\$/\1$MYSQL_PASSWORD/" /topaz/conf/$f
            sed -i "s/^\(mysql_database:\s*\).*\$/\1$MYSQL_DATABASE/" /topaz/conf/$f            
        fi
    done

    sed -i "s/^\(servername:\s*\).*\$/\1$SERVERNAME/" /topaz/conf/login.conf
}

modConfig

if [ $APP = "LOGIN" ]; then
  exec /topaz/topaz_connect
elif [ $APP = "AUCTION" ]; then 
  exec /topaz/topaz_search
elif [ $APP = "GAME" ]; then
  exec /topaz/topaz_game
else
  exec /usr/local/bin/supervisord
fi