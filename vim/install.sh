#!/bin/bash
set -euo pipefail

# apt-get install -y vim curl git

echo "vim-plug install"
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/d977fa37866a48f1001b5adaadbbdbf88baf35e8/plug.vim
vim +'PlugInstall --sync' +qa
