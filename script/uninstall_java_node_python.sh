#!/bin/bash

# version
## java: 11
## node: 10.21.x
echo "UnInstall java and node and python Start"

# jdk uninstall
sudo apt-get remove --purge -y openjdk*
sudo apt-get remove --purge -y maven
# node uninstall
sudo apt-get remove --purge -y nodejs npm yarn nvm
sudo rm -rf /usr/bin/yarn
nvm deactivate
nvm uninstall node
rm -rf ~/.nvm
sed -i '/nvm.sh/d' ~/.profile
sed -i '/.nvm/d' ~/.profile
source ~/.profile
# python3.7.x
sudo apt-get remove --purge -y python3.7*
sudo update-alternatives --remove-all python

echo "UnInstall java and node and python Success"