# UTILS_DIR SHOULD BE INSERTED ABOVE BY setup.sh

# FROM HERE ON THE CONTENTS ARE AUTOMATICALLY APPENDED BY setup.sh FROM
# UTILS_DIR

###########
# ALIASES #
###########
# Git
alias gitlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"

# Utils
alias tailf="tail -f"
alias tmux="TERM=xterm-256color tmux"

###########
# EXPORTS #
###########
# Colours
export BLACK="\e[0;30m"
export DARK_GRAY="\e[1;30m"
export LIGHT_GRAY="\e[0;37m"
export BLUE="\e[0;34m"
export LIGHT_BLUE="\e[1;34m"
export GREEN="\e[0;32m"
export LIGHT_GREEN="\e[1;32m"
export CYAN="\e[0;36m"
export LIGHT_CYAN="\e[1;36m"
export RED="\e[0;31m"
export LIGHT_RED="\e[1;31m"
export PURPLE="\e[0;35m"
export LIGHT_PURPLE="\e[1;35m"
export BROWN="\e[0;33m"
export YELLOW="\e[1;33m"
export WHITE="\e[1;37m"
export RESET="\e[00m"

# Editor
editor=vim
export EDITOR=$editor
export VISUAL=$editor

# Path
export PATH="$PATH:${UTILS_DIR}"

# Timezone
export TZ="/usr/share/zoneinfo/GB"

# Prompt
prompt_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033]0;\u@\h\007\][\[$YELLOW\]\u\[$RESET\]@\[$YELLOW\]\h\[$RESET\] \[$LIGHT_GREEN\]\W\[$RESET\]\[$CYAN\]\$(prompt_git_branch)\[$RESET\]]\$ "

