# locals {
#   iam_policies_arn = [aws_iam_policy.s3_remote_state_policy.arn, aws_iam_policy.dynamodb_state_locking_policy.arn, var.ec2_access_policy_arn, var.vpc_access_policy_arn, var.iam_access_policy_arn]
# }

locals {
  iam_policies_arn = {
    s3_remote_state_policy        = aws_iam_policy.s3_remote_state_policy.arn,
    dynamodb_state_locking_policy = aws_iam_policy.dynamodb_state_locking_policy.arn,
    ec2_access_policy             = var.ec2_access_policy_arn,
    vpc_access_policy             = var.vpc_access_policy_arn,
    iam_access_policy             = var.iam_access_policy_arn
  }
}


resource "aws_iam_role" "instance_role" {
  name = var.instance_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_remote_state_policy" {
  name        = "s3_remote_state_policy"
  description = "Policy for accessing S3 to store terraform remote state"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketVersions",
          "s3:GetBucketVersioning",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketPolicy"
        ]
        Resource = "arn:aws:s3:::${var.s3_bucket_name}"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_state_locking_policy" {
  name        = "dynamodb_state_locking_policy"
  description = "Policy for accessing DynamoDB to utilize state locking capabilities"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ]
        Resource = "arn:aws:dynamodb:*:*:table/${var.dynamodb_table_name}"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:ListTables"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "iam_policies" {
  for_each   = local.iam_policies_arn
  policy_arn = each.value
  role       = aws_iam_role.instance_role.name
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.instance_role_name}_profile"
  role = aws_iam_role.instance_role.name
}
