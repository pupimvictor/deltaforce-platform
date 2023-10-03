#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Define the file containing the list of emails
email_list_file="email_list.txt"

# Check if the email list file exists
if [ ! -f "$email_list_file" ]; then
    echo "Email list file '$email_list_file' not found."
    exit 1
fi

# Create users from the email list and set them as sudoers and members of "pi" and "adm" groups
while IFS= read -r email; do
    username=$(echo "$email" | cut -d "@" -f 1)  # Extract username from email
    password=$(openssl rand -base64 6 | tr -dc 'a-zA-Z0-9')  # Generate 6-character password

    # Create the user with the generated password
    useradd -m "$username" -s /bin/bash
    echo "$username:$password" | chpasswd

    # Add the user to the sudo, pi, and adm groups
    usermod -aG sudo,pi,adm "$username"

    echo "User '$username' created with password: $password and added to groups: sudo, pi, adm"
done < "$email_list_file"


# Loop through all users to configure proxy settings
for user_home in /home/*; do
    user=$(basename "$user_home")
    user_profile="$user_home/.profile"

    # Add SOCKS5Proxy environment variable to the user's .profile
    echo "export HTTPS_PROXY=socks5://127.0.0.1:1080" >> "$user_profile" 
    
    # Ensure proper ownership and permissions
    chown "$user:$user" "$user_profile"
    chmod 644 "$user_profile"

    echo "Proxy configured for user: $user"
done

for user_home in /home/*; do
    user=$(basename "$user_home")
    user_profile="$user_home/.profile"

    mkdir $user_home/.kube
    cp /home/operator/.kube/config $user_home/.kube/
    chown "$user:$user" $user_home/.kube/config

    echo "kubeconfg set up for $user"
done

echo "User creation and setup completed."

