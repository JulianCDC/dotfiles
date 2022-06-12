#!/bin/sh

# exit if any command fails
set -e

if [ "$EUID" -eq 0 ]; then
    echo "This script must not be run as root"
    exit
fi

exec_directory=`pwd`
tmp_directory=/tmp/install
script_directory="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
files_directory="$script_directory/files"


mkdir -p $tmp_directory

cleanup() {
    echo "Performing cleanup"

    rm -rf $tmp_directory
    cd $exec_directory
}

pacman_install() {
    sudo pacman -S --noconfirm --needed $@
}

yay_install() {
    yay -S --answerclean All --answerdiff None --answeredit None --noupgrademenu --removemake --noprovides --noconfirm --needed $@
}

trap cleanup EXIT

format_line() {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo "$1"
    echo "--------------------------------------------------------------------------------"
    echo ""
}

format_line "Performing full system update before installation"
sudo pacman --noconfirm -Syu

format_line "Installing dependencies for yay"
pacman_install git base-devel go

format_line "Installing yay"
cd $tmp_directory
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

format_line "Creating common directories in user's home directory"
pacman_install xdg-user-dirs
xdg-user-dirs-update

format_line "Cloning dotfiles in user's home directory"
git clone --recurse-submodules -j8 https://github.com/JulianCDC/dotfiles ~/.dotfiles

format_line "Installing dependencies for dotfiles"
pacman_install python

format_line "Installing dotfiles"
cd ~/.dotfiles
./install

format_line "Installing Xorg"
pacman_install xorg-server xorg-apps

amd() {
    format_line "Installing AMD drivers"
    pacman_install xf86-video-amdgpu

    sudo cp $files_directory/xorg/20-amdgpu.conf /etc/X11/xorg.conf.d
}

nvidia() {
    format_line "Installing Nvidia drivers"
    pacman_install nvidia

    sudo cp $files_directory/xorg/20-nvidia.conf /etc/X11/xorg.conf.d
}

radeon() {
    format_line "Installing Radeon drivers"
    pacman_install xf86-video-ati

    sudo cp $files_directory/xorg/20-radeon.conf /etc/X11/xorg.conf.d
}

format_line "Installing graphic drivers"
PS3='What graphic drivers should be installed: '
options=("AMD" "Nvidia" "Radeon" "None")
select opt in "${options[@]}"
do
    case $opt in
        "AMD")
            amd
            break
            ;;
        "Nvidia")
            nvidia
            break
            ;;
        "Radeon")
            radeon
            break
            ;;
        "None")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

format_line "Installing i3"
pacman_install i3-gaps

format_line "Installing display manager"
pacman_install lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan
sudo sed -i 's/^# greeter-session.*/greeter-session = lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/^webkit_theme.*/webkit_theme = litarvan/g' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo systemctl enable lightdm.service

format_line "Installing desktop environment"
pacman_install picom polybar feh
yay_install i3lock-color

format_line "Installing fonts"
pacman_install noto-fonts noto-fonts-emoji
yay_install otf-material-icons-git ttf-koruri ttf-symbola
