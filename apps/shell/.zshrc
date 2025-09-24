[[ -f ~/.zsh/plugins.zsh ]] && source ~/.zsh/plugins.zsh
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/options.zsh ]] && source ~/.zsh/options.zsh
[[ -f ~/.zsh/bindings.zsh ]] && source ~/.zsh/bindings.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh

[[ -f ~/.zsh/nnn.zsh ]] && source ~/.zsh/nnn.zsh
[[ -f ~/.zsh/fzf.zsh ]] && source ~/.zsh/fzf.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi
export HOMEBREW_NO_AUTO_UPDATE=1

# Load Starship
eval "$(starship init zsh)"