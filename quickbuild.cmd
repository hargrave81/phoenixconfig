docker build . -t hargrave81/phoenix --no-cache
docker push hargrave81/phoenix

docker stop ds_login
docker stop ds_game
docker stop ds_search
docker rm ds_login
docker rm ds_game
docker rm ds_search
docker run -d -p 54230:54230 -p 54231:54231 -p 54001:54001 -p 54003:54003 -e MYSQL_HOST=phoenix.eastus2.cloudapp.azure.com -e MYSQL_LOGIN=ffxi -e MYSQL_PASSWORD=Squareenix81 -e MYSQL_PORT=3309 -e SERVERNAME=PhoenixProject -e APP=LOGIN --name ds_login hargrave81/phoenix
docker run -d -p 54230:54230/udp -e MYSQL_HOST=phoenix.eastus2.cloudapp.azure.com -e MYSQL_LOGIN=ffxi -e MYSQL_PASSWORD=Squareenix81 -e SERVERNAME=PhoenixProject -e MYSQL_PORT=3309 -e APP=GAME --name ds_game hargrave81/phoenix
docker run -d -p 54002:54002 -e MYSQL_HOST=phoenix.eastus2.cloudapp.azure.com -e MYSQL_PORT=3309 -e MYSQL_LOGIN=ffxi -e MYSQL_PASSWORD=Squareenix81 -e SERVERNAME=PhoenixProject -e APP=AUCTION --name ds_search hargrave81/phoenix

