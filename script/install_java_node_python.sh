#!/bin/bash

# version
## java: 11
## node: 10.21.x
## python: 3.7
echo "Install java and node and python start"

# jdk8
# sudo apt-get install openjdk-8-jdk
# jdk11
sudo apt-get install -y openjdk-11-jdk
java -version
# maven install ---->
sudo apt-get install -y maven
mvn --version
# update maven setting
sudo mkdir /usr/share/maven/repsoitories
sudo cp -rf ./maven/settings.xml /usr/share/maven/conf/
sudo chmod a+rw /usr/share/maven

# node10.x
# curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
# sudo apt install nodejs
# node --version
# sudo npm config set  registry https://registry.npm.taobao.org
# npm --version
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt install --no-install-recommends yarn
# yarn --version
# sudo yarn config get registry
# sudo yarn config set registry https://registry.yarnpkg.com
# sudo yarn config set registry https://registry.npm.taobao.org
# nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh | bash
sed -i '/nvm.sh/d' ~/.profile
sed -i '/.nvm/d' ~/.profile
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.profile
source ~/.profile
nvm --version
nvm install 10
nvm use 10
nvm list
node --version
npm --version
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get remove --purge -y yarn
sudo apt install -y --no-install-recommends yarn
yarn --version
sudo yarn config set registry https://registry.npm.taobao.org



# Dont uninstall python2.7, Is the basic package
# /usr/local/lib/python3.7 --> python3.7 ----> /usr/bin/python3.7
# https://www.python.org/ftp/python/3.xx/
whereis python
sudo add-apt-repository ppa:jonathonf/python-3.7
sudo apt-get update
sudo apt-get install -y python3.7
whereis python
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 100
# select python3
sudo update-alternatives --config python
python --version
# pip3 install
sudo apt-get install -y python3-distutils
sudo python ./python/get-pip.py
pip --version
pip3 --version

echo "Install java and node and python end"