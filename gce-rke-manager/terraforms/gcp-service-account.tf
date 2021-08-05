resource "google_service_account" "gcp-rke-demo-sa" {
  account_id   = "gcp-rke-demo-sa"
  description = "Service account for gcp-rke-demo"
  display_name = "gcp-rke-demo SA"
}

resource "google_service_account_iam_member" "gce-for-gcp-rke-demo-iam" {
  service_account_id = google_service_account.gcp-rke-demo-sa.name
  role               = "roles/owner"
  member             = "serviceAccount:${google_service_account.gcp-rke-demo-sa.email}"
}
