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

trap cleanup EXIT

format_line() {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo "$1"
    echo "--------------------------------------------------------------------------------"
    echo ""
}

format_line "Installing dependencies for yay"
sudo pacman --noconfirm --needed -S git base-devel go

format_line "Installing yay"
cd $tmp_directory
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

format_line "Creating common directories in user's home directory"
sudo pacman --noconfirm --needed -S xdg-user-dirs
xdg-user-dirs-update

format_line "Cloning dotfiles in user's home directory"
git clone --recurse-submodules -j8 https://github.com/JulianCDC/dotfiles ~/.dotfiles

format_line "Installing dependencies for dotfiles"
sudo pacman --noconfirm --needed -S python

format_line "Installing dotfiles"
cd ~/.dotfiles
./install

format_line "Installing Xorg"
sudo pacman --noconfirm --needed -S xorg-server xorg-apps

amd() {
    format_line "Installing AMD drivers"
    sudo pacman --noconfirm --needed -S xf86-video-amdgpu

    sudo cp $files_directory/xorg/20-amdgpu.conf /etc/X11/xorg.conf.d
}

nvidia() {
    format_line "Installing Nvidia drivers"
    sudo pacman --noconfirm --needed -S nvidia

    sudo cp $files_directory/xorg/20-nvidia.conf /etc/X11/xorg.conf.d
}

radeon() {
    format_line "Installing Radeon drivers"
    sudo pacman --noconfirm --needed -S xf86-video-ati

    sudo cp $files_directory/xorg/20-radeon.conf /etc/X11/xorg.conf.d
}

format_line "Installing graphic drivers"
PS3='What graphic drivers should be installed: '
options=("AMD" "Nvidia" "Radeon" "Quit")
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
        "Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
    esac
done
