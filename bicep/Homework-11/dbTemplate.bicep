param serverName string = 'h11dbserver'
param location string = 'resourceGroup().location'
param adminLogin string
@secure()
param adminPassword string

param databaseName string = 'h11dbname'
param skuName string = 'GP_S_Gen5_1'
param tier string = 'GeneralPurpose'

@description('array of firewall rules')
param firewallRules array
param requestedBackupStorageRedundancy string = 'Local'

resource SQLserverName 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
}
resource SQLdatabaseName 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  parent: SQLserverName
  location: location
  name: databaseName
  properties: {
    requestedBackupStorageRedundancy: requestedBackupStorageRedundancy
  }
  sku: {
    name: skuName
    tier: tier
  }
}

resource serverName_firewallRules_name 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = [for item in firewallRules: {
  name: '${serverName}/${item.name}'
  properties: {
    endIpAddress: item.start
    startIpAddress: item.end
  }
  dependsOn: [
    SQLserverName
  ]
}]


