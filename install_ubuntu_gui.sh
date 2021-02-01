#!/bin/bash
set -euo pipefail

# install fonts
mkdir -p ~/.fonts
pushd ~/.fonts
wget -N https://github.com/powerline/fonts/raw/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf
fc-cache -vf ~/.fonts
popd

# terminal preferences
uid=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}') && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ foreground-color 'rgb(131,148,150)' && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-system-font false && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-theme-colors false && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ audible-bell false && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-theme-transparency false && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ font 'Meslo LG M for Powerline 12' && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ scrollback-unlimited true && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ background-color 'rgb(0,43,54)'

# desktop preferences
gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Software.desktop']"
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox.desktop', 'gnome-terminal.desktop']"

# disable bluetooth
rfkill block bluetooth

# disable touchpad
gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
sudo modprobe -r psmouse && sudo modprobe psmouse

# caps to escape
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

# 12 hour clock
gsettings set org.gnome.desktop.interface clock-format 12h

# disable alert sound
gsettings set org.gnome.desktop.sound event-sounds false
