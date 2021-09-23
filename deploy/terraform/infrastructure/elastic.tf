resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  namespace  = "logging"
  version = "7.14.0"
  reuse_values = "true"
  atomic = "true" 
}

#resource "kubernetes_config_map" "config" {
#  metadata {
#    namespace = "logging"
#    name = "grafana-k8s-overview"
#    labels = {
#      grafana_dashboard = "k8s-overview"
#    }
#  }
#  data = {
#    "k8s.json" = "${file("${path.module}/dashboards/k8s.json")}"
#  }
#}