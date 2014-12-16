#!/bin/bash

# only run if there are no other files to to be committed
if [[ -n $(git status -s) ]]; then
  echo "working tree already has changes; commit them first"
  exit
fi

echo "Please enter the vim plugin git clone url: "
read url
name=$(echo $url | sed 's%^.*/\([^/]*\)\.git$%\1%g')

pushd ~/.dotfiles
git submodule add $url vim/bundle/$name
git add -A
git commit -m "Install $url bundle as $name submodule."
rcup
