dotfiles
========

These are my bash dotfiles, bootstrapped across machines using [homeshick](https://github.com/andsens/homeshick).

Quick Start
-----------

To install homeshick into a fresh *nix home directory:

    git clone git@github.com:andsens/homeshick.git $HOME/.homesick/repos/homeshick

Use homeshick to clone and symlink my dotfiles from this repo:

    $HOME/.homesick/repos/homeshick/bin/homeshick clone -f git@github.com:ckandoth/dotfiles.git

This should prompt to replace all existing dotfiles including `.bashrc` which is already set to source homeshick. But rather than restarting terminal, simply get the homeshick alias running like so:

    source $HOME/.bashrc

After making any changes to local dotfiles, we can commit the changes back to this repo as follows:

    homeshick cd dotfiles
    git add -A
    git commit -m "[...summary of changes...]"
    git push origin master
