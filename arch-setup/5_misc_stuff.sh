#!/bin/bash

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
#####    SETUP KYBD   #####
###########################
# Razer Keyboard support
pacman -Sy --needed polychromatic python-openrazer openrazer-meta openrazer-daemon openrazer-driver-dkms
sudo gpasswd -a $USER plugdev
sudo modprobe razerkbd
openrazer-daemon -Fv

https://wiki.archlinux.org/title/General_recommendations
https://wiki.archlinux.org/title/Activating_numlock_on_bootup
https://wiki.archlinux.org/title/Plymouth