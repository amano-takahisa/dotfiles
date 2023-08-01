#!/bin/bash

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
DOTFILES_REPO="${USER_HOME}"/Documents/git/dotfiles

PATH="${USER_HOME}/.local/bin:${PATH}"

cd "${USER_HOME}"

####### dotfiles #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/

####### bin #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/bin/

####### bash #######
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.bash_aliases "${USER_HOME}"/.bash_aliases
rm "${USER_HOME}"/.bashrc
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.bashrc "${USER_HOME}"/.bashrc
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.profile "${USER_HOME}"/.profile
rm "${USER_HOME}"/.bash_profile
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.bash_profile "${USER_HOME}"/.bash_profile

####### zsh #######
pacman -S --noconfirm --needed \
    zsh zsh-completions

# set zsh as default shell
chsh -s "$(which zsh)" "${USER}"

# ohmyzsh
sudo -u "${USER}" ZSH="${USER_HOME}/Documents/git/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.zshenv "${USER_HOME}"
sudo -u "${USER}" mkdir "${USER_HOME}"/.config/zsh
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/zsh "${USER_HOME}"/.config/zsh
rm "${USER_HOME}"/.zshrc

# zsh theme
sudo -u "${USER}" git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${USER_HOME}/Documents/git/oh-my-zsh/custom/themes/powerlevel10k

# zsh custom
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/misc/omz_custom/* \
    "${USER_HOME}"/Documents/git/oh-my-zsh/custom/


####### package manager #######
pacman -S --noconfirm --needed \
    base-devel
sudo -u "${USER}" git clone https://aur.archlinux.org/paru.git
cd paru
sudo -u "${USER}" makepkg -si --noconfirm
cd "${USER_HOME}"

####### git #######
sudo -u "${USER}" paru -S --noconfirm --needed \
    git-secrets
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/git "${USER_HOME}"/.config/git

pacman -S --noconfirm --needed \
    lazygit

####### neovim #######
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/nvim "${USER_HOME}"/.config/nvim

####### tmux #######
pacman -S --noconfirm --needed \
    tmux
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.tmux.conf "${USER_HOME}"/.tmux.conf

####### XDG #######
pacman -S --noconfirm --needed \
    xdg-user-dirs
sudo -u "${USER}" xdg-user-dirs-update

ln -sf "${DOTFILES_REPO}"/misc/xdgenv.sh /etc/profile.d/xdgenv.sh

####### fzf #######
pacman -S --noconfirm --needed \
    fzf

####### zip #######
pacman -S --noconfirm --needed \
    zip unzip

####### Docker #######
pacman -S --noconfirm --needed \
    docker docker-compose
usermod -aG docker "${USER}"
systemctl start docker
systemctl enable docker
pacman -S --noconfirm --needed \
    docker-buildx

####### fd #######
pacman -S --noconfirm --needed \
    fd

####### tree #######
pacman -S --noconfirm --needed \
    tree

####### man #######
pacman -S --noconfirm --needed \
    mandoc

####### ripgrep #######
pacman -S --noconfirm --needed \
    ripgrep

####### Localization #######
# Fonts
pacman -S --noconfirm --needed \
    otf-ipafont otf-ipaexfont  ttf-hack-nerd \
    ttf-mplus-nerd ttf-noto-nerd
# IME
sudo -u "${USER}" paru -S --noconfirm --needed \
    fcitx5-mozc-ut
pacman -S --noconfirm --needed \
    fcitx5-configtool

####### Python #######
pacman -S --noconfirm --needed \
    python-pip

pacman -S --noconfirm --needed \
    pyright

pacman -S --noconfirm --needed \
    pyenv

sudo -u "${USER}" pip install pylama autopep8

# conda environment
sudo -u "${USER}" paru -S --noconfirm --needed \
    miniconda3
ln -sf /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh

sudo -u "${USER}" /opt/miniconda3/bin/conda init zsh

# Thonny for raspberry pi pico
sudo -u "${USER}" paru -S --noconfirm --needed \
    thonny esptool python-ptyprocess python-build
# add to uucp group to communicate pico
usermod -a -G uucp "${USER}"

####### R #######
pacman -S --noconfirm --needed \
    r
sudo -u "${USER}" paru -S --noconfirm --needed \
    rstudio-desktop-bin r-tinytex

####### Rust #######
sudo -u "${USER}" curl --proto '=https' --tlsv1.2 -sSf \
    https://sh.rustup.rs | sh

####### GIS/RS #######
# QGIS
pacman -S --noconfirm --needed \
    qgis python-yaml python-gdal python-psycopg2
sudo -u "${USER}" pip install Jinja2 Pygments owslib
# GRASS GIS
sudo -u "${USER}" paru -S --noconfirm --needed \
    grass

####### Web browser #######
sudo -u "${USER}" paru -S --noconfirm --needed \
    google-chrome

####### Slack #######
sudo -u "${USER}" paru -S --noconfirm --needed \
    slack-desktop

####### Office #######
pacman -S --noconfirm --needed \
    libreoffice-still

####### Desktop utils #######
# Screen shot
pacman -S --noconfirm --needed \
    spectacle

####### Node #######
sudo -u "${USER}" paru -S --noconfirm --needed \
    nvm
pacman -S --noconfirm --needed \
        npm

####### node tools #######
sudo -u "${USER}" npm install markdownlint --save-dev
npm install -g markdownlint-cli
####### tools #######
pacman -S --noconfirm --needed \
    jq wget rsync

# disk management
sudo -u "${USER}" paru -S --noconfirm --needed \
    qdirstat

####### aws cli #######
pacman -S --noconfirm --needed \
    aws-cli-v2

####### Bluetooth #######
pacman -S --noconfirm --needed \
    bluez  bluez-utils
systemctl start bluetooth
systemctl enable bluetooth

####### sounds #######
pacman -S --noconfirm --needed \
    alsa-utils

####### system monitor #######
pacman -S --noconfirm --needed \
    ksysguard

####### pre-commit #######
sudo -u "${USER}" pip install pre-commit

####### Clone repositories #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/Documents/git/
cd ${USER_HOME}/Documents/git
sudo -u "${USER}" git clone "git@github.com:amano-takahisa/dotfiles.git"
cd dotfiles
sudo -u "${USER}" pre-commit install
cd "${USER_HOME}"

declare -a repos=(
    "git@github.com:amano-takahisa/mypo.git"
    "git@github.com:amano-takahisa/gravel.git"
    "git@github.com:amano-takahisa/poipoi.git"
    "git@github.com:amano-takahisa/numheader.git"
    "git@github.com:amano-takahisa/czkawka.git"
)

cd ${USER_HOME}/Documents/git
for repo in "${repos[@]}"; do
    sudo -u "${USER}" git clone "${repo}"
    IFS='/.' read -ra parts <<< "${repo}"
    cd "${parts[-2]}"
    sudo -u "${USER}" pre-commit install
    cd ../
done
cd "${USER_HOME}"

####### po #######
sudo -u "${USER}" ln -sf "${USER_HOME}"/Documents/git/mypo/utils/po.py \
    "${USER_HOME}"/bin/po

####### numheader #######
sudo -u "${USER}" ln -sf "${USER_HOME}"/Documents/git/numheader/numheader/numheader.py \
    "${USER_HOME}"/bin/numheader

####### Document viewer #######
pacman -S --noconfirm --needed \
    okular

####### Document management #######
sudo -u "${USER}" paru -S --noconfirm --needed \
    zotero

####### Image viewer #######
sudo -u "${USER}" paru -S --noconfirm --needed \
    gwenview

####### media #######
pacman -S --noconfirm --needed \
    vlc

####### cloud services #######
# rclone
pacman -S --noconfirm --needed \
    rclone fuse2
# make dir for mount
sudo -u "${USER}" mkdir "${USER_HOME}"/google_drive
# to mount the drive
# rclone mount gd:/ /home/takahisa/google_drive --daemon --vfs-cache-mode full
# to unmount, run
# fusermount -u /home/takahisa/google_drive

####### Devices #######
# Logicool mouse
pacman -S --noconfirm --needed \
    solaar

####### KDE #######
# show thumbnails in Dolphin
pacman -S --noconfirm --needed \
    kdegraphics-thumbnailers

# ####### speech #######
# sudo -u "${USER}" paru -S --noconfirm --needed \
#      speech-dispatcher festival espeak-ng
#
# sudo -u "${USER}" pip install TTS

####### Disk management #######
# czkawka
# use my fork instead of official one
# pacman -S --noconfirm --needed \
#     czkawka-gui
pacman -S --noconfirm --needed \
    gtk4
cd ${USER_HOME}/Documents/git/czkawka
sudo -u "${USER}" cargo install czkawka_gui
cd "${USER_HOME}"

pacman -S --noconfirm --needed \
    partitionmanager

####### Network #######
pacman -S --noconfirm --needed \
    lsof

sudo -u "${USER}" paru -S --noconfirm --needed \
    realvnc-vnc-viewer

####### OBS #######
pacman -S --noconfirm --needed \
    obs-studio v4l2loopback-dkms linux-headers
# and follow step 2 of
# https://wiki.archlinux.org/title/V4l2loopback

####### system monitor #######
pacman -S --noconfirm --needed \
    netdata
systemctl start netdata
systemctl enable netdata

####### wine #######
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist'
pacman -S --noconfirm --needed \
    wine

####### imagemagick #######
pacman -S --noconfirm --needed \
    imagemagick
