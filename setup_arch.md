# Setup Arch Linux

## Install Arch linux

Install Arch Linux with `archinstall`.
Options are as follows:

- Mirrors: where you are
- Disk configuration:
  Use a best-effort default partitioning layout
  btrfs, default structure, RTRFS compression
- User account with `sudo`
- Profile:
  - Desktop KDE
  - Graphic driver: nvidia (proprietary)
  - greeter: sddm
- Audio: pipewire
- Network: NetworkManager
- Timezone: where you are

## Install and setup packages

The configuration is split into multiple scripts because
some steps require interactivity, such as entering the Root
password or working in a browser.

Execute them in the following order.

1. Copy secret files from your backup to `~/Documents/secrets/`.

2. Setup GitHub account

Run `setup_arch_1.sh` with root privileges to install packages required for the `github-cli`.

```bash
sudo ./setup_arch_1.sh
```
Then, run the following as a regular user to configure the `github-cli`.

```bash
gh auth login
```
Follow the [instructions](https://docs.github.com/en/github-cli/github-cli/quickstart) to authenticate.

Run the following to add 

```bash

3. Install `yay` package manager

Run `setup_arch_2.sh` with root privileges to install `yay`.

```bash
sudo ./setup_arch_2.sh
```

Root password is required during this script.

After the above script is executed, run the following to check the connection to `github.com` via ssh.

```bash
ssh -T git@github.com
```

3. Install packages

Run `setup_arch_3.sh` with root privileges to install packages.

```bash
sudo ./setup_arch_3.sh
```

4. Setup shell environment

Following commands need to be executed as a regular user.

Change default shell to zsh:

```bash
chsh -s $(which zsh)
```

Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh):

```bash
ZSH="/home/takahisa/Documents/git/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Configure zsh:

```bash
ln -sf ${HOME}/Documents/git/dotfiles/.zshenv "${HOME}"/.zshenv
ln -sf ${HOME}/Documents/git/dotfiles/.config/zsh "${HOME}"/.config/zsh
rm -f "${HOME}"/.zshrc

# plugins
ln -sf ${HOME}/Documents/git/dotfiles/misc/omz_custom/alias.zsh ${ZSH_CUSTOM}/alias.zsh
# rye completion
mkdir -p "${HOME}"/Documents/git/oh-my-zsh/custom/plugins/rye/
rye self completion -s zsh > ${ZSH_CUSTOM}/plugins/rye/_rye
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
```

5.  Setup Python environment

Run `rye` and configure as follows (all defaults):

- uv
- Python namaged by Rye
- cpython@3.12 (default)

and run the following commands:

```bash
rye install ruff
```

Run following to setup Python environment for NeoVim:

```bash
mkdir -p ~/Documents/venvs/neovim && cd $_
uv venv
source .venv/bin/activate
uv pip install pynvim
```
