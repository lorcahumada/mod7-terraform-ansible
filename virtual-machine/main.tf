resource "azurerm_resource_group" "rg-principal" {
  name     = var.rg_name
  location = var.global_location
  tags = {
    "diplomado" = "klorca"
    "grupo"     = "grupo6"
  }
}

resource "azurerm_public_ip" "pip-jenkins" {
  name                = "pip-vm-jenkins"
  resource_group_name = azurerm_resource_group.rg-principal.name
  location            = azurerm_resource_group.rg-principal.location
  allocation_method   = "Static"

}

resource "azurerm_virtual_network" "vnet-jenkins" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg-principal.location
  resource_group_name = azurerm_resource_group.rg-principal.name
}

resource "azurerm_subnet" "subnet-jenkins" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg-principal.name
  virtual_network_name = azurerm_virtual_network.vnet-jenkins.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_interface" "nic-jenkins" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg-principal.location
  resource_group_name = azurerm_resource_group.rg-principal.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-jenkins.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-jenkins.id
  }
}


resource "azurerm_linux_virtual_machine" "vm-jenkins" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg-principal.name
  location            = azurerm_resource_group.rg-principal.location
  size                = "Standard_B1s"
  network_interface_ids = [
    azurerm_network_interface.nic-jenkins.id,
  ]

  computer_name                   = "hostname"
  admin_password                  = var.vm_password
  admin_username                  = var.vm_username
  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
