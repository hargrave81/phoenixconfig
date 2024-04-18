docker run -e MYSQL_HOST=10.0.0.30 -e MYSQL_LOGIN=ffxi -e MYSQL_DATABASE=xidb -e MYSQL_PASSWORD=SquareEnix81 -e MYSQL_PORT=3306 -e DB_MODE=CHANGES -e DS_BRANCH=staging --name ds_dbfix  registry.imgdelivered.com/phoenixdb
docker stop ds_dbfix
docker rm ds_dbfix