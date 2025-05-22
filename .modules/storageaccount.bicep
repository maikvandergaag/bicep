metadata info = {
  title: 'Storage Account Module'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

metadata description = '''
Module for creating a storage account
'''

@description('The name of the storageaccount will be in the format str[name][environment]')
param name string

@description('The location of the storageaccount')
param location string = resourceGroup().location

@description('The SKU of the storage account')
param sku resourceInput<'Microsoft.Storage/storageAccounts@2024-01-01'>.sku.name = 'Standard_LRS'

@description('The tags for the storage account')
param tagValues object = {}

var storageName = toLower('str${take(replace(name, '-',''),15)}')

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageName
  location: location
  tags: tagValues
  sku: {
    name: sku
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

output name string = storage.name
