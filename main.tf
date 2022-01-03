provider "aws" {
  region = var.region
}

module "aws_infrastructure" {
  source = "./modules/aws"

  name = var.name 
  tfuser = var.tfuser
}