#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles_old
files="gemrc gdbinit gitconfig gitignore_global irbrc Rprofile tmux.conf vimrc.after Xmodmap zshrc"

echo -n "Creating $olddir for backup of any existing dotfiles in ~ "
mkdir -p $olddir

for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file $olddir
  echo "Creating symlink to $file in home directory."
  ln -s $dir/.$file ~/.$file
done
