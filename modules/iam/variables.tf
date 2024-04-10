variable "instance_role_name" {
  description = "Name of the IAM role to be attached to the provisioned instance"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name used to store terraform remote state"
  type = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB Table name used for state locking"
  type = string
}

# TODO: Will be changed to custom policies instead of full access
# ? Consider how to support dynamic policies attachments

variable "ec2_access_policy_arn" {
  description = "ARN of the EC2 Access policy. Used to provision instances"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

variable "vpc_access_policy_arn" {
  description = "ARN of the VPC Access policy. Used to provision networking resources"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

variable "iam_access_policy_arn" {
  description = "ARN of the IAM Access policy. Used to provision IAM entities and attach policies"
  type = string
  default = "arn:aws:iam::aws:policy/IAMFullAccess"
}
