FROM ecohealthalliance/geoverse:latest
MAINTAINER "Noam Ross" ross@ecohealthalliance.org

## Setup SSH server. s6 supervisor already installed for RStudio, so
## just create the run and finish scripts
RUN mkdir -p /var/run/sshd \
  && mkdir -p /etc/services.d/sshd \
  && echo '#!/bin/bash \nexec /usr/sbin/sshd -D' > /etc/services.d/sshd/run \
  && echo '#!/bin/bash \n service ssh stop' > /etc/services.d/sshd/finish \

  ## EXTRAORDINARILY UNSAFE SSH CONFIGS FOR EARLY TESTING
  && sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
  && echo "AllowUsers rstudio" >> /etc/ssh/sshd_config

EXPOSE 22 8787
