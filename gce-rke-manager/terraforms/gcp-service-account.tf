resource "google_service_account" "gcp-rke-demo-sa" {
  account_id   = "gcp-rke-demo-sa"
  description = "Service account for gcp-rke-demo"
  display_name = "gcp-rke-demo SA"
}
