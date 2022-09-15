param appServiceName string = 'h11appService'
param location string = resourceGroup().location
param backupName string = 'h11backup'
param webAppName string = 'h11webApp'
param storageAccountURL string = '<backup-url>'
param frequencyInterval int = 5

@allowed([
  'Day'
  'Hour'
])

param frequencyUnit string = 'Day'
param retentionPeriodInDays int = 30


resource webApplication 'Microsoft.Web/sites@2020-12-01' = {
  name: webAppName
  location: location
}

resource webApplicationExtension 'Microsoft.Web/sites/extensions@2020-12-01' = {
  parent: webApplication
  name: 'MSDeploy'
  properties: {
    packageUri: 'packageUri'
    dbType: 'None'
    connectionString: 'connectionString'
    setParameters: {
      'IIS Web Application Name': 'name'
    }
  }
}


resource appServiceName_backup 'Microsoft.Web/sites/config@2022-03-01' = {
  name: '${appServiceName}/backup'
  kind: 'backup'
  properties: {
    backupName: backupName
    backupSchedule: {
      frequencyInterval: frequencyInterval
      frequencyUnit: frequencyUnit
      keepAtLeastOneBackup: 'true'
      retentionPeriodInDays: retentionPeriodInDays
    }
    enabled: 'true'
    storageAccountUrl: storageAccountURL
  }
}
