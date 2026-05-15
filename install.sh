#!/bin/bash

show_progress() {
    echo -n "$1 "
    echo -n "["
    for i in {1..30}; do
        echo -n "#"
        sleep 0.02
    done
    echo "] Done!"
}

clear
echo "Starting My Hyprland Rice Installation"
echo "--------------------------------------"

# 1. Official Packages (Core, Rice, Intel Drivers & Flatpak)
echo "[1/5] Installing core applications and intel drivers..."
sudo pacman -S --needed \
    hyprland waybar kitty rofi dunst hyprlock swww hyprsunset \
    inter-font neofetch git base-devel flatpak \
    xf86-video-intel libva-intel-driver intel-media-driver vulkan-intel \
    lib32-vulkan-intel lib32-mesa \
    --noconfirm

show_progress "Core & Drivers"

# 2. AUR Packages (Yay & Pywal)
echo "[2/5] Checking for Yay and installing pywal..."
if ! command -v yay &> /dev/null; then
    echo "Yay not found. Installing yay-bin..."
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si --noconfirm
    cd .. && rm -rf yay-bin
fi

# Instalando o pywal via AUR do seu jeito
yay -S pywal --noconfirm
show_progress "Pywal AUR"

# 3. Directories
echo "[3/5] Preparing environment..."
mkdir -p ~/.config
mkdir -p ~/wallpapers
show_progress "Directories"

# 4. Deploying Dotfiles
echo "[4/5] Deploying custom configurations..."
cp -ruv .config/* ~/.config/
cp -ruv wallpapers/* ~/wallpapers/
show_progress "Dotfiles"

# 5. Permissions
echo "[5/5] Setting permissions..."
chmod +x ~/.config/hypr/*.sh
show_progress "Finalizing"

echo "--------------------------------------"
echo "Installation Finished! Running system update and rebooting..."

# Atualização final e reboot do sistema
sudo pacman -Syu --noconfirm
sudo reboot
