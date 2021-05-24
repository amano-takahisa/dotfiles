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

## Install font
Git and Docker is required.
https://github.com/miiton/Cica

```bash
git clone https://github.com/miiton/Cica.git
cd Cica
docker-compose build ; docker-compose run --rm cica
mkdir ~/.fonts
mv dist/*.ttf ~/.fonts/
```

Then set fonts from gnome-tweaks

## Install softwares and setup
Prepare directory
```bash
mkdir ~/bin
```

### Tools from Ubuntu repo
```bash
sudo apt install \
    tree \
    curl \
    ctags \
    gnome-tweaks \
    tmux \
    dolphin \
    htop \
    gcc \
    python3-dev \
    grass \
    qt5ct \
    libgdal-dev

```

### nodejs
https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
```bash
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install -y nodejs

```
### Git
```bash
sudo apt install git
```
or
```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```
### github
Follow [this](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
and [this](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).


### dotfiles
```bash
cd ~
git clone git@github.com:amano-takahisa/dotfiles.git

ln -s ~/dotfiles/.bash_aliases
ln -s ~/dotfiles/.tmux.conf
mkdir .config/git
ln -s ~/dotfiles/.config/git/config .config/git/config
ln -s ~/dotfiles/.config/git/ignore .config/git/ignore
mkdir mkdir .config/nvim
ln -s ~/dotfiles/.config/nvim/init.vim .config/nvim/init.vim
ln -s ~/dotfiles/.config/nvim/coc-settings.json .config/nvim/coc-settings.json

```

### tmux

tmux plugins
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
and on tmux `<prefix> + I` to install plugins.

### Neovim

https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
ln -s /usr/bin/nvim ~/bin/nvim
```

Install plugin manager
https://github.com/junegunn/vim-plug#unix-linux

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
Install semshi
https://github.com/numirias/semshi
Semshi itself will be installed with Plug-vim plugin manager
```bash
conda install -c conda-forge pynvim 
```


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

CHAR_PYTHON=$'\uE235'
CHAR_BRANCH=$'\uF418'
CHAR_PROMPT=$'\uE285\uE285'
# CHAR_PROMPT=$'\uF101'
CHAR_RFRAME=$'\uE0C0'
CHAR_MLLOGO=$'\uE257'
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


