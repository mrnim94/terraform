module "gcs_spinnaker_gcs" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "3.0.0"
  location   = var.region
  project_id = var.project_id

  prefix        = ""
  names         = [join("-", tolist([var.project_id, "spinnaker-config"]))]
  storage_class = "REGIONAL"

  set_admin_roles = true
  bucket_admins = {
    join("-", tolist([var.project_id, "spinnaker-config"])) = "serviceAccount:${module.sa-prod-cluster1-spinnaker-gcs.email}"
  }

  set_viewer_roles = true
  bucket_viewers = {
    join("-", tolist([var.project_id, "spinnaker-config"])) = "group:gcp.platform@tiki.vn"
  }

  bucket_policy_only = {
    tiki-es-snapshot = true
  }

}