resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = "dev-monitoring"
    }

    name = "monitoring"
  }
}

resource "helm_release" "prometeus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  reuse_values = "true"
  atomic = "true"

  depends_on = [
    kubernetes_namespace.monitoring
  ]

}

resource "kubernetes_config_map" "config" {
  metadata {
    namespace = "monitoring"
    name = "grafana-k8s-overview"
    labels = {
      grafana_dashboard = "1"
    }
  }
  data = {
    "k8s.json" = "${file("${path.module}/files/dashboards/k8s.json")}"
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]

}

resource "kubernetes_ingress" "grafana_ingress" {
  metadata {
    namespace = "monitoring"
    name = "grafana-ingress"
    annotations = {
      "enable-vts-status" = "true"
      "kubernetes.io/ingress.class" = "nginx"
      "nginx.ingress.kubernetes.io/proxy-body-size" = "15m"
      "nginx.ingress.kubernetes.io/proxy-buffer-size" = "16k"
      "nginx.ingress.kubernetes.io/ssl-ciphers" = "ALL:!aNULL:!EXPORT56:RC4+RSA:+HIGH"
      "nginx.org/proxy-hide-headers" = "Server, X-Powered-By, X-AspNet-Version, X-AspNet-Mvc-Version"
      "nginx.org/server-tokens" = "False"
      "prometheus.io/port" = "10254"
      "prometheus.io/scrape" = "true"
    }
  }

  spec {
    rule {
      host = "grafana.hgest.ru"
      http {
        path {
          backend {
            service_name = "kube-prometheus-stack-grafana"
            service_port = 80
          }

          path = "/"
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
  
}