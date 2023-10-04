#!/bin/bash

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


    if [ -d ../tenants/$username ]; then
        echo mkdirneed
    fi

    echo "'$username' hidrated" 
done < "$email_list_file"


echo "User hidration and setup completed."

