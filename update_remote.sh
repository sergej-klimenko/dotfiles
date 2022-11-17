#!/bin/zsh
# update_remote.sh

# This shell script copies the local settings from the mac to the dotfiles repo
# It should be run within the dotfiles repo

echo "Updating dotfiles repository with local configuration"

# Update the Brewfile
brew bundle dump --force

grep -Fvxf Brewfile-i386 Brewfile > Brewfile-native && rm Brewfile

# Check if anything in brew is outdated
brew update

echo 
echo "The following are pinned and will be ignored if you upgrade"
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

# Update .zshrc
cp ~/.zshrc .zshrc
cp -R ~/.zsh/* .zsh
cp ~/.zshenv .zshenv 

# Copy git config
cp ~/.gitconfig .gitconfig 
cp ~/.gitignore_global .gitignore_global 

# Copy configs
cp -R ~/.config/helix/* .config/helix
cp ~/.config/iterm2/*.itermcolors .config/iterm2
cp -R ~/.config/mc/* .config/mc 
cp -R ~/.config/nvim/* .config/nvim
cp ~/.config/* .config 2>/dev/null


# Overwrite the extensions list with the currently installed extensions
code --list-extensions > vscode/extensions.txt

#The lines below uninstall all extensions
# rm -rf ~/.vscode/extensions
# mkdir ~/.vscode/extensions

# Overwrite settings.json with the local VSCode settings file
cp "$HOME/Library/Application Support/Code/User/settings.json" vscode/settings.json