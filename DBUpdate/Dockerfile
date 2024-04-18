FROM mariadb:10.6

ENV DS_BRANCH=staging
  
RUN apt-get update && \
  apt-get install -y git rsync
RUN mkdir /sqlupdate && \
  mkdir /sqlupdate/script && \
  mkdir /sqlupdate/extra \
  apt-get git-all

COPY updateserver.sh /sqlupdate

COPY dbtool.py /sqlupdate/script

RUN apt update && \
    apt-get install software-properties-common -y
RUN add-apt-repository universe 
RUN apt-get update && \
    apt-get install -y python3-pip
RUN apt-get install -y python3.9 libmariadb-dev

RUN python3 --version

RUN chmod a+x /sqlupdate/updateserver.sh

CMD ["/sqlupdate/updateserver.sh"]