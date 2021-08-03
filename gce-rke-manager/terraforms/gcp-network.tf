
resource "google_compute_network" "team-a-vpc-network" {
  name = "team-a-vpc-network"
  delete_default_routes_on_create = false
}

resource "google_compute_router" "team-a-vpc-network-south-east1-router" {
  name    = "team-a-vpc-network-south-east1-router"
  region  = "asia-southeast1"
  network = google_compute_network.team-a-vpc-network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "team-a-vpc-network-south-east1-nat" {
  name                               = "team-a-vpc-network-south-east1"
  router                             = google_compute_router.team-a-vpc-network-south-east1-router.name
  region                             = google_compute_router.team-a-vpc-network-south-east1-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}