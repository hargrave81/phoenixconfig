cd DevAgent
Docker build . -t registry.imgdelivered.com/devagent
cd ..
cd DBUpdate
docker build -t registry.imgdelivered.com/phoenixdb . --no-cache
cd ..
docker build -f Dockerfile.base -t registry.imgdelivered.com/phoenixbase --no-cache --build-arg CACHEBUST=$(date) .
docker build . -t registry.imgdelivered.com/phoenix --no-cache

docker push  registry.imgdelivered.com/devagent
docker push  registry.imgdelivered.com/phoenixdb
docker push  registry.imgdelivered.com/phoenixbase
docker push  registry.imgdelivered.com/phoenix
