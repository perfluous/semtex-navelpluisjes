# navelpluisjes.pkr.hcl

packer {
  required_plugins {
    azure-arm = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure/arm"
    }
    salt-masterless = {
      version = ">= 0.1.2"
      source  = "github.com/mpoore/salt"
    }
  }
}

# Variables for Azure credentials and configurations
variable "azure_subscription_id" {
  type    = string
  default = "<...>"
}

variable "azure_client_id" {
  type    = string
  default = ""  # Left empty to use environment variable
}

variable "azure_client_secret" {
  type    = string
  default = ""  # Left empty to use environment variable
}

variable "azure_tenant_id" {
  type    = string
  default = "<...>"
}

variable "resource_group_name" {
  type    = string
  default = "<...>"
}

variable "managed_image_name" {
  type    = string
  default = "<...>"
}

variable "location" {
  type    = string
  default = "<...."
}

variable "vm_size" {
  type    = string
  default = "<...>"
}

# Source configuration
source "azure-arm" "navelpluisjes" {
  subscription_id                        = var.azure_subscription_id
  client_id                              = var.azure_client_id
  client_secret                          = var.azure_client_secret
  tenant_id                              = var.azure_tenant_id
  managed_image_resource_group_name      = var.resource_group_name
  managed_image_name                     = var.managed_image_name
  location                               = var.location
  vm_size                                = var.vm_size
  os_type                                = "Linux"

  # Base image details
  image_publisher                        = "openSUSE"
  image_offer                            = "Tumbleweed"
  image_sku                              = "latest"

  # Temporary resource group for build
  temp_resource_group_name               = "<...>"

  # Use SSH to connect
  ssh_username                           = "<...>"
}

build {
  sources = ["<...>"]

  # Copy over SaltStack configurations
  provisioner "file" {
    source      = "saltstack/"
    destination = "/tmp/saltstack/"
  }

  # Copy Docker images into the Salt file server root
  provisioner "file" {
    source      = "<....>"
    destination = "<...>"
  }

  # Copy models into the Salt file server root
  provisioner "file" {
    source      = "<...>"
    destination = "<...>"
  }

  # SaltStack provisioner
  provisioner "salt-masterless" {
    local_state_tree   = "<...>
    local_pillar_roots = "<...>
    minion_config      = "<...>
  }

  # Final cleanup script (if you prefer to use a shell script)
  provisioner "shell" {
    script = "<...>
  }
}
