# lean prompt theme
# by Miek Gieben: https://github.com/miekg/lean
#
# Base on Pure by Sindre Sorhus: https://github.com/sindresorhus/pure
#
# MIT License

PROMPT_LEAN_PATH_PERCENT=${PROMPT_LEAN_PATH_PERCENT-60}

prompt_lean_venv_info() {
    if [[ -z ${VIRTUAL_ENV} ]]; then
        return
    fi

    local -a venv_list
    venv_list=("${(@s:/:)${VIRTUAL_ENV}}")
    local venv=${venv_list[-1]}
    if [[ ${venv} == ".env" ]]; then
        venv=${venv_list[-2]}
    fi
    echo " %F{yellow}${venv}"
}

# turns seconds into human readable time, 165392 => 1d 21h 56m 32s
prompt_lean_human_time() {
    local tmp=$1
    local days=$(( tmp / 60 / 60 / 24 ))
    local hours=$(( tmp / 60 / 60 % 24 ))
    local minutes=$(( tmp / 60 % 60 ))
    local seconds=$(( tmp % 60 ))
    (( $days > 0 )) && echo -n "${days}d "
    (( $hours > 0 )) && echo -n "${hours}h "
    (( $minutes > 0 )) && echo -n "${minutes}m "
    echo "${seconds}s "
}

# fastest possible way to check if repo is dirty
prompt_lean_git_dirty() {
    # check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # check if it's dirty
    local umode="-uno" #|| local umode="-unormal"
    command test -n "$(git status --porcelain --ignore-submodules ${umode} 2>/dev/null | head -100)"

    (($? == 0)) && echo ' +'
}

# displays the exec time of the last command if set threshold was exceeded
prompt_lean_cmd_exec_time() {
    local stop=$EPOCHSECONDS
    local start=${cmd_timestamp:-$stop}
    integer elapsed=$stop-$start
    (($elapsed > ${PROMPT_LEAN_CMD_MAX_EXEC_TIME:=5})) && prompt_lean_human_time $elapsed
}

prompt_lean_preexec() {
    cmd_timestamp=$EPOCHSECONDS
}

prompt_lean_pwd() {
    local lean_path="`print -Pn '%~'`"
    if (($#lean_path / $COLUMNS.0 * 100 > ${PROMPT_LEAN_PATH_PERCENT:=60})); then
        print -Pn '...%2/'
        return
    fi
    print "$lean_path"
}

prompt_lean_precmd() {
    vcs_info
    rehash

    local jobs
    local prompt_lean_jobs
    unset jobs
    for a (${(k)jobstates}) {
        j=$jobstates[$a];i="${${(@s,:,)j}[2]}"
        jobs+=($a${i//[^+-]/})
    }
    # print with [ ] and comma separated
    prompt_lean_jobs=""
    [[ -n $jobs ]] && prompt_lean_jobs="%F{242}["${(j:,:)jobs}"] "

    PROMPT="$prompt_lean_jobs%F{yellow}$prompt_lean_host%(?.%F{blue}.%B%F{red})%#%f%b "
    RPROMPT="%F{yellow}`prompt_lean_cmd_exec_time`%f%F{blue}`prompt_lean_pwd`%F{242}$vcs_info_msg_0_`prompt_lean_git_dirty``prompt_lean_venv_info`%f"

    unset cmd_timestamp # reset value since `preexec` isn't always triggered
}

prompt_lean_setup() {
    prompt_opts=(cr subst percent)

    zmodload zsh/datetime
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    add-zsh-hook precmd prompt_lean_precmd
    add-zsh-hook preexec prompt_lean_preexec

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git*' formats ' %b'
    zstyle ':vcs_info:git*' actionformats ' %b|%a'

    [[ "$SSH_CONNECTION" != '' ]] && prompt_lean_host="%F{green}%m%f "
    [[ "$TMUX" != '' ]] && prompt_lean_tmux=$PROMPT_LEAN_TMUX
}

prompt_lean_setup "$@"
