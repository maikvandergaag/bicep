az account set --subscription a61be14b-136e-44e9-a88e-187fa0384d06

az deployment sub create --template-file 'main.bicep' --location 'westeurope' --parameters 'main-param.bicepparam'
