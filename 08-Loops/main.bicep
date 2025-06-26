metadata info = {
  title: 'Bicep Deployment File'
  version: '1.0.3'
  author: 'Maik van der Gaag'
}

metadata description = '''
Deployment for creating a storage account
'''

@description('The name of the storageaccount will be in the format st[name][environment]')
param name string

@description('The location of the storageaccount')
param location string = resourceGroup().location

@description('The SKU of the storage account')
param storageSKU string = 'Standard_LRS'

@allowed([
  'tst'
  'acc'
  'prd'
  'dev'
])
@description('The environment were the service is beign deployed to (tst, acc, prd, dev)')
param env string

param containers array = []


var storageName = toLower('st${take(replace(name, '-',''),15)}${env}')

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  parent: storage
  name: 'default'
}


resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = [for container in containers : {
  name: container
  parent: blobService
}]


output name string = storage.name

output deployedContainers array = [for (name, i) in containers: {
  name: storageContainer[i].name
  id: storageContainer[i].id
}]
