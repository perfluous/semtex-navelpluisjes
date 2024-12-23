# variables.tf

variable "azure_subscription_id" {
  type    = string
  default = ""  # Set your subscription ID or use environment variables
}

variable "azure_client_id" {
  type    = string
  default = ""  # Set your client ID or use environment variables
}

variable "azure_client_secret" {
  type    = string
  default = ""  # Set your client secret or use environment variables
}

variable "azure_tenant_id" {
  type    = string
  default = ""  # Set your tenant ID or use environment variables
}

variable "resource_group_name" {
  type    = string
  default = "<...>"
}

variable "location" {
  type    = string
  default = "<...<...>"
}

variable "vm_size" {
  type    = string
  default = "<...>"
}

variable "managed_image_name" {
  type    = string
  default = "<...>"
}

variable "admin_username" {
  type    = string
  default = "<...>"
}

variable "admin_password" {
  type    = string
  default = ""  # Use environment variables or secure methods to provide this
}
