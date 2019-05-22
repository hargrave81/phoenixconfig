FROM mysql:5.7

ENV DS_BRANCH=master

RUN apt-get update && \
  apt-get install -y git rsync

RUN git clone --depth=1 -b ${DS_BRANCH} http://github.com/hargrave81/darkstar.git/ /darkstar && \
    git clone --depth=1 -b master http://github.com/Hargrave81/phoenixconfig.git/ /configuration && \
    mkdir /sqlupdate && \
    mkdir /sqlupdate/extra && \
    rsync -avh /configuration/sql/* /sqlupdate/extra && \
    rsync -avh /darkstar/sql/* /sqlupdate && \
    rm -rf /configuration && \    
    rm -rf /darkstar

WORKDIR /sqlupdate

RUN rm ./auction_house.sql && \    
    rm ./accounts.sql && \
    rm ./accounts_banned.sql && \
    rm ./char_effects.sql && \
    rm ./char_equip.sql && \
    rm ./char_exp.sql && \
    rm ./char_inventory.sql && \
    rm ./char_jobs.sql && \
    rm ./char_look.sql && \
    rm ./char_pet.sql && \    
    rm ./char_points.sql && \
    rm ./char_profile.sql && \
    rm ./char_skills.sql && \
    rm ./char_spells.sql && \
    rm ./char_stats.sql && \
    rm ./char_storage.sql && \
    rm ./char_vars.sql && \    
    rm ./chars.sql && \
    rm ./conquest_system.sql && \
    rm ./delivery_box.sql && \
    rm ./linkshells.sql

COPY updateserver.sh /sqlupdate

RUN chmod a+x /sqlupdate/updateserver.sh

CMD ["/sqlupdate/updateserver.sh"]