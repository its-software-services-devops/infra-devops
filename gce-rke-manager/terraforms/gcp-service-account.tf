resource "google_service_account" "gcp-rke-demo-sa" {
  account_id   = "gcp-rke-demo-sa"
  description = "Service account for gcp-rke-demo"
  display_name = "gcp-rke-demo SA"
}

resource "google_service_account_iam_binding" "gce-for-gcp-rke-demo" {
  service_account_id = google_service_account.gcp-rke-demo-sa.name
  role               = "roles/owner"

  members = [
  ]
}