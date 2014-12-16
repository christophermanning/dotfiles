#!/bin/bash

# install rbenv and ruby-build
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
touch ~/.irb_history

rbenv install 2.1.5
rbenv global  2.1.5

# install helpful gems
gem install --no-ri --no-rdoc bundler tmuxinator hookup
rbenv rehash
