# Install Arch
Basically, follow [the official guide](https://wiki.archlinux.org/title/Installation_guide).
and [aznote.jakou.com](https://aznote.jakou.com/archlinux/index.html).
ISO image: `archlinux-2022.09.03-x86_64.iso`


## Boot from install media



... pass ...

## Check the boot mode
Check if the system is UEFI or GRUB.
```console
ls /sys/firmware/efi/efivars
```

## Connect to the internet
```console
ip link
ping archlinux.org
```

## Update the system clock
```console
timedatectl set-ntp 1
```

## Partition the disks
Check current partition settings

```console
fdisk -l
```
or
```console
lsblk
```
You can ignore partitions named such as `loop0`, `sr0`, `rom`, or `airoot`.

Make partitions with followign command.

```console
fdisk /dev/sda
```
The command start interactive dialogs.
If device do not have any partition table, create empty table with `o`(BIOS/GRUB/DOS with MBR), or `g`(UEFI with GPT).
Press `n` and `enter` to create a new partition.
~First, create a 2GB partition for `swap`. Then, create a partition for `/` with all remaining space.~
Create single linux partition. `a` to make the partition to bootable.
Enter `p` to comfirm current settings, and `w` to execute partitioning.

## Format partitions
List available formats with
```console
ls /usr/bin/mkfs.*
```
If you want to format `/dev/sda1` partition with a label `arch`,
```console
mkfs.ext4 /dev/sda1 -L arch
```

Comfirm current statement with `lsblk --fs`.

## Mount the bootable bolume
```console
mount /dev/sda1 /mnt
```

## Install
### Select mirrors
```console
reflector --sort rate --country at --latest 10 --save /etc/pacman.d/mirrorlist
```
Change `at` to your ISO country code.

### Install essential packages
```console
pacstrap /mnt base base-devel linux linux-firmware neovim
```

### Configure the system
#### Set mount options
```console
genfstab -L /mnt >> /mnt/etc/fstab
```

#### Change root into the new system
```console
arch-chroot /mnt
```
After this, system under `/mnt` is used to run commands.
If you need additional packages, install them with
```console
pacman -S <package...>
```
To find installable package, run `pacman -Ss <name>`.

#### Set time-zone
Find your time zones under `/usr/share/zoneinfo`
```console
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
```

Generate  `/etc/adjtime`
```console
hwclock --systohc
```

#### Localization
Edit `/etc/locale.gen`. Activate `en_US.UTF-8 UTF-8` and necessary locales lines by removing `#`.

```console
nvim /etc/locale.gen
```

Then, run `locale-gen` to reflect `locale.gen`.
```console
locale-gen
```

Set default locale
```console
echo LANG=en_US.UTF-8 > /etc/locale.conf
````

#### Set host name
Name the PC.
```console
echo arch > /etc/hostname
```

#### Network settings
Get network interface names
```console
ip link
# or $networkctl
```
`enp*` is a name of wired network.
Install `dhcpcd` and setup wired network. Change `enp0s3` to your interface name.
```console
pacman -S dhcpcd
systemctl enable dhcpcd@enp0s3
```

Install `netctl` and setup wireless network.
```console
pacman -S netctl openresolv wpa_supplicant

cp /etc/netctl/exsamples/wireless-wpa /etc/netctl/wireless
```
Edit `/etc/netctl/wireless` accordingly.
```console
nvim /etc/netctl/wireless
# "Interface": wlp* which get with ip link command
# "ESSID": Router network name
# "Key": Enquriptuion key
```
```console
netctl enable wireless
```

#### Set root password
```console
passwd
```

#### Boot loader
In case GRUB (BIOS-MBR), install `grub`

```console
pacman -S grub
```

Then install grub to bootable disc. (NOT partition).

```console
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

Exit from chroot environment with `exit` and reboot with `reboot`

# Setup Arch
https://wiki.archlinux.org/title/General_recommendations
Login as `root` with password which you set in the above section.
## Create a user
```console
useradd -m -G wheel takahisa
passwd takahisa
```

## Enable sudo
Install sudo
```console
pacman -S sudo
```
Configure

```console
EDITOR=nvim visudo
```
Activate `# %wheel ALL=(ALL) ALL` line by removing `#`


## Setup GUI
### Display server
```console
pacman -S xorg-server
```
In case Arch is inside of VirtualBox, additionally,

```console
pacman -S virtualbox-guest-utils
```

### xfce
```console
pacman -S xfce4 xfce4-goodies lightdm  lightdm-gtk-greeter
```
and `Enter` to install all related packages if you are asked to choose extras.
Set enable to start lightdm display manager when boot.
```console
systemctl enable lightdm
```
Switch to user created the above with `su takahisa`, and from following section, run commands as that user. (Not as root.)


## Install packages
### ssh
#### Install
```console
sudo pacman -S openssh
```
#### Configure
```console
# generate ssh key
ssh-keygen -t ed25519 -C "amano.takahisa@gmail.com"
# start ssh-agent
eval "$(ssh-agent -s)"
# add ssh key to the agent
ssh-add ~/.ssh/id_ed25519
```

### Git
Requied to setup `ssh`.
#### Install
```console
sudo pacman -S git
```
#### Configure
Register ssh key to github
```console
cat ~/.ssh/id_ed25519.pub
# Then select and copy the contents of the id_ed25519.pub file
# displayed in the terminal to your clipboard
# and paste to GitHub ssh key setting https://github.com/settings/ssh/new
```

Clone my dotfiles.
```console
git clone git@github.com:amano-takahisa/dotfiles.git $HOME/dotfiles
```

Clone dotfiles and make symbolic link.
```console
mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/config ~/.config/git/config
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore
```
### git-secrets
Prevents you from committing secrets and credentials into git repositories
#### Install
```console
yay -S git-secrets
```

### XDG environment
#### Configure
Set `XDG_XXX_HOME` variables.
https://chiyosuke.blogspot.com/2019/04/blog-post_27.html
```bash
sudo ln -s ~/dotfiles/misc/xdgenv.sh /etc/profile.d/xdgenv.sh 
```

Install `xdg-user-dirs`.
```console
sudo pacman -S xdg-user-dirs
```
Then  run 
```console
xdg-user-dirs-update
```


### Zsh
#### Install
```console
sudo pacman -S zsh zsh-completions
```
#### Configure
Change default shell to zsh.
Comfirm current running shell
```console
echo $0
# or
# echo $SHELL
```

Check full path to the shell
```console
chsh -l
```
and set default. Change `/usr/bin/zsh` accordingly.
```console
chsh -s /usr/bin/zsh
```

```console
ln -s $HOME/dotfiles/.config/zsh $HOME/.config/zsh
```
Install oh-my-zsh.
```console
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Remove autogenerated `.zshrc`, and use dotfile's one.

```console
rm $HOME/.zshrc
ln -s $HOME/dotfiles/.zshenv $HOME
```

Plugins
```console
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

### alacritty
#### Install
```console
sudo pacman -S alacritty
```

#### Config
```console
ln -s $HOME/dotfiles/.config/alacritty $XDG_CONFIG_HOME/alacritty
```

### yay
https://github.com/Jguer/yay


#### Install
```console
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

#### Configure
```console
yay -Y --gendb
```

### NeoVim
#### Install
NeoVim has been installed while installation of Arch.

#### Config
```console
# ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim
# Locate configuration files in nvim_arch until it is mature enough.
ln -s $HOME/dotfiles/.config/nvim_arch $HOME/.config/nvim

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 $XDG_DATA_HOME/nvim/site/pack/packer/start/packer.nvim
```

In NeoVim command line,
```
:PackerInstall
```

### xclip
#### Install
```console
sudo pacman -S xclip
```
### ripgrep
#### Install
```console
sudo pacman -S ripgrep
```

### fd
#### Install
```console
sudo pacman -S fd
```
### tree

#### Install
```console
sudo pacman -S tree
```

### fzf
#### Install
```console
sudo pacman -S fzf
```


### zip/unzip
#### Install
```console
sudo pacman -S zip unzip
```

### man
#### Install
```console
sudo pacman -S mandoc
```
### tmux
#### Install
```console
sudo pacman -S tmux
```
#### Configure
```console
ln -s $HOME/dotfiles/.config/tmux $HOME/.config/tmux
```

### pyright
#### Install
```console
sudo pacman -S pyright
```

### Rust
https://wiki.archlinux.org/title/rust
#### Install
```console
sudo pacman -S rust
```

#### Configure
```console
```

### xremap
#### Install
```console
yay -S xremap-x11-bin
```
#### Configure
```console
# sudo modprobe uinput
mkdir $HOME/.config/xremap
ln -s $HOME/dotfiles/.config/xremap/config.yml $HOME/.config/xremap
echo uinput | sudo tee /etc/modules-load.d/uinput.conf
sudo usermod -a -G input takahisa
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-input.rules

# systemctl
# mkdir -p $HOME/.config/systemd/user/
# ln -s $HOME/dotfiles/.config/systemd/user/xremap.service $HOME/.config/systemd/user

# auto start
mkdir -p $HOME/.config/autostart/
ln -s $HOME/dotfiles/.config/autostart/xremap.desktop $HOME/.config/autostart
```

### Docker
#### Install
```console
sudo pacman -S docker
```
#### Configure
```console
sudo usermod -aG docker ${USER}
newgrp docker
sudo systemctl enable docker
```

To test,
```console
docker run -it --rm archlinux bash -c "echo hello world"
```

### Docker-compose
#### Install
```console
sudo pacman -S docker-compose
```

### Fonts

#### Install
Cica font
```console
# yay -S nerd-fonts-complete
# yay -S ttf-cica
git clone https://github.com/miiton/Cica.git
cd Cica
docker-compose build ; docker-compose run --rm cica
# font is saved in /dist/
mkdir -p $XDG_DATA_HOME/fonts/
mv dist/*.ttf $XDG_DATA_HOME/fonts/
```
Hackgen with Nerd
```console
curl -o HackGen_NF.zip -L https://github.com/yuru7/HackGen/releases/download/v2.7.1/HackGen_NF_v2.7.1.zip
unzip HackGen_NF.zip
mv HackGen_NF_v2.7.1/*.ttf $XDG_DATA_HOME/fonts/
rm HackGen_NF.zip
rmdir HackGen_NF_v2.7.1
```

### Firefox
#### install
```console
sudo pacman -s firefox
```
#### configure
log in to firefox, and sync.


### miniconda
#### install
```console
yay -S miniconda3
```

#### configure
```console
sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
```
### IME
#### install
```console
yay -S mozc-ut
```

#### configure
```
```

### QGIS
#### install
```console
sudo pacman -S qgis
```


### LunarVim
#### install
```console
# yay -S lunarvim-git
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```
Install dependencies from dialogs.

#### configure
```console
```

### <PACKAGE>
#### install
```console
```
#### configure
```console
```

### <PACKAGE>
#### install
```console
```
#### configure
```console
```

### <PACKAGE>
#### install
```console
```
#### configure
```console
```

### <PACKAGE>
#### install
```console
```
#### configure
```console
```

