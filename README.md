https://github.com/neovim/neovim/releases/tag/stable
https://dl.google.com/go/go1.21.1.linux-amd64.tar.gz
https://github.com/jesseduffield/lazygit/releases/tag/v0.40.2
天翼下载local.7z https://cloud.189.cn/t/jQZjquM3m6F3 （访问码：9v44）

docker build -t lazyvim:0.0.7 -f ./Dockerfile .
docker run -it -d -v D:/:/mnt/d/ -v E:/:/mnt/e/ --name lazyvim lazyvim:0.0.6
docker run -it -d -v D:/:/mnt/d/ --name lazyvim lazyvim:0.0.6
docker exec -it lazyvim /bin/bash

docker cp lazyvim:/root/local.7z ./source/
docker tag lazyvim:0.0.7 1045683477/lazyvim:0.0.7
docker push 1045683477/lazyvim:0.0.7

7z a local.7z .local