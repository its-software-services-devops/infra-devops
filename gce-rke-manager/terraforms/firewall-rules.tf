resource "google_compute_firewall" "k8s-nodes-allow-only-manager" {
  name    = "k8s-nodes-allow-only-manager"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "6443"]
  }

  source_tags = ["k8s-manager"]
  target_tags = ["k8s-master", "k8s-worker"]
}

resource "google_compute_firewall" "k8s-nodes-deny-public" {
  name    = "k8s-nodes-deny-public"
  network = "default"
  priority = 1001

  deny {
    protocol = "icmp"
  }

  deny {
    protocol = "tcp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["k8s-master", "k8s-worker"]
}