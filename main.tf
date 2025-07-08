terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.81.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {}

  subscription_id                  = "a336c49a-857d-4721-a0bc-815981f9839a"
  tenant_id                        = "8295a129-7c77-4f35-9ea4-2921d9019a4d"
 
  resource_provider_registrations = "none"
}


data "azurerm_resource_group" "existing" {
  name = "rg-ofir"
}
