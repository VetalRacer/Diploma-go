resource "helm_release" "ingress-controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "nginx-ingress"
  reuse_values = "true"
  atomic = "true"
}