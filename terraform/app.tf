resource "helm_release" "app" {
  name       = "app"
  chart      = "../deploy/helm-charts/app/nhl"
  #values     = [templatefile("../deploy/helm-charts/app/nhl/values.dev.yaml", {})]
  values     = "../deploy/helm-charts/app/nhl/values.dev.yaml"
  namespace  = "develop"
  force_update = "true"
  atomic = "true"

}