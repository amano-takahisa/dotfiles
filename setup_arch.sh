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
#       Graphic driver: All open-source
#       greeter: sddm
#   Audio: Pipewire
#   Network configuration: Use NetworkManager
#   Timezone: Where you are
#
# Then, install and setup git, firefox, etc.
#
# ```bash
# sudo pacman -Syyu --noconfirm --needed neovim python-neovim xclip wl-clipboard firefox openssh git github-cli
# gh auth login -p ssh -h github.com -w
# ```
# Then,
# ```
# mkdir -p ~/Documents/git \
#     && git clone "git@github.com:amano-takahisa/dotfiles.git" ~/Documents/git/dotfiles \
#     && ln -sf ~/Documents/git/dotfiles/.config/git ~/.config/git
# ```
# and run followings with sudo

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
REPOS_DIR="${USER_HOME}"/Documents/git
DOTFILES_REPO="${REPOS_DIR}"/dotfiles


cd "${USER_HOME}"

####### Environmental Variables ######
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.profile "${USER_HOME}"/

####### gpg key #######
sudo -u "${USER}" curl -sS https://github.com/web-flow.gpg | sudo -u "${USER}" gpg --import -

####### dotfiles #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/

####### bin #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/bin/

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

####### tmux #######
pacman -S --noconfirm --needed \
    tmux
# sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.tmux.conf "${USER_HOME}"/.tmux.conf

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

####### bat #######
pacman -S --noconfirm --needed \
    bat

####### gedit #######
pacman -S --noconfirm --needed \
    gedit

####### Localization #######
# locale
echo 'ja_JP.UTF-8 UTF-8' | tee --append /etc/locale.gen
locale-gen
# Fonts
pacman -S --noconfirm --needed \
    otf-ipafont otf-ipaexfont  ttf-hack-nerd \
    ttf-mplus-nerd ttf-noto-nerd

# IME
pacman -S --noconfirm --needed \
    fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-mozc
ln -sf "${DOTFILES_REPO}"/misc/fcitx.sh /etc/profile.d/fcitx.sh
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#       fcitx5-mozc-with-jp-dict
#     --repo mozc fcitx5-mozc-ut
# and also mozc-ut is needed.

####### Python #######
pacman -S --noconfirm --needed \
    python-pip

# pacman -S --noconfirm --needed \
#     pyright
#
# pacman -S --noconfirm --needed \
#     pyenv


sudo -u "${USER}" mkdir -p "${USER_HOME}"/Documents/venvs/neovim
# # not sure the following works
# cd "${USER_HOME}"/Documents/venvs/neovim
# sudo -u "${USER}" python -m venv venv
# sudo -u "${USER}" source venv/bin/activate
# sudo -u "${USER}" pip install pynvim
# cd "${USER_HOME}"

pacman -S --noconfirm --needed \
    tk

# conda environment
sudo -u "${USER}" mkdir -p "${USER_HOME}"/miniconda3
sudo -u "${USER}" wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "${USER_HOME}"/miniconda3/miniconda.sh
sudo -u "${USER}" bash "${USER_HOME}"/miniconda3/miniconda.sh -b -u -p "${USER_HOME}"/miniconda3
sudo -u "${USER}" rm -rf "${USER_HOME}"/miniconda3/miniconda.sh
sudo -u "${USER}" "${USER_HOME}"/miniconda3/bin/conda init zsh
# Thonny for raspberry pi pico
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#     thonny esptool python-ptyprocess python-build
# # add to uucp group to communicate pico
# usermod -a -G uucp "${USER}"

####### R #######
pacman -S --noconfirm --needed \
    r
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    rstudio-desktop-bin r-tinytex

# ####### Rust #######
# # Need to find a way to run this non-interactive
# sudo -u "${USER}" curl --proto '=https' --tlsv1.2 -sSf \
#     https://sh.rustup.rs | sh

####### GIS/RS #######
# QGIS
pacman -S --noconfirm --needed \
    qgis python-yaml python-gdal python-psycopg2
# sudo -u "${USER}" pip install Jinja2 Pygments owslib
# GRASS GIS
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    grass

####### Web browser #######
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    google-chrome

####### Slack #######
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    slack-desktop

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
####### tools #######
pacman -S --noconfirm --needed \
    jq wget rsync

# disk management
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    qdirstat

pacman -S --noconfirm --needed \
    dosfstools

####### aws cli #######
pacman -S --noconfirm --needed \
    aws-cli-v2
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    aws-session-manager-plugin

sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    mountpoint-s3-git


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

# ####### pre-commit #######
# sudo -u "${USER}" pip install pre-commit
#
# ####### backup #######
# pacman -S --noconfirm --needed \
#     snapper
#
####### memo #######
pacman -S --noconfirm --needed \
    zk
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/zk "${USER_HOME}"/.config/zk

####### Document viewer #######
pacman -S --noconfirm --needed \
    okular

####### Document OCR #######
pacman -S --noconfirm --needed \
    tesseract-data-eng tesseract-data-deu
sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    ocrmypdf

# ####### Document management #######
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#     zotero
#
####### Image viewer #######
pacman -S --noconfirm --needed \
    gwenview

####### media #######
pacman -S --noconfirm --needed \
    vlc

# ####### cloud services #######
# # rclone
# pacman -S --noconfirm --needed \
#     rclone fuse2
# # make dir for mount
# sudo -u "${USER}" mkdir "${USER_HOME}"/google_drive
# # to mount the drive
# # rclone mount gd:/ /home/takahisa/google_drive --daemon --vfs-cache-mode full
# # to unmount, run
# # fusermount -u /home/takahisa/google_drive
#
####### Devices #######
# Logicool mouse
pacman -S --noconfirm --needed \
    solaar

####### KDE #######
# show thumbnails in Dolphin
pacman -S --noconfirm --needed \
    kdegraphics-thumbnailers

# ####### speech #######
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#      speech-dispatcher festival espeak-ng
#
# sudo -u "${USER}" pip install TTS

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

pacman -S --noconfirm --needed \
    partitionmanager

####### Network #######
pacman -S --noconfirm --needed \
    lsof

sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
    realvnc-vnc-viewer

####### OBS #######
pacman -S --noconfirm --needed \
    obs-studio v4l2loopback-dkms linux-headers
# and follow step 2 of
# https://wiki.archlinux.org/title/V4l2loopback

# ####### system monitor #######
# pacman -S --noconfirm --needed \
#     netdata
# systemctl start netdata
# systemctl enable netdata
#
####### wine #######
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syyu --noconfirm --needed \
    wine

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

# ohmyzsh
sudo -u "${USER}" ZSH="${USER_HOME}/Documents/git/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.zshenv "${USER_HOME}"
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/zsh "${USER_HOME}"/.config/
rm -f "${USER_HOME}"/.zshrc

# zsh theme
sudo -u "${USER}" git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${USER_HOME}/Documents/git/oh-my-zsh/custom/themes/powerlevel10k

# zsh custom
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/misc/omz_custom/* \
    "${USER_HOME}"/Documents/git/oh-my-zsh/custom/
