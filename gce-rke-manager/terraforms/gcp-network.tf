
resource "google_compute_network" "team-b-vpc-network" {
  name = "team-b-vpc-network"
  delete_default_routes_on_create = true
}
