#!/bin/bash

set -e

cd ~

if [[ "$OSTYPE" == darwin* ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew install caskroom/cask/brew-cask
  brew update

  brew install git curl tree htop ctags tmux tig the_silver_searcher

  brew cask install seil
  # https://pqrs.org/osx/karabiner/seil.html#usage

  brew cask install iterm2 vagrant virtualbox

  brew install zsh

  brew install macvim --override-system-vim

  brew tap thoughtbot/formulae
  brew install rcm
else
  # install packages
  sudo apt-get -y update
  sudo apt-get -y install git curl tree htop ctags tmux tig silversearcher-ag ethtool xclip zsh vim-gnome gnome-tweak-tool

  # install rcm
  pushd /tmp
  wget -N https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb
  sha=$(sha256sum rcm_1.2.3-1_all.deb | cut -f1 -d' ')
  [ "$sha" = "fb8ec2611cd4d519965b66fcf950bd93d7593773659f83a8612053217daa38b4" ] && \
  sudo dpkg -i rcm_1.2.3-1_all.deb
  popd

  # install chromium and make default
  sudo apt-get -y install chromium-browser
  sudo ln -sf /etc/alternatives/x-www-browser /usr/bin/google-chrome
fi

# dotfiles
if [ $(hostname) = "dotfiles-test" ]; then
  rm -Rf ~/.dotfiles
  cp -R /vagrant ~/.dotfiles
else
  if cd ~/.dotfiles; then
    git pull
  else
    git clone git://github.com/christophermanning/dotfiles.git ~/.dotfiles
  fi
fi
env RCRC=$HOME/.dotfiles/rcrc rcup

# vim-plug install plugins
vim +PlugInstall +qa

# zsh
if cd "${ZDOTDIR:-$HOME}/.zprezto"; then
  git pull
else
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

sudo chsh -s /bin/zsh $USER

# setup local files
if [ -t 1 ]; then
  echo "Please enter git name: "
  read git_name
  echo "export GIT_AUTHOR_NAME=\"$git_name\" && export GIT_COMMITTER_NAME=\$GIT_AUTHOR_NAME" >> ~/.zshrc.local

  echo "Please enter git email: "
  read git_email
  echo "export GIT_AUTHOR_EMAIL=\"$git_email\" && export GIT_COMMITTER_EMAIL=\$GIT_AUTHOR_EMAIL" >> ~/.zshrc.local
fi
