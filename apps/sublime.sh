#!/bin/zsh

###############################################################################
# Sublime Text
###############################################################################

mode=$1

echo "Sublime Text ($mode)"

cd apps/sublime

if [ "$mode" = "local" ]; then
    # Install Package Control
    cd "$HOME/Library/Application Support/Sublime Text/Installed Packages" && { curl -sL "https://packagecontrol.io/Package%20Control.sublime-package" -o Package\ Control.sublime-package; cd -; }

    # Install Sublime Text settings
    cp -r ./ "$HOME/Library/Application Support/Sublime Text/Packages/User/" 2>/dev/null

    # Set Sublime Text as default plain text editor
    duti -s com.sublimetext.4 public.plain-text all
fi

if [ "$mode" = "remote" ]; then
    cp -r "$HOME/Library/Application Support/Sublime Text/Packages/User/" ./ 2>/dev/null
fi

cd -