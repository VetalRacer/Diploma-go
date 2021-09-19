#Service Principle for AKS
variable "arm_client_id" {}
variable "arm_client_secret" {}

variable "db_pass" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "registry_url" {
    description = "Azure Registry URL"
}

variable "registry_user" {
    description = "Azure Registry user"
}