# dotfiles

## Install

single command to download, verify, and run:

```bash
pushd /tmp && \
wget -N https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
chmod u+x install.sh && \
sha=$(shasum install.sh | cut -f1 -d' ') && \
[ "$sha" = "64474f8bcad3426b9cc90b6725e26bdb489d03ca" ] && \
./install.sh && \
popd
```

## Testing

`make test`

## Components

  - [rcm](https://github.com/thoughtbot/rcm) for rc file (dotfile) management
  - vim
    - [vim-plug](https://github.com/junegunn/vim-plug) a minimalist vim plugin manager
  - zsh
    - [Prezto](https://github.com/sorin-ionescu/prezto) a configuration framework for Zsh
