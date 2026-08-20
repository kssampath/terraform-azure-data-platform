terraform { 
  required_providers { 
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" 
    } 
  } 
}

// // Create the log_analytics_workspace
// resource "azurerm_log_analytics_workspace" "databricks-loganalytics" {
//   name                = var.dbrlogworkspace-name #"law-ads-eus2-core-dev-001"
//   location            = var.location
//   resource_group_name = var.rgdbr
//   sku                 = var.dbrsku #"PerGB2018"
//   retention_in_days   = 30
// }

// Create the security groups and make the associations with the subnets
// resource "azurerm_network_security_group" "databricks-subnet-private-sg" {
//   name                = var.security_group_name_private_dbr
//   location            = var.location
//   resource_group_name = var.rgdbr
//   tags = {
//     AppId = var.AppId #"TBD" 
//     environment = var.environment
//     DataClassification = var.DataClassification #"CONFIDENTIAL"
//     Role = var.Role #"Tools"
//     SupportGroup = var.SupportGroup #"ADCS.Cloud.Infrastructure"
//   }
// }

// resource "azurerm_network_security_group" "databricks-subnet-public-sg" {
//   name                = var.security_group_name_public_dbr
//   location            = var.location
//   resource_group_name = var.rgdbr
  
//   tags = {
//     AppId = var.AppId #"TBD" 
//     environment = var.environment
//     DataClassification = var.DataClassification #"CONFIDENTIAL"
//     Role = var.Role #"Tools"
//     SupportGroup = var.SupportGroup #"ADCS.Cloud.Infrastructure"
//   }
// }


// // Create the subnets in vnet
// resource "azurerm_subnet" "public-subnet" {
//   name                 = var.public_subnet_name_dbr
// #  depends_on          = [azurerm_virtual_network.databricks-virtual-network]
//   resource_group_name  = var.rgvnet 
//   virtual_network_name = var.vnet_name #"vnet-ads-eus2-analytics-int-dev-004"
//   address_prefixes     = var.public_address_prefix_dbr  #"10.40.52.0/26"


//   delegation {
//     name = "delegation"

//     service_delegation {
//       name    = "Microsoft.Databricks/workspaces"
//       actions = []
//     }
//   }
// }

// resource "azurerm_subnet" "private-subnet" {
//   name                 = var.private_subnet_name_dbr
//   #depends_on          = [azurerm_virtual_network.databricks-virtual-network]
//   resource_group_name  = var.rgvnet
//   virtual_network_name = var.vnet_name #"vnet-ads-eus2-analytics-int-dev-004"
//   address_prefixes     = var.private_address_prefix_dbr  #"10.40.52.64/26"

//   delegation {
//     name = "delegation"

//     service_delegation {
//       name    = "Microsoft.Databricks/workspaces"
//       actions = []
//     }
//   }
// }

// //Association of private subnet with NSG
// resource "azurerm_subnet_network_security_group_association" "private-subnet-sg-association" {
//   subnet_id                 = azurerm_subnet.private-subnet.id
//   network_security_group_id = azurerm_network_security_group.databricks-subnet-private-sg.id
// }

// //Association of public subnet with NSG
// resource "azurerm_subnet_network_security_group_association" "public-subnet-sg-association" {
//   subnet_id                 = azurerm_subnet.public-subnet.id
//   network_security_group_id = azurerm_network_security_group.databricks-subnet-public-sg.id
// }

//Creation of Databricks workspace
resource "azurerm_databricks_workspace" "module-databricks" {
  name                = var.databricksworkspace_name
  resource_group_name = var.rgdbr
  #hold the workspace
  managed_resource_group_name = var.databricks_managed_resource_group_name
  location            = var.location

  sku                 = var.sku_premium #"premium"
  
  // custom_parameters {
  //   no_public_ip        = false
  //   virtual_network_id  = var.vnet_id
  //   public_subnet_name  = var.public_subnet_name_dbr
  //   public_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.public-subnet-sg-association.id
  //   private_subnet_name = var.private_subnet_name_dbr
  //   private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private-subnet-sg-association.id
  // }

  tags = {
    application = "databricks"
    AppId = var.AppId #"TBD" 
    databricks-environment = true
    environment = var.environment
    DataClassification = var.DataClassification #"CONFIDENTIAL"
    Role = var.Role #"Tools"
    SupportGroup = var.SupportGroup #"ADCS.Cloud.Infrastructure"
  }
}
