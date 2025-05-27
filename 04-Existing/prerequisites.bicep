targetScope = 'subscription'

metadata info = {
  title: 'Prerequisites for the existing demo'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

@description('The name used to create the resources')
param name string = 'prerequisites'


@onlyIfNotExists()
resource rg 'Microsoft.Resources/resourceGroups@2025-03-01' = {
  name: 'mvp-rg-${name}'
  location: 'westeurope'
}

module insights '../.modules/applicationinsights.bicep' = {
  name: 'insights'
  params: {
    name: name
    location: deployment().location
    logAnalyticsWorkspaceId: workspace.outputs.workspaceId
  }
  scope: rg
}

module workspace '../.modules/loganalytics.bicep' = {
  name: 'workspace'
  params: {
    name: name
    location: deployment().location
  }
  scope: rg
}

output instrumentationKey string = insights.outputs.InstrumentationKey
