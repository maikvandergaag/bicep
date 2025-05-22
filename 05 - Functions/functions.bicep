@export()
type nameObject = {
  storageAccount: string
  logAnalytics: string
  applicationInsights: string
  resourceGroup: string
  managedIdentity: string
}

var storageabbreviation = 'st'
var applicationinsightsabbreviation = 'appi'
var loganalyticsabbreviation = 'log'
var resourcegroupabbreviation = 'rg'
var managedidentityabbreviation = 'id'

@export()
func getName(name string, env string) nameObject =>
  {
    storageAccount: '${storageabbreviation}${take(replace(name, '-',''), 18)}${env}'
    logAnalytics: '${loganalyticsabbreviation}-${name}-${env}'
    applicationInsights: '${applicationinsightsabbreviation}-${name}-${env}'
    managedIdentity: '${managedidentityabbreviation}-${name}-${env}'
    resourceGroup: '${resourcegroupabbreviation}-${name}-${env}'
  }
