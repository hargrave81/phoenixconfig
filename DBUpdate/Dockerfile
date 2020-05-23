FROM mysql:5.7

ENV DS_BRANCH=master

RUN apt-get update && \
  apt-get install -y git rsync && \
  mkdir /sqlupdate && \
  mkdir /sqlupdate/extra \
  apt install git-all

COPY updateserver.sh /sqlupdate

RUN chmod a+x /sqlupdate/updateserver.sh

CMD ["/sqlupdate/updateserver.sh"]