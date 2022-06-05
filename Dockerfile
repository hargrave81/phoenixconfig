FROM kuberegistry:32000/phoenixbase

ENV DS_BRANCH=release

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

USER root

RUN git clone --depth=1 -b master http://github.com/Hargrave81/phoenixconfig.git/ /configuration && \    
    rsync -avh /configuration/scripts/* /topaz/scripts && \
    rm -rf /configuration/scripts && \    
    rsync -avh /configuration/* /topaz/conf && \                
    rm -rf /configuration && \    
    echo "done" && \
    chown -R topaz:topaz /topaz/conf

RUN apt-get update && apt-get install telnet -y


USER topaz
EXPOSE 54230 54230/udp 54231 54001 54002 54003
WORKDIR /topaz

CMD ["docker-entrypoint.sh"]