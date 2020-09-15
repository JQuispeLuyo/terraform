variable "gcp_credential_path" {
  default = "cs16-adm.json"
}

variable "project" {
  default = "cs16-289323"
}

variable "name_vm" {
  default = "cs16-vm"
}

variable "machine_type" {
  default = "e2-standard-2"
}

variable "region" {
  default = "southamerica-east1"
}

variable "zone" {
  default = "southamerica-east1-b"
}

variable "ssh_user" {
  default = "cs16"
}

variable "ssh_pub_key_file" {
  default = "./key/public"
}