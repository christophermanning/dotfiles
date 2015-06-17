# Install

    # single command to download, verify, and run
    pushd /tmp && \
    wget https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
    chmod u+x install.sh && \
    sha=$(sha256sum install.sh | cut -f1 -d' ') && \
    [ "$sha" = "f5973af370b19c36795d6ac3f33eb1b42966fb17b4298163992dcfb09cbc5f0f" ] && \
    ./install.sh &&\
    popd

## Add vim plugin

    ./install_vim_plugin.sh
    > https://github.com/tpope/vim-pathogen.git

## Remove vim plugin

    git submodule deinit ~/.dotfiles/vim/bundle/plugin.vim
    git rm ~/.dotfiles/vim/bundle/plugin.vim

## Update All Git Submodules

    git submodule foreach git pull
