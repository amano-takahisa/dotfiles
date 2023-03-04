#!/bin/bash

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
DOTFILES_REPO="${USER_HOME}"/Documents/git/dotfiles

cd "${USER_HOME}"

####### dotfiles #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/

####### bash #######
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.bash_aliases "${USER_HOME}"/.bash_aliases
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.bashrc "${USER_HOME}"/.bashrc
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.profile "${USER_HOME}"/.profile

####### zsh #######
pacman -S --noconfirm --needed \
    zsh zsh-completions

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

####### neovim #######
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.config/nvim "${USER_HOME}"/.config/nvim

####### tmux #######
pacman -S --noconfirm --needed \
    tmux
    sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.tmux.conf "${USER_HOME}"/.tmux.conf

####### XDG #######
pacman -S --noconfirm --needed \
    xdg-user-dirs
    sudo -u "${USER}" xdg-user-dirs-update

    ln -s "${DOTFILES_REPO}"/misc/xdgenv.sh /etc/profile.d/xdgenv.sh

####### fzf #######
pacman -S --noconfirm --needed \
    fzf
    sudo -u "${USER}" echo 'source /usr/share/fzf/completion.bash' >> /home/"${USER}"/.bashrc
    sudo -u "${USER}" echo 'source /usr/share/fzf/completion.zsh' >> /home/"${USER}"/.zshrc
    sudo -u "${USER}" echo 'source /usr/share/fzf/key-bindings.bash' >> /home/"${USER}"/.bashrc
    sudo -u "${USER}" echo 'source /usr/share/fzf/key-bindings.zsh' >> /home/"${USER}"/.zshrc

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


pacman -S --noconfirm --needed \
    wget

####### Localization #######
pacman -S --noconfirm --needed \
    otf-ipafont otf-ipaexfont  ttf-hack-nerd \
    ttf-mplus-nerd ttf-noto-nerd

sudo -u "${USER}" paru -S --noconfirm --needed \
    fcitx5-mozc-ut

####### Python #######
pacman -S --noconfirm --needed \
    python-pip

pacman -S --noconfirm --needed \
    pyright

sudo -u "${USER}" pip install pylama


sudo -u "${USER}" paru -S --noconfirm --needed \
    miniconda3
    ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh

####### GIS/RS #######
pacman -S --noconfirm --needed \
    qgis python-yaml python-gdal python-psycopg2
    sudo -u "${USER}" pip install Jinja2 Pygments owslib


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
    sudo -u "${USER}" echo 'source /usr/share/nvm/init-nvm.sh' >> /home/"${USER}"/.bashrc
    sudo -u "${USER}" echo 'source /usr/share/nvm/init-nvm.sh' >> /home/"${USER}"/.zshrc
    pacman -S --noconfirm --needed \
        npm

####### tools #######
pacman -S --noconfirm --needed \
    jq

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

####### sounds #######
pacman -S --noconfirm --needed \
    ksysguard

####### sounds #######
pacman -S --noconfirm --needed \
    ksysguard
