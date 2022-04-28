// ****************************************
// Azure Bicep:
// Bicep files that uses modules
// ****************************************

// Location parameter
param location string = resourceGroup().location


module moduleLocal '../.modules/001-storage-account.bicep' ={
  name: 'moduleLocal'
  params:{
    accountName:'accountName'
    location: location
  }
}

module modulePublic 'br/public:samples/hello-world:1.0.2' ={
  name: 'modulePublic'
  params: {
   name:'devdays'
  }
}

module moduleTemplateSpec 'ts/TemplateSpecs:az-tempspec-automationaccount:0.2' ={
  name: 'moduleTemplateSpec'
  params:{
    automationaccountName: 'azautomationS44pec'
    logAnalyticsWorkspaceName: 'azlaworkspaceName'
    location: location
  }
}

module modulePrivateRegistry 'br:azcrbicepregistry.azurecr.io/bicep/modules/storage-account:v1.0' ={
 name: 'modulePrivate'
 params:{
   accountName:'storageName'
   location: location
 }
}
