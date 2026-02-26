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
# brew install --cask discord
brew install --cask gitkraken
# brew install --cask keepassxc # replaced by Strongbox
# brew install --cask libreoffice
# brew install --cask openemu
brew install --cask paragon-ntfs
# brew install --cask plex-media-server
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
brew install chromium
brew install docker
brew install docker-compose
brew install git

# Install Node
#  source: https://stackoverflow.com/a/67529751
brew install nvm
mkdir ~/.nvm
export NVM_DIR="$HOME/.nvm" # NVM Install Path
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
nvm install --lts # Install latest LTS

# NodeJS Globals
npm i -g tree

# Install Python
brew install uv
export UV_PYTHON_INSTALL_DIR="$HOME/.uv" # Python Install Path
uv python install --default # Install latest LTS

# Config
git config --global user.name "Evan Plaice"
git config --global user.email evanplaice@gmail.com
git config --global init.defaultBranch "main"