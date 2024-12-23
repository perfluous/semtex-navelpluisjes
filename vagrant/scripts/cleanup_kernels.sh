#!/bin/bash

set -e

# Remove old kernels
sudo zypper --non-interactive purge-kernels
