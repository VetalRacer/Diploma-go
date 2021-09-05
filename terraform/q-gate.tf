resource "kubernetes_namespace" "qgate-env" {
  metadata {
    annotations = {
      name = "qgate-env"
    }

    name = "qgate"
  }
}