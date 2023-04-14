# vim: set ft=zsh:

# Options
# https://www.viget.com/articles/zsh-config-productivity-plugins-for-mac-oss-default-shell/
setopt nobeep
setopt always_to_end  		  # move the cursor to the end of the word after accepting a completion
setopt auto_menu              # show completion menu on successive tab press
setopt autocd				  # if only directory path is entered, cd there
setopt autopushd              # make cd push the old directory onto the directory stack
setopt complete_in_word       # cursor stays there and completion is done from both ends
setopt extended_history       # record timestamp of command in HISTFILE
setopt histappend             # don't erase history
setopt inc_append_history     # add immediately
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_save_no_dups      # older commands that duplicate newer ones are omitted
setopt hist_verify            # show command with history expansion to user before running it
setopt pushdignoredups        # don’t push multiple copies of the same directory onto the directory stack
setopt pushdminus             # exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack
setopt rmstarsilent           # do not query the user before executing ‘rm *’ or ‘rm path/*’
setopt share_history          # share history between session/terminals
unsetopt flow_control         # output flow control via start/stop characters is disabled in the shell’s editor

# case insensitive autocompletion
zstyle ":completion:*" matcher-list "" "m:{a-z}={A-Z}" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=* l:|=*"
zstyle ':completion:*' hosts off                                # ignore hosts file for ssh/scp autocompletion
## Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=50000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
# Change autosuggestion color see https://coderwall.com/p/pb1uzq/z-shell-colors
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=060'


# Theming section
autoload -U compinit colors zcalc
zmodload zsh/complist
zstyle ':completion:*' menu select                              # to activate the menu, press tab twice
unsetopt menu_complete                                          # do not autoselect the first completion entry
unsetopt nomatch                                                # allow gloobing, e.g apt update kernel*
setopt complete_aliases                                         # autocompletion CLI switches for aliases
zstyle ':completion:*' list-colors ''                           # show colors on menu completion
compinit -d
colors