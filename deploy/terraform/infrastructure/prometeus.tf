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
}

resource "helm_release" "cm" {
  name       = "cm"
  chart      = "../../helm-charts/monitoring"
  #values     = [templatefile("../../helm-charts/app/nhl/${var.values_name}.yaml", {})]
  namespace  = "monitoring"
  reuse_values = "true"
  atomic = "true"
}

resource "kubernetes_config_map" "example" {
  metadata {
    name = "my-config"
  }

  data = {
    "my_config_file.yml" = "../../helm-charts/monitoring/templates/configmap.yml"
  }
}