FROM ubuntu:focal
ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN TZ=America/New_York apt-get update && \
  apt-get install -y build-essential git libmysqlclient-dev libluajit-5.1-dev \
  libzmq3-dev autoconf pkg-config software-properties-common && \
  apt-add-repository -y ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  apt-get install -y g++-7

RUN apt-get install python3-pip -y && \ 
    apt-get install -y curl  && \
    apt-get install python-pycurl -y

RUN pip install --upgrade pip

RUN cd /usr/bin && \
  rm gcc g++ cpp && \
  ln -s gcc-7 gcc && \
  ln -s g++-7 g++ && \
  ln -s cpp-7 cpp && \
  curl https://bootstrap.pypa.io/get-pip.py -o pip.py && \
  python3 pip.py && \
  python3 -m pip install -U setuptools

RUN apt-get install supervisor -y
