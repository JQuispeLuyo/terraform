variable "project" {
  type = map
  default = {
    id = "vg-teams"
    region = "us-east1"
    zone = "us-east1-d"
  }
}

variable "cluster" {
  type = map
  default = {
    name = "vg-teams"
    location = "us-east1-d"
  }
}

variable "node" {
  type = map
  default = {
    count = 1
    disk_size_gb = 12
    # https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture#memory_cpu
    # g1-small      => 1vCPU (0.94) shared     1.70 GB ram
    # n1-standard-1 => 1vCPU (0.94) standard   3.75 GB ram
    # e2-small      => 2vCPU (0.94) shared     2.00 GB ram
    # e2-medium     => 2vCPU (0.94) shared     4.00 GB ram
    # e2-standard-2 => 2vCPU (1.93) standard   8.00 GB ram
    # e2-standard-4 => 4vCPU (3.92) standard   16.0 GB ram
    machine_type = "e2-standard-2"
  }
}

variable "credentials" {
  default = "vg-teams-key.json"
}

variable "app_name" {
  default = "vg-teams"
}
