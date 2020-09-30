resource "google_container_cluster" "primary" {
  name               = var.cluster
  location           = var.zone
  initial_node_count = 1
  logging_service = "none"
  monitoring_service = "none"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    disk_size_gb = 32 
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      app = var.app_name
    }

    tags = ["app", var.app_name]
    
    shielded_instance_config {
      enable_integrity_monitoring = false
      enable_secure_boot = false
    }
    
  }

  timeouts {
    create = "30m"
    update = "40m"
  }

}