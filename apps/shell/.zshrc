[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/options.zsh ]] && source ~/.zsh/options.zsh
[[ -f ~/.zsh/bindings.zsh ]] && source ~/.zsh/bindings.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh

[[ -f ~/.zsh/nnn.zsh ]] && source ~/.zsh/nnn.zsh
[[ -f ~/.zsh/fzf.zsh ]] && source ~/.zsh/fzf.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

[[ -f ~/.zsh/plugins/cursor.zsh ]] && source ~/.zsh/plugins/cursor.zsh
[[ -f ~/.zsh/plugins/git-it-on.zsh ]] && source ~/.zsh/plugins/git-it-on.zsh


# Load Starship
eval "$(starship init zsh)"

# FASD
eval "$(fasd --init zsh-hook zsh-wcomp-install zsh-wcomp)"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# goenv
if command -v goenv 1>/dev/null 2>&1; then
    eval "$(goenv init -)"
fi





