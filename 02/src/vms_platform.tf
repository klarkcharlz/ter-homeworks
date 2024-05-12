variable "vm_db_platform_id" {
    description = "The ID of the platform to use for the DB VM"
    type        = string
    default     = "standard-v3"
}

/*
variable "vm_db_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "netology-develop-platform-db"
}

variable "vm_web_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "netology-develop-platform-web"
}
*/

variable "vm_web_platform_id" {
  description = "The ID of the platform to use for the VM"
  type        = string
  default     = "standard-v3"
}

variable "vm_web_name" {
  description = "VM web name"
  type        = string
  default     = "web"
}

variable "vm_db_name" {
  description = "VM db name"
  type        = string
  default     = "db"
}

variable "vm_name_prefix" {
  description = "VM name prefix"
  type        = string
  default     = "netology-develop-platform"
}
