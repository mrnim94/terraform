module "sa-prod-cluster1-spinnaker-gcs" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "2.0.0"
  project_id = var.project_id
  names      = ["spinnaker-gcs"]

  generate_keys = "true"

  project_roles = [
    "${var.project_id}=>roles/storage.admin",
  ]
}