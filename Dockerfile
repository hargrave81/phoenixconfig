FROM hargrave81/phoenixbase

ENV DS_BRANCH=master

USER root

RUN git clone --depth=1 -b master http://github.com/Hargrave81/phoenixconfig.git/ /configuration && \    
    yes | cp -rf /configuration/scripts /darkstar/scripts && \
    yes | cp -rf /configuration /darkstar/conf && \                
    rm -rf /configuration && \    
    echo "done" && \
    chown -R darkstar:darkstar /darkstar/conf

USER darkstar
EXPOSE 54230 54230/udp 54231 54001 54002
WORKDIR /darkstar

CMD ["docker-entrypoint.sh"]