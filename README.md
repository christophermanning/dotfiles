# Install

    cd ~
    sudo apt-get -y install git
    git clone git://github.com/christophermanning/dotfiles.git ~/.dotfiles
    pushd .dotfiles
    chmod u+x install.sh 
    ./install.sh
    popd
    rcup rcrc
    rcup
    git submodule init
    git submodule update

## Add vim plugin

    git submodule add https://github.com/tpope/vim-pathogen.git ~/.dotfiles/vim/bundle/vim-pathogen

## Remove vim plugin

    git submodule deinit ~/.dotfiles/vim/bundle/plugin.vim
    git rm ~/.dotfiles/vim/bundle/plugin.vim

## Update All Git Submodules

    git submodule foreach git pull
