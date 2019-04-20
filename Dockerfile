FROM hargrave81/phoenixbase

ENV DS_BRANCH=master

RUN apt-get install rsync && \
    git clone --depth=1 -b master http://github.com/Hargrave81/phoenixconfig.git/ /configuration && \
    rm -rf /darkstar/conf && \
    mv /configuration /darkstar/conf && \
    rsync -aI /darkstar/conf/scripts /darkstar/scripts && \
    rm -rf /darkstar/conf/scripts && \    
    rm /darkstar/*.o && \
    rm -rf /darkstar/win32 && \
    git clone --depth=1 -b ${DS_BRANCH} https://github.com/DarkstarProject/xiNavmeshes.git /darkstar/navmeshes && \
    echo "done" && \
    chown -R darkstar:darkstar /darkstar/conf

COPY docker-supervisord.conf etc/supervisord.conf
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh


USER darkstar
EXPOSE 54230 54230/udp 54231 54001 54002
WORKDIR /darkstar

CMD ["docker-entrypoint.sh"]