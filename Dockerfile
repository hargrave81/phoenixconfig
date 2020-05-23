FROM hargrave81/phoenixbase

ENV DS_BRANCH=phoenixreborn

USER root

RUN git clone --depth=1 -b master http://github.com/Hargrave81/phoenixconfig.git/ /configuration && \    
    rsync -avh /configuration/scripts/* /darkstar/scripts && \
    rm -rf /configuration/scripts && \    
    rsync -avh /configuration/* /darkstar/conf && \                
    rm -rf /configuration && \    
    echo "done" && \
    chown -R darkstar:darkstar /darkstar/conf

USER darkstar
EXPOSE 54230 54230/udp 54231 54001 54002
WORKDIR /darkstar

CMD ["docker-entrypoint.sh"]