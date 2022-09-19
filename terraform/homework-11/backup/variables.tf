variable "location" {
  type = string
}
variable "group" {
  type = string
}
variable "appServiceName" {
  type = string
}
variable "pricingTier" {
  type = string
}
variable "nodeNo" {
  type = number
}
variable "dockerImage" {
  type = string
}
variable "storageAccountName" {
  type = string
}
variable "schedule" {
  type = object({ frequency_interval = number, frequency_unit = string, retentionPolicy = number })
}
variable "subID" {
  type = string
  default = "f37554b3-4021-4a23-ab51-111c0c484417"
}
variable "tenantID" {
  type = string
  default = "cbc214c3-6a4f-47db-8d6d-fe1055b29117"
}
variable "clientID" {
  type = string
  default = "db90dc2b-e8e3-41a8-90f9-d9afb4dcc59b"
}
variable "clientSec" {
  type = string
  default = "re38Q~DPiMdhU2hPemeq1sHRkMji5R9IdW6FlbIN"
}