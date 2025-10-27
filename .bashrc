# ~/.bashrc: executed by bash for non-login shells

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Default to write permission for group members
umask 002

# Limit the size of core dump files cuz they can fill up home dir quotas
ulimit -c 0

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set larger limits for history length and file size
HISTSIZE=2048
HISTFILESIZE=5120

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Some customized parameters for the less command
export LESS=-eiMXR

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable color in output of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Some more ls aliases
alias ll='ls -hlF'
alias la='ls -A'
alias l='ls -CF'

# An alias that helps view tab-delimited data
alias lc="sed ':x s/\(^\|\t\)\t/\1 \t/; t x' | column -ts$'\t' | less -SFX"

# An "alert" alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# An alias to manage dotfiles using git
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME" 

# Pull more aliases from .bash_aliases if found
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# This prevents me from accidentally closing the terminal with Ctrl+D
set -o ignoreeof

# This prevents me from accidentally overwriting a file with I/O redirects
set -o noclobber

# This allows gpg to properly prompt me for a passphrase
export GPG_TTY="$(tty)"

# Prompt colors from Clear Linux that I really like
BLUE="\[\e[38;5;39m\]";
ORANGE="\[\e[38;5;208m\]";
YELLOW="\[\e[33m\]";
WHITE="\[\e[0m\]";
export PS1=$BLUE'\u'$WHITE'@'$ORANGE'\H '$YELLOW'\W'$WHITE'$ '

# Add pixi to PATH if found
if [ -d "$HOME/.pixi/bin" ]; then
    export PATH="$HOME/.pixi/bin:$PATH"
fi

# If a private key is found and ssh-agent is installed, load it up for passwordless SSH
if [ -f "$HOME/.ssh/id_ed25519" ] && command -v ssh-agent >/dev/null; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    if ! ssh-add -l | grep -q ED25519; then
        ssh-add "$HOME/.ssh/id_ed25519"
    fi
fi
