local light_blue=39
local orange=208

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=$orange"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$orange"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$orange"
ZSH_HIGHLIGHT_STYLES[activate]="fg=$orange"
ZSH_HIGHLIGHT_STYLES[globbing]='fg=226'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=226'

function t_hostname() {
    if [[ -n $SSH_CONNECTION ]]; then
      echo "%{$fg_bold[yellow]%}%m"
    else
      echo "%{$fg_bold[green]%}%m"
    fi
}

PROMPT='%{$fg_bold[red]%}%n $(t_hostname) %F{${light_blue}}%c $(virtualenv_prompt_info)$(git_prompt_info)$(git_remote_status)%{$reset_color%}'
RPROMPT="%F{${light_blue}}%~%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{\e[38;5;214m%}⬇ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{\e[38;5;214m%}⬆ %{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg_bold[blue]%}py:(%{$fg_bold[yellow]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%} "
