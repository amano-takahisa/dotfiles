# setup_note
## Install Ubuntu
Install ubuntu from a live USB memory

### Update and add drivers
```bash
sudo apt update
sudo apt upgrade
sudo ubuntu-drivers autoinstall  
sudo reboot
```

### Install basic tools
```bash
sudo apt install \
    curl \
    gnome-tweaks \
    tree \
    htop \

```

Prepare directory
```bash
mkdir ~/bin
```
### Fix brightness control (If not work)
```bash
sudo apt install inotify-tools
```
And follow [this](https://forums.linuxmint.com/viewtopic.php?p=1826052&sid=e168cef1b97e35e9e4eff4f69fc9d99a#p1826052).

### Swap ctrl and capslock
From tweaks, change as you like.

### Setup language support
Run
```bash
gnome-language-selector
```
and add language

### GNOME settings
- Auto hide Dock
- Dark window theme
- Accessibility > Cursor size > enlarge
- Accessibility > Hearing > enable visual alart

Hide top bar
https://extensions.gnome.org/extension/545/hide-top-bar/

### wi-fi settings
If a computer can't connect to specific wifi, try to strict to use 2.4Ghz band.
You can configure this with an "Advanced Network Configuration" tool.
```bash
sudo apt install net-tools
```
Then start Advanced Network Configuration tool and set wifi band to B/G (2.4GHz).

## Git
### Install
```bash
sudo apt install git
```
or
```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```
### Setup
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
Setup ssh

```bash
# generate ssh key
ssh-keygen -t ed25519 -C "amano.takahisa@gmail.com"
# start ssh-agent
eval "$(ssh-agent -s)"
# add ssh key to the agent
ssh-add ~/.ssh/id_ed25519
```
Register ssh key to github
```bash
cat ~/.ssh/id_ed25519.pub
# Then select and copy the contents of the id_ed25519.pub file
# displayed in the terminal to your clipboard
```
and paste to GitHub ssh key setting

## dotfiles

```bash
cd ~
git clone git@github.com:amano-takahisa/dotfiles.git

ln -s ~/dotfiles/.bash_aliases
ln -s ~/dotfiles/.condarc
ln -s ~/dotfiles/.cookiecutterrc
ln -s ~/dotfiles/.tmux.conf
ln -s ~/dotfiles/.config/flake8 .config/flake8

mkdir -p .config/git
ln -s ~/dotfiles/.config/git/config .config/git/config
ln -s ~/dotfiles/.config/git/ignore .config/git/ignore

mkdir mypy
ln -s ~/dotfiles/.config/mypy/config/mypy.ini .config/mypy/config/mypy.ini

mkdir -p .config/nvim/after/ftplugin
ln -s ~/dotfiles/.config/nvim/init.vim .config/nvim/init.vim
ln -s ~/dotfiles/.config/nvim/coc-settings.json .config/nvim/coc-settings.json
ln -s ~/dotfiles/.config/nvim/after/ftplugin/dockerfile.vim .config/nvim/after/ftplugin/dockerfile.vim
ln -s ~/dotfiles/.config/nvim/after/ftplugin/markdown.vim .config/nvim/after/ftplugin/markdown.vim
ln -s ~/dotfiles/.config/nvim/after/ftplugin/sh.vim .config/nvim/after/ftplugin/sh.vim

mkdir -p .config/qt5ct/qss
ln -s ~/dotfiles/.config/qt5ct/qss/dolphin_fix_bg.qss .config/qt5ct/qss/dolphin_fix_bg.qss

mkdir -p .config/tmux
ln -s ~/dotfiles/.config/tmux/pane-border-format.sh .config/tmux/pane-border-format.sh
```
## terminal
### PS1
Edit `.bashrc` to modify PS1 as follows.

From:
```
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

```

To:
```
parse_git_branch() {
  GIT_CURRRENT_BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [ -z "$GIT_CURRRENT_BRANCH" ]
  then
      :
  else
      echo -e "\e[38;5;130m${CHAR_BRANCH} \e[00m${GIT_CURRRENT_BRANCH}"
  fi
  #git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/$CHAR_BRANCH \1/"
}


parse_conda_env() {
    if [ -z "$CONDA_DEFAULT_ENV" ]
    then
        :
    else
        echo -e "\e[32m${CHAR_PYTHON} \e[00m`basename ${CONDA_DEFAULT_ENV}`"
    fi
}

CHAR_PYTHON=$'\uE606'
CHAR_BRANCH=$'\uE725'
# CHAR_PROMPT=$'\uE285\uE285'
CHAR_PROMPT='$ '
CHAR_RFRAME=$'\uE0C0'
CHAR_MANTLELAB=$'\uE257'
CHAR_RPIXEL=$'\uE0C6'
CHAR_NUCLER=$'\uE7BA'
CHAR_STAR=$'\u272F'
CHAR_LAPTOP=$'\uF109'


if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="\e[38;5;208;100m${debian_chroot:+($debian_chroot)}\u${CHAR_MLLOGO} \h\e[90;48;5;236m$CHAR_RPIXEL \e[38;5;208m\w\e[00m\e[38;5;236m$CHAR_RPIXEL \e[00m\n\
"'`date +%X%:::z`'"\$(parse_conda_env)\$(parse_git_branch)\n\
$CHAR_PROMPT "
else
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='`date +%X%:::z`\n${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt
```

### Alias
Remove alias section from `.bashrc` since alias is managed in `.bash_aliases`

## tmux
### Install
```bash
sudo apt install tmux
```
or, get [AppImage](https://github.com/nelsonenzo/tmux-appimage/releases),
or [build and install](https://github.com/tmux/tmux#installation).

### Setup
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
and on tmux `<prefix> + I` to install plugins.

## nodejs
Required for COC NeoVim
https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
```bash
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs
```

## ctags
Requried for gutentag plugin for Neovim
```bash
sudo snap install universal-ctags
```

## Neovim
### Install
https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
ln -s /usr/bin/nvim ~/bin/nvim
```
### Setup
Install plugin manager
https://github.com/junegunn/vim-plug#unix-linux

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
Install plugins
```
:PlugInstall
```

## Docker
### Install
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
```
### Setup
```bash
sudo usermod -aG docker ${USER}
newgrp docker
```

## Install font
### Install
```bash
curl -L -O https://github.com/miiton/Cica/releases/download/v5.0.2/Cica_v5.0.2_with_emoji.zip
sudo mkdir /usr/share/fonts/truetype/cica
sudo unzip Cica_v5.0.2_with_emoji.zip -d /usr/share/fonts/truetype/cica
sudo fc-cache -vf
rm Cica_v5.0.2_with_emoji.zip
fc-list | grep -i cica
```

### Setup
Add to gnome terminal font list
```bash
$ gsettings get org.gnome.Terminal.ProfilesList list
['b1dcc9dd-5262-4d8d-a863-c897e6d979b9']

$ gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ font "Cica 12"
```

## Dolphin
### Install
```bash
sudo apt install dolphin konsole
```

### Setup


## Conda
### Install
Use miniconda
https://repo.anaconda.com/miniconda//
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

```
Agree EULA and follow installer messages.

### Setup
Setup conda environment
```bash
conda create -n py38 python=3.8.3
conda create -n py310 python=3.10
```

## GDAL
```bash
# sudo add-apt-repository ppa:ubuntugis/ppa
# sudo apt install libgdal-dev
```


## Jupyter lab
```bash
pip install jupyterlab
```

## Slack
Download `.deb` from [Slack](https://downloads.slack-edge.com/linux_releases/slack-desktop-4.12.2-amd64.deb)
Then install.
```bash
wget https://downloads.slack-edge.com/releases/linux/4.23.0/prod/x64/slack-desktop-4.23.0-amd64.deb
sudo dpkg -i slack-desktop-4.23.0-amd64.deb
rm slack-desktop-4.23.0-amd64.deb
```

## QGIS
### Install
https://qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu
```bash
wget -qO - https://qgis.org/downloads/qgis-2021.gpg.key | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import
sudo chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg
sudo add-apt-repository "deb [arch=amd64] https://qgis.org/ubuntu $(lsb_release -c -s) main"
sudo apt install qgis qgis-plugin-grass
```

## Shutter
```bash
sudo add-apt-repository ppa:shutter/ppa
sudo apt-get update
sudo apt install shutter
```
Additional install for shutter
```bash
sudo apt install gnome-web-photo 
```
Optional, if not installed.
```bash
sudo apt install gir1.2-appindicator3-0.1
```
At 2021-12-26, shutter version 0.99.2 is not support weyland.
Some features are not available on that.
Therefore, using ubuntu xorg is recommended for the time.
1. At the login screen click on the cog icon beside the "Sign In" button.
2. Select the option "Ubuntu on Xorg."
3. Enter your password and log in to your Ubuntu machine.


## Google chrome
```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

## Jupyter book

```bash
pip install -U jupyter-book
```
