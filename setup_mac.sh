# setup_mac.sh

DOTFILES_REPO=https://github.com/sergej-klimenko/dotfiles.git

BREW_HOME=/usr/local/Homebrew
if [ "$(arch)" = "arm64" ]; then
    BREW_HOME=/opt/homebrew
fi

# Install homebrew
# https://brew.sh/
if [ ! -d "$BREW_HOME" ]; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v git &> /dev/null
then
    # Install git to get the brewfile
	brew install git

	# Install git credential manager
	brew tap microsoft/git
	brew install --cask git-credential-manager-core
fi

# Remove the dotfiles repo if it already exists and restore from the source
if [ -d dotfiles ]; then rm -rf dotfiles ; fi
git clone $DOTFILES_REPO
cd dotfiles
