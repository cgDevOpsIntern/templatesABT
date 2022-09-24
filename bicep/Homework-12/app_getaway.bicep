param location string
param applicationGatewayName string
param tier string
param skuSize string
param capacity int = 2
param subnetName string
param zones array
param virtualNetworkName string
param virtualNetworkPrefix array
param publicIpAddressName string
param sku string
param allocationMethod string
param publicIpZones array
param autoScaleMaxCapacity int

var vnetId = resourceId('Test-RG', 'Microsoft.Network/virtualNetworks/', virtualNetworkName)
var publicIPRef = publicIpAddressName_resource.id
var subnetRef = '${vnetId}/subnets/${subnetName}'
var applicationGatewayId = applicationGatewayName_resource.id

resource applicationGatewayName_resource 'Microsoft.Network/applicationGateways@2021-08-01' = {
  name: applicationGatewayName
  location: location
  zones: zones
  tags: {
    capgem: 'internship'
  }
  properties: {
    sku: {
      name: skuSize
      tier: tier
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          publicIPAddress: {
            id: publicIPRef
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'h11backenpool1'
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'sample_set'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: 'h12_listner'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGatewayId}/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '${applicationGatewayId}/frontendPorts/port_80'
          }
          protocol: 'Http'
          sslCertificate: null
        }
      }
    ]
    listeners: []
    requestRoutingRules: [
      {
        name: 'h12_sample_rule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: '${applicationGatewayId}/httpListeners/h12_listner'
          }
          priority: 1
          backendAddressPool: {
            id: '${applicationGatewayId}/backendAddressPools/h11backenpool1'
          }
          backendHttpSettings: {
            id: '${applicationGatewayId}/backendHttpSettingsCollection/sample_set'
          }
        }
      }
    ]
    routingRules: []
    enableHttp2: false
    sslCertificates: []
    probes: []
    autoscaleConfiguration: {
      minCapacity: capacity
      maxCapacity: autoScaleMaxCapacity
    }
  }
  dependsOn: [
    virtualNetworkName_resource

  ]
}

resource virtualNetworkName_resource 'Microsoft.Network/virtualNetworks@2019-09-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: virtualNetworkPrefix
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
  }
}

resource publicIpAddressName_resource 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: publicIpAddressName
  location: location
  sku: {
    name: sku
  }
  zones: publicIpZones
  properties: {
    publicIPAllocationMethod: allocationMethod
  }
}