#!/bin/bash

# Fail the script on any error
set -e

echo "🚀 Starting deployment to EC2"

# Write the SSH key to a file (GitHub Action passes via env var)

echo "Creating PEM file"
printf "%s\n" "$EC2_SSH_KEY" > ec2_key.pem
chmod 600 ec2_key.pem

# Optional: Show first few characters of key for sanity check
set -e
echo "Coping the code"

sshpass -p "$EC2_PASSWORD" scp -o StrictHostKeyChecking=no -r ./ "$EC2_USER@$EC2_HOST:/home/$EC2_USER/main-code"

echo "✅ Deployment completed."

EXIT_CODE=$?

# Cleanup
rm -f ec2_key.pem

# Return proper exit code to GitHub Actions

exit $EXIT_CODE
