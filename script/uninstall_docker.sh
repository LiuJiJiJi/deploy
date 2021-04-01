#!/bin/bash

echo "uninstall Start"


# uninstall docker
sudo apt-get remove --purge docker-ce

# uninstall docker-compose
sudo rm -rf /usr/local/bin/docker-compose


echo "Success"
