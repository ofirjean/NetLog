output "app_vm_public_ip" {
  description = "The public IP address of the App VM"
  value       = azurerm_public_ip.app_public_ip.ip_address
}

output "db_vm_private_ip" {
  description = "The private IP address of the DB VM"
  value       = azurerm_network_interface.db_nic.private_ip_address
}
