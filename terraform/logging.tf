resource "kubernetes_namespace" "logging-env" {
  metadata {
    annotations = {
      name = "logging-env"
    }

    name = "logging"
  }
}
