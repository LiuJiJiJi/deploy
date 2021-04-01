#!/bin/bash

echo "uninstall Start"

# uninstall envsubst openssl
sudo apt-get remove envsubst openssl

# uninstall docker
sudo apt-get remove docker-ce

# uninstall docker-compose
sudo rm -rf /usr/local/bin/docker-compose


echo "Success"
