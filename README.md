# Deploy

## 介绍
Deploy related scripts

## Dependencies

**Ubuntu**

```txt
openssl
envsubst
docker v18.06.3
docker-compose
gitlab-runner
[bitnami](https://hub.docker.com/u/bitnami)
```

**Tip:** 在mac上不需要执行`sudo chown -R 1001:1001 ./data/xxx`
## init base env

```shell

# -----------------------Config sh , For support source ---------------------------------
sudo dpkg-reconfigure dash
# select no 
ls -l `which sh`

# -----------------------set server time-zone---------------------------------
sudo cp --remove-destination  /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
# sudo cp --remove-destination  /usr/share/zoneinfo/America/Chicago  /etc/localtime
# sudo cp --remove-destination  /usr/share/zoneinfo/Australia/Melbourne  /etc/localtime
date

#------------------------download project ------------------------------------
cd $HOME
git clone https://github.com/LiuJiJiJi/deploy.git
cd $HOME/deploy

# -----------------------config env------------------------------
# Modify the variables in env
# For safety you should update your .env file
cp -r $HOME/deploy/services/env.example $HOME/deploy/services/.env
vi $HOME/deploy/services/.env
source $HOME/deploy/script/init_variables.sh

# -----------------------install---------------------------------
cd $HOME/deploy/script
sh install_docker.sh
sh install_java_node_python.sh
# upload https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb 
#    ----> /script/
sh install_gitlab_runner.sh

# -----------------------un install------------------------------
cd $HOME/deploy/script
sh uninstall_docker.sh
sh uninstall_java_node_python.sh
sh uninstall_gitlab_runner.sh

```

## install nginx

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/letsencrypt
sudo chown -R 1001:1001 ./data/letsencrypt
docker-compose -f ./docker-compose-nginx-acmesh.yml up -d

# cert generate
# E.g: domain=www.baidu.com proxy_pass=http://192.168.1.106:8080
export DOMAIN="www.baidu.com"
export PROXY_PASS="$IP4_HOST:8080"
sh ../script/install_certs.sh
envsubst '${DOMAIN}, ${PROXY_PASS}' < ./config/nginx/conf.d/example/http.conf.example > ./config/nginx/conf.d/$DOMAIN.http.conf
docker restart nginx
# Update your domain name resolution， target www.baidu.com to your ip6 addr
# view https://www.baidu.com

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-nginx-acmesh.yml down -v
sudo rm -rf ./data/letsencrypt ./data/acme.sh
```

## install redis

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/redis
sudo chown -R 1001:1001 ./data/redis
docker-compose -f ./docker-compose-redis.yml --compatibility up -d


# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-redis.yml down -v
sudo rm -rf ./data/redis
```

## install mysql

```shell
# start
cd $HOME/deploy/services
docker-compose -f ./docker-compose-mysql.yml --compatibility up -d

# make root remote access mysql
docker exec -it mysql5 mysql -uroot -p
mysql> use mysql; update user set host='%' where user='root'; flush privileges;

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-mysql.yml down -v
sudo rm -rf ./data/mysql*
```

## install mongodb

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/mongodb
sudo chown -R 1001:1001 ./data/mongodb
docker-compose -f ./docker-compose-mongo.yml --compatibility up -d

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-mongo.yml down -v
sudo rm -rf ./data/mongodb
```

## install postgres

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/postgres
sudo chown -R 1001:1001 ./data/postgres
docker-compose -f ./docker-compose-postgres.yml --compatibility up -d

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-postgres.yml down -v
sudo rm -rf ./data/postgres
```

## install es 1.5

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/es1
sudo chown -R 1001:1001 ./data/es1
docker-compose -f ./docker-compose-es1.yml --compatibility up -d

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-es1.yml down -v
sudo rm -rf ./data/es1
```

## install es 1.5

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/es1
sudo chown -R 1001:1001 ./data/es1
docker-compose -f ./docker-compose-es1.yml --compatibility up -d

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-es1.yml down -v
sudo rm -rf ./data/es1
```

## install es 7

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/es7
sudo chown -R 1001:1001 ./data/es7
docker-compose -f ./docker-compose-es7.yml --compatibility up -d
# 设置密码
# https://www.elastic.co/guide/en/elasticsearch/reference/7.13/security-minimal-setup.html
docker exec -it es7 /bin/bash  
vi ./config/elasticsearch.yml
    xpack.security.enabled: true
# 重启es7
docker exec -it es7 /bin/bash  
# 设置密码
./bin/elasticsearch-setup-passwords interactive

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-es7.yml down -v
sudo rm -rf ./data/es7
```

## install zookeeper

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/zookeeper
sudo chown -R 1001:1001 ./data/zookeeper
docker-compose -f ./docker-compose-zookeeper.yml --compatibility up -d

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-zookeeper.yml down -v
sudo rm -rf ./data/zookeeper
```

## install jupyterhub

```shell
# start
cd $HOME/deploy/services
mkdir -p ./data/jupyterhub
sudo chown -R 1001:1001 ./data/jupyterhub
docker-compose -f ./docker-compose-jupyterhub.yml --compatibility up -d

# jupyterhub 中的用户就是  当前系统的用户
docker run -p 8000:8000 -d --name jupyterhub jupyterhub/jupyterhub:1.4  jupyterhub
docker exec -it jupyterhub bash
passwd root
https://localhost:8000   root/123456

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-jupyterhub.yml down -v
sudo rm -rf ./data/jupyterhub
```


## install frp server

```shell
# start
cd $HOME/deploy/services
cp  ./config/frp/frps.server.ini   ./config/frp/frps.ini
# update access token
vim ./config/frp/frps.ini
docker-compose -f ./docker-compose-frps.yml --compatibility up -d
# conif nginx
export DOMAIN="frps.baidu.com"
export PROXY_PASS="$IP4_HOST:50000"
sh ../script/install_certs.sh
envsubst '${DOMAIN}, ${PROXY_PASS}, ${IP4_HOST}' < ./config/nginx/conf.d/example/stream.conf.example > ./config/nginx/conf.d/$DOMAIN.stream.conf
docker restart nginx

# uninstall 
cd $HOME/deploy/services
docker-compose -f ./docker-compose-frps.yml down -v

# frp客户端连接服务器
# 下载frp --> https://github.com/fatedier/frp/releases
# 编辑frpc.ini
# 启动客户端
./frpc -c ./frpc.ini
```

```shell
# start
cd $HOME/deploy/services
docker-compose -f ./docker-compose-srs.yml --compatibility up -d
# uninstall 
docker-compose -f ./docker-compose-srs.yml down -v
```

## FAQ

+ [Shell executor fails to prepare environment in Ubuntu 20.04](https://gitlab.com/gitlab-org/gitlab-runner/-/issues/26605)