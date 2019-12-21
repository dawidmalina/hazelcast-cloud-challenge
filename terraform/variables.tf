locals {
  cluster_name = "${lower(var.PROJECT_NAME)}-${lower(var.ENVIRONMENT_TYPE)}"
}

variable "AWS_REGION" {
  description = "Provide aws region"
  default     = "eu-central-1"
}

variable "ENVIRONMENT_TYPE" {
  description = "Provide type of the environment"
  default     = "dev"
}

variable "PROJECT_NAME" {
  description = "Provide name of the project"
}

variable "VPC_CIDR_BLOCK" {
  description = "Provide aws cidr block for whole vpc"
  default     = "10.1.0.0/24"
}

variable "PUBLIC_SUBNETS" {
  default     = []
  description = "Provide list of public cidr bloks per availability zones, ex ['10.1.1.0/24']"
  type        = list(string)
}

variable "PRIVATE_SUBNETS" {
  default     = []
  description = "Provide list of application cidr bloks per availability zones, ex ['10.1.10.0/24']"
  type        = list(string)
}

variable "CLUSTER_VERSION" {
  default     = "1.14"
  description = "Provide EKS cluster version, ex '1.14'"
}

variable "INSTANCE_TYPE" {
  default     = "t3.medium"
  description = "Provide EKS node instance type, ex 't3.medium'"
}

variable "NODE_GROUP_SIZE" {
  default     = "3"
  description = "Provide EKS node group size, '3'"
}

variable "KUBECONFIG_PATH" {
  default     = null
  description = "Provide kubeconfig path"
}

variable "MONITORING_BASIC_AUTH" {
  description = "Provide basic auth generated with `htpasswd auth <user>` for monitoring tools"
}

variable "MONITORING_INGRESS_DOMAIN" {
  description = "Provide ingress domain for prometheus, ex http://test.malina.local"
}
