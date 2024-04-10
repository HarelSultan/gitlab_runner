# General
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "Profile used to authenticate with aws provider"
  type        = string
  default     = "default"
}

variable "common_tags" {
  description = "Common tags to attach when provisioning resources"
  type        = map(string)
  default = {
    Owner           = "harels"
    bootcamp        = "19"
    expiration_date = "30-12-24"
    managed_by      = "Terraform"
  }
}

# Networking

# IAM
variable "runner_role_name" {
  description = "Name of the IAM role to be attached to the GitLab-Runner instance"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name used to store terraform remote state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB Table name used for state locking"
  type        = string
}

# Compute
variable "inbound_ssh_cidr" {
  description = "CIDR block from which is allowed to connect via ssh"
  type        = string
}

variable "outbound_traffic_cidr" {
  description = "CIDR block outbound traffic allowed to"
  type        = string
}

variable "outbound_traffic_protocol" {
  description = "Protocol of the allowed outbound traffic"
}

variable "instnace_ami" {
  description = "Amazon Machine image used to create EC2 instance"
  type        = string
  default     = "ami-0f403e3180720dd7e"
}

variable "instance_type" {
  description = "Type of instance to provision"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key used to connect to the instance"
  type        = string
}
