# Install

    cd ~
    sudo apt-get -y install git
    git clone git://github.com/christophermanning/dotfiles.git ~/.dotfiles
    pushd .dotfiles
    git submodule init
    git submodule update
    chmod u+x install.sh 
    ./install.sh
    popd
    rcup rcrc
    rcup

## Add vim plugin

    ./install_vim_plugin.sh
    > https://github.com/tpope/vim-pathogen.git

## Remove vim plugin

    git submodule deinit ~/.dotfiles/vim/bundle/plugin.vim
    git rm ~/.dotfiles/vim/bundle/plugin.vim

## Update All Git Submodules

    git submodule foreach git pull
