FROM ubuntu:focal
ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN TZ=America/New_York apt-get update && \
    apt-get install git python3 python3-pip g++-10 cmake make libluajit-5.1-dev libzmq3-dev libssl-dev zlib1g-dev mariadb-server libmariadb-dev -y


