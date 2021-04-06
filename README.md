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
```

### init base env

> upload https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb 
>    ----> /script/
```shell
# -----------------------set server time-zone---------------------------------
sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

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
# view https://www.baidu.com

# uninstall 
docker-compose -f ./docker-compose-nginx-acmesh.yml down -v
rm -rf ./data/letsencrypt ./data/.acme
```


### install redis

```shell
# start
cd services
mkdir -p ./data/redis
sudo chown -R 1001:1001 ./data/redis
docker-compose -f ./docker-compose-redis.yml --compatibility up -d


# uninstall 
docker-compose -f ./docker-compose-redis.yml down -v
rm -rf ./data/redis
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
rm -rf ./data/mysql
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
rm -rf ./data/mongodb
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
rm -rf ./data/mongodb
```