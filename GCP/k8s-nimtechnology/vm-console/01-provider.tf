provider "google" {
  # Configuration options
  project = "terraform-gcp-346216"
  region = var.region
  zone = var.node_locations[0]
  credentials = "keys.json"
}