# Deploy

#### 介绍
Deploy related scripts
[bitnami](https://hub.docker.com/u/bitnami)

#### Dependencies

**Ubuntu**

```txt
openssl
envsubst
docker v18.06.3
docker-compose
gitlab-runner
```

### init base env

> upload https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb 
>    ----> /script/
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

git clone 
cd deploy https://github.com/LiuJiJiJi/deploy.git
# -----------------------install---------------------------------
cd script
sh install_docker.sh
sh install_java_node_python.sh
sh install_gitlab_runner.sh

# -----------------------un install------------------------------
cd script
sh uninstall_docker.sh
sh uninstall_java_node_python.sh
sh uninstall_gitlab_runner.sh

# -----------------------config env------------------------------
# Modify the variables in env
cd services
cp -r env.example .env
source ../script/init_variables.sh
```
mkdir -p ./data/mongodb
mkdir -p ./data/redis


### install nginx

```shell
# start
cd services
mkdir -p ./data/letsencrypt
sudo chown -R 1001:1001 ./data/letsencrypt
docker-compose -f ./docker-compose-nginx-acmesh.yml up -d

# cert generate
# E.g: domain=www.baidu.com proxy_pass=http://192.168.1.106:8080
export DOMAIN="www.baidu.com"
export PROXY_PASS="http://192.168.1.106:8080"
sh ../script/install_certs.sh
envsubst '${DOMAIN}, ${PROXY_PASS}' < ./config/nginx/conf.d/server.conf.example > ./config/nginx/conf.d/$DOMAIN.server.conf
docker restart nginx
# Update your domain name resolution， target www.baidu.com to your ip6 addr
# view https://www.baidu.com

# uninstall 
docker-compose -f ./docker-compose-nginx-acmesh.yml down -v
sudo rm -rf ./data/letsencrypt ./data/.acme
```

### [v2ray](https://www.v2fly.org/guide/install.html#docker-%E5%AE%89%E8%A3%85%E6%96%B9%E5%BC%8F) + ws + tls

```shell
cd services
mkdir -p ./data/v2ray
sudo chown -R 1001:1001 ./data/v2ray
cp  ./config/v2ray/config.demo.json   ./config/v2ray/config.json
# Please update the client infomation on ./config/v2ray/config.json ---> generate an neww uuid
docker-compose -f ./docker-compose-v2ray.yml --compatibility up -d
export DOMAIN="v2ray.baidu.com"
export PROXY_PASS="http://192.168.1.106:5432"
sh ../script/install_certs.sh
envsubst '${DOMAIN}, ${PROXY_PASS}' < ./config/nginx/conf.d/server.v2ray.conf.example > ./config/nginx/conf.d/$DOMAIN.server.conf
docker restart nginx v2ray

# uninstall 
docker-compose -f ./docker-compose-v2ray.yml down -v
sudo rm -rf ./data/v2ray
```
> **client conifg**
> ![](./img/v2ray_config.png)
> ![](./img/v2ray_config_tsl.png)

### install redis

```shell
# start
cd services
mkdir -p ./data/redis
sudo chown -R 1001:1001 ./data/redis
docker-compose -f ./docker-compose-redis.yml --compatibility up -d


# uninstall 
docker-compose -f ./docker-compose-redis.yml down -v
sudo rm -rf ./data/redis
```

### install mysql

```shell
# start
cd services
mkdir -p ./data/mysql
sudo chown -R 1001:1001 ./data/mysql
docker-compose -f ./docker-compose-mysql.yml --compatibility up -d


# uninstall 
docker-compose -f ./docker-compose-mysql.yml down -v
sudo rm -rf ./data/mysql
```

### install mongodb

```shell
# start
cd services
mkdir -p ./data/mongodb
sudo chown -R 1001:1001 ./data/mongodb
docker-compose -f ./docker-compose-mongo.yml --compatibility up -d

# uninstall 
docker-compose -f ./docker-compose-mongo.yml down -v
sudo rm -rf ./data/mongodb
```

### install postgres

```shell
# start
cd services
mkdir -p ./data/postgres
sudo chown -R 1001:1001 ./data/postgres
docker-compose -f ./docker-compose-postgres.yml --compatibility up -d

# uninstall 
docker-compose -f ./docker-compose-postgres.yml down -v
sudo rm -rf ./data/postgres
```

### frp https

```shell
TODO
```