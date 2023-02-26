setopt numericglobsort   # Sort filenames numerically when it makes sense
setopt appendhistory     # Immediately append history instead of overwriting
setopt histignorealldups # If a new command is a duplicate, remove the older one
setopt autocd autopushd  # Implied cd

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Fuzzy completions
zstyle ':completion:*' completer _complete _match _approximate

## commands
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:-command-:*:*' group-order aliases commands builtins

zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

bindkey "^[[A"    up-line-or-search
bindkey "^[[B"    down-line-or-search
bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[3~"   delete-char

# MacOS
bindkey "^[f"     forward-word
bindkey "^[b"     backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Linux
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

if [ -n "$name" ]; then
    PROMPT="[$name] $PROMPT";
fi

if [ "$NIX_NAME" ]; then
    export PROMPT="[$NIX_NAME] $PROMPT";
fi

if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# title change
function title {
    emulate -L zsh
    setopt prompt_subst
    print -Pn "\e]2;$1:q\a" # set window name
    print -Pn "\e]1;$1:q\a" # set tab name
}

function title_precmd {
    title "${PWD##*/}"
}

function title_preexec {
    setopt shwordsplit
    ARGS=($1)
    if [[ ${ARGS[1]} =~ ^(sudo|ssh|cargo|c|git|g)$ ]]; then
        local CMD="${ARGS[1]} ${ARGS[2]}"
    else
        local CMD=${ARGS[1]}
    fi
    title "${PWD##*/} : $CMD"
}

title "${PWD##*/}"
autoload -U add-zsh-hook
add-zsh-hook precmd title_precmd
add-zsh-hook preexec title_preexec
