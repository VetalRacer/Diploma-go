resource "helm_release" "ingress-controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "nginx-ingress"
  reuse_values = "true"
  atomic = "true"

  set {
    name  = "controller.service.loadBalancerIP"
    value = "20.76.245.249"
  }

  set {
    name  = "controller.service.annotations\\.service.beta.kubernetes.io/azure-load-balancer-resource-group"
    value = "Diploma-rg"
    type  = "string"
  }

}