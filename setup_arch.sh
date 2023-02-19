#!/bin/bash

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
DOTFILES_REPO="${USER_HOME}"/Documents/git/dotfiles

cd "${USER_HOME}"

pacman -Syyu --noconfirm --needed \
	git 
sudo -u "${USER}" mkdir -p "${DOTFILES_REPO}"
# TODO: set known_hosts to prevent TUI
sudo -u "${USER}" git clone git@github.com:amano-takahisa/dotfiles.git "${DOTFILES_REPO}"

sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.config/git "${USER_HOME}"/.config/git
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.config/nvim "${USER_HOME}"/.config/nvim

pacman -S --noconfirm --needed \
	tmux
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.tmux.conf "${USER_HOME}"/.tmux.conf

pacman -S --noconfirm --needed \
	base-devel
sudo -u "${USER}" git clone https://aur.archlinux.org/paru.git
cd paru
sudo -u "${USER}" makepkg -si --noconfirm
cd "${USER_HOME}"

pacman -S --noconfirm --needed \
	xdg-user-dirs
sudo -u "${USER}" xdg-user-dirs-update

ln -s "${DOTFILES_REPO}"/misc/xdgenv.sh /etc/profile.d/xdgenv.sh

pacman -S --noconfirm --needed \
	fzf

pacman -S --noconfirm --needed \
	zip unzip

sudo -u "${USER}" paru -S --noconfirm --needed \
	git-secrets

pacman -S --noconfirm --needed \
	docker docker-compose
usermod -aG docker "${USER}"
systemctl start docker
systemctl enable docker

pacman -S --noconfirm --needed \
	fd

pacman -S --noconfirm --needed \
	tree

pacman -S --noconfirm --needed \
	mandoc

pacman -S --noconfirm --needed \
	ripgrep

pacman -S --noconfirm --needed \
	pyright

sudo -u "${USER}" paru -S --noconfirm --needed \
	miniconda3
ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh

pacman -S --noconfirm --needed \
	wget

pacman -S --noconfirm --needed \
	otf-ipafont otf-ipaexfont  ttf-hack-nerd \
	ttf-mplus-nerd ttf-noto-nerd
