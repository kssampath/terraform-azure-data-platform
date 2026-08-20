data "azurerm_key_vault" "key_vault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg
}

data "azurerm_key_vault_secret" "syn_sql_admin_password" {
  name         = var.syn_sql_admin_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}