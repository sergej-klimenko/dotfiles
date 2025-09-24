# vim: set ft=zsh:

# Suffix alias
alias -s zip=unzip
alias -s {js,json,md,py,rst,toml,tex,txt,yaml,yml}="$EDITOR"
alias -s {doc,docx,html,pdf,ppt,pptx,xls,xlsx}=open
alias -s {gif,jpeg,jpg,png,tiff}=open

alias mc="SHELL=/bin/bash mc"

alias brew86="/usr/local/bin/brew"
alias pyenv86="arch -x86_64 pyenv"
alias goenv86="arch -x86_64 goenv"

# Shell
alias \
  srczsh='source $HOME/.zshrc' \
  cc="clear"

alias -- -='cd -'
alias -g ......='../../../../..'
alias -g .....='../../../..'
alias -g ....='../../..'
alias -g ...='../..'
alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."
alias 0="directory=$(echo '$(dirs -v | cut -c3- | sed s+~+$HOME+ | fzf --delimiter=/ --preview="exa --all --classify --color=always -L=2 -T {} | grep -E \$([ {q} ] && echo {q} | xargs | sed s/\ /\|/g | sed s/$/\|$/g || echo ^) --color=always" --with-nth=4..)') && [ $(echo '$directory') ] && [ -d $(echo '$directory') ] && cd $(echo '$directory')"
alias 1="cd -"
alias 2="cd -2"
alias 3="cd -3"
alias 4="cd -4"
alias 5="cd -5"
alias 6="cd -6"
alias 7="cd -7"
alias 8="cd -8"
alias 9="cd -9"
alias \?="func() { alias | grep $(echo '$@') | bat --language=sh --plain; }; func"

# Git
alias \
  gst='git status' \
  gs='git status' \
  gc='git commit' \
  push='git push' \
  pull='git pull' \
  gd='git diff' \
  gtlist='git describe --tags --abbrev=0' \
  gco='fzf-git-checkout' \
  gcm='git checkout master' \
  gcd='git checkout dev' \
  gcn='git checkout -b' \
  gt='gitui'

alias gaa="git add --all"
alias gaac="git add --all && git commit --reedit-message=HEAD"
alias gaacp="git add --all && git commit --reedit-message=HEAD && git push"

alias gl="git log --format='%C(magenta)%h %C(yellow)%as %C(cyan)%>(8,trunc)%ar %Cgreen%<(8,trunc)%cn %Creset%s %Cred%D'"
alias glf="func() { local commit=$(echo '$(git log --color=always --format="%C(cyan)%>(12,trunc)%ar %Creset%s %Cred%D %Cgreen%cn %Cblue%h" -S $1 -- ${@:2} | fzf --ansi --bind="alt-y:execute-silent(echo {-1} | pbcopy)" --nth=1,2,4..-2 --no-multi --preview="git show --color=always {-1} -- $* | delta | grep -E \$([ {q} ] && echo {q} | xargs | sed s/\ /\|/g | sed s/$/\|$/g || echo ^) --color=always" --preview-window="55%" | rev | cut -d " " -f1 | rev)') && [ $(echo '$commit') ] && git checkout $(echo '$commit~ -- ${@:2}') }; func"

# Docker
alias docker-stop-all='docker stop $(docker ps -a -q)'
alias docker-rm-containers='docker rm $(docker ps -a -q)'
alias docker-rm-images='docker rmi $(docker images -q)'

# Folders
alias work="$HOME/projects"
alias dow="$HOME/Downloads"
alias dot="$HOME/.dotfiles"


