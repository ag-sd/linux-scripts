#!/bin/bash

###########################
###     Custom Script   ### 
###     Integration     ###
###########################
cd /mnt/dev
git clone https://github.com/ag-sd/scripts.git
git clone https://github.com/ag-sd/py.git
# Add to .bashrc
echo "export PATH=$PATH:/mnt/dev/scripts/linux/custom/.sd-custom/scripts/bin" >> ~/.bashrc