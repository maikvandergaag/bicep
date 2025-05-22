targetScope = 'subscription'

metadata info = {
  title: 'Local modules demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

@description('The name used to create the resources')
param name string


@onlyIfNotExists()
resource rg 'Microsoft.Resources/resourceGroups@2025-03-01' = {
  name: 'mvp-rg-${name}'
  location: 'westeurope'
}

module webapp '../.modules/webapp.bicep' = {
  name: 'webapp'
  params: {
    name: name
    location: deployment().location
    appSettings: {
      APPINSIGHTS_INSTRUMENTATIONKEY: insights.properties.InstrumentationKey
    }
  }
  scope: rg
}

resource insights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: 'api-prerequisites'
  scope: resourceGroup('mvp-rg-prerequisites')
 }
