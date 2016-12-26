#!/bin/bash

set -e

cd ~

if [[ "$OSTYPE" == darwin* ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew install caskroom/cask/brew-cask
  brew update

  brew install git curl tree htop ctags tmux tig the_silver_searcher mtr colordiff iproute2mac

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

  # install updates since release
  sudo unattended-upgrades -v

  # install preferred packages
  sudo apt-get -y install git curl tree htop ctags tmux tig silversearcher-ag ethtool xclip zsh mtr

  # install rcm
  pushd /tmp
  wget -N https://thoughtbot.github.io/rcm/debs/rcm_1.3.0-1_all.deb
  sha=$(sha256sum rcm_1.3.0-1_all.deb | cut -f1 -d' ')
  [ "$sha" = "2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d" ] && \
  sudo dpkg -i rcm_1.3.0-1_all.deb
  popd

  if [ "$GUI" == 1 ]; then
    # install gui packages
    sudo apt-get -y install vim-gnome chromium-browser

    # install virtualbox
    sudo tee /etc/apt/sources.list.d/virtualbox.list <<EOF
deb http://download.virtualbox.org/virtualbox/debian xenial contrib
EOF

    pushd /tmp && \
    wget -N https://www.virtualbox.org/download/oracle_vbox_2016.asc && \
    fingerprint=$(gpg --with-fingerprint oracle_vbox_2016.asc | grep Key |  awk -F'= ' '{print $2}') && \
    [ "$fingerprint" = "B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF" ] && \
    sudo apt-key add oracle_vbox_2016.asc && \
    popd

    sudo apt-get update
    sudo apt-get -y install virtualbox-5.1

    # install vagrant
    pushd /tmp
    wget -N https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb
    sha=$(sha256sum vagrant_1.9.1_x86_64.deb | cut -f1 -d' ')
    [ "$sha" = "d006d6227e049725b64d8ba3967f0c82460a403ff40230515c93134d58723150" ] && \
    sudo dpkg -i vagrant_1.9.1_x86_64.deb
    popd

    # install fonts
    mkdir ~/.fonts
    pushd ~/.fonts
    wget -N https://github.com/powerline/fonts/raw/master/Meslo/Meslo%20LG%20M%20DZ%20Regular%20for%20Powerline.otf
    fc-cache -vf ~/.fonts
    popd

    # terminal preferences
    uid=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d '\''') && \
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ foreground-color 'rgb(131,148,150)' && \
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-system-font false && \
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-theme-colors false && \
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-theme-transparency false && \
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ font 'Meslo LG M DZ for Powerline 12' && \
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ scrollback-unlimited true && \
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ background-color 'rgb(0,43,54)'

    # desktop preferences
    gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Software.desktop']"
    gsettings set org.gnome.shell favorite-apps "['chromium-browser.desktop', 'org.gnome.Nautilus.desktop', 'gnome-terminal.desktop']"

    # disable bluetooth
    rfkill block bluetooth

    # disable touchpad
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
    sudo modprobe -r psmouse && sudo modprobe psmouse

    # caps to escape
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

    # 12 hour clock
    gsettings set org.gnome.desktop.interface clock-format 12h

    # TODO: disable alert sound
    # pactl play-sample audio-volume-change
    gsettings set org.gnome.desktop.sound event-sounds false
  fi
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
  touch ~/.zshrc.local

  echo "Please enter git name: "
  read git_name
  echo "export GIT_AUTHOR_NAME=\"$git_name\" && export GIT_COMMITTER_NAME=\$GIT_AUTHOR_NAME" >> ~/.zshrc.local

  echo "Please enter git email: "
  read git_email
  echo "export GIT_AUTHOR_EMAIL=\"$git_email\" && export GIT_COMMITTER_EMAIL=\$GIT_AUTHOR_EMAIL" >> ~/.zshrc.local

  if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -C "$git_email"
    ssh-add ~/.ssh/id_rsa
  fi
fi

# install private packages
[[ -f install_private.sh ]] && ./install_private.sh

# cleanup
sudo apt-get -y autoremove
