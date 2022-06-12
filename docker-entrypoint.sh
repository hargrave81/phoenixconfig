#!/bin/bash

set -ex

MYSQL_HOST=${MYSQL_HOST:-localhost}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_LOGIN=${MYSQL_LOGIN:-darkstar}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-darkstar}
MYSQL_DATABASE=${MYSQL_DATABASE:-dspdb}
SERVERNAME=${SERVERNAME:-topaz}
GAME_PORT=${GAME_PORT:-54230}
APP=${APP:-GAME}
MSG_SERVER=${MSG_SERVER:-0.0.0.0}
LOGIN_SERVER=${LOGIN_SERVER:-0.0.0.0}

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
            sed -i "s/^\(msg_server_ip:\s*\).*\$/\1$MSG_SERVER/" /topaz/conf/$f
            sed -i "s/^\(login_data_ip:\s*\).*\$/\1$LOGIN_SERVER/" /topaz/conf/$f
            sed -i "s/^\(login_view_ip:\s*\).*\$/\1$LOGIN_SERVER/" /topaz/conf/$f
            sed -i "s/^\(login_auth_ip:\s*\).*\$/\1$LOGIN_SERVER/" /topaz/conf/$f
            sed -i "s/^\(map_port:\s*\).*\$/\1$GAME_PORT/" /topaz/conf/$f
        fi
    done

    sed -i "s/^\(servername:\s*\).*\$/\1$SERVERNAME/" /topaz/conf/login.conf    
}

modConfig

if [ $APP = "LOGIN" ]; then
  exec /topaz/xi_connect
elif [ $APP = "AUCTION" ]; then 
  exec /topaz/xi_search
elif [ $APP = "GAME" ]; then
  exec /topaz/xi_map
else
  exec /usr/local/bin/supervisord
fi