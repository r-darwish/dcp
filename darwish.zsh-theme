ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'

autoload -Uz vcs_info
autoload -U add-zsh-hook

zstyle ':vcs_info:*' enable git hg svn cvs
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr		'%F{green}✱'
zstyle ':vcs_info:*' unstagedstr	'%F{red}✱'
zstyle ':vcs_info:*' branchformat	'%b%%b%f:%B%F{yellow}%r'
zstyle ':vcs_info:*' formats		'%F{magenta}(%F{white}%b%c%u%m%F{magenta}) '
zstyle ':vcs_info:*' actionformats	'%F{magenta}(%F{white}%b%c%u%m%F{magenta}|%F{red}%a%F{magenta}) '
zstyle ':vcs_info:*+set-message:*' hooks set-message
zstyle ':vcs_info:*+no-vcs:*' hooks no-vcs

typeset -gA vcs_prompt_chars
vcs_prompt_chars=(
    'git' '%F{red}⚡ '
    'hg'  '%F{black}☿ '
    'svn' '%F{blue}± '
    'cvs' '%F{white}c '
)

+vi-no-vcs() {
    _prompt_char=''
}

+vi-set-message() {
    _prompt_char=$vcs_prompt_chars[$vcs]

    case ${vcs} in
        git)
            # Show +N/-N when your local branch is ahead-of or behind remote HEAD.
            local ahead behind
            local -a gitstatus

            ahead=$(git rev-list --count ${hook_com[branch]}@{upstream}..@ 2>/dev/null)
            (( $ahead )) && gitstatus+=( "%F{green}⇡${ahead}" )

            behind=$(git rev-list --count @..${hook_com[branch]}@{upstream} 2>/dev/null)
            (( $behind )) && gitstatus+=( "%F{red}⇣${behind}" )

            (( ${#gitstatus} )) && hook_com[misc]+="%F{magenta}|%b${(@j:%F{white\}/:)gitstatus}%B"
            ;;

    esac
}

_venv_info() {
    if [[ -z ${VIRTUAL_ENV} ]]; then
        _venv_prompt=''
        return;
    fi
    local -a venv_list
    venv_list=("${(@s:/:)${VIRTUAL_ENV}}")
    local venv=${venv_list[-1]}
    if [[ ${venv} == ".env" ]]; then
        venv=${venv_list[-2]}
    fi
    _venv_prompt="🐍 %F{magenta}(%F{white}${venv}%F{magenta}) "
}

function zle-line-init zle-keymap-select {
    if [[ ${KEYMAP} == "main" ]]; then
        _vim_prompt="%F{green}● "
    else
        _vim_prompt="%F{yellow}● "
    fi
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

add-zsh-hook precmd vcs_info
add-zsh-hook precmd _venv_info

if [[ -n $SSH_CLIENT || $EUID -eq 0 ]]; then
    PROMPT_HOST='%F{magenta}%n@%m%f'
fi
PROMPT='%B${PROMPT_HOST} ${_vim_prompt}%(?.%F{green}✔.%F{red}✘) %F{red}❯%F{yellow}❯%F{green}❯%b%f%k '
RPROMPT='%B${_prompt_char}${vcs_info_msg_0_}${_venv_prompt}%F{blue}%1~'
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
