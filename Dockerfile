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
 cron \
 wget \
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
 && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O | zsh
COPY ./vimrc /root/.vimrc
COPY ./monokai.vim /root/.vim/colors
COPY ./molokai.vim /root/.vim/colors
COPY ./ycm_extra_conf.py /root/.ycm_extra_conf.py
RUN vim +PluginInstall +qall


# Install YouCompleteMe
# Reference https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
RUN /root/.vim/bundle/YouCompleteMe/install.py --java-completer
