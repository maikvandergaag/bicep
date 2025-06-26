
metadata info = {
  title: 'Example file for showing Condition functionality'
  description: 'Bicep template used for showing Condition functionality'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

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

@description('Deploy logs')
param deployLogs bool = true

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

resource appServiceLogging 'Microsoft.Web/sites/config@2024-04-01'  = if (deployLogs) {
  name: 'logs'
  properties: {
    applicationLogs: {
      fileSystem: {
        level: 'Warning'
      }
    }
    httpLogs: {
      fileSystem: {
        retentionInMb: 40
        enabled: true
      }
    }
    failedRequestsTracing: {
      enabled: true
    }
    detailedErrorMessages: {
      enabled: true
    }
  }
  parent: appService
}

resource appServiceAppSettings 'Microsoft.Web/sites/config@2024-04-01' = {
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsights.properties.InstrumentationKey
  }
  parent: appService
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${name}'
  location: location
  kind: 'string'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' = {
  name: 'log-${name}'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 120
  }
}
