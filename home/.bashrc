# ~/.bashrc: executed by bash for non-login shells.

# Use global profile when available and allow admin overrides
if [ -f /usr/share/defaults/etc/profile ]; then
    . /usr/share/defaults/etc/profile
fi
if [ -f /etc/profile ]; then
    . /etc/profile
fi

# Default to write permission for group members
umask 002

# Limit the size of core dump files cuz they can fill up home dir quotas
ulimit -c 0

# If not running interactively, don't do anything else
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Set larger limits for history length and file size
HISTSIZE=2048
HISTFILESIZE=5120

# Append to the history file, don't overwrite it
shopt -s histappend

# Check window size after each command to update LINES and COLUMNS as needed
shopt -s checkwinsize

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some customized parameters for the less command
export LESS=-eiMXR

# Make less more friendly for non-text input files, see lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# An alias that helps view tab-delimited data
alias lc="sed ':x s/\(^\|\t\)\t/\1 \t/; t x' | column -ts$'\t' | less -SFX"

# Enable color support for ls and grep using aliases
if [ -x /usr/bin/dircolors ]; then
    force_color_prompt=yes
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

# Pull more aliases from .bash_aliases if found
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# This prevents me from accidentally closing the terminal with Ctrl+D
set -o ignoreeof

# This prevents me from accidentally overwriting a file with I/O redirects
set -o noclobber

# This allows gpg to properly prompt me for a passphrase
export GPG_TTY="$(tty)"

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

# Source all .sh files in .bashrc.d if found and change the prompt
if [ -d "$HOME/.bashrc.d" ]; then
    load_dir $HOME/.bashrc.d

    # Intuitive color schemes for git repositories
    if [ -v $(__git_ps1) ]; then
        BLUE="\[\e[38;5;39m\]";
        ORANGE="\[\e[38;5;208m\]";
        YELLOW="\[\e[33m\]";
        WHITE="\[\e[0m\]";
        export PS1=$BLUE'\u'$WHITE'@'$ORANGE'\H '$YELLOW'\W'$ORANGE'$(__git_ps1 " (%s)")'$WHITE'$ '
    fi
fi

# Source Homeshick scripts if found, and sync all the castles
if [ -d "$HOME/.homesick/repos/homeshick" ]; then
    . $HOME/.homesick/repos/homeshick/homeshick.sh
fi

# Add .local/bin to PATH if found
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# Add mambaforge to PATH if found
if [ -f "$HOME/mambaforge/etc/profile.d/conda.sh" ]; then
    . $HOME/mambaforge/etc/profile.d/conda.sh
fi

# If a private key is found and keychain is installed
if [ -f "$HOME/.ssh/id_ed25519" -a -x "$(command -v keychain)" ]; then
    /usr/bin/keychain --quiet --nogui $HOME/.ssh/id_ed25519
    source $HOME/.keychain/$HOSTNAME-sh
fi
