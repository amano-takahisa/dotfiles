# Setup Arch Linux on WSL2 with Nix

## Install Arch Linux

Download the latest Arch [Linux.wsl](https://gitlab.archlinux.org/archlinux/archlinux-wsl/-/releases/permalink/latest) image and double-click on it to start the installation. 

Start Arch Linux from Windows start menu.

Then, run the following command.

Set host name.

```bash
echo '[network]' >> /etc/wsl.conf
echo 'hostname = arch' >> /etc/wsl.conf
echo 'generateHosts = false' >> /etc/wsl.conf
```

Add user

```bash
useradd -m takahisa
usermod -a -G wheel takahisa
echo '[user]' >> /etc/wsl.conf
echo 'default=takahisa' >> /etc/wsl.conf
```

Set root password.

```bash
passwd  # for root.
passwd takahisa  # takahisa's password
```

Add sudo, vi

```bash
pacman -Syyu sudo vi
```

```sudo
visudo
```

Then, uncomment the following line

```
%wheel      ALL=(ALL:ALL) ALL
```

Install curl

```bash
pacman -Syyu curl
```

Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate
```

Initialize home-manager

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
nix run home-manager/master -- init
```


Copy following config files with Windows file manager.

```
~/.ssh
~/Documents/git/dotfiles
```

Search packages from repositories

```bash
nix search nixpkgs firefox
```

Then, update home.nix, and run

```bash
home-manager switch
```

## Configs outside of Nix

Run following to be able to use clipboard.

```fish
ln -sf /mnt/wslg/.X11-unix /tmp/.X11-unix; and ln -sf /mnt/wslg/runtime-dir/wayland-0* /run/user/(id -u)
```

Set fish as default

```bash
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
```

Neovim python environment

```fish
mkdir -p ~/Documents/venvs/neovim
cd ~/Documents/venvs/neovim
pixi init
pixi add pynvim
pixi add neovim
```

## Packages which are not installed with nix

dorker is not possible to be installed with nix, so install it with pacman.

```fish
sudo pacman -S docker
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

fuse3 is not possible to be installed with nix, so install it with pacman.

```fish
sudo pacman -S fuse3
```


------------------------------------
sudo -u "${USER}" xdg-user-dirs-update
ln -sf "${DOTFILES_REPO}"/misc/xdgenv.sh /etc/profile.d/xdgenv.sh



