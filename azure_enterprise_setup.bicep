// =============================
// Azure Enterprise Setup (Fixed Bicep Version)
// =============================

// PARAMS
param location string = 'australiaeast'
param departmentTag string = 'Development'

// RESOURCE GROUP (created at Subscription Scope)
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-dummy-test'
  location: location
  tags: {
    Department: departmentTag
  }
}

// STORAGE ACCOUNT (inside the Resource Group you just created)
resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stor${uniqueString(rg.name)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
  tags: {
    Department: departmentTag
  }
  // Set the parent resource group
  scope: resourceGroup(rg.name)
}
