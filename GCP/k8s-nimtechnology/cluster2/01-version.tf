terraform {
  backend "gcs" {
    bucket = "nimtechnology-infra-tf-state"
    prefix = "gcp/cluster2"
  }
}