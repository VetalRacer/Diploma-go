provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "app" {
  name       = "app"
  chart      = "../../deploy/helm-charts/app/nhl"
  values     = [templatefile("../../deploy/helm-charts/app/nhl/values.dev.yaml", {})]
  namespace  = "develop"
  force_update = "true"
  atomic = "true"

}