# MIT License
#
# Copyright (c) 2020 Brighton Sikarskie
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#! /bin/bash

hdmi() {
	source $HOME/.screenlayout/hdmi.sh
	pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-stereo-extra1+input:analog-stereo
	xwallpaper --zoom $HOME/Pictures/Wallpapers/arch.png

	while [ "$monitor" = "HDMI" ];
	do	
		check
	done
}

laptop() {
	source $HOME/.screenlayout/main.sh
	pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo
	xwallpaper --zoom $HOME/Pictures/Wallpapers/arch.png

	while [ "$monitor" = "laptop" ];
	do	
		check
	done
}

check() {
	mode1="$(cat /sys/class/drm/card0-HDMI-A-1/status)"
	mode2="$(cat /sys/class/drm/card1-HDMI-A-1/status)"
	if [ "$mode2" = "disconnected" ];
	then
		monitor="laptop"
		sleep 10
		laptop
	elif [ "$mode1" = "disconnected" ];
	then
		monitor="laptop"
		sleep 10
		laptop

	elif [ "$mode1" = "connected" ];
	then
		monitor="HDMI"
		sleep 10
		hdmi
	elif [ "$mode2" = "connected" ];
	then
		monitor="HDMI"
		sleep 10
		hdmi
	fi
}
	check
