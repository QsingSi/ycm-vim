FROM ubuntu:18.04
MAINTAINER <wzq67675@163.com>

WORKDIR /root

RUN apt-get -y update && apt-get -y install locales \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && /usr/sbin/update-locale LANG=en_US.UTF-8 \
 && apt clean \
 && apt autoremove \
 && rm -rf /var/lib/apt/lists/*

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Install dependencies
RUN apt-get -y update && apt-get -y install vim \
 git \
 build-essential \
 cmake \
 python-dev \
 python3-dev \
 python3-pip \
 zsh \
 git-core \
 astyle \
 cron \
 wget \
 lrzsz \
 unrar \
 zip \
 && apt -qy autoremove \
 && apt -qy clean \
 && rm -rf /var/lib/apt/lists/* 

# Install Vundle
# Reference https://github.com/VundleVim/Vundle.vim#quick-start
RUN git config --global http.sslVerify false \
 && git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim \
 && chsh -s `which zsh` \
 && service cron start \
 && mkdir /root/.vim/colors \
 && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh || true \
 && mkdir /root/.pip
COPY ./vimrc /root/.vimrc
COPY ./zshrc /root/.zshrc
COPY ./monokai.vim /root/.vim/colors
COPY ./molokai.vim /root/.vim/colors
COPY ./pip.conf /root/.pip
COPY ./ycm_extra_conf.py /root/.ycm_extra_conf.py
COPY ./sources.list /etc/apt 
RUN vim +PluginInstall +qall


# Install YouCompleteMe
# Reference https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
RUN python3 /root/.vim/bundle/YouCompleteMe/install.py --clang-completer
