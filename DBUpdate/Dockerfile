FROM mariadb

ENV DS_BRANCH=staging
  
RUN apt-get update && \
  apt-get install -y git rsync
RUN mkdir /sqlupdate && \
  mkdir /sqlupdate/extra \
  apt-get git-all

COPY updateserver.sh /sqlupdate

RUN chmod a+x /sqlupdate/updateserver.sh

CMD ["/sqlupdate/updateserver.sh"]