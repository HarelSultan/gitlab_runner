variable "inbound_ssh_cidr" {
  description = "CIDR block from which is allowed to connect via ssh"
  type = string
}

variable "outbound_traffic_cidr" {
  description = "CIDR block outbound traffic allowed to"
  type = string
}

variable "outbound_traffic_protocol" {
  description = "Protocol of the allowed outbound traffic"
}

variable "vpc_id" {
  description = "ID of the VPC to be associated with"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "instnace_ami" {
  description = "Amazon Machine image used to create EC2 instance"
  type        = string
  default     = "ami-0f403e3180720dd7e"
}

variable "instance_type" {
  description = "Type of instance to provision"
  type        = string
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the key used to connect to the instance"
  type        = string
}
