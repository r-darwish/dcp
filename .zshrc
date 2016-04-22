if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    PS1='$ '
    return
fi

source ~/.zplug/zplug

export VIRTUAL_ENV_DISABLE_PROMPT=1
DISABLE_AUTO_UPDATE="true"

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "plugins/git-flow-avh", from:oh-my-zsh, if:"which git-flow"
zplug "plugins/sudo", from:oh-my-zsh, if:"which sudo"
zplug "plugins/fasd", from:oh-my-zsh, if:"which fasd"
zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux"
zplug "plugins/systemd", from:oh-my-zsh, if:"which systemctl"
zplug "plugins/ssh-agent", from:oh-my-zsh, if:"which ssh-agent"
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zaw"
zplug "supercrabtree/k"

if ! zplug check --verbose; then
    zplug install
fi

zplug load


unset zle_bracketed_paste

alias nd='local t=$?; pb push -t "$(hostname -s)" "Process exited: $t"; unset t'
alias fgnd='fg ; nd'
alias lenv='activate .env'
alias pac=pacaur
alias jc=journalctl
alias gf=git-flow
alias ec='emacsclient -n'
alias ect='emacsclient -t'
alias l='k'
unalias ag 2>/dev/null

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

bindkey '^xr' zaw-history
bindkey '^xd' zaw-fasd-directories
bindkey '^xf' zaw-fasd-files
bindkey '^xp' zaw-process

export KEYTIMEOUT=1


function _fgnd() {
    BUFFER="fgnd"
    zle accept-line
}

zle -N _fgnd

bindkey "^f" _fgnd

function activate() {
   source $1/bin/activate
}

source "${HOME}/.dcp/darwish.zsh-theme"
if [ -f "${HOME}/.local.zsh" ]; then
    source "${HOME}/.local.zsh"
fi

if ! type emacsclient > /dev/null; then
    export EDITOR=vim
else
    export EDITOR="emacsclient -a vim"
fi

bindkey "^[[1;9C" forward-word
bindkey "^[[1;9D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export HUNTER_ROOT="${HOME}/.hunter"
