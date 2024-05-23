#!/bin/bash

# Copy following files to the specified directories.
# - ~/Documents/secrets/
# Run this with sudo.
# ```
# sudo ./setup_arch_1.sh
# ```
# Then, run following manually as a user.
# ```
# gh auth login -p ssh -h github.com -w
# ```
# This will open firefox.
# Login to github.com


set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
REPOS_DIR="${USER_HOME}"/Documents/git
DOTFILES_REPO="${REPOS_DIR}"/dotfiles

cd "${USER_HOME}"

####### required apps for gh cli login #######
pacman -Syyu --noconfirm --needed firefox openssh git github-cli

####### Set ssh secrets #######
sudo -u "${USER}" cp "${USER_HOME}"/Documents/secrets/.ssh/id_ed25519 "${USER_HOME}"/.ssh/id_ed25519
sudo -u "${USER}" cp "${USER_HOME}"/Documents/secrets/.ssh/id_ed25519.pub "${USER_HOME}"/.ssh/id_ed25519.pub
