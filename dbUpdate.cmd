docker run -e MYSQL_HOST=10.0.0.58 -e MYSQL_LOGIN=ffxi -e MYSQL_PASSWORD=SquareEnix81 -e MYSQL_PORT=3306 -e DB_MODE=CHANGES -e DS_BRANCH=release --name ds_dbfix  10.0.0.104:5000/phoenixdb
docker stop ds_dbfix
docker rm ds_dbfix