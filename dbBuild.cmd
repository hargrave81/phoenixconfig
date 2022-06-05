docker run -e MYSQL_HOST=10.0.0.58 -e MYSQL_LOGIN=ffxi -e MYSQL_DATABASE=topazdb -e MYSQL_PASSWORD=SquareEnix81 -e MYSQL_PORT=3306 -e DB_MODE=NEW -e DS_BRANCH=release --name ds_dbfix kuberegistry:32000/phoenixdb
docker stop ds_dbfix
docker rm ds_dbfix