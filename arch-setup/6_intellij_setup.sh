#! /bin/bash

###########################
###   Git and Intellij  ###
###########################
pacman -Sy --needed less
git config --global user.name "Sheldon DSouza"
git config --global user.email sheldon.s.d@gmail.com
git config --list
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

