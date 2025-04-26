// main.bicep
targetScope = 'subscription'

@description('Name of the Resource Group')
param rgName string = 'rg-dummy-test'

@description('Location for the Resource Group')
param location string = 'australiaeast'

// Create the Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
}

// Deploy the Storage Account inside the Resource Group
module storageModule './storage.bicep' = {
  name: 'storageDeployment'
  scope: rg
  params: {
    location: location
  }
}
