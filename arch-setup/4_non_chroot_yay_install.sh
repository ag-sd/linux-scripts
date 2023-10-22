#!/bin/bash

###########################
#####    SETUP TRIM   #####
###########################
sudo systemctl enable fstrim.timer

###########################
#####    SETUP YAY    #####
###########################
cd opt && pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

