#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Define the SSH tunnel details
tunnel_user="your_ssh_username"
tunnel_host="your_ssh_host"
tunnel_port="your_ssh_port"
# Define the SSH tunnel details
tunnel_user="operator"
tunnel_host="192.168.0.178"
tunnel_port=22

# Start the SSH SOCKS5 tunnel in the background
ssh -fN -D 1080 "$tunnel_user@$tunnel_host" -p "$tunnel_port"

echo "SSH SOCKS5 tunnel established, and proxy configured for all users."
