variable "region" {
  default = "asia-southeast1"
}

variable "project_id" {
  default = "terraform-gcp-346216"
}

variable network {
  type        = string
  default     = "nimtechnology"
  description = "this is a main VPC"
}

variable env_name {
  type        = string
  default     = "prod"
  description = "This is Production environment"
}

variable subnetwork {
  type        = string
  default     = "cluster1"
  description = "subnetwork name of cluster 1"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods of cluster1"
  default     = "ip-range-pods-cluster1"
}
variable "ip_range_services_name" {
  description = "The secondary ip range to use for services of cluster1"
  default     = "ip-range-services-cluster1"
}


variable "node_locations" {
  default = [
    "asia-southeast1-a",
    "asia-southeast1-b",
    "asia-southeast1-c",
  ]
}

variable "master_cidr" {
  default = "10.40.0.0/28"
}

variable "compute_engine_service_account" {
  default = "terraform-gcp@terraform-gcp-346216.iam.gserviceaccount.com"
}

variable ssh_user {
  type        = string
  default     = "root"
}

variable "key_pairs" {
  type = map
  default = {
    root_public_key  = "keys/id_rsa.pub",
    root_private_key = "keys/root_id_ed25519"
  }
}

