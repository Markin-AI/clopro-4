###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "HW_Netology"
  description = "VPC network"
}

variable "default_zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_cidr_a" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr_a" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_subnet_a" {
  type        = string
  default     = "public_a"
  description = "subnet name"
}

variable "private_subnet_a" {
  type        = string
  default     = "private_a"
  description = "subnet name"
}

variable "default_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_cidr_b" {
  type        = list(string)
  default     = ["192.168.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr_b" {
  type        = list(string)
  default     = ["192.168.40.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_subnet_b" {
  type        = string
  default     = "public_b"
  description = "subnet name"
}

variable "private_subnet_b" {
  type        = string
  default     = "private_b"
  description = "subnet name"
}

variable "public_cidr_d" {
  type        = list(string)
  default     = ["192.168.50.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr_d" {
  type        = list(string)
  default     = ["192.168.60.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_subnet_d" {
  type        = string
  default     = "public_d"
  description = "subnet name"
}

variable "private_subnet_d" {
  type        = string
  default     = "private_d"
  description = "subnet name"
}

variable "vm_metadata" {
  type        = map(string)
  description = "Metadata map for VMs"
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID7Tv/k8eZPA441HJ+BwGoF02XXNadGqDQ4DWmB0JgAF markin@markin-VirtualBox"
  }
}