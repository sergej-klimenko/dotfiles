# vi: ft=zsh

# ZSH Options
# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt autocd
setopt auto_pushd

HISTSIZE=2000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=10000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file

setopt hist_ignore_all_dups    # Remove older duplicate entries from history.
setopt hist_save_nodups        # Remove older duplicate entries from history.
setopt hist_expire_dups_first  # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups        # Do Not Record An Event That Was Just Recorded Again.
setopt hist_reduce_blanks      # Remove superfluous blanks from history items.
setopt hist_find_no_dups       # Do Not Display A Previously Found Event.
setopt hist_ignore_space       # Do Not Record An Event Starting With A Space.
setopt hist_save_no_dups       # Do Not Write A Duplicate Event To The History File.
setopt hist_verify             # Do Not Execute Immediately Upon History Expansion.
setopt append_history          # Allow multiple terminal sessions to all append to one zsh command history.
setopt extended_history        # Show Timestamp In History.
setopt inc_append_history      # Write To The History File Immediately, Not When The Shell Exits.
setopt share_history           # Share history between different instances of the shell
setopt incappendhistory        # Immediately append to the history file, not just when a term is killed
setopt HIST_IGNORE_SPACE       # Ignore commands started from space from saving
setopt bang_hist               # Treat The '!' Character Specially During Expansion.
setopt multios                 # Perform implicit tees or cats when multiple redirections are attempted.
setopt interactive_comments    # Allow comments even in interactive shells (especially for Muness).
setopt pushd_ignore_dups       # Don't push multiple copies of the same directory onto the directory stack.
setopt auto_cd                 # Use cd by typing directory name if it's not a command.
setopt no_beep                 # Don't beep on error.
setopt auto_list               # Automatically list choices on ambiguous completion.
setopt auto_pushd              # Make cd push the old directory onto the directory stack.
setopt pushdminus              # Swapped the meaning of cd +1 and cd -1; we want them to mean the opposite of what they mean.
setopt promptsubst             # Enables the substitution of parameters inside the prompt each time the prompt is drawn.
set +o clobber # write with > operator instead of >|


zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format '-- %d --'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# let's use the tag name as group name
zstyle ':completion:*' group-name ''

autoload -U compinit 
compinit -d