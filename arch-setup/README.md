```
------------------------------------------------------------------------
 █████╗ ██████╗  ██████╗██╗  ██╗███████╗███████╗████████╗██╗   ██╗██████╗ 
██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
███████║██████╔╝██║     ███████║███████╗█████╗     ██║   ██║   ██║██████╔╝
██╔══██║██╔══██╗██║     ██╔══██║╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║  ██║██║  ██║╚██████╗██║  ██║███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
-------------------------------------------------------------------------
```

# Pre Installation Steps

Start here: https://wiki.archlinux.org/title/installation_guide and follow the steps to...
1. Acquire an installation image
2. Prepare an installation medium
3. Boot the live environment
4. Connect to the internet (use iwctl https://wiki.archlinux.org/title/Iwd#iwctl)
    ```sh
    station device scan
    station device get-networks
    station device connect SSID-*
    ```
5. https://wiki.archlinux.org/title/archinstall
    #### Note: Archinstall will *WIPE* the drive its being installed to. Partitions are preserved, data is lost

# Post Installation Process
## Change User Directories
Using `gnome-disk-utility` setup all your drives to automount and mount to the correct locations in the `/mnt` directory. Additionally, setup your NAS and its mount directories if needed. NAS scripts are found in the scripts repository

This is how we want the setup to look.
```
Downloads   -> /mnt/downloads/Downloads
Documents   -> /mnt/documents
Pictures    -> /mnt/documents/Pictures
Music (NAS) -> /mnt/nas/...
```

And this is how to set it up once the mounts points are configured in `gnome-disk-utility`
```sh
su
    cd /mnt
    mkdir downloads documents nas
    mkdir nas/share nas/.sys # NAS script will mount here
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
```



## Install Software
First review the software [listed here](2_install_sw_list.txt) and comment out (with a `#`) anything that shouldnt be installed. Then run 
```sh
install_sw.sh
```

This script will 
- Update the Pacman Mirror List
- Setup an auto clean of the package cache
- Install microcode for your cpu
- Install graphics drivers if needed
- Install all the apps listed in [2_install_sw_list.txt](2_install_sw_list.txt)
- And finally do a cleanup

## Bluetooth Setup
KDE has a bluetooth manager, so an additional manager isnt needed. If for some strange reason, you need another bluetooth manager, run the following
```sh
sudo pacman -S bluez blueman bluez-utils
sudo modprobe btusb
sudo systemctl enable bluetooth && sudo systemctl start bluetooth
```

## Install Yay
yay is an AUR helper and pacman wrapper that streamlines the command line software installation experience

```sh
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```


## Setup Trim
Over time, some users experience slow downs in certain flash storage devices. This might be alleviated by issuing a periodic fstrim command to the mounted file system. Devices and file systems that don't support fstrim are unaffected.

By enabling the existing fstrim.timer systemd unit file by default, will cause weekly execution of the fstrim.service. This service acts only on mounted filesystems listed in fstab. On supported hardware (e.g. most SD Card, SSD, and NVMe drives), LVM thin provisioned storage, and file systems (e.g. ext4, XFS, Btrfs, f2fs, VFAT), fstrim will inform underlying physical storage device's firmware about unused blocks. This hinting can make wear leveling and block erasure more efficient. [1](https://fedoraproject.org/wiki/Changes/EnableFSTrimTimer) [2](https://wiki.archlinux.org/title/Solid_state_drive)

Add fstrim to systemctl to have it run periodically

```sh
sudo systemctl enable fstrim.timer
```

## Development Environment
### Git
```sh
pacman -Sy --needed less
git config --global user.name "ag-sd"
git config --global user.email ag-sd@gmail.com
git config --list
```
### VSCode
Install VSCode extensions from the command line 
```sh
code --install-extension jdinhlife.gruvbox
```

### IntelliJ

```sh
yay intellij-idea-ce

# Add Intellij Plugins
# Python
/opt/intellij-idea-ce/bin/idea.sh installPlugins Pythonid
# Git toolbox
/opt/intellij-idea-ce/bin/idea.sh installPlugins zielu.gittoolbox
# Solarized theme
/opt/intellij-idea-ce/bin/idea.sh com.vincentp.gruvbox-theme
# Restful Fast Request - API Buddy
/opt/intellij-idea-ce/bin/idea.sh io.github.kings1990.FastRequest
# Indent Rainbow
/opt/intellij-idea-ce/bin/idea.sh indent-rainbow.indent-rainbow
# Grazie Lite Spellchecker
/opt/intellij-idea-ce/bin/idea.sh tanvd.grazi
# Rainbow Brackets
/opt/intellij-idea-ce/bin/idea.sh izhangzhihao.rainbow.brackets
# Key Promoter X
/opt/intellij-idea-ce/bin/idea.sh "Key Promoter X"
# WakaTime - Activity Telemetry
/opt/intellij-idea-ce/bin/idea.sh com.wakatime.intellij.plugin
# String Manipulation
/opt/intellij-idea-ce/bin/idea.sh "String Manipulation"
# Extra Icons
#/opt/intellij-idea-ce/bin/idea.sh lermitage.intellij.extra.icons
# Mario Progress Bar
/opt/intellij-idea-ce/bin/idea.sh manjaro.mpb

```

## Convenience Setup
### Easy Command Line Access
In startup applications add `konsole` or `xfce-terminal`. This will ensure that the terminal launches on each system startup. To ensure that the terminal is always at hand, install [`jumpapp`](https://github.com/mkropat/jumpapp) and add a system shortcut to bring the terminal to the front.

```sh
yay jumpapp

Add Shortcut > jumpapp -R -f konsole >> win+R
```

## iPhone (iOS) Support
Ensure the following packages are intstalled
1. `libimobiledevice`. CHeck if its running with the command `systemctl status usbmuxd.service`
2. To access the media filesystem, install `gvfs-gphoto2`. To access the app document filesystem, install `gvfs-afc`




## Miscellaneous Notes
### Using Nemo as the file manager in XFCE

If you choose to replace Thunar with Nemo, the desktop will not work out of the box. Additonally, Nemo will not call the xfce-terminal by default. Thus, some configuration is needed.

```sh
# Install nemo and dconf-editor
sudo pacman -Sy --needed nemo dconf-editor nemo-desktop
```
1. In dconf-editor   >>  `org.nemo.desktop ignored-desktop-handlers` add ['xfdesktop']
2. In dconf-editor   >>  `org.cinnamon.desktop.default-applications.terminal` set exec to 'xfce4-terminal'
3. In xfdesktop-settings ('Desktop') go to Icons > Appearance > Icon type and set it to `none`
4. In 'Session and Startup' (xfce4-session-settings), *Application autostart*, add `nemo-desktop`

To integrate with Thunar bulk rename: in Nemo, Edit > Preferences > Behavior > Bulk rename, enter `thunar --bulk-rename`

### Configuring Nemo Appearance
1. Open a terminal window Ctrl+Alt+t
2. `cd ~/.config/gtk-3.0/`
3. `xed gtk.css` (Create one if it doesn't exit)
4. Add the following code:
    ```css
    /*.nemo-places-sidebar .view { */ 
    .nemo-window .sidebar .view {
    background-color: @theme_fg_color;
    color: @theme_bg_color;
    }
    ```
5. Save file and close; Quit/close all nemo windows and Startup a nemo file explorer nemo


### Razer keyboard support
```sh
sudo pacman -Sy --needed polychromatic python-openrazer openrazer-meta openrazer-daemon openrazer-driver-dkms
sudo gpasswd -a $USER plugdev
sudo modprobe razerkbd
openrazer-daemon -Fv
```


## General Reading
- https://wiki.archlinux.org/title/General_recommendations
- https://wiki.archlinux.org/title/Activating_numlock_on_bootup
- https://wiki.archlinux.org/title/Plymouth
