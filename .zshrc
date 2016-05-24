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

zplug "lib/misc", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh

zplug "plugins/git", from:oh-my-zsh, if:"which git", nice:10
zplug "plugins/git-flow-avh", from:oh-my-zsh, if:"which git-flow"
zplug "plugins/fasd", from:oh-my-zsh, if:"which fasd"
zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux", nice:10
zplug "plugins/systemd", from:oh-my-zsh, if:"which systemctl"
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "chrissicool/zsh-256color"
if [[ -n ${ANDROID_ROOT} ]] ; then
    alias ai="apt install"
else
    zplug "plugins/ssh-agent", from:oh-my-zsh, if:"which ssh-agent"
    zplug "supercrabtree/k"
    zplug "junegunn/fzf", of:"shell/*.zsh", nice: 10
    export FZF_COMPLETION_TRIGGER="~~"
    export FZF_DEFAULT_COMMAND='ag -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fasd -Rdl"
    alias fzfag="ag --nobreak --nonumbers --noheading . | fzf-tmux"
    _fzf_compgen_path() {
        ag -g "" "$1"
    }
fi

if ! zplug check --verbose; then
    zplug install
fi

zplug load

if hash pyenv 2>/dev/null ; then
    eval "$(pyenv init -)"
fi

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
