#!/bin/bash

source ./config.sh

az group create \
    --name $resourceGroup \
    --location $location