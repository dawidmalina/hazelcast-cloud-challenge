##
# Define environment eks cluster configuration
##
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "7.0.1"

  cluster_name    = local.cluster_name
  cluster_version = var.CLUSTER_VERSION
  kubeconfig_name = "kubeconfig"

  subnets = module.vpc.private_subnets
  vpc_id  = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "${local.cluster_name}-worker-group"
      instance_type                 = var.INSTANCE_TYPE
      asg_desired_capacity          = var.NODE_GROUP_SIZE
      additional_security_group_ids = [module.security_group_alb_to_worker_group.this_security_group_id]
      target_group_arns             = module.alb.target_group_arns
    }
  ]

  tags = {
    Name        = "${local.cluster_name}-eks"
    Terraform   = "true"
    Environment = var.ENVIRONMENT_TYPE
    Project     = var.PROJECT_NAME
  }
}