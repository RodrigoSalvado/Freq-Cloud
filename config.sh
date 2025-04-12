#config.sh

resourceGroup=Freq

location=uksouth  # Altera para a região desejada, ex: northeurope, francecentral, uksouth etc.

vmName=myVM

user=azureuser
password=RodrigoSalvad0!

nsgName=my-nsg

vnetName="my-vnet"
subnetName="sub-1"
ipName="${vmName}-ip"
nicName="${vmName}-nic"

sshKey="./ssh-keys/chave_publica.pub"