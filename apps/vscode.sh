#!/bin/zsh

###############################################################################
# VSCode
###############################################################################

mode=$1

echo "VSCode ($mode)"

cd apps/vscode

if [ "$mode" = "local" ]; then
    # Install extensions for VSCode
    # https://unix.stackexchange.com/questions/149726/how-to-parse-each-line-of-a-text-file-as-an-argument-to-a-command
    # < file tr '\n' '\0' | xargs -0 -I{} command --option {} this shell script can do it
    < extensions.txt tr '\n' '\0' | xargs -0 -I{} code --install-extension {}

    # Copy the template settings file to the system location
    cp settings.json "$HOME/Library/Application Support/Code/User/settings.json"
fi

if [ "$mode" = "remote" ]; then
    # Overwrite the extensions list with the currently installed extensions
    code --list-extensions > extensions.txt

    #The lines below uninstall all extensions
    # rm -rf ~/.vscode/extensions
    # mkdir ~/.vscode/extensions

    # Overwrite settings.json with the local VSCode settings file
    cp "$HOME/Library/Application Support/Code/User/settings.json" settings.json
fi

cd -