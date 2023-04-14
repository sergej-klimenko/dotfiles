#!/bin/zsh

###############################################################################
# Homebrew x86
###############################################################################

mode=$1

if [ "$mode" = "remote" ]; then
    return 0
fi

echo "Homebrew x86 ($mode)"

if [ "$(arch)" = "i386" ]; then
    return 0
fi

# Install Rosetta
if [ $(/usr/bin/pgrep oahd) ]; then 
    echo "Rosetta installed"
else
    softwareupdate --install-rosetta --agree-to-license
fi

eval "$(arch --x86_64 /usr/local/bin/brew shellenv)"

# Make sure we are using the latest Homebrew
arch --x86_64 brew update

# Install dependencies from Brewfile
arch --x86_64 brew bundle install -f installers/homebrew/Brewfile-i386