data "google_client_config" "provider" {}

data "google_container_cluster" "primary" {
  name = var.cluster
  location = var.region
}

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.provider.access_token
    load_config_file       = false
  }
}


resource "helm_release" "strimzi" {

  name = "strimzi-kafka"
  repository = "https://strimzi.io/charts/"
  chart = "strimzi-kafka-operator"
  namespace = "kafka" 
  create_namespace = true

}