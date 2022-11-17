
export EDITOR=hx

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export MC_SKIN=$HOME/.config/mc/gruvbox256.ini

export PATH=/usr/local/bin:$HOME/.local/bin:$PATH

export GOPATH=$HOME/projects/golang
export PATH=$PATH:$GOPATH/bin

if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

[[ -f ~/.zshenv-secret ]] && source ~/.zshenv-secret
