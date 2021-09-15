#Service Principle for AKS
variable "arm_client_id" {}
variable "arm_client_secret" {}

variable "db_pass" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "registry_server" {
    default = "diplomacontainerregistry.azurecr.io"
}

variable "registry_username" {
    default = "diplomacontainerregistry"
}

#variable "registry_password" {}