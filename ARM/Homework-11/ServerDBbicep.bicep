@minLength(1)
param h11_sqlserverAdminLogin string

@secure()
param h11_sqlserverAdminLoginPassword string

@minLength(1)
param h11_sqldbName string

@minLength(1)
param h11_sqldbCollation string = 'SQL_Latin1_General_CP1_CI_AS'
param h11_sqlserverName string

@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param h11_sqldbEdition string = 'Basic'

@description('Describes the performance level for Edition')
@allowed([
  'Basic'
  'S0'
  'S1'
  'S2'
  'P1'
  'P2'
  'P3'
])
param h11_sqldbRequestedServiceObjectiveName string = 'Basic'
param dbBackupPolicy object

var h11_sqlserverName_var = 'h11-sqlserver${uniqueString(resourceGroup().id)}'
var fullyQualifiedh11_sqldbName_var = '${h11_sqlserverName_var}/${h11_sqldbName}'

resource h11_sqlserverName_resource 'Microsoft.Sql/servers@2021-11-01-preview' = {
  name: h11_sqlserverName_var
  location: resourceGroup().location
  tags: {
    displayName: 'h11-sqlserver'
  }
  properties: {
    administratorLogin: h11_sqlserverAdminLogin
    administratorLoginPassword: h11_sqlserverAdminLoginPassword
  }
  dependsOn: []
}

resource h11_sqlserverName_AllowAllWindowsAzureIps 'Microsoft.Sql/servers/firewallrules@2021-11-01-preview' = {
  parent: h11_sqlserverName_resource
  name: 'AllowAllWindowsAzureIps'
  location: resourceGroup().location
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource fullyQualifiedh11_sqldbName 'Microsoft.Sql/servers/databases@2021-11-01-preview' = {
  name: fullyQualifiedh11_sqldbName_var
  location: resourceGroup().location
  tags: {
    displayName: 'h11-sqldb'
  }
  properties: {
    collation: h11_sqldbCollation
    edition: h11_sqldbEdition
    maxSizeBytes: 1073741824
    requestedServiceObjectiveName: h11_sqldbRequestedServiceObjectiveName
  }
  dependsOn: [
    h11_sqlserverName_resource
  ]
}

resource fullyQualifiedh11_sqldbName_Default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2021-11-01-preview' = {
  parent: fullyQualifiedh11_sqldbName
  name: 'Default'
  properties: dbBackupPolicy
  dependsOn: [
    resourceId('Microsoft.Sql/servers/databases', h11_sqlserverName, h11_sqldbName)
  ]
}
