sudo apt-get update
sudo apt-get install -y locales
sudo locale-gen zh_TW
sudo locale-gen zh_TW.UTF-8
sudo dpkg-reconfigure --frontend=noninteractive locales
sudo update-locale LANG="zh_TW.UTF-8" LANGUAGE="zh_TW"
