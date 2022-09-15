param appServiceName string = 'h11appService'
param backupName string = 'h11backup'
param webApp string = 'h11webApp'
param storageAccountURL string = '<backup-url>'
param frequencyInterval int = 5

@allowed([
  'Day'
  'Hour'
])

param frequencyUnit string = 'Day'
param retentionPeriodInDays int = 30

resource webAppName 'Microsoft.Web/sites@2022-03-01' existing = {
  name: webApp
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
