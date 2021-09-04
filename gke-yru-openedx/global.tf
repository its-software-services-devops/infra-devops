terraform {
  backend "gcs" {
    bucket  = "its-terraform-states"
    prefix = "its-gke-yru-openedx"
  }
  
  required_providers {
    google = "3.79.0"
  }
}

provider "google" {
  project     = "its-artifact-commons"
  region      = "asia-southeast1"
}
