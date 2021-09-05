resource "kubernetes_namespace" "dev-monitoring" {
  metadata {
    annotations = {
      name = "dev-monitoring"
    }

    name = "monitoring"
  }
}