#!/bin/bash

#TODO
# vscode
#Make install rerunnable



###########################
#####   HOUSEKEEPING  #####
###########################
cd /mnt
sudo mkdir Downloads Documents nas
sudo mkdir nas/share nas/sys
sudo chmod +rwx -R *

rm -rf ~/Downloads
ln -s <MOUNT LOCATION>/Downloads/Downloads ~/Downloads

rm -rf ~/Documents
ln -s <MOUNT LOCATION>/Documents/ ~/Documents

rm -rf ~/Music
ln -s <MOUNT LOCATION>/Documents/ ~/Music

rm -rf ~/Pictures
ln -s <MOUNT LOCATION>/Documents/Pictures ~/Pictures

rm -rf ~/Videos
ln -s <MOUNT LOCATION>/Documents/Videos ~/Videos

rm -rf ~/Public ~/Templates


###########################
#####   CDN MIRRORS   #####
###########################
sudo pacman-mirrors --fasttrack

###########################
#####    SETUP TRIM   #####
###########################
sudo systemctl enable fstrim.timer

###########################
###   Git and Intellij  ###
###########################
git config --global user.name "SD"
git config --global user.email <email id>
git config --list
pacman install -S rclone libreoffice-fresh ristretto avidemux-qt calibre chromium 
pacman install -S sqlitebrowser gnome-disk-utility filezilla handbrake keepassxc kid3
pacman install -S kruler nomacs transmission-qt xed youtube-dl gallery-dl-bin dconf-editor
# Razer Keyboard support
pacman install -S polychromatic python-openrazer openrazer-meta openrazer-daemon openrazer-driver-dkms
# Optional applications
pacman install -S jetbrains-toolbox maui-pix amazon-workspaces-bin inkscape gimp kdeconnect
sudo gpasswd -a $USER plugdev

###########################
###  If Desktop is XFCE ###
###  Set default file   ###
###  manager as NEMO    ###
###########################
https://unix.stackexchange.com/questions/543468/make-nemo-handle-the-desktop-in-mint-xfce
# In dconf-editor   >>  org.nemo.desktop ignored-desktop-handlers ['xfdesktop']
# In dconf-editor   >>  org.cinnamon.desktop.default-applications.terminal exec 'xfce4-terminal'
# In xfdesktop-settings ('Desktop') go to Icons -> Appearance -> Icon type and set it to none
# Check if nemo-desktop is installed. If not, install nemo-desktop
# In 'Session and Startup' (xfce4-session-settings), 'Application autostart', add nemo-desktop
#
# Integrate with Thunar bulk rename: in Nemo, Edit > Preferences > Behavior > Bulk rename, enter thunar --bulk-rename



###########################
###     REBOOT  NOW     ###
###########################

sudo modprobe razerkbd
openrazer-daemon -Fv


