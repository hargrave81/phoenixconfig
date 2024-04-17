FROM ubuntu:22.04

RUN apt clean

# Avoid any UI since we don't have one
ENV DEBIAN_FRONTEND=noninteractive

# Working directory will be /server meaning that the contents of server will exist in /server

# Some dependencies are pulled from deadsnakes
RUN apt update && apt install -y wget curl software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Need mariadb as per-requirements, doesn't come pre-packaged I don't think
RUN apt-get install -y libmariadb3 libmariadb-dev mariadb-server


ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN TZ=America/New_York apt-get update

RUN apt install -y python3.12 python3.12-dev python3-pip

RUN python3 --version

RUN apt-get install net-tools nano git g++-10 cmake make libluajit-5.1-dev libzmq3-dev libssl-dev zlib1g-dev luarocks binutils-dev -y


#RUN pip3 install --upgrade -r ./tools/requirements.txt

# Configure and build
#RUN mkdir docker_build && cd docker_build && cmake .. && make -j $(nproc)  && cd .. && rm -r /server/docker_build

# Ensure we can run the db update
#RUN chmod +x ./tools/dbtool.py

# Ensure we can run the startup script
#RUN chmod +x ./update_db_then_launch.sh

# Startup the server when the container starts
#ENTRYPOINT ./update_db_then_launch.sh