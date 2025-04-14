locals {
  payload_database_cidr_rule = [
    {
      type         = "ingress"
      cidr_blocks  = ["10.1.0.0/16"]
      from_port    = 5432
      to_port      = 5432
      protocol     = "tcp"
      description  = "Allow postgres port within the VPC"
    },
    {
      type         = "egress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      description  = "Allow IPv4 all outbound traffic"
    }
  ]

  payload_private_cidr_rule = [
    {
      type         = "ingress"
      cidr_blocks  = ["10.1.0.0/16"]
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      description  = "Allow IPv4 all within the VPC"
    },
    {
      type         = "egress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      description  = "Allow IPv4 all outbound traffic"
    }
  ]

  payload_public_cidr_rule = [
    {
      type         = "ingress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 80
      to_port      = 80
      protocol     = "tcp"
      description  = "Allow HTTP traffic to inbound"
    },
    {
      type         = "ingress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      description  = "Allow HTTPs traffic to inbound"
    },
    {
      type         = "ingress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 5000
      to_port      = 5000
      protocol     = "tcp"
      description  = "Allow HTTPs traffic to inbound"
    },
    {
      type         = "egress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      description  = "Allow IPv4 all outbound traffic"
    }
  ]
}

module "private_sg" {
  source                = "./security-group"
  create                = true
  name                  = "vivek-poc-private-security-group"
  description           = "private security group for amazon studio project"
  vpc_id                = module.vpc.vpc_id
  source_cidr_block     = true
  source_cidr_rules     = local.payload_private_cidr_rule
  source_security_group = false
  source_self           = false

  tags  = {
    Environment = "development",
    Terraform = "True"
  }
}

module "public_sg" {
  source                = "./security-group"
  create                = true
  name                  = "vivek-poc-public-security-group"
  description           = "Public security group for amazon studio project"
  vpc_id                = module.vpc.vpc_id
  source_cidr_block     = true
  source_cidr_rules     = local.payload_public_cidr_rule
  source_security_group = false
  source_self           = false

  tags  = {
    Environment = "development",
    Terraform = "True"
  }
}