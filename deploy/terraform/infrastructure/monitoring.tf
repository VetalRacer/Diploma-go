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
    labels = {
      grafana_dashboard = "k8s-overview"
    }
  }
  data = {
    "k8s.json" = "${file("${path.module}/files/dashboards/k8s.json")}"
  }
}