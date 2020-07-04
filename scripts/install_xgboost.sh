# Xgboost

git clone --recursive https://github.com/dmlc/xgboost
mkdir -p xgboost/build && cd xgboost/build
cmake .. -DUSE_CUDA=ON -DR_LIB=ON
make install
cd ../.. && rm -rf xgboost
