param subscriptionId string
param appName string
param farmName string
param location string
param hostingPlanName string
param serverFarmResourceGroup string
param sku string
param skuCode string
param numberOfWorkers int
param linuxFxVersion string
param dockerRegistryUrl string

resource name_resource 'Microsoft.Web/sites@2022-03-01' = {
  name: farmName
  location: location
  tags: {
  }
  properties: {
    name: name
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryUrl
        }
      ]
      linuxFxVersion: linuxFxVersion
    }
    serverFarmId: '/subscriptions/${subscriptionId}/resourcegroups/${serverFarmResourceGroup}/providers/Microsoft.Web/serverfarms/${hostingPlanName}'
    clientAffinityEnabled: false
    virtualNetworkSubnetId: null
    httpsOnly: true
  }
  dependsOn: [
    hostingPlanName_resource
  ]
}

resource hostingPlanName_resource 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: hostingPlanName
  location: location
  sku: {
    tier: sku
    name: skuCode
  }
  kind: 'linux'
  properties: {
    workerTierName: hostingPlanName
    numberOfWorkers: numberOfWorkers
  }
}
