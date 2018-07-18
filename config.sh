#!/bin/bash

# Add Microsoft key
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Docker
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y

# Azure CLI
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install azure-cli

# Kubectl
az aks install-cli

# Configure access
usermod -aG docker azureuser

# Run Jenkins
sudo docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 oguzpastirmaci/openhack-jenkins-docker