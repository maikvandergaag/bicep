targetScope = 'subscription'

metadata info = {
  title: 'Functions demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

import * as functions from 'functions.bicep'

metadata description = '''
Demonstration bicep file that shows how to use functions
'''

@description('The name used to create the resources')
param name string

var storageAccountName =  contains(name, '-') ? fail('The name can not contain a dash (-)') : toLower(replace(name, ' ', ''))

var resourceGroupName = functions.getName(name, 'dev').resourceGroup

resource rg 'Microsoft.Resources/resourceGroups@2025-03-01' = {
  name: resourceGroupName
  location: deployment().location
}

module storageAccount '../.modules/storageaccount.bicep' ={
 name: 'modulePrivate'
 params:{
   name: storageAccountName
   location: deployment().location
   tagValues:{
     deployer: deployer().objectId
   }
 }
 scope: rg
}

