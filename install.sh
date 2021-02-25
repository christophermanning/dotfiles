#!/bin/bash
set -euo pipefail

DOTFILES_DIR=~/.dotfiles

cd ~

if [[ "$OSTYPE" == darwin* ]]; then
  # Homebrew https://github.com/Homebrew/install#install-homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle -v

  # load iterm2 preferences
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

  # capslock -> esc (https://developer.apple.com/library/content/technotes/tn2450/_index.html)
  hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'

  # autohide dock
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.dock autohide-time-modifier -float 1
  defaults write com.apple.dock static-only -bool true
  killall Dock

  # bottom right hot corner sleep display
  defaults write com.apple.dock wvous-br-corner -int 10
  echo 'manually set "require password immediately"'

  # update date display
  defaults write com.apple.menuextra.clock "DateFormat" 'EEE d MMM hh:mm a'
  killall SystemUIServer

  # disable alerts
  defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 1
  defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0
  killall SystemUIServer

  # finder
  defaults write com.apple.finder AppleShowAllFiles YES
  defaults write com.apple.finder NewWindowTarget -string "PfHm"
  defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
  killall Finder

  echo 'manually disable "Automatically adjust brightness"'


  # fonts
  git clone https://github.com/powerline/fonts.git /tmp/fonts
  cd /tmp/fonts
  ./install.sh
  rm -Rf /tmp/fonts

  # enable filevault
  sudo fdesetup enable

  echo 'harden: http://docs.hardentheworld.org/OS/MacOS_10.12_Sierra/index.html'
else
  echo "install packages"
  sudo apt-get update > /dev/null
  sudo apt-get -y install unattended-upgrades git curl tree htop ctags tmux tig silversearcher-ag ethtool xclip zsh mtr vim > /dev/null

  echo "install rcm"
  pushd /tmp
  wget -q -N https://thoughtbot.github.io/rcm/debs/rcm_1.3.0-1_all.deb
  sha=$(sha256sum rcm_1.3.0-1_all.deb | cut -f1 -d' ')
  [ "$sha" = "2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d" ] && \
  sudo dpkg -i rcm_1.3.0-1_all.deb
  popd
fi

echo "disable last login terminal prompt"
touch ~/.hushlogin

echo "dotfiles install to $DOTFILES_DIR"
if [ $(hostname) = "dotfiles-test" ]; then
  rm -Rf $DOTFILES_DIR
  cp -R /vagrant $DOTFILES_DIR
else
  if [ -d "$DOTFILES_DIR" ]; then
    git pull
  else
    # https clone so a login isn't required
    git clone --quiet https://github.com/christophermanning/dotfiles.git $DOTFILES_DIR
  fi
fi
env RCRC=$DOTFILES_DIR/rcrc rcup

echo "vim-plug install"
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugInstall --sync' +qa

echo "zprezto install"
if [ -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git pull --quiet
else
  git clone --quiet --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

echo "change shell to zsh"
sudo chsh -s /bin/zsh $USER

# setup local files (if there is a tty)
if [ -t 1 ]; then
  touch ~/.zshrc.local

  echo "Please enter git name: "
  read git_name
  echo "export GIT_AUTHOR_NAME=\"$git_name\" && export GIT_COMMITTER_NAME=\$GIT_AUTHOR_NAME" >> ~/.zshrc.local

  echo "Please enter git email: "
  read git_email
  echo "export GIT_AUTHOR_EMAIL=\"$git_email\" && export GIT_COMMITTER_EMAIL=\$GIT_AUTHOR_EMAIL" >> ~/.zshrc.local

  if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "$git_email"
    ssh-add ~/.ssh/id_ed25519
  fi

  read -p "Install ubuntu_gui?" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    $DOTFILES_DIR/install_ubuntu_gui.sh
  fi
fi

# install private packages
[[ -f install_private.sh ]] && ./install_private.sh

if [[ "$OSTYPE" != darwin* ]]; then
  sudo apt-get -y autoremove > /dev/null
fi
