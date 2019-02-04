
# Stuff run in setting up prospero
#check device
ubuntu-drivers devices
# install standard drivers for GPU
sudo ubuntu-drivers autoinstall
#restart
sudo reboot

# Get docker
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    htop \
    ncdu 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update
sudo apt-get install docker-ce

sudo groupadd docker
sudo usermod -aG docker $USER

sudo systemctl enable docker

sudo apt-get install linux-headers-$(uname -r)

wget https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux
wget https://developer.nvidia.com/compute/cuda/9.2/Prod/patches/1/cuda_9.2.88.1_linux
mv cuda_9.2.88_396.26_linux cuda_9.2.88_396.26_linux.run
mv cuda_9.2.88.1_linux cuda_9.2.88.1_linux.run
chmod +x cuda_9.2.88_396.26_linux.run
sudo ./cuda_9.2.88_396.26_linux.run --verbose --toolkit --override --silent
sudo ./cuda_9.2.88_396.26_linux.run -silent -driver

sudo apt install nvidia-384
sudo chmod +x cuda_9.2.88.1_linux.run
sudo ./cuda_9.2.88.1_linux.run
sudo apt install nvidia-cuda-toolkit

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi

sudo apt-get install mosh
sudo apt install byobu
