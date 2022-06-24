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

variable subnetwork_other {
  type        = string
  default     = "cluster2"
  description = "subnetwork name of cluster 2"
}

variable "ip_range_pods_name_other" {
  description = "The secondary ip range to use for pods of cluster2"
  default     = "ip-range-pods-cluster2"
}
variable "ip_range_services_name_other" {
  description = "The secondary ip range to use for services of cluster2"
  default     = "ip-range-services-cluster2"
}


variable "node_locations" {
  default = [
    "asia-southeast1-a",
    "asia-southeast1-b",
    "asia-southeast1-c",
  ]
}