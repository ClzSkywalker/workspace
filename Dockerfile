FROM ubuntu:23.10

ENV INSTALL_PATH ./install_pack
ENV SOURCE_PATH /root/install_pack/source
ENV CONFIG_PATH /root/install_pack/config

ENV NVIM_NAME nvim-linux64-v0.9.4.tar.gz
ENV GOPACK_NAME go1.21.3.linux-amd64.tar.gz
ENV FLUTTER_NAME flutter_linux_3.13.8-stable.tar.xz

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
    snapd \
    # docker
    ca-certificates \
    gnupg \
    # 压缩包工具
    zip \
    tar \
    p7zip-full \
    # python环境
    python3 \
    python3-pip \
    # 搜索工具
    ripgrep \
    fish \
    pkg-config \
    libssl-dev \
    # protobuf 工具
    protobuf-compiler \
    libprotobuf-dev \
    # bevy 配置
    g++ \
    libx11-dev \
    libasound2-dev \
    libudev-dev \
    lld \
    # flutter
    cmake \
    xz-utils \
    ninja-build \
    # ibgtk-3-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]
COPY $INSTALL_PATH /root/install_pack

# 安装neovim
RUN tar -zxvf ${SOURCE_PATH}/${NVIM_NAME} -C /opt/
RUN chmod +x /opt/nvim-linux64/bin/nvim
RUN echo 'export PATH=$PATH:/opt/nvim-linux64/bin' >> /root/.bashrc

# 安装flutter
RUN tar -xf ${SOURCE_PATH}/${FLUTTER_NAME} -C /opt/ 
RUN git config --global --add safe.directory /opt/flutter
RUN /opt/flutter/bin/flutter precache
RUN echo 'export PATH=$PATH:/opt/flutter/bin' >> /root/.bashrc

#python
# yaml 格式化
# RUN pip3 install pyyaml -i https://pypi.tuna.tsinghua.edu.cn/simple

# 文件搜索
# RUN add-apt-repository ppa:x4121/ripgrep
# RUN apt update
# RUN apt install ripgrep -y

# 安装go 
RUN tar -zxvf ${SOURCE_PATH}/$GOPACK_NAME -C /opt/
RUN echo 'export PATH=$PATH:/opt/go/bin' >> /root/.bashrc
RUN echo "export GO111MODULE=on" >> /root/.bashrc
RUN echo "export GOPROXY=https://goproxy.cn" >> /root/.bashrc
# 安装 protobuf lsp 
RUN /opt/go/bin/go install github.com/bufbuild/buf-language-server/cmd/bufls@latest
# 安装lazygit
RUN /opt/go/bin/go install github.com/jesseduffield/lazygit@latest


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
RUN mkdir /root/.cargo
RUN cp ${CONFIG_PATH}/config /root/.cargo/config
RUN echo 'export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static' >> /root/.bashrc
RUN curl -o ${CONFIG_PATH}/rustup-init.sh https://sh.rustup.rs
RUN sh ${CONFIG_PATH}/rustup-init.sh -y
RUN source /root/.cargo/env
# 安装cargo nextest 测试工具
RUN curl -LsSf https://get.nexte.st/latest/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin


# 下载nvim配置以及依赖包
RUN git clone https://github.com/ClzSkywalker/starter.git /root/.config/nvim
RUN 7z x ${SOURCE_PATH}/local.7z -o/root/

RUN source /root/.bashrc


CMD [ "bash" ]