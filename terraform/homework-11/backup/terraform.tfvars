location           = "westus"
appServiceName     = "h11webApp"
pricingTier        = "B1"
nodeNo             = 1
dockerImage        = "pavcg/alpine-linux"
storageAccountName = "h11storage"
schedule = {
  frequency_interval = 1
  frequency_unit     = "Day"
  retentionPolicy    = 5
}
group = "Cap.Pawel-Aleksandruk"