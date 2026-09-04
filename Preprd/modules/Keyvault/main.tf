terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0"
    }
  }
}
data "azurerm_client_config" "current" {}
# enable_rbac_authorization = true defers all data-plane permissions to Azure RBAC,
# so access is granted via azurerm_role_assignment rather than inline access_policy blocks.
resource "azurerm_key_vault" "key_vault" {
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.rgkv
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = "standard"
  enabled_for_disk_encryption     = false
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  soft_delete_retention_days      = 7
  purge_protection_enabled        = var.purge_protection_enabled
  rbac_authorization_enabled      = true

  # We have now moved to RBAC model for Key Vault access control, so we don't need to define access policies in the Key Vault resource. Instead, we will use Azure RBAC roles to manage access to the Key Vault. The following access policy block is commented out as it is no longer needed.
  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = data.azurerm_client_config.current.object_id

  #   key_permissions = var.key_permissions
  #   secret_permissions = var.secret_permissions
  # }

}

# Grant the identity running Terraform admin rights over this vault's data plane,
# scoped to just this vault (least privilege — not subscription-wide).
resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

# NOTE: Private endpoint intentionally NOT defined here (loose coupling).
# It depends on a VNet subnet; it will be added once the VNet module is migrated,
# in a separate file/module that consumes this vault's ID via the output below.

resource "azurerm_private_endpoint" "key-vault-pep" {
  name                = var.key_vault_end_point_name
  location            = var.location
  resource_group_name = var.rgkv
  subnet_id           = var.kvsubnet_id

  private_service_connection {
    name                           = azurerm_key_vault.key_vault.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    subresource_names              = ["vault"]
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}
