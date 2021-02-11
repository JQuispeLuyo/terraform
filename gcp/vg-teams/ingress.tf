resource "helm_release" "ingress_nginx" {

  name = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  namespace = "ingress" 
  create_namespace = true
  
  depends_on = [google_container_cluster.primary]

}