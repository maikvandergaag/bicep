using './main.bicep'

param name = 'githubdeploy'
param storageSKU = 'Standard_LRS'
param env = 'tst'
param containers = [
  'mycontainer'
  'testcontainer'
]

