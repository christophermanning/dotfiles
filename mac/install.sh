#!/bin/bash
set -euo pipefail

cd ~

# enable filevault
sudo fdesetup enable

# Homebrew https://github.com/Homebrew/install#install-homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle -v

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
pushd ~/Library/Fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontMono-Regular.ttf
popd
