// storage.bicep
targetScope = 'resourceGroup'

@description('Location for the Storage Account')
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: uniqueString(resourceGroup().id)
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: {
    Department: 'IT'
  }
  properties: {}
}
