// ****************************************
// Azure Bicep Module:
// Bicep file for multiple linux vm's based on module
// ****************************************

targetScope = 'subscription'

param virtualNetworkName string
param location string = 'westeurope'
param count int
param rgName string
param subnetName string = 'myprivatesubnet'
var subnetAddressPrefix = '10.1.0.0/24'
var addressPrefix = '10.1.0.0/16'
param networkSecurityGroupName string = 'aznsg${subnetName}'
@secure()
param password string


resource appRg 'Microsoft.Resources/resourceGroups@2020-01-01' = {
  name: rgName
  location: location
  scope: subscription()
}

resource appRgVnet 'Microsoft.Resources/resourceGroups@2020-01-01' = {
  name: concat(rgName,'-vnet')
  location: location
  scope: subscription()
}

module vms '../.modules/003-linux-vm.bicep' =[for i in range(0,count): {
  name: 'vms${i}'
  params:{
    adminPasswordOrKey: password
    authenticationType: 'password'
    location: location
    adminUsername: 'aztestadmin'
    vmName: 'azvmlbicep${i}'
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





