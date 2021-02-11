terraform {
  backend "remote" {
    organization = "josedev"
    workspaces {
      name = "vg-teams"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project.id
  region      = var.project.region
  zone        = var.project.zone
}


data "google_client_config" "provider" {}

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.provider.access_token
  }

}
