FROM ecohealthalliance/geoverse:latest
MAINTAINER "Noam Ross" ross@ecohealthalliance.org

## Setup SSH server
# Install packages
RUN apt-get update && apt-get -y install openssh-server supervisor\
  && mkdir -p /var/run/sshd /var/log/supervisor \

  ## EXTRAORDINARILY UNSAFE SSH CONFIGS FOR EARLY TESTING
  && sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
  && echo "AllowUsers rstudio" >> /etc/ssh/sshd_config

EXPOSE 22 8787
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
