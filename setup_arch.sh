#!/bin/bash

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
DOTFILES_REPO="${USER_HOME}"/Documents/git/dotfiles

cd "${USER_HOME}"

####### dotfiles #######
pacman -Syyu --noconfirm --needed \
	git 
sudo -u "${USER}" mkdir -p "${DOTFILES_REPO}"
# TODO: set known_hosts to prevent TUI
sudo -u "${USER}" git clone git@github.com:amano-takahisa/dotfiles.git "${DOTFILES_REPO}"
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/


####### bash #######
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.bash_aliases "${USER_HOME}"/.bash_aliases
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.bashrc "${USER_HOME}"/.bashrc

####### zsh #######
pacman -S --noconfirm --needed \
	zsh zsh-completions

####### git #######
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.config/git "${USER_HOME}"/.config/git
sudo -u "${USER}" paru -S --noconfirm --needed \
	git-secrets

####### neovim #######
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.config/nvim "${USER_HOME}"/.config/nvim

####### tmux #######
pacman -S --noconfirm --needed \
	tmux
sudo -u "${USER}" ln -s "${DOTFILES_REPO}"/.tmux.conf "${USER_HOME}"/.tmux.conf

####### package manager #######
pacman -S --noconfirm --needed \
	base-devel
sudo -u "${USER}" git clone https://aur.archlinux.org/paru.git
cd paru
sudo -u "${USER}" makepkg -si --noconfirm
cd "${USER_HOME}"

####### XDG #######
pacman -S --noconfirm --needed \
	xdg-user-dirs
sudo -u "${USER}" xdg-user-dirs-update

ln -s "${DOTFILES_REPO}"/misc/xdgenv.sh /etc/profile.d/xdgenv.sh

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

####### Python #######
pacman -S --noconfirm --needed \
	python-pip

pacman -S --noconfirm --needed \
	pyright

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
Screen shot
pacman -S --noconfirm --needed \
	spectacle


####### Node #######
sudo -u "${USER}" paru -S --noconfirm --needed \
	nvm
# sudo -u "${USER}" echo 'source /usr/share/nvm/init-nvm.sh' >> /home/"${USER}"/.bashrc
# sudo -u "${USER}" echo 'source /usr/share/nvm/init-nvm.sh' >> /home/"${USER}"/.zshrc
pacman -S --noconfirm --needed \
	npm

