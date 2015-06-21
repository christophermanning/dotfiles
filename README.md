# Install

    # single command to download, verify, and run
    pushd /tmp && \
    wget https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
    chmod u+x install.sh && \
    sha=$(sha256sum install.sh | cut -f1 -d' ') && \
    [ "$sha" = "d9eff7f6175291b313f8a469e86a7e350b71826b28dd789da667e4c346d90cdf" ] && \
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
