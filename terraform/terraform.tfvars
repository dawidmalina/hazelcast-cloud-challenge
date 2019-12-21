##
# define aws region
##
AWS_REGION = "eu-central-1"

##
# define project name
##
PROJECT_NAME = "malina"

##
# define type of the environment
##
ENVIRONMENT_TYPE = "test"

##
# define vpc cidr block (network range)
##
VPC_CIDR_BLOCK = "10.10.0.0/16"

##
# define public network cidr bloks per az
##
PUBLIC_SUBNETS = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24"]

##
# define application network cidr bloks per az
##
PRIVATE_SUBNETS = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]

##
# define local kubeconfig file path
##
# KUBECONFIG_PATH = "~/.kube/config"

##
# define basic auth secret generatede with htpasswd
##
MONITORING_BASIC_AUTH = "admin:$apr1$rUY2gZ12$TSsC67tcL2S9TW3SKwdTD1"

##
# define ingress domain (alb)
##
MONITORING_INGRESS_DOMAIN = "http://test.malina.local"