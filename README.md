### To set up a new Linux dev machine

Install some useful utilities using the appropriate package manager.

```bash
sudo apt install -y git vim tree curl tmux parallel keychain
sudo zypper install -y git vim tree curl tmux gnu_parallel keychain
```

Create an ed25519 key for SSH with a passphrase.

```bash
ssh-keygen -t ed25519 -C $USER -f .ssh/id_ed25519
```

Deploy the dotfiles in this repo and logout.

```bash
cd $HOME
git clone --bare https://github.com/ckandoth/dotfiles.git .dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles checkout --force
exit
```
