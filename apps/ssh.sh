#!/bin/zsh

###############################################################################
# SSH
###############################################################################

mode=$1

echo "SSH ($mode)"

if [ "$mode" = "remote" ]; then
    return 0
fi

# Generate SSH keys for GitHub, GitLab
   
## Only one key is needed per computer
## The label is MacBook model

label=$(sysctl hw.model | cut -d\  -f2 | cut -d, -f1)

ssh-keygen -t rsa -b 4096 -f ~/.ssh/$label -C $label

ssh-add ~/.ssh/$label

cat ~/.ssh/$label.pub | pbcopy

#gh ssh-key add ~/.ssh/$label.pub -t $label

echo "Host *\n\tUseKeychain yes\n\tAddKeysToAgent yes\n\tIdentityFile ~/.ssh/$label" >> ~/.ssh/config