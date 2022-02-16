# UTILS_DIR SHOULD BE SET TO THE DIRECTORY CONTAINING THIS FILE
if [ -z "${UTILS_DIR}" ]; then
    echo "UTILS_DIR not set: ${UTILS_DIR}" 1>&2
    return
fi

###########
# OPTIONS #
###########
shopt -s globstar

###########
# ALIASES #
###########
# Git
alias gitlog1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an (%ae)%C(reset)'"
alias gitlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an (%ae)%C(reset)' --all"
alias gitpup="git pull && git submodule init && git submodule update && git submodule status"

# Utils
alias tailf="tail -f"
alias tmux="TERM=xterm-256color tmux"

#############
# FUNCTIONS #
#############
gup()
{
    path=`pwd`
    while [ ! -d "$path/.git" -a $path != "/" ]; do
        path=`dirname $path`
    done
    if [ $path = "/" ]; then
        echo "Not in a git workspace"
    else
        cd $path
    fi
}

###########
# EXPORTS #
###########
export RESET="\e[00m"
export BOLD="\e[1m"

# 255 Colors
export ORANGE="\e[38;5;214m"
export PURPLE="\e[38;5;128m"
export GRAY="\e[38;5;250m"
export CYAN="\e[38;5;6m"

# Colours: Uncomment for non 256 terminals
# export BLACK="\e[30m"
# export RED="\e[31m"
# export GREEN="\e[32m"
# export YELLOW="\e[33m"
# export BLUE="\e[34m"
# export PURPLE="\e[35m"
# export CYAN="\e[36m"
# export WHITE="\e[37m"

# Editor
editor=vim
export EDITOR=$editor
export VISUAL=$editor

# Path
export PATH="$PATH:${UTILS_DIR}"

# Timezone
# export TZ="/usr/share/zoneinfo/GB"
unset TZ

# Terminal
export TERM=xterm-256color

# Prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
prompt_venv() {
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "($venv)"
}
prompt_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033]0;\u@\h\007\]\[$BOLD$ORANGE\]\u\[$RESET\]@\[$BOLD$ORANGE\]\h\[$RESET\]:\[$BOLD$GRAY\]\W\[$RESET\]\[$CYAN\]\$(prompt_git_branch)\[$RESET\]\n>\$(prompt_venv)\$ "

###########################
# SOURCE ADDITIONAL UTILS #
###########################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

