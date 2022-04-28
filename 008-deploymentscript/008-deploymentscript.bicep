param location string = resourceGroup().location

var scriptContent = loadTextContent('script.ps1')

param argumentNameValue string

resource sscript 'Microsoft.Resources/deploymentScripts@2020-10-01'={
  name: 'deploymentscript'
  kind:'AzurePowerShell'
  location: location
  properties:{
    retentionInterval: 'P1D'
    azPowerShellVersion: '6.4'
    arguments: '-name \\"${argumentNameValue}\\"'
    environmentVariables: [
      {
        name: 'envValue1'
        value: 'test'
      }
      {
        name: 'envValue2'
        secureValue: 'test 2'
      }
    ]
    scriptContent: scriptContent
  }
}


output scriptOutput string = sscript.properties.outputs.output1
