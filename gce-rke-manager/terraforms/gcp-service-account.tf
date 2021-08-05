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

resource "google_service_account" "its-rke-demo-cloud-dns" {
  account_id   = "its-rke-demo-cloud-dns"
  description = "Service account for its-rke-demo-cloud-dns"
  display_name = "its-rke-demo-cloud-dns SA"
}

resource "google_project_iam_member" "its-rke-demo-cloud-dns-iam" {
  project = "its-artifact-commons"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.its-rke-demo-cloud-dns.email}"
}
