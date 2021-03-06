#!/bin/bash

set -e
set -x


# Restore man pages
yes | unminimize

apt-get update
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --allow-unauthenticated --no-install-recommends --no-upgrade \
  aria2 \
  apt-transport-https \
  awscli \
  bat \
  byobu \
  ccache \
  cmake \
  coinor-libcgl-dev \
  coinor-libsymphony-dev \
  coinor-symphony \
  cron \
  curl \
  dirmngr \
  fish \
  fzf \
  git-core \
  git-crypt \
  gpg \
  gnupg \
  gnupg2 \
  gocryptfs \
  golang-go \
  graphviz \
  grass \
  grass-dev \
  grass-doc \
  htop \
  jags \
  libclang-dev \
  libncursesw5 \
  libglpk-dev \
  libgoogle-perftools-dev \
  libleptonica-dev \
  libnlopt-dev \
  libopenmpi-dev \
  libpoppler-cpp-dev \
  libprotobuf-dev \
  libprotoc-dev \
  libsecret-1-dev \
  libsodium-dev \
  libtesseract-dev \
  lsb-release \
  micro \
  man \
  man-db \
  mosh \
  multitail \
  nano \
  ncdu \
  nnn \
  p7zip-full \
  parallel \
  postgresql-client \
  protobuf-compiler \
  pv \
  rclone \
  rename  \
  rsync \
  silversearcher-ag \
  software-properties-common \
  openssh-server \
  tesseract-ocr-eng \
  tmux \
  tree \
  whois \
  xclip \
  zsh

apt-get clean
rm -rf /var/lib/apt/lists/


### Docker
curl -sSL https://get.docker.com/ | sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.26.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

# Dive (for exploring docker images)
wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
apt install ./dive_0.9.2_linux_amd64.deb

### Z
wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O /usr/bin/z
