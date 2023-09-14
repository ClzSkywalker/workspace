FROM ubuntu:23.10

ENV GOPACK go1.21.1.linux-amd64.tar.gz
ENV LAZYGIT lazygit_0.40.2_Linux_x86_64.tar.gz

WORKDIR /root
RUN cd /root/

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y \
    bash \
    build-essential \
    curl \
    git \
    vim \
    wget \
    tar \
    ca-certificates \
    gnupg \
    zip \
    python3 \
    python3-pip \
    ripgrep \
    fish \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]
RUN mkdir source

# 安装neovim
RUN mkdir -p source/neovim
RUN mkdir neovim
COPY ./nvim-linux64.tar.gz ./source/neovim
RUN tar -zxvf ./source/neovim/nvim-linux64.tar.gz -C ./source/neovim
RUN chmod +x ./source/neovim/nvim-linux64/bin/nvim
RUN echo 'export PATH=$PATH:/root/source/neovim/nvim-linux64/bin' >> /root/.bashrc

#python
# yaml 格式化
# RUN pip3 install pyyaml -i https://pypi.tuna.tsinghua.edu.cn/simple

# 文件搜索
# RUN add-apt-repository ppa:x4121/ripgrep
# RUN apt update
# RUN apt install ripgrep -y

# 安装go 
RUN mkdir ./source/golang
COPY ./$GOPACK ./source/golang/
RUN tar -zxvf ./source/golang/$GOPACK -C /usr/local/
# RUN mv ./source/golang/go /usr/local/
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc
RUN echo "export GO111MODULE=on" >> /root/.bashrc
RUN echo "export GOPROXY=https://goproxy.cn" >> /root/.bashrc
# RUN source /root/.bashrc

# 安装lazygit
COPY ./$LAZYGIT ./source/golang/
RUN mkdir -p ./source/golang/lazygit
RUN tar -zxvf ./source/golang/$LAZYGIT -C ./source/golang/lazygit/
RUN install ./source/golang/lazygit/lazygit /usr/local/bin

# 安装node https://deb.nodesource.com/
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
# RUN NODE_MAJOR=20
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" |  tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update 
RUN apt-get install nodejs -y
RUN npm config set registry https://registry.npm.taobao.org
RUN npm install -g npm@10.1.0
# 文件搜索
RUN npm install -g -y fd-find 
# json格式化
# RUN npm install -y --save-dev --save-exact prettier

# 安装rust
RUN mkdir ./source/rust
COPY ./rustup-init.sh ./source/rust
RUN echo 'export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static' >> /root/.bashrc
# RUN curl https://sh.rustup.rs -sSf  | sh 
RUN sh ./source/rust/rustup-init.sh -y
COPY ./config /root/.cargo/config
RUN source /root/.cargo/env

# 下载Nv
RUN mkdir .config
RUN git clone https://github.com/ClzSkywalker/Nv.git /root/.config/nvim

RUN source /root/.bashrc
# RUN /root/source/neovim/nvim-linux64/bin/nvim

CMD [ "bash" ]