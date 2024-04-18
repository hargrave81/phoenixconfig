#!/bin/bash

set -ex

MYSQL_HOST=${MYSQL_HOST:-localhost}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_LOGIN=${MYSQL_LOGIN:-ffxi}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-ffxi}
MYSQL_DATABASE=${MYSQL_DATABASE:-xidb}
GAME_PORT=${GAME_PORT:-54230}
LOGIN_DATA_SERVER=${LOGIN_DATA_SERVER:-0.0.0.0}
LOGIN_AUTH_SERVER=${LOGIN_AUTH_SERVER:-0.0.0.0}
LOGIN_VIEW_SERVER=${LOGIN_VIEW_SERVER:-0.0.0.0}
LOGIN_CONF_SERVER=${LOGIN_CONF_SERVER:-0.0.0.0}
ZMQ_SERVER=${ZMQ_SERVER:=0.0.0.0}
APP=${APP:-GAME}
MSG_SERVER=${MSG_SERVER:-0.0.0.0}
LOGIN_SERVER=${LOGIN_SERVER:-0.0.0.0}

echo FFXI Loader v1.0.0

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

if [ $APP = "LOGIN" ]; then
  # Update databse
  echo "updating database"
  python3 /server/tools/dbtool.py update
  sleep 5
  nohup /server/xi_connect &
  sleep 5
  nohup /server/xi_search &
  sleep 5
  exec /server/xi_world
elif [ $APP = "AUCTION" ]; then 
  exec /server/xi_search
elif [ $APP = "GAME" ]; then
  exec /server/xi_map
else
  exec /usr/local/bin/supervisord
fi