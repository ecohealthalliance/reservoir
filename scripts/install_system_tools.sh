#!/bin/bash

set -e
set -x

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
  mosh \
  multitail \
  nano \
  ncdu \
  nnn \
  p7zip-full \
  protobuf-compiler \
  pv \
  rclone \
  rename  \
  rsync \
  silversearcher-ag \
  software-properties-common \
  tesseract-ocr-eng \
  tmux \
  tree \
  whois \
  xclip \
  zsh \
  docker \
  docker-compose \
  docker.io

apt-get clean
rm -rf /var/lib/apt/lists/

wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O /usr/bin/z

echo "Done!"