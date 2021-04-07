// ****************************************
// Azure Bicep Module:
// Azure Storage Account
// ****************************************

// Parameter of Azure Region to use
param location string = resourceGroup().location

// Parameter of Storage Account Names
param accountName string 

// Storage Account resource
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
    name: accountName          // Storage account name
    location: location  // Azure Region
    kind: 'Storage'
    sku: {
      name: 'Standard_LRS'
    }
}

// Output Storage Accounts Ids in Array
output storageAccountIds string = storageAccount.id 
