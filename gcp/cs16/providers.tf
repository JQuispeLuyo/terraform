# terraform apply -var-file="personal.tfvars"
provider "google" {
  credentials = file(var.gcp_credential_path)
  project     = var.project
  region      = var.region
  zone        = var.zone
}
