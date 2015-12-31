local light_blue=39
local orange=208

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=$light_blue"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$light_blue"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$light_blue"
ZSH_HIGHLIGHT_STYLES[activate]="fg=$light_blue"
ZSH_HIGHLIGHT_STYLES[globbing]='fg=226'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=226'

autoload -Uz vcs_info

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

venv_prompt() {
    if [[ -z ${VIRTUAL_ENV} ]]; then return; fi
    local venv_list=(${(s:/:)${VIRTUAL_ENV}})
    local venv=${venv_list[-1]}
    if [[ ${venv} == ".env" ]]; then
        venv=${venv_list[-2]}
    fi
    echo "🐍 %F{magenta}(%F{white}${venv}%F{magenta}) "
}

add-zsh-hook precmd vcs_info
if [[ -n $SSH_CLIENT || $EUID -eq 0 ]]; then
    PROMPT_HOST='%F{magenta}%n@%m%f'
fi
PROMPT='%B${PROMPT_HOST} %(?.%F{green}✔.%F{red}✘) %F{red}❯%F{yellow}❯%F{green}❯%b%f%k '
RPROMPT='%B${_prompt_char}${vcs_info_msg_0_}$(venv_prompt)%F{blue}%1~'
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
