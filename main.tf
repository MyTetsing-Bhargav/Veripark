resource "azurerm_resource_group" "veripark" {
  name     = "veripark"
  location = "East US"
}

resource "azurerm_app_service_plan" "veripark_asp" {
  name                = "veripark-asp"
  location            = azurerm_resource_group.veripark.location
  resource_group_name = azurerm_resource_group.veripark.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "veripark_webapp" {
  name                = "veripark-backendapp"
  location            = azurerm_resource_group.veripark.location
  resource_group_name = azurerm_resource_group.veripark.name
  app_service_plan_id = azurerm_app_service_plan.veripark_asp.id
  site_config {
    dotnet_framework_version = "v7.0"
  }
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

resource "azurerm_virtual_network" "veripark_vnet" {
  name                = "veripark-vnet"
  location            = azurerm_resource_group.veripark.location
  resource_group_name = azurerm_resource_group.veripark.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "veripark_subnet" {
  name                 = "veriparksubnet-webapp"
  resource_group_name  = azurerm_resource_group.veripark.name
  virtual_network_name = azurerm_virtual_network.veripark_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_endpoint" "veripark_pe_webapp" {
  name                = "veripark-webapp-pe"
  location            = azurerm_resource_group.veripark.location
  resource_group_name = azurerm_resource_group.veripark.name
  subnet_id           = azurerm_subnet.veripark_subnet.id
  private_service_connection {
    name                           = "veripark-private-connection"
    private_connection_resource_id = azurerm_app_service.veripark_webapp.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone" "veripark_dns" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.veripark.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "veripark_dnslink" {
  name                  = "veriparkdns-vnet-link"
  resource_group_name   = azurerm_resource_group.veripark.name
  private_dns_zone_name = azurerm_private_dns_zone.veripark_dns.name
  virtual_network_id    = azurerm_virtual_network.veripark_vnet.id
}

resource "azurerm_private_dns_a_record" "veripark_arecord" {
  name                = "veripark-webapp-arecord"
  zone_name           = azurerm_private_dns_zone.veripark_dns.name
  resource_group_name = azurerm_resource_group.veripark.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.veripark_pe_webapp.private_service_connection[0].private_ip_address]
}
