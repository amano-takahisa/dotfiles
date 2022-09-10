# Install Arch
Basically, follow [the official guide](https://wiki.archlinux.org/title/Installation_guide).
and [aznote.jakou.com](https://aznote.jakou.com/archlinux/index.html).
ISO image: archlinux-2022.09.03-x86_64.iso


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
timedatectl set-ntp true
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
pacman -S netctl openresolv dhcpcd wpa_supplicant

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
```echo
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


Switch to user created the above with `su takahisa`, and from following section, run commands as that user. (Not as root.)

## Install packages



















