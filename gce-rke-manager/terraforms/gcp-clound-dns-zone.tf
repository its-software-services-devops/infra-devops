resource "google_dns_managed_zone" "gcp-rke-demo" {
  name     = "gcp-rke-demo"
  dns_name = "gcp-rke-demo.its-software-services.com."
}
