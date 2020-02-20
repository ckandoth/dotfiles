# ~/.profile: executed by Bourne-compatible login shells (e.g. bash).
# Not loaded by bash, if ~/.bash_profile or ~/.bash_login exists.

# Default to write permission for group members
umask 002

# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
