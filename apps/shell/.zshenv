
export WORKSPACE=$HOME/projects

export EDITOR=hx

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export MC_SKIN=$HOME/.config/mc/gruvbox256.ini

export PATH=/usr/local/bin:$HOME/.local/bin:$PATH

if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Golang
export GOPATH=$WORKSPACE/golang
export PATH=$PATH:$GOPATH/bin

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# Pyenv
export GOENV_ROOT="$HOME/.goenv"
command -v goenv >/dev/null || export PATH="$GOENV_ROOT/bin:$PATH"


[[ -f ~/.zshenv-secret ]] && source ~/.zshenv-secret
