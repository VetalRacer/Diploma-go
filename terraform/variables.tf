#Service Principle for AKS
variable "arm_client_id" {}
variable "arm_client_secret" {}

variable "registry_server" {
    default = "diplomacontainerregistry.azurecr.io"
}

variable "registry_username" {
    default = "diplomacontainerregistry"
}

variable "registry_password" {}