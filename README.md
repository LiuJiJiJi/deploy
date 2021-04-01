# deploy-docker

#### 介绍
部署 相关脚本

### base env

+ OS: ubuntu.20.0.4
+ docker: 18.06.3-ce
+ docker-compose: 18.06.3-ce


### Nacos

1. First you should create database for nacos in your mysql server
2. run ddl sql(data/nacos/nacos-mysql.sql) on your mysql server
3. ssh login your server, git clone this project
4. cd deploy-docker
5. update mysql connection config (env/nacos-standlone-mysql.env)
6. docker-compose -f example/nacos.yaml up -d
    - docker-compose -f example/nacos.yaml down -v
7. Access http://ip:8848/nacos    username:nacos    password:nacos
8. tail -n 200 -f data/nacos/logs/nacos.log
> nacos is an intranet application，Please don't ose it to internet.

### nginx

1. ssh login your server, use git clone this project
2. cd deploy-docker
3. cp -r data/nginx/nginx.conf.example data/nginx/nginx.conf       update your domain on nginx.conf
    - vim data/nginx/nginx.conf
    - :%s/domain.com/xxx.xxx.xxx/g
    - update `proxy_pass http://ip:port;`   ps: because we are use docker ,so 127.0.0.1 is not suitable here.
4. use acme.sh install cert for your domain

    ```shell script
     ## Background
         volumes:
           - ../data/nginx/nginx.conf:/etc/nginx/nginx.conf
           - ../data/nginx/cert/:/etc/nginx/cert/
           - ../data/nginx/log/:/var/log/nginx/
     ## So we should install the cert to /root/deploy-docker/data/nginx/cert/
     # As an example for baidu.com
     sudo -i
     curl https://get.acme.sh | sh
     cd /root/.acme.sh
     export DP_Id="DNS管理中心创建的ID"
     export DP_Key="DNS管理中心创建的Token"
     sh /root/.acme.sh/acme.sh --issue --force --dns dns_dp -d baidu.com
     mkdir -p /root/deploy-docker/data/nginx/cert/baidu.com/
     sh /root/.acme.sh/acme.sh --install-cert -d baidu.com --cert-file /root/deploy-docker/data/nginx/cert/baidu.com/chain.pem  --key-file /root/deploy-docker/data/nginx/cert/baidu.com/privkey.pem --fullchain-file /root/deploy-docker/data/nginx/cert/baidu.com/fullchain.pem
     # sh /root/.acme.sh/acme.sh --install-cert -d baidu.com --cert-file /root/deploy-docker/data/nginx/cert/baidu.com/chain.pem  --key-file /root/deploy-docker/data/nginx/cert/baidu.com/privkey.pem --fullchain-file /root/deploy-docker/data/nginx/cert/baidu.com/fullchain.pem  --reloadcmd  "docker restart nginx"
    ```
5. cd /root/deploy-docker
6. docker-compose -f example/nginx.yaml up -d

### mongo

1. cd deploy-docker
2. cp -r data/mongo/configdb/mongod.conf.example data/mongo/configdb/mongod.conf
3. cp -r env/mongo.env.example env/mongo.env
4. docker-compose -f example/mongo.yaml up -d
5. update container mongodb access
    - docker exec -it --user root mongo /bin/bash
    - chown mongodb:mongodb /data/log
    - chown mongodb:mongodb /data/log/*
6. open log config (data/mongo/configdb/mongod.conf)    
7. docker restart mongo
> [Ubuntu Mongdb安装](https://docs.mongodb.com/v4.0/tutorial/install-mongodb-on-ubuntu/) 
> [mongo clinet](https://docs.mongodb.com/v4.0/mongo/)
> mongo --host XXX --port 27017
> use admin;
> db.auth('root', '123456')
> db.changeUserPassword("root", "新密码")


### nest
1. cd deploy-docker
2. cp -r data/nest/.env.example data/nest/.env
3. cp -r example/nest.yaml example/nest.local.yaml
4. update yaml's image
4. docker-compose -f example/nest.local.yaml up -d

### redis
1. cd deploy-docker
2. cp -r data/redis/redis.conf.example data/redis/redis.conf
3. update `requirepass XXXXXX` on redis.conf
4. docker-compose -f example/redis.yaml up -d

### [rocket mq](https://github.com/apache/rocketmq-docker)
1. cd deploy-docker
2. cp -r data/rocketmq/broker/broker.conf.example data/rocketmq/broker/broker.conf
2. cp -r data/rocketmq/console/users.properties.example data/rocketmq/console/users.properties
4. update admin username & pwd on users.properties
5. docker-compose -f example/rocketmq.yaml up -d
6. docker inspect --format='{{.Name}} - {{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
7. get rmqnamesrv & rmqbroker ip4
8. update `-Drocketmq.config.namesrvAddr=rmqnamesrv ip4:9876` on rocketmq.yaml
9. update `brokeP1=rmqbroker ip4` on broker.conf
10. docker-compose -f example/rocketmq.yaml up -d
11. docker restart rmqnamesrv rmqbroker rmqconsole

> #### [rocketmq-console](https://github.com/apache/rocketmq-externals/tree/master/rocketmq-console) ocker image build
> 1. sudo -i  # because docker build need root access.
> 2. cd deploy-docker/source/rocketmq-console
> 3. mvn clean package -Dmaven.test.skip=true docker:build
> 4. docker tag apacherocketmq/rocketmq-console-ng:latest liujijiji/rocketmq:console-4.5.0
> 5. docker push liujijiji/rocketmq:console-4.5.0