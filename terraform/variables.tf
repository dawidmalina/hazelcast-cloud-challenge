variable "KUBECONFIG_PATH" {
  default     = "~/.kube/config"
  description = "Provide kubeconfig path"
}

variable "MONITORING_BASIC_AUTH" {
  description = "Provide basic auth generated with `htpasswd auth <user>` for monitoring tools"
}

variable "MONITORING_INGRESS_DOMAIN" {
  description = "Provide ingress domain for prometheus, ex http://test.malina.local"
}
