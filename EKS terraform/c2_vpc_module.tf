# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  # VPC Basic Details
  name           = var.vpc_name
  cidr           = var.vpc_cidr_block
  azs            = var.vpc_availability_zones
  public_subnets = var.vpc_public_subnets

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true
}
