#!/bin/bash
set -euo pipefail

# install fonts
mkdir ~/.fonts
pushd ~/.fonts
wget -N https://github.com/powerline/fonts/raw/master/Meslo/Meslo%20LG%20M%20DZ%20Regular%20for%20Powerline.otf
fc-cache -vf ~/.fonts
popd

# terminal preferences
uid=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d '\''') && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ foreground-color 'rgb(131,148,150)' && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-system-font false && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-theme-colors false && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ use-theme-transparency false && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ font 'Meslo LG M DZ for Powerline 12' && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ scrollback-unlimited true && \
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uid/ background-color 'rgb(0,43,54)'

# desktop preferences
gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Software.desktop']"
gsettings set org.gnome.shell favorite-apps "['chromium-browser.desktop', 'org.gnome.Nautilus.desktop', 'gnome-terminal.desktop']"

# disable bluetooth
rfkill block bluetooth

# disable touchpad
gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
sudo modprobe -r psmouse && sudo modprobe psmouse

# caps to escape
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

# 12 hour clock
gsettings set org.gnome.desktop.interface clock-format 12h

# TODO: disable alert sound
# pactl play-sample audio-volume-change
gsettings set org.gnome.desktop.sound event-sounds false
