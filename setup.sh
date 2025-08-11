#!/bin/bash

PACKAGES=(
	zsh
	neovim
	hyprland
	hypridle
	hyprlock
	hyprpaper
	hyprshot
	waybar
	wofi
	pipewire
	pavucontrol
	brightnessctl
	zoxide
	ani-cli
	vlc
	vlc-plugins-all
	man
	google-chrome
	vencord
	visual-studio-code-bin
	stow
	nautilus
	ttf-jetbrains-mono-nerd
	noto-fonts
	noto-fonts-cjk
	noto-fonts-emoji
	noto-fonts-extra
	blueman
	fastfetch
	imagemagick
	)
is_installed(){
	yay -Qi "$1" &> /dev/null
}

install_package_if_missing(){
	if ! is_installed "$1"; then
		echo "installing $1..."
		yay -S --noconfirm --needed "$1"
	else
		echo "$1 is already installed."	
	fi

}

for pkg in "${PACKAGES[@]}"; do
	install_package_if_missing "$pkg"
done

echo -e "\n============================"
echo "====Folders to be stowed===="
echo -e "============================\n"

folders=($(ls -d */ | sed 's|/||'))

printf '%s\n' "${folders[@]}"

read -p "Do you want to stow these folders? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

for dir in "${folders[@]}"; do
	stow "$dir"
done

echo "Setup finished."
