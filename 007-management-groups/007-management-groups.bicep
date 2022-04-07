targetScope = 'managementGroup'

var mgGroups = json(loadTextContent('mgstructure.json'))


module mg '../.modules/005-managementgroup.bicep' =[for mgItem in mgGroups.tier1: {
  name: mgItem.name
  params:{
    groupName: mgItem.name
    groupId: mgItem.id
  }
  scope:tenant()
}]

module mgTier2 '../.modules/005-managementgroup.bicep' =[for mgItem in mgGroups.tier2: {
  name: mgItem.name
  params:{
    groupName: mgItem.name
    groupId: mgItem.id
    parentGroupId: mgItem.parentId
  }
  scope:tenant()
  dependsOn: mg
}]

module mgTier3 '../.modules/005-managementgroup.bicep' =[for mgItem in mgGroups.tier3: {
  name: mgItem.name
  params:{
    groupName: mgItem.name
    groupId: mgItem.id
    parentGroupId: mgItem.parentId
  }
  scope:tenant()
  dependsOn: mgTier2
}]

module mgTier4 '../.modules/005-managementgroup.bicep' =[for mgItem in mgGroups.tier4: {
  name: mgItem.name
  params:{
    groupName: mgItem.name
    groupId: mgItem.id
    parentGroupId: mgItem.parentId
  }
  scope:tenant()
  dependsOn: mgTier3
}]

module mgTier5 '../.modules/005-managementgroup.bicep' =[for mgItem in mgGroups.tier5: {
  name: mgItem.name
  params:{
    groupName: mgItem.name
    groupId: mgItem.id
    parentGroupId: mgItem.parentId
  }
  scope:tenant()
  dependsOn: mgTier4
}]

module mgTier6 '../.modules/005-managementgroup.bicep' =[for mgItem in mgGroups.tier6: {
  name: mgItem.name
  params:{
    groupName: mgItem.name
    groupId: mgItem.id
    parentGroupId: mgItem.parentId
  }
  scope:tenant()
  dependsOn: mgTier5
}]
