metadata info = {
  title: 'Reusability avm demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

@description('The name used to create the resources')
param name string

@description('The location used to create the resources')
param location string = resourceGroup().location

module moduleAVMRegistry 'br/public:avm/res/key-vault/vault:0.12.1' = {
  name: 'avm-keyvault-deploy'
  params: {
    name: 'kv-${name}'
    location: location
    enableSoftDelete: true
  }
}
