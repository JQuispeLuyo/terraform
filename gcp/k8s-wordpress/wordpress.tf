resource "helm_release" "wordpress" {
  
  name = "wordpress"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "wordpress"
  namespace = "wordpress"
  create_namespace = true

  set {
    name  = "wordpressUsername"
    value = "admin"
  }

  set {
    name  = "wordpressPassword"
    value = "password"
  }

  values = [
    "${file("values.yaml")}"
  ]

  depends_on = [helm_release.prometheus]

}