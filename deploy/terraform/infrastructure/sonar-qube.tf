resource "kubernetes_namespace" "quality-gate" {
  metadata {
    annotations = {
      name = "quality-gate"
    }

    name = "qgate"
  }
}r

esource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://oteemo.github.io/charts"
  chart      = "sonarqube"
  namespace  = "quality-gate"
  version = "9.6.6"
  reuse_values = "true"
  atomic = "true"
}