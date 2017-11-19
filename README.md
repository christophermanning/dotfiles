# dotfiles

## Install

single command to download, verify, and run:

```bash
pushd /tmp && \
wget -N https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
chmod u+x install.sh && \
sha=$(shasum install.sh | cut -f1 -d' ') && \
[ "$sha" = "7b96d58fa4f17d862156843ceb077e3977348c07" ] && \
./install.sh && \
popd
```

## Components

  - [rcm](https://github.com/thoughtbot/rcm) for rc file (dotfile) management
  - zsh
  - [Prezto](https://github.com/sorin-ionescu/prezto) a configuration framework for Zsh
  - vim
  - [vim-plug](https://github.com/junegunn/vim-plug) a minimalist vim plugin manager
