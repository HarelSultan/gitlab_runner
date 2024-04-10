locals {
  project_tag = "harel_gitlab_runner"
}

resource "aws_security_group" "allow_inbound_ssh" {
  name        = "allow_inbound_ssh"
  description = "Security group allowing inbound ssh connections to the instance"
  vpc_id      = var.vpc_id
  #   tags = {}
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_ssh_rule" {
  security_group_id = aws_security_group.allow_inbound_ssh.id
  #   Consider restricting connection from a specific IP
  cidr_ipv4   = var.inbound_ssh_cidr
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_security_group" "allow_outbound_traffic" {
  name        = "allow_outbound_traffic"
  description = "Security group allowing all outbound traffic from the instance"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic_rule" {
  # Consider limiting the cidr and ip protocol to be more specific
  security_group_id = aws_security_group.allow_outbound_traffic.id
  cidr_ipv4         = var.outbound_traffic_cidr
  ip_protocol       = var.outbound_traffic_protocol
}

resource "aws_instance" "gitlab_runner" {
  ami           = var.instnace_ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name
  iam_instance_profile = var.instance_profile_name
  vpc_security_group_ids = [ aws_security_group.allow_inbound_ssh.id, aws_security_group.allow_outbound_traffic.id ]
  user_data = file("${path.module}/init.sh")

  tags = {
    "Name" = "${local.project_tag}"
  }
}

