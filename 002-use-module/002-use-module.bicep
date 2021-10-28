// ****************************************
// Azure Bicep:
// Bicep files that uses modules
// ****************************************

// Location parameter
param location string = resourceGroup().location

// Use storage module
module storage '../.modules/001-storage-account.bicep' = {
  name: 'storageAccount'
  params:{
    accountName: 'azstrbiceptesting'
    location: location
  }
}

module storageExternal 'br/SponsorRegistry:bicep/modules/storage-account:v1.0' ={
  name: 'storageAccountExternal'
  params:{
    accountName:'azstrbiceptestingexternal'
    location:location
  }
}

module automation 'ts/TemplateSpecs:az-tempspec-automationaccount:0.2' ={
  name: 'automationSpecTempSpec'
  params:{
    automationaccountName: 'azautomationSpec'
    logAnalyticsWorkspaceName: 'azlaworkspaceName'
    location: location
  }
}

output storageAccountIds string = storage.outputs.storageAccountIds
