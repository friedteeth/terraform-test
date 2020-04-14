#!/bin/bash
# Terraform installation (run with sudo)

echo "PLEASE RUN WITH SUDO"

echo "Installing dependencies..."
apt-get update &> /dev/null
apt install unzip -y &> /dev/null

echo ""
echo "Downloading terraform zip..."
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip -P /tmp &> /dev/null

echo ""
echo "Unzipping and installing..."
unzip -o /tmp/terraform_0.12.24_linux_amd64.zip -d /usr/local/bin &> /dev/null

echo ""
echo "Cleaning scraps..."
rm -f /tmp/terraform_0.12.24_linux_amd64.zip &> /dev/null

echo ""
echo "Done!"
echo "Terraform was installed."
echo "Run 'terraform' and make sure you have access to the commands."
