#!/bin/bash

set -e

echo "Starting final cleanup to reduce box size..."

# Remove package caches
echo "Cleaning up package caches..."
sudo zypper clean --all

# Remove temporary files
echo "Removing temporary files..."
sudo rm -rf <...>
sudo rm -rf <...>

# Truncate log files
echo "Truncating log files..."
sudo find /var/log -type f -exec sudo truncate -s 0 {} \;

# Remove any residual Docker data (optional, if not needed)
# sudo docker system prune -a -f

# Remove Docker tar files if they haven't been removed
echo "Removing Docker tar files (if any)..."
sudo rm -f <...>

# Zero out free space to make the box more compressible
echo "Zeroing free space to improve compression..."
sudo dd if=/dev/zero of=/EMPTY bs=1M || echo "No free space to zero."
sudo rm -f /EMPTY

# Clear shell history
echo "Clearing shell history..."
history -c
sudo rm -f <...>
sudo rm -f <...>

# Final message
echo "Final cleanup completed."

# Optionally, shut down the VM if this is part of box creation
# sudo shutdown -h now
