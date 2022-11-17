#!/bin/zsh
# update_local.sh

# This shell script matches the local configuration to the dotfiles repo
# It should be run within the dotfiles repo

echo "Updating local configuration to match dotfiles repo"

is_m1=0
if [[ $(sysctl -n machdep.cpu.brand_string) =~ "Apple M1" ]]; then
    is_m1=1
fi

if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Make sure you have the latest
git pull --rebase

# Install dependencies from Brewfile
if [ "$is_m1" = "0" ] || [ "$(arch)" = "arm64" ]; then
    brew bundle install -f Brewfile-native
fi

if [ "$is_m1" = "1" ] && [ "$(arch)" = "i386" ]; then
    brew bundle install -f Brewfile-i386
fi


# Check if anything in brew is outdated
brew update

echo 
echo "The following are pinned and will be ignored if you upgrade"
echo "To unpin use bup <formula>"
brew list --pinned

echo "Listing outdated"
brew outdated

# Ask before upgrading
if read -q "choice?Enter Y/y to upgrade all, or upgrade individually with brew upgrade <formula>: ";
then
    echo "Upgrading brew formulae and casks"
    brew upgrade
    brew cu
else
    echo
    echo "'$choice' not 'Y' or 'y'. Skipping on"
fi

# Copy and source ~/.zshrc
cp .zshrc ~/.zshrc
cp -R .zsh/* ~/.zsh
cp .zshenv ~/.zshenv

source ~/.zshrc
source ~/.zshenv

# Copy git config
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global

# Copy configs
cp -R .config/* ~/.config

# Install extensions for VSCode
# https://unix.stackexchange.com/questions/149726/how-to-parse-each-line-of-a-text-file-as-an-argument-to-a-command
# < file tr '\n' '\0' | xargs -0 -I{} command --option {} this shell script can do it
< vscode/extensions.txt tr '\n' '\0' | xargs -0 -I{} code --install-extension {}

# Copy the template settings file to the system location
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"