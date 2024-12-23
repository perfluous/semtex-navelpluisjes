#!/bin/bash

set -e

# Clone the Loghi repository (if not already present)
if [ ! -d "/home/<...>/loghi" ]; then
  sudo -u <...> git clone https://github.com/knaw-huc/loghi.git /home/<...>/loghi
fi
