targetScope = 'tenant'

param groupName string
param groupId string
param parentGroupId string = ''

resource mg 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: groupId
  properties: {
    displayName: groupName
    details: empty(parentGroupId) ? json('null') : {
      parent: {
        id: tenantResourceId('Microsoft.Management/managementGroups', parentGroupId)
      }
    }
  }
  scope: tenant()
}
