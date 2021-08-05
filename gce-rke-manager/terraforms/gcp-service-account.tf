resource "google_service_account" "gcp-rke-demo-sa" {
  account_id   = "gcp-rke-demo-sa"
  description = "Service account for gcp-rke-demo"
  display_name = "gcp-rke-demo SA"
}

resource "google_project_iam_policy" "project" {
  policy_data = data.google_iam_policy.node-gcp-rke-demo.policy_data
}

data "google_iam_policy" "node-gcp-rke-demo" {
  binding {
    role = "roles/owner"

    members = [
      "serviceAccount:${google_service_account.gcp-rke-demo-sa.email}",
    ]
  }
}