# Look up the Key Vault by name (the vault lives outside this module's lifecycle;
# we depend on a secret existing in it, not on the vault resource itself).
data "azurerm_key_vault" "key_vault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg
}

# Read the VM admin password from the vault at runtime — never stored in code/tfvars.
data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = var.vm_admin_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}