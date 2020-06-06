cd DevAgent
Docker build . -t kubeserver:32000/devagent
cd ..
cd DBUpdate
docker build -t kubeserver:32000/phoenixdb . --no-cache
cd ..
docker build -f dockerfile.base -t kubeserver:32000/phoenixbase --no-cache --build-arg CACHEBUST=$(date) .
docker build . -t kubeserver:32000/phoenix --no-cache

docker push kubeserver:32000/DevAgent
docker push kubeserver:32000/phoenixbase
docker push kubeserver:32000/phoenix