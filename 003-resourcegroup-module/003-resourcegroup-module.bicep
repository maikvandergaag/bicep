// ****************************************
// Azure Bicep:
// Bicep files deploy resource group with module
// ****************************************

// set the target scope for this file
targetScope = 'subscription'

param appRgName string

param rglocation string

// deploy a resource group to the subscription scope
resource appRg 'Microsoft.Resources/resourceGroups@2020-01-01' = {
  name: appRgName
  location: rglocation
  scope: subscription()
}

// deploy a module to that newly-created resource group
module storageMod '../.modules/001-storage-account.bicep' = {
  name: 'storageAccount'
  params: {
    accountName: 'azstrmodulerg'
    location: appRg.location
  }
  scope: appRg
}
