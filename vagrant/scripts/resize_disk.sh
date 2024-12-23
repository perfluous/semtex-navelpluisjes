#!/bin/bash

set -e

# Install parted, gdisk, and e2fsprogs if not already installed
sudo zypper install -y parted gdisk e2fsprogs

# Detect the root partition
ROOT_PART=$(findmnt -n -o SOURCE /)

# Get the disk and partition number (e.g., /dev/vda3)
DISK=$(echo "$ROOT_PART" | sed -E 's/p?[0-9]+$//')
PART_NUM=$(echo "$ROOT_PART" | grep -o '[0-9]*$')

# Fix GPT if needed
echo "Fixing GPT if necessary..."
sudo sgdisk -e "$DISK"

# Resize the partition
echo "Resizing partition $ROOT_PART on disk $DISK..."

sudo parted --script "$DISK" unit % resizepart "$PART_NUM" 100%

# Inform the OS of partition table changes
sudo partprobe "$DISK"

# Resize the filesystem
echo "Resizing filesystem on $ROOT_PART..."
sudo resize2fs "$ROOT_PART"

