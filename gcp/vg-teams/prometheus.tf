resource "helm_release" "prometheus" {

  name = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "kube-prometheus-stack"
  namespace = "monitoring" 
  create_namespace = true

  set {
    name  = "grafana.service.type"
    value = "NodePort"
  }

  set {
    name  = "grafana.service.port"
    value = "80"
  }

  set {
    name  = "grafana.service.targetPort"
    value = "3000"
  }

  set {
    name  = "grafana.service.nodePort"
    value = "30000"
  }

  depends_on = [helm_release.ingress_nginx]
  
}