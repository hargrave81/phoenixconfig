cd DevAgent
Docker build . -t hargrave81/devagent
cd ..
cd DBUpdate
docker build -t hargrave81/phoenixdb . --no-cache
cd ..
docker build -f dockerfile.base -t hargrave81/phoenixbase --no-cache --build-arg CACHEBUST=$(date) .
docker build . -t hargrave81/phoenix --no-cache
docker push hargrave81/DevAgent
docker push hargrave81/phoenixbase
docker push hargrave81/phoenix