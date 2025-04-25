// =============================
// Level 3: Azure Enterprise Setup (Bicep)
// Author: Rhys | Project: Mock Enterprise Azure Environment
// =============================

// PARAMS
param location string = 'australiaeast'
param departmentTag string = 'Development'

// RESOURCE GROUP
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-dummy-test'
  location: location
  tags: {
    Department: departmentTag
  }
}

// STORAGE ACCOUNT
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
}

// NOTES FOR NEXT STEPS:
// - Management groups and RBAC roles must be handled outside Bicep (via CLI or separate pipeline, or Bicep + Azure Deployment Scripts)
// - Azure Policy definitions and assignments can also be defined in Bicep if desired (coming next)
// - This template is scoped to a resource group-level deployment

// TO DEPLOY:
// az deployment sub create \
//   --location australiaeast \
//   --template-file ./azure_enterprise_setup.bicep \
//   --parameters departmentTag="Development"

// Add this to GitHub and use Actions to deploy automatically on push

