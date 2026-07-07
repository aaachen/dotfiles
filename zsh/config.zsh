# key binds, options, etc.
export EDITOR='vim'
setopt extendedglob

if [[ "$TERM" == *ghostty* || -n "$GHOSTTY_RESOURCES_DIR" || "$TERM_PROGRAM" == "ghostty" ]]; then
    ghostty-clear-and-save() {
        printf '\e[22J\e[H'
        zle && zle .reset-prompt
    }
    zle -N ghostty-clear-and-save
    bindkey '^L' ghostty-clear-and-save
fi

