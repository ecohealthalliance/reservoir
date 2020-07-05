#!/bin/bash

# Set up config files
chmod +x /reservoir_config/motd.sh; sync; ./reservoir_config/motd.sh > /etc/motd
mv -f /reservoir_config/rsession.conf /etc/rstudio/rsession.conf
mv -f /reservoir_config/rserver.conf /etc/rstudio/rserver.conf
mv -f /reservoir_config/rstudio-login.html /etc/rstudio/login.html
mv -f /reservoir_config/EHA_Logo_369C.png /usr/lib/rstudio-server/www/images/EHA_Logo_369C.png
mv -f /reservoir_config/shiny-server.conf /etc/shiny-server/shiny-server.conf
mv -f /reservoir_config/Rprofile.site /usr/local/lib/R/etc/Rprofile.site
mv -f /reservoir_config/Renviron.site /usr/local/lib/R/etc/Renviron.site
mv -f /reservoir_config/Makevars.site /usr/local/lib/R/etc/Makevars.site
mv -f /reservoir_config/bash_settings.sh /etc/bash.bashrc
mv -f /reservoir_config/userconf.sh /etc/cont-init.d/conf
mv -f /reservoir_config/byobu_status /usr/share/byobu/status/status
mv -f /reservoir_config/byobu_statusrc /usr/share/byobu/status/statusrc
mv -f /reservoir_config/byoburc /usr/share/byobu/profiles/byoburc
mv -f /reservoir_config/ccache.conf /etc/ccache.conf
ln -s /usr/bin/byobu-launch /etc/profile.d/Z98-byobu.sh
echo 'set -g default-terminal "screen-256color"' >> /usr/share/byobu/profiles/tmux

# Limit mosh's server ports to 60990:61000
mv /usr/bin/mosh-server /usr/bin/mosh-server-original
echo '#!/bin/bash' > /usr/bin/mosh-server
echo '/usr/bin/mosh-server-original new -p 60990:61000 $@' >> /usr/bin/mosh-server
chmod +x /usr/bin/mosh-server

## Setup SSH and cron. s6 supervisor already installed for RStudio, so
## just create the run and finish scripts
mkdir -p /var/run/sshd
mkdir -p /etc/services.d/sshd
echo '#!/bin/bash \nexec /usr/sbin/sshd -D' > /etc/services.d/sshd/run
echo '#!/bin/bash \n service ssh stop' > /etc/services.d/sshd/finish
sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "AllowGroups ssh-users" >> /etc/ssh/sshd_config
mkdir -p /etc/services.d/cron
echo '#!/usr/bin/with-contenv sh\ntouch /etc/crontab /etc/cron.*/*\nexec cron -f' > /etc/services.d/cron/run
