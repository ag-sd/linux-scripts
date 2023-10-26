#!/bin/bash

# Install custom scripts
../scripts/install_custom_scripts.sh
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

# Install apps
# Review the list in install_sw_list.txt and comment (#) out software thats not needed
sudo pacman -S --needed $(cat 2_install_sw_list.txt | grep -v '#')

# List packages
pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h

# Remove unused
pacman -Qtdq | pacman -Rns -