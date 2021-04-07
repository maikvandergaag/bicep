// ****************************************
// Azure Bicep Module:
// Azure App Service completly configured
// ****************************************

// SKU name for the app service
param skuName string = 'S1'

// Capacity for the app service
param skuCapacity int = 1

// Location for all the resources
param location string = resourceGroup().location

// name for the app
param appName string

// app service plan name
var appServicePlanName = concat('azhosting-', appName)

// application insights name
var appInsightsName = concat('azinsights-', appName)

// log analytics name
var logAnalyticsName = concat('azloga-', appName)

// website name
var websiteName = concat('azappserv-', appName)

// The hosting name for the web application
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    capacity: skuCapacity
  }
}

// The web application
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: websiteName
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

// The web application logging configuration
resource appServiceLogging 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${appService.name}/logs'
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
}

// The web application app settings
resource appServiceAppSettings 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${appService.name}/appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsights.properties.InstrumentationKey
  }
  dependsOn: [
    appInsights
    appServiceSiteExtension
  ]
}

// The web applications extensions
resource appServiceSiteExtension 'Microsoft.Web/sites/siteextensions@2020-06-01' = {
  name: '${appService.name}/Microsoft.ApplicationInsights.AzureWebsites'
  dependsOn: [
    appInsights
  ]
}

// The application insights component
resource appInsights 'microsoft.insights/components@2020-02-02-preview' = {
  name: appInsightsName
  location: location
  kind: 'string'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

// The log analytics workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 120
  }
}

output appInsightsTelemtry string = appInsights.properties.InstrumentationKey
output workspaceId string = logAnalyticsWorkspace.id
output websiteUrl array = appService.properties.hostNames
