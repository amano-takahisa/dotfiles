# Install Arch


## Boot from install media
... pass ...


## Archinstall

Run following to start archinstall, and follow install steps.
```bash
archinstall
```


## Install packages
```bash
sudo pacman -Syyu --noconfirm --needed \
    neovim xclip python-neovim wl-clipboard xclip firefox \
    openssh \
    && ssh-keygen -t ed25519 -C "amano.takahisa@gmail.com" \
    && eval "$(ssh-agent -s)" \
    && ssh-add ~/.ssh/id_ed25519 \
    && cat ~/.ssh/id_ed25519.pub | wl-copy
```
Paste ssh strings copied to a clip board to https://github.com/settings/ssh/new.

Then run `setup_arch.sh` as root.
```
sudo ./setup_arch.sh
```
