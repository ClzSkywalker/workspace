账号密码：root:root
构建参数：
PC_HOST:本地pc的ip地址
PWD:root密码

资源准备：
flutter包：https://flutter.cn/docs/get-started/install/linux
go安装：https://go.dev/doc/install
lazygit: https://github.com/jesseduffield/lazygit/releases
local: lazygit库，docker镜像中取出
nvim-linux：https://github.com/neovim/neovim/wiki/Installing-Neovim

desktop app开发需要下载：
https://mobaxterm.mobatek.net/download-home-edition.html



docker build -t lazyvim:0.1.5 -f ./Dockerfile .
docker build -t workspace:0.0.1 -f ./Dockerfile2 .
docker run -it -d -e pchost="0.0.0.0" -p 50002:22 -v D:/:/mnt/d/ -v C:/:/mnt/c/ -v D:/:/mnt/d/ -v E:/:/mnt/e/ --name lazyvim lazyvim:0.1.5
docker run -it -d -e PC_HOST="192.168.0.60" -p 8008:8007 -p 50002:22 -v C:/:/mnt/c/ -v D:/:/mnt/d/  --name lazyvim lazyvim:0.1.5
docker run -it -d -e PC_HOST="0.0.0.0" -p 8008:8007 -p 50002:22 -v /Users/sky/Documents/project:/mnt/c/  --name workspace workspace:0.0.1
docker exec -it lazyvim /bin/bash

docker tag lazyvim:0.1.5 1045683477/lazyvim:0.1.5
docker push 1045683477/lazyvim:0.1.5

7z a local.7z .local
docker cp lazyvim:/root/local.7z ./install_pack/source/


docker json
```json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "registry-mirrors": [
    "https://dockerpull.org",
    "https://hub.geekery.cn",
    "https://docker.1ms.run",
    "https://docker.1panel.dev",
    "https://docker.foreverlink.love",
    "https://docker.fxxk.dedyn.io",
    "https://docker.zhai.cm",
    "https://hub.docker.com"
  ]
}


{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "registry-mirrors": [
    "https://docker.hpcloud.cloud",
    "https://docker.m.daocloud.io",
    "https://docker.unsee.tech",
    "https://docker.1panel.live",
    "http://mirrors.ustc.edu.cn",
    "https://docker.chenby.cn",
    "http://mirror.azure.cn",
    "https://dockerpull.org",
    "https://dockerhub.icu",
    "https://hub.rat.dev",
    "https://docker.1ms.run",
    "https://dockerpull.org"
    "https://hub.docker.com",
  ]
}
```