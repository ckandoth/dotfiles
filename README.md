### To set up a new Linux dev machine

Install some useful utilities using the appropriate package manager.

```bash
sudo apt install -y git vim tree curl tmux parallel
sudo zypper install -y git vim tree curl tmux gnu_parallel
```

Create an ed25519 key for SSH with a passphrase.

```bash
ssh-keygen -t ed25519 -f .ssh/id_ed25519
```

Deploy the dotfiles in this repo, enable the SSH agent, and logout.

```bash
cd $HOME
git clone --bare https://github.com/ckandoth/dotfiles.git .dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dotfiles checkout --force
systemctl --user enable --now ssh-agent.service
exit
```

When we log back in, it should prompt for the passphrase to the ed25519 key created earlier, and load it into the ssh agent in prep for passwordless SSH into other servers where the key is authorized.
