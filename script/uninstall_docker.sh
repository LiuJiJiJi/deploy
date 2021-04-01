#!/bin/bash

echo "uninstall Start"

# uninstall docker
sudo apt-get remove docker docker-engine docker.io containerd runc

# uninstall docker-compose
sudo rm -rf /usr/local/bin/docker-compose

echo "Success"
