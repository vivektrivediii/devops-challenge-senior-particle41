provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket  = "vivek-poc-tf-state"
    key     = "vivek-poc-tf/terraform.tfstate"
    region  = "us-east-1"
  }
}