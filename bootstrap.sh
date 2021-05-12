#!/bin/bash

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.bash_profile
eval "$(/opt/homebrew/bin/brew shellenv)"

# GUI Applications
# brew install --cask brave-browser
# brew install --cask chromium
# brew install --cask discord
# brew install --cask keepassxc
# brew install --cask gitkraken
# brew install --cask google-chrome
# brew install --cask iterm2
# brew install --cask openemu
# brew install --cask paragon-ntfs
# brew install --cask plex-media-server
# brew install --cask shotcut
# brew install --cask spotify
# brew install --cask steam
# brew install --cask sublime-text
# brew install --cask transmission
# brew install --cask vagrant
# brew install --cask virtualbox
# brew install --cask visual-studio-code
# brew install --cask vlc

# CLI Applications
# brew install awscli
# brew install docker
# brew install docker-compose
# brew install git
# brew install node
# brew install python@3.9

# Config
# git config --global init.defaultBranch "main"