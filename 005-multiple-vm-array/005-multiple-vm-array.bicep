// ****************************************
// Azure Bicep:
// Bicep file for multiple linux vm's based on module
// ****************************************

targetScope = 'subscription'

@secure()
param password string
param virtualNetworkName string
param location string = 'westeurope'
param vmItems array
param rgName string
param subnetName string = 'myprivatesubnet'
param networkSecurityGroupName string = 'aznsg${subnetName}'


resource appRg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: rgName
  location: location
}

resource appRgVnet 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${rgName}-vnet'
  location: location
}

module vms '../.modules/003-linux-vm.bicep' =[for vmItem in vmItems: {
  name: vmItem
  params:{
    adminPasswordOrKey: password
    authenticationType: 'password'
    location: location
    adminUsername: 'aztestadmin'
    vmName: vmItem
    vnetId: vmvnetItem.outputs.vnetId
    subnetName: subnetName
  }
  scope: appRg
}]

module vmvnetItem '../.modules/004-vnet.bicep'= {
  name: 'vmvnet'
  params:{
    networkSecurityGroupName: networkSecurityGroupName
    subnetName: subnetName
    virtualNetworkName:virtualNetworkName
  }
  scope: appRgVnet
}
