resource "kubernetes_namespace" "nginx-ingress" {
  metadata {
    annotations = {
      name = "nginx-ingress"
    }

    name = "nginx-ingress"
  }
}

resource "helm_release" "ingress-controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "nginx-ingress"
  reuse_values = "true"
  atomic = "true"

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.default.ip_address
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = "Diploma-rg"
  }

  depends_on = [
    kubernetes_namespace.nginx-ingress
  ]

}