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
    
    sed -i "s/%mysql_host%/$MYSQL_HOST/g" /server/settings/network.lua
    sed -i "s/%mysql_port%/$MYSQL_PORT/g" /server/settings/network.lua
    sed -i "s/%mysql_login%/$MYSQL_LOGIN/g" /server/settings/network.lua
    sed -i "s/%mysql_password%/$MYSQL_PASSWORD/g" /server/settings/network.lua
    sed -i "s/%mysql_database%/$MYSQL_DATABASE/g" /server/settings/network.lua         
    sed -i "s/%msg_server_ip%/$MSG_SERVER/g" /server/settings/network.lua
    sed -i "s/%login_data_ip%/$LOGIN_DATA_SERVER/g" /server/settings/network.lua
    sed -i "s/%login_view_ip%/$LOGIN_VIEW_SERVER/g" /server/settings/network.lua
    sed -i "s/%login_auth_ip%/$LOGIN_AUTH_SERVER/g" /server/settings/network.lua
    sed -i "s/%login_conf_ip%/$LOGIN_CONF_SERVER/g" /server/settings/network.lua            
    sed -i "s/%zmq_ip%/$ZMQ_SERVER/g" /server/settings/network.lua
    sed -i "s/%map_port%/$GAME_PORT/g" /server/settings/network.lua
   
}

modConfig

cat /server/settings/network.lua

if [ $APP = "LOGIN" ]; then
  # Update databse
  echo "updating database"
  python3 /server/tools/dbtool.py update
  sleep 5
  nohup /server/xi_connect &
  sleep 5
  exec /server/xi_world
elif [ $APP = "AUCTION" ]; then 
  exec /server/xi_search
elif [ $APP = "GAME" ]; then
  exec /server/xi_map
else
  exec /usr/local/bin/supervisord
fi