# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=5120

# Check the window size after each command, and update values of LINES and COLUMNS as needed
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support for ls and grep using aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add some aliases for ls
alias ll='ls -hlF'
alias la='ls -A'
alias l='ls -CF'

# An alias that helps view tab-delimited data
alias lc="sed ':x s/\(^\|\t\)\t/\1 \t/; t x' | column -ts$'\t' | less -SFX"

# Add an "alert" alias for long running commands. Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Pull more aliases from .bash_aliases if found
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Ask for confirmation before removing or overwriting stuff
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Limit the size of core dump files cuz they can fill up home dir quotas
ulimit -c 0

# This prevents me from accidentally closing the terminal with Ctrl+D
set -o ignoreeof

# This prevents me from accidentally overwriting a file with I/O redirects
set -o noclobber

# Some customized parameters for the less command
export LESS=-eiMXR

# A function that sources all .sh files within a given directory
function load_dir {
    LOAD_DIR=${1}
    if [ -d $LOAD_DIR -a -r $LOAD_DIR -a -x $LOAD_DIR ]; then
        local i
        for i in $(find -L $LOAD_DIR -name '*.sh'); do
            source $i
        done
    fi
}

# Source all .sh files in directory .bashrc.d if found and change the prompt
if [ -d "$HOME/.bashrc.d" ]; then
    load_dir $HOME/.bashrc.d

    # Intuitive color schemes for git repositories
    if [ "$PS1" ]; then
        CYAN="\[\033[0;36m\]"
        BROWN="\[\033[0;33m\]"
        NONE="\[\e[m\]"
        export PS1R="${BROWN}\W\$${NONE} "
        export PS1=$BROWN'\W'$CYAN'$(__git_ps1 " (%s)")'$BROWN'$'$NONE" "
    fi
fi

# Source the Homeshick scripts, and make sure all the castles are synced up
if [ -d "$HOME/.homesick/repos/homeshick" ]; then
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fi
