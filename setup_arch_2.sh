#!/bin/bash
# Install yay

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
REPOS_DIR="${USER_HOME}"/Documents/git
DOTFILES_REPO="${REPOS_DIR}"/dotfiles

cd "${USER_HOME}"

####### gpg key #######
sudo -u "${USER}" curl -sS https://github.com/web-flow.gpg | sudo -u "${USER}" gpg --import -

####### ssh config #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/
sudo -u "${USER}" ln -sf "${USER_HOME}"/Documents/secrets/.ssh/config "${USER_HOME}"/.ssh/config
sudo -u "${USER}" \
    ssh-keyscan -t ssh-ed25519 github.com >> "${USER_HOME}"/.config/known_hosts

##### package manager #######
pacman -S --noconfirm --needed \
    base-devel
sudo -u "${USER}" git clone https://aur.archlinux.org/yay.git ${USER_HOME}/Documents/git/yay
cd ${REPOS_DIR}/yay
sudo -u "${USER}"  makepkg -si
# <----   HERE root password will be asked. ----> #
cd "${USER_HOME}"

# Development packages upgrade
sudo -u "${USER}" yay -Y --gendb
sudo -u "${USER}" yay -Syu --devel
# <----   HERE root password will be asked. ----> #
sudo -u "${USER}" yay -Y --devel --save
