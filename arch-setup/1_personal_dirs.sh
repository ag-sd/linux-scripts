#!/bin/bash

# TODO: Confirm before doing this
                                                                          
###########################
#####   HOUSEKEEPING  #####
###########################
su
    cd /mnt
    mkdir downloads documents nas
    mkdir nas/share nas/.sys
    chmod +rwx -R *
exit

rm -rf ~/Downloads
ln -s /mnt/downloads/Downloads ~/Downloads

rm -rf ~/Documents
ln -s /mnt/documents/ ~/Documents

rm -rf ~/Music
ln -s /mnt/nas/share/Sheldon/Music ~/Music

rm -rf ~/Pictures
ln -s /mnt/nas/share/Photos ~/Pictures

rm -rf ~/Public ~/Templates ~/Videos