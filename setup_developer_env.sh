#!/bin/bash

# Exit on error
set -e

# Update system
sudo apt update && sudo apt upgrade -y

# Install essential tools
sudo apt install -y curl wget git build-essential

# Partition NVMe Drive
NVME_DEVICE="/dev/nvme0n1"

# Check if NVMe device exists
if [ ! -e "$NVME_DEVICE" ]; then
    echo "NVMe device $NVME_DEVICE not found!"
    exit 1
fi

# Wipe the existing partitions
sudo wipefs -a $NVME_DEVICE

# Create new partitions
echo "Creating partitions on $NVME_DEVICE"
(
echo g  # Create a new empty GPT partition table
echo n  # Add a new partition
echo 1  # Partition number 1
echo    # First sector (Accept default: 1)
echo +1G # Last sector
echo n  # Add a new partition
echo 2  # Partition number 2
echo    # First sector (Accept default: varies)
echo +4G # Last sector
echo n  # Add a new partition
echo 3  # Partition number 3
echo    # First sector (Accept default: varies)
echo +66G # Last sector
echo n  # Add a new partition
echo 4  # Partition number 4
echo    # First sector (Accept default: varies)
echo +4G # Last sector
echo n  # Add a new partition
echo 5  # Partition number 5
echo    # First sector (Accept default: varies)
echo +200G # Last sector
echo n  # Add a new partition
echo 6  # Partition number 6
echo    # First sector (Accept default: varies)
echo +50G # Last sector
echo n  # Add a new partition
echo 7  # Partition number 7
echo    # First sector (Accept default: varies)
echo +100G # Last sector
echo n  # Add a new partition
echo 8  # Partition number 8
echo    # First sector (Accept default: varies)
echo +50G # Last sector
echo n  # Add a new partition
echo 9  # Partition number 9
echo    # First sector (Accept default: varies)
echo +20G # Last sector
echo n  # Add a new partition
echo 10  # Partition number 10
echo    # First sector (Accept default: varies)
echo +10G # Last sector
echo n  # Add a new partition
echo 11  # Partition number 11
echo    # First sector (Accept default: varies)
echo +10G # Last sector
echo n  # Add a new partition
echo 12  # Partition number 12
echo    # First sector (Accept default: varies)
echo +10G # Last sector
echo n  # Add a new partition
echo 13  # Partition number 13
echo    # First sector (Accept default: varies)
echo    # Last sector (remaining space)
echo w  # Write changes
) | sudo fdisk $NVME_DEVICE

# Format partitions
echo "Formatting partitions"
sudo mkfs.ext4 ${NVME_DEVICE}p1
sudo mkfs.ext4 ${NVME_DEVICE}p2
sudo mkswap ${NVME_DEVICE}p3
sudo mkfs.ext4 ${NVME_DEVICE}p4
sudo mkfs.ext4 ${NVME_DEVICE}p5
sudo mkfs.ext4 ${NVME_DEVICE}p6
sudo mkfs.ext4 ${NVME_DEVICE}p7
sudo mkfs.ext4 ${NVME_DEVICE}p8
sudo mkfs.ext4 ${NVME_DEVICE}p9
sudo mkfs.ext4 ${NVME_DEVICE}p10
sudo mkfs.ext4 ${NVME_DEVICE}p11
sudo mkfs.ext4 ${NVME_DEVICE}p12
sudo mkfs.ext4 ${NVME_DEVICE}p13

# Mount partitions
echo "Mounting partitions"
sudo mount ${NVME_DEVICE}p2 /mnt
sudo mkdir -p /mnt/{boot,swap,tmp,home,var,usr,usr/local,opt,usr/ports,usr/src,var/log}

sudo mount ${NVME_DEVICE}p1 /mnt/boot
sudo swapon ${NVME_DEVICE}p3
sudo mount ${NVME_DEVICE}p4 /mnt/tmp
sudo mount ${NVME_DEVICE}p5 /mnt/home
sudo mount ${NVME_DEVICE}p6 /mnt/var
sudo mount ${NVME_DEVICE}p7 /mnt/usr
sudo mount ${NVME_DEVICE}p8 /mnt/usr/local
sudo mount ${NVME_DEVICE}p9 /mnt/opt
sudo mount ${NVME_DEVICE}p10 /mnt/usr/ports
sudo mount ${NVME_DEVICE}p11 /mnt/usr/src
sudo mount ${NVME_DEVICE}p12 /mnt/var/log
sudo mount ${NVME_DEVICE}p13 /mnt/extra

# Install GNOME
echo "Installing GNOME"
sudo apt install -y gnome-shell ubuntu-gnome-desktop

# Install NVIDIA drivers
echo "Installing NVIDIA drivers"
sudo apt install -y nvidia-driver-460

# Install WiFi drivers
echo "Installing WiFi drivers"
sudo apt install -y firmware-iwlwifi

# Install development tools
echo "Installing development tools"
sudo apt install -y python3 python3-pip python3-venv
sudo apt install -y git vim neovim
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
sudo apt install -y default-jdk
sudo apt install -y code

# Install Django
echo "Installing Django"
pip3 install django

# Install video player
echo "Installing VLC"
sudo apt install -y vlc

# Install Steam
echo "Installing Steam"
sudo apt install -y steam

echo "Installation complete. Please reboot your system."

# End of script

