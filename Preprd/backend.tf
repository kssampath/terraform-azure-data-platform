  # Remote state backend (team setting). Requires the storage account below to
  # exist first (bootstrap). State locking is handled automatically by Azure Blob.
  # Uncomment once the backend storage is provisioned.
  # backend "azurerm" {
  #   resource_group_name  = "rg-ads-eus2-edh-preprd-tfstate-001"
  #   storage_account_name = "stadseus2edhpreprdtf001"
  #   container_name       = "tfstate"
  #   key                  = "preprd.terraform.tfstate"
  # }