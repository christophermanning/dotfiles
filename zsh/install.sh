#!/bin/bash
set -euo pipefail

# apt-get install -y zsh

# https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#manual-installation
export ZSH=$HOME/.oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git --depth 1 $ZSH
chsh -s $(which zsh)

touch ~/.zshrc.local
