#!/bin/bash

set -e

# Load Docker images from the shared folder
echo "Loading Docker images..."
sudo -u <...> load -i <...>
sudo -u <...> load -i <...>
sudo -u <...> load -i <...>

# Remove Docker image tar files to save space
echo "Removing Docker tar files..."
sudo rm -f <...>

echo "Docker images loaded and tar files removed."
