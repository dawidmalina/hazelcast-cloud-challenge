# K8S Cluster with monitoring, ingress and Vault

## Prerequisities

Procedure requires several components which must be installed (available) on your local machine, before we can continue with the installation.

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [terraform](https://www.terraform.io/downloads.html)
- [kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
- [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration)

> Installation of those components is out of scope of this document so please proceed with official documentation where all required steps are precisely described

## Main Requirments:

- Bootstrap K8S cluster based on EKS with monitoring, ingress and Vault

## Non Functional Requirements

- Installation of all components should be automated with Terraform
- Helm should be used as package manager for K8S addons installation
- Prometheus and Alertmanager should be protected by authentication
- Monitoring should be installed with a pre-configured alert to notify a responsible person for any pod that has more than 10% Memory usage
- Alertmanager notifications should be send to the endpoint https://hazelcast-cloud-challenge.herokuapp.com/challenge_events with the POST method (body should includes pod information)
- All passwords should be stored in the Vault
- All configuration and infrastructure description should be kept in the git repository

## Implementation

Installation process is fully managed by terraform and provided default allows you to have fully running kubernetes cluster based on eks deployed in `eu-central-1` aws region.

The minimal setup can be easily and softly applied but make sure that all prerequisites are installed and configured.

### Installation steps:

Clone git repository
```
git clone https://github.com/dawidmalina/hazelcast-cloud-challenge.git
```

Go to directory where all terraform configuration are located
```
cd hazelcast-cloud-challenge/terraform
```

> Adjust your configuration in `terraform.tfvars` (but as mentioned it is not mandatory)

Make sure all terraform modules are in place
```
terraform get -update
```

Initialise terraform environment
```
terraform init
```

Validate changes proposed by the terraform
```
terraform plan
```

Apply proposed changes
```
terraform plan
```

> Double check if proposed changes are valid and if yes confirm change

> This process might take several minutes before it will be fully completed

At the end you should see output similar to this:
```
Outputs:

info =

- Custer Name           :: hazelcast-challenge
- ID                    :: vpc-07b953974a8e1568a
- Region                :: eu-central-1
- Availability Zones    :: eu-central-1a, eu-central-1b, eu-central-1c

Subnets:
- Public                :: subnet-0f697da3cb1ec82a6, subnet-07aa87bd43b9dd419, subnet-04b3af46f6f082f65
- Private               :: subnet-0c465e6c552d1b63f, subnet-050b202a45dc9e5ea, subnet-0000a032c0f0f9389

Monitoring:
- Prometheus            :: http://hazelcast-challenge-alb-1707379743.eu-central-1.elb.amazonaws.com/prometheus
- Alertmanager          :: http://hazelcast-challenge-alb-1707379743.eu-central-1.elb.amazonaws.com/prometheus

EKS:
- ID                    :: hazelcast-challenge
- Cluster Version       :: 1.14
- Cluster Endpoint      :: https://E65886AD525EE6D71CAE514238EBA049.gr7.eu-central-1.eks.amazonaws.com

Management:
- Node Status           :: kubectl --kubeconfig kubeconfig* get nodes
- Pods Status           :: kubectl --kubeconfig kubeconfig* get pods --all-namespaces
```

Apply hotfix for kube-proxy
```
kubectl --kubeconfig kubeconfig* -n kube-system get cm kube-proxy-config -o yaml |sed 's/metricsBindAddress: 127.0.0.1:10249/metricsBindAddress: 0.0.0.0:10249/' | kubectl --kubeconfig kubeconfig* apply -f -
kubectl --kubeconfig kubeconfig* -n kube-system patch ds kube-proxy -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"updateTime\":\"`date +'%s'`\"}}}}}"
```

Decommission environment
```
terraform destroy
```
> Double check if this is what you want and if yes confirm action


## Known Issues (not implemented tasks)

- Kube-proxy require extra hotfix (https://github.com/aws/containers-roadmap/issues/657)
- Helm2 is used as terraform provider is not yet ready (https://github.com/terraform-providers/terraform-provider-helm/pull/378)
- Vault is not configured and is not storing any secrets as expected
- No TLS for ingress and custom domain
- Environment still require small hardening (ip whitelisting, strict security groups, etc)
- Terraform is not using any remote state configuration