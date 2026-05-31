#!/bin/bash

# Add XDG Config
mkdir -p ~/{.config,.cache,.local/share,.local/state}
echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> ~/.zshrc
echo 'export XDG_CACHE_HOME="$HOME/.cache"' >> ~/.zshrc
echo 'export XDG_DATA_HOME="$HOME/.local/share"' >> ~/.zshrc
echo 'export XDG_STATE_HOME="$HOME/.local/state"' >> ~/.zshrc
cat > ~/Library/LaunchAgents/setenv.XDG_CONFIG.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>setenv.XDG_CONFIG</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/launchctl</string>
        <string>setenv</string>
        <string>XDG_CONFIG_HOME</string>
        <string>/Users/evanplaice/.config</string>
        <string>setenv</string>
        <string>XDG_CACHE_HOME</string>
        <string>/Users/evanplaice/.cache</string>
        <string>setenv</string>
        <string>XDG_DATA_HOME</string>
        <string>/Users/evanplaice/.local/share</string>
        <string>setenv</string>
        <string>XDG_STATE_HOME</string>
        <string>/Users/evanplaice/.local/state</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF
launchctl load ~/Library/LaunchAgents/setenv.XDG_CONFIG.plist

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# Prereqs
softwareupdate --install-rosetta

# GUI Applications
brew install --cask brave-browser
brew install --cask ungoogled-chromium
xattr -cr /Applications/Chromium.app
brew install --cask claude-code
# brew install --cask discord
# brew install --cask gitkraken
brew install --cask ghostty
# brew install --cask keepassxc # replaced by Strongbox
# brew install --cask libreoffice
# brew install --cask openemu
brew install --cask paragon-ntfs
# brew install --cask plex-media-server
# brew install --cask postman
brew install --cask rectangle
brew install --cask shotcut
brew install --cask slack
brew install --cask spotify
# brew install --cask steam
brew install --cask sublime-text
brew install --cask transmission
brew install --cask vagrant
brew install --cask virtualbox
brew install --cask vscodium
brew install --cask vlc
brew install --cask warp

# CLI Applications
brew install awscli
brew install chromium
brew install deno
brew install docker
brew install docker-compose
brew install git
brew install gh

# GPG Setup
brew install gpg
brew install pinentry-mac
echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
pinentry-program /opt/homebrew/bin/pinentry-mac
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
# echo "test" | gpg --clearsign

# Install Node
#  source: https://stackoverflow.com/a/67529751
brew install nvm
mkdir ~/.nvm
export NVM_DIR="$HOME/.nvm" # NVM install path
 # load NVM
if [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]; then
    echo '. "$(brew --prefix)/opt/nvm/nvm.sh"' >> ~/.zshrc
    . "$(brew --prefix)/opt/nvm/nvm.sh"
fi
# load NVM bash completions
if [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ]; then
    echo '. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"' >> ~/.zshrc
    . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
fi
nvm install --lts # Install latest LTS

# NodeJS Globals
npm i -g tree

# Install Python
brew install uv
export UV_PYTHON_INSTALL_DIR="$HOME/.uv" # Python Install Path
uv python install --default # Install latest LTS

# Config
npm config set ignore-scripts true
git config --global user.name "Evan Plaice"
git config --global user.email evanplaice@gmail.com
git config --global init.defaultBranch "main"
