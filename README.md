https://github.com/neovim/neovim/releases/tag/stable

docker build -t lazyvim:0.0.1 -f ./Dockerfile .
docker run -it -d --name lazyvim lazyvim:0.0.1
docker exec -it lazyvim /bin/bash