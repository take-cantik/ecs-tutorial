# ------------------
# VPC
# ------------------
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.5.0"

  name = "${var.project_name}-${var.environment}-vpc"
  cidr = "10.0.0.0/16"

  azs = [var.az_a, var.az_c]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.10.0/24", "10.0.20.0/24"]
  database_subnets = ["10.0.110.0/24", "10.0.120.0/24"]

  create_database_subnet_group = true

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Project = var.project_name
    Environment = var.environment
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "nat_gateway_ips" {
  value = module.vpc.nat_public_ips
}
