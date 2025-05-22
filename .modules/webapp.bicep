metadata info = {
  title: 'Web app module'
  description: 'Module for a Web App'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

metadata description = '''
Module for a Azure Web App
'''

@description('The SKU name of the App Service Plan')
param skuName string = 'S1'

@description('The SKU capacity of the App Service Plan')
@allowed([
  1
  2
  3
])
param skuCapacity int = 1

@description('The name of the resource group')
param location string = resourceGroup().location

@description('The name used for the resources')
param name string

@description('Additional app settings')
param appSettings object = {}

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: 'asp-${name}'
  location: location
  sku: {
    name: skuName
    capacity: skuCapacity
  }
}

resource appService 'Microsoft.Web/sites@2024-04-01' = {
  name: 'app-${name}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
    }
  }
}

resource siteconfig 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: appService
  name: 'appsettings'
  properties: union(
    {},
    appSettings
  )
}
