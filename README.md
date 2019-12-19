# K8S Cluster with monitoring, ingress and Vault

## Prerequisities

Procedure requires several components which must be installed (available) on your local machine, before we can continue with the installation.

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [terraform](https://www.terraform.io/downloads.html)
- [helm](https://helm.sh/docs/intro/install/)

> Installation of those components is out of scope of this document so please proceed with official documentation where all required steps are precisely described

## Main Requirments:

- Bootstrap K8S cluster with kubeadm with monitoring, ingress and Vault

## Non Functional Requirements

- Installation of all components should be automated with Terraform
- Helm should be used as package manager for K8S addons installation
- Prometheus and Alertmanager should be protected by authentication
- Monitoring should be installed with a pre-configured alert to notify a responsible person for any pod that has more than 10% Memory usage
- Alertmanager notifications should be send to the endpoint https://hazelcast-cloud-challenge.herokuapp.com/challenge_events with the POST method (body should includes pod information)
- All passwords should be stored in the Vault
- All configuration and infrastructure description should be kept in the git repository
