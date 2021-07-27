resource "google_dns_managed_zone" "gcp-rke-demo" {
  name     = "gcp-rke-demo"
  dns_name = "gcp-rke-demo.its-software-services.com."

  dnssec_config {
      state = "on"
  }
}

resource "google_dns_record_set" "gcp-rke-demo-ns" {
  name = "gcp-rke-demo.its-software-services.com."
  type = "NS"
  ttl  = 300

  managed_zone = "root"

  rrdatas = google_dns_managed_zone.gcp-rke-demo.name_servers
}