variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "region_id" {
  description = "Region"
  # Значение по умолчанию
  default = "ru-central1"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "network_id" {
  description="network"
}
variable "count_inst" {
  description = "Количество интсансов"
  default     = 1
}
