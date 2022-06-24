// this is the address the nat will use externally
resource "google_compute_address" "nat_address" {
  name = "${var.network}-nat-address"
  region = var.region
}

// this is needed to allow a private gke cluster access to the internet (e.g. pull images)
resource "google_compute_router_nat" "nat" {
  name                               = "${var.network}-router-nat"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_address.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  region = var.region
}