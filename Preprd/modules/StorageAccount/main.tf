terraform {
  required_version = ">= 1.00"
}

# ADLS Gen2 storage account (is_hns_enabled = true makes it hierarchical/Data Lake).
resource "azurerm_storage_account" "storage-account" {
  name                     = var.storage-name
  resource_group_name      = var.storage_rg
  location                 = var.location
  account_tier             = var.account-tier
  account_replication_type = var.replication-type
  account_kind             = var.storage-kind
  min_tls_version          = var.storage-tls
  is_hns_enabled           = true

  # 4.x renamed args: was enable_https_traffic_only / allow_blob_public_access
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  network_rules {
    # Deny public network access by default; reach the account only via the
    # private endpoints below. "Allow" here would defeat the private-endpoint design.
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# One private endpoint per storage sub-resource (blob, dfs, file, queue, table),
# created by iterating over a map of sub-resource type -> endpoint name.
# each.key is the sub-resource type; each.value is that endpoint's name.
resource "azurerm_private_endpoint" "storage" {
  for_each = var.private_endpoints

  name                = each.value
  location            = var.location
  resource_group_name = var.storage_rg
  subnet_id           = var.storsubnet_id

  private_service_connection {
    name                           = "${azurerm_storage_account.storage-account.name}-${each.key}"
    private_connection_resource_id = azurerm_storage_account.storage-account.id
    is_manual_connection           = false
    subresource_names              = [each.key]
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}