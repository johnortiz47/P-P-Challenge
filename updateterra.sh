#!/bin/bash

# Author: John Ortiz
# Description: Makes a backup of current Terraform binary in same folder as script, then updates Terraform
# Date: 18 Mar 2023

# BACKUP
#-------------------------------------------------

# This script must be run with elevated privileges

#Copies current terraform binary to current working folder, extracting the version name as the new file name
cp /usr/bin/terraform `terraform --version | head -n 1 | cut -d ' ' -f 2`


# UPDATE HASHICORP REPOSITORY
#--------------------------------------------------------------

#Gets HashiCorp GPG Key
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

#Add repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# UPDATE TERRAFORM
#--------------------------------------------------------------

#Default location will be /usr/bin as usual for Linux. 
sudo apt update && sudo apt install terraform
