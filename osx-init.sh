#! /bin/bash

# New Mac Setup

# Settings (currently manual)
# - three-finger drag
# - tap to click
# - auto hide dock
# - swap ctrl + caps
# - option as meta in Terminal
# - key repeat

# Apps (manual)
# - spectacles
# - simplenote


# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# apps
brew tap caskroom/cask
brew cask install dash
brew cask install alfred
brew cask install google-chrome
brew cask install spotify
brew cask install slack
brew cask install iterm2

# packages
brew cask install emacs
brew services start emacs
brew install hub # also needs an alias 
brew install tmux

