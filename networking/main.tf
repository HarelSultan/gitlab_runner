data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az          = data.aws_availability_zones.available.names[0]
  project_tag = "harel_gitlab_runner"
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "${local.project_tag}_vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${local.project_tag}_igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = local.az
  map_public_ip_on_launch = var.map_public_ip
  tags = {
    "Name" = "${local.project_tag}_public_subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    "Name" = "${local.project_tag}_public_rt"
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public.id
}