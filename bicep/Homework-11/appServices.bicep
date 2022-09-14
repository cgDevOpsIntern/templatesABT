param location string = resourceGroup().location
param farmName string = 'h11farm'
param sku string = 'F1'
param skuTier string = 'Free'
param nodeNo int = 1
param webAppName string = 'h11webApp'
param dockerImage string = 'pavcg/alpine-linux'

resource serverFarms 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: farmName
  location: location
  kind: 'linux'
  sku: {
    name: sku
    tier: skuTier
  }
  tags: {
    displayName: farmName
  }
  properties: {
    targetWorkerCount: nodeNo
    reserved: true
  }
}

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: serverFarms.id
    siteConfig: {
      dockerImage: 'DOCKER|${dockerImage}'
    }
  }
  dependsOn: [ serverFarms ]
}

output concatOutput string = '${farmName}${uniqueString(resourceGroup().id)}'
