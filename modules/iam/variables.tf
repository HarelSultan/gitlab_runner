variable "instance_role_name" {
  description = "Name of the IAM role to be attached to the provisioned instance"
  type        = string
}

# TODO: Will be changed to custom policies instead of full access
# ? Consider how to support dynamic policies attachments

variable "s3_access_policy_arn" {
  description = "ARN of the S3 Access policy. Used to access the remote state"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

variable "dynamo_access_policy_arn" {
  description = "ARN of the DynamoDB Access policy. Used to access state locking"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

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
