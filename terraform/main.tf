module "vpc" {
  source = "./vpc"
  name            = var.vpc_name
  cidr            = var.vpc_cidr
  azs             = var.vpc_azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags = var.vpc_tags
}

