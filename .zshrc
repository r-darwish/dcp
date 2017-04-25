if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    PS1='$ '
    return
fi

bindkey -e
source "$HOME/.zplug/init.zsh"

export VIRTUAL_ENV_DISABLE_PROMPT=1

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls="gls --color=auto --group-directories-first -lFhX"
else
    alias ls="ls --color=auto --group-directories-first -lFhX"
fi

HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history

# zplug plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-completions"
if [[ -n ${ANDROID_ROOT} ]] ; then
    alias ai="apt install"
else
    zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
    export FZF_COMPLETION_TRIGGER="~~"
    export FZF_DEFAULT_COMMAND='ag -g ""'
    export FZF_DEFAULT_OPTS="-e"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fasd -Rdl"
    alias fzfag="ag --nobreak --nonumbers --noheading . | fzf-tmux"
    _fzf_compgen_path() {
        ag -g "" "$1"
    }

    fasd_cache="$HOME/.fasd-init-zsh"
    zplug clvv/fasd, \
          as:command, \
          hook-build:"./fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $fasd_cache"
fi

if ! zplug check --verbose; then
    zplug install
fi

zplug load

if zplug check clvv/fasd; then
    source "$fasd_cache"
fi
unset fasd_cache

unset zle_bracketed_paste

function t()
{
    tmux new-session -A -s ${1:=main}
}

alias lenv='activate .env'
alias pac=pacaur
alias gf=git-flow
alias ec='emacsclient -n'
alias cgtop='systemd-cgtop'
alias cgls='systemd-cgls'
alias ect='emacsclient -t'
alias cmk="ssh -O stop"
alias jc=journalctl
alias sc="sudo systemctl"
alias scu="systemctl --user"
alias scdr="sudo systemctl daemon-reload"
alias pip="python -m pip"
unalias ag 2>/dev/null

export KEYTIMEOUT=1

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

# enable cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*' list-dirs-first 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:descriptions' format ' %B%F{yellow}-- %d --%f%b'
zstyle ':completion:*:corrections' format ' %B%F{green}-- %d (errors: %e) --%f%b'
zstyle ':completion:*:messages' format ' %B%F{purple} -- %d --%f%b'
zstyle ':completion:*:warnings' format ' %B%F{red}-- no matches found --%f%b'
zstyle ':completion:*' verbose yes

# enable fuzzy matching when completing
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

WORDCHARS=${WORDCHARS//\/}
