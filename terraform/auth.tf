resource "kubernetes_secret" "monitoring_basic_auth" {
  metadata {
    name      = "monitoring-basic-auth"
    namespace = "monitoring"
  }

  data = {
    auth = var.MONITORING_BASIC_AUTH
  }

}