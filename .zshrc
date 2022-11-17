[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Load Starship
if [ -d "/opt/homebrew" ]; then
	eval "$(/opt/homebrew/bin/starship init zsh)"
else 
	eval "$(starship init zsh)"
fi

