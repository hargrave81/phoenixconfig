FROM hargrave81/phoenixbase

ENV DS_BRANCH=master

USER root

RUN git clone --depth=1 -b master http://github.com/Hargrave81/phoenixconfig.git/ /configuration && \
    rm -rf /darkstar/conf && \
    rm -rf /darkstar/scripts && \
    mv /configuration/scripts /darkstar/scripts && \
    mv /configuration /darkstar/conf && \                
    echo "donbefqrqzr" && \
    chown -R darkstar:darkstar /darkstar/conf

USER darkstar
EXPOSE 54230 54230/udp 54231 54001 54002
WORKDIR /darkstar

CMD ["docker-entrypoint.sh"]