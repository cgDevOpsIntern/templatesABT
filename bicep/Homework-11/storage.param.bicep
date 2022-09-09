module storageModule 'storageAcc2.bicep' = {
  name: 'h11storageAccount'
  params: {
    storageAccountName: 'biceph11stroage'
    storageSKU: 'Standard_LRS'
    storageKind: 'StorageV2'
    storageTier: 'Hot'
    location: 'West Europe'
  }
}
