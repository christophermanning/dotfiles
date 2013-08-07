#!/bin/bash

sudo apt-get -y update

# command line tools for transferring data with URL
sudo apt-get -y install curl wget

# install dependencies
sudo apt-get -y install build-essential openssl libreadline6 libreadline6-dev \
libyaml-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libmysqlclient-dev ruby-dev \
libxml2-dev autoconf libc6-dev libncurses5-dev automake libtool bison  \
libpq-dev bison libxslt1-dev zlib1g-dev libreadline-dev libxslt-dev \
libxml2-dev libcurl4-openssl-dev libpcre3-dev

# helpful tools
sudo apt-get -y install tree htop ctags tmux tig graphviz ack-grep r-base paman ethtool

# install zsh
sudo apt-get -y install zsh

# write placeholder for git email; ~/.zshenv is not updated from dotfiles
echo 'export GIT_AUTHOR_EMAIL="" && export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL' >> ~/.zshenv

# install chromium
sudo apt-get -y install chromium-browser
sudo ln -s /etc/alternatives/x-www-browser /usr/bin/google-chrome

# install oh-my-zsh framework
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# Set zsh as your default shell
chsh -s /bin/zsh

# install rbenv
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
touch ~/.irb_history
source ~/.zshrc

rbenv install 2.0.0-p247
rbenv global  2.0.0-p247

# install helpful gems
gem install bundler tmuxinator hookup
rbenv rehash

# divert ack to ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# install vim and gvim
sudo apt-get -y install vim vim-gnome

# install janus
curl -Lo- https://bit.ly/janus-bootstrap | bash

# update dotfiles
~/dotfiles/update.sh

sudo apt-get -y upgrade

exec $SHELL
