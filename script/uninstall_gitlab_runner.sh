#!/bin/bash

echo "Install gitlab runner start"

echo -n "Please input runner name:"
read runner_name
sudo gitlab-runner unregister --name $runner_name
sudo apt-get -y remove --purge gitlab-runner

echo "Install gitlab runner end"