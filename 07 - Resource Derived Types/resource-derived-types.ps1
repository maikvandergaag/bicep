az account set --subscription a61be14b-136e-44e9-a88e-187fa0384d06

az group create --name 'rg-bicep-demo-07' --location 'westeurope'

az deployment group create --resource-group 'rg-bicep-demo-07' --template-file 'main.bicep'