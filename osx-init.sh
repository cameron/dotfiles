#! /bin/bash

# TODO
# - auto link
#   - iterm2 keymap
#   - rectangle settings

# homebrew
which brew 2> /dev/null
if [[ $? != 0 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "************"
  echo "[osx-init] Follow the instructions above for adding brew to your path, and then re-run $0"
  exit 0
fi


# apps
brew install dash
brew install alfred
brew install google-chrome
brew install spotify
brew install slack
brew install iterm2
brew install obsidian
brew install rectangle

# unix
brew install emacs
brew install coreutils
brew services start emacs
brew install pyenv
brew install tree
brew install gh
brew install tmux
brew install ag
brew install telnet
brew install entr
brew install httpie
brew install duf
brew install bottom

# fish shell
brew install fish fd bat fzf
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install PatrickF1/fzf.fish
echo "/opt/homebrew/bin/fish " >> /etc/shells
chsh  -s /opt/homebrew/bin/fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

echo "
Manual Things
 Settings
 - three-finger drag
 - tap to click
 - shrink + auto hide dock
 - swap ctrl + caps
 - option as meta in iTerm
 - key repeat fast
 - key repeat delay short
 - shortcuts
   - disable spotlight
 - finder
   - show path bar

 Apps
 - docker
 - rectangle prefs
 - alfred snippets
 - iTerm2 keys
" >> TODO

echo "You have a TODO list in ./TODO"
cat TODO
