# variables.tf

variable "prefix" {
  description = "Prefix for resource names"
  default     = "navelpluisjes"
}

variable "location" {
  description = "Azure region to deploy resources"
  default     = "<...>"
}

variable "admin_username" {
  description = "Admin username for the VM"
  default     = "<...>"
}

variable "ssh_public_key" {
  description = "Path to your SSH public key"
  default     = "<...>"
}

variable "vm_size" {
  description = "Azure VM size"
  default     = "<...>"
}
