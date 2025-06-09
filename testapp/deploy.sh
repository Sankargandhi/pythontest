#!/bin/bash

# Fail the script on any error
set -e

echo "🚀 Starting deployment to EC2"

# Write the SSH key to a file (GitHub Action passes via env var)

echo "Creating PEM file"
printf "%s\n" "$EC2_SSH_KEY" > ec2_key.pem


#chmod 600 ec2_key.pem

# Connect and deploy

# Debug info (don't print full private key!)
echo "🔐 EC2_USER: $EC2_USER"
echo "🌐 EC2_HOST: $EC2_HOST"

# Optional: Show first few characters of key for sanity check
echo "🔑 EC2_SSH_KEY starts with: $(echo "$EC2_SSH_KEY" | head -n 1)"

ssh -i ec2_key.pem -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << 'EOF'
  set -e
  echo "Pulling latest changes..."
  cd /home/ec2-user
  git pull origin main

  echo "✅ Deployment completed."
EOF

EXIT_CODE=$?

# Cleanup
rm -f ec2_key.pem

# Return proper exit code to GitHub Actions
exit $EXIT_CODE
