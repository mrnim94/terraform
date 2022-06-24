resource "google_compute_project_metadata" "metadata_nimtechnology_prod" {
  project = data.google_project.project_nimtechnology_prod.project_id

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.key_pairs["root_public_key"])}"
  }
}