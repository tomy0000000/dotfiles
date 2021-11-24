sudo apt-get update
sudo ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
sudo apt-get install -y tzdata
sudo dpkg-reconfigure --frontend noninteractive tzdata
