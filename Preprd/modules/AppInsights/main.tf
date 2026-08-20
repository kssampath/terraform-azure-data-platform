terraform { 
  required_providers { 
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" 
    } 
  } 
}


resource "azurerm_log_analytics_workspace" "example" {
  name                = var.loganalytics_workspace_appin
  location            = var.location
  resource_group_name = var.rgappin #"rg-ads-eus2-pioneer-inn-armtotf"
  sku                 = var.sku_appin #"PerGB2018"
  retention_in_days   = var.retention_in_days
}

resource "azurerm_application_insights" "azure-appin" {
  name                = var.appinsights_name #"appin-ads-eus2-edhpreprd-dev-001"
  location            = var.location
  resource_group_name = var.rgappin #"rg-ads-eus2-pioneer-inn-armtotf"
  workspace_id        = azurerm_log_analytics_workspace.example.id
  application_type    = var.application_type #"web"
  tags = {
      AppId                 = var.AppId #"TBD" 
      environment           = var.environment
      DataClassification    = var.DataClassification #"CONFIDENTIAL"
      Role                  = var.Role #"Tools"
      SupportGroup          = var.SupportGroup #"ADCS.Cloud.Infrastructure"
    }
}
