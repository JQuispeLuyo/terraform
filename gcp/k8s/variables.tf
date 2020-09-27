variable "project" {
  default = "ci-cd-demo-275102"
}

variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-d"
}

variable "cluster" {
  default = "k8s"
}

variable "credentials" {
  default = "k8s.json"
}

variable "kubernetes_min_ver" {
  default = "latest"
}

variable "kubernetes_max_ver" {
  default = "latest"
}

variable "machine_type" {
  default = "g1-small"
}

variable "app_name" {
  default = "cicd-101"
}