#!/bin/zsh

###############################################################################
# Shell
###############################################################################

mode=$1

echo "Shell ($mode)"

cd apps/shell

if [ "$mode" = "local" ]; then
    # Copy .zshrc
    cp .zshrc ~/.zshrc
    mkdir -p ~/.zsh && cp -R .zsh/* ~/.zsh
    cp .zshenv ~/.zshenv

    source ~/.zshrc
    source ~/.zshenv

    # Starship
    cp starship.toml ~/.config/starship.toml

    # fd
    mkdir -p ~/.config/fd && cp -R ../fd/* ~/.config/fd

    # Midnight Commander
    mkdir -p ~/.config/mc && cp -R ../mc/* ~/.config/mc

    # Helix
    mkdir -p ~/.config/helix && cp -R ../helix/* ~/.config/helix

    # bat
    mkdir -p ~/.config/bat && cp -R ../bat/* ~/.config/bat

    # Git
    cp ../git/.gitconfig ~/.gitconfig
    cp ../git/.gitignore_global ~/.gitignore_global
    cp ../git/.gitmessage ~/.gitmessage
fi

if [ "$mode" = "remote" ]; then
    # Update .zshrc
    cp ~/.zshrc .zshrc
    cp -R ~/.zsh/* .zsh
    cp ~/.zshenv .zshenv 

    # Starship
    cp ~/.config/starship.toml starship.toml 

    # fd
    cp -R ~/.config/fd/* ../fd

    # Midnight Commander
    cp -R ~/.config/mc/* ../mc

    # Helix
    cp -R ~/.config/helix/* ../helix

    # bat
    cp -R ~/.config/bat/* ../bat

    # Git
    cp ~/.gitconfig ../git/.gitconfig 
    cp ~/.gitignore_global ../git/.gitignore_global
    cp ~/.gitmessage ../git/.gitmessage
fi

cd -