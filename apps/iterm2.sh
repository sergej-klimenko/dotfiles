#!/bin/zsh

###############################################################################
# iTerm2
###############################################################################

mode=$1

echo "iTerm2 ($mode)"

cd apps/iterm2

if [ "$mode" = "local" ]; then
    cp com.googlecode.iterm2.plist "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
    cp *.itermcolors ~/.config/iterm2
fi

if [ "$mode" = "remote" ]; then
    cp "$HOME/Library/Preferences/com.googlecode.iterm2.plist" com.googlecode.iterm2.plist
    cp ~/.config/iterm2/*.itermcolors ./
fi

cd -