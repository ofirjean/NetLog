resource "azurerm_public_ip" "app_public_ip" {
  name                = "netlog-app-public-ip"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
