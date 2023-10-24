https://github.com/neovim/neovim/releases/tag/stable
https://dl.google.com/go/go1.21.1.linux-amd64.tar.gz
https://github.com/jesseduffield/lazygit/releases/tag/v0.40.2
天翼下载local.7z https://cloud.189.cn/t/jQZjquM3m6F3 （访问码：9v44）

资源准备：
flutter包：https://flutter.cn/docs/get-started/install/linux
go安装：https://go.dev/doc/install
lazygit: https://github.com/jesseduffield/lazygit/releases
local: lazygit库，docker镜像中取出
nvim-linux：https://github.com/neovim/neovim/wiki/Installing-Neovim

docker build -t lazyvim:0.1.0 -f ./Dockerfile .
docker run -it -d -v D:/:/mnt/d/ -v E:/:/mnt/e/ --name lazyvim lazyvim:0.1.0
docker run -it -d -p 8008:8007 -v C:/:/mnt/c/ -v D:/:/mnt/d/ --name lazyvim lazyvim:0.1.0
docker exec -it lazyvim /bin/bash


docker tag lazyvim:0.1.0 1045683477/lazyvim:0.1.0
docker push 1045683477/lazyvim:0.1.0

7z a local.7z .local
docker cp lazyvim:/root/local.7z ./source/