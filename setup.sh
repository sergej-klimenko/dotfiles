#!/bin/zsh

DOTFILES_REPO=https://github.com/sergej-klimenko/dotfiles.git

# See http://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
echo "Checking Xcode CLI tools"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  echo "Xcode CLI tools not found. Installing them..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    tail -n 1 | sed 's/^[^C]* //')
    echo "Prod: ${PROD}"
  softwareupdate -i "$PROD" --verbose;
else
  echo "Xcode CLI tools OK"
fi

BREW_HOME=/opt/homebrew

# Install homebrew
# https://brew.sh/
if [ ! -d "$BREW_HOME" ]; then
	BREW_HOME=~/.local/Homebrew
	LOCAL_BIN=~/.local/bin
	if [ ! -d "$BREW_HOME" ]; then
		echo "Installing Homebrew..."
		# install as user
		mkdir -p $BREW_HOME && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $BREW_HOME
		mkdir -p $LOCAL_BIN && ln -s $BREW_HOME/bin/brew $LOCAL_BIN
		export PATH="$PATH:$LOCAL_BIN"
	fi
fi

if ! command -v git &> /dev/null
then
    # Install git
	brew install git

	# Install git credential manager
	brew tap microsoft/git
	brew install --cask git-credential-manager-core
fi

# Remove the dotfiles repo if it already exists and restore from the source
if [ -d $HOME/dotfiles ]; then rm -rf $HOME/dotfiles ; fi
cd $HOME && git clone $DOTFILES_REPO
cd dotfiles
