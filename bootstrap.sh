#!/bin/bash

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# Prereqs
softwareupdate --install-rosetta

# GUI Applications
brew install --cask brave-browser
brew install --cask chromium
xattr -cr /Applications/Chromium.app
brew install --cask discord
brew install --cask gitkraken
brew install --cask google-chrome
# brew install --cask keepassxc # replaced by Strongbox
brew install --cask openemu
brew install --cask paragon-ntfs
brew install --cask plex-media-server
brew install --cask rectangle
brew install --cask shotcut
brew install --cask slack
brew install --cask spotify
brew install --cask steam
brew install --cask sublime-text
brew install --cask transmission
brew install --cask vagrant
brew install --cask virtualbox
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask warp

# CLI Applications
brew install awscli
brew install docker
brew install docker-compose
brew install git
brew install -g node
brew install python@3.10

# NodeJS Globals
npm i -g tree

# Config
git config --global user.name "Evan Plaice"
git config --global user.email evanplaice@gmail.com
git config --global init.defaultBranch "main"