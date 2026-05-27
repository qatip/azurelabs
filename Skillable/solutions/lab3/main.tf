## Task 1
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "your subscription id here"
}

# Create a resource group
resource "azurerm_resource_group" "RG_3" {
  name     = "RG3"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "Lab3_Vnet" {
  name                = "Lab3-Vnet"
  resource_group_name = azurerm_resource_group.RG_3.name
  location            = azurerm_resource_group.RG_3.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "Lab3_Subnet" {
  name                 = "Lab3-Subnet"
  resource_group_name  = azurerm_resource_group.RG_3.name
  virtual_network_name = azurerm_virtual_network.Lab3_Vnet.name
  address_prefixes     = ["10.1.1.0/24"]

}

## Task 2
resource "azurerm_route_table" "Lab3_Route_Table" {
  name                = "Lab3-Route-Table"
  location            = azurerm_resource_group.RG_3.location
  resource_group_name = azurerm_resource_group.RG_3.name

  route {
    name           = "Route-Local"
    address_prefix = "10.1.0.0/16"
    next_hop_type  = "VnetLocal"
  }

  route {
    name           = "Route-Internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "Lab3_Subnet_RTA" {
  subnet_id      = azurerm_subnet.Lab3_Subnet.id 
  route_table_id = azurerm_route_table.Lab3_Route_Table.id
}

## Task 3
resource "azurerm_network_security_group" "Lab3_Security_Group" {
  name                = "Lab3-Security-Group"
  location            = azurerm_resource_group.RG_3.location
  resource_group_name = azurerm_resource_group.RG_3.name

  security_rule {
    name                       = "WebAdminNSG"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "Lab3_NSG_Assoc" {
  subnet_id                 = azurerm_subnet.Lab3_Subnet.id
  network_security_group_id = azurerm_network_security_group.Lab3_Security_Group.id
}


## Task 4
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


