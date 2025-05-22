metadata info = {
  title: 'Log Analytics Workspace'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

metadata description = '''
Module for a Log Analytics Workspace
'''

@description('Location of the workspace')
param location string = resourceGroup().location

@description('Name of the workspace')
param name string

@description('Sku of the workspace')
@allowed([
  'PerGB2018'
  'Free'
  'Standalone'
  'PerNode'
  'Standard'
  'Premium'
])
param sku string = 'PerGB2018'

@description('The workspace data retention in days. Allowed values are per pricing plan. See pricing tiers documentation for details.')
@minValue(7)
@maxValue(730)
param retentionInDays int = 30

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' = {
  name: 'log-${name}'
  location: location
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
  }
}


output workspaceId string = logAnalyticsWorkspace.id
output workspaceName string = logAnalyticsWorkspace.name
