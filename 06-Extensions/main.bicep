extension microsoftGraphV1

metadata info = {
  title: 'Extenion demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

metadata description = '''
Demonstration bicep file that shows how to use extensions
'''

param location string = resourceGroup().location

param name string = 'default'

var readerRole = '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'

var roleAssignmentName = guid(resourceGroup().id, groupName, storageName)

var groupName = 'sg-${name}'

var storageName = 'stgraphdemo${name}'

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    minimumTlsVersion: 'TLS1_2'
  }
}

resource readerGroup 'Microsoft.Graph/groups@v1.0' = {
  displayName: groupName
  mailEnabled: false
  mailNickname: uniqueString(groupName)
  securityEnabled: true
  uniqueName: groupName
  owners: [
    deployer().objectId
  ]
  members: [
    deployer().objectId
  ]
}

resource readersRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storage
  name: roleAssignmentName
  properties: {
    principalId: readerGroup.id
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', readerRole)
  }
}
