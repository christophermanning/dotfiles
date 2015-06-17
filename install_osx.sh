ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install caskroom/cask/brew-cask
brew update

brew install git curl tree htop ctags tmux tig the_silver_searcher

brew cask install seil
# https://pqrs.org/osx/karabiner/seil.html#usage

brew cask install iterm2 vagrant virtualbox

brew install zsh
chsh -s /bin/zsh

brew install macvim --override-system-vim

brew tap thoughtbot/formulae
brew install rcm
