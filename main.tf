terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.60.0"
    }
  }
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_databricks_workspace" "main" {
  name                        = var.workspace_name
  resource_group_name         = data.azurerm_resource_group.main.name
  location                    = var.location
  sku                         = var.databricks_sku
  managed_resource_group_name = var.managed_resource_group_name

  custom_parameters {
    no_public_ip                                         = var.no_public_ip
    public_subnet_name                                   = var.public_subnet_name
    private_subnet_name                                  = var.private_subnet_name
    virtual_network_id                                   = var.vnet_id
    public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group_association_id
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
  }

  tags = var.tags
}
