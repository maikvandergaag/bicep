az account set --subscription a61be14b-136e-44e9-a88e-187fa0384d06

az group create --name 'rg-bicep-demo-02' --location 'westeurope'

az deployment group create --template-file 'local-modules.bicep' --resource-group 'rg-bicep-demo-02' --parameters 'local-modules.bicepparam'

az deployment group create --template-file 'registry-modules.bicep' --resource-group 'rg-bicep-demo-02' --parameters 'registry-modules.bicepparam'

az deployment group create --template-file 'avm-modules.bicep' --resource-group 'rg-bicep-demo-02' --parameters 'avm-modules.bicepparam'