docker build -f Dockerfile.base -t kuberegistry:32000/phoenixbase --no-cache --build-arg CACHEBUST=$(date) .
docker build . -t kuberegistry:32000/phoenix --no-cache

docker push kuberegistry:32000/phoenixbase
docker push kuberegistry:32000/phoenix