param location string
param virtualNetworkName string
param resourceGroup string
param addressSpaces array
param ipv6Enabled bool
param subnetCount int
param subnet0_name string
param subnet0_addressRange string
param subnet1_name string
param subnet1_addressRange string
param ddosProtectionPlanEnabled bool
param firewallEnabled bool

resource virtualNetworkName_resource 'Microsoft.Network/VirtualNetworks@2021-01-01' = {
  name: virtualNetworkName
  location: location
  tags: {
    capgem: 'internship'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'h12subnet1'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'h12subnet2'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
    enableDdosProtection: ddosProtectionPlanEnabled
  }
  dependsOn: []
}