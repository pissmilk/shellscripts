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
