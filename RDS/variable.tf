variable "region" {
  default = "us-east-1"
}
#Get the access key and secret key generated from AWS portal
provider "aws" {
  access_key = ""
  secret_key = ""
}
variable "customVPC" {
  default = "MyowncustomVPC"
  description = "Name of the custom VPC"
}

variable "privateSubnetName" {
  default = "privatesubnet"
  description = "Name of private subnet"
}

variable "publicsubnetname" {
  default = "publicsubnet"
  description = "name of the public subnet"
}

variable "private_az" {
  default = "us-east-1a"
  description = "privateAz"
}

variable "public_az" {
  default = "us-east-1b"
  description = "publicAZ "
}
variable "VPC_CIDR" {
  default = "10.0.0.0/16"
  description = "CIDR Block for VPC"
}
variable "privateCIDR" {
  default = "10.0.1.0/24"
  description = "CIDR Block for private"
}
variable "publicCIDR" {
  default = "10.0.129.0/24"
  description = "CIDR Block for Public"
}
  # Arbitrary mapping of region name to number to use in
  # a VPC's CIDR prefix.
#variable "region_number" {
  #default = {
    #us-east-1      = 1
    #us-west-1      = 2
    #us-west-2      = 3
    #eu-central-1   = 4
    #ap-northeast-1 = 5
  #}
#}

# Assign a number to each AZ letter used in our configuration
#variable "az_number" {
  #default = {
    #a = 1
    #b = 2
    #c = 3
    #d = 4
    #e = 5
    #f = 6
  #}
#}



