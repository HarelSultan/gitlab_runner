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
