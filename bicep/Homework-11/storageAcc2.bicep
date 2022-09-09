// @storage.param.json

param storageAccountName string
param storageSKU string
param storageKind string
param storageTier string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSKU
  }
  kind: storageKind
  properties: {
    accessTier: storageTier
    supportsHttpsTrafficOnly: true
  }
}
