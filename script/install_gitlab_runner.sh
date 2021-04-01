#!/bin/bash

echo "Install gitlab runner start"

# curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
echo -e -n "Please upload gitlab-runner_amd64.deb to /script"
echo -e -n "      -----> scp -r gitlab-runner_amd64.deb ubuntu@xx.xx.xx.xx:/home/ubuntu/deploy/script"
sudo dpkg -i gitlab-runner_amd64.deb
# input REGISTRATION_TOKEN
echo -e -n "\033[31m Please input REGISTRATION_TOKEN: \033[0m"
read REGISTRATION_TOKEN
sudo gitlab-runner register --url https://gitlab.com/ --registration-token $REGISTRATION_TOKEN
sudo systemctl enable gitlab-runner
gitlab-runner list

# Grant docker permissions to gitlab-runner users
sudo groupadd docker
# sudo newgrp docker
sudo gpasswd -a gitlab-runner docker
su gitlab-runner
docker ps
exit

echo "Install gitlab runner end"