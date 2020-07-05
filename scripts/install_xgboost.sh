# Xgboost

set -e
set -x

NCCL_VERSION=${NCCL_VERSION:-2.4.8-1+cuda10.1}

apt-get update
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --allow-unauthenticated --no-install-recommends --no-upgrade \
  gcc-8 \
  g++-8 \
  libnccl2=${NCCL_VERSION} \
  libnccl-dev=${NCCL_VERSION} 

git clone --recursive https://github.com/dmlc/xgboost
mkdir -p xgboost/build && cd xgboost/build
CC=gcc-8 CXX=g++-8 cmake .. -DUSE_CUDA=ON -DR_LIB=ON -DUSE_NCCL=ON
CC=gcc-8 CXX=g++-8 make install
cd ../.. && rm -rf xgboost

