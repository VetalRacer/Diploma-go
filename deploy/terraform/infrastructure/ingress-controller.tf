resource "helm_release" "ingress-controller" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  values     = ["${file("files/values/nginx-ingress.yml")}"]
  namespace  = "nginx-ingress"
  reuse_values = "true"
  atomic = "true"

  set {
    name  = "controller.service.loadBalancerIP"
    value = "20.76.232.143"
  }

 set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = "tf-storage-rg"
  }

}