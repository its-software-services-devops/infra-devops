resource "google_service_account" "gcp-rke-demo-sa" {
  account_id   = "gcp-rke-demo-sa"
  description = "Service account for gcp-rke-demo"
  display_name = "gcp-rke-demo SA"
}

resource "google_project_iam_binding" "node-gcp-rke-demo" {
  project = "its-artifact-commons"
  role    = "roles/owner"

  members = [
    "serviceAccount:${google_service_account.gcp-rke-demo-sa.email}",
  ]
}
