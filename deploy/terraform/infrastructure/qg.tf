resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://oteemo.github.io/charts"
  chart      = "sonarqube"
  namespace  = "qgate"
  version = "7.14.0"
  reuse_values = "true"
  atomic = "true"
}