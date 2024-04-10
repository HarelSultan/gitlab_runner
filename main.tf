module "networking" {
  source = "./modules/networking"
}

module "iam" {
  source             = "./modules/iam"
  instance_role_name = var.runner_role_name
  s3_access_policy_arn = var.s3_access_policy_arn
  dynamo_access_policy_arn = var.dynamo_access_policy_arn
}

module "compute" {
  source                    = "./modules/compute"
  instance_profile_name     = module.iam.instance_profile_name
  vpc_id                    = module.networking.vpc_id
  public_subnet_id          = module.networking.subnet_id
  inbound_ssh_cidr          = var.inbound_ssh_cidr
  outbound_traffic_cidr     = var.outbound_traffic_cidr
  outbound_traffic_protocol = var.outbound_traffic_protocol
  instnace_ami              = var.instnace_ami
  instance_type             = var.instance_type
  key_name                  = var.key_name
}