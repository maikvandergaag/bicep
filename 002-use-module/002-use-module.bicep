// ****************************************
// Azure Bicep:
// Bicep files that uses modules
// ****************************************

// Location parameter
param location string = resourceGroup().location

// Use storage module
module storage '../.modules/001-storage-account.bicep' = {
  name: 'storageAccount'
  params:{
    accountName: 'azstrbiceptesting'
    location: location
  }
}


output storageAccountIds string = storage.outputs.storageAccountIds
