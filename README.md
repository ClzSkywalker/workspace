https://github.com/neovim/neovim/releases/tag/stable
https://dl.google.com/go/go1.21.1.linux-amd64.tar.gz
https://github.com/jesseduffield/lazygit/releases/tag/v0.40.2
天翼下载local.7z https://cloud.189.cn/t/jQZjquM3m6F3 （访问码：9v44）

docker build -t lazyvim:0.0.4 -f ./Dockerfile .
docker run -it -d -v D:/:/mnt/d/ -v E:/:/mnt/e/ --name lazyvim lazyvim:0.0.4
docker run -it -d -v D:/:/mnt/d/ --name lazyvim lazyvim:0.0.4
docker exec -it lazyvim /bin/bash