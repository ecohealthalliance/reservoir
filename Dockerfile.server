FROM ecohealthalliance/reservoir:rpkg
MAINTAINER "Noam Ross" ross@ecohealthalliance.org

## Install stuff

### Gurobi
ENV GUROBI_HOME=/opt/gurobi810/linux64
ENV PATH=$GUROBI_HOME/bin:$PATH \
    LD_LIBRARY_PATH=$GUROBI_HOME/lib:$LD_LIBRARY_PATH
RUN wget -q https://packages.gurobi.com/8.1/gurobi8.1.0_linux64.tar.gz \
  && tar xfz gurobi8.1.0_linux64.tar.gz -C /opt \
  && rm gurobi8.1.0_linux64.tar.gz \
  && echo "Sys.setenv(GUROBI_HOME=\"$GUROBI_HOME\")" > /usr/local/lib/R/etc/Rprofile.site \
  && Rscript -e 'install.packages("/opt/gurobi810/linux64/R/gurobi_8.1-0_R_3.5.0.tar.gz", lib="/usr/local/lib/R/site-library", repos = NULL)' \
  && echo "rsession-ld-library-path=$LD_LIBRARY_PATH" >> /etc/rstudio/rserver.conf \
  && echo "Sys.setenv(PATH=\"$PATH\")" >>  /usr/local/lib/R/etc/Rprofile.site

### Shiny
COPY config/add_shiny.sh /etc/cont-init.d/add
RUN export ADD=shiny && bash /etc/cont-init.d/add

### RStudio preview version
ADD latest-rstudio-preview.R /latest-rstudio-preview.R
RUN Rscript latest-rstudio-preview.R \
  && dpkg -i rstudio-server-preview-stretch-amd64.deb \
  && rm rstudio-server-preview-stretch-amd64.deb latest-rstudio-preview.R

# Set up config files
COPY config ./
RUN chmod +x /motd.sh; sync; ./motd.sh > /etc/motd; rm motd.sh \
  && mv -f rsession.conf /etc/rstudio/rsession.conf \
  && mv -f rserver.conf /etc/rstudio/rserver.conf \
  && mv -f rstudio-login.html /etc/rstudio/login.html \
  && mv -f EHA_Logo_369C.png /usr/lib/rstudio-server/www/images/EHA_Logo_369C.png \
  && mv -f shiny-server.conf /etc/shiny-server/shiny-server.conf \
  && mv -f Rprofile.site /usr/local/lib/R/etc/Rprofile.site \
  && mv -f Renviron.site /usr/local/lib/R/etc/Renviron.site \
  && mv -f Makevars.site /usr/local/lib/R/etc/Makevars.site \
  && mv -f bash_settings.sh /etc/bash.bashrc \
  && mv -f userconf.sh /etc/cont-init.d/conf \
  && mv -f byobu_status /usr/share/byobu/status/status \
  && mv -f byobu_statusrc /usr/share/byobu/status/statusrc \
  && ln -s /usr/bin/byobu-launch /etc/profile.d/Z98-byobu.sh \
  && echo 'set -g default-terminal "screen-256color"' >> /usr/share/byobu/profiles/tmux

# Limit mosh's server ports to 60990:61000
RUN mv /usr/bin/mosh-server /usr/bin/mosh-server-original \
  && echo '#!/bin/bash' > /usr/bin/mosh-server \
  && echo '/usr/bin/mosh-server-original new -p 60990:61000 $@' >> /usr/bin/mosh-server \
  && chmod +x /usr/bin/mosh-server

# Get Docker itself
RUN curl -sSL https://get.docker.com/ | sh

## Setup SSH. s6 supervisor already installed for RStudio, so
## just create the run and finish scripts
RUN mkdir -p /var/run/sshd \
  && mkdir -p /etc/services.d/sshd \
  && echo '#!/bin/bash \nexec /usr/sbin/sshd -D' > /etc/services.d/sshd/run \
  && echo '#!/bin/bash \n service ssh stop' > /etc/services.d/sshd/finish \
  && sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
  && echo "AllowGroups ssh-users" >> /etc/ssh/sshd_config

EXPOSE 22 8787 3838
