# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Override the default umask with something that's friendlier to your lab mates
umask 002

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH=:"$PATH:$HOME/.local/bin"
fi

# Set PATH to include MSKCC's private bin if found
if [ -d "/opt/common/CentOS_6-dev/bin/current" ]; then
    PATH="/opt/common/CentOS_6-dev/bin/current:$PATH"
fi

# Set PATH to include MSKCC's python bin if found
if [ -d "/opt/common/CentOS_6-dev/python/python-2.7.10/bin" ]; then
    PATH="/opt/common/CentOS_6-dev/python/python-2.7.10/bin:$PATH"
fi

# Add local Perl libraries to $PERL5LIB if found
if [ -d "$HOME/perl5" ]; then
    export PERL5LIB="$HOME/perl5/lib/perl5:$HOME/perl5/lib/perl5/site_perl"
fi

# Set up Perlbrew if found in the expected folder
if [ -d "$HOME/perl5/perlbrew" ]; then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

# Set up Pyenv if found in the expected folder
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
fi

# Configure Roslin, if its settings are found in the expected folder
if [ -f "/ifs/work/pi/roslin-core/2.0.0/config/settings.sh" ]; then
    source /ifs/work/pi/roslin-core/2.0.0/config/settings.sh
    export PATH=${ROSLIN_CORE_BIN_PATH}:$PATH
    export TOIL_LSF_ARGS="-sla Haystack -S 1"
fi

# Use scratch as tmp if found
if [ -d "/scratch/kandoth" ]; then
    export TMP=/scratch/kandoth
    export TMPDIR=/scratch/kandoth
fi
