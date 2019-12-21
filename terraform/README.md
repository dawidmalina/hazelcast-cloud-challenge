## Dependencies

| Name | Versions |
|:--------:|:-----------:|
| terraform | \>= 0.12.0
| provider : aws | ~> 2.43
| provider : local | ~> 1.2
| provider : null | ~> 2.1
| provider : template | ~> 2.1
| provider : kubernetes | ~> 1.10
| provider : helm | ~> 0.10

## Variables

| Variable | Default | Description | Type |
|:--------:|:-------:|:-----------:|:----:|
| AWS_REGION | eu-central-1 | Provide aws region | string |
| CLUSTER_VERSION | 1.14 | Provide EKS cluster version, ex '1.14' | string |
| ENVIRONMENT_TYPE | dev | Provide type of the environment | string |
| INSTANCE_TYPE | t3.medium | Provide EKS node instance type, ex 't3.medium' | string |
| KUBECONFIG_PATH | None | Provide kubeconfig path | string |
| MONITORING_BASIC_AUTH | | Provide basic auth generated with `htpasswd auth <user>` for monitoring tools | string |
| NODE_GROUP_SIZE | 3 | Provide EKS node group size, '3' | string |
| PRIVATE_SUBNETS | [] | Provide list of application cidr bloks per availability zones, ex ['10.1.10.0/24'] | list(string) |
| PROJECT_NAME | | Provide name of the project | string |
| PUBLIC_SUBNETS | [] | Provide list of public cidr bloks per availability zones, ex ['10.1.1.0/24'] | list(string) |
| VPC_CIDR_BLOCK | 10.1.0.0/24 | Provide aws cidr block for whole vpc | string |


## Outputs

| Output | Description |
|:--------:|:-----------:|
| info | Basic information related to provisioned environment |
