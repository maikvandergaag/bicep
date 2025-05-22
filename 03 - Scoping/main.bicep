targetScope = 'subscription'

metadata info = {
  title: 'Scoping demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

metadata description = '''
Deployment file that deploy's resources to a management group
'''

@description('The name used to create the resources')
param name string

resource rg 'Microsoft.Resources/resourceGroups@2025-03-01' = {
  name: 'mvp-rg-${name}'
  location: 'westeurope'
}

module webapp '../.modules/webapp.bicep' = {
  name: 'webapp'
  scope: rg
  params: {
    name: name
    location: deployment().location
  }
}
