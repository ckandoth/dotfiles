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
