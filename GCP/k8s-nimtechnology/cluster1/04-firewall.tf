resource "google_compute_firewall" "ssh-rule" {
  name = "ssh"
  network  = "${var.network}-${var.env_name}"
  project  = "${var.project_id}"
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}