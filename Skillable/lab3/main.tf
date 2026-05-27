## Task 1

## Task 2

## Task 3

## Task 4
/*
resource "azurerm_public_ip" "Lab3_Public_IP" {
  name                    = "Lab3-Public-IP"
  location                = azurerm_resource_group.RG_3.location
  resource_group_name     = azurerm_resource_group.RG_3.name
  sku = "Standard"
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "Lab3_Nic" {
  name                = "Lab3-Nic"
  location            = azurerm_resource_group.RG_3.location
  resource_group_name = azurerm_resource_group.RG_3.name

  ip_configuration {
    name                          = "Lab3_IP"
    subnet_id                     = azurerm_subnet.Lab3_Subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Lab3_Public_IP.id
  }
}

resource "azurerm_windows_virtual_machine" "Lab3_vm" {
  name                = "VM3"
  resource_group_name = azurerm_resource_group.RG_3.name
  location            = azurerm_resource_group.RG_3.location
  size                = "Standard_B2S"
  admin_username      = "TFadminuser"
  admin_password      = "TFP@$$w0rd1234!"
  network_interface_ids = [azurerm_network_interface.Lab3_Nic.id]
 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
*/

