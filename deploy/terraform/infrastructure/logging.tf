resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  namespace  = "logging"
  version = "7.14.0"
  reuse_values = "true"
  atomic = "true"

  set {
    name  = "minimumMasterNodes"
    value = "0"
  }

  set {
    name  = "replicas"
    value = "1"
  }

}

resource "helm_release" "kibana" {
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  namespace  = "logging"
  version = "7.14.0"
  reuse_values = "true"
  atomic = "true"
}

resource "helm_release" "logstash" {
  name       = "logstash"
  repository = "https://helm.elastic.co"
  chart      = "logstash"
  namespace  = "logging"
  version = "7.14.0"
  reuse_values = "true"
  atomic = "true"
}

resource "helm_release" "filebeat" {
  name       = "filebeat"
  repository = "https://helm.elastic.co"
  chart      = "filebeat"
  values     = ["${file("files/values/filebeat-values.yml")}"]
  namespace  = "logging"
  version = "7.14.0"
  reuse_values = "true"
  atomic = "true"
}