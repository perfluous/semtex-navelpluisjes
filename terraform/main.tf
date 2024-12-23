# main.tf

# Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Reference the managed image created by Packer
data "azurerm_image" "navelpluisjes_image" {
  name                = var.managed_image_name
  resource_group_name = var.resource_group_name
}

# Create a Network
resource "azurerm_virtual_network" "main" {
  name                = "<...>"
  address_space       = ["<....>"]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "<...>"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["<....>"]
}

# Create a Public IP
resource "azurerm_public_ip" "main" {
  name                = "<...>"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}

# Create a Network Interface
resource "azurerm_network_interface" "main" {
  name                = "<...>"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "<...>"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "<...>"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# Create the VM
resource "azurerm_linux_virtual_machine" "main" {
  name                = "<...>"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password  # Or use SSH key authentication

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  source_image_id = data.azurerm_image.navelpluisjes_image.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "<...>"
  }

  # Optional: Custom data or cloud-init script
  # custom_data = file("cloud-init.yml")
}

# Open port 22 for SSH access (adjust as needed)
resource "azurerm_network_security_group" "main" {
  name                = "<...>"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "<...>"
    priority                   = 1001
    direction                  = "<...>"
    access                     = "<...>"
    protocol                   = "<...>"
    source_port_range          = "*" # TODO: You know what to do
    destination_port_range     = "<...>"
    source_address_prefix      = "*"  # TODO: You know what to do
    destination_address_prefix = "*" # TODO: You know what to do
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}
