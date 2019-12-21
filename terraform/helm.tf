resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "terraform-tiller"
    namespace = "kube-system"
  }

  automount_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "terraform-tiller"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind = "ServiceAccount"
    name = "terraform-tiller"

    api_group = ""
    namespace = "kube-system"
  }

  depends_on = [kubernetes_service_account.tiller]
}

resource "helm_release" "ingress_nginx" {
  chart     = "stable/nginx-ingress"
  name      = "ingress-nginx"
  namespace = "ingress"

  values = [
    file("addons/ingress-nginx.yaml")
  ]

  depends_on = [kubernetes_cluster_role_binding.tiller]
}

resource "helm_release" "vault_operator" {
  chart     = "stable/vault-operator"
  name      = "vault-operator"
  namespace = "vault"

  values = [
    file("addons/vault-operator.yaml")
  ]

  depends_on = [kubernetes_cluster_role_binding.tiller]
}

resource "helm_release" "prometheus_operator" {
  chart     = "stable/prometheus-operator"
  name      = "prometheus-operator"
  namespace = "monitoring"

  values = [
    file("addons/prometheus-operator.yaml")
  ]

  depends_on = [kubernetes_cluster_role_binding.tiller]
}