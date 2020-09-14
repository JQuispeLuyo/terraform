# terraform apply -var-file="personal.tfvars"

provider "google" {
  credentials = file(var.gcp_credential_path)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "default" {
  name         = var.name_vm
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-77-lts"
      type  = "pd-ssd"
      size  = 10
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }

  metadata_startup_script = "echo '${file("server.cfg")}' > /home/server.cfg; docker run -d -p 26900:26900/udp -p 27020:27020/udp -p 27015:27015/udp -p 27015:27015 -e START_MAP=de_aztec -e ADMIN_STEAM=0:1:1234566 -v /home/server.cfg:/opt/hlds/cstrike/server.cfg --name cs cs16ds/server:latest"
}

resource "google_compute_firewall" "default" {
  name    = "cs16"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27015", "26900"]
  }

  allow {
    protocol = "udp"
    ports    = ["27015", "26900"]
  }
}