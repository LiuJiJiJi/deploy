#!/bin/bash

# node10 install 
nvm --version
nvm install 10
nvm use 10
nvm list
node --version
npm --version
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt install -y --no-install-recommends yarn
yarn --version
sudo yarn config set registry https://registry.npm.taobao.org
