#!/bin/sh
#
# FOR SWAPPING LINES
##grep -l "urxvt" ~/.config/sxhkd/sxhkdrc | xargs sed -i 's/urxvt/xfce4-terminal/g'


# Creating partitions:
#fdisk -l
#fdisk /dev/sda
#o (once)
#n
# boot +70G
# hone +200G
# swap
#w (save changes).

# Creating filesystems:
#mkfs.ext4 /dev/sda1
#mkfs.ext4 /dev/sda2

# Mounting:
#mount /dev/sda1 /mnt
#mkdir /mnt/home
#mount /dev/sda2 /mnt
#mkswap /dev/sda2
#swapon /dev/sda2

#Vars:
PCNAME="THISPC"
USERNAME="wake"

# Setting up Time zone:
timedatectl set-ntp true && \
timedatectl set-timezone Etc/GMT-3 && \
timedatectl status

pacstrap /mnt base linux linux-firmware vim
genfstab -U /mnt >> /mnt/etc/fstab && \
arch-chroot /mnt && \
ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime && \
hwclock --systohc && \
###vim /etc/locale.gen
locale-gen

# Write name of your pc here (Further reference MYHOSTNAME):
echo $PCNAME >> /etc/hostname

# Append to /etc/hosts:
cat <<EOF >> /etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.1.1    $PCNAME.localdomain $PCNAME
EOF

mkinitcpio -P
# Create root password:
passwd

# Add new user:
useradd -m $USERNAME
passwd $USERNAME
usermod -aG wheel,audio,video,optical,storage $USERNAME

# Editing sudoers file:
pacman -S sudo
#EDITOR=vim visudo
#uncomment %wheel ALL=(ALL:ALL) ALL



# Downloading packages:
pacman -S grub base-devel linux-headers networkmanager os-prober mtools dosfstools dialog wireless_tools wpa_supplicant git wget

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Finishing up:
systemctl enable NetworkManager

# Unmounting:
exit
umount -l /mnt/home
umount -l /mnt
echo "End of BIOS/MBR Archlinux install script."

#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si
