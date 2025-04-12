#!/bin/bash

# Variáveis
source ./config.sh

init=./inits/cloud-init.yaml

# Criar IP público
az network public-ip create \
  --resource-group $resourceGroup \
  --name $ipName \
  --location $location \
  --sku Standard \
  --allocation-method Static

# Criar NSG
az network nsg create \
  --resource-group $resourceGroup \
  --name $nsgName \
  --location $location

# Criar regra para permitir SSH
az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name $nsgName \
  --name AllowSSH \
  --protocol Tcp \
  --direction Inbound \
  --priority 1000 \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 22 \
  --access Allow

# Criar regra para permitir HTTP
az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name $nsgName \
  --name AllowHTTP \
  --protocol Tcp \
  --direction Inbound \
  --priority 1010 \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 80 \
  --access Allow

# Criar regra para permitir HTTPS
az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name $nsgName \
  --name AllowHTTPS \
  --protocol Tcp \
  --direction Inbound \
  --priority 1020 \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 443 \
  --access Allow

# Criar NIC com NSG associado
az network nic create \
  --resource-group $resourceGroup \
  --name $nicName \
  --vnet-name $vnetName \
  --subnet $subnetName \
  --public-ip-address $ipName \
  --network-security-group $nsgName \
  --location $location

# Criar VM com SSH key e cloud-init
az vm create \
  --resource-group $resourceGroup \
  --location $location \
  --name $vmName \
  --nics $nicName \
  --image Ubuntu2204 \
  --admin-username $user \
  --ssh-key-values $sshKey \
  --custom-data $init \
  --size Standard_B1s \
  --verbose



# Com password

# az vm create \
#     --resource-group $resourceGroup \
#     --location $location \
#     --name $vmName \
#     --image Canonical:UbuntuServer:24.04-LTS:latest \
#     --admin-username $user \
#     --admin-password $password \
#     --nsg-rule SSH \
#     --custom-data $init \
#     --size "Standard_B1s" \
#     --verbose
