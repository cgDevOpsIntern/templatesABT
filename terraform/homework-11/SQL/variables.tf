variable "rgName" {
  type    = string
  default = "Cap.Pawel-Aleksandruk"
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
variable "admName" {
  type    = string
  default = "h11admlog"
}
variable "logpass" {
  type    = string
  default = "#@$WER%wrt2341q"
}

variable "location" {
  type    = string
  default = "eastus"
}
variable "serverName" {
  type    = string
  default = "h11sqlserver"
}
variable "dbName" {
  type    = string
  default = "h11dbName"
}
variable "pricingTier" {
  type    = string
  default = "S0"
}
variable "dbBackupPolicy" {
  type    = string
  default = "Local"
}

variable "firewallRules" {
  type = list(any)
  default = [
    {
      name  = "rule1",
      start = "1.0.0.1",
      end   = "1.0.0.1"
    },
    {
      name  = "rule2",
      start = "1.1.1.1",
      end   = "1.1.1.1"
    },
    {
      name  = "rule3",
      start = "8.8.8.8",
      end   = "8.8.8.8"
    }
  ]
}
