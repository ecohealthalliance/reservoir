FROM rocker/geospatial:latest
MAINTAINER "Noam Ross" ross@ecohealthalliance.org

## Other possible things to install: python, go, julia, node

ADD latest-rstudio-preview.R /latest-rstudio-preview.R

## Install additional packages
RUN echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_9.0/ /' > /etc/apt/sources.list.d/fish.list \
  && apt-get update && apt-get install -y --force-yes --no-install-recommends --no-upgrade \
## Shell tools
  curl man ncdu tmux byobu htop zsh fish silversearcher-ag lsb-release mosh nginx gdebi-core \
## R package dependencies
  libnlopt-dev \
  libglpk-dev coinor-symphony coinor-symphony coinor-libsymphony-dev coinor-libcgl-dev \ 
  grass grass-doc grass-dev \
## non-apt stuff
  # micro
&& curl -sL https://gist.githubusercontent.com/zyedidia/d4acfcc6acf2d0d75e79004fa5feaf24/raw/a43e603e62205e1074775d756ef98c3fc77f6f8d/install_micro.sh | bash -s linux64 /usr/bin \
## RStudio preview version
&& Rscript latest-rstudio-preview.R \
&& dpkg -i rstudio-server-preview-stretch-amd64.deb \
&& rm rstudio-server-preview-stretch-amd64.deb latest-rstudio-preview.R \
## GitHub pkgs
&& installGithub.r s-u/unixtools \
## cleanup
  && . /etc/environment \
  && R CMD javareconf \
  && install2.r -e -r $MRAN rJava V8 rgrass7 Rglpk ROI.plugin.glpk Rsymphony ROI.plugin.symphony lme4 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \

  ## Setup SSH. s6 supervisor already installed for RStudio, so
  ## just create the run and finish scripts
    && mkdir -p /var/run/sshd \
    && mkdir -p /etc/services.d/sshd \
    && echo '#!/bin/bash \nexec /usr/sbin/sshd -D' > /etc/services.d/sshd/run \
    && echo '#!/bin/bash \n service ssh stop' > /etc/services.d/sshd/finish \

    ## EXTRAORDINARILY UNSAFE SSH CONFIGS FOR EARLY TESTING
    && sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "AllowGroups ssh-users" >> /etc/ssh/sshd_config

COPY config ./
RUN chmod +x /motd.sh; sync; ./motd.sh > /etc/motd \
&& mv -f rsession.conf /etc/rstudio/rsession.conf \
&& mv -f Renviron.site /usr/local/lib/R/etc/Renviron.site \
&& mv -f bash_settings.sh /etc/bash.bashrc \
&& mv -f userconf.sh /etc/cont-init.d/conf \
&& mv -f byobu_status /usr/share/byobu/status/status \
&& ln -s /usr/bin/byobu-launch /etc/profile.d/Z98-byobu.sh \
&& echo 'set -g default-terminal "screen-256color"' >> /usr/share/byobu/profiles/tmux


EXPOSE 22 8787
