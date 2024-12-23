#!/bin/bash

set -e

# Update and upgrade the system
sudo zypper refresh
sudo zypper update -y

# Clean up unused packages
sudo zypper clean
