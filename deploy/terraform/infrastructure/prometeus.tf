provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "app" {
  name       = "kube-prometheus-stack"
  repository = "https://github.com/prometheus-community/helm-charts/tree/main/charts"
  chart      = "kube-prometheus-stack"
  namespace  = monitoring
  #reuse_values = "true"
  #atomic = "true"
}