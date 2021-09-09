resource "helm_release" "app" {
  name       = "app"
  chart      = "deploy/helm-charts/app/nhl"
  #values     = "values.dev.yaml"
  namespace  = "develop"
  force_update = "true"
  atomic = "true"

  service_principal {
    client_id     = var.arm_client_id
    client_secret = var.arm_client_secret
  }

}