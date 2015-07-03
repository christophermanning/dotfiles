# Install

    # single command to download, verify, and run
    pushd /tmp && \
    wget -N https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
    chmod u+x install.sh && \
    sha=$(sha256sum install.sh | cut -f1 -d' ') && \
    [ "$sha" = "e95994ecd28d355a8122bded234e2a78f088c52ca8d7aa7b75716e098df593d2" ] && \
    ./install.sh &&\
    popd

# Components

  - [rcm](https://github.com/thoughtbot/rcm) for rc file (dotfile) management
  - zsh
  - [Prezto](https://github.com/sorin-ionescu/prezto) a configuration framework for Zsh
  - vim
  - [vim-plug](https://github.com/junegunn/vim-plug) a minimalist vim plugin manager
