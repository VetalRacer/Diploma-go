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
    namespace = "monitoring"
    name = "grafana-ingress"
    annotations {
      enable-vts-status: "true"
      kubernetes.io/ingress.class: nginx
      meta.helm.sh/release-name: app
      meta.helm.sh/release-namespace: develop
      nginx.ingress.kubernetes.io/configuration-snippet: |
        more_set_headers "Server: ";
      nginx.ingress.kubernetes.io/proxy-body-size: 15m
      nginx.ingress.kubernetes.io/proxy-buffer-size: 16k
      nginx.ingress.kubernetes.io/ssl-ciphers: ALL:!aNULL:!EXPORT56:RC4+RSA:+HIGH
      nginx.org/proxy-hide-headers: Server, X-Powered-By, X-AspNet-Version, X-AspNet-Mvc-Version
      nginx.org/server-tokens: "False"
      prometheus.io/port: "10254"
      prometheus.io/scrape: "true"
    }
  }

  spec {
    rule {
      host = "grafana.hgest.ru"
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