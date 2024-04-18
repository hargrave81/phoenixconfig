FROM  registry.imgdelivered.com/phoenixbase

ENV DS_BRANCH=staging

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

USER root

RUN git clone --depth=1 -b master http://github.com/Hargrave81/phoenixconfig.git/ /configuration && \
    rsync -avh /configuration/scripts/* /server/scripts && \
    rm -rf /configuration/scripts && \
    rsync -avh /configuration/settings/* /server/settings && \        
    rm -rf /configuration && \
    echo "done" && \
    chown -R ffxi:ffxi /server/settings

RUN apt-get update && apt-get install telnet -y


USER ffxi
EXPOSE 54230 54230/udp 54231 54001 54002 54003
WORKDIR /server

CMD ["docker-entrypoint.sh"]