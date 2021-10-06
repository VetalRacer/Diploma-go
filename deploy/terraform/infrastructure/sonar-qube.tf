resource "kubernetes_namespace" "quality-gate" {
  metadata {
    annotations = {
      name = "quality-gate"
    }

    name = "quality-gate"
  }
}

resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://oteemo.github.io/charts"
  chart      = "sonarqube"
  namespace  = "quality-gate"
  version = "9.6.6"
  reuse_values = "true"
  atomic = "true"
}

resource "kubernetes_ingress" "sonar_ingress" {
  metadata {
    namespace = "quality-gate"
    name = "sonar-qube-ingress"
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
      host = "sonar-qube.hgest.ru"
      http {
        path {
          backend {
            service_name = "sonarqube-sonarqube"
            service_port = 9000
          }

          path = "/"
        }
      }
    }
  }
}