#!/bin/bash
# This script is expectedt to be run just after archinstall.
# Options for the archinstall is as follows:
#   Mirrors: Where you are.
#   Disk configuration:
#       Use a best-effort default partition layout
#           btrfs, default structure, BTRFS compression
#   User account: with sodo
#   Profile:
#       Desktop KDE
#       Graphic driver: nvidia (proprietary)
#       greeter: sddm
#   Audio: pulseaudio
#   Network configuration: Use NetworkManager
#   Timezone: Where you are
#
# Then, install and setup git, firefox, etc.
#
# ```bash
# sudo pacman -Syyu --noconfirm --needed neovim python-neovim xclip wl-clipboard firefox openssh git github-cli
# gh auth login -p ssh -h github.com -w
# ```
#
# Then,
#
# ```bash
# mkdir -p ~/Documents/git \
#     && git clone "git@github.com:amano-takahisa/dotfiles.git" ~/Documents/git/dotfiles \
#     && ln -sf ~/Documents/git/dotfiles/.config/git ~/.config/git
# ```
# and run followings with sudo
#
# TODO: Looking for a way to call yay command non-interactively.

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
REPOS_DIR="${USER_HOME}"/Documents/git
DOTFILES_REPO="${REPOS_DIR}"/dotfiles


cd "${USER_HOME}"

####### gpg key #######
sudo -u "${USER}" curl -sS https://github.com/web-flow.gpg | sudo -u "${USER}" gpg --import -

####### dotfiles #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/

####### ssh config #######
sudo -u "${USER}" ln -sf "${USER_HOME}"/Documents/secrets/.ssh/config "${USER_HOME}"/.ssh/config

####### bin #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/bin/
export PATH="/home/takahisa/bin/:${PATH}"

####### Clone repositories #######
sudo -u "${USER}" git clone "git@github.com:amano-takahisa/multigit.git" "${USER_HOME}"/Documents/git/multigit
sudo -u "${USER}" ln -sf "${REPOS_DIR}"/multigit/multigit.py "${USER_HOME}"/bin/mg
cd ${USER_HOME}/Documents/git
sudo -u "${USER}" mg clone -u amano-takahisa
cd "${USER_HOME}"

##### package manager #######
pacman -S --noconfirm --needed \
    base-devel
sudo -u "${USER}" git clone https://aur.archlinux.org/yay-bin.git ${USER_HOME}/Documents/git/yay
cd ${REPOS_DIR}/yay
sudo -u "${USER}"  makepkg -si
# <----   HERE root password will be asked. ----> #
cd "${USER_HOME}"

####### git #######
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    git-secrets

####### neovim #######
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/nvim "${USER_HOME}"/.config/nvim

####### wezterm #######
pacman -S --noconfirm --needed \
    wezterm libsixel

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

####### ripgrep-all #######
pacman -S --noconfirm --needed \
    ripgrep-all

####### bat #######
pacman -S --noconfirm --needed \
    bat

####### FUSE #######
# fuse is required to run appimage
pacman -S --noconfirm --needed \
    fuse2 fuse3

####### libxcrypt-compat #######
# libcrypt.so.1 is required to run appimage
# libxcrypt-compat provides libcrypt.so.1
pacman -S --noconfirm --needed \
    libxcrypt-compat

####### Localization #######
# locale
echo 'ja_JP.UTF-8 UTF-8' | tee --append /etc/locale.gen
locale-gen
# Fonts
pacman -S --noconfirm --needed \
    otf-ipafont otf-ipaexfont  ttf-hack-nerd \
    ttf-mplus-nerd ttf-noto-nerd noto-fonts-emoji

sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    ttf-hackgen

# IME
pacman -S --noconfirm --needed \
    fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-mozc
ln -sf "${DOTFILES_REPO}"/misc/fcitx.sh /etc/profile.d/fcitx.sh

####### Python #######
pacman -S --noconfirm --needed \
    python-pip


# neovim python support
# Do manually followings as a user
# ```
# mkdir -p ~/Documents/venvs/neovim && cd $_
# python -m venv venv
# source venv/bin/activate
# pip install pynvim
# ```

pacman -S --noconfirm --needed \
    tk

# # Thonny for raspberry pi pico
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#     thonny esptool python-ptyprocess python-build
# # add to uucp group to communicate pico
# usermod -a -G uucp "${USER}"
#
# # Mu for circuit python
# # download appimage from the following page
# # https://codewith.mu/en/download
# 
# ####### R #######
# pacman -S --noconfirm --needed \
#     r
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#     rstudio-desktop-bin r-tinytex
# 
# ####### Rust #######
# # Need to find a way to run this non-interactive
# sudo -u "${USER}" curl --proto '=https' --tlsv1.2 -sSf \
#     https://sh.rustup.rs | sh
# 
####### GIS/RS #######
# QGIS
pacman -S --noconfirm --needed \
    qgis python-yaml python-gdal python-psycopg2 python-owslib python-pygments python-lxml
sudo -u "${USER}" pip install Jinja2 --break-sys

# Google Earth
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    google-earth-pro

# GRASS GIS
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    grass

####### Web browser #######
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    google-chrome

####### Slack #######
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    slack-desktop


####### thinderbird #######
pacman -S --noconfirm --needed \
    thunderbird


####### Office #######
pacman -S --noconfirm --needed \
    libreoffice-still hunspell hunspell-en_us

####### Desktop utils #######
# Screen shot
pacman -S --noconfirm --needed \
    spectacle

####### Document tool #######
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    pandoc-bin

####### Node #######
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    nvm
pacman -S --noconfirm --needed \
        npm

####### node tools #######
# sudo -u "${USER}" npm install markdownlint --save-dev
# npm install -g markdownlint-cli
#
####### tools #######
pacman -S --noconfirm --needed \
    jq wget rsync less

# torrent
pacman -S --noconfirm --needed \
    qbittorrent

# disk management
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    qdirstat

pacman -S --noconfirm --needed \
    dosfstools

####### Bluetooth #######
pacman -S --noconfirm --needed \
    bluez  bluez-utils
systemctl start bluetooth
systemctl enable bluetooth

####### memo #######
pacman -S --noconfirm --needed \
    zk
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/zk "${USER_HOME}"/.config/zk

####### Document viewer #######
pacman -S --noconfirm --needed \
    okular

####### media #######
pacman -S --noconfirm --needed \
    vlc

####### Devices #######
# Logicool mouse
pacman -S --noconfirm --needed \
    solaar

####### KDE #######
# show thumbnails in Dolphin
pacman -S --noconfirm --needed \
    kdegraphics-thumbnailers

# kdeconnect
pacman -S --noconfirm --needed \
    kdeconnect sshfs xdg-desktop-portal

# ####### Disk management #######
# # czkawka
# # need to find a way to install non-interactive
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#     czkawka-gui
# # use my fork instead of official one
# # pacman -S --noconfirm --needed \
# #     gtk4
# # cd ${USER_HOME}/Documents/git/czkawka
# # sudo -u "${USER}" cargo install czkawka_gui
# # cd "${USER_HOME}"
# 
# pacman -S --noconfirm --needed \
#     partitionmanager

####### Network #######
# # if networkmanager is not set in archinstall
# run manually as a user
# ```
# pacman -S --noconfirm --needed \
#     networkmanager nm-connection-editor
# systemctl start NetworkManager.service
# systemctl enable NetworkManager.service
# ```

####### OBS #######
pacman -S --noconfirm --needed \
    obs-studio v4l2loopback-dkms linux-headers
# # and follow the instruction in the following page to be able to capture screen.
# https://wiki.archlinux.org/title/V4l2loopback

####### wine #######
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syyu --noconfirm --needed \
    wine winetricks kdialog

####### imagemagick #######
pacman -S --noconfirm --needed \
    imagemagick

####### baloo #######
# stop and disable
sudo -u "${USER}" balooctl suspend
sudo -u "${USER}" balooctl disable
sudo -u "${USER}" balooctl purge

####### zsh #######
pacman -S --noconfirm --needed \
    zsh zsh-completions
# # then, run following as a user manually to switch default shell to zsh.
# ```
# chsh -s $(which zsh)
# ```

# ohmyzsh
# need to install manually.
# ```
# ZSH="/home/takahisa/Documents/git/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# ```

sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.zshenv "${USER_HOME}"/.zshenv
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/zsh "${USER_HOME}"/.config/zsh
rm -f "${USER_HOME}"/.zshrc

# zsh theme
# ```
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
# ```
# # fzf for zsh
# ```
# git clone --depth=1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM}/plugins/fzf-zsh-plugin
# ```
# # zsh custom
# ```
# ln -sf "${DOTFILES_REPO}"/misc/omz_custom/* 
#     "${USER_HOME}"/Documents/git/oh-my-zsh/custom/
# ```
