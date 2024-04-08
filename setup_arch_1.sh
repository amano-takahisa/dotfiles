#!/bin/bash

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
# Then, copy files from my local backups
# - ~/Documents/secrets/


set -euxo pipefail

USER='takahisa'
USER_HOME=/home/"${USER}"
REPOS_DIR="${USER_HOME}"/Documents/git
DOTFILES_REPO="${REPOS_DIR}"/dotfiles

cd "${USER_HOME}"

####### required apps for gh cli login #######

pacman -Syyu --noconfirm --needed firefox openssh git github-cli
