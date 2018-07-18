#!/bin/bash
export resourceGroup=oguzpjenkinstest
virtualMachine=oguzpjenkinstest
adminUser=azureuser
pathToKubeConfig=~/.kube/config

if [ -f $pathToKubeConfig ]
then

    # Create a resource group.
    az group create --name $resourceGroup --location eastus

    # Create a new virtual machine, this creates SSH keys if not present.
    az vm create --resource-group $resourceGroup --name $virtualMachine --admin-username $adminUser --image UbuntuLTS --generate-ssh-keys

    # Open port 22
    az vm open-port --port 80 --resource-group $resourceGroup --name $virtualMachine  --priority 101

    # Open port 80
    az vm open-port --port 22 --resource-group $resourceGroup --name $virtualMachine --priority 102

    # Open port 8080
    az vm open-port --port 8080 --resource-group $resourceGroup --name $virtualMachine --priority 103

    # Use CustomScript extension to install.
    az vm extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --vm-name $virtualMachine --resource-group $resourceGroup --settings '{"fileUris": ["https://raw.githubusercontent.com/OguzPastirmaci/openhack-jenkins-docker/master/config.sh"],"commandToExecute": "./config.sh"}'

    # Get public IP
    ip=$(az vm list-ip-addresses --resource-group $resourceGroup --name $virtualMachine --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress -o tsv)

    # Copy Kube config file to Jenkins
    ssh -o "StrictHostKeyChecking no" $adminUser@$ip sudo chmod 777 /var/lib/jenkins
    yes | scp $pathToKubeConfig $adminUser@$ip:/var/lib/jenkins/config
    ssh -o "StrictHostKeyChecking no" $adminUser@$ip sudo chmod 777 /var/lib/jenkins/config

else
    echo "Kubernetes configuration / authentication file not found. Run az aks get-credentials to download this file."
fi