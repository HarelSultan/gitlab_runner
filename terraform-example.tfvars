runner_role_name          = "harel_git_lab_runner"
inbound_ssh_cidr          = "0.0.0.0/0"
outbound_traffic_cidr     = "0.0.0.0/0"
outbound_traffic_protocol = -1
instnace_ami              = "ami-0f403e3180720dd7e"
instance_type             = "t2.micro"
key_name                  = "your_ssh_key"
s3_bucket_name            = "your_s3_bucket_name"
dynamodb_table_name       = "your_dynamodb_table_name"