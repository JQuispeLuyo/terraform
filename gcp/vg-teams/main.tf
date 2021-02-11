resource "google_container_cluster" "primary" {
  name               = var.cluster.name
  location           = var.cluster.location
  initial_node_count = var.node.count


  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    disk_size_gb = var.node.disk_size_gb 
    machine_type = var.node.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      app = var.app_name
    }

    tags = ["app", var.app_name]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}
