resource "google_service_account" "gcp-rke-demo-sa" {
  account_id   = "gcp-rke-demo-sa"
  description = "Service account for gcp-rke-demo"
  display_name = "gcp-rke-demo SA"
}

resource "google_project_iam_member" "node-gcp-rke-demo" {
  project = "its-artifact-commons"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.gcp-rke-demo-sa.email}"
}