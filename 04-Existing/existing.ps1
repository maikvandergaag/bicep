az account set --subscription a61be14b-136e-44e9-a88e-187fa0384d06

az deployment sub create --location 'westeurope' --template-file 'prerequisites.bicep'

az deployment sub create --location 'westeurope' --template-file 'main.bicep' --parameters 'main.bicepparam'