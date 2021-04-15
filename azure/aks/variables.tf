variable "project" {
  type = map
  default = {
    name = "basic-example"
    location = "Brazil South"
  }
}

variable "node" {
  type = map
  default = {
    count = 1
    disk_size_gb = 30
    machine_type = "Standard_B2s"
  }
}