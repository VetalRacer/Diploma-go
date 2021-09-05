resource "kubernetes_namespace" "prod-env" {
  metadata {
    annotations = {
      name = "prod-env"
    }

    name = "production"
  }
}

resource "kubernetes_namespace" "dev-env" {
  metadata {
    annotations = {
      name = "dev-env"
    }

    name = "develop"
  }
}