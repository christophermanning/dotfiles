# dotfiles

## Install

single command to download, verify, and run:

```bash
pushd /tmp && \
wget -N https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
chmod u+x install.sh && \
sha=$(shasum install.sh | cut -f1 -d' ') && \
[ "$sha" = "a04a99160442de3a599a0ff00cf3079eeca22377" ] && \
./install.sh && \
popd
```

## Testing

Run `vagrant up` to ensure the install.sh script works correctly.

## Components

  - [rcm](https://github.com/thoughtbot/rcm) for rc file (dotfile) management
  - vim
    - [vim-plug](https://github.com/junegunn/vim-plug) a minimalist vim plugin manager
  - zsh
    - [Prezto](https://github.com/sorin-ionescu/prezto) a configuration framework for Zsh
