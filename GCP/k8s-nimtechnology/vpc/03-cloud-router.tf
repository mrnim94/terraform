// this is needed to allow a private gke cluster access to the internet (e.g. pull images)
resource "google_compute_router" "router" {
  name    = "${var.network}-cloud-router"
  network = module.gcp-network.network_self_link
  region = var.region
}