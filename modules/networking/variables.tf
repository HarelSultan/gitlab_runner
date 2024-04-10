variable "vpc_cidr_block" {
  description = "CIDR Block for VPC."
  type        = string
  default     = "10.0.0.0/20"
}

variable "public_subnet_cidr" {
  description = "CIDR Block for VPC."
  type        = string
  default     = "10.0.1.0/24"
}

variable "map_public_ip" {
  description = "Indicates whether instances launched in this subnet receive a public IPv4 address."
  type        = bool
  default     = true
}

variable "rt_cidr_block" {
  description = "CIDR Block for outbound traffic"
  type        = string
  default     = "0.0.0.0/0"
}