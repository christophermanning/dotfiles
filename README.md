# Install

    pushd /tmp
    curl -L https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh
    chmod u+x install.sh
    sha=$(sha256sum install.sh | cut -f1 -d' ')
    [ "$sha" = "e679bfa4c03776a710372b6632e778e2eedc3865b24c1f63da851dbb905b4077" ] && ./install.sh
    popd

## Add vim plugin

    ./install_vim_plugin.sh
    > https://github.com/tpope/vim-pathogen.git

## Remove vim plugin

    git submodule deinit ~/.dotfiles/vim/bundle/plugin.vim
    git rm ~/.dotfiles/vim/bundle/plugin.vim

## Update All Git Submodules

    git submodule foreach git pull
