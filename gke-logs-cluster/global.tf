terraform {
  backend "gcs" {
    bucket  = "its-terraform-states"
    prefix = "its-gke-log-cluster"
  }
  
  required_providers {
    google = "3.79.0"
  }
}

provider "google" {
  project     = "its-artifact-commons"
  region      = "asia-southeast1"
}
