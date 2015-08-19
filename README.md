# dotfiles

## Install

single command to download, verify, and run:

```bash
pushd /tmp && \
wget -N https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
chmod u+x install.sh && \
sha=$(sha256sum install.sh | cut -f1 -d' ') && \
[ "$sha" = "11f6bf9965f6feadf4fcb36c66b7bbc115d2e09995601fba59ae62a3d93309b5" ] && \
./install.sh &&\
popd
```

## Components

  - [rcm](https://github.com/thoughtbot/rcm) for rc file (dotfile) management
  - zsh
  - [Prezto](https://github.com/sorin-ionescu/prezto) a configuration framework for Zsh
  - vim
  - [vim-plug](https://github.com/junegunn/vim-plug) a minimalist vim plugin manager
