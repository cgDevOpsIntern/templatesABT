param configurationStores_h14_appconf_name string = 'h14-appconf'

resource configurationStores_h14_appconf_name_resource 'Microsoft.AppConfiguration/configurationStores@2022-05-01' = {
  name: configurationStores_h14_appconf_name
  location: 'eastus'
  tags: {
    capgem: 'internship'
  }
  sku: {
    name: 'free'
  }
  properties: {
    encryption: {
    }
    disableLocalAuth: false
    softDeleteRetentionInDays: 0
    enablePurgeProtection: false
  }
}