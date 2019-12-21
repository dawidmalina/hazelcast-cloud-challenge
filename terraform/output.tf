output "info" {
  value = <<OUTPUT


- Custer Name           :: ${local.cluster_name}
- ID                    :: ${module.vpc.vpc_id}
- Region                :: ${var.AWS_REGION}
- Availability Zones    :: ${join(", ", module.vpc.azs)}

Subnets:
- Public                :: ${join(", ", module.vpc.public_subnets)}
- Private               :: ${join(", ", module.vpc.private_subnets)}

Monitoring:
- Prometheus            :: http://${module.alb.this_lb_dns_name}/prometheus
- Alertmanager          :: http://${module.alb.this_lb_dns_name}/prometheus

EKS:
- ID                    :: ${module.eks.cluster_id}
- Cluster Version       :: ${module.eks.cluster_version}
- Cluster Endpoint      :: ${module.eks.cluster_endpoint}

Management:
- Node Status           :: kubectl --kubeconfig kubeconfig* get nodes
- Pods Status           :: kubectl --kubeconfig kubeconfig* get pods --all-namespaces

OUTPUT

}