param networkSecurityGroups_h12NSG_name string = 'h12NSG'

resource networkSecurityGroups_h12NSG_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_h12NSG_name
  location: 'eastus'
  tags: {
    capgem: 'internship'
  }
  properties: {
    securityRules: []
  }
}