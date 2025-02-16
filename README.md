### To set up a new Debian-based dev machine

Install some useful utilities.

```bash
sudo apt install -y git vim tree curl tmux parallel keychain
```

Install Azure CLI using Microsoft repos.

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az config set extension.use_dynamic_install=yes_without_prompt
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

Log back in, install conda with libmamba solver, and logout.

```bash
curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh
bash miniconda.sh -bup $HOME/miniconda3 && rm -f miniconda.sh
exit
```

Log back in, use the libmamba dependency solver, and create a conda env for bioinformatics.

```bash
conda update -y -n base -c defaults --all
conda config --set solver libmamba
conda create -y -n bio -c conda-forge -c bioconda htslib samtools bcftools
```
