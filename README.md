# Deploy

#### 介绍
Deploy related scripts

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
```

### install nginx

```shell
# start
cd services
docker-compose -f ./docker-compose-nginx-acmesh.yml up -d

# cert generate
# E.g: domain=www.baidu.com proxy_pass=http://192.168.1.106:8080
sh ../script/install_certs.sh
export DOMAIN="www.baidu.com"
export PROXY_PASS="http://192.168.1.106:8080"
envsubst '${DOMAIN}, ${PROXY_PASS}' < ./config/nginx/conf.d/server.conf.example > ./config/nginx/conf.d/<input your server name>.server.conf
docker restart nginx
# view https://www.baidu.com

# uninstall 
cd services
docker-compose -f ./docker-compose-nginx-acmesh.yml up -d
rm -rf ./data/letsencrypt ./data/.acme
```

### install common middleware (redis mysql mongodb)

```shell
```