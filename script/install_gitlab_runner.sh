#!/bin/bash

echo "Install gitlab runner start"

# curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
echo "Please upload gitlab-runner_amd64.deb to /script"
echo "-----> scp -r gitlab-runner_amd64.deb ubuntu@xx.xx.xx.xx:/home/ubuntu/deploy/script"
sudo dpkg -i gitlab-runner_amd64.deb
# input REGISTRATION_TOKEN
echo -n "Please input REGISTRATION_TOKEN:"
read REGISTRATION_TOKEN
sudo gitlab-runner register --url https://gitlab.com/ --registration-token $REGISTRATION_TOKEN

echo "Install gitlab runner end"