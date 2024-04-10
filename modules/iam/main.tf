locals {
  iam_policies_arn = [var.s3_access_policy_arn, var.dynamo_access_policy_arn, var.ec2_access_policy_arn, var.vpc_access_policy_arn]
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

resource "aws_iam_role_policy_attachment" "iam_policies" {
  for_each   = toset(local.iam_policies_arn)
  policy_arn = each.value
  role       = aws_iam_role.instance_role.name
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.instance_role_name}_profile"
  role = aws_iam_role.instance_role.name
}

# resource "aws_iam_role_policy_attachment" "s3_state_access" {
#   policy_arn = var.s3_access_policy_arn
#   role       = aws_iam_role.instance_role.name
# }

# resource "aws_iam_role_policy_attachment" "dynamodb_state_lock_access" {
#   policy_arn = var.dynamo_access_policy_arn
#   role       = aws_iam_role.instance_role.name
# }

# resource "aws_iam_role_policy_attachment" "ec2_access" {
#   policy_arn = var.ec2_access_policy_arn
#   role       = aws_iam_role.instance_role.name
# }

# resource "aws_iam_role_policy_attachment" "vpc_access" {
#   policy_arn = var.vpc_access_policy_arn
#   role       = aws_iam_role.instance_role.name
# }
