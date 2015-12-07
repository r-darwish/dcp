ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=39'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=39'
ZSH_HIGHLIGHT_STYLES[alias]='fg=39'
ZSH_HIGHLIGHT_STYLES[activate]='fg=39'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=226'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=226'

source "${HOME}/.dcp/zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-flow
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/archlinux
    zgen oh-my-zsh plugins/fasd
    zgen oh-my-zsh plugins/virtualenv
    zgen load zsh-users/zsh-syntax-highlighting

    # completions
    zgen load zsh-users/zsh-completions src

    # save all to init script
    zgen save
fi

function activate() {
   source $1/bin/activate
}

source "${HOME}/.dcp/darwish.zsh-theme"
if [ -f "${HOME}/.local.zsh" ]; then
    source "${HOME}/.local.zsh"
fi
