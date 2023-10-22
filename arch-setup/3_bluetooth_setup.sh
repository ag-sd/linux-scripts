#!/bin/bash

sudo pacman -S bluez blueman bluez-utils
sudo modprobe btusb
sudo systemctl enable bluetooth && sudo systemctl start bluetooth