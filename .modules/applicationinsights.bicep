metadata info = {
  title: 'Application Insights module'
  description: 'Module for a single Application Insights instance'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}


@description('Name of the Application Insights instance')
param name string

@description('Location of the Application Insights instance')
param location string = resourceGroup().location

@description('Resource ID of the Log Analytics workspace to connect to')
param logAnalyticsWorkspaceId string

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'api-${name}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceId
    Flow_Type: 'Bluefield'
  }
}

output InstrumentationKey string = applicationInsights.properties.InstrumentationKey
output ConnectionString string = applicationInsights.properties.ConnectionString
