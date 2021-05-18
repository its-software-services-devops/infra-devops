resource "google_compute_firewall" "k8s-manager-to-cluster" {
  name    = "k8s-manager-to-cluster"
  network = "default"
  priority = 1000

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

resource "google_compute_firewall" "k8s-nodes-internode-connect" {
  name    = "k8s-nodes-internode-connect"
  network = "default"
  priority = 1001

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["443", "6443", "10250", "10255", "2379", "2380"]
  }

  source_tags = ["k8s-master", "k8s-worker"]
  target_tags = ["k8s-worker", "k8s-master"]
}

resource "google_compute_firewall" "k8s-nodes-deny-public" {
  name    = "k8s-nodes-deny-public"
  network = "default"
  priority = 1003

  deny {
    protocol = "icmp"
  }

  deny {
    protocol = "tcp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["k8s-master", "k8s-worker"]
}