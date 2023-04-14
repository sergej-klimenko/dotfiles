# vim: set ft=zsh:

autoload -U edit-command-line; zle -N edit-command-line

export KEYTIMEOUT=1

# Keybindings
# https://github.com/junegunn/fzf/issues/546#issuecomment-213344845
# https://en.wikipedia.org/wiki/GNU_Readline#Emacs_keyboard_shortcuts
# http://web.cs.elte.hu/zsh-manual/zsh_14.html#SEC49
bindkey -v
bindkey -M menuselect '^o' accept-and-infer-next-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M viins "^['" quote-line
bindkey -M viins "^[^e" globalias
bindkey -M viins '^ ' set-mark-command
bindkey -M viins '^/' undo
bindkey -M viins '^["' quote-region
bindkey -M viins '^[-' neg-argument
bindkey -M viins '^[.' insert-last-word
bindkey -M viins '^[<' beginning-of-buffer-or-history
bindkey -M viins '^[>' end-of-buffer-or-history
bindkey -M viins '^[^h' backward-kill-word
bindkey -M viins '^[b' backward-word
bindkey -M viins '^[c' capitalize-word
bindkey -M viins '^[d' kill-word
bindkey -M viins '^[f' forward-word
bindkey -M viins '^[h' kill-region
bindkey -M viins '^[l' down-case-word
bindkey -M viins '^[n' history-search-forward
bindkey -M viins '^[p' history-search-backward
bindkey -M viins '^[t' transpose-words
bindkey -M viins '^[u' up-case-word
bindkey -M viins '^[w' copy-region-as-kill
bindkey -M viins '^[x' execute-named-cmd
bindkey -M viins '^[y' yank-pop
bindkey -M viins '^_' undo
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^b' backward-char
bindkey -M viins '^d' delete-char
bindkey -M viins '^e' end-of-line
bindkey -M viins '^f' forward-char
bindkey -M viins '^g' send-break
bindkey -M viins '^h' backward-delete-char
bindkey -M viins '^k' kill-line
bindkey -M viins '^n' down-history
bindkey -M viins '^o' accept-line-and-down-history
bindkey -M viins '^p' up-history
bindkey -M viins '^r' fzf-history-widget
bindkey -M viins '^t' transpose-chars
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^x^a' fasd-complete
bindkey -M viins '^x^b' vi-match-bracket
bindkey -M viins '^x^d' fasd-complete-d
bindkey -M viins '^x^e' edit-command-line
bindkey -M viins '^x^f' fasd-complete-f
bindkey -M viins '^x^j' fzf-cd-widget
bindkey -M viins '^x^s' fzf-file-widget
bindkey -M viins '^x^u' undo
bindkey -M viins '^x^x' exchange-point-and-mark
bindkey -M viins '^xa' fasd-complete
bindkey -M viins '^xb' vi-match-bracket
bindkey -M viins '^xd' fasd-complete-d
bindkey -M viins '^xe' edit-command-line
bindkey -M viins '^xf' fasd-complete-f
bindkey -M viins '^xj' fzf-cd-widget
bindkey -M viins '^xs' fzf-file-widget
bindkey -M viins '^xu' undo
bindkey -M viins '^xx' exchange-point-and-mark
bindkey -M viins '^y' yank
bindkey -M viins "∫" backward-word
bindkey -M viins "ƒ" forward-word
bindkey -M viins "∂" delete-word
bindkey -M viins '˙' backward-kill-word
bindkey -M viins '≥' insert-last-word