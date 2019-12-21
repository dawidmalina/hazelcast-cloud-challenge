##
# Define environment vpc configuration
##
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = "${local.cluster_name}-vpc"
  cidr = var.VPC_CIDR_BLOCK

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.PRIVATE_SUBNETS
  public_subnets  = var.PUBLIC_SUBNETS

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Name                                          = "${local.cluster_name}-vpc"
    Terraform                                     = "true"
    Environment                                   = var.ENVIRONMENT_TYPE
    Project                                       = var.PROJECT_NAME
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
