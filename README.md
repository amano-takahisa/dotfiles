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
    fzf \
    xclip \
    jq \
    kate
```

Prepare directory
```bash
mkdir ~/bin ~/Applications
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
and install Japanese.
Then, activate input method.

- Settings > Region & Language > Input Source > add Japanese (Mozc)
- Formats > United Kingdom

import key map

### GNOME settings
- Auto hide Dock
- Dark window theme
- Accessibility > Cursor size > enlarge
- Accessibility > Hearing > enable visual alart
- Default Applications > Web > Firefox

Hide top bar

```bash
sudo apt-get install chrome-gnome-shell
```

https://extensions.gnome.org/extension/545/hide-top-bar/

### wi-fi settings
If a computer can't connect to specific wifi, try to strict to use 2.4Ghz band.
You can configure this with an "Advanced Network Configuration" tool.
```bash
# sudo apt install net-tools  # <- not necessary?
```
Then start Advanced Network Configuration tool `nm-connection-editor` and set wifi band to B/G (2.4GHz).

### Fix wakeup issue (If there is a problem)
https://askubuntu.com/a/1361408/

> Open with e.g. vim: `sudo vim /etc/default/grub`
> Add `amd_iommu=off` to option of `GRUB_CMDLINE_LINUX_DEFAULT`.
> (For me it was `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`
> to begin with, and `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amd_iommu=off"`
> after editing.)

## XDG environment setup
Set `XDG_XXX_HOME` variables.
https://chiyosuke.blogspot.com/2019/04/blog-post_27.html
```bash
sudo cp ~/dotfiles/misc/xdgenv.sh /etc/profile.d/
```


## Full screen to dual monitor
```bash
sudo apt install compizconfig-settings-manager
```
and open *CompizConfig Settings Manager*




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

and
```bash
sudo apt install git-secret
```

## GitHub

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
https://github.com/settings/ssh/new

## GitHub cli
https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt

```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

### Setup
```bash
gh auth login
```

## dotfiles

```bash
cd ~
git clone git@github.com:amano-takahisa/dotfiles.git

ln -s ~/dotfiles/.bash_aliases
ln -s ~/dotfiles/.condarc
ln -s ~/dotfiles/.cookiecutterrc
ln -s ~/dotfiles/.tmux.conf
ln -s ~/dotfiles/.config/flake8 ~/.config/flake8

mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/config ~/.config/git/config
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore

mkdir -p ~/.config/mypy/config
ln -s ~/dotfiles/.config/mypy/config/mypy.ini ~/.config/mypy/config/mypy.ini

ln -s ~/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/dotfiles/.config/lvim ~/.config/lvim

mkdir -p ~/.config/qt5ct/qss
ln -s ~/dotfiles/.config/qt5ct/qss/dolphin_fix_bg.qss ~/.config/qt5ct/qss/dolphin_fix_bg.qss

mkdir -p ~/.config/tmux
ln -s ~/dotfiles/.config/tmux/pane-border-format.sh ~/.config/tmux/pane-border-format.sh
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
CHAR_PROMPT='$'
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

In case appimage,

```bash
wget <url-to-app-image>
chmod +x tmux.appimage
mv tmux.appimage ~/Applications
ln -s ~/Applications/tmux.appimage ~/bin/
sudo apt-get install fuse libfuse2
```

### Setup
```bash
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
and on tmux `<prefix> + I` to install plugins.

# Install node version manager
# https://github.com/nvm-sh/nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# install node
nvm install node
```

# install cargo (Rust package manager)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```


## ctags
Requried for gutentag plugin for Neovim
```bash
# snap version of ctags is not compatible with gutentag
# https://github.com/ludovicchabant/vim-gutentags/issues/267
# sudo snap install universal-ctags

sudo apt install universal-ctags
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

Or build from source
```bash
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

git clone https://github.com/neovim/neovim
cd neovim && make
sudo make install
ln -s /usr/local/bin/nvim ~/bin/nvim
cd ~
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
:UpdateRemotePlugins
```

For semshi
```console
# https://github.com/numirias/semshi#installation
sudo apt install python3-pip
pip3 install pynvim --upgrade
```
Coc

```
:CocInstall coc-pyright
```

## LunarVim
Requirements:
https://www.lunarvim.org/01-installing.html

- NeoVim (0.7 +)
- git, make, pip, npm, node

```
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

LunarVim will be installed at `$HOME/.local/bin/lvim`. Make a symbolic link in `$home/bin/`.
```bash
ln -s $HOME/.local/bin/lvim $HOME/bin/
```

Configuration files are under `$HOME/.config/lvim/`.


## Docker
### Install
https://docs.docker.com/engine/install/ubuntu/
```bash
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
### Setup
```bash
sudo usermod -aG docker ${USER}
newgrp docker
```

### Test installation
```bash
sudo docker run hello-world
```


## Install font
### Install Cica
```bash
curl -L -O https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip
sudo mkdir /usr/share/fonts/truetype/cica
sudo unzip Cica_v5.0.3.zip -d /usr/share/fonts/truetype/cica
sudo fc-cache -vf
rm Cica_v5.0.3.zip
fc-list | grep -i cica
```

### Setup Cica
Add to gnome terminal font list
```bash
gsettings get org.gnome.Terminal.ProfilesList list
# ['b1dcc9dd-5262-4d8d-a863-c897e6d979b9']

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ font "Cica 12"
```

Set Cica font as default mono font from tweaks app.

### Install Nerd font
Follow https://github.com/ronniedroid/getnf
Install *Hack*

```bash
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ font "Hack 12"
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
In each environment,
```bash
pip install pyright pre-commit isort autopep8 pyright awscli
```

If you get an error like the following, the `GDAL_DATA` path is not set properly.
```
CRSError: The EPSG code is unknown. Unable to open EPSG support file gcs.csv.  Try setting the GDAL_DATA environment variable to point to the directory containing EPSG csv files.
```
Stop modifiing `GDAL_DATA` by conda init, and use system default.
```bash
mv $CONDA_PREFIX/etc/conda/activate.d/gdal-activate.sh $CONDA_PREFIX/etc/conda/activate.d/gdal-activate.sh.bak
mv $CONDA_PREFIX/etc/conda/deactivate.d/gdal-deactivate.sh $CONDA_PREFIX/etc/conda/deactivate.d/gdal-deactivate.sh.bak
```



## Git hooks
```bash
pip install pre-commit
```
in git repository,
```bash
pre-commit sample-config > .pre-commit-config.yaml
pre-commit install
```


## GDAL
```bash
# sudo add-apt-repository ppa:ubuntugis/ppa
sudo apt install libgdal-dev
pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}')
```


## Jupyter lab
```bash
pip install jupyterlab
```
install following extentions.
- @jupyter-widgets/jupyterlab-manager
- jupyter-leaflet
- nbdime-jupyterlab
    - requires `pip install nbdime`
- jupyter-matplotlib
- @lckr/jupyterlab_variableinspector
- @ryantam626/jupyterlab_code_formatter
    - requires `pip install jupyterlab_code_formatter` 
- @axlair/jupyterlab_vim
- @krassowski/jupyterlab-lsp
    - requires `pip install jupyterlab-lsp` 

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

## Orfeo toolbox
### Install
```python
wget https://www.orfeo-toolbox.org/packages/OTB-8.0.1-Linux64.run
chmod +x OTB-8.0.1-Linux64.run
./OTB-8.0.1-Linux64.run
sudo apt-get -y install cmake build-essential libgl1-mesa-dev
cd OTB-8.0.1-Linux64
ctest -S share/otb/swig/build_wrapping.cmake -VV

# following symbolic link part should be moved into a script which run when conda activate.
ln -s $CONDA_PREFIX/lib/libpython3.8.so.1.0 /home/takahisa/OTB-7.2.0-Linux64/lib/libpython3.8.so.1.0
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

## OBS
```bash
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install obs-studio

```

## Google chrome
```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb 
```
## Google earth
```bash
wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
sudo dpkg -i google-earth-stable*.deb
```

## Sphinx
```bash
sudo apt install python3-sphinx
# in conda env,
pip install sphinx-rtd-theme
conda install -c conda-forge nbsphinx pandoc ipython

```

## Jupyter book

```bash
pip install -U jupyter-book
```

## peek
```bash
sudo apt install peek
```

## Other
```bash
# aws
sudo apt install awscli
```

## wine
```bash
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo mv winehq.key /usr/share/keyrings/winehq-archive.key
sudo apt install --install-recommends winehq-devel
cd ~/bin
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
```
## VPN

```bash
sudo apt install openvpn
```
### Usage
```bash
sudo openvpn --config <path to .ovpn file>
```

## Kindle
Download kindle installer from Amazon, and install via wine.
If Japanese texts are tofu, install JCK fonts via winetricks.


## direnv
Install
```bash
sudo apt install direnv
```

## alacritty
https://github.com/alacritty/alacritty/blob/master/INSTALL.md
```bash
git clone https://github.com/alacritty/alacritty.git
cd alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# To make sure you have the right Rust compiler installed, run
# rustup override set stable
# rustup update stable

# build
cargo build --release

# install it globally
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# Desktop Entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Shell completions
echo "source $(pwd)/extra/completions/alacritty.bash" >> ~/.bashrc

```


