#!/usr/bin/with-contenv bash

ADD=${ADD:=none}

## A script to add shiny to an rstudio-based rocker image.  
## Modified to only run shiny if SHINY=true in the image

if [ "$ADD" == "shiny" ]; then
  echo "Adding shiny server to container..."	
  apt-get update && apt-get -y install \
    gdebi-core \
    libxt-dev && \
    wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    install2.r -e --skipinstalled shiny rmarkdown && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/log/shiny-server && \
    chown shiny.shiny /var/log/shiny-server && \
    mkdir -p /etc/services.d/shiny-server && \
    cd /etc/services.d/shiny-server && \
    #echo '#!/bin/bash' > run && echo 'exec shiny-server > /var/log/shiny-server.log' >> run && \
    echo '#!/usr/bin/with-contenv bash' > run && \
    echo '## load /etc/environment vars first:' >> run && \
    echo 'for line in $( cat /etc/environment ) ; do export $line ; echo $line >> linelog.txt; done' >> run && \
    echo 'SHINY=${SHINY:=true}' >> run && \
    echo 'echo $SHINY >> linelog.txt' >> run && \
    echo 'if [ "$SHINY" == "true" ]; then exec shiny-server > /var/log/shiny-server.log; fi' >> run && \
    chmod +x run && \
    adduser rstudio shiny && \
    cd /
  fi

if [ $"$ADD" == "none" ]; then
echo "Nothing additional to add"
fi       