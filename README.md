# Deploy

#### 介绍
Deploy related scripts

### init base env

> upload https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb 
>    ----> /script/
```shell
cd script
sh install_docker.sh
sh install_java_node_python.sh
sh install_gitlab_runner.sh

# -----------------------un install------------------------------
cd script
sh uninstall_docker.sh
sh uninstall_java_node_python.sh
sh uninstall_gitlab_runner.sh
```

### install common middleware (redis mysql mongodb)

```shell
```