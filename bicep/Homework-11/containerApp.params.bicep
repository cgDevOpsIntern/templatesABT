module contfarmModule 'containerApp.bicep' = {
  name: 'h11containerApp'
  params: {
    subscriptionId: 'a4d2d645-5b37-48c6-b284-6861dcfd344a'
    appName: 'h11appName'
    farmName: 'h11LinuxFarm'
    location: 'resourceGroup().location'
    hostingPlanName: 'h11-testPlan'
    serverFarmResourceGroup: 'h11farmRG'
    sku: 'Basic'
    skuCode: 'B1'
    numberOfWorkers: 1
    linuxFxVersion: 'pavcg/alpine-linux'
    dockerRegistryUrl: 'https://index.docker.io'

  }
}
