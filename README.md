https://github.com/neovim/neovim/releases/tag/stable
https://dl.google.com/go/go1.21.1.linux-amd64.tar.gz
https://github.com/jesseduffield/lazygit/releases/tag/v0.40.2

docker build -t lazyvim:0.0.2 -f ./Dockerfile .
docker run -it -d -v D:/:/mnt/d/ -v E:/:/mnt/e/ --name lazyvim lazyvim:0.0.2
docker run -it -d -v D:/:/mnt/d/ --name lazyvim lazyvim:0.0.2
docker exec -it lazyvim /bin/bash