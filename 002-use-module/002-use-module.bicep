// ****************************************
// Azure Bicep:
// Bicep files that uses modules
// ****************************************

// Location parameter
param location string = resourceGroup().location

// Use storage module
module automation 'ts/TemplateSpecs:az-tempspec-automationaccount:0.2' ={
  name: 'automationSpecTempSpec'
  params:{
    automationaccountName: 'azautomationSpec'
    logAnalyticsWorkspaceName: 'azlaworkspaceName'
    location: location
  }
}
