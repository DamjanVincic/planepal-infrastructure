variable "environment" {
  type        = string
  description = "Name of Environment"
}

variable "resource_group" {
  type = string
}

variable "location" {
  type        = string
  description = "location where our resource needs provisioning in azure"
}

variable "app_name" {
  type        = string
  description = "Name of Application"
}

variable "subneta_id" {
  type = string
}

variable "location_abbreviation" {
  type = string
}
variable "levi9_public_ip" {
  type    = string
}
variable "as_addr_prefixes" {
    
}

resource "azurerm_virtual_machine" "main" {
  name                  = "vm-${lower(var.app_name)}-${var.environment}-00"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.net_int.id]
  vm_size               = "D2s_v3"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
}

resource "azurerm_network_interface" "net_int" {
  name                = "nic-${var.app_name}-${var.environment}-${var.location_abbreviation}-00"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  var.subneta_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "nsg-vm-${lower(var.app_name)}-${var.environment}-${var.location}-01"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.levi9_public_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "web_app"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.as_addr_prefixes[0]
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "vm_nsg_assoc" {
  subnet_id                 = var.subneta_id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}