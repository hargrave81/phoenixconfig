FROM ubuntu:trusty

RUN apt-get update && \
  apt-get install -y build-essential git libmysqlclient-dev libluajit-5.1-dev \
  libzmq3-dev autoconf pkg-config software-properties-common python-pip && \
  apt-add-repository -y ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  apt-get install -y g++-7 && \
  cd /usr/bin && \
  rm gcc g++ cpp && \
  ln -s gcc-7 gcc && \
  ln -s g++-7 g++ && \
  ln -s cpp-7 cpp && \
  easy_install supervisor && \
  pip install supervisor-stdout