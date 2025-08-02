#!/bin/bash

# Get GPU info
if command -v nvidia-smi &> /dev/null; then
    gpu=$(nvidia-smi --query-gpu=name --format=csv,noheader)
elif command -v lshw &> /dev/null; then
    gpu=$(sudo lshw -C display | grep 'product' | head -n1 | cut -d: -f2 | xargs)
elif command -v lspci &> /dev/null; then
    gpu=$(lspci | grep -i 'vga\|3d\|2d' | head -n1)
else
    gpu="Unknown GPU"
fi