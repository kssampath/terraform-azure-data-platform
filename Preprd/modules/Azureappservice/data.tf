data "azurerm_key_vault" "key_vault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.sql_admin_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}