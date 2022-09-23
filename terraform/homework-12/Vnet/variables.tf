variable "location" {
  type = string
}
variable "vnetName" {
  type = string
}
variable "addressSpace" {
  type = string
}
variable "arrayOfSubnets" {
  type = list(any)
}
variable "rgName" {
  type    = string
}
# Resources Autenthication 
variable "subID" {
  type = string
}
variable "tenantID" {
  type = string
}
variable "clientID" {
  type = string
}
variable "clientSec" {
  type = string
}