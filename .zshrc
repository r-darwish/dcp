source "${HOME}/.dcp/zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-flow
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

alias nd='local t=$?; pb push -t "$(hostname -s)" "Process exited: $t"; unset t'
alias fgnd='fg ; nd'
alias lenv='activate .env'
alias pac=pacaur
alias jc=journalctl

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
