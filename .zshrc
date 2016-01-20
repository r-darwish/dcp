if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    PS1='$ '
    return
fi

DISABLE_AUTO_UPDATE="true"
source "${HOME}/.dcp/zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-flow-avh
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/fasd
    zgen oh-my-zsh plugins/virtualenv
    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/debian
    zgen oh-my-zsh plugins/pyenv
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/systemd
    zgen oh-my-zsh plugins/ssh-agent
    zgen oh-my-zsh plugins/common-aliases
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load chrissicool/zsh-256color

    # completions
    zgen load zsh-users/zsh-completions src

    # save all to init script
    zgen save
fi

unset zle_bracketed_paste

alias nd='local t=$?; pb push -t "$(hostname -s)" "Process exited: $t"; unset t'
alias fgnd='fg ; nd'
alias lenv='activate .env'
alias pac=pacaur
alias jc=journalctl
alias gf=git-flow
alias ec='emacsclient -n'
unalias ag 2>/dev/null

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

export EDITOR="emacsclient"

bindkey "^[[1;9C" forward-word
bindkey "^[[1;9D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
