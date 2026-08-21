# One NIC per VM, keyed the same as the VMs so they pair up by each.key.
resource "azurerm_network_interface" "nic" {
  for_each = var.virtual_machines

  name                = each.value.nic_name
  location            = var.location
  resource_group_name = var.rgvm

  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = var.vmnicsub_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

# Modern Linux VM resource (replaces the deprecated azurerm_virtual_machine).
resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.virtual_machines

  name                            = each.value.name
  location                        = var.location
  resource_group_name             = var.rgvm
  size                            = var.vm_size
  computer_name                   = each.value.computer_name
  admin_username                  = each.value.admin_username
  admin_password                  = data.azurerm_key_vault_secret.vm_admin_password.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    name                 = each.value.os_disk_name
    caching              = var.caching
    storage_account_type = var.managed_disk_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version1
  }

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# One data disk per VM.
resource "azurerm_managed_disk" "data_disk" {
  for_each = var.virtual_machines

  name                 = each.value.data_disk_name
  location             = var.location
  resource_group_name  = var.rgvm
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = 64
  zone                 = "1"

  tags = {
    AppId              = var.AppId
    environment        = var.environment
    DataClassification = var.DataClassification
    Role               = var.Role
    SupportGroup       = var.SupportGroup
  }
}

# Attach each data disk to its matching VM (paired by each.key).
resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  for_each = var.virtual_machines

  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[each.key].id
  lun                = 0
  caching            = "None"
}