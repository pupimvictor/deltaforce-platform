#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Define Tanzu CLI and kubectl versions
TANZU_CLI_VERSION="1.0.0"
KUBECTL_VERSION="latest"  # You can specify a specific version if needed

# Download and extract Tanzu CLI
TANZU_CLI_URL="https://github.com/vmware-tanzu/tanzu-cli/releases/download/v$TANZU_CLI_VERSION/tanzu-cli-linux-arm64-unstable.tar.gz"
echo $TANZU_CLI_URL
curl -Lo tanzu.tar.gz "$TANZU_CLI_URL"
tar -xvzf tanzu.tar.gz 
rm tanzu.tar.gz 
sudo install v1.0.0/tanzu-cli-linux_arm64 /usr/local/bin/tanzu


# kubectl installation
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
install kubectl /usr/local/bin/kubectl
rm kubectl

echo "Tanzu CLI version $TANZU_CLI_VERSION and kubectl installed for all users."

# Verify installations
tanzu --version
kubectl version 

# Cleanup downloaded installation files (optional)
# rm -f /usr/local/bin/tanzu /usr/local/bin/kubectl
