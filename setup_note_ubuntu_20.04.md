Set up note for Ubuntu 18.04.

# Install
Install from live USB
[Install Ubuntu]

## Keyboard layout
English(US), English(US)
[Continue]

## Update and other software
x Normal Installation
x Download updates while installing Ubuntu
x Install third party software for ...
[Continue]

## Installation type
x Something else
[Continue]

## Install
Select partition to install ubuntu
[Change...]
Edit partition
Use as Ext4
x Format the partition
Mount Point: /
[Install Now]

## Where are you?
Vienna
[Continue]

## Who are you?
Your name: Takahisa Amano
Your computer's name: CF-SX2
Pick a username: takahisa
Choose a password: **********
Confirm your password: **********

x Require my password to login

===================================

# Ubuntu application setup
## Update repository and upgrade
```bash
sudo apt update
sudo apt upgrade
```

## Add Japanese repository
```bash
wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -
sudo wget https://www.ubuntulinux.jp/sources.list.d/focal.list -O /etc/apt/sources.list.d/ubuntu-ja.list
sudo apt update

```

## setup Japanese language support
follow the instruction of Ubuntu Japanese team.
https://www.ubuntulinux.jp/japanese


## software update settings
- Activities > software & Updates > settings 
Ubuntu Software: 
select ubuntu software server as your near location.
- Select othoers... > Select best server
- Other Software:
Check mark on at Canonical Partners.

# Install system tools
```bash
sudo apt install \
dolphin \
wine64 \
winetricks \
vim \
arandr \
gimp \
vlc \
okular \
dolphin-plugins \
git \
automake \  # make command
libevent-dev \  # when tmux building 
libncurses-dev \  # when tmux building 
byacc \  # when tmux building 
gnome-shell-extensions \
screenfetch  \ # sprash screen of terminal
libxml2-dev \ # tidyverse for R 
libssl-dev \  # tidyverse for R 
libcurl4-openssl-dev \  # tidyverse for R 
systemsettings  \ # icons for dolphin
qt5-gtk2-platformtheme libqt5svg5   \ # icons for dolphin
qt5ct \ # icons for dolphin do export QT_QPA_PLATFORMTHEME=qt5ct
git-flow \
font-manager \
gconf2 \
mlocate \
jupyter-core \
iree \
neovim \
r-base \
fontforge \
libudunits2-dev \ # sf for R
libgdal-dev \  # sf for R
rename \
tree \
nodejs


```
# setup git
```bash
git config --global core.editor "nvim"
git config --global user.name "Takahisa Amano"
git config --global user.email 51368373+amano-takahisa@users.noreply.github.com

```

# clone my dotfiles

# copy ssh files from other PC


# Install programming tools
## install Anaconda3
```bash
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
bash Anaconda3-2020.02-Linux-x86_64.sh
rm Anaconda3-2020.02-Linux-x86_64.sh
source .bashrc
conda update conda
```

## setup conda environment
```bash
# create condarc
conda config
conda config --add channels conda-forge
conda config --set channel_priority strict
conda config --set changeps1 False


conda create --name py37 python=3.7
conda activate py37

# install python packages

conda install -c conda-forge \
geopandas \
rasterio \
matplotlib \
seaborn \
jupyterlab \
descartes \
autoflake \
black \
prospector \
mypy
```
# PS1
modify `.bashrc`

```bash
#### Customize PS1 ####
parse_git_branch() {
  GIT_CURRRENT_BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"` 
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

CHAR_PYTHON=$'\UE235'
CHAR_BRANCH=$'\UF418'
CHAR_PROMPT=$'\UE285\UE285'
# CHAR_PROMPT=$'\uF101'
CHAR_RFRAME=$'\UE0C0'
CHAR_MANTLELAB=$'\UE257'
CHAR_RPIXEL=$'\UE0C6'
CHAR_NUCLER=$'\UE7BA'
CHAR_STAR=$'\U272F'
CHAR_LAPTOP=$'\UF109'


if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="\e[100m${debian_chroot:+($debian_chroot)}\u\e[38;5;190m${CHAR_NUCLER} \e[39m\h\e[90;48;5;236m$CHAR_RPIXEL\e[94m \w\e[00m\e[38;5;236m$CHAR_RPIXEL \e[00m\n\
"'`date +%X%:::z`'"\$(parse_conda_env)\$(parse_git_branch)\n\
$CHAR_PROMPT "
else
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='`date +%X%:::z`\n${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
##############

```


# Install Docker
```bash
# https://docs.docker.com/engine/install/ubuntu/#installation-methods
sudo apt install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt install docker-ce docker-ce-cli containerd.io
```

after install docker, make docker group.
https://docs.docker.com/engine/install/linux-postinstall/

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
# newgrp docker
```

and start docker when login
```bash
sudo systemctl enable docker
```
# setup neovim
## Plugin manager

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```


# install tmux
build tmux and make symbolic link to the tmux binary.
Follow the maual to build tmux but after apply patch in next section.
https://github.com/tmux/tmux#from-version-control

## double width letter issue on tmux
apply following patch
https://github.com/z80oolong/tmux-eaw-fix

## install tmux plugin manager
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
and on tmux `<prefix> + I` to install plugins.


# Font

## Install Ricty
follow official instruction.

1. download Inconsolata 
https://fonts.google.com/download?family=Inconsolata


```bash
wget https://rictyfonts.github.io/files/ricty_generator-4.1.1.sh

```

## Install Cica font
font files are saved in `cica/dist/`

```bash
# https://github.com/miiton/Cica#%E6%89%8B%E5%8B%95%E3%81%A7%E3%82%84%E3%82%8B%E5%A0%B4%E5%90%88
sudo apt-get update
sudo apt-get -y install apt-file
sudo apt-file update
sudo apt-file search add-apt-repository
sudo apt-get -y install software-properties-common
sudo apt-get -y install fontforge unar
git clone git@github.com:miiton/Cica.git
cd Cica
curl -L https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip -o hack.zip
unar hack.zip
cp ttf/* sourceFonts/
rm hack.zip
rm -r ttf
curl -LO https://osdn.jp/downloads/users/8/8598/rounded-mgenplus-20150602.7z
unar rounded-mgenplus-20150602.7z
cp rounded-mgenplus-20150602/rounded-mgenplus-1m-regular.ttf ./sourceFonts
cp rounded-mgenplus-20150602/rounded-mgenplus-1m-bold.ttf ./sourceFonts
curl -L https://github.com/googlei18n/noto-emoji/raw/master/fonts/NotoEmoji-Regular.ttf -o sourceFonts/NotoEmoji-Regular.ttf
curl -LO http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.zip
unar dejavu-fonts-ttf-2.37.zip
mv dejavu-fonts-ttf-2.37/ttf/DejaVuSansMono.ttf ./sourceFonts/
mv dejavu-fonts-ttf-2.37/ttf/DejaVuSansMono-Bold.ttf ./sourceFonts/
curl -L https://github.com/mirmat/iconsfordevs/raw/master/fonts/iconsfordevs.ttf -o sourceFonts/iconsfordevs.ttf
fontforge -lang=py -script cica.py
```

# use windows fonts
sudo ln -s /media/takahisa/50F442DEF442C5C6/Windows/Fonts /usr/share/fonts/winfonts

# install slack
```bash
sudo snap install slack --classic
```


# install gis related packages
add following lines to `/etc/apt/source.list`
```
deb [arch=amd64] https://qgis.org/ubuntu/  focal main
# deb-src [arch=amd64] https://qgis.org/ubuntu/ focal main
```
run
```bash
wget -O - https://qgis.org/downloads/qgis-2019.gpg.key | gpg --import
gpg --fingerprint 51F523511C7028C3
gpg --export --armor 51F523511C7028C3 | sudo apt-key add -
sudo apt update

sudo apt install qgis
```

# Install R-studio
download deb package from https://www.rstudio.com/products/rstudio/download/

```bash
# install dependency
sudo apt install libclang-dev
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.959-amd64.deb
sudo dpkg -i rstudio-1.3.959-amd64.deb
rm rstudio-1.3.959-amd64.deb
```

# install google chrome

## from repository
add the following line in `/etc/apt/sources.list.d/google-chrome.list`
```
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
```
get key and install via apt
```bash
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
sudo apt update
sudo apt install google-chrome-stable
```

# Install IME
Settings > Region & Language > Input Sources > Others > Japanese (Mozc)
                             > Manage Installed Languages > Japanese
# Custom key map for mozc


# keyboard setting
```bash
sudo apt install gnome-tweak-tool
```
# google earth engine

# customize gnome panels
## hide top bar
https://extensions.gnome.org/extension/545/hide-top-bar/

# install shutter
```
sudo add-apt-repository ppa:linuxuprising/shutter
sudo apt install shutter
```
if you get error as `Updating from such a repository can't be done securely, and is therefore disabled by default.`, modify `/etc/apt/source.list.d/linuxuprising-ubuntu-shutter-focal.list` as

```
deb [trusted=yes] http://ppa.launchpad.net/linuxuprising/shutter/ubuntu focal main
```
