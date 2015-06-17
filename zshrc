# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Uncomment the following line to disable auto-setting terminal title.
# for tmuxinator
DISABLE_AUTO_TITLE="true"

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# GO
export GOPATH=~/workspace/go
export PATH=$PATH:$GOPATH/bin

# NPM
export PATH=$PATH:~/.npm/bin

# VI
export EDITOR='vi'
bindkey -v
export KEYTIMEOUT=1
bindkey '^r' history-incremental-search-backward

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias R='R --quiet'
alias xc='xclip -selection clipboard'
alias tig='tig status'

# directory aliases
alias l='ls -lah'

# git aliases
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
alias ggpush='git push origin $(current_branch)'
alias gc='git commit -v'
alias gl='git pull'
alias gst='git status'
alias gco='git checkout'
alias gcm='git checkout master'
alias gd='git diff'

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
