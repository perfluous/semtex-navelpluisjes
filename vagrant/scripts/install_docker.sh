#!/bin/bash

set -e

# Install required packages
sudo zypper --non-interactive install wget curl git ca-certificates gpg2 lsb-release kernel-default-devel parted gdisk e2fsprogs systemd open-iscsi tpm2.0-tools rng-tools lvm2 mdadm cifs-utils rpcbind squashfuse-tools

# If the overlay module is missing, rebuilding the initramfs might help load the correct kernel modules.
sudo dracut --force --kver "$(uname -r)"

# Set this to 1 if you want to install NVIDIA Container Toolkit, 0 otherwise
INSTALL_NVIDIA_TOOLKIT=0

if [ "$INSTALL_NVIDIA_TOOLKIT" -eq 1 ]; then
    # Install NVIDIA Container Toolkit
    sudo zypper --non-interactive addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
    sudo zypper --gpg-auto-import-keys --non-interactive refresh
    sudo zypper --non-interactive install nvidia-container-toolkit
fi

# Install Docker
sudo zypper install -y docker

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add '<...>' user to the 'docker' group
sudo usermod -aG <...> <...>

# Refresh group membership
exec su -l <...>
