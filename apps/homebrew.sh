#!/bin/zsh

###############################################################################
# Homebrew
###############################################################################

mode=$1

echo "Homebrew ($mode)"

cd apps/homebrew 

if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

if [ "$mode" = "local" ]; then
    # Make sure we are using the latest Homebrew
    brew update

    # Install dependencies from Brewfile
    brew bundle install -f Brewfile-native

    if [ "$(arch)" = "i386" ]; then
      brew bundle install -f Brewfile-i386
    fi

    # Upgrading brew formulae and casks
    brew upgrade && brew cu

    # Remove outdated versions from the cellar including casks
    brew cleanup && brew prune
fi


# Update the Brewfile
if [ "$mode" = "remote" ]; then
    brew bundle dump --force

    grep -Fvxf Brewfile-i386 Brewfile > Brewfile-native && rm Brewfile
fi

cd -
