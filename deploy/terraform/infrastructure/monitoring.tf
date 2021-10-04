resource "helm_release" "prometeus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  reuse_values = "true"
  atomic = "true"

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

resource "kubernetes_ingress" "grafana_ingress" {
  metadata {
    name = "grafana-ingress"
  }

  spec {
    rule {
      host = grafana.hgest.ru
      http {
        path {
          backend {
            service_name = "kube-prometheus-stack-grafana"
            service_port = 8080
          }

          path = "/"
        }
      }
    }
  }
}