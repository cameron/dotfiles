#! /bin/bash

# New Mac Setup

# Settings (currently manual)
# - three-finger drag
# - tap to click
# - auto hide dock
# - swap ctrl + caps
# - option as meta in Terminal
# - key repeat

# Manual Things
# - software
#   - spectacles
#   - simplenote
#   - docker


# homebrew
which brew 2> /dev/null
if [[ $? != 0 ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "*****"
    echo "Following the instructions for adding brew to your path and re-run $0"
    exit 0
fi


# apps
brew install dash
brew install alfred
brew install google-chrome
brew install spotify
brew install slack
brew install iterm2

# fish shell
brew install fish fd bat fzf
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install PatrickF1/fzf.fish
echo "/opt/homebrew/bin/fish " >> /etc/shells
chsh  -s /opt/homebrew/bin/fish

# other packages
brew install emacs
brew install coreutils
brew services start emacs
brew install gh
brew install tmux
brew install ag
brew install telnet
