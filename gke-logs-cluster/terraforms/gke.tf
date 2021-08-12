resource "google_service_account" "etda-logs-monitoring-sa" {
  account_id   = "etda-logs-monitoring-sa"
  display_name = "Service Account for ETDA"
}

resource "google_container_cluster" "etda-logs-monitoring" {
  name     = "etda-logs-monitoring"
  location = "asia-southeast1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  network = "team-a-vpc-network"

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "192.168.1.1/28"
  }
}

resource "google_container_node_pool" "etda-logs-basic-pool" {
  name       = "etda-logs-basic-pool"
  location   = "asia-southeast1"
  cluster    = google_container_cluster.etda-logs-monitoring.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.etda-logs-monitoring-sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}