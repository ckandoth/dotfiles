# ~/.profile: Executed by the command interpreter (e.g. bash) for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.

# Set umask so that your group members can help you with your work
umask 002

# If running bash, load .bashrc
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
