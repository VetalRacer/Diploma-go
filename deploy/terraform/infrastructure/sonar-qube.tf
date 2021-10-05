resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://oteemo.github.io/charts"
  chart      = "sonarqube"
  namespace  = "qgate"
  version = "9.6.6"
  reuse_values = "true"
  atomic = "true"
}