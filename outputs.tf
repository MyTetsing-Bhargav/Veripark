output "resource_group_name" {
  value = azurerm_resource_group.veripark.name
}

output "app_service_plan_id" {
  value = azurerm_app_service_plan.veripark_asp.id
}

output "app_service_name" {
  value = azurerm_app_service.veripark_webapp.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.veripark_vnet.name
}

output "veripark_subnet" {
  value = azurerm_subnet.veripark_subnet.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.veripark_pe_webapp.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.veripark_dns.id
}
