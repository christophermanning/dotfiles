# dotfiles

## Install

single command to download, verify, and run:

```bash
pushd /tmp && \
wget -N https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
chmod u+x install.sh && \
sha=$(sha256sum install.sh | cut -f1 -d' ') && \
[ "$sha" = "be10f4f2c8c6d6ba52839ee945c11ba6a40d17e71b49f3ea4e54667c4ef3ad00" ] && \
./install.sh &&\
popd
```

## Components

  - [rcm](https://github.com/thoughtbot/rcm) for rc file (dotfile) management
  - zsh
  - [Prezto](https://github.com/sorin-ionescu/prezto) a configuration framework for Zsh
  - vim
  - [vim-plug](https://github.com/junegunn/vim-plug) a minimalist vim plugin manager
