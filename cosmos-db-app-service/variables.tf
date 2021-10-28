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

variable "cors_origin" {
  type    = string
}

variable "root_password" {
  type    = string
  sensitive = true
}

variable "container_registry_name" {
  type    = string
}

variable "container_registry_resource_group" {
  type    = string
}

variable "container_image" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "app_service_plan_name" {
  type = string
}
