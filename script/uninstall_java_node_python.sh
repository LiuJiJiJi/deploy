#!/bin/bash

# version
## java: 11
## node: 10.21.x
echo "UnInstall java and node and python Start"

# jdk uninstall
sudo apt-get remove --purge openjdk*
sudo apt-get remove --purge maven
# node uninstall
sudo apt-get remove --purge nodejs npm yarn
sudo rm -rf /usr/bin/yarn
# python3.7.x
sudo apt-get remove --purge python3.7*
sudo update-alternatives --remove-all python

echo "UnInstall java and node and python Success"