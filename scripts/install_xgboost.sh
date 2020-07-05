# Xgboost

apt-get update
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages --allow-unauthenticated --no-install-recommends --no-upgrade \
  gcc-8 \
  g++-8

git clone --recursive https://github.com/dmlc/xgboost
mkdir -p xgboost/build && cd xgboost/build
CC=gcc-8 CXX=g++-8 cmake .. -DUSE_CUDA=ON 
CC=gcc-8 CXX=g++-8 make 
cd ../.. && rm -rf xgboost
