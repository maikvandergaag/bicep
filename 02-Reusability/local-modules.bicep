metadata info = {
  title: 'Local modules demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

@description('The name used to create the resources')
param name string

module webapp '../.modules/webapp.bicep' = {
  name: 'webapp'
  params: {
    name: name
    location: resourceGroup().location
  }
}
