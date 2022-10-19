variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable "subnet_id" {
  description = "Subnets for modules"
}
variable "private_key_path" {
  description = "Path to the private key used for provisioners"
}
variable "nodes_count" {
  default = "2"
  description = "Number of nodes"
  }