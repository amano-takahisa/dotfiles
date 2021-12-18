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
    tree
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
CHAR_PROMPT=$'\uE285\uE285'
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
```

***************************************

## Install font
Git and Docker is required.
https://github.com/miiton/Cica


Install semshi
https://github.com/numirias/semshi
Semshi itself will be installed with Plug-vim plugin manager
```bash
conda install -c conda-forge pynvim 
```

```bash
git clone https://github.com/miiton/Cica.git
cd Cica
docker-compose build ; docker-compose run --rm cica
mkdir ~/.fonts
mv dist/*.ttf ~/.fonts/
```

Then set fonts from gnome-tweaks

## Install softwares and setup

### Tools from Ubuntu repo
```bash
sudo apt install \
    tree \
    tmux \
    dolphin \
    htop \
    gcc \
    python3-dev \
    grass \
    qt5ct \
    libgdal-dev

```

### github
Follow [this](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
and [this](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).






### Docker
https://docs.docker.com/engine/install/ubuntu/
```bash
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    cmake \
    build-essential \
    libgl1-mesa-dev \
    mlocate


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose
sudo docker run hello-world

sudo usermod -aG docker ${USER}
newgrp docker
```

### Conda
Use miniconda
https://repo.anaconda.com/miniconda//
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.3-Linux-x86_64.sh
bash Miniconda3-py38_4.8.3-Linux-x86_64.sh
```
Agree EULA and follow installer messages.

Setup conda environment
```bash
conda create -n py38 python=3.8.3
```

Conda packages
```bash
conda install -c conda-forge jupyterlab descartes autopep8 ipywidgets altair
```

Pip packages
```bash
pip install grass-session
```

### Slack
Download `.deb` from [Slack](https://downloads.slack-edge.com/linux_releases/slack-desktop-4.12.2-amd64.deb)
Then install.
```bash
sudo dpkg -i slack-desktop-4.12.2-amd64.deb
```
### QGIS
https://www.qgis.org/en/site/forusers/alldownloads.html
```bash
wget -qO - https://qgis.org/downloads/qgis-2020.gpg.key | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import
sudo chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg
sudo add-apt-repository "deb [arch=amd64] https://qgis.org/ubuntu `lsb_release -c -s` main"

```

### Orfeo Toolbox
```bash
wget https://www.orfeo-toolbox.org/packages/OTB-7.2.0-Linux64.run
chmod +x OTB-7.2.0-Linux64.run
./OTB-7.2.0-Linux64.run
```

Re-compile for python 3.8
https://www.orfeo-toolbox.org/CookBook/Installation.html#id4
```
cd ~/OTB-7.2.0-Linux64
source otbenv.profile
ctest -S share/otb/swig/build_wrapping.cmake -VV
```

### Google chrome
```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

### Shutter
```bash
sudo add-apt-repository ppa:linuxuprising/shutter
sudo apt-get update
sudo apt install shutter
```


### wine and kindle

Install wine
```bash
sudo dpkg --add-architecture i386
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport
sudo apt update && sudo apt install -y --install-recommends winehq-devel
cd "${HOME}/Downloads"
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
```

Install kindle
```bash
mkdir -p ${WINEPREFIX:-$HOME/.wine}/drive_c/users/$USER/AppData/Local/Amazon/Kindle
wine KindleForPC-installer-1.30.59056.exe
```

### Japanese environments
#### Ubuntu settings
 

- hide top bar
https://extensions.gnome.org/extension/545/hide-top-bar/

- Auto-hide the Dock


## Bash
## GPU
Install CUDA Toolkit by folliowing [this](https://developer.nvidia.com/cuda-toolkit).

https://github.com/tensorflow/tensorflow/issues/44777#issuecomment-771285431
```bash
echo export LD_LIBRARY_PATH=/usr/local/cuda-11.2/lib64 >> .bashrc
```
```
cd $LD_LIBRARY_PATH
sudo ln libcusolver.so.11 libcusolver.so.10  # hard link
```

Install libcudnn8 if necessary

https://github.com/tensorflow/tensorflow/issues/45200#issuecomment-786641172


