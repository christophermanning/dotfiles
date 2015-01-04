#!/bin/bash

sudo apt-get -y update

# install packages
sudo apt-get -y install curl tree htop ctags tmux tig ack-grep ethtool xclip zsh vim-gnome gnome-tweak-tool

# install rcm
wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb
sudo dpkg -i rcm_1.2.3-1_all.deb

# write git env variables; ~/.zshenv is not updated from dotfiles
echo "Please enter git name: "
read git_name
echo "export GIT_AUTHOR_NAME=\"$git_name\" && export GIT_COMMITTER_NAME=\$GIT_AUTHOR_NAME" >> ~/.zshenv

echo "Please enter git email: "
read git_email
echo "export GIT_AUTHOR_EMAIL=\"$git_email\" && export GIT_COMMITTER_EMAIL=\$GIT_AUTHOR_EMAIL" >> ~/.zshenv

# divert ack to ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# install chromium and make default
sudo apt-get -y install chromium-browser
sudo ln -s /etc/alternatives/x-www-browser /usr/bin/google-chrome

# install nodejs
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get -y install nodejs

# install oh-my-zsh
curl -L http://install.ohmyz.sh | sh
chsh -s /bin/zsh
