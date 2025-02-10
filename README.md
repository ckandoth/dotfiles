### To deploy these into a new machine

```bash
cd $HOME
git clone --bare https://github.com/ckandoth/dotfiles.git .dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles checkout
```
