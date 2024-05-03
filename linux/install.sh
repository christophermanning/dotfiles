#!/bin/bash
set -euo pipefail

echo "install packages"
apt-get update
apt-get -y install unattended-upgrades rcm git curl tree htop ctags tmux tig silversearcher-ag ethtool xclip zsh mtr vim
