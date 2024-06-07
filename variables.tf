variable "location" {
  description = "The Azure region to deploy resources in"
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "veripark"
}

variable "app_service_plan_name" {
  description = "The name of the App Service plan"
  default     = "veripark-asp"
}

variable "app_service_name" {
  description = "The name of the App Service"
  default     = "veripark-backendapp"
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  default     = "veripark-vnet"
}

variable "subnet_name" {
  description = "The name of the Subnet"
  default     = "veriparksubnet-webapp"
}

variable "private_endpoint_name" {
  description = "The name of the Private Endpoint"
  default     = "veripark-webapp-pe"
}

variable "dns_zone_name" {
  description = "The name of the Private DNS Zone"
  default     = "privatelink.azurewebsites.net"
}
