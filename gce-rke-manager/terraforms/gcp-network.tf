resource "google_compute_network" "team-a-vpc-network" {
  name = "team-a-vpc-network"
  mtu  = 1500
}