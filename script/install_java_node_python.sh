#!/bin/bash

# version
## java: 11
## node: 10.21.x
## python: 3.7
echo "Install java and node and python start"

# jdk8
# sudo apt-get install openjdk-8-jdk
# jdk11
sudo apt-get install openjdk-11-jdk
java -version

# node10.x
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install nodejs
node --version
npm --version
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt install --no-install-recommends yarn
yarn --version
sudo yarn config get registry
sudo yarn config set registry https://registry.npm.taobao.org

# Dont uninstall python2.7, Is the basic package
# python3.7 ----> /usr/bin/python3.7
# https://www.python.org/ftp/python/3.xx/
whereis python
sudo add-apt-repository ppa:jonathonf/python-3.7
sudo apt-get update
sudo apt-get install python3.7
whereis python
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 100
# select python3
sudo update-alternatives --config python
# pip3 install
sudo apt-get install python3-distutils
sudo python get-pip.py
pip --version
pip --version

echo "Install java and node and python end"