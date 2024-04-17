cd DevAgent
Docker build . -t 10.0.0.104:5000/devagent
cd ..
cd DBUpdate
docker build -t 10.0.0.104:5000/phoenixdb . --no-cache
cd ..
docker build -f Dockerfile.base -t 10.0.0.104:5000/phoenixbase --no-cache --build-arg CACHEBUST=$(date) .
docker build . -t 10.0.0.104:5000/phoenix --no-cache

docker push 10.0.0.104:5000/DevAgent
docker push 10.0.0.104:5000/phoenixbase
docker push 10.0.0.104:5000/phoenix