metadata info = {
  title: 'Resource derived demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

metadata description = '''
Demonstration bicep file that shows how to use demo derived types
'''

@description('The name used to create the resources')
param name string = 'default'

module storage '../.modules/storageaccount.bicep' = {
  name: 'storage'
  params: {
    name: toLower(replace(name, ' ', ''))
    location: resourceGroup().location
    tagValues: {
      deployer: deployer().objectId
    }
    sku:'Standard_LRS'
  }
}
