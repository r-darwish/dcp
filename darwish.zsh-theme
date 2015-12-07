function t_hostname() {
    if [[ -n $SSH_CONNECTION ]]; then
      echo "%{$fg_bold[yellow]%}$(hostname -s)"
    else
      echo "%{$fg_bold[green]%}$(hostname -s)"
    fi
}

PROMPT='%{$fg_bold[red]%}%n $(t_hostname) %{$fg[cyan]%}%c $(virtualenv_prompt_info)$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg_bold[blue]%}py:(%{$fg_bold[yellow]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%} "
