#!/bin/bash

# Install custom scripts
install_custom_scripts.sh
source /home/sheldon/.bashrc

# Update Pacman Mirrorlist
sudo pacman -Sy --needed pacman-contrib 
sd-update-mirrors.sh

# Automatic cleaning of the package cache
sudo pacman -Sy --needed pacman-contrib
sudo systemctl enable paccache.timer

# Microcode updates
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${proc_type}; then
    echo "Installing Intel microcode"
    sudo pacman -Sy --noconfirm --needed intel-ucode
    proc_ucode=intel-ucode.img
elif grep -E "AuthenticAMD" <<< ${proc_type}; then
    echo "Installing AMD microcode"
    sudo pacman -Sy --noconfirm --needed amd-ucode
    proc_ucode=amd-ucode.img
fi

# Graphics Drivers find and install
gpu_type=$(lspci)
if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
    sudo pacman -S --noconfirm --needed nvidia
	nvidia-xconfig
elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
    sudo pacman -S --noconfirm --needed xf86-video-amdgpu
elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
    sudo pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
    sudo pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
fi

# Mostly needed apps
sudo pacman -Sy --needed rclone libreoffice-fresh ristretto calibre ffmpegthumbs konsave
sudo pacman -Sy --needed youtube-dl gallery-dl-bin gnome-disk-utility keepassxc transmission-qt code-oss
sudo pacman -Sy --needed handbrake handbrake-cli brave-bin
sudo pacman -Sy --needed nomacs ristretto

# Somewhat needed apps
sudo pacman -Sy --needed inkscape gimp
sudo pacman -Sy --needed sqlitebrowser filezilla  avidemux-qt
sudo pacman -Sy --needed kruler dconf-editor

# Optional applications
#sudo pacman -Sy --needed jetbrains-toolbox maui-pix amazon-workspaces-bin kdeconnect

# List packages
pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h

# Remove unused
pacman -Qtdq | pacman -Rns -