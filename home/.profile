# ~/.profile is executed by the command interpreter (e.g. bash) for login shells. It has the stuff
# *not* specifically related to bash, such as environment variables (e.g. PATH, PERL5LIB, etc.)

# Set umask so that your group members can help you with your work
umask 002

# If running bash, load .bashrc
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Set PATH to include MSKCC's private bin if found
if [ -d "/opt/common/CentOS_6-dev/bin/current" ]; then
    export PATH=/opt/common/CentOS_6-dev/bin/current:$PATH
fi

# Set PATH to include MSKCC's python bin if found
if [ -d "/opt/common/CentOS_6-dev/python/python-2.7.10/bin" ]; then
    export PATH=/opt/common/CentOS_6-dev/python/python-2.7.10/bin:$PATH
fi

# Configure Roslin, if its settings are found in the expected folders
if [ -f "/ifs/work/pi/roslin-core/2.0.2/config/settings.sh" ]; then
    source /ifs/work/pi/roslin-core/2.0.2/config/settings.sh
    source /ifs/work/pi/roslin-core/2.0.2/config/variant/2.2.0/settings.sh
    export PATH=${ROSLIN_CORE_BIN_PATH}:$PATH
    export TOIL_LSF_ARGS="-sla Haystack -S 1"
fi

# Use /scratch/username instead of /tmp if /scratch disk is found
if [ -d "/scratch" ]; then
    mkdir -p /scratch/$USER
    export TMP=/scratch/$USER
    export TMPDIR=/scratch/$USER
fi

# Reference newer gcc libraries if found
if [ -d "/opt/common/CentOS_6/gcc/gcc-4.9.3/lib64" ]; then
    export LD_LIBRARY_PATH=/opt/common/CentOS_6/gcc/gcc-4.9.3/lib64:$LD_LIBRARY_PATH
fi

# Load NVM and bash completion if found
if [ -d "/opt/common/CentOS_6-dev/nvm/v0.33.9" ]; then
    export NVM_DIR=/opt/common/CentOS_6-dev/nvm/v0.33.9
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
