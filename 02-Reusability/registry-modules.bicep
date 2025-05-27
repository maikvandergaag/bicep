metadata info = {
  title: 'Reusability registry demo file'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

@description('The name used to create the resources')
param name string

param location string = resourceGroup().location


module modulePrivateRegistry 'br/myregistry:storageaccount:0.0.1' ={
 name: 'modulePrivate'
 params:{
   name: name
   location: location
   environment: 'dev'
 }
}
