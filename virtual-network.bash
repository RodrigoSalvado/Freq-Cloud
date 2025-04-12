#!/bin/bash

source ./config.sh


# NOTA: ao criar uma segunda vnet para poder fazer o peering entre elas, os ip's nao podem ser iguais

# Variáveis
subnetName=sub-1
vnetAddressPrefix=10.0.0.0/16
subnetAddressPrefix=10.0.8.0/24

newSubnetName=sub-2
newSubnetPrefix=10.0.9.0/24

# Criar a VNet com a primeira sub-rede
az network vnet create \
  --name $vnetName \
  --resource-group $resourceGroup \
  --location $location \
  --address-prefixes $vnetAddressPrefix \
  --subnet-name $subnetName \
  --subnet-prefixes $subnetAddressPrefix

# Adicionar uma segunda sub-rede
az network vnet subnet create \
  --name $newSubnetName \
  --resource-group $resourceGroup \
  --vnet-name $vnetName \
  --address-prefixes $newSubnetPrefix
