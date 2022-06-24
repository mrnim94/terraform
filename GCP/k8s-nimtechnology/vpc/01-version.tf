terraform {
  backend "gcs" {
    bucket = "nimtechnology-infra-tf-state"
    prefix = "gcp/vpc-k8s"
  }
}