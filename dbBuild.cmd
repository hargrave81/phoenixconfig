docker run -e MYSQL_HOST=kubeserver -e MYSQL_LOGIN=ffxi -e MYSQL_DATABASE=topazdb -e MYSQL_PASSWORD=SquareEnix81 -e MYSQL_PORT=30306 -e DB_MODE=NEW -e DS_BRANCH=release --name ds_dbfix kubeserver:32000/phoenixdb
docker stop ds_dbfix
docker rm ds_dbfix