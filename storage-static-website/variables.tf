variable "client_secret" {
  type    = string
  sensitive = true
}

variable "subscription_id" {
  type    = string
  sensitive = true
}

variable "client_id" {
  type    = string
  sensitive = true
}

variable "tenant_id" {
  type    = string
  sensitive = true
}

variable "location" {
  type    = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}
