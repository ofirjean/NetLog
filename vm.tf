resource "azurerm_linux_virtual_machine" "app_vm" {
  name                = "netlog-app-vm"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "Admin@1"
  network_interface_ids = [
    azurerm_network_interface.app_nic.id,
  ]

  #admin_ssh_key {
   # username   = "azureuser"
    #public_key = file("~/.ssh/id_rsa.pub")
  #}

  disable_password_authentication = false

  custom_data = filebase64("${path.module}/cloud-init/app_init.yaml")

  os_disk {
    name                 = "netlog-app-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name = "netlogappvm"

  tags = {
    role    = "app"
    project = "netlog"
  }
}

resource "azurerm_linux_virtual_machine" "db_vm" {
  name                = "netlog-db-vm"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "Admin@1"
  network_interface_ids = [
    azurerm_network_interface.db_nic.id,
  ]

  # admin_ssh_key {
  #   username   = "azureuser"
  #   public_key = file("~/.ssh/netlog_key.pub")
  # }

  disable_password_authentication = false

  custom_data = filebase64("${path.module}/cloud-init/db_init.yaml")

  os_disk {
    name                 = "netlog-db-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name = "netlogdbvm"

  tags = {
    role    = "db"
    project = "netlog"
  }
}
