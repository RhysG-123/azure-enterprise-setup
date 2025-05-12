param location string = resourceGroup().location
param vnetName string = 'enterprise-vnet'
param subnetName string = 'vm-subnet'
param addressPrefix string = '10.0.0.0/16'
param subnetPrefix string = '10.0.1.0/24'
param vmCount int = 2
param storageAccountName string
@secure()
param adminPassword string

var commonTags = {
  Department: 'Development'
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  tags: commonTags
  properties: {
    addressSpace: {
      addressPrefixes: [addressPrefix]
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: '${subnetName}-nsg'
  location: location
  tags: commonTags
  properties: {
    securityRules: [
      {
        name: 'AllowHTTP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  parent: vnet
  name: subnetName
  properties: {
    addressPrefix: subnetPrefix
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: 'vm-public-ip'
  location: location
  tags: commonTags
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource lb 'Microsoft.Network/loadBalancers@2023-04-01' = {
  name: 'vm-loadbalancer'
  location: location
  tags: commonTags
  properties: {
    frontendIPConfigurations: [
      {
        name: 'LoadBalancerFrontEnd'
        properties: {
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'BackendPool'
      }
    ]
    probes: [
      {
        name: 'HealthProbe'
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'HTTPRule'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', 'vm-loadbalancer', 'LoadBalancerFrontEnd')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', 'vm-loadbalancer', 'BackendPool')
          }
          probe: {
            id: resourceId('Microsoft.Network/loadBalancers/probes', 'vm-loadbalancer', 'HealthProbe')
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 4
        }
      }
    ]
  }
  dependsOn: [publicIP]
}

module vms 'modules/vm.bicep' = [for i in range(0, vmCount): {
  name: 'vm-${i}'
  params: {
    vmName: 'vm-${i}'
    location: location
    subnetId: subnet.id
    lbBackendPoolId: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', 'vm-loadbalancer', 'BackendPool')
    storageAccountName: storageAccountName
    adminPassword: adminPassword
    tags: commonTags
  }
}]
