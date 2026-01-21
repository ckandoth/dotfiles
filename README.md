### To set up a new Linux dev machine

Install some useful utilities using the appropriate package manager.

```bash
sudo apt install -y git vim tree curl tmux parallel
sudo pacman -S git vim tree curl tmux parallel
sudo zypper install -y git vim tree curl tmux gnu_parallel
```

Install `pixi` to help manage conda environments and packages.

```bash
curl -fsSL https://pixi.sh/install.sh | sh
```

Create an ed25519 key for SSH with a passphrase.

```bash
ssh-keygen -t ed25519 -f .ssh/id_ed25519
```

Deploy the dotfiles in this repo and logout. Dotfiles will be loaded on the next login.

```bash
cd $HOME
git clone --bare https://github.com/ckandoth/dotfiles.git .dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles checkout --force
exit
```
