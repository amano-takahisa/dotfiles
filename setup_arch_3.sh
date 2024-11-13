#!/bin/bash

set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
REPOS_DIR="${USER_HOME}"/Documents/git
DOTFILES_REPO="${REPOS_DIR}"/dotfiles

cd "${USER_HOME}"

####### Install packages from AUR #######
sudo -u "${USER}" yay -S --noconfirm --sudoloop --needed \
    git-secrets \
    google-chrome \
    google-cloud-cli \
    google-earth-pro \
    grass \
    nvm \
    qdirstat \
    slack-desktop \
    teams \
    ttf-hackgen \
    udunits \
    visual-studio-code-bin

####### Config $PATH #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/bin/
export PATH="/home/takahisa/bin/:${PATH}"

####### Clone my repositories #######
sudo -u "${USER}" git clone "git@github.com:amano-takahisa/multigit.git" "${USER_HOME}"/Documents/git/multigit
sudo -u "${USER}" ln -sf "${REPOS_DIR}"/multigit/multigit.py "${USER_HOME}"/bin/mg
cd ${USER_HOME}/Documents/git
sudo -u "${USER}" mg clone -u amano-takahisa
cd "${USER_HOME}"

####### git #######
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/git "${USER_HOME}"/.config/git

####### additional external repositories #######
repositories=(
    'git@github.com:adafruit/Adafruit_CircuitPython_Bundle.git'
)
for repository in ${repositories[@]}
do
    sudo -u "${USER}" git clone --depth=1 "${repository}" "${USER_HOME}"/Documents/git/$(basename "${repository}" .git)
done


####### neovim #######
pacman -S --noconfirm --needed \
    neovim python-neovim xclip wl-clipboard deno luarocks lua51
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/nvim "${USER_HOME}"/.config/nvim

####### wezterm #######
pacman -S --noconfirm --needed \
    wezterm libsixel

sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/wezterm "${USER_HOME}"/.config/wezterm
#
####### XDG #######
pacman -S --noconfirm --needed \
    xdg-user-dirs
sudo -u "${USER}" xdg-user-dirs-update

ln -sf "${DOTFILES_REPO}"/misc/xdgenv.sh /etc/profile.d/xdgenv.sh

####### fzf #######
pacman -S --noconfirm --needed \
    fzf

# ####### nvidia #######
# FIXME: nvidia conflicts.
# pacman -S --noconfirm --needed \
#     nvidia cuda

####### eza #######
# alternative to ls
pacman -S --noconfirm --needed \
    eza

####### zsh-abbr #######
# expand abbreviations in zsh
sudo -u "${USER}" git clone git@github.com:olets/zsh-abbr.git ${USER_HOME}/Documents/git/zsh-abbr

sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/zsh-abbr "${USER_HOME}"/.config/zsh-abbr

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

####### lazygit #######
pacman -S --noconfirm --needed \
    lazygit
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/git "${USER_HOME}"/.config/lazygit

####### pandoc #######
pacman -S --noconfirm --needed \
    pandoc

####### ripgrep #######
pacman -S --noconfirm --needed \
    ripgrep

####### ripgrep-all #######
pacman -S --noconfirm --needed \
    ripgrep-all

####### Gwenview #######
pacman -S --noconfirm --needed \
    gwenview

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
    noto-fonts-emoji \
    otf-ipaexfont  \
    otf-ipafont \
    ttf-hack-nerd \
    ttf-mplus-nerd \
    ttf-noto-nerd \
    ttf-opensans

# IME
pacman -S --noconfirm --needed \
    fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-mozc
ln -sf "${DOTFILES_REPO}"/misc/fcitx.sh /etc/profile.d/fcitx.sh

####### Python #######
pacman -S --noconfirm --needed \
    python-pip rye python-uv python-hatch ruff

sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/hatch "${USER_HOME}"/.config/hatch

pacman -S --noconfirm --needed \
    tk

# # Thonny for raspberry pi pico
# sudo -u "${USER}" echo y | sudo -u "${USER}" yay -S --sudoloop --answerclean None --answerdiff None \
#     thonny esptool python-ptyprocess python-build
# # add to uucp group to communicate pico
# usermod -a -G uucp "${USER}"

####### mu #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.local/share/applications/
sudo -u "${USER}" \
    ln -sf "${DOTFILES_REPO}"/misc/mu.desktop "${USER_HOME}"/.local/share/applications/mu.desktop
mu_version=1.2.0
sudo -u "${USER}" mkdir -p "${USER_HOME}"/Documents/program/mu
curl -L https://github.com/mu-editor/mu/releases/download/v"${mu_version}"/MuEditor-Linux-"${mu_version}"-x86_64.tar \
    -o "${USER_HOME}"/Documents/program/mu/MuEditor-Linux-"${mu_version}"-x86_64.tar
sudo -u "${USER}" tar xf "${USER_HOME}"/Documents/program/mu/MuEditor-Linux-"${mu_version}"-x86_64.tar \
    -C "${USER_HOME}"/Documents/program/mu/
sudo -u "${USER}" \
    mv "${USER_HOME}"/Documents/program/mu/Mu_Editor-"${mu_version}"-x86_64.AppImage \
    "${USER_HOME}"/Documents/program/mu/Mu_Editor.AppImage

usermod -a -G uucp "${USER}"

####### Raspberry Pi Imager #######
pacman -S --noconfirm --needed \
    rpi-imager

####### jupyter #######
sudo -u "${USER}" mkdir -p "${USER_HOME}"/.jupyter/lab/
sudo -u "${USER}" \
    ln -sf "${DOTFILES_REPO}"/.jupyter/lab/user-settings "${USER_HOME}"/.jupyter/lab/user-settings
sudo -u "${USER}" \
    ln -sf "${DOTFILES_REPO}"/.jupyter/jupyter_lab_config.py "${USER_HOME}"/.jupyter/jupyter_lab_config.py

####### Network #######
# avahi is required to resolve .local domain, such as pi.local
pacman -S --noconfirm --needed \
    avahi nss-mdns

systemctl enable avahi-daemon.service
systemctl start avahi-daemon.service
# and change hosts line in /etc/nsswitch.conf
# hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns

# VPN
pacman -S --noconfirm --needed \
    tailscale

# sftp
pacman -S --noconfirm --needed \
    sshfs

####### R #######
# Use rstudio from container.
pacman -S --noconfirm --needed \
    r

sudo -u "${USER}" mkdir -p "${USER_HOME}"/.config/rstudio/
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/rstudio/config.json "${USER_HOME}"/.config/rstudio/config.json
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/rstudio/crash-handler.conf "${USER_HOME}"/.config/rstudio/crash-handler.conf
sudo -u "${USER}" ln -sf "${DOTFILES_REPO}"/.config/rstudio/rstudio-prefs.json "${USER_HOME}"/.config/rstudio/rstudio-prefs.json

####### Fortran #######
pacman -S --noconfirm --needed \
    gcc-fortran

# ####### Rust #######
# # Need to find a way to run this non-interactive
# sudo -u "${USER}" curl --proto '=https' --tlsv1.2 -sSf \
#     https://sh.rustup.rs | sh

pacman -S --noconfirm --needed \
    rust-analyzer

# for Tauri app
pacman -S --noconfirm --needed \
    webkit2gtk-4.1

####### GIS/RS #######
# QGIS
pacman -S --noconfirm --needed \
    qgis python-yaml python-gdal python-psycopg2 python-owslib python-pygments python-lxml python-jinja
# sudo -u "${USER}" pip install Jinja2 --break-sys
#
# QGIS Plugin development
pacman -S --noconfirm --needed \
    qt5-tools

# Orfeo Toolbox
# AUR orfeo-toolbox is not installable.
# Following official instruction to install.
# https://www.orfeo-toolbox.org/CookBook/First_Steps.html
# When use orfeo-toolbox, need to activate the otbenv.profile
# source ${HOME}/Documents/program/otb/otbenv.profile
sudo -u "${USER}" mkdir -p ${USER_HOME}/Documents/program/otb
sudo -u "${USER}" curl https://www.orfeo-toolbox.org/packages/archives/OTB/OTB-9.0.0-Linux.tar.gz \
    -o ${USER_HOME}/Documents/program/otb/OTB-9.0.0-Linux.tar.gz
sudo -u "${USER}" tar xf ${USER_HOME}/Documents/program/otb/OTB-9.0.0-Linux.tar.gz \
    --one-top-level=${USER_HOME}/Documents/program/otb
# Following additional pacakges are required to use orfeo-toolbox in python.
pacman -S --noconfirm --needed \
    cmake

# To use python bindigs, need to re-buid otb in the python virtual environment.
# https://www.orfeo-toolbox.org/CookBook-develop/Installation.html#recompiling-python-bindings
# ```bash
# source .venv/bin/activate
# cd ${HOME}/Documents/program/otb/
# source otbenv.profile
# sh recompile_bindings.sh
# ```
# then, orfeo-toolbox can be used in the python virtual environment.
# ```python
# from otbApplication import otb
# ```

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

####### Node #######
pacman -S --noconfirm --needed \
        npm

####### tools #######
pacman -S --noconfirm --needed \
    jq wget rsync less

# draw graph
pacman -S --noconfirm --needed \
    graphviz

# torrent
pacman -S --noconfirm --needed \
    qbittorrent

# disk management
pacman -S --noconfirm --needed \
    dosfstools

####### circuite #######
pacman -S --noconfirm --needed \
    kicad kicad-library kicad-library-3d

####### Bluetooth #######
pacman -S --noconfirm --needed \
    bluez  bluez-utils bluez-obex
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

####### Disk management #######
pacman -S --noconfirm --needed \
    partitionmanager

####### OBS #######
pacman -S --noconfirm --needed \
    obs-studio v4l2loopback-dkms linux-headers
# # and follow the instruction in the following page to be able to capture screen.
# https://wiki.archlinux.org/title/V4l2loopback

####### openshot #######
pacman -S --noconfirm --needed \
    openshot

####### GIMP #######
pacman -S --noconfirm --needed \
    gimp

####### inkscape #######
pacman -S --noconfirm --needed \
    inkscape

# ####### wine #######
# echo '[multilib]' >> /etc/pacman.conf
# echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
# pacman -Syyu --noconfirm --needed \
#     wine winetricks kdialog

####### Remmina #######
# remote desktop client written in GTK+
# pacman -S --noconfirm --needed \
#     remmina freerdp

####### imagemagick #######
pacman -S --noconfirm --needed \
    imagemagick

####### rclone #######
# Sync files to and from Google Drive, S3, Swift, Cloudfiles, Dropbox and Google Cloud Storage
# run following to set up after installation
# $ rclone config
# $ mkdir ~/gdrive
# $ rclone mount gdrive: ~/gdrive
pacman -S --noconfirm --needed \
    rclone

####### zsh #######
pacman -S --noconfirm --needed \
    zsh zsh-completions
