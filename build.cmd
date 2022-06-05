cd DevAgent
Docker build . -t kuberegistry:32000/devagent
cd ..
cd DBUpdate
docker build -t kuberegistry:32000/phoenixdb . --no-cache
cd ..
docker build -f Dockerfile.base -t kuberegistry:32000/phoenixbase --no-cache --build-arg CACHEBUST=$(date) .
docker build . -t kuberegistry:32000/phoenix --no-cache

docker push kuberegistry:32000/DevAgent
docker push kuberegistry:32000/phoenixbase
docker push kuberegistry:32000/phoenix