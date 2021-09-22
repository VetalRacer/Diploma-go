provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

resource "helm_release" "prometeus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  reuse_values = "true"
  atomic = "true"

  #set {
  #  name  = "sidecar.dashboards.enabled"
  #  value = "true"
  #}

}

resource "kubernetes_config_map" "config" {
  metadata {
    namespace = "monitoring"
    name = "grafana-k8s-overview"
  }
  data {
    "config" = "${file(${path.module}/k8s.json)}"
  }
}