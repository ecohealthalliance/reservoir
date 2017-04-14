FROM ecohealthalliance/geoverse:3.3.1
MAINTAINER "Noam Ross" ross@ecohealthalliance.org

## Setup SSH server
# Install packages
RUN apt-get -y install openssh-server \
 && mkdir /var/run/sshd \
# SSH login fix. Otherwise user is kicked off after login
 && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
 && /etc/init.d/ssh restart
 && /etc/init.d/cron restart

EXPOSE 22
